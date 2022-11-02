Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B161615F47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiKBJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKBJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36B28E2C;
        Wed,  2 Nov 2022 02:12:46 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RO2IHuYFSdiGcCtndhrP9IGcPaamUDawD8uuIGJbN9M=;
        b=Pb8lrMrN/Narh/Fq4vIi73rrhPd8ezLdWLptblZFR6wLis7MDb9U4i2cep280jaX9U4zeB
        eBXumIJ7qrZ7mLMntnIe84cat3u+NO7sdCLYBj8ajbLqALPS+KbV6dRmrk4viaErOUhDvp
        09DuhdEWCYxLfo63qGzq5G6Ksi9IOAGXDa1RCmx6pZKy4zEhiIYjwGK3zwCP0sj6PNRlSD
        fVS18M2iLZUMfxDMIE9QT9B2q1xRxk4iEVanVg/GoqmRkOnZg0Ll82vwOTehFDVRAImXlF
        qD85Q9Ax4X8+eDgETHn+ENCF+CYm9KX0PswkahHE+6cm4iPBieU4Xbweh7insQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RO2IHuYFSdiGcCtndhrP9IGcPaamUDawD8uuIGJbN9M=;
        b=n4U32zc/lnxmcPgWuhNsTxDzJD+IBsAUGgOkNvWt8Bw4boBFxd4lNQ02cm0QYGYPkjdbm9
        cDxoQfAXm2i980Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] sh/mm: Make pmd_t similar to pte_t
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738036405.7716.8277600641359044546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     bb51ac2cd4191626bee6e196f39559d371c8609d
Gitweb:        https://git.kernel.org/tip/bb51ac2cd4191626bee6e196f39559d371c8609d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:05:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:00 +01:00

sh/mm: Make pmd_t similar to pte_t

Just like 64bit pte_t, have a low/high split in pmd_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.645657294%40infradead.org
---
 arch/sh/include/asm/pgtable-3level.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index cdced80..a889a3a 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -28,9 +28,15 @@
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct {
+	struct {
+		unsigned long pmd_low;
+		unsigned long pmd_high;
+	};
+	unsigned long long pmd;
+} pmd_t;
 #define pmd_val(x)	((x).pmd)
-#define __pmd(x)	((pmd_t) { (x) } )
+#define __pmd(x)	((pmd_t) { .pmd = (x) } )
 
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
