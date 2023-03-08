Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC6B047B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCHKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCHKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AD77CB0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:32:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so821016wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678271561;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTpI/ATF+c54SwR4NIfut5ZP/DAkJSYP7eEYSoHEoTg=;
        b=GwQXQzmmF7hBdRmoRbCPZpzDZOPv4x+tbm/AGfcGf9mMg9SE9K/xbpBKJ7sCaLlt4N
         XZ1AcrGHwRwuNRuVZbiirQ9QP+4RXo6lzLnrqdjMaVpF1Mwz0UobpbOosQVAa0eab+tc
         8zqiAGh+0B3/u6oj0it85P5/i7oxmM5Nv3HwRvvGSMYpaSKAsKFIeD1lpEt+v22dAQ4+
         B/olSlCglc/Ud6+V20vGTbPCESuVoWa13rOJqyJnM/WVNzj2viYYSPKPllAkozvLgU6l
         Sy9jNYCq5XaX+L5/9Ur5v9dl0ho8VSA94pqQYJRqcJT62y2+vzKkhE8NerkTc5teq/Sr
         /9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271561;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTpI/ATF+c54SwR4NIfut5ZP/DAkJSYP7eEYSoHEoTg=;
        b=QVVG5+3q9g6pSIHR+Yx/uZA5riCIL6Nc/7SQ4kB/XPIspsrkwjXws5hz7g1mbwfugZ
         iOQBORUSmPbqHr5baQ7ewkOdmIk2pOnN78vX8BsDkPLipkYS7TPYEneYLTY03Nf+WTjf
         5RXYO7FHL9DxR+VKoDZhCVfGtnFn5oGAsf11FuL2jASYYVzfSg4sT4W6BxVIRW5oxU+I
         le07UBCSF1eQqbtGHtb5qVr3tr8EKNinqpzebfKSsDXWUlVaVHkfm0vJqGxnPtj83uS7
         qosYAtmBRkrwkofoB8iASZKYR+IbhGCXZEsdXnsljtFJSIAavbBW9r085gVxKwYZW4le
         QiHw==
X-Gm-Message-State: AO0yUKU9TScKdb3pQE94P6K6s+uBtDxxR1Px7QAU6ZeqJlZB7M413peV
        /4dcMQ67VIP1nXUTDjldUgx5og==
X-Google-Smtp-Source: AK7set8Y8IRO+bYklRwCSoQnrSW5ClVdKEoAiubrrROMlKzUVbjvAL0/hv/YW3oe+/LFgT/+USJONw==
X-Received: by 2002:a05:600c:4692:b0:3ea:f73e:9d8a with SMTP id p18-20020a05600c469200b003eaf73e9d8amr15409084wmo.30.1678271561077;
        Wed, 08 Mar 2023 02:32:41 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:ba88:6ccc:13c7:4bae])
        by smtp.gmail.com with ESMTPSA id s25-20020a05600c319900b003db03725e86sm15243907wmp.8.2023.03.08.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:32:40 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:32:33 +0100
From:   Marco Elver <elver@google.com>
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        xiaoming.yu@mediatek.com, will@kernel.org
Subject: Re: [PATCH] kcsan:fix alignment_fault when read unaligned
 instrumented memory
Message-ID: <ZAhkQUmvf1U3H4nR@elver.google.com>
References: <CANpmjNMj3JX6d=HS=CNzxZPZcJZWfz0G5wKmJjfGb_N525NNLw@mail.gmail.com>
 <20230308094101.66448-1-haibo.li@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094101.66448-1-haibo.li@mediatek.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 05:41PM +0800, Haibo Li wrote:
[...]
> > > x2 : 0005ff802a0d8d71 x1 : 0000000000000000 x0 : 0000000000000000 Call
> > > trace:
> > >  kcsan_setup_watchpoint+0x26c/0x6bc
> > >  __tsan_read2+0x1f0/0x234
> > >  inflate_fast+0x498/0x750
> > 
> > ^^ is it possible that an access in "inflate_fast" is unaligned?
> Here is the instruction for inflate_fast+0x498:
> ffffffc008948980 <inflate_fast>:
> ...
> 	ffffffc008948e10: e0 03 1c aa   mov     x0, x28
> 	ffffffc008948e14: 06 3a e9 97   bl      0xffffffc00839762c <__tsan_unaligned_read2>
> 	ffffffc008948e18: e0 03 17 aa   mov     x0, x23
> 	>ffffffc008948e1c: 9a 27 40 78   ldrh    w26, [x28], #2
> 
> And the instruction for kcsan_setup_watchpoint+0x26c:
> 	ffffffc00839ab90 <kcsan_setup_watchpoint>:
> 	...
> 	>ffffffc00839adfc: a8 fe df 48   ldarh   w8, [x21]
> 
> The instruction is different.READ_ONCE uses ldarh,which requires the access address is aligned.
> As ARM v8 arm said:
> "
> Load-Acquire, Load-AcquirePC and Store-Release, other than Load-Acquire Exclusive Pair and
> Store-Release-Exclusive Pair, access only a single data element. This access is single-copy atomic. The address of the data object must be aligned to the size of the data element being accessed, otherwise the access generates an
> Alignment fault."
> 
> while ldrh accepts unaligned address.
> That's why it is ok while disable KCSAN.

I understand now what's going on, thanks for the analysis.

Can you test the below patch, I think it is the correct solution for
this - compared to your approach of opting out unaligned accesses, with
the below there is no loss of functionality.

Thanks,
-- Marco

------ >8 ------


From 889e9d5ce61592a18c90a9c57495337d5827bbc2 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Wed, 8 Mar 2023 11:21:06 +0100
Subject: [PATCH] kcsan: Avoid READ_ONCE() in read_instrumented_memory()

Haibo Li reported:

 | Unable to handle kernel paging request at virtual address
 |   ffffff802a0d8d7171
 | Mem abort info:o:
 |   ESR = 0x9600002121
 |   EC = 0x25: DABT (current EL), IL = 32 bitsts
 |   SET = 0, FnV = 0 0
 |   EA = 0, S1PTW = 0 0
 |   FSC = 0x21: alignment fault
 | Data abort info:o:
 |   ISV = 0, ISS = 0x0000002121
 |   CM = 0, WnR = 0 0
 | swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000002835200000
 | [ffffff802a0d8d71] pgd=180000005fbf9003, p4d=180000005fbf9003,
 | pud=180000005fbf9003, pmd=180000005fbe8003, pte=006800002a0d8707
 | Internal error: Oops: 96000021 [#1] PREEMPT SMP
 | Modules linked in:
 | CPU: 2 PID: 45 Comm: kworker/u8:2 Not tainted
 |   5.15.78-android13-8-g63561175bbda-dirty #1
 | ...
 | pc : kcsan_setup_watchpoint+0x26c/0x6bc
 | lr : kcsan_setup_watchpoint+0x88/0x6bc
 | sp : ffffffc00ab4b7f0
 | x29: ffffffc00ab4b800 x28: ffffff80294fe588 x27: 0000000000000001
 | x26: 0000000000000019 x25: 0000000000000001 x24: ffffff80294fdb80
 | x23: 0000000000000000 x22: ffffffc00a70fb68 x21: ffffff802a0d8d71
 | x20: 0000000000000002 x19: 0000000000000000 x18: ffffffc00a9bd060
 | x17: 0000000000000001 x16: 0000000000000000 x15: ffffffc00a59f000
 | x14: 0000000000000001 x13: 0000000000000000 x12: ffffffc00a70faa0
 | x11: 00000000aaaaaaab x10: 0000000000000054 x9 : ffffffc00839adf8
 | x8 : ffffffc009b4cf00 x7 : 0000000000000000 x6 : 0000000000000007
 | x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc00a70fb70
 | x2 : 0005ff802a0d8d71 x1 : 0000000000000000 x0 : 0000000000000000
 | Call trace:
 |  kcsan_setup_watchpoint+0x26c/0x6bc
 |  __tsan_read2+0x1f0/0x234
 |  inflate_fast+0x498/0x750
 |  zlib_inflate+0x1304/0x2384
 |  __gunzip+0x3a0/0x45c
 |  gunzip+0x20/0x30
 |  unpack_to_rootfs+0x2a8/0x3fc
 |  do_populate_rootfs+0xe8/0x11c
 |  async_run_entry_fn+0x58/0x1bc
 |  process_one_work+0x3ec/0x738
 |  worker_thread+0x4c4/0x838
 |  kthread+0x20c/0x258
 |  ret_from_fork+0x10/0x20
 | Code: b8bfc2a8 2a0803f7 14000007 d503249f (78bfc2a8) )
 | ---[ end trace 613a943cb0a572b6 ]-----

The reason for this is that on certain arm64 configuration since
e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when
CONFIG_LTO=y"), READ_ONCE() may be promoted to a full atomic acquire
instruction which cannot be used on unaligned addresses.

Fix it by avoiding READ_ONCE() in read_instrumented_memory(), and simply
forcing the compiler to do the required access by casting to the
appropriate volatile type. In terms of generated code this currently
only affects architectures that do not use the default READ_ONCE()
implementation.

The only downside is that we are not guaranteed atomicity of the access
itself, although on most architectures a plain load up to machine word
size should still be atomic (a fact the default READ_ONCE() still relies
on itself).

Reported-by: Haibo Li <haibo.li@mediatek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 54d077e1a2dc..5a60cc52adc0 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -337,11 +337,20 @@ static void delay_access(int type)
  */
 static __always_inline u64 read_instrumented_memory(const volatile void *ptr, size_t size)
 {
+	/*
+	 * In the below we don't necessarily need the read of the location to
+	 * be atomic, and we don't use READ_ONCE(), since all we need for race
+	 * detection is to observe 2 different values.
+	 *
+	 * Furthermore, on certain architectures (such as arm64), READ_ONCE()
+	 * may turn into more complex instructions than a plain load that cannot
+	 * do unaligned accesses.
+	 */
 	switch (size) {
-	case 1:  return READ_ONCE(*(const u8 *)ptr);
-	case 2:  return READ_ONCE(*(const u16 *)ptr);
-	case 4:  return READ_ONCE(*(const u32 *)ptr);
-	case 8:  return READ_ONCE(*(const u64 *)ptr);
+	case 1:  return *(const volatile u8 *)ptr;
+	case 2:  return *(const volatile u16 *)ptr;
+	case 4:  return *(const volatile u32 *)ptr;
+	case 8:  return *(const volatile u64 *)ptr;
 	default: return 0; /* Ignore; we do not diff the values. */
 	}
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

