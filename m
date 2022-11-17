Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04B162E179
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiKQQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiKQQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25F7A37F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C40A462129
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B97C43470;
        Thu, 17 Nov 2022 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702013;
        bh=awJcsInCrnpYPooCsXmTvq88qOaCFASkgl3nzDbnHPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIq57JAoDRaj58PMEcNmC8uPLkoF+sZmJAf0+i9riIje4fcxajltdx7uWHUyEsygf
         wrf4q05yDtUqPPzbQYnjIKaGJDcvaaVfzLscujFi1FSbvznJojFtYmbktiw5DviV9o
         aVPxr0ppFZNRzwQ7TY1LpA0KMSs1QwNZpC6mtST7tiaqQJaqTyjeKVJV5d0DKnOLJq
         IWgdDHMxXJH3yLz2zKkcUaaOGbA+lQiigssGJhLpm/v26i/GHd4dAxj9Y+5pd4L34l
         GDsDnDUSno9lxyNwJtZWnjOkwbjJrwyWkomS//k0uTzTym4WJ5C54ibV8f3YUgwVqP
         F5/DGiZoJKteA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 13/20] habanalabs/gaudi2: remove redundant firmware version check
Date:   Thu, 17 Nov 2022 18:19:44 +0200
Message-Id: <20221117161951.845454-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
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

Firmware 1.7 is the first official firmware, so no need to check
if we are running a version below it.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index bdb5782afb7e..36f0ea1100bb 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -10358,10 +10358,9 @@ int gaudi2_send_device_activity(struct hl_device *hdev, bool open)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 
-	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q) || hdev->fw_major_version < 37)
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	/* TODO: add check for FW version using minor ver once it's known */
 	return hl_fw_send_device_activity(hdev, open);
 }
 
-- 
2.25.1

