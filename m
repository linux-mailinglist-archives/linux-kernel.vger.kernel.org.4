Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFF64B088
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiLMHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:45:30 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA8ACB1D3;
        Mon, 12 Dec 2022 23:45:28 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 10F721E80D80;
        Tue, 13 Dec 2022 15:40:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FlQBb2iAncfU; Tue, 13 Dec 2022 15:40:47 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 440BA1E80D56;
        Tue, 13 Dec 2022 15:40:47 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, akpm@linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] kernel: smp: Remove unnecessary (void*) conversions
Date:   Tue, 13 Dec 2022 15:45:22 +0800
Message-Id: <20221213074522.3738-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The void * type pointer does not need to be cast and assigned to another
pointer.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 arch/alpha/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index f4e20f75438f..0ede4b044e86 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -628,7 +628,7 @@ flush_tlb_all(void)
 static void
 ipi_flush_tlb_mm(void *x)
 {
-	struct mm_struct *mm = (struct mm_struct *) x;
+	struct mm_struct *mm = x;
 	if (mm == current->active_mm && !asn_locked())
 		flush_tlb_current(mm);
 	else
@@ -670,7 +670,7 @@ struct flush_tlb_page_struct {
 static void
 ipi_flush_tlb_page(void *x)
 {
-	struct flush_tlb_page_struct *data = (struct flush_tlb_page_struct *)x;
+	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
 	if (mm == current->active_mm && !asn_locked())
-- 
2.18.2

