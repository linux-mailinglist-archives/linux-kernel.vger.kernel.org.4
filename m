Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A27113BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbjEYSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjEYSbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE6119;
        Thu, 25 May 2023 11:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EBE464882;
        Thu, 25 May 2023 18:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3CEC433EF;
        Thu, 25 May 2023 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039509;
        bh=3O17mJCef4dAWkLXHFYSN3N283VHBeJhF8Ojoh+j8Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8aWo9JiFI40q7BblhxZK+vGRErcBUEZbWE41H320wA7IO8/DMLCvazoWLgb3U8F7
         C7rNGUvxlDE31/osCtaj7tnV0EdM+sdB5U2v503pvb6dOkE77PMylQPrmFwPzfyqTj
         Loqjgz2jZjzcMhkM8JCKVaW2zlT9V68GJfFFB01+fY3Zp6JRkCsrQ5BGT/Rs6SRlwy
         7m7QT8gdp3lLnb7tkyYr6gBFxJvANF+Wg/X2kUC/wPZ9d1oha6XiDspD+54WXrOXoV
         XdtjyEFMFcd6n4qbJcu5IFmUhbwURBXSoLXjv7nSTuExaSRggT+DYPC3X5OWYVUwEd
         kvKtztgBMbpAg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hristo Venev <hristo@venev.name>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, kbusch@kernel.org,
        sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 02/67] nvme-pci: add quirk for missing secondary temperature thresholds
Date:   Thu, 25 May 2023 14:30:39 -0400
Message-Id: <20230525183144.1717540-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hristo Venev <hristo@venev.name>

[ Upstream commit bd375feeaf3408ed00e08c3bc918d6be15f691ad ]

On Kingston KC3000 and Kingston FURY Renegade (both have the same PCI
IDs) accessing temp3_{min,max} fails with an invalid field error (note
that there is no problem setting the thresholds for temp1).

This contradicts the NVM Express Base Specification 2.0b, page 292:

  The over temperature threshold and under temperature threshold
  features shall be implemented for all implemented temperature sensors
  (i.e., all Temperature Sensor fields that report a non-zero value).

Define NVME_QUIRK_NO_SECONDARY_TEMP_THRESH that disables the thresholds
for all but the composite temperature and set it for this device.

Signed-off-by: Hristo Venev <hristo@venev.name>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/hwmon.c | 4 +++-
 drivers/nvme/host/nvme.h  | 5 +++++
 drivers/nvme/host/pci.c   | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec99..316f3e4ca7cc6 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -163,7 +163,9 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
-		    (channel && data->log->temp_sensor[channel - 1])) {
+		    (channel && data->log->temp_sensor[channel - 1] &&
+		     !(data->ctrl->quirks &
+		       NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1e..a2d4f59e0535a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -149,6 +149,11 @@ enum nvme_quirks {
 	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
 	 */
 	NVME_QUIRK_BOGUS_NID			= (1 << 18),
+
+	/*
+	 * No temperature thresholds for channels other than 0 (Composite).
+	 */
+	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bbf96567365cd..a7772c0194d5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3406,6 +3406,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000, Kingston FURY Renegade */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
-- 
2.39.2

