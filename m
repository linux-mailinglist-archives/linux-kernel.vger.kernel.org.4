Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7236643542
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLEUHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiLEUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:07:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E712DFCE5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670270774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5OTqoTXPXM33Uzjd4PZuIqIzOIq6qcNx83qgoRc9Nk=;
        b=ZVBVdXURJ+WwCDVtSh146TCpU39HePE6qDPFhdCJtqkct8llozDDtE3lsnuOHk+rUqpdhM
        YsDncPC6GxPwoO1lZJnK75pDiiiPvYGl/iuOqOJtMoZ/J30xUW4SBAaK5AkZUq7BPoMLTQ
        58dnUm14tg9fsGAnc4B9MZBENil3MLs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-v7mHkac9NfG-LNeQV8n2hg-1; Mon, 05 Dec 2022 15:06:13 -0500
X-MC-Unique: v7mHkac9NfG-LNeQV8n2hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEAF23810784;
        Mon,  5 Dec 2022 20:06:12 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93A6D112132D;
        Mon,  5 Dec 2022 20:06:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v11 1/4] random: add vgetrandom_alloc() syscall
References: <20221205020046.1876356-1-Jason@zx2c4.com>
        <20221205020046.1876356-2-Jason@zx2c4.com>
        <CAG48ez2R=Ov2Z9zn_W9+C3gHqOkPdQKAY=4SMWDUG=NfP=3eJw@mail.gmail.com>
        <Y45OWhyN+U975vIN@zx2c4.com>
Date:   Mon, 05 Dec 2022 21:06:06 +0100
In-Reply-To: <Y45OWhyN+U975vIN@zx2c4.com> (Jason A. Donenfeld's message of
        "Mon, 5 Dec 2022 21:02:34 +0100")
Message-ID: <87bkohpqdt.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> Hi Jann,
>
> On Mon, Dec 05, 2022 at 08:13:36PM +0100, Jann Horn wrote:
>> On Mon, Dec 5, 2022 at 3:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > +       mm->def_flags |=
>> > +               /*
>> > +                * Don't allow state to be written to swap, to preserve forward secrecy.
>> > +                * This works in conjunction with MAP_LOCKED in do_mmap(), below, which
>> > +                * actually does the locking (and associated permission check and accounting).
>> > +                * Here, VM_LOCKONFAULT together with VM_NORESERVE simply make the mlocking
>> > +                * happen the first time it's actually used, the same as when calling
>> > +                * mlock2(MLOCK_ONFAULT) from userspace.
>> > +                */
>> > +               VM_LOCKONFAULT | VM_NORESERVE |
>> 
>> Have you checked the interaction with this line in dup_mmap()?
>> "tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);"
>> 
>> As the mlock.2 manpage says, "Memory locks are not inherited by a
>> child created via fork(2)". I think the intention here is that the VMA
>> should stay unswappable after fork(), right?
>> 
>> Of course, trying to reserve more mlocked memory in fork() would also
>> be problematic...
>
> Thanks for pointing that out! Indeed that seems problematic.
> Fortunately, the use of WIPEONFORK at the same time as LOCKONFAULT means
> that memory doesn't actually need to be reserved in fork() itself. So
> something like the below seems correct and doable.
>
> Jason
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ec57cae58ff1..cd53ffff615d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -656,7 +656,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  			tmp->anon_vma = NULL;
>  		} else if (anon_vma_fork(tmp, mpnt))
>  			goto fail_nomem_anon_vma_fork;
> -		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
> +		if ((tmp->vm_flags & (VM_LOCKONFAULT | VM_WIPEONFORK)) !=
> +		    (VM_LOCKONFAULT | VM_WIPEONFORK))
> +			tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
>  		file = tmp->vm_file;
>  		if (file) {
>  			struct address_space *mapping = file->f_mapping;

Still it's a bit concerning that calling getrandom (the libc function)
now apparently can kill the process if the system is under severe memory
pressure.  In many cases, that's okay, but we wouldn't want that for
PID 1, for example.  vm.overcommit_memory=2 mode is supposed to prevent
such crashes, and I think NORESERVE (not shown here) sidesteps that.

Thanks,
Florian

