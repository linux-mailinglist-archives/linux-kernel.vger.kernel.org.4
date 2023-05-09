Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258226FBF4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjEIGiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjEIGiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:38:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7BDAD25;
        Mon,  8 May 2023 23:38:19 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QFpLm0cZLzLpd7;
        Tue,  9 May 2023 14:35:28 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 14:38:17 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf bpf skels: vmlinux.h uses bpf.h and perf_event.h in the source directory
Date:   Tue, 9 May 2023 06:36:49 +0000
Message-ID: <20230509063649.239942-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vmlinux.h uses the bpf.h and perf_event.h header files in the
system path. If the header files in compilation environment are old,
compilation may fail. For example:

  /home/yangjihong/linux/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:151:27: error: field has incomplete type 'union perf_sample_weight'
          union perf_sample_weight weight;

Use the bpf.h and perf_event.h files in the source code directory to
avoid compilation compatibility problems.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/bpf_skel/vmlinux.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux.h
index 449b1ea91fc4..af79bcc4c4b7 100644
--- a/tools/perf/util/bpf_skel/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux.h
@@ -1,11 +1,13 @@
 #ifndef __VMLINUX_H
 #define __VMLINUX_H
 
-#include <linux/bpf.h>
 #include <linux/types.h>
-#include <linux/perf_event.h>
 #include <stdbool.h>
 
+// Use header files in source directory to avoid compilation compatibility problems.
+#include "../../../include/uapi/linux/perf_event.h"
+#include "../../../include/uapi/linux/bpf.h"
+
 // non-UAPI kernel data structures, used in the .bpf.c BPF tool component.
 
 // Just the fields used in these tools preserving the access index so that
-- 
2.30.GIT

