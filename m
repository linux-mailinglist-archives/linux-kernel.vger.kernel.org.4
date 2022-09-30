Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAC5F02BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiI3CYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3CYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:24:47 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585D20184
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:24:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VR.tpaw_1664504677;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VR.tpaw_1664504677)
          by smtp.aliyun-inc.com;
          Fri, 30 Sep 2022 10:24:39 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     namit@vmware.com
Cc:     rdunlap@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        peterz@infradead.org, hpa@zytor.com, jroedel@suse.de,
        xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/mm/tlb: update some comments in pte_flags_need_flush
Date:   Fri, 30 Sep 2022 10:24:34 +0800
Message-Id: <20220930022434.51850-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There just changed the comment about 'flush_on_clear' check, which make
the explanation more reasonable.

Suggested-by: Nadav Amit <namit@vmware.com>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---

Changes from v2
(https://lore.kernel.org/lkml/20220929091040.45390-1-xhao@linux.alibaba.com/)
- fix some comments suggested-by Nadav Amit <namit@vmware.com> and
Randy Dunlap <rdunlap@infradead.org>

 arch/x86/include/asm/tlbflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..2a17698fb194 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -291,8 +291,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 		diff &= ~_PAGE_ACCESSED;

 	/*
-	 * Did any of the 'flush_on_clear' flags was clleared set from between
-	 * 'oldflags' and 'newflags'?
+	 * Consider the 'flush_on_clear' flags that are set on 'oldflags',
+	 * Flush if any of these flags is cleared on 'newflags'.
 	 */
 	if (diff & oldflags & flush_on_clear)
 		return true;
--
2.31.0
