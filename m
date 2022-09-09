Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059235B3FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiIITiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiIIThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:37:12 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3660C11B037;
        Fri,  9 Sep 2022 12:36:46 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id BD46DDBE;
        Fri,  9 Sep 2022 22:40:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com BD46DDBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662752427;
        bh=lR+XuoZ5OpBeN2gxrD/crsk4SZmx3KT/fJ296KmTZDU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dkQ7x92rwf4ZFGPkITL4+WyM0/2sdRRqBOD8LTdLfDPJFUUgk3LyPApiRqFDlQSoF
         RyHGPCSvDKXnSxJmZdwaQQQnCcCP/hNo87eg2bFrQZa+AkcwQbgBO37yQyPcU10op4
         fRYZi0qr6UvIg/HtJARYcugtNHtU/B6wE+38R5fM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:36:39 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v8 12/23] ata: libahci: Extend port-cmd flags set with port capabilities
Date:   Fri, 9 Sep 2022 22:36:10 +0300
Message-ID: <20220909193621.17380-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently not all of the Port-specific capabilities listed in the
PORT_CMD-enumeration. Let's extend that set with the Cold Presence
Detection and Mechanical Presence Switch attached to the Port flags [1] so
to closeup the set of the platform-specific port-capabilities flags.  Note
these flags are supposed to be set by the platform firmware if there is
one. Alternatively as we are about to do they can be set by means of the
OF properties.

While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DMPS and fix the
comment there. In accordance with [2] that IRQ flag is supposed to
indicate the state of the signal coming from the Mechanical Presence
Switch.

[1] Serial ATA AHCI 1.3.1 Specification, p.27
[2] Serial ATA AHCI 1.3.1 Specification, p.24, p.88

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Changelog v4:
- Fix the DMPS macros name in the patch log. (@Sergei Shtylyov)

Changelog v5:
- Add a comment regarding the PORT_CMD_CAP enum entity purpose. (@Damien)
---
 drivers/ata/ahci.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7d834deefeb9..27cab4e909a5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -138,7 +138,7 @@ enum {
 	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
 
 	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
+	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
 	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
 	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
 	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
@@ -166,6 +166,8 @@ enum {
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
 	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
+	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
+	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
 	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
@@ -181,6 +183,10 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	/* PORT_CMD capabilities mask */
+	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
+				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
+
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
-- 
2.37.2

