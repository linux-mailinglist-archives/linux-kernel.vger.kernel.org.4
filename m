Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F563E79D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLACQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLACQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:16:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93F9C637;
        Wed, 30 Nov 2022 18:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA1461E33;
        Thu,  1 Dec 2022 02:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99982C433D6;
        Thu,  1 Dec 2022 02:16:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W9BC4zgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669860987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u3FTOtZpdTZLy3/k78tZkT54sf8xZfaUw16L7xc/1go=;
        b=W9BC4zgHnBzwICnH/96H72eXUR+/bnlmnKyNj58IytMW4u+R3rETOIp1hrjekTSMOU77Bt
        SPWUBmYkAArZxIZarKQbdCW5TM6vPas2sTEbM9K4UCnTLM3AYldAIOeJUj5PYKP1G++C/b
        bmfxZ1yb5uXK/F+TeQZpd9Q+KJO3FZ4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d009f39a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 1 Dec 2022 02:16:27 +0000 (UTC)
Date:   Thu, 1 Dec 2022 03:16:20 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Message-ID: <Y4gOdC8J+zzRsago@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
 <20221129210639.42233-2-Jason@zx2c4.com>
 <877czc7m0g.fsf@oldenburg.str.redhat.com>
 <Y4d5SyU3akA9ZBaJ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4d5SyU3akA9ZBaJ@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 04:39:55PM +0100, Jason A. Donenfeld wrote:
> > Can userspace use the memory for something else if it's not passed to
> > getrandom?
> 
> I suspect the documentation answer here is, "no", even if technically it
> might happen to work on this kernel or that kernel. I suppose this could
> even be quasi-enforced by xoring the top bits with some vdso
> compile-time constant, so you can't rely on being able to dereference
> it yourself.
> [...]
> Then they're caught holding the bag? This doesn't seem much different
> from userspace shooting themselves in general, like writing garbage into
> the allocated states and then trying to use them. If this is something
> you really, really are concerned about, then maybe my cheesy dumb xor
> thing mentioned above would be a low effort mitigation here.

I implemented a sample of this, below. I think this is a bit silly,
though, and making this fully robust could take some effort. Overall, I
don't think we should do this.

However, the more I think about the args thing from the last email,
the more I like *that* idea. So I think I'll roll with that.

But this cheesy pointer obfuscation thing here, meh. But here's what it
could look like anyway:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2aaeb48d11be..7aff45165ce5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -228,7 +228,7 @@ SYSCALL_DEFINE2(vgetrandom_alloc, struct vgetrandom_alloc_args __user *, uargs,
 	if (args.flags & VGRA_DEALLOCATE) {
 		if (args.size_per_each != state_size || args.num > max_states || !args.states)
 			return -EINVAL;
-		return vm_munmap(args.states, args.num * state_size);
+		return vm_munmap(args.states ^ VGETRANDOM_STATE_HI_TAINT, args.num * state_size);
 	}

 	/* These don't make sense as input values if allocating, so reject them. */
@@ -249,7 +249,7 @@ SYSCALL_DEFINE2(vgetrandom_alloc, struct vgetrandom_alloc_args __user *, uargs,

 	args.num = num_states;
 	args.size_per_each = state_size;
-	args.states = pages_addr;
+	args.states = pages_addr ^ VGETRANDOM_STATE_HI_TAINT;

 	ret = -EFAULT;
 	if (copy_to_user(uargs, &args, sizeof(args)))
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
index cb624799a8e7..9a6aaf4d99d4 100644
--- a/include/vdso/getrandom.h
+++ b/include/vdso/getrandom.h
@@ -8,6 +8,7 @@

 #include <crypto/chacha.h>
 #include <vdso/limits.h>
+#include <linux/version.h>

 /**
  * struct vgetrandom_state - State used by vDSO getrandom() and allocated by vgetrandom_alloc().
@@ -41,4 +42,10 @@ struct vgetrandom_state {
 	bool 			in_use;
 };

+/* Be annoying by changing frequently enough. */
+#define VGETRANDOM_STATE_HI_TAINT ((unsigned long)(((LINUX_VERSION_CODE >> 16) + \
+				    (LINUX_VERSION_CODE >>  8) + (LINUX_VERSION_CODE >>  0) + \
+				    __GNUC__ + __GNUC_MINOR__ + __GNUC_PATCHLEVEL__) \
+				   & 0xff) << (BITS_PER_LONG - 8))
+
 #endif /* _VDSO_GETRANDOM_H */
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 9ca624756432..14cbd349186c 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -57,7 +57,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 		       unsigned int flags, void *opaque_state)
 {
 	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
-	struct vgetrandom_state *state = opaque_state;
+	struct vgetrandom_state *state = (void *)((unsigned long)opaque_state ^ VGETRANDOM_STATE_HI_TAINT);
 	size_t batch_len, nblocks, orig_len = len;
 	unsigned long current_generation;
 	void *orig_buffer = buffer;
