Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4170BB92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjEVLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjEVLQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:16:34 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB9269E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:11:08 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id 664B9E1EF3; Mon, 22 May 2023 18:53:36 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
Subject: [PATCH v8 4/6] ksm: add documentation for ksm zero pages
Date:   Mon, 22 May 2023 18:53:35 +0800
Message-Id: <20230522105335.4176-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202305221842587200002@zte.com.cn>
References: <202305221842587200002@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add the description of ksm_zero_pages.

When use_zero_pages is enabled, pages_sharing cannot represent how
much memory saved actually by KSM, but the sum of ksm_zero_pages +
pages_sharing does.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/ksm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 7626392fe82c..019dc40a0d3c 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -173,6 +173,14 @@ stable_node_chains
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
         number of duplicated KSM pages
+ksm_zero_pages
+        how many empty pages are sharing the kernel zero page(s) instead
+        of other user pages as it would happen normally. Only meaningful
+        when ``use_zero_pages`` is/was enabled.
+
+When ``use_zero_pages`` is/was enabled, the sum of ``pages_sharing`` +
+``ksm_zero_pages`` represents the actual number of pages saved by KSM.
+if ``use_zero_pages`` has never been enabled, ``ksm_zero_pages`` is 0.
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
-- 
2.15.2
