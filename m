Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5663CB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiK2W25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiK2W2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:28:54 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91136F803
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:53 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q21so11144808iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZIKiJcgUuWp0oqTM0Nvj4Rb47SDYoygumg7jcsAqcQ=;
        b=coFxrujpB1pnAva9udLJRWxLMnV7LD329v1GYpOQf6WxwrWjmjgSNLmyoiYmR6Qhhb
         4OUUTZ6Gs7SE0MlCj3wq7mKQ2iDBwlaGhpZJUWnU9eRwLafGSYJC20xjIs3v6EIUBFIp
         r4biSJIH10a5XjI/h1t4tMeRHjHvykveeSvGlEFEbp0IkA4y+SKqrvS5pn/llgWxSCyE
         391kLoDtRRN1lsColupdODBWbA/njBoXZZXbHz6rrtENkpwaGFJkhQbBgKZYDB5YiARY
         pt3Ij1X+xRdfZiasdeMbKuct//6bKvhTirNM5z44T/3wegwpkHpezNpW0EpfvXUToUpL
         +EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZIKiJcgUuWp0oqTM0Nvj4Rb47SDYoygumg7jcsAqcQ=;
        b=lGfmsdzq5bvPzWAKSI6xcOWxsxj16ol34C8ZLQXxtoAYo6fmXue+yEXqHmGx7UPrNK
         leNTmAhPH60FBLZLkdJOMH1ap51napoLBVH57Oena1E+ls1G7xQhSOIHwlyLkf8n/3Ra
         szFxgxRAKloH71r+17zYCI/7zJ1LQi3w87zxZuCciOQeCwVb1LOxZ6WTM3UufwW5XtRP
         PVpOl1qvM4CCVdORQT4Mx0igPwbSf6MVj7IeYQUM45R8sCgk+xYEjPC4r+Zjt8S+NfaU
         mf7tDtX32YoKU82SXl0v2P20kfcPO6JsX3r5cATtT0dVyj6WmHhr4Yyf2vFhcvAvksZU
         mL2A==
X-Gm-Message-State: ANoB5pmBcZA+tDTfRGH3IT439+RGPXF6MW2dhWfelTGRdg+Akmfo1aPu
        Q+DMIJtx5dfmLf8XIiI69QHOHhaLbjeCN2aiWlGuxQ==
X-Google-Smtp-Source: AA0mqf5LpEubGhhYy56Bdt/Mw00cbqwy1nLVt4MnsK+WZhpYS/w+giE2cuOBflGLkWtMAD18VC535AFhfuQ0i3Tn+dI=
X-Received: by 2002:a05:6638:3470:b0:389:c976:846e with SMTP id
 q48-20020a056638347000b00389c976846emr9608102jav.246.1669760932985; Tue, 29
 Nov 2022 14:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20221129191839.2471308-1-jannh@google.com> <20221129191839.2471308-2-jannh@google.com>
 <87fse1v4rf.ffs@tglx>
In-Reply-To: <87fse1v4rf.ffs@tglx>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Nov 2022 23:28:16 +0100
Message-ID: <CAG48ez3UBb3Aq7+AFSmRj5a9czmew5b0PEdhWQ9qvQdeejnJZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] time/namespace: Forbid timens page faults under kthread_use_mm()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, Nov 29 2022 at 20:18, Jann Horn wrote:
>
> > find_timens_vvar_page() doesn't work when current's timens does not match
> > the timens associated with current->mm.
> > v6 of the series adding this code [1] had some complicated code to deal
> > with this case, but v7 [2] removed that.
> >
> > Since the vvar region is designed to only be accessed by vDSO code, and
> > vDSO code can't run in kthread context, it should be fine to error out in
> > this case.
>
> Should? Either it is correct or not.
>
> But the way more interesting question is:
>
> >  struct page *find_timens_vvar_page(struct vm_area_struct *vma)
> >  {
> > +     /*
> > +      * We can't handle faults where current's timens does not match the
> > +      * timens associated with the mm_struct. This can happen if a page fault
> > +      * occurs in a kthread that is using kthread_use_mm().
> > +      */
>
> How does a kthread, which obvioulsy did kthread_use_mm(), end up trying to
> fault in the time namespace vvar page?

By doing copy_from_user()? That's what kthread_use_mm() is for, right?
If you look through the users of kthread_use_mm(), most of them use it
to be able to use the normal usercopy functions. See the users in usb
gadget code, and the VFIO code, and the AMD GPU code. And if you're
doing usercopy on userspace addresses, then you can basically always
hit a vvar page - even if you had somehow checked beforehand what the
address points to, userspace could have moved a vvar region in that
spot in the meantime.

That said, I haven't actually tried it. But I don't think there's
anything in the page fault handling path that distinguishes between
copy_from_user() faults in kthread context and other userspace faults
in a relevant way?

> It's probably something nasty, but the changelog has a big information
> void.
>
> It neither answers the obvious question why this is a problem of the
> time namespace vvar page and not a general issue versus a kthread, which
> borrowed a user mm, ending up in vdso_fault() in the first place?

Is it a problem if a kthread ends up in the other parts of
vdso_fault() or vvar_fault()? From what I can tell, nothing in there
except for the timens stuff is going to care whether it's hit from a
userspace fault or from a kthread.

Though, looking at it again now, I guess the `sym_offset ==
image->sym_vvar_page` path is also going to misbehave, so I guess we
could try to instead make the vdso/vvar fault handlers bail out in
kthread context for all the architectures, since we're only going to
hit that if userspace is deliberately doing something bad...

> None of those VDSO (user space) addresses are subject to be faulted in
> by anything else than the associated user space task(s).

Are you saying that it's not possible or that it doesn't happen when
userspace is well-behaved?
