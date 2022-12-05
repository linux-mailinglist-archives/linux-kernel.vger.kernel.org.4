Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFFC643532
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiLEUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiLEUCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:02:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF62C228;
        Mon,  5 Dec 2022 12:02:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C11B2B81212;
        Mon,  5 Dec 2022 20:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2F3C433D7;
        Mon,  5 Dec 2022 20:02:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MRX1z0ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670270558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyZtCU+2gsCu7KCwhkt8a9c6R0xPU3y4F0anDuzkzwY=;
        b=MRX1z0chvZFKzyr0XVk/4fJ7RUniJro8ZYda1qQWry7EVFIy3BnXhJQcimO33iXiG7hF+P
        Bo7DVHXbyvqu/FJdu78o5chMiY0aGo2PqBVrp79vtzaFbLw52sC16UNro89nCkvoVig/hh
        TNWk5yOc4J2ke52xCFS4TH3Ad6f6z20=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aceab3d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 20:02:37 +0000 (UTC)
Date:   Mon, 5 Dec 2022 21:02:34 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v11 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y45OWhyN+U975vIN@zx2c4.com>
References: <20221205020046.1876356-1-Jason@zx2c4.com>
 <20221205020046.1876356-2-Jason@zx2c4.com>
 <CAG48ez2R=Ov2Z9zn_W9+C3gHqOkPdQKAY=4SMWDUG=NfP=3eJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2R=Ov2Z9zn_W9+C3gHqOkPdQKAY=4SMWDUG=NfP=3eJw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Mon, Dec 05, 2022 at 08:13:36PM +0100, Jann Horn wrote:
> On Mon, Dec 5, 2022 at 3:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > +       mm->def_flags |=
> > +               /*
> > +                * Don't allow state to be written to swap, to preserve forward secrecy.
> > +                * This works in conjunction with MAP_LOCKED in do_mmap(), below, which
> > +                * actually does the locking (and associated permission check and accounting).
> > +                * Here, VM_LOCKONFAULT together with VM_NORESERVE simply make the mlocking
> > +                * happen the first time it's actually used, the same as when calling
> > +                * mlock2(MLOCK_ONFAULT) from userspace.
> > +                */
> > +               VM_LOCKONFAULT | VM_NORESERVE |
> 
> Have you checked the interaction with this line in dup_mmap()?
> "tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);"
> 
> As the mlock.2 manpage says, "Memory locks are not inherited by a
> child created via fork(2)". I think the intention here is that the VMA
> should stay unswappable after fork(), right?
> 
> Of course, trying to reserve more mlocked memory in fork() would also
> be problematic...

Thanks for pointing that out! Indeed that seems problematic.
Fortunately, the use of WIPEONFORK at the same time as LOCKONFAULT means
that memory doesn't actually need to be reserved in fork() itself. So
something like the below seems correct and doable.

Jason

diff --git a/kernel/fork.c b/kernel/fork.c
index ec57cae58ff1..cd53ffff615d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -656,7 +656,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->anon_vma = NULL;
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
-		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
+		if ((tmp->vm_flags & (VM_LOCKONFAULT | VM_WIPEONFORK)) !=
+		    (VM_LOCKONFAULT | VM_WIPEONFORK))
+			tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;

