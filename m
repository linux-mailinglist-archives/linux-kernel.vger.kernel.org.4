Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD471659404
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 02:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiL3BRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 20:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3BRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:17:35 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA51B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 17:17:34 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NjnRx3gb2z501Qn;
        Fri, 30 Dec 2022 09:17:33 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 2BU1HRq8060335;
        Fri, 30 Dec 2022 09:17:27 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 30 Dec 2022 09:17:28 +0800 (CST)
Date:   Fri, 30 Dec 2022 09:17:28 +0800 (CST)
X-Zmail-TransId: 2b0363ae3c28ffffffffc3ec2cb7
X-Mailer: Zmail v1.0
Message-ID: <202212300917284911971@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY1IDUvNl0ga3NtOiBhZGQgemVyb19wYWdlc19zaGFyaW5nIGRvY3VtZW50YXRpb24=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BU1HRq8060335
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63AE3C2D.000 by FangMail milter!
X-FangMail-Envelope: 1672363053/4NjnRx3gb2z501Qn/63AE3C2D.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AE3C2D.000/4NjnRx3gb2z501Qn
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When enabling use_zero_pages, pages_sharing cannot represent how
much memory saved indeed. zero_pages_sharing + pages_sharing does.
add the description of zero_pages_sharing.

Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index fb6ba2002a4b..f160f9487a90 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -173,6 +173,13 @@ stable_node_chains
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
         number of duplicated KSM pages
+zero_pages_sharing
+        how many empty pages are sharing kernel zero page(s) instead of
+        with each other as it would happen normally. Only effective when
+        enabling ``use_zero_pages`` knob.
+
+When enabling ``use_zero_pages``, the sum of ``pages_sharing`` +
+``zero_pages_sharing`` represents how much really saved by KSM.

 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
-- 
2.15.2
