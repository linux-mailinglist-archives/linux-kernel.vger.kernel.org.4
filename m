Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A75667CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjALRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbjALRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:44:45 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878414037;
        Thu, 12 Jan 2023 09:03:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:dc8b:b602:9bcd:3004])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id D59497803AE;
        Thu, 12 Jan 2023 18:03:18 +0100 (CET)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: [RFC PATCH 1/4] random: introduce getrandom() GRND_TIMESTAMP
Date:   Thu, 12 Jan 2023 18:02:33 +0100
Message-Id: <d890f9d03c2da1eef7bdf47e5b6f3d0b7e1afb3f.1673539719.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1673539719.git.ydroneaud@opteya.com>
References: <cover.1673539719.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the pursuit of implementing an userspace arc4random() fast
enough to be used in place of rand(), random(), lrand48(),
mrand48(), etc., and as strong as getrandom(), it was found
that calling getrandom() to generate one uint32_t at a time
is not fast enough (see [1] for example).

As noted by Florian Weimer in [2]:

    "The performance numbers suggest that we benefit from buffering in user
     space.  It might not be necessary to implement expansion in userspace.
     getrandom (or /dev/urandom) with a moderately-sized buffer could be
     sufficient."

Generating multiple values ahead of time with a proper CSPRNG
helps achieve better performances. But buffering in userspace
come with a lot of security related hurdles and pitfalls.

As noted by Jason A. Donenfeld in [3]

    "For example, the kernel reseeds itself when virtual machines fork using
     an identifier passed to the kernel via ACPI. It also reseeds itself on
     system resume, both from ordinary S3 sleep but also, more importantly,
     from hibernation."

Ignoring for now the issue of securily store the buffered
random values in memory to achieve forward secrecy [4], it's
possible to devise a mechanism to help userspace to know
when to discard the values generated/buffered from a previous
call to getrandom() so that the VM and/or resume issue can
be dealt with at userspace level.

Instead of adding a new system call, this patch shoehorns a
query mechanism in getrandom() syscall by adding a mean to
get and test a "timestamp". Currently, the "timestamp" is a
single 64bit integer, that maps to the kernel's base CSPRNG
generation, inverted, so that 0 means unintialized.

GRND_TIMESTAMP allows userspace to ask the kernel if previous
"timestamp" has changed as the result of an event that
triggered kernel CSPRNG reseed, and to update the "timestamp".

In case the "timestamp" hasn't changed, userspace CSPRNG can
consume a slice of its buffered random stream.

If it has changed, remaining userspace buffered random values
should be discarded. Userspace should call getrandom() to fill
and/or generate its buffer with updated seed.
It's advised to test again the "timestamp" to deal with the
race condition, where the kernel reseed just after the call
to getrandom() to get entropy.

How to not use it (because it doesn't have reseed on fork(),
aka. MADV_WIPEONFORK, and forward secrecy buffer protection
aka. mlock(), see [4]):

    static bool expired(void)
    {
            static uint64_t grnd_ts;

            ret = getrandom(&grnd_ts, sizeof(grnd_ts), GRND_TIMESTAMP);
            if (ret < 0)
                    abort(); /* TODO: proper fallback to unbuffered getrandom() */

            return !!ret;
    }

    uint32_t arc4random(void)
    {
            static uint32_t buffer[128]; /* TODO: mlock() buffer memory */
            static unsigned int avail;
            uint32_t val;

            while (expired() || !avail) {
                    getrandom(buffer, sizeof(buffer), 0);
                    avail = 128;
            }

            avail--;
            val = buffer[avail];
            buffer[avail] = 0;

            return val;
    }

As the "timestamp" query has to be made for each uint32_t value
generated by arc4random(), the query should be as lightweight
as possible, thus it's expected GRND_TIMESTAMP to be handled by
at the vDSO level to prevent a system call.

[1] https://lore.kernel.org/all/874jt0kndq.fsf@oldenburg.str.redhat.com/
[2] https://sourceware.org/pipermail/libc-alpha/2022-July/140963.html
[3] https://sourceware.org/pipermail/libc-alpha/2022-July/140939.html
[4] https://lore.kernel.org/all/20230101162910.710293-1-Jason@zx2c4.com/

Link: https://lore.kernel.org/all/cover.1673539719.git.ydroneaud@opteya.com/
Cc: linux-crypto@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 drivers/char/random.c       | 46 ++++++++++++++++++++++++++++++++++++-
 include/linux/random.h      | 31 +++++++++++++++++++++++++
 include/uapi/linux/random.h |  2 ++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index ce3ccd172cc8..9e2a37e432c0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1361,15 +1361,59 @@ static void __cold try_to_generate_entropy(void)
  *
  **********************************************************************/
 
+static ssize_t get_random_timestamp(char __user *ubuf, size_t len, unsigned int flags)
+{
+	u64 ts;
+
+	/* other combination not supported */
+	if (WARN(flags != GRND_TIMESTAMP, "GRND_TIMESTAMP cannot be used with other flags"))
+		return -EINVAL;
+
+	/* shorter structure not supported */
+	if (len < sizeof(ts))
+		return -EINVAL;
+
+	if (copy_from_user(&ts, ubuf, sizeof(ts)))
+		return -EFAULT;
+
+	/* longer structure supported, only if 0-padded,
+	   timestamp might be extended in the future with more fields */
+	if (len > sizeof(ts)) {
+		char __user *p = ubuf + sizeof(ts);
+		size_t l = len - sizeof(ts);
+
+		while (l) {
+			char b;
+
+			if (get_user(b, p++))
+				return -EFAULT;
+
+			if (b)
+				return -EINVAL;
+		}
+	}
+
+	if (!get_random_timestamp_update(&ts, READ_ONCE(base_crng.generation)))
+		return 0;
+
+	if (copy_to_user(ubuf, &ts, sizeof(ts)))
+		return -EFAULT;
+
+	return sizeof(ts);
+}
+
 SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
 {
 	struct iov_iter iter;
 	struct iovec iov;
 	int ret;
 
-	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
+	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE | GRND_TIMESTAMP))
 		return -EINVAL;
 
+	if (unlikely(flags & GRND_TIMESTAMP))
+		return get_random_timestamp(ubuf, len, flags);
+
 	/*
 	 * Requesting insecure and blocking randomness at the same time makes
 	 * no sense.
diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..bc219b5a96a5 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -161,4 +161,35 @@ int random_online_cpu(unsigned int cpu);
 extern const struct file_operations random_fops, urandom_fops;
 #endif
 
+/*
+ * get_random_timestamp_update()
+ *
+ * @generation: current CRNG generation (from base_crng.generation
+ *              or _vdso_rng_data.generation)
+ *
+ * Return: timestamp size if previous timestamp is expired and is updated,
+ *         0 if not expired (and not updated)
+ */
+static inline bool get_random_timestamp_update(u64 *user_ts,
+					       u64 generation)
+{
+	u64 ts;
+
+	/* base_crng.generation is never ULONG_MAX,
+	 * OTOH userspace will initialize its timestamp
+	 * to 0, so inverting base_crng.generation ensure
+	 * first call to getrandom(,,GRND_TIMESTAMP) will
+	 * update
+	 */
+	ts = ~generation;
+
+	/* not expired ? no refresh suggested */
+	if (*user_ts == ts)
+		return false;
+
+	*user_ts = ts;
+
+	return true;
+}
+
 #endif /* _LINUX_RANDOM_H */
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index e744c23582eb..b433fb8d79ac 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -50,9 +50,11 @@ struct rand_pool_info {
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
  * GRND_RANDOM		No effect
  * GRND_INSECURE	Return non-cryptographic random bytes
+ * GRND_TIMESTAMP	Interpret buffer as an opaque timestamp structure
  */
 #define GRND_NONBLOCK	0x0001
 #define GRND_RANDOM	0x0002
 #define GRND_INSECURE	0x0004
+#define GRND_TIMESTAMP	0x0008
 
 #endif /* _UAPI_LINUX_RANDOM_H */
-- 
2.37.2

