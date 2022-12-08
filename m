Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA06472A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiLHPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiLHPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC517B56C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B920E61F7D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EA4C433C1;
        Thu,  8 Dec 2022 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512459;
        bh=5/B/6xm6EZAJ5ul0EuRWGnEHFBhwPuBWdvvYzLWeBlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBaDrIsIJwFl99jsLsKk7341Pms0EoeW62pYwYz7gCo2L9W4WW30F97abdgoXY9K/
         dnhdo/3SCVJfUn/uQTCSOxhyQq0unZBX6ORU9SHNCJqcdl6aX06Lan/B3UdTQrzHwO
         SjanNY0AEvGUErvY+xpoW3vf9WRj/52D4D6/jOQ2baWOYE+fbgQAjJW2266qzxZ2LK
         sBnZifcmiVi6RbE07/su8DVdAtAFoKsOwW8WWzAB3CoxARVOVAgeIvvypyWcp970+V
         hMW0FzIR7hPIlU/20Fokemsyi+AkHQIHAMVvbUaxsTgeNFj/gSual6Du2FlMJw9JWa
         VXK3OfXWk3m6g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 18/26] habanalabs: set log level for descriptor validation to debug
Date:   Thu,  8 Dec 2022 17:13:42 +0200
Message-Id: <20221208151350.1833823-18-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

This warning doesn't have real consequences, and therefore can be
printed in debug level.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index ebb81cf89f02..537b1ae3fcb7 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1932,11 +1932,11 @@ static int hl_fw_dynamic_validate_descriptor(struct hl_device *hdev,
 	int rc;
 
 	if (le32_to_cpu(fw_desc->header.magic) != HL_COMMS_DESC_MAGIC)
-		dev_warn(hdev->dev, "Invalid magic for dynamic FW descriptor (%x)\n",
+		dev_dbg(hdev->dev, "Invalid magic for dynamic FW descriptor (%x)\n",
 				fw_desc->header.magic);
 
 	if (fw_desc->header.version != HL_COMMS_DESC_VER)
-		dev_warn(hdev->dev, "Invalid version for dynamic FW descriptor (%x)\n",
+		dev_dbg(hdev->dev, "Invalid version for dynamic FW descriptor (%x)\n",
 				fw_desc->header.version);
 
 	/*
-- 
2.25.1

