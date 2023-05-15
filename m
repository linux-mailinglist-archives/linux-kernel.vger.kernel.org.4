Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A57028A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbjEOJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjEOJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:31:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DF10E5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=n5FX9O5NE2mJSX7EZnD0DzVAFi6zSBewbsr6jBc6kiw=; b=Z1Blh8OVDwtCEVdf75OxFiqKJ6
        ug6o73IBdnyIBFJcz1w98pNFIDKs3bAI0JDs7nlUJVFXQSf5jmGROH6FwJk3lKG5yjPt877qThICc
        lTTfY0mTwzBgt0zSuM2mQJUNR8xQ/FtLUjNDfKPNdrXnKEDc72T/j9QL54JSsxtRx8Jv2UWEmdupP
        9eYou/dJ1vXlSpH9P8kQ1SfB6e6XcIe8pbNhPdeR4GLUdhREiXiiPgoBsLxQxwqW1Xg7FrDZY3b69
        D75jQofF3Ghmi9bcRS0KvbVKv11bk11gQUJ2eR8cfj46CIIbfTD3YSXrXHHiu76sBPetsv4XY/cm6
        vQP/jU8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyUXZ-00BRNr-2p;
        Mon, 15 May 2023 09:30:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70DA8300786;
        Mon, 15 May 2023 11:30:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 42CAA202674A5; Mon, 15 May 2023 11:30:48 +0200 (CEST)
Message-ID: <20230515093020.661756940@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 May 2023 11:28:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, Andrew.Cooper3@citrix.com, jpoimboe@redhat.com
Subject: [PATCH 1/2] x86_64: Longer NOPs
References: <20230515092804.120600032@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding support for longer NOPs there are a few more alternatives
that can turn into a single instruction.

Add up to NOP11, the same limit where GNU as .nops also stops
generating longer nops. This is because a number of uarchs have severe
decode penalties for more than 3 prefixes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nops.h   |   16 ++++++++++++++--
 arch/x86/kernel/alternative.c |   10 ++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -34,6 +34,8 @@
 #define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x3e,BYTES_NOP7
 
+#define ASM_NOP_MAX 8
+
 #else
 
 /*
@@ -47,6 +49,9 @@
  * 6: osp nopl 0x00(%eax,%eax,1)
  * 7: nopl 0x00000000(%eax)
  * 8: nopl 0x00000000(%eax,%eax,1)
+ * 9: cs nopl 0x00000000(%eax,%eax,1)
+ * 10: osp cs nopl 0x00000000(%eax,%eax,1)
+ * 11: osp osp cs nopl 0x00000000(%eax,%eax,1)
  */
 #define BYTES_NOP1	0x90
 #define BYTES_NOP2	0x66,BYTES_NOP1
@@ -56,6 +61,15 @@
 #define BYTES_NOP6	0x66,BYTES_NOP5
 #define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
 #define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
+#define BYTES_NOP9	0x2e,BYTES_NOP8
+#define BYTES_NOP10	0x66,BYTES_NOP9
+#define BYTES_NOP11	0x66,BYTES_NOP10
+
+#define ASM_NOP9  _ASM_BYTES(BYTES_NOP9)
+#define ASM_NOP10 _ASM_BYTES(BYTES_NOP10)
+#define ASM_NOP11 _ASM_BYTES(BYTES_NOP11)
+
+#define ASM_NOP_MAX 11
 
 #endif /* CONFIG_64BIT */
 
@@ -68,8 +82,6 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#define ASM_NOP_MAX 8
-
 #ifndef __ASSEMBLY__
 extern const unsigned char * const x86_nops[];
 #endif
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -98,6 +98,11 @@ static const unsigned char x86nops[] =
 	BYTES_NOP6,
 	BYTES_NOP7,
 	BYTES_NOP8,
+#ifdef CONFIG_64BIT
+	BYTES_NOP9,
+	BYTES_NOP10,
+	BYTES_NOP11,
+#endif
 };
 
 const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
@@ -111,6 +116,11 @@ const unsigned char * const x86_nops[ASM
 	x86nops + 1 + 2 + 3 + 4 + 5,
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6,
 	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+#ifdef CONFIG_64BIT
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9,
+	x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10,
+#endif
 };
 
 /*


