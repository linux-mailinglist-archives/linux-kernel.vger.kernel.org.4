Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C566433D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiLETjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiLETjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F9FC7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670268921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ymx9vYbfvPSu1FyTD+EP2FA1MzxLKdOD5sbRdjsyNg=;
        b=AtHysDVrzVVLYkuS/q4hJqTFb6nLacv9iE90OVr74wGP1qePq4YHckNU3VGXDDOgH92x+Z
        9aSlvbIQBKXk9/93ctjo98mS7QT3mVXMLHmCU7WOd1ROR1/WcAksGbpTxYShgBKqnkeUPV
        KJLC0S/TIqm5zuY+H9iFY4Lyx/moaYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-W0bjpuIXO4eRhW0NUmBusQ-1; Mon, 05 Dec 2022 14:35:16 -0500
X-MC-Unique: W0bjpuIXO4eRhW0NUmBusQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EA69811E67;
        Mon,  5 Dec 2022 19:35:15 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2731B40C846B;
        Mon,  5 Dec 2022 19:35:12 +0000 (UTC)
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
Subject: Re: [PATCH v11 3/4] random: introduce generic vDSO getrandom()
 implementation
References: <20221205020046.1876356-1-Jason@zx2c4.com>
        <20221205020046.1876356-4-Jason@zx2c4.com>
        <878rjlr85s.fsf@oldenburg.str.redhat.com> <Y45Ar3mwRBSr+X7F@zx2c4.com>
Date:   Mon, 05 Dec 2022 20:35:09 +0100
In-Reply-To: <Y45Ar3mwRBSr+X7F@zx2c4.com> (Jason A. Donenfeld's message of
        "Mon, 5 Dec 2022 20:04:15 +0100")
Message-ID: <87wn75prte.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> Hi Florian,
>
> On Mon, Dec 05, 2022 at 07:56:47PM +0100, Florian Weimer wrote:
>> * Jason A. Donenfeld:
>>=20
>> > +retry_generation:
>> > +	/*
>> > +	 * @rng_info->generation must always be read here, as it serializes =
@state->key with the
>> > +	 * kernel's RNG reseeding schedule.
>> > +	 */
>> > +	current_generation =3D READ_ONCE(rng_info->generation);
>>=20
>> > +		if (unlikely(READ_ONCE(state->generation) !=3D READ_ONCE(rng_info-
>>=20
>> I'm pretty sure you need some sort of barrier here.  We have a similar
>> TM-lite construct in glibc ld.so for locating link maps by address, and
>> there the compiler performed reordering.
>>=20
>>   _dl_find_object miscompilation on powerpc64le
>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=3D28745>
>>=20
>> I'm not familiar with READ_ONCE, but Documentation/atomic_t.txt suggests
>> it's a =E2=80=9Cregular LOAD=E2=80=9D, and include/asm-generic/rwonce.h =
concurs.
>
> Do you mean compiler barriers or SMP barriers?

Compiler barrier.

>> Likewise, the signal safety mechanism needs compiler barriers (signal
>> fences).
>
> READ_ONCE() should prevent the compiler from reordering the read.

READ_ONCE looks just like a volatile read.  Other reads can be ordered
around it.

For example, this:

void f1 (int, int, int);

extern int a;
extern int b;

void
f2 (volatile int *p)
{
  int a1 =3D a;
  int p1 =3D *p;
  int b1 =3D b;
  return f1 (a1, p1, b1);
}

Turns into:

	.globl	f2
	.type	f2, @function
f2:
	movl	(%rdi), %esi
	movl	b(%rip), %edx
	movl	a(%rip), %edi
	jmp	f1

Looks like compiler reodering to me.

>> I'm also not sure how READ_ONCE realizes atomic 64-bit reads on 32-bit
>> platforms.  i386 can do them in user space via the FPU worst-case (if
>> the control word hasn't been corrupted).  CMPXCHG8B is not applicable
>> here because it's a read-only mapping.  Maybe add a comment at least
>> about that =E2=80=9Cstrong prevailing wind=E2=80=9D?
>
> There's read tearing in that case, which isn't super, but perhaps not
> all together harmful.

Maybe add a comment that it was considered?

Thanks,
Florian

