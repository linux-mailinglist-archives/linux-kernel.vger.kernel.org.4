Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF1B6A208F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBXRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:40:25 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2244.outbound.protection.outlook.com [52.100.157.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B784269AEB;
        Fri, 24 Feb 2023 09:40:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfImz7ntGsE5nrgVpoTEYrWIkGGH5Mu2AMRlX0L8w3K8hFbl2pzWyJlU6DVjkJEXTjtWoPPQmui+aKWkrsL0whriZeBw8LO8KlJygcsnvVEPsGScmkuSbo4tXz8bIIZq2NjwNnJdDJIkRYXknDnmqBshMoBSQgdSIo3Phn+RImc3ErSkXNW9Al7VsXNAzuSEcaNBF7yJqCI/1EgVTlnUInI+r/WiN5sWb+3A08QYXufPtN2kr6Hq0NjJ0ZsFWksLpKPq5XOBhMr+NmT4ZVv2OgjJvFgdNX6JM36UPdz/C67Wscgno19uq0nKqrPN08SxIPn1KOT6BJyQrPi6eB0diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PMq/i/FulQVIpfMseiPXE5FktUUFiMwo7vKnVb/0ao=;
 b=Fiu29smrDWmot9A1q97npccUiOeF7pQV6HK5qHY/Wl4uzUdmto/S7kD9fOi+QqlFuNxE21yrcFKF1qEoo1rNFwmqTpG+PhOVBU+s9AgfBaCgLVzPcAZ+jek0re55mGU3jdcYIFBIDol8dRDJAvbhcqhaV/RS1PHZOZ8NJZFIRT8XokL+PyxtMgo+RFTddBovWqif9Pmf/GTOP5ljh/2yDbMwghZ3HsWBaIOsIDK+DowisoOtYjFIdXiqM3m0kAwm8dH/hmjbpd9HvZQ/p0UHuLkvM3VqoclFKmjmBWMzTgqrU1Uo8iegIoThe6MYqTj1zlXbTEldNIR+bgh2biNIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PMq/i/FulQVIpfMseiPXE5FktUUFiMwo7vKnVb/0ao=;
 b=F4XoxM2YZnzv1aMJ2qVoqiGepz7a7MD1o05GxUr8zMHQrjqmNXy/TSzmnuH9OTWaR3XDQg+Dv0c1rJzaF8W4kHb3f7NwbNSlrp2BE3PHJCybllZADrkrYuElQrsn9LL/RtvBcYb3XeX1IaJ+0Jo4nk47dfUZa4E4pN8I/Dotr3N5UHotpxPoE1Bol7TcPUqIbB7OElQWdSjiadwM2pDZuCcy0ZDD9Xdyrt/MWl/An3dUf8eIV2srlPhAu7b/fAK1OUtTZAbG/aesm9Vd0IpmJbP4sXkd87ecy/PtouVxid76LVgI4GmQN+r3owmhJJLIK9qoYUwMzzdh8n3UUSy/3Q==
Received: from DM6PR02CA0044.namprd02.prod.outlook.com (2603:10b6:5:177::21)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 17:40:22 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::7) by DM6PR02CA0044.outlook.office365.com
 (2603:10b6:5:177::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 17:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 17:40:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 09:40:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 09:40:10 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Fri, 24 Feb
 2023 09:40:09 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1] gpio: mmio: handle "ngpios" properly in bgpio_init
Date:   Fri, 24 Feb 2023 12:40:07 -0500
Message-ID: <20230224174007.13009-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ec89a9-682b-4688-fd53-08db168e3444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSb/K5QOvuvbuAZgjg2roUfMpQIFyU0s+Thgl3l1zFcaLU7QdNu5B9AgnrdXRa30NeXBUmZ5VuQQyKviJaERdA2do1cdZaCi23IkiBKH7oZOltcBBPuOEiRLTuscNs43U0YiKsc/r4ULhg3ljuRwxIO4w2cK+Mv7QjbuKLWZYIwo4sEHyNjUV49ydPtgjRG0LS/nerXvOlan4UWI4sKBhhGmthDgvOhyQd3msRCC19qfCKTSA2YJHGv2Dc5Pzwf+RZIZa0aKCSwyCE5d3C9+NuGj6VoPdEMnGlRQoDh/uKv3R+fxd7Snz01kFazk/SQnT+x2fKko/eJ7tZvJGgEig5gkNZ526LAi40zlY3JAWARiHgMQ9tu1bb7bE24DrgRe97pzS69Vl5BtL7pbiGD+Qpnjaok33y1muDdVNyxVNsvHeclihmtgcfxvty8cbEJP0EiGz4/82yJd8agv/QT2nWI4v4nng/MTKGnAGqMsJNOXZ/gcBbWHCW2uGioRixo9IjzQShHnM0pYHZRXjHI3XTPikWhUWmQ+z+FLi+vizcvHvRVT38CMtZud9x7+EzNY7vffF2XqS1btdbKTjvPHbs+phFipJVBWvW1EbUtcYo99XJU4HsJVqSwIKLRVtbRLw8lD9cTttBk6FPYrdTNHq4k63gd2t/TL3ofb142TgTJhAG+BuNmp2DZ8XyKJ66LwS4nyFDGIBsUtReR14LGyUobAgyHfoGoagxWI2C5flJcRVGhA/9D2V6B+aRvif7mGfCPiW13bODrm/IzLNssbMiL/OVEDn4xOdmE02vGRQf4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(5400799012)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(2906002)(82310400005)(7636003)(82740400003)(86362001)(336012)(478600001)(7696005)(186003)(47076005)(426003)(2616005)(26005)(40480700001)(36756003)(356005)(83380400001)(110136005)(63370400001)(63350400001)(40460700003)(70206006)(4326008)(41300700001)(107886003)(70586007)(316002)(8936002)(1076003)(8676002)(5660300002)(34020700004)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 17:40:21.9598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ec89a9-682b-4688-fd53-08db168e3444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_init uses "sz" argument to populate ngpio, which is not accurate.
Instead, read the "ngpios" property from the DT and if it
doesn't exist, use the "sz" argument. With this change, drivers no
longer need to overwrite the ngpio variable after calling bgpio_init.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/gpio-mmio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..f317a371c529 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -601,6 +601,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	       void __iomem *clr, void __iomem *dirout, void __iomem *dirin,
 	       unsigned long flags)
 {
+	u32 ngpios = 0;
 	int ret;
 
 	if (!is_power_of_2(sz))
@@ -614,10 +615,15 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	gc->parent = dev;
 	gc->label = dev_name(dev);
 	gc->base = -1;
-	gc->ngpio = gc->bgpio_bits;
 	gc->request = bgpio_request;
 	gc->be_bits = !!(flags & BGPIOF_BIG_ENDIAN);
 
+	ret = device_property_read_u32(dev, "ngpios", &ngpios);
+	if (!ret)
+		gc->ngpio = ngpios;
+	else
+		gc->ngpio = gc->bgpio_bits;
+
 	ret = bgpio_setup_io(gc, dat, set, clr, flags);
 	if (ret)
 		return ret;
-- 
2.30.1

