Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B4C73D5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFZCfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFZCfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:35:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D5193
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:35:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e2fdd186so2066814f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687746913; x=1690338913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqmKGWm+jTRona2CHbfUBt+oTaSkdVF8E4LHvdIFA7g=;
        b=Ev4VR3zX+egrC1GzP9vmnumQaLWsYIafaGn+QD/sP/4VF6EghP+tjQfgzC5y4yoDu1
         a1gHI7iCwh4bPx7dizJwA06GOvJd3aR5dmvglJkssGJ6e4okEY7JvDvms8inTTMu3oC9
         r1Vdj7bESbqlJ0zEQ05OvYP/QD+52cZofITWGipeWInLyhCzB2l/ikiRk2Q9eWyNWE/F
         QyKDUqiXU0wy5HUnG8O1Y92DYbF0uqjYO+i4O3VtdjfeuDgHj6pGSBMbHtJprbIMtwJ2
         mao2ZV9q9w5UmnrJMvns85fztj9Z5ihPbBbzV8YBnpxH5lcwJ2BlgQ15pOxEXwGahrrN
         3bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687746913; x=1690338913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqmKGWm+jTRona2CHbfUBt+oTaSkdVF8E4LHvdIFA7g=;
        b=HO/TaubDp4v+edV5hSdKAnxBcgye0c0GOyK70EXlGeDT3EapsIk5A4Wj5Ik8euuD/e
         ZMsYCWTF00QhqPQ7nutHfVPbguRmvw2plhvo5BJAF7DI5dCzg3tDuc5iKpL8Utg/O7WV
         8e3ut3Bkj1kNCyJTXExzvACdbOi0vRUD1hlbz/lhzspjjh2dR59HhFt+c04zObzsVtwS
         xzKYwDnEb3UZ6OuTkYg3imTeFHWkgg3Pxut1GvGNNMnB0gsFHmlsskSyVxDAoyvrj5/7
         fUnyhRcCZh3bLRabfrgvV++p8IWUmSxNMGlN/ctUdbUJdFkXNW2YhDEzuLUsoHNzoyxI
         AQQA==
X-Gm-Message-State: AC+VfDw+XmrHmAiCYQSZnkHvmVBsBl7ihAqEFY38R23o2wt2rgUeyX97
        9GDEibSei8Nsnshjf99MhpJziAKaZos5oEFLIrUKDQ==
X-Google-Smtp-Source: ACHHUZ75oUBx/qyzgdcMESa3eAenLGXtO9pbbn8W41qAOI9hW2478LCqwt9LDjG3xy05uSwjX14YwU3sj8eN5k3s0q4=
X-Received: by 2002:a5d:6a91:0:b0:311:1128:9634 with SMTP id
 s17-20020a5d6a91000000b0031111289634mr23631699wru.54.1687746912806; Sun, 25
 Jun 2023 19:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com> <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
In-Reply-To: <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 26 Jun 2023 10:35:01 +0800
Message-ID: <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     ron minnich <rminnich@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ron, Ard,

On Sun, Jun 25, 2023 at 11:57=E2=80=AFPM ron minnich <rminnich@gmail.com> w=
rote:
>
> Hey Ard, thanks for the discussion, sounds like we are able to move forwa=
rd now!

>
> On Sun, Jun 25, 2023, 6:13 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> If this is only used on RISC-V, and implemented under arch/riscv, I
>> have no objections.

Thank you for your suggestions that made us reach an agreement, let's
continue to review this patch.

The current logic is to implement the common interface under
drivers/firmware/, if we need this function, we can call
fdt_fwtbl_init() to complete it in arch/xxx/kernel/setup.c.

For enabling on RISC-V, we can complete it in a subsequent patch to
setup_arch-->fdt_fwtbl_init() in arch/riscv/kernel/setup.c.

What do you think?

Thanks,
Yunhui
