Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA2732C29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbjFPJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbjFPJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:40:10 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA32726
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:40:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3409d944009so107625ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686908408; x=1689500408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43PrIaNilwLVOBaGJgg3FhjL+CYuMOw3V/XLZiBQlYE=;
        b=yKrw35JciWVKtv0Yy+RXVoVaEA9wuX/nelST7hHhfAOkFL2FkdHfykVwC7K37WIPsh
         GhS4gCLqMvOyYRHo2Le16NAXgZGrnckfTr9G9YAk1YcYG+HZMHBr3EHuEjVtcrJOZx8S
         8aRccrcvczj3fVY928UAXdnZPn8c5M4qZopfbGBtMvbNTZMd5MHxz8S7zN0nr03Qf3ic
         8Q/AZzMB7wEMIADV6tEJXAX5v6yfJ8oHP9dYudDQ5FUQUDxw3KdGNSr46G6ROPRUndKD
         sn31joB99Ma6r/Rk2uKKpxsJ68yvzXdByPm17oMMvDqLvj9jXS4M0FQ0YspfGi69i5uB
         ebJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686908408; x=1689500408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43PrIaNilwLVOBaGJgg3FhjL+CYuMOw3V/XLZiBQlYE=;
        b=NPeIybMf7P0AHp6NgKMCcqBo/O1MX+8Rk+LDlIeRKiXocyDd/kqZavAqZRfhzBDC7M
         faxfpXmdtc0m5EnXvqe6f+1o1E9y0YViq1k3g+0dpV72ZXl2sRaB1jVg+YJAKtT648NU
         tcnKejkJoAv5TLL7z1yVvS/byCZFkAKSH9v6vzG1fGUOHzYDUGWptI+JS/Lfsmvby8L8
         +TaaXUIlUHj529FvZv/0Kguok82A9+/hcgPQ6cDMdQsPZ9AOcHNKo12N82gjx6KXPZet
         Cc5SfPbEgpLwrQwzU+hepczM30LJBNatQncKMS1zs9IZ7/x7trKFG/EsSh21Hf091dUR
         YyPQ==
X-Gm-Message-State: AC+VfDx8+VEq0KS4UErmkn4ix+zqcvkJs22PPqTtwlOH5VS7WV0ZWxst
        Z0X/Mt/GJKIQ/RHVeIWtm2Ve41fl/V1eFdGissnEfa5wv/Lygs2ybaFOmA==
X-Google-Smtp-Source: ACHHUZ4CLjc42sgoycpHkixS7s+Qk0aypo3zCVJ/AGY8A/3PTK8S+fQ75d1iH45DeHuHotIaZnyTETriUMEXxyuSRHA=
X-Received: by 2002:a05:6e02:1569:b0:338:55b9:f1a3 with SMTP id
 k9-20020a056e02156900b0033855b9f1a3mr454946ilu.7.1686908408312; Fri, 16 Jun
 2023 02:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com> <20230615163125.td3aodpfwth5n4mc@desk>
 <ZIufZn+reW0rza1H@equinox> <20230616031447.yslq6ep7lxe6sjv4@desk>
In-Reply-To: <20230616031447.yslq6ep7lxe6sjv4@desk>
From:   Jordy Zomer <jordyzomer@google.com>
Date:   Fri, 16 Jun 2023 11:39:57 +0200
Message-ID: <CABjM8Zc4WU-QXVDDtfKtGPnsHOhjXYufg+HZ=cdSudXYeKS7YQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation Pawan, a little bit off-topic for this patch but
shall I send a patch to add this to the documentation of array_index_nospec=
()
and fix other calls to that function where the upper bound is not a constan=
t? :)

On Fri, Jun 16, 2023 at 5:15=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Jun 16, 2023 at 12:31:50AM +0100, Phillip Potter wrote:
> > I've now looked at this. It is possible for cdi->capacity to be > 1, as
> > it is set via get_capabilities() -> cdrom_number_of_slots(), if the
> > device is an individual or cartridge changer.
>
> Ohk. Is there an upper limit to cdi->capacity? If not, we are left with
> barrier_nospec().
>
> > Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
> > approach. Jordy's V2 patch is fine therefore, but perhaps using
> > array_index_nospec() with cdi->capacity is still better than a
> > do/while loop from a performance perspective, given it would be cached
> > etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
> > spectre-v1 I'll admit).
>
> array_index_nospec() can only clip the arg correctly if the upper bound
> is correct. Problem with array_index_nospec(arg, cdi->capacity) is
> cdi->capacity is not a constant, so it suffers from the same problem as
> arg i.e. cdi->capacity could also be speculated. Although having to
> control 2 loads makes the attack difficult, but does not rules out
> completely.
>
> barrier_nospec() makes the CPU wait for all previous loads to retire
> before executing following instructions speculatively. This causes the
> conditional branch to resolve correctly. I hope this does not fall into
> a hotpath.
