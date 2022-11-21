Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF34631DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKUKGa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKUKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:06:23 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 02:06:20 PST
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 905228FB06
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:20 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="38178246"
Received: from hk-mbx13.mioffice.cn (HELO xiaomi.com) ([10.56.21.123])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 21 Nov 2022 18:05:16 +0800
Received: from BJ-MBX04.mioffice.cn (10.237.8.124) by HK-MBX13.mioffice.cn
 (10.56.21.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 18:05:15 +0800
Received: from mi-OptiPlex-7060.mioffice.cn (10.237.8.11) by
 BJ-MBX04.mioffice.cn (10.237.8.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 18:05:14 +0800
From:   <wangbiao3@xiaomi.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <brauner@kernel.org>, <bsegall@google.com>
CC:     <linux-kernel@vger.kernel.org>, <wangbiao3@xiaomi.com>,
        <wenjieli@qti.qualcomm.com>, <chenguanyou@xiaomi.com>
Subject: [PATCH 0/1] sched: fix user_mask double free
Date:   Mon, 21 Nov 2022 18:04:19 +0800
Message-ID: <cover.1669020858.git.wangbiao3@xiaomi.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.237.8.11]
X-ClientProxiedBy: BJ-MBX10.mioffice.cn (10.237.8.130) To BJ-MBX04.mioffice.cn
 (10.237.8.124)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_SOFTFAIL,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangbiao3 <wangbiao3@xiaomi.com>

    Clone/Fork a new task,call dup_task_struct->arch_dup_task_struct(tsk,orig)
    which copy the data of parent/sibling task inclding p->user_cpus_ptr,so
    the user_cpus_ptr of newtask is the same with orig task's.When
    dup_task_struct call dup_user_cpus_ptr(tsk, orig, node),it return 0
    dircetly if src->user_cpus_ptris free by other task,in this case ,
    the newtask's address of user_cpus_ptr is not changed. Finally,
    wakup newtask to execute, call task_cpu_possible_mask-->
    do_set_cpus_allowed to set new task's user_cpus_ptr(user_mask) which
    call kfree user_mask at the end. So cause a slub double free panic.

    Use pi_lock to protect content of user_cpus_ptr in dup_user_cpus_ptr and
    clear dst->user_cpus_ptr when found src->user_cpus_ptr is null

    kernel BUG at mm/slub.c:363!
    Call trace:
     __slab_free+0x230/0x28c
     kfree+0x220/0x2cc
     do_set_cpus_allowed+0x74/0xa4
     select_fallback_rq+0x12c/0x200
     wake_up_new_task+0x26c/0x304
     kernel_clone+0x2c0/0x470
     __arm64_sys_clone+0x5c/0x8c
     invoke_syscall+0x60/0x150
     el0_svc_common.llvm.13030543509303927816+0x98/0x114
     do_el0_svc_compat+0x20/0x30
     el0_svc_compat+0x28/0x90
     el0t_32_sync_handler+0x7c/0xbc
     el0t_32_sync+0x1b8/0x1bc


wangbiao3 (1):
  sched: fix user_mask double free

 kernel/sched/core.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--
2.38.1

#/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
