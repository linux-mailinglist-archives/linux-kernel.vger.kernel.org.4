Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782EE727A86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjFHIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFHIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:54:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D892D47
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:53:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f6c6320d4eso111241cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686214438; x=1688806438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3S8C+P+RZ3F6jzMdu/JeV141/1ahGxg12LTpyZNIHw=;
        b=OXHv1owDPqb0g834/kg0UzU5qhenGwGzZ4KXOZIuJ5a1wRja9eTUaEZeb/loknQfG/
         Jn10n+89cl69FALW+acvv/z3rRetvqzPegeOexMiqIvbduhyZE2fKfSTZQ+Yte8OOwKj
         LkVCTJltjF4edV9Hio2Ln+UipXOlqlhT8DD5WlolKnXh8LaJaZSrwNWG03iIcL9U/r6H
         xRhFf5fHNaCuTBRCn8bUlPXlvvlbWCeKMR8cuJazvfDSUdum8ScIN1/mUQeJIOURmBt2
         F12FNi47v9+NFgO8mb0c0Ufe3bFA7kUacyPPDq0zJmgh56Yqf9xFDnoqsAamO1EY6rkb
         HsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214438; x=1688806438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3S8C+P+RZ3F6jzMdu/JeV141/1ahGxg12LTpyZNIHw=;
        b=MZhXFo5kNB09yaQXpYANan6fNOSHJjKdoqQsWnfU+AFWPRXsGqvDcQp4Roy2F04Aa6
         Yga6FsLJ8ach49S0LDlXRmaLtQOrlTK+GlU5ljIZuAnkTyTawxrGYlBtlYQ1LU20xWVM
         aYIeclQR0PJIw4DOCT2XAiwOZdbh9Rz0jEzRGwv9pUJZrLwauZCYlLhAd8IYvTMPbOaY
         Rp6yy/Q9CHexFx2BMNVIa552saA/jeoBhVvMtM+G+yt2le0kl54Mh1k1VLZfYhh3LZhC
         klkmkokv/DCe/O1+pdjmkjv8jN8wU9O84zIjmTMupiHL2GosmLiZpVmhQ6GnYbcHbM9d
         x4oQ==
X-Gm-Message-State: AC+VfDxYY/9Xcy+1I0HShRdP2gCQHWe2CXC2536G3QrZnfF4uP0TFIP0
        lLDX4nx/p3bLkmiPlfOZS9X6SirFLulNKDN7bfCdZA==
X-Google-Smtp-Source: ACHHUZ45IzPGwJunoTfox5YB1GSDNlPeAsXonirICmxLPz9P3JztasM+Mpti07xFNBCfwaOrMJklH4GSPnbVrZUhFSs=
X-Received: by 2002:a05:622a:250:b0:3ef:3361:75d5 with SMTP id
 c16-20020a05622a025000b003ef336175d5mr166643qtx.11.1686214437738; Thu, 08 Jun
 2023 01:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230525180209.19497-1-james.morse@arm.com> <20230525180209.19497-13-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-13-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 8 Jun 2023 10:53:47 +0200
Message-ID: <CALPaoCj3h=ELzRwUB2FcPAFAMD7G_nq1-r=PUGOuLq38bUMr0g@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, May 25, 2023 at 8:03=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> resctrl_arch_rmid_read() could be called by resctrl in process context,
> and then called by the PMU driver from irq context on the same CPU.

Will there be x86 PMU changes to do this or is this only ARM? I just
want to make sure the x86 resctrl_arch_rmid_read() changes are
actually needed.

Thanks!
-Peter
