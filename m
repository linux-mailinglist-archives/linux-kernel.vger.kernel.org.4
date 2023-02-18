Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3C69B900
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBRJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBRJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:18:12 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4913C0E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:17:49 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PJjjH1y9Wz9sd2;
        Sat, 18 Feb 2023 10:16:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WJBiP80qF47X; Sat, 18 Feb 2023 10:16:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PJjjC3dmzz9sd3;
        Sat, 18 Feb 2023 10:16:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68CE28B76E;
        Sat, 18 Feb 2023 10:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YUkPoWbePtPH; Sat, 18 Feb 2023 10:16:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EBF048B78C;
        Sat, 18 Feb 2023 10:16:14 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31I9G93E642554
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 10:16:09 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31I9G9wv642553;
        Sat, 18 Feb 2023 10:16:09 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/10] powerpc: Add ppc_md_progress()
Date:   Sat, 18 Feb 2023 10:15:51 +0100
Message-Id: <01d6c5351eaabfe4dca0c930bda47985389346f7.1676711562.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <6cb9865d916231c38401ba34ad1a98c249fae135.1676711562.git.christophe.leroy@csgroup.eu>
References: <6cb9865d916231c38401ba34ad1a98c249fae135.1676711562.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676711719; l=939; s=20211009; h=from:subject:message-id; bh=+qET8afofiQoc7l/laSQSD8jUH9ZI0aUXYw3gC0G8x0=; b=HRzsw/eDy6K9sjU2QMhLbBpGKPcwVRpfz6pqGXswZ4PmeeFhasI6Ut475ZgOR1KQ2F4I0NCMAPqh bG1/I8E7AwADU4Q0P7JxMoIydKAV0squqK5kBe6LnoyFWEg1QRfk
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places have:

	if (ppc.md_progress)
		ppc.md_progress();

Introduce ppc_md_progress() which will embedded the test.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/machdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 4f6e7d7ee388..b9a21ec54d1c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -240,6 +240,12 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
 		ppc_md.log_error(buf, err_type, fatal);
 }
 
+static inline void ppc_md_progress(char *s, unsigned short hex)
+{
+	if (ppc_md.progress)
+		ppc_md.progress(s, hex);
+}
+
 #define __define_machine_initcall(mach, fn, id) \
 	static int __init __machine_initcall_##mach##_##fn(void) { \
 		if (machine_is(mach)) return fn(); \
-- 
2.39.1

