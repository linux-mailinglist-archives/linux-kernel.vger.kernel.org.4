Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125A6E1CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjDNHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:14:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053C3C07;
        Fri, 14 Apr 2023 00:14:08 -0700 (PDT)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PySMD1ctQzrbgs;
        Fri, 14 Apr 2023 15:12:40 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 15:14:05 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] ring-buffer: Clearly check null ptr returned by rb_set_head_page()
Date:   Fri, 14 Apr 2023 15:17:29 +0800
Message-ID: <20230414071729.57312-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error case, 'buffer_page' returned by rb_set_head_page() is NULL,
currently check '&buffer_page->list' is equivalent to check 'buffer_page'
due to 'list' is the first member of 'buffer_page', but suppose it is not
some time, 'head_page' would be wild memory while check would be bypassed.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 76a2d91eecad..025324df1f96 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2060,10 +2060,11 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 		struct list_head *head_page, *prev_page, *r;
 		struct list_head *last_page, *first_page;
 		struct list_head *head_page_with_bit;
+		struct buffer_page *hpage = rb_set_head_page(cpu_buffer);
 
-		head_page = &rb_set_head_page(cpu_buffer)->list;
-		if (!head_page)
+		if (!hpage)
 			break;
+		head_page = &hpage->list;
 		prev_page = head_page->prev;
 
 		first_page = pages->next;
-- 
2.25.1

