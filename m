Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47A6B89E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCNEui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCNEuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:50:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39523DAB;
        Mon, 13 Mar 2023 21:50:29 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbLgB13VbzKmyT;
        Tue, 14 Mar 2023 12:50:14 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 12:50:26 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output
Date:   Tue, 14 Mar 2023 04:47:35 +0000
Message-ID: <20230314044735.56551-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzkaller reportes a KASAN issue with stack-out-of-bounds.
The call trace is as follows:
  dump_stack+0x9c/0xd3
  print_address_description.constprop.0+0x19/0x170
  __kasan_report.cold+0x6c/0x84
  kasan_report+0x3a/0x50
  __perf_event_header__init_id+0x34/0x290
  perf_event_header__init_id+0x48/0x60
  perf_output_begin+0x4a4/0x560
  perf_event_bpf_output+0x161/0x1e0
  perf_iterate_sb_cpu+0x29e/0x340
  perf_iterate_sb+0x4c/0xc0
  perf_event_bpf_event+0x194/0x2c0
  __bpf_prog_put.constprop.0+0x55/0xf0
  __cls_bpf_delete_prog+0xea/0x120 [cls_bpf]
  cls_bpf_delete_prog_work+0x1c/0x30 [cls_bpf]
  process_one_work+0x3c2/0x730
  worker_thread+0x93/0x650
  kthread+0x1b8/0x210
  ret_from_fork+0x1f/0x30

commit 267fb27352b6 ("perf: Reduce stack usage of perf_output_begin()")
use on-stack struct perf_sample_data of the caller function.

However, perf_event_bpf_output uses incorrect parameter to convert
small-sized data (struct perf_bpf_event) into large-sized data
(struct perf_sample_data), which causes memory overwriting occurs in
__perf_event_header__init_id.

Fixes: 267fb27352b6 ("perf: Reduce stack usage of perf_output_begin()")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..296617edbda1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9187,7 +9187,7 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&bpf_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, data, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				bpf_event->event_id.header.size);
 	if (ret)
 		return;
-- 
2.30.GIT

