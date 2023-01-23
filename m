Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E705267744B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 04:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAWDTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 22:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:19:02 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607212078
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 19:19:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 871ED43B81;
        Mon, 23 Jan 2023 03:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1674443937;
        bh=r/A9vCNnUeh8eXWcAofjOJ52TiQX6lXArC0u7z6naKc=;
        h=From:To:Cc:Subject:Date;
        b=mbdvDI6dk/FNTYDNwUSw+4d1FqAeKyPVktUm2H48CekcMfBdnq32vZ4y8hkFTuSvj
         dfmBgACB1E83ChNMCbFlHMx62/JXedXP7MAhWny05FXP98WUPYObdW39U4OdyquY9g
         aWOG7kDPXzldCaY/BQJbYondyHLNMVSihNYGKOSY8tRbvh6pCWKsKIGXeNk+kOFdZk
         5daR15Pcd70ebPboJAm79Kv4Ghj29PrphHzJGPGAeYIRZFV3ECFZrQbS34Xse/PeDI
         3xPgbmLngwMzF606OVfJuGerE0ECGFEhCNOKOHLGjW+92sTYincMz3aeeI2GeAbniH
         0fF4rx6OJ4ltQ==
From:   Asahi Lina <lina@asahilina.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>,
        Eric Curtin <ecurtin@redhat.com>
Subject: [PATCH v2] soc: apple: rtkit: Add register dump decoding to crashlog
Date:   Mon, 23 Jan 2023 12:17:28 +0900
Message-Id: <20230123031728.22515-1-lina@asahilina.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the coprocessor crashes, it's useful to get a proper register dump
so we can find out what the firmware was doing. Add a decoder for this.

Originally this had ESR decoding by reusing the ARM64 arch header for
this, but that introduces some module linking and cross-arch compilation
issues, so let's leave that out for now.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/soc/apple/rtkit-crashlog.c | 93 ++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/soc/apple/rtkit-crashlog.c b/drivers/soc/apple/rtkit-crashlog.c
index 732deed64660..dfa74b32eda2 100644
--- a/drivers/soc/apple/rtkit-crashlog.c
+++ b/drivers/soc/apple/rtkit-crashlog.c
@@ -13,6 +13,17 @@
 #define APPLE_RTKIT_CRASHLOG_VERSION FOURCC('C', 'v', 'e', 'r')
 #define APPLE_RTKIT_CRASHLOG_MBOX FOURCC('C', 'm', 'b', 'x')
 #define APPLE_RTKIT_CRASHLOG_TIME FOURCC('C', 't', 'i', 'm')
+#define APPLE_RTKIT_CRASHLOG_REGS FOURCC('C', 'r', 'g', '8')
+
+/* For COMPILE_TEST on non-ARM64 architectures */
+#ifndef PSR_MODE_EL0t
+#define PSR_MODE_EL0t	0x00000000
+#define PSR_MODE_EL1t	0x00000004
+#define PSR_MODE_EL1h	0x00000005
+#define PSR_MODE_EL2t	0x00000008
+#define PSR_MODE_EL2h	0x00000009
+#define PSR_MODE_MASK	0x0000000f
+#endif
 
 struct apple_rtkit_crashlog_header {
 	u32 fourcc;
@@ -31,6 +42,24 @@ struct apple_rtkit_crashlog_mbox_entry {
 };
 static_assert(sizeof(struct apple_rtkit_crashlog_mbox_entry) == 0x18);
 
+struct apple_rtkit_crashlog_regs {
+	u32 unk_0;
+	u32 unk_4;
+	u64 regs[31];
+	u64 sp;
+	u64 pc;
+	u64 psr;
+	u64 cpacr;
+	u64 fpsr;
+	u64 fpcr;
+	u64 unk[64];
+	u64 far;
+	u64 unk_X;
+	u64 esr;
+	u64 unk_Z;
+};
+static_assert(sizeof(struct apple_rtkit_crashlog_regs) == 0x350);
+
 static void apple_rtkit_crashlog_dump_str(struct apple_rtkit *rtk, u8 *bfr,
 					  size_t size)
 {
@@ -94,6 +123,66 @@ static void apple_rtkit_crashlog_dump_mailbox(struct apple_rtkit *rtk, u8 *bfr,
 	}
 }
 
+static void apple_rtkit_crashlog_dump_regs(struct apple_rtkit *rtk, u8 *bfr,
+					   size_t size)
+{
+	struct apple_rtkit_crashlog_regs regs;
+	const char *el;
+	int i;
+
+	if (size < sizeof(regs)) {
+		dev_warn(rtk->dev, "RTKit: Regs section too small: 0x%zx", size);
+		return;
+	}
+
+	memcpy(&regs, bfr, sizeof(regs));
+
+	switch (regs.psr & PSR_MODE_MASK) {
+	case PSR_MODE_EL0t:
+		el = "EL0t";
+		break;
+	case PSR_MODE_EL1t:
+		el = "EL1t";
+		break;
+	case PSR_MODE_EL1h:
+		el = "EL1h";
+		break;
+	case PSR_MODE_EL2t:
+		el = "EL2t";
+		break;
+	case PSR_MODE_EL2h:
+		el = "EL2h";
+		break;
+	default:
+		el = "unknown";
+		break;
+	}
+
+	dev_warn(rtk->dev, "RTKit: Exception dump:");
+	dev_warn(rtk->dev, "  == Exception taken from %s ==", el);
+	dev_warn(rtk->dev, "  PSR    = 0x%llx", regs.psr);
+	dev_warn(rtk->dev, "  PC     = 0x%llx\n", regs.pc);
+	dev_warn(rtk->dev, "  ESR    = 0x%llx\n", regs.esr);
+	dev_warn(rtk->dev, "  FAR    = 0x%llx\n", regs.far);
+	dev_warn(rtk->dev, "  SP     = 0x%llx\n", regs.sp);
+	dev_warn(rtk->dev, "\n");
+
+	for (i = 0; i < 31; i += 4) {
+		if (i < 28)
+			dev_warn(rtk->dev,
+					 "  x%02d-x%02d = %016llx %016llx %016llx %016llx\n",
+					 i, i + 3,
+					 regs.regs[i], regs.regs[i + 1],
+					 regs.regs[i + 2], regs.regs[i + 3]);
+		else
+			dev_warn(rtk->dev,
+					 "  x%02d-x%02d = %016llx %016llx %016llx\n", i, i + 3,
+					 regs.regs[i], regs.regs[i + 1], regs.regs[i + 2]);
+	}
+
+	dev_warn(rtk->dev, "\n");
+}
+
 void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
 {
 	size_t offset;
@@ -140,6 +229,10 @@ void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
 			apple_rtkit_crashlog_dump_time(rtk, bfr + offset + 16,
 						       section_size);
 			break;
+		case APPLE_RTKIT_CRASHLOG_REGS:
+			apple_rtkit_crashlog_dump_regs(rtk, bfr + offset + 16,
+						       section_size);
+			break;
 		default:
 			dev_warn(rtk->dev,
 				 "RTKit: Unknown crashlog section: %x",
-- 
2.35.1

