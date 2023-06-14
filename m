Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558AD72F968
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbjFNJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjFNJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67E269D;
        Wed, 14 Jun 2023 02:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC3863FCC;
        Wed, 14 Jun 2023 09:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67847C433C0;
        Wed, 14 Jun 2023 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735509;
        bh=PNBDcfmPiuTmZxa/7+QSCUFa+MFGRw2fJ9ebjzPRjoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb5SXF4Qx+BjdjWU0zPpt+r44dMKlGCp2ArX4K8Psyap4TOZztIhtUXmP4rDJE/vm
         Hb637ee+mrJ5/3HykvetORDsvRhl4xVCQT0hrnWR/1CXfNsTdV0DLmoDzt0UBlH86J
         YHCMeVNM+I0BJvhUC3lVtSsf7e8Wye5qNwqFs6W8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.184
Date:   Wed, 14 Jun 2023 11:38:18 +0200
Message-ID: <2023061417-sanctity-exclusive-e872@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023061417-denote-onboard-aca1@gregkh>
References: <2023061417-denote-onboard-aca1@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 28115681fffd..3450b061e8d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 183
+SUBLEVEL = 184
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 27ad76791539..fd0e09033a7c 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -203,7 +203,7 @@ ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
  * The function returns the old value of @v minus @i.
  */
 #define ATOMIC_SIP_OP(pfx, type, op, ll, sc)				\
-static __inline__ int pfx##_sub_if_positive(type i, pfx##_t * v)	\
+static __inline__ type pfx##_sub_if_positive(type i, pfx##_t * v)	\
 {									\
 	type temp, result;						\
 									\
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c192bd7305dc..b28fabfc91bf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -22,6 +22,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9255b642d6ad..105ad23dff06 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -232,7 +232,9 @@ enum {
 
 	/* 1/64k is granular enough and can easily be handled w/ u32 */
 	WEIGHT_ONE		= 1 << 16,
+};
 
+enum {
 	/*
 	 * As vtime is used to calculate the cost of each IO, it needs to
 	 * be fairly high precision.  For example, it should be able to
@@ -256,6 +258,11 @@ enum {
 	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
 	VRATE_CLAMP_ADJ_PCT	= 4,
 
+	/* switch iff the conditions are met for longer than this */
+	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
+};
+
+enum {
 	/* if IOs end up waiting for requests, issue less */
 	RQ_WAIT_BUSY_PCT	= 5,
 
@@ -294,9 +301,6 @@ enum {
 	/* don't let cmds which take a very long time pin lagging for too long */
 	MAX_LAGGING_PERIODS	= 10,
 
-	/* switch iff the conditions are met for longer than this */
-	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
-
 	/*
 	 * Count IO size in 4k pages.  The 12bit shift helps keeping
 	 * size-proportional components of cost calculation in closer
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1ce897356993..7cc6feb17e97 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -24,6 +24,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bits.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -54,12 +55,12 @@ enum {
 	AHCI_PORT_PRIV_FBS_DMA_SZ	= AHCI_CMD_SLOT_SZ +
 					  AHCI_CMD_TBL_AR_SZ +
 					  (AHCI_RX_FIS_SZ * 16),
-	AHCI_IRQ_ON_SG		= (1 << 31),
-	AHCI_CMD_ATAPI		= (1 << 5),
-	AHCI_CMD_WRITE		= (1 << 6),
-	AHCI_CMD_PREFETCH	= (1 << 7),
-	AHCI_CMD_RESET		= (1 << 8),
-	AHCI_CMD_CLR_BUSY	= (1 << 10),
+	AHCI_IRQ_ON_SG		= BIT(31),
+	AHCI_CMD_ATAPI		= BIT(5),
+	AHCI_CMD_WRITE		= BIT(6),
+	AHCI_CMD_PREFETCH	= BIT(7),
+	AHCI_CMD_RESET		= BIT(8),
+	AHCI_CMD_CLR_BUSY	= BIT(10),
 
 	RX_FIS_PIO_SETUP	= 0x20,	/* offset of PIO Setup FIS data */
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
@@ -77,37 +78,37 @@ enum {
 	HOST_CAP2		= 0x24, /* host capabilities, extended */
 
 	/* HOST_CTL bits */
-	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
-	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
-	HOST_MRSM		= (1 << 2),  /* MSI Revert to Single Message */
-	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+	HOST_RESET		= BIT(0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= BIT(1),  /* global IRQ enable */
+	HOST_MRSM		= BIT(2),  /* MSI Revert to Single Message */
+	HOST_AHCI_EN		= BIT(31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
-	HOST_CAP_SXS		= (1 << 5),  /* Supports External SATA */
-	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
-	HOST_CAP_CCC		= (1 << 7),  /* Command Completion Coalescing */
-	HOST_CAP_PART		= (1 << 13), /* Partial state capable */
-	HOST_CAP_SSC		= (1 << 14), /* Slumber state capable */
-	HOST_CAP_PIO_MULTI	= (1 << 15), /* PIO multiple DRQ support */
-	HOST_CAP_FBS		= (1 << 16), /* FIS-based switching support */
-	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
-	HOST_CAP_ONLY		= (1 << 18), /* Supports AHCI mode only */
-	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
-	HOST_CAP_LED		= (1 << 25), /* Supports activity LED */
-	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
-	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
-	HOST_CAP_MPS		= (1 << 28), /* Mechanical presence switch */
-	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
-	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
-	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_SXS		= BIT(5),  /* Supports External SATA */
+	HOST_CAP_EMS		= BIT(6),  /* Enclosure Management support */
+	HOST_CAP_CCC		= BIT(7),  /* Command Completion Coalescing */
+	HOST_CAP_PART		= BIT(13), /* Partial state capable */
+	HOST_CAP_SSC		= BIT(14), /* Slumber state capable */
+	HOST_CAP_PIO_MULTI	= BIT(15), /* PIO multiple DRQ support */
+	HOST_CAP_FBS		= BIT(16), /* FIS-based switching support */
+	HOST_CAP_PMP		= BIT(17), /* Port Multiplier support */
+	HOST_CAP_ONLY		= BIT(18), /* Supports AHCI mode only */
+	HOST_CAP_CLO		= BIT(24), /* Command List Override support */
+	HOST_CAP_LED		= BIT(25), /* Supports activity LED */
+	HOST_CAP_ALPM		= BIT(26), /* Aggressive Link PM support */
+	HOST_CAP_SSS		= BIT(27), /* Staggered Spin-up */
+	HOST_CAP_MPS		= BIT(28), /* Mechanical presence switch */
+	HOST_CAP_SNTF		= BIT(29), /* SNotification register */
+	HOST_CAP_NCQ		= BIT(30), /* Native Command Queueing */
+	HOST_CAP_64		= BIT(31), /* PCI DAC (64-bit DMA) support */
 
 	/* HOST_CAP2 bits */
-	HOST_CAP2_BOH		= (1 << 0),  /* BIOS/OS handoff supported */
-	HOST_CAP2_NVMHCI	= (1 << 1),  /* NVMHCI supported */
-	HOST_CAP2_APST		= (1 << 2),  /* Automatic partial to slumber */
-	HOST_CAP2_SDS		= (1 << 3),  /* Support device sleep */
-	HOST_CAP2_SADM		= (1 << 4),  /* Support aggressive DevSlp */
-	HOST_CAP2_DESO		= (1 << 5),  /* DevSlp from slumber only */
+	HOST_CAP2_BOH		= BIT(0),  /* BIOS/OS handoff supported */
+	HOST_CAP2_NVMHCI	= BIT(1),  /* NVMHCI supported */
+	HOST_CAP2_APST		= BIT(2),  /* Automatic partial to slumber */
+	HOST_CAP2_SDS		= BIT(3),  /* Support device sleep */
+	HOST_CAP2_SADM		= BIT(4),  /* Support aggressive DevSlp */
+	HOST_CAP2_DESO		= BIT(5),  /* DevSlp from slumber only */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -129,24 +130,24 @@ enum {
 	PORT_DEVSLP		= 0x44, /* device sleep */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
-	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
-	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
-	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
-	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
-	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
-	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
-	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
-	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
-
-	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
-	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
-	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
-	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
-	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
-	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
-	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
-	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+	PORT_IRQ_COLD_PRES	= BIT(31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= BIT(30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= BIT(29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= BIT(28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= BIT(27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= BIT(26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= BIT(24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= BIT(23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= BIT(22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= BIT(7),  /* device interlock */
+	PORT_IRQ_CONNECT	= BIT(6),  /* port connect change status */
+	PORT_IRQ_SG_DONE	= BIT(5),  /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= BIT(4),  /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= BIT(3),  /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= BIT(2),  /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= BIT(1),  /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= BIT(0),  /* D2H Register FIS rx'd */
 
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
@@ -162,34 +163,34 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
-	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
-	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
-	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
-	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
-	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
-	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
-	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
-	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
-	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
-	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
-	PORT_CMD_CLO		= (1 << 3), /* Command list override */
-	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
-	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
-	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
-
-	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
-	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
-	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
-	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ASP		= BIT(27), /* Aggressive Slumber/Partial */
+	PORT_CMD_ALPE		= BIT(26), /* Aggressive Link PM enable */
+	PORT_CMD_ATAPI		= BIT(24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= BIT(22), /* FBS Capable Port */
+	PORT_CMD_ESP		= BIT(21), /* External Sata Port */
+	PORT_CMD_HPCP		= BIT(18), /* HotPlug Capable Port */
+	PORT_CMD_PMP		= BIT(17), /* PMP attached */
+	PORT_CMD_LIST_ON	= BIT(15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= BIT(14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= BIT(4),  /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= BIT(3),  /* Command list override */
+	PORT_CMD_POWER_ON	= BIT(2),  /* Power up device */
+	PORT_CMD_SPIN_UP	= BIT(1),  /* Spin up device */
+	PORT_CMD_START		= BIT(0),  /* Enable port DMA engine */
+
+	PORT_CMD_ICC_MASK	= (0xfu << 28), /* i/f ICC state mask */
+	PORT_CMD_ICC_ACTIVE	= (0x1u << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2u << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6u << 28), /* Put i/f in slumber state */
 
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
 	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
-	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
-	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
-	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
+	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
+	PORT_FBS_EN		= BIT(0), /* Enable FBS */
 
 	/* PORT_DEVSLP bits */
 	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
@@ -197,52 +198,52 @@ enum {
 	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
 	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
 	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
-	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
-	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
+	PORT_DEVSLP_DSP		= BIT(1),         /* DevSlp present */
+	PORT_DEVSLP_ADSE	= BIT(0),         /* Aggressive DevSlp enable */
 
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
 
-	AHCI_HFLAG_NO_NCQ		= (1 << 0),
-	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
-	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
-	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
-	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
-	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
-	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
-	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
-	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
-	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
-	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= (1 << 11), /* treat SRST timeout as
-							link offline */
-	AHCI_HFLAG_NO_SNTF		= (1 << 12), /* no sntf */
-	AHCI_HFLAG_NO_FPDMA_AA		= (1 << 13), /* no FPDMA AA */
-	AHCI_HFLAG_YES_FBS		= (1 << 14), /* force FBS cap on */
-	AHCI_HFLAG_DELAY_ENGINE		= (1 << 15), /* do not start engine on
-						        port start (wait until
-						        error-handling stage) */
-	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
-	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
+	AHCI_HFLAG_NO_NCQ		= BIT(0),
+	AHCI_HFLAG_IGN_IRQ_IF_ERR	= BIT(1), /* ignore IRQ_IF_ERR */
+	AHCI_HFLAG_IGN_SERR_INTERNAL	= BIT(2), /* ignore SERR_INTERNAL */
+	AHCI_HFLAG_32BIT_ONLY		= BIT(3), /* force 32bit */
+	AHCI_HFLAG_MV_PATA		= BIT(4), /* PATA port */
+	AHCI_HFLAG_NO_MSI		= BIT(5), /* no PCI MSI */
+	AHCI_HFLAG_NO_PMP		= BIT(6), /* no PMP */
+	AHCI_HFLAG_SECT255		= BIT(8), /* max 255 sectors */
+	AHCI_HFLAG_YES_NCQ		= BIT(9), /* force NCQ cap on */
+	AHCI_HFLAG_NO_SUSPEND		= BIT(10), /* don't suspend */
+	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= BIT(11), /* treat SRST timeout as
+						      link offline */
+	AHCI_HFLAG_NO_SNTF		= BIT(12), /* no sntf */
+	AHCI_HFLAG_NO_FPDMA_AA		= BIT(13), /* no FPDMA AA */
+	AHCI_HFLAG_YES_FBS		= BIT(14), /* force FBS cap on */
+	AHCI_HFLAG_DELAY_ENGINE		= BIT(15), /* do not start engine on
+						      port start (wait until
+						      error-handling stage) */
+	AHCI_HFLAG_NO_DEVSLP		= BIT(17), /* no device sleep */
+	AHCI_HFLAG_NO_FBS		= BIT(18), /* no FBS */
 
 #ifdef CONFIG_PCI_MSI
-	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* per-port MSI(-X) */
+	AHCI_HFLAG_MULTI_MSI		= BIT(20), /* per-port MSI(-X) */
 #else
 	/* compile out MSI infrastructure */
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
-	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
-	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
-	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
-							only registers */
-	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
-							SATA_MOBILE_LPM_POLICY
-							as default lpm_policy */
-	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
-							suspend/resume */
-	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
-							from phy_power_on() */
-	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= BIT(22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= BIT(23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= BIT(24), /* don't write to read
+						      only registers */
+	AHCI_HFLAG_IS_MOBILE            = BIT(25), /* mobile chipset, use
+						      SATA_MOBILE_LPM_POLICY
+						      as default lpm_policy */
+	AHCI_HFLAG_SUSPEND_PHYS		= BIT(26), /* handle PHYs during
+						      suspend/resume */
+	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
+						      from phy_power_on() */
+	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
 
 	/* ap->flags bits */
 
@@ -258,22 +259,22 @@ enum {
 	EM_MAX_RETRY			= 5,
 
 	/* em_ctl bits */
-	EM_CTL_RST		= (1 << 9), /* Reset */
-	EM_CTL_TM		= (1 << 8), /* Transmit Message */
-	EM_CTL_MR		= (1 << 0), /* Message Received */
-	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
-	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
-	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
-	EM_CTL_SGPIO		= (1 << 19), /* SGPIO messages supported */
-	EM_CTL_SES		= (1 << 18), /* SES-2 messages supported */
-	EM_CTL_SAFTE		= (1 << 17), /* SAF-TE messages supported */
-	EM_CTL_LED		= (1 << 16), /* LED messages supported */
+	EM_CTL_RST		= BIT(9), /* Reset */
+	EM_CTL_TM		= BIT(8), /* Transmit Message */
+	EM_CTL_MR		= BIT(0), /* Message Received */
+	EM_CTL_ALHD		= BIT(26), /* Activity LED */
+	EM_CTL_XMT		= BIT(25), /* Transmit Only */
+	EM_CTL_SMB		= BIT(24), /* Single Message Buffer */
+	EM_CTL_SGPIO		= BIT(19), /* SGPIO messages supported */
+	EM_CTL_SES		= BIT(18), /* SES-2 messages supported */
+	EM_CTL_SAFTE		= BIT(17), /* SAF-TE messages supported */
+	EM_CTL_LED		= BIT(16), /* LED messages supported */
 
 	/* em message type */
-	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
-	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
-	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
-	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */
+	EM_MSG_TYPE_LED		= BIT(0), /* LED */
+	EM_MSG_TYPE_SAFTE	= BIT(1), /* SAF-TE */
+	EM_MSG_TYPE_SES2	= BIT(2), /* SES-2 */
+	EM_MSG_TYPE_SGPIO	= BIT(3), /* SGPIO */
 };
 
 struct ahci_cmd_hdr {
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 9617688b58b3..408c7428cca5 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -293,15 +293,6 @@ config BLK_DEV_SKD
 
 	Use device /dev/skd$N amd /dev/skd$Np$M.
 
-config BLK_DEV_SX8
-	tristate "Promise SATA SX8 support"
-	depends on PCI
-	help
-	  Saying Y or M here will enable support for the 
-	  Promise SATA SX8 controllers.
-
-	  Use devices /dev/sx8/$N and /dev/sx8/$Np$M.
-
 config BLK_DEV_RAM
 	tristate "RAM block device support"
 	help
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a3170859e01d..24427da7dd64 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -29,8 +29,6 @@ obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
-obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
-
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
 obj-$(CONFIG_XEN_BLKDEV_BACKEND)	+= xen-blkback/
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd/
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 932d4bb8e403..63491748dc8d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1397,14 +1397,30 @@ static bool rbd_obj_is_tail(struct rbd_obj_request *obj_req)
 /*
  * Must be called after rbd_obj_calc_img_extents().
  */
-static bool rbd_obj_copyup_enabled(struct rbd_obj_request *obj_req)
+static void rbd_obj_set_copyup_enabled(struct rbd_obj_request *obj_req)
 {
-	if (!obj_req->num_img_extents ||
-	    (rbd_obj_is_entire(obj_req) &&
-	     !obj_req->img_request->snapc->num_snaps))
-		return false;
+	rbd_assert(obj_req->img_request->snapc);
 
-	return true;
+	if (obj_req->img_request->op_type == OBJ_OP_DISCARD) {
+		dout("%s %p objno %llu discard\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (!obj_req->num_img_extents) {
+		dout("%s %p objno %llu not overlapping\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (rbd_obj_is_entire(obj_req) &&
+	    !obj_req->img_request->snapc->num_snaps) {
+		dout("%s %p objno %llu entire\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 }
 
 static u64 rbd_obj_img_extents_bytes(struct rbd_obj_request *obj_req)
@@ -1505,6 +1521,7 @@ __rbd_obj_add_osd_request(struct rbd_obj_request *obj_req,
 static struct ceph_osd_request *
 rbd_obj_add_osd_request(struct rbd_obj_request *obj_req, int num_ops)
 {
+	rbd_assert(obj_req->img_request->snapc);
 	return __rbd_obj_add_osd_request(obj_req, obj_req->img_request->snapc,
 					 num_ops);
 }
@@ -1641,15 +1658,18 @@ static void rbd_img_request_init(struct rbd_img_request *img_request,
 	mutex_init(&img_request->state_mutex);
 }
 
+/*
+ * Only snap_id is captured here, for reads.  For writes, snapshot
+ * context is captured in rbd_img_object_requests() after exclusive
+ * lock is ensured to be held.
+ */
 static void rbd_img_capture_header(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 
 	lockdep_assert_held(&rbd_dev->header_rwsem);
 
-	if (rbd_img_is_write(img_req))
-		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
-	else
+	if (!rbd_img_is_write(img_req))
 		img_req->snap_id = rbd_dev->spec->snap_id;
 
 	if (rbd_dev_parent_get(rbd_dev))
@@ -2296,9 +2316,6 @@ static int rbd_obj_init_write(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
-
 	obj_req->write_state = RBD_OBJ_WRITE_START;
 	return 0;
 }
@@ -2404,8 +2421,6 @@ static int rbd_obj_init_zeroout(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 	if (!obj_req->num_img_extents) {
 		obj_req->flags |= RBD_OBJ_FLAG_NOOP_FOR_NONEXISTENT;
 		if (rbd_obj_is_entire(obj_req))
@@ -3351,6 +3366,7 @@ static bool rbd_obj_advance_write(struct rbd_obj_request *obj_req, int *result)
 	case RBD_OBJ_WRITE_START:
 		rbd_assert(!*result);
 
+		rbd_obj_set_copyup_enabled(obj_req);
 		if (rbd_obj_write_is_noop(obj_req))
 			return true;
 
@@ -3537,9 +3553,19 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 
 static void rbd_img_object_requests(struct rbd_img_request *img_req)
 {
+	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	struct rbd_obj_request *obj_req;
 
 	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
+	rbd_assert(!need_exclusive_lock(img_req) ||
+		   __rbd_is_lock_owner(rbd_dev));
+
+	if (rbd_img_is_write(img_req)) {
+		rbd_assert(!img_req->snapc);
+		down_read(&rbd_dev->header_rwsem);
+		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		up_read(&rbd_dev->header_rwsem);
+	}
 
 	for_each_obj_request(img_req, obj_req) {
 		int result = 0;
@@ -3557,7 +3583,6 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 
 static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 {
-	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
 again:
@@ -3578,9 +3603,6 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 		if (*result)
 			return true;
 
-		rbd_assert(!need_exclusive_lock(img_req) ||
-			   __rbd_is_lock_owner(rbd_dev));
-
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
@@ -4038,6 +4060,10 @@ static int rbd_post_acquire_action(struct rbd_device *rbd_dev)
 {
 	int ret;
 
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (rbd_dev->header.features & RBD_FEATURE_OBJECT_MAP) {
 		ret = rbd_object_map_open(rbd_dev);
 		if (ret)
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
deleted file mode 100644
index 4478eb7efee0..000000000000
--- a/drivers/block/sx8.c
+++ /dev/null
@@ -1,1586 +0,0 @@
-/*
- *  sx8.c: Driver for Promise SATA SX8 looks-like-I2O hardware
- *
- *  Copyright 2004-2005 Red Hat, Inc.
- *
- *  Author/maintainer:  Jeff Garzik <jgarzik@pobox.com>
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file "COPYING" in the main directory of this archive
- *  for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/blk-mq.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/ktime.h>
-#include <linux/hdreg.h>
-#include <linux/dma-mapping.h>
-#include <linux/completion.h>
-#include <linux/scatterlist.h>
-#include <asm/io.h>
-#include <linux/uaccess.h>
-
-#if 0
-#define CARM_DEBUG
-#define CARM_VERBOSE_DEBUG
-#else
-#undef CARM_DEBUG
-#undef CARM_VERBOSE_DEBUG
-#endif
-#undef CARM_NDEBUG
-
-#define DRV_NAME "sx8"
-#define DRV_VERSION "1.0"
-#define PFX DRV_NAME ": "
-
-MODULE_AUTHOR("Jeff Garzik");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Promise SATA SX8 block driver");
-MODULE_VERSION(DRV_VERSION);
-
-/*
- * SX8 hardware has a single message queue for all ATA ports.
- * When this driver was written, the hardware (firmware?) would
- * corrupt data eventually, if more than one request was outstanding.
- * As one can imagine, having 8 ports bottlenecking on a single
- * command hurts performance.
- *
- * Based on user reports, later versions of the hardware (firmware?)
- * seem to be able to survive with more than one command queued.
- *
- * Therefore, we default to the safe option -- 1 command -- but
- * allow the user to increase this.
- *
- * SX8 should be able to support up to ~60 queued commands (CARM_MAX_REQ),
- * but problems seem to occur when you exceed ~30, even on newer hardware.
- */
-static int max_queue = 1;
-module_param(max_queue, int, 0444);
-MODULE_PARM_DESC(max_queue, "Maximum number of queued commands. (min==1, max==30, safe==1)");
-
-
-#define NEXT_RESP(idx)	((idx + 1) % RMSG_Q_LEN)
-
-/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */
-#define TAG_ENCODE(tag)	(((tag) << 16) | 0xf)
-#define TAG_DECODE(tag)	(((tag) >> 16) & 0x1f)
-#define TAG_VALID(tag)	((((tag) & 0xf) == 0xf) && (TAG_DECODE(tag) < 32))
-
-/* note: prints function name for you */
-#ifdef CARM_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#ifdef CARM_VERBOSE_DEBUG
-#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_VERBOSE_DEBUG */
-#else
-#define DPRINTK(fmt, args...)
-#define VPRINTK(fmt, args...)
-#endif	/* CARM_DEBUG */
-
-#ifdef CARM_NDEBUG
-#define assert(expr)
-#else
-#define assert(expr) \
-        if(unlikely(!(expr))) {                                   \
-        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
-	#expr, __FILE__, __func__, __LINE__);          \
-        }
-#endif
-
-/* defines only for the constants which don't work well as enums */
-struct carm_host;
-
-enum {
-	/* adapter-wide limits */
-	CARM_MAX_PORTS		= 8,
-	CARM_SHM_SIZE		= (4096 << 7),
-	CARM_MINORS_PER_MAJOR	= 256 / CARM_MAX_PORTS,
-	CARM_MAX_WAIT_Q		= CARM_MAX_PORTS + 1,
-
-	/* command message queue limits */
-	CARM_MAX_REQ		= 64,	       /* max command msgs per host */
-	CARM_MSG_LOW_WATER	= (CARM_MAX_REQ / 4),	     /* refill mark */
-
-	/* S/G limits, host-wide and per-request */
-	CARM_MAX_REQ_SG		= 32,	     /* max s/g entries per request */
-	CARM_MAX_HOST_SG	= 600,		/* max s/g entries per host */
-	CARM_SG_LOW_WATER	= (CARM_MAX_HOST_SG / 4),   /* re-fill mark */
-
-	/* hardware registers */
-	CARM_IHQP		= 0x1c,
-	CARM_INT_STAT		= 0x10, /* interrupt status */
-	CARM_INT_MASK		= 0x14, /* interrupt mask */
-	CARM_HMUC		= 0x18, /* host message unit control */
-	RBUF_ADDR_LO		= 0x20, /* response msg DMA buf low 32 bits */
-	RBUF_ADDR_HI		= 0x24, /* response msg DMA buf high 32 bits */
-	RBUF_BYTE_SZ		= 0x28,
-	CARM_RESP_IDX		= 0x2c,
-	CARM_CMS0		= 0x30, /* command message size reg 0 */
-	CARM_LMUC		= 0x48,
-	CARM_HMPHA		= 0x6c,
-	CARM_INITC		= 0xb5,
-
-	/* bits in CARM_INT_{STAT,MASK} */
-	INT_RESERVED		= 0xfffffff0,
-	INT_WATCHDOG		= (1 << 3),	/* watchdog timer */
-	INT_Q_OVERFLOW		= (1 << 2),	/* cmd msg q overflow */
-	INT_Q_AVAILABLE		= (1 << 1),	/* cmd msg q has free space */
-	INT_RESPONSE		= (1 << 0),	/* response msg available */
-	INT_ACK_MASK		= INT_WATCHDOG | INT_Q_OVERFLOW,
-	INT_DEF_MASK		= INT_RESERVED | INT_Q_OVERFLOW |
-				  INT_RESPONSE,
-
-	/* command messages, and related register bits */
-	CARM_HAVE_RESP		= 0x01,
-	CARM_MSG_READ		= 1,
-	CARM_MSG_WRITE		= 2,
-	CARM_MSG_VERIFY		= 3,
-	CARM_MSG_GET_CAPACITY	= 4,
-	CARM_MSG_FLUSH		= 5,
-	CARM_MSG_IOCTL		= 6,
-	CARM_MSG_ARRAY		= 8,
-	CARM_MSG_MISC		= 9,
-	CARM_CME		= (1 << 2),
-	CARM_RME		= (1 << 1),
-	CARM_WZBC		= (1 << 0),
-	CARM_RMI		= (1 << 0),
-	CARM_Q_FULL		= (1 << 3),
-	CARM_MSG_SIZE		= 288,
-	CARM_Q_LEN		= 48,
-
-	/* CARM_MSG_IOCTL messages */
-	CARM_IOC_SCAN_CHAN	= 5,	/* scan channels for devices */
-	CARM_IOC_GET_TCQ	= 13,	/* get tcq/ncq depth */
-	CARM_IOC_SET_TCQ	= 14,	/* set tcq/ncq depth */
-
-	IOC_SCAN_CHAN_NODEV	= 0x1f,
-	IOC_SCAN_CHAN_OFFSET	= 0x40,
-
-	/* CARM_MSG_ARRAY messages */
-	CARM_ARRAY_INFO		= 0,
-
-	ARRAY_NO_EXIST		= (1 << 31),
-
-	/* response messages */
-	RMSG_SZ			= 8,	/* sizeof(struct carm_response) */
-	RMSG_Q_LEN		= 48,	/* resp. msg list length */
-	RMSG_OK			= 1,	/* bit indicating msg was successful */
-					/* length of entire resp. msg buffer */
-	RBUF_LEN		= RMSG_SZ * RMSG_Q_LEN,
-
-	PDC_SHM_SIZE		= (4096 << 7), /* length of entire h/w buffer */
-
-	/* CARM_MSG_MISC messages */
-	MISC_GET_FW_VER		= 2,
-	MISC_ALLOC_MEM		= 3,
-	MISC_SET_TIME		= 5,
-
-	/* MISC_GET_FW_VER feature bits */
-	FW_VER_4PORT		= (1 << 2), /* 1=4 ports, 0=8 ports */
-	FW_VER_NON_RAID		= (1 << 1), /* 1=non-RAID firmware, 0=RAID */
-	FW_VER_ZCR		= (1 << 0), /* zero channel RAID (whatever that is) */
-
-	/* carm_host flags */
-	FL_NON_RAID		= FW_VER_NON_RAID,
-	FL_4PORT		= FW_VER_4PORT,
-	FL_FW_VER_MASK		= (FW_VER_NON_RAID | FW_VER_4PORT),
-	FL_DYN_MAJOR		= (1 << 17),
-};
-
-enum {
-	CARM_SG_BOUNDARY	= 0xffffUL,	    /* s/g segment boundary */
-};
-
-enum scatter_gather_types {
-	SGT_32BIT		= 0,
-	SGT_64BIT		= 1,
-};
-
-enum host_states {
-	HST_INVALID,		/* invalid state; never used */
-	HST_ALLOC_BUF,		/* setting up master SHM area */
-	HST_ERROR,		/* we never leave here */
-	HST_PORT_SCAN,		/* start dev scan */
-	HST_DEV_SCAN_START,	/* start per-device probe */
-	HST_DEV_SCAN,		/* continue per-device probe */
-	HST_DEV_ACTIVATE,	/* activate devices we found */
-	HST_PROBE_FINISHED,	/* probe is complete */
-	HST_PROBE_START,	/* initiate probe */
-	HST_SYNC_TIME,		/* tell firmware what time it is */
-	HST_GET_FW_VER,		/* get firmware version, adapter port cnt */
-};
-
-#ifdef CARM_DEBUG
-static const char *state_name[] = {
-	"HST_INVALID",
-	"HST_ALLOC_BUF",
-	"HST_ERROR",
-	"HST_PORT_SCAN",
-	"HST_DEV_SCAN_START",
-	"HST_DEV_SCAN",
-	"HST_DEV_ACTIVATE",
-	"HST_PROBE_FINISHED",
-	"HST_PROBE_START",
-	"HST_SYNC_TIME",
-	"HST_GET_FW_VER",
-};
-#endif
-
-struct carm_port {
-	unsigned int			port_no;
-	struct gendisk			*disk;
-	struct carm_host		*host;
-
-	/* attached device characteristics */
-	u64				capacity;
-	char				name[41];
-	u16				dev_geom_head;
-	u16				dev_geom_sect;
-	u16				dev_geom_cyl;
-};
-
-struct carm_request {
-	int				n_elem;
-	unsigned int			msg_type;
-	unsigned int			msg_subtype;
-	unsigned int			msg_bucket;
-	struct scatterlist		sg[CARM_MAX_REQ_SG];
-};
-
-struct carm_host {
-	unsigned long			flags;
-	void				__iomem *mmio;
-	void				*shm;
-	dma_addr_t			shm_dma;
-
-	int				major;
-	int				id;
-	char				name[32];
-
-	spinlock_t			lock;
-	struct pci_dev			*pdev;
-	unsigned int			state;
-	u32				fw_ver;
-
-	struct blk_mq_tag_set		tag_set;
-	struct request_queue		*oob_q;
-	unsigned int			n_oob;
-
-	unsigned int			hw_sg_used;
-
-	unsigned int			resp_idx;
-
-	unsigned int			wait_q_prod;
-	unsigned int			wait_q_cons;
-	struct request_queue		*wait_q[CARM_MAX_WAIT_Q];
-
-	void				*msg_base;
-	dma_addr_t			msg_dma;
-
-	int				cur_scan_dev;
-	unsigned long			dev_active;
-	unsigned long			dev_present;
-	struct carm_port		port[CARM_MAX_PORTS];
-
-	struct work_struct		fsm_task;
-
-	struct completion		probe_comp;
-};
-
-struct carm_response {
-	__le32 ret_handle;
-	__le32 status;
-}  __attribute__((packed));
-
-struct carm_msg_sg {
-	__le32 start;
-	__le32 len;
-}  __attribute__((packed));
-
-struct carm_msg_rw {
-	u8 type;
-	u8 id;
-	u8 sg_count;
-	u8 sg_type;
-	__le32 handle;
-	__le32 lba;
-	__le16 lba_count;
-	__le16 lba_high;
-	struct carm_msg_sg sg[32];
-}  __attribute__((packed));
-
-struct carm_msg_allocbuf {
-	u8 type;
-	u8 subtype;
-	u8 n_sg;
-	u8 sg_type;
-	__le32 handle;
-	__le32 addr;
-	__le32 len;
-	__le32 evt_pool;
-	__le32 n_evt;
-	__le32 rbuf_pool;
-	__le32 n_rbuf;
-	__le32 msg_pool;
-	__le32 n_msg;
-	struct carm_msg_sg sg[8];
-}  __attribute__((packed));
-
-struct carm_msg_ioctl {
-	u8 type;
-	u8 subtype;
-	u8 array_id;
-	u8 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_msg_sync_time {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	u32 reserved2;
-	__le32 timestamp;
-}  __attribute__((packed));
-
-struct carm_msg_get_fw_ver {
-	u8 type;
-	u8 subtype;
-	u16 reserved1;
-	__le32 handle;
-	__le32 data_addr;
-	u32 reserved2;
-}  __attribute__((packed));
-
-struct carm_fw_ver {
-	__le32 version;
-	u8 features;
-	u8 reserved1;
-	u16 reserved2;
-}  __attribute__((packed));
-
-struct carm_array_info {
-	__le32 size;
-
-	__le16 size_hi;
-	__le16 stripe_size;
-
-	__le32 mode;
-
-	__le16 stripe_blk_sz;
-	__le16 reserved1;
-
-	__le16 cyl;
-	__le16 head;
-
-	__le16 sect;
-	u8 array_id;
-	u8 reserved2;
-
-	char name[40];
-
-	__le32 array_status;
-
-	/* device list continues beyond this point? */
-}  __attribute__((packed));
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void carm_remove_one (struct pci_dev *pdev);
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo);
-
-static const struct pci_device_id carm_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x8000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ PCI_VENDOR_ID_PROMISE, 0x8002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
-	{ }	/* terminate list */
-};
-MODULE_DEVICE_TABLE(pci, carm_pci_tbl);
-
-static struct pci_driver carm_driver = {
-	.name		= DRV_NAME,
-	.id_table	= carm_pci_tbl,
-	.probe		= carm_init_one,
-	.remove		= carm_remove_one,
-};
-
-static const struct block_device_operations carm_bd_ops = {
-	.owner		= THIS_MODULE,
-	.getgeo		= carm_bdev_getgeo,
-};
-
-static unsigned int carm_host_id;
-static unsigned long carm_major_alloc;
-
-
-
-static int carm_bdev_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-{
-	struct carm_port *port = bdev->bd_disk->private_data;
-
-	geo->heads = (u8) port->dev_geom_head;
-	geo->sectors = (u8) port->dev_geom_sect;
-	geo->cylinders = port->dev_geom_cyl;
-	return 0;
-}
-
-static const u32 msg_sizes[] = { 32, 64, 128, CARM_MSG_SIZE };
-
-static inline int carm_lookup_bucket(u32 msg_size)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		if (msg_size <= msg_sizes[i])
-			return i;
-
-	return -ENOENT;
-}
-
-static void carm_init_buckets(void __iomem *mmio)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(msg_sizes); i++)
-		writel(msg_sizes[i], mmio + CARM_CMS0 + (4 * i));
-}
-
-static inline void *carm_ref_msg(struct carm_host *host,
-				 unsigned int msg_idx)
-{
-	return host->msg_base + (msg_idx * CARM_MSG_SIZE);
-}
-
-static inline dma_addr_t carm_ref_msg_dma(struct carm_host *host,
-					  unsigned int msg_idx)
-{
-	return host->msg_dma + (msg_idx * CARM_MSG_SIZE);
-}
-
-static int carm_send_msg(struct carm_host *host,
-			 struct carm_request *crq, unsigned tag)
-{
-	void __iomem *mmio = host->mmio;
-	u32 msg = (u32) carm_ref_msg_dma(host, tag);
-	u32 cm_bucket = crq->msg_bucket;
-	u32 tmp;
-	int rc = 0;
-
-	VPRINTK("ENTER\n");
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_Q_FULL) {
-#if 0
-		tmp = readl(mmio + CARM_INT_MASK);
-		tmp |= INT_Q_AVAILABLE;
-		writel(tmp, mmio + CARM_INT_MASK);
-		readl(mmio + CARM_INT_MASK);	/* flush */
-#endif
-		DPRINTK("host msg queue full\n");
-		rc = -EBUSY;
-	} else {
-		writel(msg | (cm_bucket << 1), mmio + CARM_IHQP);
-		readl(mmio + CARM_IHQP);	/* flush */
-	}
-
-	return rc;
-}
-
-static int carm_array_info (struct carm_host *host, unsigned int array_idx)
-{
-	struct carm_msg_ioctl *ioc;
-	u32 msg_data;
-	dma_addr_t msg_dma;
-	struct carm_request *crq;
-	struct request *rq;
-	int rc;
-
-	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq)) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-	crq = blk_mq_rq_to_pdu(rq);
-
-	ioc = carm_ref_msg(host, rq->tag);
-	msg_dma = carm_ref_msg_dma(host, rq->tag);
-	msg_data = (u32) (msg_dma + sizeof(struct carm_array_info));
-
-	crq->msg_type = CARM_MSG_ARRAY;
-	crq->msg_subtype = CARM_ARRAY_INFO;
-	rc = carm_lookup_bucket(sizeof(struct carm_msg_ioctl) +
-				sizeof(struct carm_array_info));
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_ARRAY;
-	ioc->subtype	= CARM_ARRAY_INFO;
-	ioc->array_id	= (u8) array_idx;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_DEV_SCAN_START ||
-	       host->state == HST_DEV_SCAN);
-	spin_unlock_irq(&host->lock);
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
-
-	return 0;
-
-err_out:
-	spin_lock_irq(&host->lock);
-	host->state = HST_ERROR;
-	spin_unlock_irq(&host->lock);
-	return rc;
-}
-
-typedef unsigned int (*carm_sspc_t)(struct carm_host *, unsigned int, void *);
-
-static int carm_send_special (struct carm_host *host, carm_sspc_t func)
-{
-	struct request *rq;
-	struct carm_request *crq;
-	struct carm_msg_ioctl *ioc;
-	void *mem;
-	unsigned int msg_size;
-	int rc;
-
-	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq))
-		return -ENOMEM;
-	crq = blk_mq_rq_to_pdu(rq);
-
-	mem = carm_ref_msg(host, rq->tag);
-
-	msg_size = func(host, rq->tag, mem);
-
-	ioc = mem;
-	crq->msg_type = ioc->type;
-	crq->msg_subtype = ioc->subtype;
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
-
-	return 0;
-}
-
-static unsigned int carm_fill_sync_time(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_sync_time *st = mem;
-
-	time64_t tv = ktime_get_real_seconds();
-
-	memset(st, 0, sizeof(*st));
-	st->type	= CARM_MSG_MISC;
-	st->subtype	= MISC_SET_TIME;
-	st->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	st->timestamp	= cpu_to_le32(tv);
-
-	return sizeof(struct carm_msg_sync_time);
-}
-
-static unsigned int carm_fill_alloc_buf(struct carm_host *host,
-					unsigned int idx, void *mem)
-{
-	struct carm_msg_allocbuf *ab = mem;
-
-	memset(ab, 0, sizeof(*ab));
-	ab->type	= CARM_MSG_MISC;
-	ab->subtype	= MISC_ALLOC_MEM;
-	ab->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ab->n_sg	= 1;
-	ab->sg_type	= SGT_32BIT;
-	ab->addr	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->len		= cpu_to_le32(PDC_SHM_SIZE >> 1);
-	ab->evt_pool	= cpu_to_le32(host->shm_dma + (16 * 1024));
-	ab->n_evt	= cpu_to_le32(1024);
-	ab->rbuf_pool	= cpu_to_le32(host->shm_dma);
-	ab->n_rbuf	= cpu_to_le32(RMSG_Q_LEN);
-	ab->msg_pool	= cpu_to_le32(host->shm_dma + RBUF_LEN);
-	ab->n_msg	= cpu_to_le32(CARM_Q_LEN);
-	ab->sg[0].start	= cpu_to_le32(host->shm_dma + (PDC_SHM_SIZE >> 1));
-	ab->sg[0].len	= cpu_to_le32(65536);
-
-	return sizeof(struct carm_msg_allocbuf);
-}
-
-static unsigned int carm_fill_scan_channels(struct carm_host *host,
-					    unsigned int idx, void *mem)
-{
-	struct carm_msg_ioctl *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) +
-			      IOC_SCAN_CHAN_OFFSET);
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_IOCTL;
-	ioc->subtype	= CARM_IOC_SCAN_CHAN;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	/* fill output data area with "no device" default values */
-	mem += IOC_SCAN_CHAN_OFFSET;
-	memset(mem, IOC_SCAN_CHAN_NODEV, CARM_MAX_PORTS);
-
-	return IOC_SCAN_CHAN_OFFSET + CARM_MAX_PORTS;
-}
-
-static unsigned int carm_fill_get_fw_ver(struct carm_host *host,
-					 unsigned int idx, void *mem)
-{
-	struct carm_msg_get_fw_ver *ioc = mem;
-	u32 msg_data = (u32) (carm_ref_msg_dma(host, idx) + sizeof(*ioc));
-
-	memset(ioc, 0, sizeof(*ioc));
-	ioc->type	= CARM_MSG_MISC;
-	ioc->subtype	= MISC_GET_FW_VER;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
-	ioc->data_addr	= cpu_to_le32(msg_data);
-
-	return sizeof(struct carm_msg_get_fw_ver) +
-	       sizeof(struct carm_fw_ver);
-}
-
-static inline void carm_push_q (struct carm_host *host, struct request_queue *q)
-{
-	unsigned int idx = host->wait_q_prod % CARM_MAX_WAIT_Q;
-
-	blk_mq_stop_hw_queues(q);
-	VPRINTK("STOPPED QUEUE %p\n", q);
-
-	host->wait_q[idx] = q;
-	host->wait_q_prod++;
-	BUG_ON(host->wait_q_prod == host->wait_q_cons); /* overrun */
-}
-
-static inline struct request_queue *carm_pop_q(struct carm_host *host)
-{
-	unsigned int idx;
-
-	if (host->wait_q_prod == host->wait_q_cons)
-		return NULL;
-
-	idx = host->wait_q_cons % CARM_MAX_WAIT_Q;
-	host->wait_q_cons++;
-
-	return host->wait_q[idx];
-}
-
-static inline void carm_round_robin(struct carm_host *host)
-{
-	struct request_queue *q = carm_pop_q(host);
-	if (q) {
-		blk_mq_start_hw_queues(q);
-		VPRINTK("STARTED QUEUE %p\n", q);
-	}
-}
-
-static inline enum dma_data_direction carm_rq_dir(struct request *rq)
-{
-	return op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
-}
-
-static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
-				  const struct blk_mq_queue_data *bd)
-{
-	struct request_queue *q = hctx->queue;
-	struct request *rq = bd->rq;
-	struct carm_port *port = q->queuedata;
-	struct carm_host *host = port->host;
-	struct carm_request *crq = blk_mq_rq_to_pdu(rq);
-	struct carm_msg_rw *msg;
-	struct scatterlist *sg;
-	int i, n_elem = 0, rc;
-	unsigned int msg_size;
-	u32 tmp;
-
-	crq->n_elem = 0;
-	sg_init_table(crq->sg, CARM_MAX_REQ_SG);
-
-	blk_mq_start_request(rq);
-
-	spin_lock_irq(&host->lock);
-	if (req_op(rq) == REQ_OP_DRV_OUT)
-		goto send_msg;
-
-	/* get scatterlist from block layer */
-	sg = &crq->sg[0];
-	n_elem = blk_rq_map_sg(q, rq, sg);
-	if (n_elem <= 0)
-		goto out_ioerr;
-
-	/* map scatterlist to PCI bus addresses */
-	n_elem = dma_map_sg(&host->pdev->dev, sg, n_elem, carm_rq_dir(rq));
-	if (n_elem <= 0)
-		goto out_ioerr;
-
-	/* obey global hardware limit on S/G entries */
-	if (host->hw_sg_used >= CARM_MAX_HOST_SG - n_elem)
-		goto out_resource;
-
-	crq->n_elem = n_elem;
-	host->hw_sg_used += n_elem;
-
-	/*
-	 * build read/write message
-	 */
-
-	VPRINTK("build msg\n");
-	msg = (struct carm_msg_rw *) carm_ref_msg(host, rq->tag);
-
-	if (rq_data_dir(rq) == WRITE) {
-		msg->type = CARM_MSG_WRITE;
-		crq->msg_type = CARM_MSG_WRITE;
-	} else {
-		msg->type = CARM_MSG_READ;
-		crq->msg_type = CARM_MSG_READ;
-	}
-
-	msg->id		= port->port_no;
-	msg->sg_count	= n_elem;
-	msg->sg_type	= SGT_32BIT;
-	msg->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
-	msg->lba	= cpu_to_le32(blk_rq_pos(rq) & 0xffffffff);
-	tmp		= (blk_rq_pos(rq) >> 16) >> 16;
-	msg->lba_high	= cpu_to_le16( (u16) tmp );
-	msg->lba_count	= cpu_to_le16(blk_rq_sectors(rq));
-
-	msg_size = sizeof(struct carm_msg_rw) - sizeof(msg->sg);
-	for (i = 0; i < n_elem; i++) {
-		struct carm_msg_sg *carm_sg = &msg->sg[i];
-		carm_sg->start = cpu_to_le32(sg_dma_address(&crq->sg[i]));
-		carm_sg->len = cpu_to_le32(sg_dma_len(&crq->sg[i]));
-		msg_size += sizeof(struct carm_msg_sg);
-	}
-
-	rc = carm_lookup_bucket(msg_size);
-	BUG_ON(rc < 0);
-	crq->msg_bucket = (u32) rc;
-send_msg:
-	/*
-	 * queue read/write message to hardware
-	 */
-	VPRINTK("send msg, tag == %u\n", rq->tag);
-	rc = carm_send_msg(host, crq, rq->tag);
-	if (rc) {
-		host->hw_sg_used -= n_elem;
-		goto out_resource;
-	}
-
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_OK;
-out_resource:
-	dma_unmap_sg(&host->pdev->dev, &crq->sg[0], n_elem, carm_rq_dir(rq));
-	carm_push_q(host, q);
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_DEV_RESOURCE;
-out_ioerr:
-	carm_round_robin(host);
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_IOERR;
-}
-
-static void carm_handle_array_info(struct carm_host *host,
-				   struct carm_request *crq, u8 *mem,
-				   blk_status_t error)
-{
-	struct carm_port *port;
-	u8 *msg_data = mem + sizeof(struct carm_array_info);
-	struct carm_array_info *desc = (struct carm_array_info *) msg_data;
-	u64 lo, hi;
-	int cur_port;
-	size_t slen;
-
-	DPRINTK("ENTER\n");
-
-	if (error)
-		goto out;
-	if (le32_to_cpu(desc->array_status) & ARRAY_NO_EXIST)
-		goto out;
-
-	cur_port = host->cur_scan_dev;
-
-	/* should never occur */
-	if ((cur_port < 0) || (cur_port >= CARM_MAX_PORTS)) {
-		printk(KERN_ERR PFX "BUG: cur_scan_dev==%d, array_id==%d\n",
-		       cur_port, (int) desc->array_id);
-		goto out;
-	}
-
-	port = &host->port[cur_port];
-
-	lo = (u64) le32_to_cpu(desc->size);
-	hi = (u64) le16_to_cpu(desc->size_hi);
-
-	port->capacity = lo | (hi << 32);
-	port->dev_geom_head = le16_to_cpu(desc->head);
-	port->dev_geom_sect = le16_to_cpu(desc->sect);
-	port->dev_geom_cyl = le16_to_cpu(desc->cyl);
-
-	host->dev_active |= (1 << cur_port);
-
-	strncpy(port->name, desc->name, sizeof(port->name));
-	port->name[sizeof(port->name) - 1] = 0;
-	slen = strlen(port->name);
-	while (slen && (port->name[slen - 1] == ' ')) {
-		port->name[slen - 1] = 0;
-		slen--;
-	}
-
-	printk(KERN_INFO DRV_NAME "(%s): port %u device %Lu sectors\n",
-	       pci_name(host->pdev), port->port_no,
-	       (unsigned long long) port->capacity);
-	printk(KERN_INFO DRV_NAME "(%s): port %u device \"%s\"\n",
-	       pci_name(host->pdev), port->port_no, port->name);
-
-out:
-	assert(host->state == HST_DEV_SCAN);
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_scan_chan(struct carm_host *host,
-				  struct carm_request *crq, u8 *mem,
-				  blk_status_t error)
-{
-	u8 *msg_data = mem + IOC_SCAN_CHAN_OFFSET;
-	unsigned int i, dev_count = 0;
-	int new_state = HST_DEV_SCAN_START;
-
-	DPRINTK("ENTER\n");
-
-	if (error) {
-		new_state = HST_ERROR;
-		goto out;
-	}
-
-	/* TODO: scan and support non-disk devices */
-	for (i = 0; i < 8; i++)
-		if (msg_data[i] == 0) { /* direct-access device (disk) */
-			host->dev_present |= (1 << i);
-			dev_count++;
-		}
-
-	printk(KERN_INFO DRV_NAME "(%s): found %u interesting devices\n",
-	       pci_name(host->pdev), dev_count);
-
-out:
-	assert(host->state == HST_PORT_SCAN);
-	host->state = new_state;
-	schedule_work(&host->fsm_task);
-}
-
-static void carm_handle_generic(struct carm_host *host,
-				struct carm_request *crq, blk_status_t error,
-				int cur_state, int next_state)
-{
-	DPRINTK("ENTER\n");
-
-	assert(host->state == cur_state);
-	if (error)
-		host->state = HST_ERROR;
-	else
-		host->state = next_state;
-	schedule_work(&host->fsm_task);
-}
-
-static inline void carm_handle_resp(struct carm_host *host,
-				    __le32 ret_handle_le, u32 status)
-{
-	u32 handle = le32_to_cpu(ret_handle_le);
-	unsigned int msg_idx;
-	struct request *rq;
-	struct carm_request *crq;
-	blk_status_t error = (status == RMSG_OK) ? 0 : BLK_STS_IOERR;
-	u8 *mem;
-
-	VPRINTK("ENTER, handle == 0x%x\n", handle);
-
-	if (unlikely(!TAG_VALID(handle))) {
-		printk(KERN_ERR DRV_NAME "(%s): BUG: invalid tag 0x%x\n",
-		       pci_name(host->pdev), handle);
-		return;
-	}
-
-	msg_idx = TAG_DECODE(handle);
-	VPRINTK("tag == %u\n", msg_idx);
-
-	rq = blk_mq_tag_to_rq(host->tag_set.tags[0], msg_idx);
-	crq = blk_mq_rq_to_pdu(rq);
-
-	/* fast path */
-	if (likely(crq->msg_type == CARM_MSG_READ ||
-		   crq->msg_type == CARM_MSG_WRITE)) {
-		dma_unmap_sg(&host->pdev->dev, &crq->sg[0], crq->n_elem,
-			     carm_rq_dir(rq));
-		goto done;
-	}
-
-	mem = carm_ref_msg(host, msg_idx);
-
-	switch (crq->msg_type) {
-	case CARM_MSG_IOCTL: {
-		switch (crq->msg_subtype) {
-		case CARM_IOC_SCAN_CHAN:
-			carm_handle_scan_chan(host, crq, mem, error);
-			goto done;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_MISC: {
-		switch (crq->msg_subtype) {
-		case MISC_ALLOC_MEM:
-			carm_handle_generic(host, crq, error,
-					    HST_ALLOC_BUF, HST_SYNC_TIME);
-			goto done;
-		case MISC_SET_TIME:
-			carm_handle_generic(host, crq, error,
-					    HST_SYNC_TIME, HST_GET_FW_VER);
-			goto done;
-		case MISC_GET_FW_VER: {
-			struct carm_fw_ver *ver = (struct carm_fw_ver *)
-				(mem + sizeof(struct carm_msg_get_fw_ver));
-			if (!error) {
-				host->fw_ver = le32_to_cpu(ver->version);
-				host->flags |= (ver->features & FL_FW_VER_MASK);
-			}
-			carm_handle_generic(host, crq, error,
-					    HST_GET_FW_VER, HST_PORT_SCAN);
-			goto done;
-		}
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	case CARM_MSG_ARRAY: {
-		switch (crq->msg_subtype) {
-		case CARM_ARRAY_INFO:
-			carm_handle_array_info(host, crq, mem, error);
-			break;
-		default:
-			/* unknown / invalid response */
-			goto err_out;
-		}
-		break;
-	}
-
-	default:
-		/* unknown / invalid response */
-		goto err_out;
-	}
-
-	return;
-
-err_out:
-	printk(KERN_WARNING DRV_NAME "(%s): BUG: unhandled message type %d/%d\n",
-	       pci_name(host->pdev), crq->msg_type, crq->msg_subtype);
-	error = BLK_STS_IOERR;
-done:
-	host->hw_sg_used -= crq->n_elem;
-	blk_mq_end_request(blk_mq_rq_from_pdu(crq), error);
-
-	if (host->hw_sg_used <= CARM_SG_LOW_WATER)
-		carm_round_robin(host);
-}
-
-static inline void carm_handle_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-	unsigned int work = 0;
-	unsigned int idx = host->resp_idx % RMSG_Q_LEN;
-
-	while (1) {
-		u32 status = le32_to_cpu(resp[idx].status);
-
-		if (status == 0xffffffff) {
-			VPRINTK("ending response on index %u\n", idx);
-			writel(idx << 3, mmio + CARM_RESP_IDX);
-			break;
-		}
-
-		/* response to a message we sent */
-		else if ((status & (1 << 31)) == 0) {
-			VPRINTK("handling msg response on index %u\n", idx);
-			carm_handle_resp(host, resp[idx].ret_handle, status);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		/* asynchronous events the hardware throws our way */
-		else if ((status & 0xff000000) == (1 << 31)) {
-			u8 *evt_type_ptr = (u8 *) &resp[idx];
-			u8 evt_type = *evt_type_ptr;
-			printk(KERN_WARNING DRV_NAME "(%s): unhandled event type %d\n",
-			       pci_name(host->pdev), (int) evt_type);
-			resp[idx].status = cpu_to_le32(0xffffffff);
-		}
-
-		idx = NEXT_RESP(idx);
-		work++;
-	}
-
-	VPRINTK("EXIT, work==%u\n", work);
-	host->resp_idx += work;
-}
-
-static irqreturn_t carm_interrupt(int irq, void *__host)
-{
-	struct carm_host *host = __host;
-	void __iomem *mmio;
-	u32 mask;
-	int handled = 0;
-	unsigned long flags;
-
-	if (!host) {
-		VPRINTK("no host\n");
-		return IRQ_NONE;
-	}
-
-	spin_lock_irqsave(&host->lock, flags);
-
-	mmio = host->mmio;
-
-	/* reading should also clear interrupts */
-	mask = readl(mmio + CARM_INT_STAT);
-
-	if (mask == 0 || mask == 0xffffffff) {
-		VPRINTK("no work, mask == 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & INT_ACK_MASK)
-		writel(mask, mmio + CARM_INT_STAT);
-
-	if (unlikely(host->state == HST_INVALID)) {
-		VPRINTK("not initialized yet, mask = 0x%x\n", mask);
-		goto out;
-	}
-
-	if (mask & CARM_HAVE_RESP) {
-		handled = 1;
-		carm_handle_responses(host);
-	}
-
-out:
-	spin_unlock_irqrestore(&host->lock, flags);
-	VPRINTK("EXIT\n");
-	return IRQ_RETVAL(handled);
-}
-
-static void carm_fsm_task (struct work_struct *work)
-{
-	struct carm_host *host =
-		container_of(work, struct carm_host, fsm_task);
-	unsigned long flags;
-	unsigned int state;
-	int rc, i, next_dev;
-	int reschedule = 0;
-	int new_state = HST_INVALID;
-
-	spin_lock_irqsave(&host->lock, flags);
-	state = host->state;
-	spin_unlock_irqrestore(&host->lock, flags);
-
-	DPRINTK("ENTER, state == %s\n", state_name[state]);
-
-	switch (state) {
-	case HST_PROBE_START:
-		new_state = HST_ALLOC_BUF;
-		reschedule = 1;
-		break;
-
-	case HST_ALLOC_BUF:
-		rc = carm_send_special(host, carm_fill_alloc_buf);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_SYNC_TIME:
-		rc = carm_send_special(host, carm_fill_sync_time);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_GET_FW_VER:
-		rc = carm_send_special(host, carm_fill_get_fw_ver);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_PORT_SCAN:
-		rc = carm_send_special(host, carm_fill_scan_channels);
-		if (rc) {
-			new_state = HST_ERROR;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_SCAN_START:
-		host->cur_scan_dev = -1;
-		new_state = HST_DEV_SCAN;
-		reschedule = 1;
-		break;
-
-	case HST_DEV_SCAN:
-		next_dev = -1;
-		for (i = host->cur_scan_dev + 1; i < CARM_MAX_PORTS; i++)
-			if (host->dev_present & (1 << i)) {
-				next_dev = i;
-				break;
-			}
-
-		if (next_dev >= 0) {
-			host->cur_scan_dev = next_dev;
-			rc = carm_array_info(host, next_dev);
-			if (rc) {
-				new_state = HST_ERROR;
-				reschedule = 1;
-			}
-		} else {
-			new_state = HST_DEV_ACTIVATE;
-			reschedule = 1;
-		}
-		break;
-
-	case HST_DEV_ACTIVATE: {
-		int activated = 0;
-		for (i = 0; i < CARM_MAX_PORTS; i++)
-			if (host->dev_active & (1 << i)) {
-				struct carm_port *port = &host->port[i];
-				struct gendisk *disk = port->disk;
-
-				set_capacity(disk, port->capacity);
-				add_disk(disk);
-				activated++;
-			}
-
-		printk(KERN_INFO DRV_NAME "(%s): %d ports activated\n",
-		       pci_name(host->pdev), activated);
-
-		new_state = HST_PROBE_FINISHED;
-		reschedule = 1;
-		break;
-	}
-
-	case HST_PROBE_FINISHED:
-		complete(&host->probe_comp);
-		break;
-
-	case HST_ERROR:
-		/* FIXME: TODO */
-		break;
-
-	default:
-		/* should never occur */
-		printk(KERN_ERR PFX "BUG: unknown state %d\n", state);
-		assert(0);
-		break;
-	}
-
-	if (new_state != HST_INVALID) {
-		spin_lock_irqsave(&host->lock, flags);
-		host->state = new_state;
-		spin_unlock_irqrestore(&host->lock, flags);
-	}
-	if (reschedule)
-		schedule_work(&host->fsm_task);
-}
-
-static int carm_init_wait(void __iomem *mmio, u32 bits, unsigned int test_bit)
-{
-	unsigned int i;
-
-	for (i = 0; i < 50000; i++) {
-		u32 tmp = readl(mmio + CARM_LMUC);
-		udelay(100);
-
-		if (test_bit) {
-			if ((tmp & bits) == bits)
-				return 0;
-		} else {
-			if ((tmp & bits) == 0)
-				return 0;
-		}
-
-		cond_resched();
-	}
-
-	printk(KERN_ERR PFX "carm_init_wait timeout, bits == 0x%x, test_bit == %s\n",
-	       bits, test_bit ? "yes" : "no");
-	return -EBUSY;
-}
-
-static void carm_init_responses(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	unsigned int i;
-	struct carm_response *resp = (struct carm_response *) host->shm;
-
-	for (i = 0; i < RMSG_Q_LEN; i++)
-		resp[i].status = cpu_to_le32(0xffffffff);
-
-	writel(0, mmio + CARM_RESP_IDX);
-}
-
-static int carm_init_host(struct carm_host *host)
-{
-	void __iomem *mmio = host->mmio;
-	u32 tmp;
-	u8 tmp8;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	writel(0, mmio + CARM_INT_MASK);
-
-	tmp8 = readb(mmio + CARM_INITC);
-	if (tmp8 & 0x01) {
-		tmp8 &= ~0x01;
-		writeb(tmp8, mmio + CARM_INITC);
-		readb(mmio + CARM_INITC);	/* flush */
-
-		DPRINTK("snooze...\n");
-		msleep(5000);
-	}
-
-	tmp = readl(mmio + CARM_HMUC);
-	if (tmp & CARM_CME) {
-		DPRINTK("CME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_CME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 1 failed\n");
-			return rc;
-		}
-	}
-	if (tmp & CARM_RME) {
-		DPRINTK("RME bit present, waiting\n");
-		rc = carm_init_wait(mmio, CARM_RME, 1);
-		if (rc) {
-			DPRINTK("EXIT, carm_init_wait 2 failed\n");
-			return rc;
-		}
-	}
-
-	tmp &= ~(CARM_RME | CARM_CME);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 0);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 3 failed\n");
-		return rc;
-	}
-
-	carm_init_buckets(mmio);
-
-	writel(host->shm_dma & 0xffffffff, mmio + RBUF_ADDR_LO);
-	writel((host->shm_dma >> 16) >> 16, mmio + RBUF_ADDR_HI);
-	writel(RBUF_LEN, mmio + RBUF_BYTE_SZ);
-
-	tmp = readl(mmio + CARM_HMUC);
-	tmp |= (CARM_RME | CARM_CME | CARM_WZBC);
-	writel(tmp, mmio + CARM_HMUC);
-	readl(mmio + CARM_HMUC);	/* flush */
-
-	rc = carm_init_wait(mmio, CARM_RME | CARM_CME, 1);
-	if (rc) {
-		DPRINTK("EXIT, carm_init_wait 4 failed\n");
-		return rc;
-	}
-
-	writel(0, mmio + CARM_HMPHA);
-	writel(INT_DEF_MASK, mmio + CARM_INT_MASK);
-
-	carm_init_responses(host);
-
-	/* start initialization, probing state machine */
-	spin_lock_irq(&host->lock);
-	assert(host->state == HST_INVALID);
-	host->state = HST_PROBE_START;
-	spin_unlock_irq(&host->lock);
-	schedule_work(&host->fsm_task);
-
-	DPRINTK("EXIT\n");
-	return 0;
-}
-
-static const struct blk_mq_ops carm_mq_ops = {
-	.queue_rq	= carm_queue_rq,
-};
-
-static int carm_init_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk;
-	struct request_queue *q;
-
-	port->host = host;
-	port->port_no = port_no;
-
-	disk = alloc_disk(CARM_MINORS_PER_MAJOR);
-	if (!disk)
-		return -ENOMEM;
-
-	port->disk = disk;
-	sprintf(disk->disk_name, DRV_NAME "/%u",
-		(unsigned int)host->id * CARM_MAX_PORTS + port_no);
-	disk->major = host->major;
-	disk->first_minor = port_no * CARM_MINORS_PER_MAJOR;
-	disk->fops = &carm_bd_ops;
-	disk->private_data = port;
-
-	q = blk_mq_init_queue(&host->tag_set);
-	if (IS_ERR(q))
-		return PTR_ERR(q);
-
-	blk_queue_max_segments(q, CARM_MAX_REQ_SG);
-	blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
-
-	q->queuedata = port;
-	disk->queue = q;
-	return 0;
-}
-
-static void carm_free_disk(struct carm_host *host, unsigned int port_no)
-{
-	struct carm_port *port = &host->port[port_no];
-	struct gendisk *disk = port->disk;
-
-	if (!disk)
-		return;
-
-	if (disk->flags & GENHD_FL_UP)
-		del_gendisk(disk);
-	if (disk->queue)
-		blk_cleanup_queue(disk->queue);
-	put_disk(disk);
-}
-
-static int carm_init_shm(struct carm_host *host)
-{
-	host->shm = dma_alloc_coherent(&host->pdev->dev, CARM_SHM_SIZE,
-				       &host->shm_dma, GFP_KERNEL);
-	if (!host->shm)
-		return -ENOMEM;
-
-	host->msg_base = host->shm + RBUF_LEN;
-	host->msg_dma = host->shm_dma + RBUF_LEN;
-
-	memset(host->shm, 0xff, RBUF_LEN);
-	memset(host->msg_base, 0, PDC_SHM_SIZE - RBUF_LEN);
-
-	return 0;
-}
-
-static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	struct carm_host *host;
-	int rc;
-	struct request_queue *q;
-	unsigned int i;
-
-	printk_once(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
-
-	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
-
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		goto err_out;
-
-	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
-			pci_name(pdev));
-		goto err_out_regions;
-	}
-
-	host = kzalloc(sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		printk(KERN_ERR DRV_NAME "(%s): memory alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
-	host->pdev = pdev;
-	spin_lock_init(&host->lock);
-	INIT_WORK(&host->fsm_task, carm_fsm_task);
-	init_completion(&host->probe_comp);
-
-	host->mmio = ioremap(pci_resource_start(pdev, 0),
-			     pci_resource_len(pdev, 0));
-	if (!host->mmio) {
-		printk(KERN_ERR DRV_NAME "(%s): MMIO alloc failure\n",
-		       pci_name(pdev));
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
-
-	rc = carm_init_shm(host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): DMA SHM alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_iounmap;
-	}
-
-	memset(&host->tag_set, 0, sizeof(host->tag_set));
-	host->tag_set.ops = &carm_mq_ops;
-	host->tag_set.cmd_size = sizeof(struct carm_request);
-	host->tag_set.nr_hw_queues = 1;
-	host->tag_set.nr_maps = 1;
-	host->tag_set.queue_depth = max_queue;
-	host->tag_set.numa_node = NUMA_NO_NODE;
-	host->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-
-	rc = blk_mq_alloc_tag_set(&host->tag_set);
-	if (rc)
-		goto err_out_dma_free;
-
-	q = blk_mq_init_queue(&host->tag_set);
-	if (IS_ERR(q)) {
-		rc = PTR_ERR(q);
-		blk_mq_free_tag_set(&host->tag_set);
-		goto err_out_dma_free;
-	}
-
-	host->oob_q = q;
-	q->queuedata = host;
-
-	/*
-	 * Figure out which major to use: 160, 161, or dynamic
-	 */
-	if (!test_and_set_bit(0, &carm_major_alloc))
-		host->major = 160;
-	else if (!test_and_set_bit(1, &carm_major_alloc))
-		host->major = 161;
-	else
-		host->flags |= FL_DYN_MAJOR;
-
-	host->id = carm_host_id;
-	sprintf(host->name, DRV_NAME "%d", carm_host_id);
-
-	rc = register_blkdev(host->major, host->name);
-	if (rc < 0)
-		goto err_out_free_majors;
-	if (host->flags & FL_DYN_MAJOR)
-		host->major = rc;
-
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		rc = carm_init_disk(host, i);
-		if (rc)
-			goto err_out_blkdev_disks;
-	}
-
-	pci_set_master(pdev);
-
-	rc = request_irq(pdev->irq, carm_interrupt, IRQF_SHARED, DRV_NAME, host);
-	if (rc) {
-		printk(KERN_ERR DRV_NAME "(%s): irq alloc failure\n",
-		       pci_name(pdev));
-		goto err_out_blkdev_disks;
-	}
-
-	rc = carm_init_host(host);
-	if (rc)
-		goto err_out_free_irq;
-
-	DPRINTK("waiting for probe_comp\n");
-	wait_for_completion(&host->probe_comp);
-
-	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
-	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-	       (unsigned long long)pci_resource_start(pdev, 0),
-		   pdev->irq, host->major);
-
-	carm_host_id++;
-	pci_set_drvdata(pdev, host);
-	return 0;
-
-err_out_free_irq:
-	free_irq(pdev->irq, host);
-err_out_blkdev_disks:
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
-err_out_free_majors:
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	blk_mq_free_tag_set(&host->tag_set);
-err_out_dma_free:
-	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-err_out_iounmap:
-	iounmap(host->mmio);
-err_out_kfree:
-	kfree(host);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	pci_disable_device(pdev);
-	return rc;
-}
-
-static void carm_remove_one (struct pci_dev *pdev)
-{
-	struct carm_host *host = pci_get_drvdata(pdev);
-	unsigned int i;
-
-	if (!host) {
-		printk(KERN_ERR PFX "BUG: no host data for PCI(%s)\n",
-		       pci_name(pdev));
-		return;
-	}
-
-	free_irq(pdev->irq, host);
-	for (i = 0; i < CARM_MAX_PORTS; i++)
-		carm_free_disk(host, i);
-	unregister_blkdev(host->major, host->name);
-	if (host->major == 160)
-		clear_bit(0, &carm_major_alloc);
-	else if (host->major == 161)
-		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
-	blk_mq_free_tag_set(&host->tag_set);
-	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
-	iounmap(host->mmio);
-	kfree(host);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-}
-
-module_pci_driver(carm_driver);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5347fc465ce8..bc0850d3f7d2 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -78,7 +78,8 @@ enum qca_flags {
 	QCA_HW_ERROR_EVENT,
 	QCA_SSR_TRIGGERED,
 	QCA_BT_OFF,
-	QCA_ROM_FW
+	QCA_ROM_FW,
+	QCA_DEBUGFS_CREATED,
 };
 
 enum qca_capabilities {
@@ -633,6 +634,9 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return;
 
+	if (test_and_set_bit(QCA_DEBUGFS_CREATED, &qca->flags))
+		return;
+
 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
 
 	/* read only */
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 9bcd0eebc6d7..2e030a308b6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -329,8 +329,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
 	u32 reference_clock = adev->clock.spll.reference_freq;
 	u32 tmp;
 
-	if (adev->flags & AMD_IS_APU)
-		return reference_clock;
+	if (adev->flags & AMD_IS_APU) {
+		switch (adev->asic_type) {
+		case CHIP_STONEY:
+			/* vbios says 48Mhz, but the actual freq is 100Mhz */
+			return 10000;
+		default:
+			return reference_clock;
+		}
+	}
 
 	tmp = RREG32_SMC(ixCG_CLKPIN_CNTL_2);
 	if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 25c269bc4681..b6062833370f 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -75,15 +75,17 @@ int drm_atomic_set_mode_for_crtc(struct drm_crtc_state *state,
 	state->mode_blob = NULL;
 
 	if (mode) {
+		struct drm_property_blob *blob;
+
 		drm_mode_convert_to_umode(&umode, mode);
-		state->mode_blob =
-			drm_property_create_blob(state->crtc->dev,
-		                                 sizeof(umode),
-		                                 &umode);
-		if (IS_ERR(state->mode_blob))
-			return PTR_ERR(state->mode_blob);
+		blob = drm_property_create_blob(crtc->dev,
+						sizeof(umode), &umode);
+		if (IS_ERR(blob))
+			return PTR_ERR(blob);
 
 		drm_mode_copy(&state->mode, mode);
+
+		state->mode_blob = blob;
 		state->enable = true;
 		DRM_DEBUG_ATOMIC("Set [MODE:%s] for [CRTC:%d:%s] state %p\n",
 				 mode->name, crtc->base.id, crtc->name, state);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 8ead7e021008..a520aa06d2cb 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -576,12 +576,14 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(i2c_dev->dev);
+	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev, "Failed to resume device (%pe)\n", ERR_PTR(ret));
 
 	i2c_del_adapter(&i2c_dev->adap);
-	clk_disable_unprepare(i2c_dev->clk);
+
+	if (ret >= 0)
+		clk_disable_unprepare(i2c_dev->clk);
 
 	pm_runtime_put_noidle(i2c_dev->dev);
 	pm_runtime_disable(i2c_dev->dev);
diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 832b80de004f..13545fcdc5ad 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -422,9 +422,8 @@ void i40iw_manage_arp_cache(struct i40iw_device *iwdev,
 			    bool ipv4,
 			    u32 action);
 
-int i40iw_manage_apbvt(struct i40iw_device *iwdev,
-		       u16 accel_local_port,
-		       bool add_port);
+enum i40iw_status_code i40iw_manage_apbvt(struct i40iw_device *iwdev,
+					  u16 accel_local_port, bool add_port);
 
 struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait);
 void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp_request);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 0bd55e1fca37..b99318fb58dc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -262,7 +262,6 @@ static const struct xpad_device {
 	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
-	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2e53ea261e01..598fcb99f6c9 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -674,10 +674,11 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	int id = ((packet[3] & 0xe0) >> 5) - 1;
+	int id;
 	int pres, traces;
 
-	if (id < 0)
+	id = ((packet[3] & 0xe0) >> 5) - 1;
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
@@ -707,7 +708,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	int id, sid;
 
 	id = ((packet[0] & 0xe0) >> 5) - 1;
-	if (id < 0)
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	sid = ((packet[3] & 0xe0) >> 5) - 1;
@@ -728,7 +729,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 
-	if (sid >= 0) {
+	if (sid >= 0 && sid < ETP_MAX_FINGERS) {
 		etd->mt[sid].x += delta_x2 * weight;
 		etd->mt[sid].y -= delta_y2 * weight;
 		input_mt_slot(dev, sid);
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 0f791bfdc1f5..c92f2cdf4026 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -6,6 +6,7 @@ config EEPROM_AT24
 	depends on I2C && SYSFS
 	select NVMEM
 	select NVMEM_SYSFS
+	select REGMAP
 	select REGMAP_I2C
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index deeed50a42c0..f5ab0bff4ac2 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1187,8 +1187,6 @@ static int lan9303_port_fdb_add(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 
 	return lan9303_alr_add_port(chip, addr, port, false);
 }
@@ -1200,8 +1198,6 @@ static int lan9303_port_fdb_del(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 	lan9303_alr_del_port(chip, addr, port);
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3a9fcf942a6d..d8366351cf14 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8337,6 +8337,9 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		goto err_out;
 	}
 
+	if (BNXT_VF(bp))
+		bnxt_hwrm_func_qcfg(bp);
+
 	rc = bnxt_setup_vnic(bp, 0);
 	if (rc)
 		goto err_out;
@@ -12101,26 +12104,37 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 
 #endif /* CONFIG_RFS_ACCEL */
 
-static int bnxt_udp_tunnel_sync(struct net_device *netdev, unsigned int table)
+static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
+				    unsigned int entry, struct udp_tunnel_info *ti)
 {
 	struct bnxt *bp = netdev_priv(netdev);
-	struct udp_tunnel_info ti;
 	unsigned int cmd;
 
-	udp_tunnel_nic_get_port(netdev, table, 0, &ti);
-	if (ti.type == UDP_TUNNEL_TYPE_VXLAN)
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
 	else
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
-	if (ti.port)
-		return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti.port, cmd);
+	return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti->port, cmd);
+}
+
+static int bnxt_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
+				      unsigned int entry, struct udp_tunnel_info *ti)
+{
+	struct bnxt *bp = netdev_priv(netdev);
+	unsigned int cmd;
+
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
+	else
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
 	return bnxt_hwrm_tunnel_dst_port_free(bp, cmd);
 }
 
 static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
-	.sync_table	= bnxt_udp_tunnel_sync,
+	.set_port	= bnxt_udp_tunnel_set_port,
+	.unset_port	= bnxt_udp_tunnel_unset_port,
 	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
 			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1e67e86fc334..2984234df67e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3440,7 +3440,7 @@ static int bnxt_reset(struct net_device *dev, u32 *flags)
 		}
 	}
 
-	if (req & BNXT_FW_RESET_AP) {
+	if (!BNXT_CHIP_P4_PLUS(bp) && (req & BNXT_FW_RESET_AP)) {
 		/* This feature is not supported in older firmware versions */
 		if (bp->hwrm_spec_code >= 0x10803) {
 			if (!bnxt_firmware_reset_ap(dev)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index cb8689222c8b..55ba6b690ab6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -20,16 +20,11 @@ enum i40e_memory_type {
 };
 
 /* prototype for functions used for dynamic memory allocation */
-i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
-					    struct i40e_dma_mem *mem,
-					    enum i40e_memory_type type,
-					    u64 size, u32 alignment);
-i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
-					struct i40e_dma_mem *mem);
-i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
-					     struct i40e_virt_mem *mem,
-					     u32 size);
-i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
-					 struct i40e_virt_mem *mem);
+int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
+			  enum i40e_memory_type type, u64 size, u32 alignment);
+int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem);
+int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem,
+			   u32 size);
+int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem);
 
 #endif /* _I40E_ALLOC_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index 2418d4fff037..e27b4de7e7aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -128,7 +128,7 @@ void ice_fltr_remove_all(struct ice_vsi *vsi)
  * @mac: MAC address to add
  * @action: filter action
  */
-int
+enum ice_status
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 const u8 *mac, enum ice_sw_fwd_act_type action)
 {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 07824bf9d68d..0157bcd2efff 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -1902,7 +1902,7 @@ void qed_get_vport_stats(struct qed_dev *cdev, struct qed_eth_stats *stats)
 {
 	u32 i;
 
-	if (!cdev) {
+	if (!cdev || cdev->recov_in_prog) {
 		memset(stats, 0, sizeof(*stats));
 		return;
 	}
diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index f313fd730331..3251d58a263f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -273,6 +273,10 @@ struct qede_dev {
 #define QEDE_ERR_WARN			3
 
 	struct qede_dump_info		dump_info;
+	struct delayed_work		periodic_task;
+	unsigned long			stats_coal_ticks;
+	u32				stats_coal_usecs;
+	spinlock_t			stats_lock; /* lock for vport stats access */
 };
 
 enum QEDE_STATE {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index bedbb85a179a..db104e035ba1 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -426,6 +426,8 @@ static void qede_get_ethtool_stats(struct net_device *dev,
 		}
 	}
 
+	spin_lock(&edev->stats_lock);
+
 	for (i = 0; i < QEDE_NUM_STATS; i++) {
 		if (qede_is_irrelevant_stat(edev, i))
 			continue;
@@ -435,6 +437,8 @@ static void qede_get_ethtool_stats(struct net_device *dev,
 		buf++;
 	}
 
+	spin_unlock(&edev->stats_lock);
+
 	__qede_unlock(edev);
 }
 
@@ -815,6 +819,7 @@ static int qede_get_coalesce(struct net_device *dev,
 
 	coal->rx_coalesce_usecs = rx_coal;
 	coal->tx_coalesce_usecs = tx_coal;
+	coal->stats_block_coalesce_usecs = edev->stats_coal_usecs;
 
 	return rc;
 }
@@ -827,6 +832,19 @@ static int qede_set_coalesce(struct net_device *dev,
 	int i, rc = 0;
 	u16 rxc, txc;
 
+	if (edev->stats_coal_usecs != coal->stats_block_coalesce_usecs) {
+		edev->stats_coal_usecs = coal->stats_block_coalesce_usecs;
+		if (edev->stats_coal_usecs) {
+			edev->stats_coal_ticks = usecs_to_jiffies(edev->stats_coal_usecs);
+			schedule_delayed_work(&edev->periodic_task, 0);
+
+			DP_INFO(edev, "Configured stats coal ticks=%lu jiffies\n",
+				edev->stats_coal_ticks);
+		} else {
+			cancel_delayed_work_sync(&edev->periodic_task);
+		}
+	}
+
 	if (!netif_running(dev)) {
 		DP_INFO(edev, "Interface is down\n");
 		return -EINVAL;
@@ -2106,7 +2124,8 @@ static int qede_get_dump_data(struct net_device *dev,
 }
 
 static const struct ethtool_ops qede_ethtool_ops = {
-	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_link_ksettings		= qede_get_link_ksettings,
 	.set_link_ksettings		= qede_set_link_ksettings,
 	.get_drvinfo			= qede_get_drvinfo,
@@ -2155,7 +2174,8 @@ static const struct ethtool_ops qede_ethtool_ops = {
 };
 
 static const struct ethtool_ops qede_vf_ethtool_ops = {
-	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_link_ksettings		= qede_get_link_ksettings,
 	.get_drvinfo			= qede_get_drvinfo,
 	.get_msglevel			= qede_get_msglevel,
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index e93f06e4a172..681ec142c23d 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -313,6 +313,8 @@ void qede_fill_by_demand_stats(struct qede_dev *edev)
 
 	edev->ops->get_vport_stats(edev->cdev, &stats);
 
+	spin_lock(&edev->stats_lock);
+
 	p_common->no_buff_discards = stats.common.no_buff_discards;
 	p_common->packet_too_big_discard = stats.common.packet_too_big_discard;
 	p_common->ttl0_discard = stats.common.ttl0_discard;
@@ -410,6 +412,8 @@ void qede_fill_by_demand_stats(struct qede_dev *edev)
 		p_ah->tx_1519_to_max_byte_packets =
 		    stats.ah.tx_1519_to_max_byte_packets;
 	}
+
+	spin_unlock(&edev->stats_lock);
 }
 
 static void qede_get_stats64(struct net_device *dev,
@@ -418,9 +422,10 @@ static void qede_get_stats64(struct net_device *dev,
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qede_stats_common *p_common;
 
-	qede_fill_by_demand_stats(edev);
 	p_common = &edev->stats.common;
 
+	spin_lock(&edev->stats_lock);
+
 	stats->rx_packets = p_common->rx_ucast_pkts + p_common->rx_mcast_pkts +
 			    p_common->rx_bcast_pkts;
 	stats->tx_packets = p_common->tx_ucast_pkts + p_common->tx_mcast_pkts +
@@ -440,6 +445,8 @@ static void qede_get_stats64(struct net_device *dev,
 		stats->collisions = edev->stats.bb.tx_total_collisions;
 	stats->rx_crc_errors = p_common->rx_crc_errors;
 	stats->rx_frame_errors = p_common->rx_align_errors;
+
+	spin_unlock(&edev->stats_lock);
 }
 
 #ifdef CONFIG_QED_SRIOV
@@ -1001,6 +1008,23 @@ static void qede_unlock(struct qede_dev *edev)
 	rtnl_unlock();
 }
 
+static void qede_periodic_task(struct work_struct *work)
+{
+	struct qede_dev *edev = container_of(work, struct qede_dev,
+					     periodic_task.work);
+
+	qede_fill_by_demand_stats(edev);
+	schedule_delayed_work(&edev->periodic_task, edev->stats_coal_ticks);
+}
+
+static void qede_init_periodic_task(struct qede_dev *edev)
+{
+	INIT_DELAYED_WORK(&edev->periodic_task, qede_periodic_task);
+	spin_lock_init(&edev->stats_lock);
+	edev->stats_coal_usecs = USEC_PER_SEC;
+	edev->stats_coal_ticks = usecs_to_jiffies(USEC_PER_SEC);
+}
+
 static void qede_sp_task(struct work_struct *work)
 {
 	struct qede_dev *edev = container_of(work, struct qede_dev,
@@ -1020,6 +1044,7 @@ static void qede_sp_task(struct work_struct *work)
 	 */
 
 	if (test_and_clear_bit(QEDE_SP_RECOVERY, &edev->sp_flags)) {
+		cancel_delayed_work_sync(&edev->periodic_task);
 #ifdef CONFIG_QED_SRIOV
 		/* SRIOV must be disabled outside the lock to avoid a deadlock.
 		 * The recovery of the active VFs is currently not supported.
@@ -1216,6 +1241,7 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 		 */
 		INIT_DELAYED_WORK(&edev->sp_task, qede_sp_task);
 		mutex_init(&edev->qede_lock);
+		qede_init_periodic_task(edev);
 
 		rc = register_netdev(edev->ndev);
 		if (rc) {
@@ -1240,6 +1266,11 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 	edev->rx_copybreak = QEDE_RX_HDR_SIZE;
 
 	qede_log_probe(edev);
+
+	/* retain user config (for example - after recovery) */
+	if (edev->stats_coal_usecs)
+		schedule_delayed_work(&edev->periodic_task, 0);
+
 	return 0;
 
 err4:
@@ -1308,6 +1339,7 @@ static void __qede_remove(struct pci_dev *pdev, enum qede_remove_mode mode)
 		unregister_netdev(ndev);
 
 		cancel_delayed_work_sync(&edev->sp_task);
+		cancel_delayed_work_sync(&edev->periodic_task);
 
 		edev->ops->common->set_power_state(cdev, PCI_D0);
 
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index a90e5a9d2a37..6ddda1a5e536 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -333,7 +333,8 @@ void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
  * Returns 0 on success, error code otherwise. In case of an error this
  * function will free the SKB.
  */
-int ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb)
+netdev_tx_t ef100_enqueue_skb(struct efx_tx_queue *tx_queue,
+			      struct sk_buff *skb)
 {
 	unsigned int old_insert_count = tx_queue->insert_count;
 	struct efx_nic *efx = tx_queue->efx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b26617026e83..4364f73b501d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -779,7 +779,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
+
+		spin_lock_bh(&dev->sta_poll_lock);
 		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 072765db93d7..505466b06629 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOA_15),
 	GPIO_GROUP(GPIOA_16),
 	GPIO_GROUP(GPIOA_17),
+	GPIO_GROUP(GPIOA_18),
 	GPIO_GROUP(GPIOA_19),
 	GPIO_GROUP(GPIOA_20),
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index cb6427fb9f3d..6d5c9cb83592 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -505,10 +505,10 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 8bf58510cca6..2cc9bb413c10 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1030,23 +1030,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = clk_prepare_enable(cclk);
-	if (ret) {
-		dev_err(dev, "cannot enable core clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(iclk);
-	if (ret) {
-		clk_disable_unprepare(cclk);
-		dev_err(dev, "cannot enable iface clock\n");
-		return ret;
-	}
-
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
 		dev_err(dev, "cannot allocate master\n");
 		return -ENOMEM;
 	}
@@ -1092,6 +1077,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
+	ret = clk_prepare_enable(cclk);
+	if (ret) {
+		dev_err(dev, "cannot enable core clock\n");
+		goto error_dma;
+	}
+
+	ret = clk_prepare_enable(iclk);
+	if (ret) {
+		clk_disable_unprepare(cclk);
+		dev_err(dev, "cannot enable iface clock\n");
+		goto error_dma;
+	}
+
 	iomode = readl_relaxed(base + QUP_IO_M_MODES);
 
 	size = QUP_IO_M_OUTPUT_BLOCK_SIZE(iomode);
@@ -1121,7 +1119,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error_dma;
+		goto error_clk;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -1145,7 +1143,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error_dma;
+		goto error_clk;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -1160,11 +1158,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_clk:
+	clk_disable_unprepare(cclk);
+	clk_disable_unprepare(iclk);
 error_dma:
 	spi_qup_release_dma(master);
 error:
-	clk_disable_unprepare(cclk);
-	clk_disable_unprepare(iclk);
 	spi_master_put(master);
 	return ret;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4c201679fc08..291f98251f7f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -50,9 +50,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
-	{PCI_DEVICE(0x10ec, 0x8192)},
-	{PCI_DEVICE(0x07aa, 0x0044)},
-	{PCI_DEVICE(0x07aa, 0x0047)},
+	{RTL_PCI_DEVICE(0x10ec, 0x8192, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0044, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0047, rtl819xp_ops)},
 	{}
 };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 7bbd884aa5f1..736f1a824cd2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -55,6 +55,11 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
+#define RTL_PCI_DEVICE(vend, dev, cfg) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.driver_data = (kernel_ulong_t)&(cfg)
+
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3d378da119e7..178cf90fb3e5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -147,12 +147,11 @@ vchiq_blocking_bulk_transfer(unsigned int handle, void *data,
 	unsigned int size, enum vchiq_bulk_dir dir);
 
 #define VCHIQ_INIT_RETRIES 10
-enum vchiq_status vchiq_initialise(struct vchiq_instance **instance_out)
+int vchiq_initialise(struct vchiq_instance **instance_out)
 {
-	enum vchiq_status status = VCHIQ_ERROR;
 	struct vchiq_state *state;
 	struct vchiq_instance *instance = NULL;
-	int i;
+	int i, ret;
 
 	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
 
@@ -169,6 +168,7 @@ enum vchiq_status vchiq_initialise(struct vchiq_instance **instance_out)
 	if (i == VCHIQ_INIT_RETRIES) {
 		vchiq_log_error(vchiq_core_log_level,
 			"%s: videocore not initialized\n", __func__);
+		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
 		vchiq_log_warning(vchiq_core_log_level,
@@ -180,6 +180,7 @@ enum vchiq_status vchiq_initialise(struct vchiq_instance **instance_out)
 	if (!instance) {
 		vchiq_log_error(vchiq_core_log_level,
 			"%s: error allocating vchiq instance\n", __func__);
+		ret = -ENOMEM;
 		goto failed;
 	}
 
@@ -190,13 +191,13 @@ enum vchiq_status vchiq_initialise(struct vchiq_instance **instance_out)
 
 	*instance_out = instance;
 
-	status = VCHIQ_SUCCESS;
+	ret = 0;
 
 failed:
 	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
+		"%s(%p): returning %d", __func__, instance, ret);
 
-	return status;
+	return ret;
 }
 EXPORT_SYMBOL(vchiq_initialise);
 
@@ -2223,6 +2224,7 @@ vchiq_keepalive_thread_func(void *v)
 	enum vchiq_status status;
 	struct vchiq_instance *instance;
 	unsigned int ka_handle;
+	int ret;
 
 	struct vchiq_service_params_kernel params = {
 		.fourcc      = VCHIQ_MAKE_FOURCC('K', 'E', 'E', 'P'),
@@ -2231,10 +2233,10 @@ vchiq_keepalive_thread_func(void *v)
 		.version_min = KEEPALIVE_VER_MIN
 	};
 
-	status = vchiq_initialise(&instance);
-	if (status != VCHIQ_SUCCESS) {
+	ret = vchiq_initialise(&instance);
+	if (ret) {
 		vchiq_log_error(vchiq_susp_log_level,
-			"%s vchiq_initialise failed %d", __func__, status);
+			"%s vchiq_initialise failed %d", __func__, ret);
 		goto exit;
 	}
 
@@ -2313,7 +2315,7 @@ vchiq_arm_init_state(struct vchiq_state *state,
 	return VCHIQ_SUCCESS;
 }
 
-enum vchiq_status
+int
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type)
 {
@@ -2373,7 +2375,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	return ret;
 }
 
-enum vchiq_status
+int
 vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 {
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
index ff48c3e47375..e2014e21530a 100644
--- a/drivers/tee/amdtee/amdtee_if.h
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
 
 /**
  * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
- * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
- * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
- * @size:        [in] size of TA binary in bytes
- * @ta_handle:   [out] return handle of the loaded TA
+ * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
+ * @size:           [in] size of TA binary in bytes
+ * @ta_handle:      [out] return handle of the loaded TA
+ * @return_origin:  [out] origin of return code after TEE processing
  */
 struct tee_cmd_load_ta {
 	u32 low_addr;
 	u32 hi_addr;
 	u32 size;
 	u32 ta_handle;
+	u32 return_origin;
 };
 
 /**
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 07f36ac834c8..63d428423e90 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else if (arg->ret == TEEC_SUCCESS) {
-		ret = get_ta_refcount(load_cmd.ta_handle);
-		if (!ret) {
-			arg->ret_origin = TEEC_ORIGIN_COMMS;
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
-
-			/* Unload the TA on error */
-			unload_cmd.ta_handle = load_cmd.ta_handle;
-			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
-					    (void *)&unload_cmd,
-					    sizeof(unload_cmd), &ret);
-		} else {
-			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+	} else {
+		arg->ret_origin = load_cmd.return_origin;
+
+		if (arg->ret == TEEC_SUCCESS) {
+			ret = get_ta_refcount(load_cmd.ta_handle);
+			if (!ret) {
+				arg->ret_origin = TEEC_ORIGIN_COMMS;
+				arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+
+				/* Unload the TA on error */
+				unload_cmd.ta_handle = load_cmd.ta_handle;
+				psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+						    (void *)&unload_cmd,
+						    sizeof(unload_cmd), &ret);
+			} else {
+				set_session_id(load_cmd.ta_handle, 0, &arg->session);
+			}
 		}
 	}
 	mutex_unlock(&ta_refcount_mutex);
diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 6cf22c27f2d2..be8738750948 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -170,3 +170,44 @@ void hcd_buffer_free(
 	}
 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
 }
+
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma)
+{
+	if (size == 0)
+		return NULL;
+
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc_align(hcd->localmem_pool,
+				size, dma, PAGE_SIZE);
+
+	/* some USB hosts just use PIO */
+	if (!hcd_uses_dma(hcd)) {
+		*dma = DMA_MAPPING_ERROR;
+		return (void *)__get_free_pages(mem_flags,
+				get_order(size));
+	}
+
+	return dma_alloc_coherent(hcd->self.sysdev,
+			size, dma, mem_flags);
+}
+
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma)
+{
+	if (!addr)
+		return;
+
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool,
+				(unsigned long)addr, size);
+		return;
+	}
+
+	if (!hcd_uses_dma(hcd)) {
+		free_pages((unsigned long)addr, get_order(size));
+		return;
+	}
+
+	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
+}
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 73b60f013b20..2fe29319de44 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -173,6 +173,7 @@ static int connected(struct usb_dev_state *ps)
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
+	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ps->lock, flags);
@@ -181,8 +182,8 @@ static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 		list_del(&usbm->memlist);
 		spin_unlock_irqrestore(&ps->lock, flags);
 
-		usb_free_coherent(ps->dev, usbm->size, usbm->mem,
-				usbm->dma_handle);
+		hcd_buffer_free_pages(hcd, usbm->size,
+				usbm->mem, usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -221,7 +222,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	size_t size = vma->vm_end - vma->vm_start;
 	void *mem;
 	unsigned long flags;
-	dma_addr_t dma_handle;
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
@@ -234,8 +235,8 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd,
+			size, GFP_USER | __GFP_NOWARN, &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
@@ -251,7 +252,14 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+	/*
+	 * In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
+	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
+	 * whether we are in such cases, and then use remap_pfn_range (or
+	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
+	 * space, respectively.
+	 */
+	if (dma_handle == DMA_MAPPING_ERROR) {
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1f9a1554ce5f..de110363af52 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1621,17 +1621,25 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		if (s.num > 0xffff) {
-			r = -EINVAL;
-			break;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = s.num & 0xffff;
+			vq->last_used_idx = (s.num >> 16) & 0xffff;
+		} else {
+			if (s.num > 0xffff) {
+				r = -EINVAL;
+				break;
+			}
+			vq->last_avail_idx = s.num;
 		}
-		vq->last_avail_idx = s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index = idx;
-		s.num = vq->last_avail_idx;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+			s.num = (u32)vq->last_avail_idx | ((u32)vq->last_used_idx << 16);
+		else
+			s.num = vq->last_avail_idx;
 		if (copy_to_user(argp, &s, sizeof s))
 			r = -EFAULT;
 		break;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 8f80d6b0d843..e00347f2b4d3 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -87,13 +87,17 @@ struct vhost_virtqueue {
 	/* The routine to call when the Guest pings us, or timeout. */
 	vhost_work_fn_t handle_kick;
 
-	/* Last available index we saw. */
+	/* Last available index we saw.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_avail_idx;
 
 	/* Caches available index value from user. */
 	u16 avail_idx;
 
-	/* Last index we used. */
+	/* Last index we used.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_used_idx;
 
 	/* Used flags */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 159795059547..a59d6293a32b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1313,6 +1313,7 @@ static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	op->dentry	= dentry;
 	op->create.mode	= S_IFDIR | mode;
 	op->create.reason = afs_edit_dir_for_mkdir;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
 	return afs_do_sync_operation(op);
 }
@@ -1616,6 +1617,7 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFREG | mode;
 	op->create.reason = afs_edit_dir_for_create;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_create_operation;
 	return afs_do_sync_operation(op);
 
@@ -1745,6 +1747,7 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 	op->ops			= &afs_symlink_operation;
 	op->create.reason	= afs_edit_dir_for_symlink;
 	op->create.symlink	= content;
+	op->mtime		= current_time(dir);
 	return afs_do_sync_operation(op);
 
 error:
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c21545c5b34b..93db4486a943 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1895,7 +1895,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3270,8 +3270,12 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
+		unset_reloc_control(rc);
+
+	return ret;
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3443,7 +3447,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 210496dc2fd4..e1fda3923944 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1636,6 +1636,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	struct inode *inode = &ci->vfs_inode;
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
+	bool need_put = false;
 	int mds;
 
 	dout("ceph_flush_snaps %p\n", inode);
@@ -1687,8 +1688,13 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	}
 	/* we flushed them all; remove this inode from the queue */
 	spin_lock(&mdsc->snap_flush_lock);
+	if (!list_empty(&ci->i_snap_flush_item))
+		need_put = true;
 	list_del_init(&ci->i_snap_flush_item);
 	spin_unlock(&mdsc->snap_flush_lock);
+
+	if (need_put)
+		iput(inode);
 }
 
 /*
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 8e6fc45ccc9e..db464682b2cb 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -647,8 +647,10 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	     capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
-	if (list_empty(&ci->i_snap_flush_item))
+	if (list_empty(&ci->i_snap_flush_item)) {
+		ihold(inode);
 		list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
+	}
 	spin_unlock(&mdsc->snap_flush_lock);
 	return 1;  /* caller may want to ceph_flush_snaps */
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f72896384dbc..84b4fc9833e3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5799,7 +5799,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	ext4_group_t g;
 	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -5992,7 +5991,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6039,9 +6038,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 10b2f570d400..ed39101dc7b6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1999,8 +1999,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2062,8 +2063,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a7e7d68256e0..2501c11d8c46 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -403,9 +403,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "iostat_period_ms")) {
 		if (t < MIN_IOSTAT_PERIOD_MS || t > MAX_IOSTAT_PERIOD_MS)
 			return -EINVAL;
-		spin_lock(&sbi->iostat_lock);
+		spin_lock_irq(&sbi->iostat_lock);
 		sbi->iostat_period_ms = (unsigned int)t;
-		spin_unlock(&sbi->iostat_lock);
+		spin_unlock_irq(&sbi->iostat_lock);
 		return count;
 	}
 
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index b374c9cee117..a053b0bf7930 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -924,6 +924,16 @@ xlog_recover_buf_commit_pass2(
 	if (lsn && lsn != -1 && XFS_LSN_CMP(lsn, current_lsn) >= 0) {
 		trace_xfs_log_recover_buf_skip(log, buf_f);
 		xlog_recover_validate_buf_type(mp, bp, buf_f, NULLCOMMITLSN);
+
+		/*
+		 * We're skipping replay of this buffer log item due to the log
+		 * item LSN being behind the ondisk buffer.  Verify the buffer
+		 * contents since we aren't going to run the write verifier.
+		 */
+		if (bp->b_ops) {
+			bp->b_ops->verify_read(bp);
+			error = bp->b_error;
+		}
 		goto out_release;
 	}
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9ef63bc14b00..24fe2cd4b0e8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -744,8 +744,11 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 		/* We only give a hint, preemption can change CPU under us */
 		val |= raw_smp_processor_id();
 
-		if (table->ents[index] != val)
-			table->ents[index] = val;
+		/* The following WRITE_ONCE() is paired with the READ_ONCE()
+		 * here, and another one in get_rps_cpu().
+		 */
+		if (READ_ONCE(table->ents[index]) != val)
+			WRITE_ONCE(table->ents[index], val);
 	}
 }
 
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index c0cf20b19e63..528be670006f 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -504,6 +504,11 @@ void *hcd_buffer_alloc(struct usb_bus *bus, size_t size,
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 191c36afa1f4..9dc082b2d543 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -156,8 +156,8 @@ int bond_alb_init_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
 void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
-int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
-int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
 struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 				      struct sk_buff *skb);
 struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index d5767e25509c..abb22cfd4827 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -174,7 +174,7 @@ struct pneigh_entry {
 	struct net_device	*dev;
 	u8			flags;
 	u8			protocol;
-	u8			key[];
+	u32			key[];
 };
 
 /*
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 50d5ffbad473..ba781e0aaf56 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -129,6 +129,8 @@ static inline void qdisc_run(struct Qdisc *q)
 	}
 }
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* Calculate maximal size of packet seen by hard_start_xmit
    routine of this device.
  */
diff --git a/include/net/rpl.h b/include/net/rpl.h
index 308ef0a05cae..30fe780d1e7c 100644
--- a/include/net/rpl.h
+++ b/include/net/rpl.h
@@ -23,9 +23,6 @@ static inline int rpl_init(void)
 static inline void rpl_exit(void) {}
 #endif
 
-/* Worst decompression memory usage ipv6 address (16) + pad 7 */
-#define IPV6_RPL_SRH_WORST_SWAP_SIZE (sizeof(struct in6_addr) + 7)
-
 size_t ipv6_rpl_srh_size(unsigned char n, unsigned char cmpri,
 			 unsigned char cmpre);
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 3da0601b573e..51b499d74549 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1073,8 +1073,12 @@ static inline void sock_rps_record_flow(const struct sock *sk)
 		 * OR	an additional socket flag
 		 * [1] : sk_state and sk_prot are in the same cache line.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			sock_rps_record_flow_hash(sk->sk_rxhash);
+		if (sk->sk_state == TCP_ESTABLISHED) {
+			/* This READ_ONCE() is paired with the WRITE_ONCE()
+			 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
+			 */
+			sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
+		}
 	}
 #endif
 }
@@ -1083,15 +1087,19 @@ static inline void sock_rps_save_rxhash(struct sock *sk,
 					const struct sk_buff *skb)
 {
 #ifdef CONFIG_RPS
-	if (unlikely(sk->sk_rxhash != skb->hash))
-		sk->sk_rxhash = skb->hash;
+	/* The following WRITE_ONCE() is paired with the READ_ONCE()
+	 * here, and another one in sock_rps_record_flow().
+	 */
+	if (unlikely(READ_ONCE(sk->sk_rxhash) != skb->hash))
+		WRITE_ONCE(sk->sk_rxhash, skb->hash);
 #endif
 }
 
 static inline void sock_rps_reset_rxhash(struct sock *sk)
 {
 #ifdef CONFIG_RPS
-	sk->sk_rxhash = 0;
+	/* Paired with READ_ONCE() in sock_rps_record_flow() */
+	WRITE_ONCE(sk->sk_rxhash, 0);
 #endif
 }
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 94e51d36fb49..9e90d1e7af2c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1128,13 +1128,23 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
-	p = d_path(path, buf, sz);
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
+	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
 	} else {
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index e77f12bb3c77..1833ad73de6f 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -268,8 +268,8 @@ static void irq_cpu_rmap_release(struct kref *ref)
 	struct irq_glue *glue =
 		container_of(ref, struct irq_glue, notify.kref);
 
-	cpu_rmap_put(glue->rmap);
 	glue->rmap->obj[glue->index] = NULL;
+	cpu_rmap_put(glue->rmap);
 	kfree(glue);
 }
 
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 338e4e9c33b8..ddd3b4c70a51 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -102,7 +102,6 @@ static void batadv_dat_purge(struct work_struct *work);
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat.work,
 			   msecs_to_jiffies(10000));
 }
@@ -822,6 +821,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 08c473aa0113..bd6f20ef13f3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2685,10 +2685,10 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -2704,9 +2704,9 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b85ce276e2a3..568f0f072b3d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4303,6 +4303,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	result = __le16_to_cpu(rsp->result);
 	status = __le16_to_cpu(rsp->status);
 
+	if (result == L2CAP_CR_SUCCESS && (dcid < L2CAP_CID_DYN_START ||
+					   dcid > L2CAP_CID_DYN_END))
+		return -EPROTO;
+
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 	       dcid, scid, result, status);
 
@@ -4334,6 +4338,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
+		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
+			err = -EBADSLT;
+			break;
+		}
+
 		l2cap_state_change(chan, BT_CONFIG);
 		chan->ident = 0;
 		chan->dcid = dcid;
@@ -4659,7 +4668,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 	mutex_unlock(&conn->chan_lock);
 
@@ -4698,7 +4709,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
 	mutex_unlock(&conn->chan_lock);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 9da8fbc81c04..9169ef174ff0 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -122,7 +122,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 #define J1939_CAN_ID CAN_EFF_FLAG
 #define J1939_CAN_MASK (CAN_EFF_FLAG | CAN_RTR_FLAG)
 
-static DEFINE_SPINLOCK(j1939_netdev_lock);
+static DEFINE_MUTEX(j1939_netdev_lock);
 
 static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 {
@@ -216,7 +216,7 @@ static void __j1939_rx_release(struct kref *kref)
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 }
 
 /* get pointer to priv without increasing ref counter */
@@ -244,9 +244,9 @@ static struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	return priv;
 }
@@ -256,14 +256,14 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	struct j1939_priv *priv, *priv_new;
 	int ret;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv) {
 		kref_get(&priv->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		return priv;
 	}
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	priv = j1939_priv_create(ndev);
 	if (!priv)
@@ -273,29 +273,31 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	spin_lock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv_new = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv_new) {
 		/* Someone was faster than us, use their priv and roll
 		 * back our's.
 		 */
 		kref_get(&priv_new->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		dev_put(ndev);
 		kfree(priv);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
-	spin_unlock(&j1939_netdev_lock);
 
 	ret = j1939_can_rx_register(priv);
 	if (ret < 0)
 		goto out_priv_put;
 
+	mutex_unlock(&j1939_netdev_lock);
 	return priv;
 
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
+	mutex_unlock(&j1939_netdev_lock);
+
 	dev_put(ndev);
 	kfree(priv);
 
@@ -304,7 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	kref_put_lock(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
+	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 76cd5f43faf7..906a08d38c1c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1013,6 +1013,11 @@ void j1939_sk_errqueue(struct j1939_session *session,
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
 {
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	if (jsk->state & J1939_SOCK_ERRQUEUE)
+		return;
+
 	sk->sk_err = err;
 
 	sk->sk_error_report(sk);
diff --git a/net/core/dev.c b/net/core/dev.c
index 29e6e11c481c..f4aad9b00cc9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4385,8 +4385,10 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		u32 next_cpu;
 		u32 ident;
 
-		/* First check into global flow table if there is a match */
-		ident = sock_flow_table->ents[hash & sock_flow_table->mask];
+		/* First check into global flow table if there is a match.
+		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
+		 */
+		ident = READ_ONCE(sock_flow_table->ents[hash & sock_flow_table->mask]);
 		if ((ident ^ hash) & ~rps_cpu_mask)
 			goto try_rps;
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3a34e9768bff..5aa8bde3e9c8 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -31,7 +31,6 @@
 static int two = 2;
 static int four = 4;
 static int thousand = 1000;
-static int gso_max_segs = GSO_MAX_SEGS;
 static int tcp_retr1_max = 255;
 static int ip_local_port_range_min[] = { 1, 1 };
 static int ip_local_port_range_max[] = { 65535, 65535 };
@@ -1193,7 +1192,6 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &gso_max_segs,
 	},
 	{
 		.procname	= "tcp_min_rtt_wlen",
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 4932dea9820b..cdad9019c77c 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -552,24 +552,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_cloned(skb)) {
-		if (pskb_expand_head(skb, IPV6_RPL_SRH_WORST_SWAP_SIZE, 0,
-				     GFP_ATOMIC)) {
-			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-					IPSTATS_MIB_OUTDISCARDS);
-			kfree_skb(skb);
-			return -1;
-		}
-	} else {
-		err = skb_cow_head(skb, IPV6_RPL_SRH_WORST_SWAP_SIZE);
-		if (unlikely(err)) {
-			kfree_skb(skb);
-			return -1;
-		}
-	}
-
-	hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
-
 	if (!pskb_may_pull(skb, ipv6_rpl_srh_size(n, hdr->cmpri,
 						  hdr->cmpre))) {
 		kfree_skb(skb);
@@ -615,6 +597,17 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
 	skb_postpull_rcsum(skb, oldhdr,
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
+	if (unlikely(!hdr->segments_left)) {
+		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
+				     GFP_ATOMIC)) {
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
+			kfree_skb(skb);
+			kfree(buf);
+			return -1;
+		}
+
+		oldhdr = ipv6_hdr(skb);
+	}
 	skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 1bf6ab83644b..55ac0cc12657 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1704,6 +1704,14 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 	bool eexist = flags & IPSET_FLAG_EXIST, retried = false;
 
 	do {
+		if (retried) {
+			__ip_set_get(set);
+			nfnl_unlock(NFNL_SUBSYS_IPSET);
+			cond_resched();
+			nfnl_lock(NFNL_SUBSYS_IPSET);
+			__ip_set_put(set);
+		}
+
 		ip_set_lock(set);
 		ret = set->variant->uadt(set, tb, adt, &lineno, flags, retried);
 		ip_set_unlock(set);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 193a18bfddc0..f82a234ac53a 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2075,6 +2075,9 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 		return 0;
 
 	helper = rcu_dereference(help->helper);
+	if (!helper)
+		return 0;
+
 	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
 		return 0;
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 53d315ed9430..befe42aad04b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -41,8 +41,6 @@
 #include <net/tc_act/tc_gate.h>
 #include <net/flow_offload.h>
 
-extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
-
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
@@ -2774,6 +2772,7 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 		return PTR_ERR(ops);
 	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
+		module_put(ops->owner);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index cf04f70e96bf..4f6b5b6fba3e 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -201,6 +201,11 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_CN;
 }
 
+static struct netlink_range_validation fq_pie_q_range = {
+	.min = 1,
+	.max = 1 << 20,
+};
+
 static const struct nla_policy fq_pie_policy[TCA_FQ_PIE_MAX + 1] = {
 	[TCA_FQ_PIE_LIMIT]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_FLOWS]		= {.type = NLA_U32},
@@ -208,7 +213,8 @@ static const struct nla_policy fq_pie_policy[TCA_FQ_PIE_MAX + 1] = {
 	[TCA_FQ_PIE_TUPDATE]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_ALPHA]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_BETA]		= {.type = NLA_U32},
-	[TCA_FQ_PIE_QUANTUM]		= {.type = NLA_U32},
+	[TCA_FQ_PIE_QUANTUM]		=
+			NLA_POLICY_FULL_RANGE(NLA_U32, &fq_pie_q_range),
 	[TCA_FQ_PIE_MEMORY_LIMIT]	= {.type = NLA_U32},
 	[TCA_FQ_PIE_ECN_PROB]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_ECN]		= {.type = NLA_U32},
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 0ef15f8fba90..d5ee961ca72d 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -716,6 +716,8 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 	addc_llc->num_rkeys = *num_rkeys_todo;
 	n = *num_rkeys_todo;
 	for (i = 0; i < min_t(u8, n, SMC_LLC_RKEYS_PER_CONT_MSG); i++) {
+		while (*buf_pos && !(*buf_pos)->used)
+			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 		if (!*buf_pos) {
 			addc_llc->num_rkeys = addc_llc->num_rkeys -
 					      *num_rkeys_todo;
@@ -731,8 +733,6 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 
 		(*num_rkeys_todo)--;
 		*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
-		while (*buf_pos && !(*buf_pos)->used)
-			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 	}
 	addc_llc->hd.common.type = SMC_LLC_ADD_LINK_CONT;
 	addc_llc->hd.length = sizeof(struct smc_llc_msg_add_link_cont);
diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9ad76b7f3f10..6d4563b8a52c 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -108,7 +108,13 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#endif
+
+#include "gimple.h"
+
+#if BUILDING_GCC_VERSION >= 4009
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -124,13 +130,10 @@
 #include "gimplify.h"
 #endif
 
-#include "gimple.h"
-
 #if BUILDING_GCC_VERSION >= 4009
 #include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 #endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 21c8b474a4df..8a42262dd7fa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11162,6 +11162,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x8768, "HP Slim Desktop S01", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
@@ -11183,6 +11184,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x1064, "Lenovo P3 Tower", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 15b3f47fbfa3..9f66f6dc2c67 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -646,7 +646,6 @@ static struct regmap_config wsa881x_regmap_config = {
 	.readable_reg = wsa881x_readable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 };
 
 enum {
