Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158E9668875
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjAMAct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjAMAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:32:45 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E960CC0;
        Thu, 12 Jan 2023 16:32:43 -0800 (PST)
Date:   Fri, 13 Jan 2023 00:32:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1673569960; x=1673829160;
        bh=QX+nECwZN3I0sjACQskWunwGexAVyvI38tBRthUZqi8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=5KEj8O1+DGoKU+C2si1N1Giub5/toyi24R26iaYxIFkLMkpVPn4XKOI78HMGmYRHo
         zmJOUXI+9ZbEQf6NrdDN+gVejG9ZDq28X8n8kIcVBFbAhBpHQxuD0GneKtqXhqCOD5
         O5MJIz8lFIlhW69TpRA9Plsbh1v2k+gPCX+8u3uBsnNFfAWnGki4Nw1/wjRqG7pWQB
         0BMbVyJHEbA8bqTNuvf8gOC6CGUAKMyS6MQ8Jt/tzrJORiHyKkShoRzhEGrZ40k1YR
         egR9KfaG+fIhqSejvzJlUpLot6yiWdEMnB9Pb3squKMILtobi1xjFcFueGd5yQ1Ym0
         zBvn/puqVxSEg==
To:     Yann Droneaud <ydroneaud@opteya.com>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [RFC PATCH 1/4] random: introduce getrandom() GRND_TIMESTAMP
Message-ID: <u63qVsNp7euFAjiS_EUypV5P87i6gOl1BLX8cU8LQ7oHkzQVUxncjJhMb_4ybS574fV_buYZwDJDGFnFdREaQu44daEX7Pvednf-CXtPcJ0=@n8pjl.ca>
In-Reply-To: <d890f9d03c2da1eef7bdf47e5b6f3d0b7e1afb3f.1673539719.git.ydroneaud@opteya.com>
References: <cover.1673539719.git.ydroneaud@opteya.com> <d890f9d03c2da1eef7bdf47e5b6f3d0b7e1afb3f.1673539719.git.ydroneaud@opteya.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>GRND_TIMESTAMP allows userspace to ask the kernel if previous
>"timestamp" has changed as the result of an event that
>triggered kernel CSPRNG reseed, and to update the "timestamp".

>In case the "timestamp" hasn't changed, userspace CSPRNG can
>consume a slice of its buffered random stream.

>If it has changed, remaining userspace buffered random values
>should be discarded. Userspace should call getrandom() to fill
>and/or generate its buffer with updated seed.
>It's advised to test again the "timestamp" to deal with the
>race condition, where the kernel reseed just after the call
>to getrandom() to get entropy.

This second check is the 'safe thing' to do, but if you're that
worried about race conditions then this api is useless. You can't
ignore the inherent TOCTOU problem with the GRND_TIMESTAMP calls.

That said, the race condition is so tiny that the added overhead
of a third syscall (without vDSO support) starts to negate the
value in buffering the random numbers (not to mention adding
significant latency to every nth arc4random() call, for example).

IMO, for callers that cannot accept the risk, the getrandom(,,0)
option is the perfect alternative.

[...]

>+static ssize_t get_random_timestamp(char __user *ubuf, size_t len, unsign=
ed int flags)
>+{
>+=09u64 ts;
>+
>+=09/* other combination not supported */
>+=09if (WARN(flags !=3D GRND_TIMESTAMP, "GRND_TIMESTAMP cannot be used wit=
h other flags"))
>+=09=09return -EINVAL;

If userspace messes up the flags then it's the problem of the
caller. Why clutter the logs in that case?

At the very least this should be WARN_ONCE() to avoid log spam.

>+=09/* shorter structure not supported */
>+=09if (len < sizeof(ts))
>+=09=09return -EINVAL;

This should be sizeof(u64) to match the vDSO patch and to avoid
having to change this condition if ts becomes larger.

>+
>+=09if (copy_from_user(&ts, ubuf, sizeof(ts)))
>+=09=09return -EFAULT;
>+
>+=09/* longer structure supported, only if 0-padded,
>+=09   timestamp might be extended in the future with more fields */
>+=09if (len > sizeof(ts)) {
>+=09=09char __user *p =3D ubuf + sizeof(ts);
>+=09=09size_t l =3D len - sizeof(ts);
>+
>+=09=09while (l) {
>+=09=09=09char b;
>+
>+=09=09=09if (get_user(b, p++))
>+=09=09=09=09return -EFAULT;
>+
>+=09=09=09if (b)
>+=09=09=09=09return -EINVAL;
>+=09=09}
>+=09}
>+
>+=09if (!get_random_timestamp_update(&ts, READ_ONCE(base_crng.generation))=
)
>+=09=09return 0;
>+
>+=09if (copy_to_user(ubuf, &ts, sizeof(ts)))
>+=09=09return -EFAULT;
>+
>+=09return sizeof(ts);
>+}
>+
> SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int=
, flags)
> {
> =09struct iov_iter iter;
> =09struct iovec iov;
> =09int ret;
>
>-=09if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
>+=09if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE | GRND_TIMES=
TAMP))
> =09=09return -EINVAL;
>
>+=09if (unlikely(flags & GRND_TIMESTAMP))
>+=09=09return get_random_timestamp(ubuf, len, flags);
>+

I'd remove the unlikely(). I don't like to assume usage patterns.

> =09/*
> =09 * Requesting insecure and blocking randomness at the same time makes
> =09 * no sense.
>diff --git a/include/linux/random.h b/include/linux/random.h
>index b0a940af4fff..bc219b5a96a5 100644
>--- a/include/linux/random.h
>+++ b/include/linux/random.h
>@@ -161,4 +161,35 @@ int random_online_cpu(unsigned int cpu);
> extern const struct file_operations random_fops, urandom_fops;
> #endif
>
>+/*
>+ * get_random_timestamp_update()
>+ *
>+ * @generation: current CRNG generation (from base_crng.generation
>+ *              or _vdso_rng_data.generation)
>+ *
>+ * Return: timestamp size if previous timestamp is expired and is updated=
,
>+ *         0 if not expired (and not updated)
>+ */
>+static inline bool get_random_timestamp_update(u64 *user_ts,
>+=09=09=09=09=09       u64 generation)
>+{
>+=09u64 ts;
>+
>+=09/* base_crng.generation is never ULONG_MAX,
>+=09 * OTOH userspace will initialize its timestamp
>+=09 * to 0, so inverting base_crng.generation ensure
>+=09 * first call to getrandom(,,GRND_TIMESTAMP) will
>+=09 * update
>+=09 */

Rather than assuming that the timestamp will start zero-initilized,
expect it to be uninitilized. Either way the code works.

>+=09ts =3D ~generation;
>+
>+=09/* not expired ? no refresh suggested */
>+=09if (*user_ts =3D=3D ts)
>+=09=09return false;
>+
>+=09*user_ts =3D ts;
>+
>+=09return true;
>+}
>+

Not that it matters much, but you could make generation a u64* that
gets dereferenced by get_random_timestamp_update(). It's cleaner for
the caller, barely changes this function, and will get inlined anyway.
I might just be imposing my personal style in this case though.

After a cursory skimming of the rest of the series I think that this
is a worthwhile direction to pursue. Jason's series is growing bulky
and this provides the needed slimming while solving the root problem.

The only thing I see immediately is the TOCTOU problem and the extra
steps needed to guarantee forward secrecy.

I should mention that I'm not a security or rng expert at all.

Cheers,
Peter Lafreniere
<peter@n8pjl.ca>


