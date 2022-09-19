Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368F85BCBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiISMio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiISMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:38:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37602DA94
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:38:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWPN40M8Cz4xG5;
        Mon, 19 Sep 2022 22:37:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1663591077;
        bh=26aYF6mHiSEt2iwCmNXzzHxdDu+GYYO2herY5axBaIs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ascLbqb3/mCGZ9Vqn5RLOOm0XFP91jM5LETMX9S2kwAG7OarHImLnwGRt/MhNWZtS
         d2WCoEsXGM6E3eIZYONoX4buh5dXApQ5vdHnnjAxP/bIU7kcOJ6w9N0s7WHJq4c7F1
         MURQJjtF+OD18kY8NfzEpsFz9Z9D0K9CiKKKIFk9gauppc5M3+mxt57QzqpuCn80GG
         n4deI0vtI6kJ+WGGWRYvBlsn7xBT9zdDc0ONJbU6z/4bSwulkkJyB/P6Gdy+Bdk+iL
         uzU9F/A2q9VAAlkaxmARYYY1CvdrwR3PzSMRJNfOozRTU8Nx5OetT8GZfO6iZVeIKu
         HRfQKcwEjS44Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Samuel Holland <samuel@sholland.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Russell Currey <ruscur@russell.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Save AMR/IAMR when switching tasks
In-Reply-To: <89049105-64fc-8d5b-d090-2841064786d1@csgroup.eu>
References: <20220916050515.48842-1-samuel@sholland.org>
 <89049105-64fc-8d5b-d090-2841064786d1@csgroup.eu>
Date:   Mon, 19 Sep 2022 22:37:51 +1000
Message-ID: <87h713leu8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 16/09/2022 =C3=A0 07:05, Samuel Holland a =C3=A9crit=C2=A0:
>> With CONFIG_PREEMPT=3Dy (involuntary preemption enabled), it is possible
>> to switch away from a task inside copy_{from,to}_user. This left the CPU
>> with userspace access enabled until after the next IRQ or privilege
>> level switch, when AMR/IAMR got reset to AMR_KU[AE]P_BLOCKED. Then, when
>> switching back to the original task, the userspace access would fault:
>
> This is not supposed to happen. You never switch away from a task=20
> magically. Task switch will always happen in an interrupt, that means=20
> copy_{from,to}_user() get interrupted.

Unfortunately this isn't true when CONFIG_PREEMPT=3Dy.

We can switch away without an interrupt via:
  __copy_tofrom_user()
    -> __copy_tofrom_user_power7()
       -> exit_vmx_usercopy()
          -> preempt_enable()
             -> __preempt_schedule()
                -> preempt_schedule()
                   -> preempt_schedule_common()
                      -> __schedule()

I do some boot tests with CONFIG_PREEMPT=3Dy, but I realise now those are
all on Power8, which is a bit of an oversight on my part.

And clearly no one else tests it, until now :)

I think the root of our problem is that our KUAP lock/unlock is at too
high a level, ie. we do it in C around the low-level copy to/from.

eg:

static inline unsigned long
raw_copy_to_user(void __user *to, const void *from, unsigned long n)
{
	unsigned long ret;

	allow_write_to_user(to, n);
	ret =3D __copy_tofrom_user(to, (__force const void __user *)from, n);
	prevent_write_to_user(to, n);
	return ret;
}

There's a reason we did that, which is that we have various different
KUAP methods on different platforms, not a simple instruction like other
arches.

But that means we have that exit_vmx_usercopy() being called deep in the
guts of __copy_tofrom_user(), with KUAP disabled, and then we call into
the preempt machinery and eventually schedule.

I don't see an easy way to fix that "properly", it would be a big change
to all platforms to push the KUAP save/restore down into the low level
asm code.

But I think the patch below does fix it, although it abuses things a
little. Namely it only works because the 64s KUAP code can handle a
double call to prevent, and doesn't need the addresses or size for the
allow.

Still I think it might be our best option for an easy fix.

Samuel, can you try this on your system and check it works for you?

cheers


diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/as=
m/processor.h
index 97a77b37daa3..c50080c6a136 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -432,6 +432,7 @@ int speround_handler(struct pt_regs *regs);
 /* VMX copying */
 int enter_vmx_usercopy(void);
 int exit_vmx_usercopy(void);
+void exit_vmx_usercopy_continue(void);
 int enter_vmx_ops(void);
 void *exit_vmx_ops(void *dest);
=20
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser=
_power7.S
index 28f0be523c06..77804860383c 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -47,7 +47,7 @@
 	ld	r15,STK_REG(R15)(r1)
 	ld	r14,STK_REG(R14)(r1)
 .Ldo_err3:
-	bl	exit_vmx_usercopy
+	bl	exit_vmx_usercopy_continue
 	ld	r0,STACKFRAMESIZE+16(r1)
 	mtlr	r0
 	b	.Lexit
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index f76a50291fd7..78a18b8384ff 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -8,6 +8,7 @@
  */
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
+#include <asm/kup.h>
 #include <asm/switch_to.h>
=20
 int enter_vmx_usercopy(void)
@@ -34,12 +35,19 @@ int enter_vmx_usercopy(void)
  */
 int exit_vmx_usercopy(void)
 {
+	prevent_user_access(KUAP_READ_WRITE);
 	disable_kernel_altivec();
 	pagefault_enable();
 	preempt_enable();
 	return 0;
 }
=20
+void exit_vmx_usercopy_continue(void)
+{
+	exit_vmx_usercopy();
+	allow_read_write_user(NULL, NULL, 0);
+}
+
 int enter_vmx_ops(void)
 {
 	if (in_interrupt())

