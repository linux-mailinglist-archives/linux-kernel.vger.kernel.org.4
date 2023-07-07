Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BBA74AAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGGGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGGQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:16:26 -0400
X-Greylist: delayed 660 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 23:16:24 PDT
Received: from chinatelecom.cn (smtpnm6-01.21cn.com [182.42.159.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 155C11737
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:16:23 -0700 (PDT)
HMM_SOURCE_IP: 192.168.137.232:16264.1587224530
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.137.232])
        by chinatelecom.cn (HERMES) with SMTP id C6CFC10013632;
        Fri,  7 Jul 2023 14:05:07 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
        by gateway-ssl-dep-d8bd95c49-j4mlb with ESMTP id c87cf4383e7346e3a79c67b0e0606676 for akpm@linux-foundation.org;
        Fri, 07 Jul 2023 14:05:17 CST
X-Transaction-ID: c87cf4383e7346e3a79c67b0e0606676
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From:   liuq <liuq131@chinatelecom.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuq <liuq131@chinatelecom.cn>
Subject: [PATCH] mm/sparse: remove redundant judgments from macro for_each_present_section_nr
Date:   Fri,  7 Jul 2023 14:05:01 +0800
Message-Id: <20230707060501.29184-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next_present_section_nr function has already ensured
that 'section_nr<=__highest_present_section_nr',
so this conditional judgment is removed.

Signed-off-by: liuq <liuq131@chinatelecom.cn>
---
 mm/sparse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 297a8b772e8d..77d91e565045 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -172,8 +172,7 @@ static void __section_mark_present(struct mem_section *ms,
 
 #define for_each_present_section_nr(start, section_nr)		\
 	for (section_nr = next_present_section_nr(start-1);	\
-	     ((section_nr != -1) &&				\
-	      (section_nr <= __highest_present_section_nr));	\
+	     section_nr != -1;								\
 	     section_nr = next_present_section_nr(section_nr))
 
 static inline unsigned long first_present_section_nr(void)
-- 
2.27.0

