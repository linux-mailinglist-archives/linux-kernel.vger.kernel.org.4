Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03DE708B40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjERWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjERWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE70E6B;
        Thu, 18 May 2023 15:03:18 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I6pXIb9fQE5juMsJz0V8ZGE7yVqeUevIja1EUkuR/qk=;
        b=z5iZ9LSfzYS1r2pfNT4Ip5ffGsH7msJpQYv6BoOpD7sVSib/aFCskVqTtZzC/GGckugJEy
        xOO1o4454zLo4zx1KVlP8zbHs2PLRVSxQwwYrRjvorm4AUjMM9aWFDRIqoVZflQvMo88Sq
        MSOUTO9C1TyUKhytj9RGe+r6taYNKv/VM/OAToE9br9fU2A5prw6sFGeRSHpgxy6BOMgyB
        qT6xW4rs/Dw2CrDqLcQLEnyE3UtGJp8IiS1jQmxQrEhrws9nCgCOqsz8q434XEXS5Jxfwy
        L1GmWRZe/3MW/vKPMKC5I3z/JGrzSaplJA3hORWThOEDcd6ze3fxjvaG3diYcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I6pXIb9fQE5juMsJz0V8ZGE7yVqeUevIja1EUkuR/qk=;
        b=hJdlbU4aDWET+94oiY+r/ks/FQv295YfjCbyXkY2GLJWDvV9chyQl0zSe7sQ1YWd02kV4D
        QcChATrjCk/DIEBg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pci: Mark local functions as 'static'
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739547.404.4202344290739070365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0253b04d5b2683f5a4fdcf655b1cae6739d5ab30
Gitweb:        https://git.kernel.org/tip/0253b04d5b2683f5a4fdcf655b1cae6739d5ab30
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:31 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:10 -07:00

x86/pci: Mark local functions as 'static'

Two functions in this file are global but have no prototype in
a header and are not called from elsewhere, so they should
be static:

arch/x86/pci/ce4100.c:86:6: error: no previous prototype for 'sata_revid_init' [-Werror=missing-prototypes]
arch/x86/pci/ce4100.c:175:5: error: no previous prototype for 'bridge_read' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-3-arnd%40kernel.org
---
 arch/x86/pci/ce4100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
index 584c25b..8731370 100644
--- a/arch/x86/pci/ce4100.c
+++ b/arch/x86/pci/ce4100.c
@@ -83,7 +83,7 @@ static void ehci_reg_read(struct sim_dev_reg *reg, u32 *value)
 		*value |= 0x100;
 }
 
-void sata_revid_init(struct sim_dev_reg *reg)
+static void sata_revid_init(struct sim_dev_reg *reg)
 {
 	reg->sim_reg.value = 0x01060100;
 	reg->sim_reg.mask = 0;
@@ -172,7 +172,7 @@ static inline void extract_bytes(u32 *value, int reg, int len)
 	*value &= mask;
 }
 
-int bridge_read(unsigned int devfn, int reg, int len, u32 *value)
+static int bridge_read(unsigned int devfn, int reg, int len, u32 *value)
 {
 	u32 av_bridge_base, av_bridge_limit;
 	int retval = 0;
