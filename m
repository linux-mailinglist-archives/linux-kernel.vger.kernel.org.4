Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81925EA6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiIZNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiIZNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1841CD133
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83008B80760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1330C433D7;
        Mon, 26 Sep 2022 11:38:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Iwdz3EdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664192280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4V07+F+ZCgcaY161ySINjNSoGHejxfibeuVPmSgNTYg=;
        b=Iwdz3EdLWR+hH9+ejf7b7cGSAQE26tNFpOhREjKLGNn23sG3jCxtZKvdhFrWscBZr4q7cq
        AV7VGZfAlOINyw0lsKIa1h+ZdUYjjXJUngcD/77CPBVM0x9Mh1Fn72/vRWbMao/qmWqwpd
        kgBZSA7GamzFSN4ynQXD0mPTNKoW4s0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5054d334 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 11:37:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 1/3] m68k: process bootinfo records before saving them
Date:   Mon, 26 Sep 2022 13:37:52 +0200
Message-Id: <20220926113754.1256358-1-Jason@zx2c4.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

