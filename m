Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F43692995
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjBJVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjBJVv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:51:59 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956413DFD;
        Fri, 10 Feb 2023 13:51:56 -0800 (PST)
From:   Patrick McLean <chutzpah@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Patrick McLean <chutzpah@gentoo.org>
Subject: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung MZ7LH
Date:   Fri, 10 Feb 2023 13:51:51 -0800
Message-Id: <20230210215151.812839-1-chutzpah@gentoo.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
SATA controllers:

ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
ata1.00: failed command: SEND FPDMA QUEUED
ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
         res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
         0x4 (timeout)

Since this was seen previously with SSD 840 EVO drives in
https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
fix for these drives as the EVOs have, since they likely have very
similar firmwares.

Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2ea572628b1c..c4c89d24f84c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4045,6 +4045,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NO_NCQ_ON_ATI },
+	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NO_NCQ_ON_ATI, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM },
 
-- 
2.39.1

