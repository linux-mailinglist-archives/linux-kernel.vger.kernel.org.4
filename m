Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D271A697421
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBOCIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBOCIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B2E29E08
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676426852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RMCmkhFCPXrDhMTsi/I6uPUq167ZjtWxYObHzGUXvz8=;
        b=MXxk8CVHXS8rLWknElHMhZCDQ+Ah+VYYLfSAsKjtO5/6c7Dy7WKHefw1BrpvxsHDEyY6iJ
        dGRRpLuKMbCCKmPKrXc7nmuf9tXbs/n4MLf7mmH5rK6NoF3jNEqfUYsc359VUYwQAQBfaj
        PFAg+5SOqCA0ZJzFM+buzwR0HB/RS98=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-vS0kIW32OS6Bmui6CYPR4Q-1; Tue, 14 Feb 2023 21:07:30 -0500
X-MC-Unique: vS0kIW32OS6Bmui6CYPR4Q-1
Received: by mail-pf1-f200.google.com with SMTP id z14-20020a056a00240e00b0059395f5a701so8932605pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMCmkhFCPXrDhMTsi/I6uPUq167ZjtWxYObHzGUXvz8=;
        b=M6Ps7zbZfmYUIBY9z6C7+wzFIxgm0TNXrFTQvH0jUiaiPlUilojhrsL/i+gUoXOrIV
         zne0y2zUtBXriwxrlR4cFxWoxtMpWMBXxXWVHUlFJDA4Enaq1qFoXM9i2HTWY3IFsYVn
         1wccZrVX7BVmNjMexazbM6GHhXzOajrMpD0Qix7mYKbYARzQKQZJhWlk9SEfsMwQvCOo
         SF9KnWmB2JKaW3rWXOVEqIpRmcNHI3XjQPXoVUy7vbJP2McWRwshbwB2FYUmyt/qmslU
         YJvmabbk+AXNGipiS2sTlrvNbgtZRHTqaPLgS6xFioUo573s4yBDWOWKHfz1Wnut1jQs
         Ls8A==
X-Gm-Message-State: AO0yUKWgVqLnz+DaNoLb3AvOM/h+uhdphub8lW2IqxLXcBfZO5rs93B0
        N8MPvCFAP2fI9XqlVgus80ypOnxcrXTSOStw7U2Ri62O2KpTcxuOSqq+2BJYGOp91AYk/ZgCG6A
        U6lIi2n0fiO30S5Wz9qqxSj6boZf+Wpb47rc=
X-Received: by 2002:a62:1586:0:b0:5a8:ae6b:bdb0 with SMTP id 128-20020a621586000000b005a8ae6bbdb0mr198615pfv.33.1676426849339;
        Tue, 14 Feb 2023 18:07:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+t97phZ5edl0hsPYHsYdlkhQfFlbgee026VAQw20WChmy3wfeMIHNRcB2t3MFNc8FjMpUCLQ==
X-Received: by 2002:a62:1586:0:b0:5a8:ae6b:bdb0 with SMTP id 128-20020a621586000000b005a8ae6bbdb0mr198603pfv.33.1676426848964;
        Tue, 14 Feb 2023 18:07:28 -0800 (PST)
Received: from [10.72.12.170] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a6-20020aa780c6000000b005a8f1187112sm392924pfn.58.2023.02.14.18.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 18:07:28 -0800 (PST)
Message-ID: <768be93b-a401-deab-600c-f946e0bd27fa@redhat.com>
Date:   Wed, 15 Feb 2023 10:07:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Subject: cgroup: deadlock between cpu_hotplug_lock and freezer_mutex
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Recently when running some test cases for ceph we hit the following 
deadlock issue in cgroup code. Has this been fixed ? I have checked the 
latest code and it seems no any commit is fixing this.

This call trace could also be found in 
https://tracker.ceph.com/issues/58564#note-4, which is more friendly to 
read.

  ======================================================
  WARNING: possible circular locking dependency detected
  6.1.0-rc5-ceph-gc90f64b588ff #1 Tainted: G S
  ------------------------------------------------------
  runc/90769 is trying to acquire lock:
  ffffffff82664cb0 (cpu_hotplug_lock){++++}-{0:0}, at: 
static_key_slow_inc+0xe/0x20
  #012but task is already holding lock:
  ffffffff8276e468 (freezer_mutex){+.+.}-{3:3}, at: freezer_write+0x89/0x530
  #012which lock already depends on the new lock.
  #012the existing dependency chain (in reverse order) is:
  #012-> #2 (freezer_mutex){+.+.}-{3:3}:
        __mutex_lock+0x9c/0xf20
        freezer_attach+0x2c/0xf0
        cgroup_migrate_execute+0x3f3/0x4c0
        cgroup_attach_task+0x22e/0x3e0
        __cgroup1_procs_write.constprop.12+0xfb/0x140
        cgroup_file_write+0x91/0x230
        kernfs_fop_write_iter+0x137/0x1d0
        vfs_write+0x344/0x4d0
        ksys_write+0x5c/0xd0
        do_syscall_64+0x34/0x80
        entry_SYSCALL_64_after_hwframe+0x63/0xcd
  #012-> #1 (cgroup_threadgroup_rwsem){++++}-{0:0}:
        percpu_down_write+0x45/0x2c0
        cgroup_procs_write_start+0x84/0x270
        __cgroup1_procs_write.constprop.12+0x57/0x140
        cgroup_file_write+0x91/0x230
        kernfs_fop_write_iter+0x137/0x1d0
        vfs_write+0x344/0x4d0
        ksys_write+0x5c/0xd0
        do_syscall_64+0x34/0x80
        entry_SYSCALL_64_after_hwframe+0x63/0xcd
  #012-> #0 (cpu_hotplug_lock){++++}-{0:0}:
        __lock_acquire+0x103f/0x1de0
        lock_acquire+0xd4/0x2f0
        cpus_read_lock+0x3c/0xd0
        static_key_slow_inc+0xe/0x20
        freezer_apply_state+0x98/0xb0
        freezer_write+0x307/0x530
        cgroup_file_write+0x91/0x230
        kernfs_fop_write_iter+0x137/0x1d0
        vfs_write+0x344/0x4d0
        ksys_write+0x5c/0xd0
        do_syscall_64+0x34/0x80
        entry_SYSCALL_64_after_hwframe+0x63/0xcd
  #012other info that might help us debug this:
  Chain exists of:#012  cpu_hotplug_lock --> cgroup_threadgroup_rwsem 
--> freezer_mutex
  Possible unsafe locking scenario:
        CPU0                    CPU1
        ----                    ----
   lock(freezer_mutex);
                                lock(cgroup_threadgroup_rwsem);
                                lock(freezer_mutex);
   lock(cpu_hotplug_lock);
  #012 *** DEADLOCK ***
  5 locks held by runc/90769:
  #0: ffff88810bd064e8 (&f->f_pos_lock){+.+.}-{3:3}, at: 
__fdget_pos+0x44/0x50
  #1: ffff88817f828448 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0x5c/0xd0
  #2: ffff888104cf5688 (&of->mutex){+.+.}-{3:3}, at: 
kernfs_fop_write_iter+0x104/0x1d0
  #3: ffff888107f885f0 (kn->active#170){.+.+}-{0:0}, at: 
kernfs_fop_write_iter+0x10d/0x1d0
  #4: ffffffff8276e468 (freezer_mutex){+.+.}-{3:3}, at: 
freezer_write+0x89/0x530
  #012stack backtrace:
  CPU: 3 PID: 90769 Comm: runc Tainted: G S 6.1.0-rc5-ceph-gc90f64b588ff #1
  Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015
  Call Trace:
  <TASK>
  dump_stack_lvl+0x55/0x6d
  check_noncircular+0xfe/0x110
  ? __lock_acquire+0xec6/0x1de0
  __lock_acquire+0x103f/0x1de0
  lock_acquire+0xd4/0x2f0
  ? static_key_slow_inc+0xe/0x20
  ? freezer_write+0x1c6/0x530
  cpus_read_lock+0x3c/0xd0
  ? static_key_slow_inc+0xe/0x20
  static_key_slow_inc+0xe/0x20
  freezer_apply_state+0x98/0xb0
  freezer_write+0x307/0x530
  cgroup_file_write+0x91/0x230
  kernfs_fop_write_iter+0x137/0x1d0
  vfs_write+0x344/0x4d0
  ksys_write+0x5c/0xd0
  do_syscall_64+0x34/0x80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x558e89efab9b
  Code: e8 8a 2e fb ff eb 88 cc cc cc cc cc cc cc cc e8 7b 74 fb ff 48 
8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 
01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
  RSP: 002b:000000c00019c010 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 000000c000031000 RCX: 0000558e89efab9b
  RDX: 0000000000000006 RSI: 000000c00019c1c8 RDI: 000000000000000d
  RBP: 000000c00019c060 R08: 0000000000000001 R09: 000000c00028ed20
  R10: 0000000000000006 R11: 0000000000000202 R12: 000000c00019c0f0
  R13: 0000000000000000 R14: 000000c0000001a0 R15: 00007f38d2e1476c
  </TASK>

Thanks

-- 
Best Regards,

Xiubo Li (李秀波)

Email: xiubli@redhat.com/xiubli@ibm.com
Slack: @Xiubo Li

