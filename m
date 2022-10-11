Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE4B5FAAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJKCrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKCrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:47:08 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74A83F3F;
        Mon, 10 Oct 2022 19:47:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BBCC6418F0;
        Tue, 11 Oct 2022 02:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665456425;
        bh=HflF1gV8seldaSEOgSdsCH6aT1WH34HctisODV95CKM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=smN7y8fcRIGAGA+Y1nvNREFbNXAoUi0BsgX8aOZtMrvnmJJFb9mVglOJlUMqFWV+T
         2CQ2N0Neb93miP6BnXpluwI29g0hg/0k0ZultDmJN25hvlpE3Lut9hKLOpTdkBMOjq
         /aPmtM5Pf26rXB85MlniD6skpWodkGuF3220ZVslTJZS9Gj/bg2OYBhd8THBXKtc0X
         xCDtJ2lbjfExZM1vDUTTrgBySMs99QoFVu9foawGjfHrcSTlCUJqnyEYyeuETZPzWv
         DLnxZe4WgEf7/0YBvbmiPTTlY6KNcq+X/l+T5A7082mdgdCP3sodAwldzQoXqRuxwN
         nYfn6BGmU6uCQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: ahci: Match EM_MAX_SLOTS with SATA_PMP_MAX_PORTS
Date:   Tue, 11 Oct 2022 10:46:17 +0800
Message-Id: <20221011024617.720898-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains about array-index-out-of-bounds:
[ 1.980703] kernel: UBSAN: array-index-out-of-bounds in /build/linux-9H675w/linux-5.15.0/drivers/ata/libahci.c:968:41
[ 1.980709] kernel: index 15 is out of range for type 'ahci_em_priv [8]'
[ 1.980713] kernel: CPU: 0 PID: 209 Comm: scsi_eh_8 Not tainted 5.15.0-25-generic #25-Ubuntu
[ 1.980716] kernel: Hardware name: System manufacturer System Product Name/P5Q3, BIOS 1102 06/11/2010
[ 1.980718] kernel: Call Trace:
[ 1.980721] kernel: <TASK>
[ 1.980723] kernel: show_stack+0x52/0x58
[ 1.980729] kernel: dump_stack_lvl+0x4a/0x5f
[ 1.980734] kernel: dump_stack+0x10/0x12
[ 1.980736] kernel: ubsan_epilogue+0x9/0x45
[ 1.980739] kernel: __ubsan_handle_out_of_bounds.cold+0x44/0x49
[ 1.980742] kernel: ahci_qc_issue+0x166/0x170 [libahci]
[ 1.980748] kernel: ata_qc_issue+0x135/0x240
[ 1.980752] kernel: ata_exec_internal_sg+0x2c4/0x580
[ 1.980754] kernel: ? vprintk_default+0x1d/0x20
[ 1.980759] kernel: ata_exec_internal+0x67/0xa0
[ 1.980762] kernel: sata_pmp_read+0x8d/0xc0
[ 1.980765] kernel: sata_pmp_read_gscr+0x3c/0x90
[ 1.980768] kernel: sata_pmp_attach+0x8b/0x310
[ 1.980771] kernel: ata_eh_revalidate_and_attach+0x28c/0x4b0
[ 1.980775] kernel: ata_eh_recover+0x6b6/0xb30
[ 1.980778] kernel: ? ahci_do_hardreset+0x180/0x180 [libahci]
[ 1.980783] kernel: ? ahci_stop_engine+0xb0/0xb0 [libahci]
[ 1.980787] kernel: ? ahci_do_softreset+0x290/0x290 [libahci]
[ 1.980792] kernel: ? trace_event_raw_event_ata_eh_link_autopsy_qc+0xe0/0xe0
[ 1.980795] kernel: sata_pmp_eh_recover.isra.0+0x214/0x560
[ 1.980799] kernel: sata_pmp_error_handler+0x23/0x40
[ 1.980802] kernel: ahci_error_handler+0x43/0x80 [libahci]
[ 1.980806] kernel: ata_scsi_port_error_handler+0x2b1/0x600
[ 1.980810] kernel: ata_scsi_error+0x9c/0xd0
[ 1.980813] kernel: scsi_error_handler+0xa1/0x180
[ 1.980817] kernel: ? scsi_unjam_host+0x1c0/0x1c0
[ 1.980820] kernel: kthread+0x12a/0x150
[ 1.980823] kernel: ? set_kthread_struct+0x50/0x50
[ 1.980826] kernel: ret_from_fork+0x22/0x30
[ 1.980831] kernel: </TASK>

This happens because sata_pmp_init_links() initialize link->pmp up to
SATA_PMP_MAX_PORTS while em_priv is declared as 8 elements array.

I can't find the maximum Enclosure Management ports specified in AHCI
spec v1.3.1, but "12.2.1 LED message type" states that "Port Multiplier
Information" can utilize 4 bits, which implies it can support up to 16
ports. Hence, use SATA_PMP_MAX_PORTS as EM_MAX_SLOTS to resolve the
issue.

BugLink: https://bugs.launchpad.net/bugs/1970074
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/ata/ahci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index da7ee8bec165a..7add8e79912b1 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -257,7 +257,7 @@ enum {
 	PCS_7				= 0x94, /* 7+ port PCS (Denverton) */
 
 	/* em constants */
-	EM_MAX_SLOTS			= 8,
+	EM_MAX_SLOTS			= SATA_PMP_MAX_PORTS,
 	EM_MAX_RETRY			= 5,
 
 	/* em_ctl bits */
-- 
2.34.1

