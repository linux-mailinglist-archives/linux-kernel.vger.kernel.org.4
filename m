Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49D711AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbjEZAFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbjEZAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:04:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328C194;
        Thu, 25 May 2023 17:04:43 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PNsp8B018449;
        Thu, 25 May 2023 19:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=KMEdkmN2mqwtyDfXxt5SyyP1iCNO3Bzg7wvQm68Qgfw=;
 b=MGGWaZL2V1Bwqc4z1kRH5zcbrnJQPI99nGf7YzMm/IYmukze5UWIB4SBPpbBTzG6vIRn
 i5ZUBGC3REwwwqCi269pPRapolP7yLtTwh78arIc0vTVFLwoY8zMHS8Afh1f5eMbqZUC
 UvrzDM//7OIOeLJmPKrt4XFqyR5oybGSlmvSYhYiFGkym4tXRPEuA89uUAVimxc4G+Z9
 fn2tr/rJ0uctP40iTyHscJcpBjxlQ0CCq+GJkDwd2UwOVg6BFWHCqBwIU2Vh2ipkXha6
 nJrNP51Ejdl5y9Sb+Nev2tn/ntl9/2ObKZEsHq2apWwiiaXp1vx4Fgwha2F04yczcgXp TQ== 
Received: from ausex02.ad.cirrus.com ([141.131.3.21])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm7qhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 19:04:39 -0500
Received: from ausex02.ad.cirrus.com (141.131.37.96) by ausex02.ad.cirrus.com
 (141.131.37.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 19:04:38 -0500
Received: from ftrev.crystal.cirrus.com (141.131.38.212) by
 anon-ausex02.ad.cirrus.com (141.131.37.96) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 19:04:38 -0500
From:   Fred Treven <fred.treven@cirrus.com>
To:     Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lee@kernel.org>
Subject: [PATCH RFC 5/5] mfd: cs40l26: Add CODEC driver component
Date:   Thu, 25 May 2023 19:04:31 -0500
Message-ID: <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: G3BKsgIFTqKLZh8SsGhIQJMn26swAnMA
X-Proofpoint-GUID: G3BKsgIFTqKLZh8SsGhIQJMn26swAnMA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MFD interface to load the CODEC driver along
with the Input FF driver.

Signed-off-by: Fred Treven <fred.treven@cirrus.com>
---
 drivers/input/misc/cs40l26.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
index 12c29cbd4ff0..35d15a6c2230 100644
--- a/drivers/input/misc/cs40l26.c
+++ b/drivers/input/misc/cs40l26.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mfd/core.h>
 #include <linux/pm_runtime.h>
 #include <linux/string.h>
 #include <linux/firmware/cirrus/wmfw.h>
@@ -2136,6 +2137,10 @@ static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
 	return 0;
 }
 
+static const struct mfd_cell cs40l26_devs[] = {
+	{ .name = "cs40l26-codec" },
+};
+
 static struct regulator_bulk_data cs40l26_supplies[] = {
 	{ .supply = "VP" },
 	{ .supply = "VA" },
@@ -2275,6 +2280,12 @@ int cs40l26_probe(struct cs40l26_private *cs40l26)
 	if (error)
 		goto err;
 
+	error = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cs40l26_devs, 1, NULL, 0, NULL);
+	if (error) {
+		dev_err(dev, "Failed to MFD add device %s: %d\n", cs40l26_devs[0].name, error);
+		goto err;
+	}
+
 	return 0;
 err:
 	cs40l26_remove(cs40l26);
-- 
2.7.4

