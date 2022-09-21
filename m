Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649FA5BFEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiIUNXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIUNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E230A9351B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663766599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gAmZ3Aq0yQw/itkslHGF953uDDwcJAEu2PS67so2ayg=;
        b=KvnfTTQOkTB1BEgeRbpaYOyMIEXMv21aEE6sqTjiLNfYwBIIJZNwyEdINJpNfM4C7BjISh
        BLOxfjDJWU4TX+DO3moo47cXFFx3+tGz3kra+lsCNTphVx+FSReeuPgBs+e6z86syYtcy4
        l8Tign53lXJ15G7afD41degRTAy9VJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-zpCnSiHbOrumJIKuPmaWSg-1; Wed, 21 Sep 2022 09:23:15 -0400
X-MC-Unique: zpCnSiHbOrumJIKuPmaWSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51EED85530E;
        Wed, 21 Sep 2022 13:23:15 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E96239DB3;
        Wed, 21 Sep 2022 13:23:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] locking, tracing: Fix incorrect use of arch_spin_lock()
Date:   Wed, 21 Sep 2022 09:21:50 -0400
Message-Id: <20220921132152.1622616-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is found that running the LTP read_all_proc test may cause the
following warning to show up:

[12512.905036] BUG: using smp_processor_id() in preemptible [00000000] code: read_all/133711
[12512.913499] caller is __pv_queued_spin_lock_slowpath+0x7f/0xd30
[12512.921163] CPU: 3 PID: 133711 Comm: read_all Kdump: loaded Tainted: G           OE    --------- ---  5.14.0-163.el9.x86_64+debug #1
[12512.936652] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[12512.944213] Call Trace:
[12512.950660]  dump_stack_lvl+0x57/0x81
[12512.957400]  check_preemption_disabled+0xcc/0xd0
[12512.964487]  __pv_queued_spin_lock_slowpath+0x7f/0xd30
[12512.971552]  ? pv_hash+0x110/0x110
[12512.978119]  ? __lock_acquire+0xb72/0x1870
[12512.984683]  tracing_saved_cmdlines_size_read+0x177/0x190
[12512.991655]  ? saved_cmdlines_start+0x2c0/0x2c0
[12512.998355]  ? inode_security+0x54/0xf0
[12513.004548]  ? selinux_file_permission+0x324/0x420
[12513.011185]  ? lock_downgrade+0x130/0x130
[12513.017423]  ? fsnotify_perm.part.0+0x14a/0x4c0
[12513.023715]  vfs_read+0x126/0x4d0
[12513.029432]  ksys_read+0xf9/0x1d0
[12513.035131]  ? __ia32_sys_pwrite64+0x1e0/0x1e0
[12513.041028]  ? ktime_get_coarse_real_ts64+0x130/0x170
[12513.047167]  do_syscall_64+0x59/0x90
[12513.052656]  ? lockdep_hardirqs_on+0x79/0x100
[12513.058268]  ? do_syscall_64+0x69/0x90
[12513.063593]  ? lockdep_hardirqs_on+0x79/0x100
[12513.069022]  ? do_syscall_64+0x69/0x90
[12513.074137]  ? lockdep_hardirqs_on+0x79/0x100
[12513.079533]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[12513.085015] RIP: 0033:0x7f93f09d38c2

So tracing_saved_cmdlines_size_read() does call arch_spin_lock() with
preemption enabled. Looking at other arch_spin_lock() call sites in
kernel/trace/trace.c, there are several others that may have the same
problem. Other arch_spin_lock() callers under kernel look OK as
irqs has been disabled before calling arch_spin_lock().

Add a do_arch_spin_lock() helper that disables preemption and make
kernel/trace/trace.c use it if it is not obvious that either preemption
or interrupt has been disabled.

Waiman Long (2):
  locking: Provide a low overhead do_arch_spin_lock() API
  tracing: Use proper do_arch_spin_lock() API

 include/linux/spinlock.h | 27 +++++++++++++++++++++
 kernel/trace/trace.c     | 52 +++++++++++++++++++---------------------
 2 files changed, 51 insertions(+), 28 deletions(-)

-- 
2.31.1

