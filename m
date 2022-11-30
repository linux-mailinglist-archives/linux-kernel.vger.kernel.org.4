Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7731063DAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiK3Qks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiK3Qkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:40:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E506DFEA;
        Wed, 30 Nov 2022 08:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6D50B81BB5;
        Wed, 30 Nov 2022 16:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A557C433D6;
        Wed, 30 Nov 2022 16:40:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gby+j1c7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669826430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpuNagX9yGWmz76JAkOLaM+VS0TPgWzkWZvprmcKQbY=;
        b=gby+j1c7NXWwpVuXnHiMmJj+lPbOBkli/O9dEo2H5OspsHqBGo9JSgGSCUis3tMXl0Cpr0
        xW5RlhjXuKo0k48ojwY3B9Q84+zlzXZJE1stp5RrYVYsy+GAU2K8S0O43J8Hy6EZstPYXJ
        Za2Lb5aA0cjThbxvATAe40Q8emKtqik=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74a5b925 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 30 Nov 2022 16:40:30 +0000 (UTC)
Date:   Wed, 30 Nov 2022 17:38:13 +0100
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
Message-ID: <Y4eG9cUE28s0YpgO@zx2c4.com>
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
> 2) Convert vgetrandom_alloc() into a clone3-style syscall, as Christian
>    suggested earlier, which might allow for a bit more overloading
>    capability. That would be a struct that looks like:
> 
>       struct vgetrandom_alloc_args {
> 	  __aligned_u64 flags;
>           __aligned_u64 states;
> 	  __aligned_u64 num;
> 	  __aligned_u64 size_of_each;
>       }
> 
>   - If flags is VGRA_ALLOCATE, states and size_of_each must be zero on
>     input, while num is the hint, as is the case now. On output, states,
>     size_of_each, and num are filled in.
> 
>   - If flags is VGRA_DEALLOCATE, states, size_of_each, and num must be as
>     they were originally, and then it deallocates.
> 
> I suppose (2) would alleviate your concerns entirely, without future
> uncertainty over what it'd be like to add special cases to munmap(). And
> it'd add a bit more future proofing to the syscall, depending on what we
> do.
> 
> So maybe I'm warming up to that approach a bit.

So I just did a little quick implementation to see what it'd feel like,
and actually, it's quite simple, and might address a lot of concerns all
at once. What do you think of the below? Documentation and such still
needs work obviously, but the bones should be there.

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4341c6a91207..dae6095b937d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -189,44 +189,53 @@ int __cold execute_with_initialized_rng(struct notifier_block *nb)
 /**
  * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
  *
- * @num:	   On input, a pointer to a suggested hint of how many states to
- * 		   allocate, and on output the number of states actually allocated.
- *
- * @size_per_each: The size of each state allocated, so that the caller can
- *		   split up the returned allocation into individual states.
- *
- * @flags:	   Currently always zero.
+ * @uargs:	A vgetrandom_alloc_args which may be updated on return.
+ * 		allocate, and on output the number of states actually allocated.
+ * @usize:	The size of @uargs, which determines the version of the struct used.
  *
  * The getrandom() vDSO function in userspace requires an opaque state, which
  * this function allocates by mapping a certain number of special pages into
  * the calling process. It takes a hint as to the number of opaque states
  * desired, and provides the caller with the number of opaque states actually
  * allocated, the size of each one in bytes, and the address of the first
- * state.
+ * state. Alternatively, if the VGRA_DEALLOCATE flag is specified, the provided
+ * states parameter is unmapped.
  *
- * Returns the address of the first state in the allocation on success, or a
- * negative error value on failure.
+ * Returns 0 on success and an error value otherwise.
  */
-SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
-		unsigned int __user *, size_per_each, unsigned int, flags)
+SYSCALL_DEFINE2(vgetrandom_alloc, struct vgetrandom_alloc_args __user *, uargs, size_t, usize)
 {
 	const size_t state_size = sizeof(struct vgetrandom_state);
+	const size_t max_states = (SIZE_MAX & PAGE_MASK) / state_size;
+	struct vgetrandom_alloc_args args;
 	size_t alloc_size, num_states;
 	unsigned long pages_addr;
-	unsigned int num_hint;
 	int ret;

-	if (flags)
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+	if (usize < VGETRANDOM_ALLOC_ARGS_SIZE_VER0)
 		return -EINVAL;
+	ret = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+	if (ret)
+		return ret;

-	if (get_user(num_hint, num))
-		return -EFAULT;
+	/* Currently only VGRA_DEALLOCATE is defined. */
+	if (args.flags & ~VGRA_DEALLOCATE)
+		return -EINVAL;

-	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
-	alloc_size = PAGE_ALIGN(num_states * state_size);
+	if (args.flags & VGRA_DEALLOCATE) {
+		if (args.size_per_each != state_size || args.num > max_states || !args.states)
+			return -EINVAL;
+		return vm_munmap(args.states, args.num * state_size);
+	}

-	if (put_user(alloc_size / state_size, num) || put_user(state_size, size_per_each))
-		return -EFAULT;
+	/* These don't make sense as input values if allocating, so reject them. */
+	if (args.size_per_each || args.states)
+		return -EINVAL;
+
+	num_states = clamp_t(size_t, args.num, 1, max_states);
+	alloc_size = PAGE_ALIGN(num_states * state_size);

 	pages_addr = vm_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
 			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0);
@@ -237,7 +246,14 @@ SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
 	if (ret < 0)
 		goto err_unmap;

-	return pages_addr;
+	args.num = num_states;
+	args.size_per_each = state_size;
+	args.states = pages_addr;
+
+	ret = -EFAULT;
+	if (copy_to_user(uargs, &args, sizeof(args)))
+		goto err_unmap;
+	return 0;

 err_unmap:
 	vm_munmap(pages_addr, alloc_size);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7741dc94f10c..de4338e26db0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -72,6 +72,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct vgetrandom_alloc_args;

 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1006,9 +1007,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 			    void __user *uargs);
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
-asmlinkage long sys_vgetrandom_alloc(unsigned int __user *num,
-				     unsigned int __user *size_per_each,
-				     unsigned int flags);
+asmlinkage long sys_vgetrandom_alloc(struct vgetrandom_alloc_args __user *uargs,
+				     size_t size);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
 asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index e744c23582eb..49911ea2c343 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -55,4 +55,30 @@ struct rand_pool_info {
 #define GRND_RANDOM	0x0002
 #define GRND_INSECURE	0x0004

+/*
+ * Flags for vgetrandom_alloc(2)
+ *
+ * VGRA_DEALLOCATE	Deallocate supplied states.
+ */
+#define VGRA_DEALLOCATE	0x0001ULL
+
+/**
+ * struct vgetrandom_alloc_args - Arguments for the vgetrandom_alloc(2) syscall.
+ *
+ * @flags:	   Zero or more VGRA_* flags.
+ * @states:	   Zero on input if allocating, and filled in on successful
+ *		   return. An existing allocation, if deallocating.
+ * @num:	   A hint as to the desired number of states, if allocating. The
+ *		   number of existing states in @states, if deallocating
+ * @size_per_each: The size of each state in @states.
+ */
+struct vgetrandom_alloc_args {
+	__aligned_u64 flags;
+	__aligned_u64 states;
+	__aligned_u64 num;
+	__aligned_u64 size_per_each;
+};
+
+#define VGETRANDOM_ALLOC_ARGS_SIZE_VER0 32 /* sizeof first published struct */
+
 #endif /* _UAPI_LINUX_RANDOM_H */

