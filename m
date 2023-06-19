Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0662C7359B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFSOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjFSOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:35:24 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4091E68
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:35:23 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1414A5FD2B;
        Mon, 19 Jun 2023 17:35:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687185322;
        bh=qkAqgOog0Wha6onJcOVZ2iYFUcpXYVWLhgQSsgfFkw4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=GNCjOeK5MQU0348wIlewlcv613AtqJhNNSR65PSAxd0fr3yMAFVaif/CzC5MS89Ig
         rAyfaJDZFQHIJ08+ai3QfHdodwvBgRTvG855/E++P2pk34UUolUo+RC+/PXROUglgR
         94C+Si/SBq/v7U07AFOu2RPyaLQZdU9GmxB0UsaYErJQ1Mvs+HMnttTVp5dYThztF/
         4C7uhBf/KWbEHShCHr46ZVZsi3aJ7cnQYTXYwmD7Vv1hBTfHSjPtx8f2gHbduiov/d
         64KjILGGak+q3gocUSI5H9g0MIzsqaPh/XSLwHFa+3qzRsgItIKI5YYMLrYWEAaOO/
         dbsxnA3i1AVNA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 19 Jun 2023 17:35:22 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 2/2] zsmalloc: check empty page in find_alloced_obj
Date:   Mon, 19 Jun 2023 17:35:06 +0300
Message-ID: <20230619143506.45253-3-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230619143506.45253-1-avromanov@sberdevices.ru>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/19 10:56:00 #21523989
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes no sense to search for an allocated object
if there are none on the page. Using this check, we
get rid of the extra kmap_atomic, as well as the search
for a tagged object. On my synthetic test data, this
change speed up zsmalloc compaction time by up to 10%.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index dd6e2c3429e0..d0ce579dcde5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1764,6 +1764,9 @@ static unsigned long find_tagged_obj(struct size_class *class,
 static unsigned long find_alloced_obj(struct size_class *class,
 					struct page *page, int *obj_idx)
 {
+	if (!get_obj_allocated(page))
+		return 0;
+
 	return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
 }
 
-- 
2.38.1

