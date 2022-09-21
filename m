Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D95E5362
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiIUSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiIUSwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E845A1D32
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 576DB62D37
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2785BC4314A;
        Wed, 21 Sep 2022 18:52:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CI7BvgLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663786359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zSq4SOzJNqbi4MDYH6SNjZYv9uMDpNSoVaymUl1nOfg=;
        b=CI7BvgLg348OycfIDznk8YA7jLrNvp/WJDUkJwGVVBjsz4S1B2qPJx4SBnFvea2qJpcWUZ
        dO0dZCgrpTW44ahk/gWGHhQA/Ay5RHvCjatidBnjKF7fZ80DB2brgDz9zZ63Kitr5YToV0
        HnAIu5e6qISatrrtrRHWlIRfpMQ74I4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6de866c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 21 Sep 2022 18:52:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/2] m68k: process bootinfo records before saving them
Date:   Wed, 21 Sep 2022 20:52:07 +0200
Message-Id: <20220921185208.3549140-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RNG seed boot record is memzeroed after processing, in order to
preserve forward secrecy. By saving the bootinfo for procfs prior to
that, forward secrecy is violated, since it becomes possible to recover
past states. So, save the bootinfo block only after first processing
them.

Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/m68k/kernel/setup_mm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index e62fa8f2149b..7e7ef67cff8b 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -109,10 +109,9 @@ extern void paging_init(void);
 
 static void __init m68k_parse_bootinfo(const struct bi_record *record)
 {
+	const struct bi_record *first_record = record;
 	uint16_t tag;
 
-	save_bootinfo(record);
-
 	while ((tag = be16_to_cpu(record->tag)) != BI_LAST) {
 		int unknown = 0;
 		const void *data = record->data;
@@ -182,6 +181,8 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 		record = (struct bi_record *)((unsigned long)record + size);
 	}
 
+	save_bootinfo(first_record);
+
 	m68k_realnum_memory = m68k_num_memory;
 #ifdef CONFIG_SINGLE_MEMORY_CHUNK
 	if (m68k_num_memory > 1) {
-- 
2.37.3

