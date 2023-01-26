Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F6D67D3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAZSFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAZSFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:05:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 902DC23D83
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:05:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5E304B3;
        Thu, 26 Jan 2023 10:06:19 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D600B3F71E;
        Thu, 26 Jan 2023 10:05:36 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH] regulator: scmi: Allow for zero voltage domains
Date:   Thu, 26 Jan 2023 18:05:11 +0000
Message-Id: <20230126180511.766373-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI Voltage protocol allows the platform to report no voltage domains
on discovery, while warning the user about such an odd configuration.
As a consequence this condition should not be treated as error by the SCMI
regulator driver either.

Allow SCMI regulator driver to probe successfully even when no voltage
domains are discovered.

Cc: Mark Brown <broonie@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/regulator/scmi-regulator.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index b9918f4fd241..29ab217297d6 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -311,16 +311,12 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 		return PTR_ERR(voltage_ops);
 
 	num_doms = voltage_ops->num_domains_get(ph);
-	if (num_doms <= 0) {
-		if (!num_doms) {
-			dev_err(&sdev->dev,
-				"number of voltage domains invalid\n");
-			num_doms = -EINVAL;
-		} else {
-			dev_err(&sdev->dev,
-				"failed to get voltage domains - err:%d\n",
-				num_doms);
-		}
+	if (!num_doms)
+		return 0;
+
+	if (num_doms < 0) {
+		dev_err(&sdev->dev, "failed to get voltage domains - err:%d\n",
+			num_doms);
 
 		return num_doms;
 	}
-- 
2.34.1

