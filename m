Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC650700497
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbjELKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjELKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:00:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFA13849
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:59:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab0c697c2bso90097735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1683885577; x=1686477577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J2ZJnDmboCKN65asMulJKTQ7oAGkyMypOi8N9qUDaM=;
        b=iV15/4Gc4dM5nXgibYo8jehJqP7rFQJLD4K+sKQke8vu5fqJMEVRnY1bsWBtX8OqEx
         XjaC9mmxWFOPg76FeqUyxgZgK7lVA0cFiYgIGm57F3mn9rCGa69fdjrcdEJJKbiZJcJ1
         PcA2cvzX/4eCHiZikCkVy3vfGSRto7clNkVrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683885577; x=1686477577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J2ZJnDmboCKN65asMulJKTQ7oAGkyMypOi8N9qUDaM=;
        b=ODnO6VH6qNX1j+Zd0TdpI9lHxhKEDyGSryPa4/3uQr7gS44wtEqUFoER0fwtvBjuzx
         V+joWTT3Ge0jDrULccdYAsznaOvRlf9375XlfGlTNCIKPNeSOA7txRwUKbvId7kmLHMM
         B4Bv6gpa0FXk5CovTVb3+x+TvmzvESOPf2jZAUDk23tEqLyXGR7i3qf+AVjCFROMb949
         YHpZD0f1xYg4NblAN7tcHnQkiv5hOipKleqfSl5+XqpZjA23jXezLDEaw1z3ARBQdKAU
         Y7F5sT2v/kqcTpQWyyJqz6qGmt0JfhFMz8m0nmvI/ObISGWyeUAyL6hLo87k7B4Al/As
         t25Q==
X-Gm-Message-State: AC+VfDwz5Ql1qsd9h5BxI6s0xpipext76fCItn99eFaZvQCy1KwTpwdz
        pxj8wK4LPmue5mBhClc+2sQaAHbSkSGib+x0/dgjODZW+plvyfsNWdF2aECYgqk=
X-Google-Smtp-Source: ACHHUZ4/ym6NDbByzCpXM236x7lUbxxOc0SnMwWRJXQor6i+H/EpLBaD/hjINvnPin0xJu7QH92ra92GuqfmxTkj7mI=
X-Received: by 2002:a17:902:ce91:b0:1ad:c1c2:7d1a with SMTP id
 f17-20020a170902ce9100b001adc1c27d1amr7752806plg.63.1683885577124; Fri, 12
 May 2023 02:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030705.399628514@linuxfoundation.org> <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c> <2023050913-spearhead-angrily-fc58@gregkh>
 <20230509145806.GA8@df3c0d7ae0b0> <2023051025-plug-willow-e278@gregkh>
 <CAG9oJsnr55Atybm4nOQAFjXQ_TeqVG+Nz_8zqMT3ansdnEpGBQ@mail.gmail.com>
 <2023051048-plus-mountable-6280@gregkh> <CAG9oJskrJotpyqwi6AHVMmhnFmL+Ym=xAFmL51RiZFaU78wv-A@mail.gmail.com>
 <2023051132-dweller-upturned-b446@gregkh> <CAG9oJskf0fE7LiumdzD4QW8dTmGpmVyXBSyiKu_xP+s72Rw44A@mail.gmail.com>
 <CAHk-=wjJNHjwfrT0X5DvSP3fZzUF0SAbErkc30qAWDW=U9uKtQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjJNHjwfrT0X5DvSP3fZzUF0SAbErkc30qAWDW=U9uKtQ@mail.gmail.com>
From:   Rudi Heitbaum <rudi@heitbaum.com>
Date:   Fri, 12 May 2023 19:59:25 +1000
Message-ID: <CAG9oJsm7GA3A9MHcMiMqxzz5a9sV+S6BCzuYRbAVawweswSOAA@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, ntfs3@lists.linux.dev,
        almaz.alexandrovich@paragon-software.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 at 00:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 11, 2023 at 3:30=E2=80=AFAM Rudi Heitbaum <rudi@heitbaum.com>=
 wrote:
> >
> > I have run 6.1.28-rc2 today, and was able to trigger the error. So
> > definitely bad in both 6.3 and 6.1.
> >
> > [13812.020209] BUG: kernel NULL pointer dereference, address: 000000000=
0000020
> > [13812.021322] #PF: supervisor read access in kernel mode
> > [13812.022346] #PF: error_code(0x0000) - not-present page
> > [13812.023591] PGD 0 P4D 0
> > [13812.024876] Oops: 0000 [#1] SMP NOPTI
> > [13812.026088] CPU: 5 PID: 20386 Comm: .NET ThreadPool Not tainted 6.1.=
28-rc2 #1
> > [13812.027336] Hardware name: Intel(R) Client Systems
> > NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
> > [13812.028593] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
>
> I suspect this is fixed in mainline by commit 6827d50b2c43 ("fs/ntfs3:
> Refactoring of various minor issues") which changed the IS_ERR() check
> into a IS_ERR_OR_NULL().

Hi Linus,

Thanks for the direction to the commit. I can confirm that once adding
commit 6827d50b2c43 to both 6.1.28-rc2 and 6.3.2-rc2 and testing for
today - that the error is not reproducible with the below lines.

- if (!IS_ERR(inode) && inode->i_op =3D=3D NULL) {
+ if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {

Rudi

> But dropping the original fix from stable might be the right thing to do.
>
>                  Linus
