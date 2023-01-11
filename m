Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69560665CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjAKNqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjAKNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:46:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21D632D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673444758; x=1704980758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D44+KU7ZiM3CE8om7qWz+e12D8GVZHQeVAMd689yP1o=;
  b=erJV2dWJIoYskshxn0APA0VGPgK4CRTaLGZddGtx9K6aI8tRa9jGPsXs
   lUohED6SNfMiOWox3qXHkKreUlJ+lqEigOY5OP4rvZb9EHfhN0+aeQTnn
   WUg3gjMNfDeHuhto0VwrDENawr1DQV1pHi4607OZ6Tab1Qz9fSOv+MMyU
   kKNRTzBbfDRGNoTrxGlxaATe+HGnhbToDUURQAxqFfu7Xj8mvLc1ceZ14
   rnqKwIb74b2GPUbjF/O/AgNf5PFu0k/vvgEx4KFCfZi78h7i1nXSSV3DJ
   mzHl8hwAUmOLZwxNdZUlCdUybJc1vIkGbTJG+ZLyDL7NO1V5imC3hCULp
   g==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="131834651"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2023 06:45:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 06:45:53 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Wed, 11 Jan 2023 06:45:52 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/7] soc: microchip: mpfs: fix some horrible alignment
Date:   Wed, 11 Jan 2023 13:45:10 +0000
Message-ID: <20230111134513.2495510-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111134513.2495510-1-conor.dooley@microchip.com>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpfs_sys_controller_delete() has some horrible alignment that upsets my
OCD... Move the RHS of the assignment to a new line for greater
satifaction.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 6e20207b5756..12039cb38b33 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -66,8 +66,8 @@ static void rx_callback(struct mbox_client *client, void *msg)
 
 static void mpfs_sys_controller_delete(struct kref *kref)
 {
-	struct mpfs_sys_controller *sys_controller = container_of(kref, struct mpfs_sys_controller,
-					       consumers);
+	struct mpfs_sys_controller *sys_controller =
+		container_of(kref, struct mpfs_sys_controller, consumers);
 
 	mbox_free_channel(sys_controller->chan);
 	kfree(sys_controller);
-- 
2.39.0

