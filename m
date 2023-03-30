Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B06D02F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjC3LTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjC3LT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:19:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84341A5C1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:18:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso17547186pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbArA3MR/dT7CNLjMYxDZhfmZYmOo9cX1NVqv86zJ4c=;
        b=hTtVSiFY4xN0fvYJwLlpm17ZO5ll4khXg+/qgUGXs6sdunkjikGDYSGewaTC/aC1rr
         i5OmZmgNWj+L1Ny2zTxncYLa5NyG/pq/56zlQIBjfJ5ICUlPDy2TZhuB4rMDb+ogbk/0
         Ntld7PiCfoYVluMJdp2EDbo9bCeFv/oBCCga0Ay7yl4Qux6tFI6aHywBIYOif0MgVU6F
         ynldFLRBf2kyQFFBY2TwnyW1DCml6Osn/zz2HZ8ZicxPRn2IspijHSgFFtXctcOVrkSs
         IWqf8eP5X50sC/ZG3bq03LPdUma9kCADRZtX18/lH+CCQSybcZzwMpMtGE/EI9CICaA8
         FkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbArA3MR/dT7CNLjMYxDZhfmZYmOo9cX1NVqv86zJ4c=;
        b=ARc1opzNQpW81l9eTArv2gvgMZwoWi5Y6zHtQN/pnre5i3H67R99twXrJTsFPcxrQJ
         9KiW137HRZGEYsuOLOaiAeR0jUXN9u0GlsbMGITcivz8Wl49ZPUOEOMRsJPPrbZuDUoc
         2NP+sOu5GsBt9nkXh+e6K+gGxJhl+YpZdiWH0SDurWf38xemnFJ9qkIEAfgQiEjUsU/p
         xGL+c2yqUxjGZBra1q2ODIKyDON7D5vjEbKx1KMM10A68rh4XM0erSuop5ibB/Iwp35w
         DfO/+hJvFdcbsQcChrsO9lh0NsaEdvDQfE1PkGQH1cth4/DEQe/YKT7YEL6qujDVlfRI
         fdVA==
X-Gm-Message-State: AO0yUKUjunRyKAYlAsv7iSJoN0FV9dUMqWxY9LuRjOWYA+qw2jqk/zPG
        GYVj+3VJMAUe4b7c3s6y77o=
X-Google-Smtp-Source: AK7set/rloeBiAAnQD1zNjknSZ9Kjoor4sWEGwVY1JExx1EmSeKfMRhbltFlIY5iiJXwNS7+hMB5Rw==
X-Received: by 2002:a05:6a20:3156:b0:db:3293:278f with SMTP id 22-20020a056a20315600b000db3293278fmr20355361pzk.44.1680175117204;
        Thu, 30 Mar 2023 04:18:37 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id g67-20020a636b46000000b005035f5e1f9csm23205270pgc.2.2023.03.30.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:18:36 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:18:32 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci_host: fix a race condition in vmci_host_poll()
 causing GPF
Message-ID: <ZCVwCNbuLDmiZ58w@dragonet>
References: <ZCGFsdBAU4cYww5l@dragonet>
 <ZCQPuaps5rCtGAb2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCQPuaps5rCtGAb2@kroah.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 12:15:21PM +0200, Greg KH wrote:
> On Mon, Mar 27, 2023 at 09:01:53PM +0900, Dae R. Jeong wrote:
> > During fuzzing, a general protection fault is observed in
> > vmci_host_poll().
> > 
> > general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
> > RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
> > <- omitting registers ->
> > Call Trace:
> >  <TASK>
> >  lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
> >  add_wait_queue+0x3d/0x260 kernel/sched/wait.c:22
> >  poll_wait include/linux/poll.h:49 [inline]
> >  vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
> >  vfs_poll include/linux/poll.h:88 [inline]
> >  do_pollfd fs/select.c:873 [inline]
> >  do_poll fs/select.c:921 [inline]
> >  do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
> >  __do_sys_ppoll fs/select.c:1121 [inline]
> >  __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > 
> > Example thread interleaving that causes the general protection fault
> > is as follows:
> > 
> > CPU1 (vmci_host_poll)               CPU2 (vmci_host_do_init_context)
> > -----                               -----
> > // Read uninitialized context
> > context = vmci_host_dev->context;
> >                                     // Initialize context
> >                                     vmci_host_dev->context = vmci_ctx_create();
> >                                     vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;
> > 
> > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> >     // Dereferencing the wrong pointer
> >     poll_wait(..., &context->host_context);
> > }
> > 
> > In this scenario, vmci_host_poll() reads vmci_host_dev->context first,
> > and then reads vmci_host_dev->ct_type to check that
> > vmci_host_dev->context is initialized. However, since these two reads
> > are not atomically executed, there is a chance of a race condition as
> > described above.
> > 
> > To fix this race condition, read vmci_host_dev->context after checking
> > the value of vmci_host_dev->ct_type so that vmci_host_poll() always
> > reads an initialized context.
> > 
> > Reported-by: Dae R. Jeong <threeearcat@gmail.com>
> > Fixes: 8bf503991f87 ("VMCI: host side driver implementation.")
> > Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>
> 
> If you author and sign-off on the patch, no need for a Reported-by: as
> that is obvious :)

For a student like me, two of my names are cooler than one... (shy smile :)...)

> And how did you test this change?

I attach a simple C program used in testing at the end of this email.
I used the same C program to trigger the crash before applying the
patch, and to test the patch after applying it.

Before applying this patch, I inserted msleep() to trigger the crash
easily as follows:

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 857b9851402a..e925f7effac4 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "vmci_handle_array.h"
 #include "vmci_queue_pair.h"
@@ -168,6 +169,11 @@ static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 	struct vmci_ctx *context = vmci_host_dev->context;
 	__poll_t mask = 0;
 
+	msleep(1000);
+
+	printk("%s, context=%px, ct_type=%d\n", __func__, context,
+		   vmci_host_dev->ct_type);
+
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
 		/* Check for VMCI calls to this VM context. */
 		if (wait)
@@ -341,6 +347,10 @@ static int vmci_host_do_init_context(struct vmci_host_dev *vmci_host_dev,
 	}
 
 	vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;
+
+	printk("%s, context=%px, ct_type=%d\n", __func__,
+		   vmci_host_dev->context, vmci_host_dev->ct_type);
+
 	atomic_inc(&vmci_host_active_users);
 
 	vmci_call_vsock_callback(true);

With this msleep(), the C program below can easily trigger the GPF.

Then I applied the patch that I propose, and ran the same C
program. After applying the patch, I couldn't observe the GPF.

> thanks,
> 
> greg k-h

Best regards,
Dae R. Jeong

------------->8-----------------
#include <fcntl.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

struct init_block {
  int cid;
  int flags;
};

int fd;

void *th1(void *a) {
  struct init_block s = {
      .cid = 2,
      .flags = 0,
  };
  ioctl(fd, 0x7a0, &s);
  return NULL;
}

void *th2(void *a) {
  struct pollfd pfd = {.fd = fd};
  poll(&pfd, 1, 20000);
  return NULL;
}

int test() {
#define filename "/dev/vmci"

  fd = openat(AT_FDCWD, filename, 0x2, 0x0);
  int var = 0x10000;
  ioctl(fd, 0x7a7, &var);
  pthread_t pth1, pth2;
  pthread_create(&pth1, NULL, th1, NULL);
  pthread_create(&pth2, NULL, th2, NULL);
  pthread_join(pth1, NULL);
  pthread_join(pth2, NULL);
  return 0;
}

int main() {
  for (;;) {
    pid_t pid = fork();
    if (pid == 0) {
      test();
    } else {
      usleep(100 * 1000);
      kill(pid, SIGKILL);
    }
  }
}
