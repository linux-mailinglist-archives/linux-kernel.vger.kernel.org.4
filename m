Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD073160A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbjFOLEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjFOLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:04:33 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2640B271F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:04:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25e78cf986dso770794a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686827071; x=1689419071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOL5SMkV7WpEvt21ZSPSbSICTEtkyFVJT2+TE/j3rDs=;
        b=U7XyevQxaW0tBj0uhtpOyOMo0IvE1AGimjFOAwCzVDD4bQ0sw9Ja3r2FYVLXZcLOxF
         K7Hl7mm8/4xAS7MHVJK8ir3zbdL7PT4HlY7Z96z6ox/QOGoFXBrdU0ig4rWmYZPYTlph
         zwDztfwOMvrFQko2hmchQwiz/MC7dtEZqkkS9uBYiXhVaz+82fvtYYnIHYchuS7SWluO
         Rt1O2eLRVlr8ldrwKokxxGbAOBt86rUVNGQnXJk8E+NLVjQUhN/jTSN4F4J2a7y5CEQz
         CiY9scv8RNtdjrdI1vx3Fv8F77UYDpcZBFDbh4ldcNVG6ecf1NuYDE/ZRAGd7mIW0Q/3
         2sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686827071; x=1689419071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOL5SMkV7WpEvt21ZSPSbSICTEtkyFVJT2+TE/j3rDs=;
        b=HfTf3a/P+ZAymJvB0a2D42TxJ3ds1JVtSY62lhCvVZaK1WDAdtivwYMjqt2e1us2C7
         KaKCjUxVVzXNZ1kKu527bbF2mEdXa8byEl62+2tpOyxDV5sMMqY5JcbKy5Hg8hH3kXXV
         kJUfZwROHB7LnRedQx2/Hh+kScu/5+2kFz8Mjem3zR2Kz1J3GcZxI3XEzr3urLeD+Y7U
         PkvcIP9Dbdtk/Lkc0RF7TR526z3QlsEX/vRMn636z+M9+6B802Eagq0ADGWbXZtGuC5N
         WZpx9F9ElYsdstkO455wuG5irOa3aAHczUP7bHiAewnlj/5I0x5jsEdZzwwaOdA0dnFh
         cq/A==
X-Gm-Message-State: AC+VfDxbKedWvUBssb1Np2PcrpznDt/rhtaRYXhSsRAIXeyDfguMJ2Qf
        XenKXQlHSgNIYPmvnMslnpusNKbZnsM1IQ==
X-Google-Smtp-Source: ACHHUZ7VRCia8nAtQ4IhGzeDcl4fwIeQcPE35++aU9XPqBNRmbtnkinTV3qY5kvF0hKpPnf7h+tHHWMGnYyk/A==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:6391:b0:259:c0b7:79d7 with SMTP
 id f17-20020a17090a639100b00259c0b779d7mr688136pjj.7.1686827071465; Thu, 15
 Jun 2023 04:04:31 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:04:29 +0000
In-Reply-To: <20230614112625.GN7912@redhat.com>
Mime-Version: 1.0
References: <20230614112625.GN7912@redhat.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230615110429.2839058-1-zhuyifei@google.com>
Subject: Re: printk.time causes rare kernel boot hangs
From:   YiFei Zhu <zhuyifei@google.com>
To:     rjones@redhat.com
Cc:     dev@aaront.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        zhuyifei1999@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW attached is a test program that runs the qemu instances in
> parallel (up to 8 threads), which seems to be a quicker way to hit the
> problem for me.  Even on Intel, with this test I can hit the bug in a
> few hundred iteration.

A friend sent me here so I took a look.

I was unable to reproduce with this script after 10000 iterations,
on a AMD Gentoo Linux host:

Host kernel:  6.3.3 vanilla
Guest kernel: git commit f31dcb152a3d0816e2f1deab4e64572336da197d
Guest config: Provided full-fat Fedora config + CONFIG_GDB_SCRIPTS
QEMU:         8.0.2 (with kvm_amd)
Hardware:     AMD Ryzen 7 PRO 5850U

I wonder if anything on the host side affects this, or could be some
sort of race condition.

> So is sleeping in kernel_init_freeable valid?  It seems as if it
> wouldn't be an atomic context.  And is the fact that the failure looks
> precisely the same coincidence?

I did a quick test on this and was able to reproduce. Attaching gdb
shows the CPU is idling in:
default_idle -> arch_safe_halt -> pv_native_safe_halt

By booting with an additional "idle=poll" and using gdb to invoke
"p show_state_filter(0)", I was able to dump the stack of kernel_init
at PID 1 (this is before it execve userspace init):

  [    0.322736] task:swapper/0       state:D stack:0     pid:1     ppid:0      flags:0x00004000
  [    0.322736] Call Trace:
  [    0.322736]  <TASK>
  [    0.322736]  __schedule+0x3eb/0x14c0
  [    0.322736]  schedule+0x5e/0xd0
  [    0.322736]  schedule_timeout+0x98/0x160
  [    0.322736]  ? __pfx_process_timeout+0x10/0x10
  [    0.322736]  msleep+0x2d/0x40
  [    0.322736]  kernel_init_freeable+0x1f7/0x490
  [    0.322736]  ? __pfx_kernel_init+0x10/0x10
  [    0.322736]  kernel_init+0x1a/0x1c0
  [    0.322736]  ret_from_fork+0x2c/0x50
  [    0.322736]  </TASK>

It does not appear that msleep work at this stage. Also interestingly,
the printk timer shown does not reflect the time spent idling (a few
seconds), and shows the exact timestamp as:

  [    0.322736] Freeing SMP alternatives memory: 48K

I'm not exactly sure where msleep would start working. If it's just timers
then "init_timers" has already run my PID 0 at this point I believe.

I also tested a busy delay via:

diff --git a/init/main.c b/init/main.c
index bb87b789c543..f6d722917388 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1616,6 +1616,7 @@ static noinline void __init kernel_init_freeable(void)

 	cad_pid = get_pid(task_pid(current));

+	for (volatile long i = 0; i < 0x100000000ULL; i++);
 	smp_prepare_cpus(setup_max_cpus);

 	workqueue_init();

The kernel does boot and panic (due to lack of rootfs), taking around two
seconds longer. The dmesg printed still does not reflect that there was a
busy wait.

If you can reproduce the original bug (without the msleep or busy wait
patch), could you check if you can reproduce that with idle=poll? If so,
can you run "p show_state_filter(0)" so we get a stack trace of kernel_init,
assuming it hit a similar issue as if msleep was added. If idle=poll does
not work, or you can't call functions from within gdb (some old qemu versions
did not support this), see if you can send a alt-sysrq-w to show stacks of
blocked tasks.

YiFei Zhu
