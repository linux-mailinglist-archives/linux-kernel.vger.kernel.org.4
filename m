Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68D640BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiLBRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiLBRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55264EC82F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670001447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IxPEAqF9SN/Ec6+MrDMnr/2mkqvaWqnJM9SdEQtL8I=;
        b=FSRh92eeCVqyh0PATew0doLqpWgklIn1PQiCxy4USj4g0jjVAUAvJm9qtYyrcLBGOvHtK6
        J5GZuAD8vgI9tHzIYmCm+nRJwCmbYnIu5vhG4vOSLPUL8ME/oxrQAegcIpiVyhoTTYYNEL
        11SnrsSk+wX64+hnf9Ms/9xfFATDDU4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-izNlqvCZOEqgJaFW-E2R4g-1; Fri, 02 Dec 2022 12:17:24 -0500
X-MC-Unique: izNlqvCZOEqgJaFW-E2R4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 314193817971;
        Fri,  2 Dec 2022 17:17:23 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1481D145454E;
        Fri,  2 Dec 2022 17:17:20 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
References: <20221129210639.42233-1-Jason@zx2c4.com>
        <20221129210639.42233-2-Jason@zx2c4.com>
        <877czc7m0g.fsf@oldenburg.str.redhat.com> <Y4d5SyU3akA9ZBaJ@zx2c4.com>
Date:   Fri, 02 Dec 2022 18:17:17 +0100
In-Reply-To: <Y4d5SyU3akA9ZBaJ@zx2c4.com> (Jason A. Donenfeld's message of
        "Wed, 30 Nov 2022 16:39:55 +0100")
Message-ID: <87v8mtpvxe.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> I don't think zapping that memory is supported, or even a sensible thing
> to do. In the first place, I don't think we should suggest that the user
> can dereference that pointer, at all. In that sense, maybe it's best to
> call it a "handle" or something similar (a "HANDLE"! a "HWND"? a "HRNG"?

Surely the caller has to carve up the allocation, so the returned
pointer is not opaque at all.  From Adhemerval's glibc patch:

      grnd_allocator.cap = new_cap;
      grnd_allocator.states = new_states;

      for (size_t i = 0; i < num; ++i)
	{
	  grnd_allocator.states[i] = new_block;
	  new_block += size_per_each;
	}
      grnd_allocator.len = num;
    }

That's the opposite of a handle, really.

>> But it will constrain future
>> evolution of the implementation because you can't add registration
>> (retaining a reference to the passed-in area in getrandom) after the
>> fact.  But I'm not sure if this is possible with the current interface,
>> either.  Userspace has to make some assumptions about the life-cycle to
>> avoid a memory leak on thread exit.
>
> It sounds like this is sort of a different angle on Rasmus' earlier
> comment about how munmap leaks implementation details. Maybe there's
> something to that after all? Or not? I see two approaches:
>
> 1) Keep munmap as the allocation function. If later on we do fancy
>    registration and in-kernel state tracking, or add fancy protection
>    flags, or whatever else, munmap should be able to identify these
>    pages and carry out whatever special treatment is necessary.

munmap is fine, but the interface needs to say how to use it, and what
length to pass.

>> > +	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
>> > +	alloc_size = PAGE_ALIGN(num_states * state_size);
>> 
>> Doesn't this waste space for one state if state_size happens to be a
>> power of 2?  Why do this SIZE_MAX & PAGE_MASK thing at all?  Shouldn't
>> it be PAGE_SIZE / state_size?
>
> The first line is a clamp. That fixes num_hint between 1 and the largest
> number that when multiplied and rounded up won't overflow.
>
> So, if state_size is a power of two, let's say 256, and there's only one
> state, here's what that looks like:
>
>     num_states = clamp(1, 1, (0xffffffff & (~(4096 - 1))) / 256 = 16777200) = 1
>     alloc_size = PAGE_ALIGN(1 * 256) = 4096
>
> So that seems like it's working as intended, right? Or if not, maybe
> it'd help to write out the digits you're concerned about?

I think I was just confused.

>> > +	if (put_user(alloc_size / state_size, num) || put_user(state_size, size_per_each))
>> > +		return -EFAULT;
>> > +
>> > +	pages_addr = vm_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
>> > +			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0);
>> 
>> I think Rasmus has already raised questions about MAP_LOCKED.
>> 
>> I think the kernel cannot rely on it because userspace could call
>> munlock on the allocation.
>
> Then they're caught holding the bag? This doesn't seem much different
> from userspace shooting themselves in general, like writing garbage into
> the allocated states and then trying to use them. If this is something
> you really, really are concerned about, then maybe my cheesy dumb xor
> thing mentioned above would be a low effort mitigation here.

So the MAP_LOCKED is just there to prevent leakage to swap?

Thanks,
Florian

