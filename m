Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16AC711F21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbjEZFQQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 01:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZFQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:16:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADE187
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:11 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKnwNZ009618
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:10 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt3t6q3mp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:16:10 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 22:16:07 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 60E301E38AFE6; Thu, 25 May 2023 22:15:53 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <mcgrof@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <x86@kernel.org>, <rppt@kernel.org>,
        <kent.overstreet@linux.dev>, Song Liu <song@kernel.org>
Subject: [PATCH 0/3] Type aware module allocator
Date:   Thu, 25 May 2023 22:15:26 -0700
Message-ID: <20230526051529.3387103-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7VxM5-OhACkQs5pdd26HVY8ObZNuINL-
X-Proofpoint-GUID: 7VxM5-OhACkQs5pdd26HVY8ObZNuINL-
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set implements the second part of module type aware allocator
(module_alloc_type), which was discussed in [1]. This part contains the
interface of the new allocator, as well as changes in x86 code to use the
new allocator (modules, BPF, ftrace, kprobe).

The set does not contain a binpack allocator to enable sharing huge pages
among different allocations. But this set defines the interface used by
the binpack allocator. [2] has some discussion on different options of the
binpack allocator.

[1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/
[2] https://lore.kernel.org/all/20230308094106.227365-1-rppt@kernel.org/

Song Liu (3):
  module: Introduce module_alloc_type
  ftrace: Add swap_func to ftrace_process_locs()
  x86/module: Use module_alloc_type

 arch/x86/kernel/alternative.c  |  37 ++++--
 arch/x86/kernel/ftrace.c       |  44 ++++---
 arch/x86/kernel/kprobes/core.c |   8 +-
 arch/x86/kernel/module.c       | 114 +++++++++++------
 arch/x86/kernel/unwind_orc.c   |  13 +-
 arch/x86/net/bpf_jit_comp.c    |  22 +++-
 include/linux/ftrace.h         |   2 +
 include/linux/module.h         |   6 +
 include/linux/moduleloader.h   |  75 ++++++++++++
 init/main.c                    |   1 +
 kernel/bpf/bpf_struct_ops.c    |  10 +-
 kernel/bpf/core.c              |  26 ++--
 kernel/bpf/trampoline.c        |   6 +-
 kernel/kprobes.c               |   6 +-
 kernel/module/internal.h       |   3 +
 kernel/module/main.c           | 217 +++++++++++++++++++++++++++++++--
 kernel/module/strict_rwx.c     |   4 +
 kernel/trace/ftrace.c          |  13 +-
 18 files changed, 493 insertions(+), 114 deletions(-)

--
2.34.1
