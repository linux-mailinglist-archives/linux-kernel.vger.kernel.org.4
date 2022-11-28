Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB963A8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiK1NHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiK1NHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:07:52 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E84646F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:07:49 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NLQkC3Xxzz5BNS0;
        Mon, 28 Nov 2022 21:07:47 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2ASD7eKW005088;
        Mon, 28 Nov 2022 21:07:40 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 28 Nov 2022 21:07:43 +0800 (CST)
Date:   Mon, 28 Nov 2022 21:07:43 +0800 (CST)
X-Zmail-TransId: 2afa6384b29f33485def
X-Mailer: Zmail v1.0
Message-ID: <202211282107437343474@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <yuzhao@google.com>, <peterz@infradead.org>, <david@redhat.com>,
        <jgross@suse.com>, <tongtiangen@huawei.com>,
        <liushixin2@huawei.com>, <anshuman.khandual@arm.com>,
        <namit@vmware.com>, <kunyu@nfschina.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tOiByZW1vdmUgcmVkdW5kYW50IHB0ZSB2YXJpYWJsZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2ASD7eKW005088
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6384B2A3.000 by FangMail milter!
X-FangMail-Envelope: 1669640867/4NLQkC3Xxzz5BNS0/6384B2A3.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6384B2A3.000/4NLQkC3Xxzz5BNS0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Return value from ptep_get_and_clear_full() directly instead of taking
this in another redundant variable.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 include/linux/pgtable.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 576093de8b1c..1159b25b0542 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -456,9 +456,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
                                            unsigned long address, pte_t *ptep,
                                            int full)
 {
-       pte_t pte;
-       pte = ptep_get_and_clear(mm, address, ptep);
-       return pte;
+       return ptep_get_and_clear(mm, address, ptep);
 }
 #endif

--
2.15.2
