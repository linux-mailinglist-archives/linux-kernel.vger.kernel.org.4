Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE765C467
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbjACRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjACRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:06 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D013CD1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 041591C3E5B5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=UW//XMfsyLwkNUQC+hmGNX+dObS72OyhB+hvng4FX9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LbXJ+BBqOT90Zk15dr8oHAdyVpBOrW5foZ4LMrpaD2Jsat0XryuNuNYnEmZ1PKuy/
         Gzq0Mw9aL+kGGvbQX35o2Sk1wFHMki2Uru2O5K6mlizrxmtjxHD3xXUq0Q3HgFOL4N
         fyEbIJPEQpz9CQcMQM0ZiTtvUI+iBM+3JyBFwNtQ=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id D3D071C3E518; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 6E4DE1C3E441; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 20C4927E03FC; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id E568C27E03F4; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 eQRWjyMH1xxK; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 9D90127E03FE; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <b491.63b45b71.48f14.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu E568C27E03F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=J+L8c7UszbJKFAVPwsLki0REM9sesctiXlzfsKWWtFs=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=Zzm4jH2j3YflQyM6ODdFeopmtrDe6SbBb4GpP3nI5Jm7oUW0X04KWW6YOTiSz5DU/
 V7IzaRW+sQcoNWoZ+h3i1ANwVbZnu80+FfNMX3mS4bII27V0HGezV0SPlvXdOuii5t
 6sYrKPDKK4REwLB1jv+ADFo5Bz6EWfDhSaPcJXA0=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>
Subject: [RFC PATCH 19/25] kvx: power: scall poweroff driver
Date:   Tue,  3 Jan 2023 17:43:53 +0100
Message-ID: <20230103164359.24347-20-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to poweroff the Coolidge SoC
when running under Qemu, ISS or when
the debugger (jtag-runner) runs on PL0
to catch the scall.

CC: Sebastian Reichel <sre@kernel.org>
CC: linux-kernel@vger.kernel.org
CC: linux-pm@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 drivers/power/reset/kvx-scall-poweroff.c | 53 ++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/power/reset/kvx-scall-poweroff.c

diff --git a/drivers/power/reset/kvx-scall-poweroff.c b/drivers/power/reset/kvx-scall-poweroff.c
new file mode 100644
index 000000000000..586d93fbcaed
--- /dev/null
+++ b/drivers/power/reset/kvx-scall-poweroff.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 - 2022 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/pm.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define SCALL_NUM_EXIT	"0xfff"
+
+static void kvx_scall_poweroff(void)
+{
+	register int status asm("r0") = 0;
+
+	asm volatile ("scall " SCALL_NUM_EXIT "\n\t;;"
+		      : /* out */
+		      : "r"(status));
+
+	unreachable();
+}
+
+static int kvx_scall_poweroff_probe(struct platform_device *pdev)
+{
+	pm_power_off = kvx_scall_poweroff;
+
+	return 0;
+}
+
+static int kvx_scall_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == kvx_scall_poweroff)
+		pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id kvx_scall_poweroff_of_match[] = {
+	{ .compatible = "kalray,kvx-scall-poweroff" },
+	{}
+};
+
+static struct platform_driver kvx_scall_poweroff_driver = {
+	.probe = kvx_scall_poweroff_probe,
+	.remove = kvx_scall_poweroff_remove,
+	.driver = {
+		.name = "kvx-scall-poweroff",
+		.of_match_table = kvx_scall_poweroff_of_match,
+	},
+};
+module_platform_driver(kvx_scall_poweroff_driver);
-- 
2.37.2





