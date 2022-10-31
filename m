Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52D6134B9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJaLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJaLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E46E0E2;
        Mon, 31 Oct 2022 04:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8433D611C9;
        Mon, 31 Oct 2022 11:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF94C4347C;
        Mon, 31 Oct 2022 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216594;
        bh=0ZZ284EWNF06f5R1l1B1TXZEBiL1Fy17DKZB7HJJ7UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TM0q94CuiR05qMPTWw+U8ZRctqUeEaviDMaXe/llPyFF5jTLXqOCh92j6AqLrT+JA
         OZUvfu0v2sxmQQJUNQ9V/Pvsin+C7VYCV24vqFcVNj5NqRPPmyIgX5nihmM3o25Twd
         QzO6aFmku8JtpquwMwnLW0a2PPuq+fKWcIKshqTm2rTobb4Sbw2hxFi8awx0Sfan/h
         FMevtt+x2DDXnCO9VqJI7y0M1XxMa7zBu7qGOjyiFr/DlueR03Y6ITfss3WAwKxj3q
         41uRh8E3ZNsEv3lGMdQLy8UahlQC/Mhl4vPL5TwUkIcvq67fRQQ5ZVNJVxVwkqMRUS
         2GzoscDNiRk4g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>, linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: ahci (gcc13): use U suffix for enum definitions
Date:   Mon, 31 Oct 2022 12:43:10 +0100
Message-Id: <20221031114310.10337-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031114310.10337-1-jirislaby@kernel.org>
References: <20221031114310.10337-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc13 now uses the type of the enum for all its members [1]. Given the
ata enum defines its members using both unsigned and signed ints, the
type of the enum is promoted to long.

Make sure the rest of the members are unsigned ints using U suffix.

The error in question is for example this:
  drivers/block/mtip32xx/mtip32xx.c:722:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long in'

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

Cc: Martin Liska <mliska@suse.cz>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/ata/ahci.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 94b5c81f08dd..14eb6e97f6f7 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -39,7 +39,7 @@
 enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
-	AHCI_DMA_BOUNDARY	= 0xffffffff,
+	AHCI_DMA_BOUNDARY	= ~0U,
 	AHCI_MAX_CMDS		= 32,
 	AHCI_CMD_SZ		= 32,
 	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
@@ -178,10 +178,10 @@ enum {
 	PORT_CMD_SPIN_UP	= BIT(1), /* Spin up device */
 	PORT_CMD_START		= BIT(0), /* Enable port DMA engine */
 
-	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
-	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
-	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
-	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ICC_MASK	= (0xfU << 28), /* i/f ICC state mask */
+	PORT_CMD_ICC_ACTIVE	= (0x1U << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2U << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6U << 28), /* Put i/f in slumber state */
 
 	/* PORT_CMD capabilities mask */
 	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
@@ -191,14 +191,14 @@ enum {
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
-	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
+	PORT_FBS_DEV_MASK	= (0xfU << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
 	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
 	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
 	PORT_FBS_EN		= BIT(0), /* Enable FBS */
 
 	/* PORT_DEVSLP bits */
 	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
-	PORT_DEVSLP_DM_MASK	= (0xf << 25),    /* DITO multiplier mask */
+	PORT_DEVSLP_DM_MASK	= (0xfU << 25),    /* DITO multiplier mask */
 	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
 	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
 	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
-- 
2.38.1

