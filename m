Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB666A224C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBXTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBXTUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:20:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2245.outbound.protection.outlook.com [52.100.172.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5363DDA;
        Fri, 24 Feb 2023 11:20:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLqNRE93R9QUOzgROc4IojZVb5I3OBrRhp7WURUDRk9dl3FKLBKNmEkfpo5eKM6bh9hG78YzU/GgcBERPos1zOOqmKjEH17+/bHJcc0BJN9l8fcXqDeQqZWSoqaTieHN/XjFPblHq60CrKaJWpAvn54WCjMKe54VXFq/U69Hw4/Cqk7ePyitehCjHQ1h3AH4sS0D3F8AUzLfSh+ccVvuDLXhm3POGXvNvE0muabhzPYB+MeTKCfJZ3lI/tBcwS9cyEgS5TaCeL7DLpi++k8oe9PQWd+aNbYmmCVmuZ6fnYSr4j8u7k4Ij6f/ksuNLTTXy7Ca/iZSqiGMULrt+Bi+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HYmUjtadAdO2hXTJllHHg25Wljp1srnA0w9FCDso4g=;
 b=Cvr7FKt0BSzaE2y0TyXQl9Jqub1ua0BW+H7w+lV0tEW20RVpZDxBfnJ2HbOkHZugK8ed27FsgTy5SF+Lge8GhNZlN+xW+QxPoKGF26yg7vgq/9dxab+hJBllBk3ym388YVwVLnFXP9u6mK8Hzq47qlW4NN9p6AusVg8CKGfg3m5rpFxXk1ctLyo7dw0OjSqTJCTEgxjEQaDqyVsIHMsPPbvASGHNK0OPYXc413GtxfcC14h8Qid/5NXFJ45eMEFVnm05FORcvVi5EUPOpN3FAoo9wQgoSWkLJzxN+TR0riDz0Yk2X52MxQshinFsA5KD/KDsVB5Jr7TTkvWv9mI/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HYmUjtadAdO2hXTJllHHg25Wljp1srnA0w9FCDso4g=;
 b=cBZP1j6MgLydTFfaa9DYiuUGtNEOKZd5a8hyg/hhN3YvZKrGFVtAF+WNGyWiwnKEX+MnusrtzmHGm3prkS3xG8M32Ugf+dxi6J48uTgcBJvx73A8jfnnuzyPDaIdGlyYpRbbff6Cwy5jttb2eEhT319w8HEjhwHEpJXiKN3T96AQQxLX5cTmnN9+D8ZrFdzUS1KDbQDtFSyQRJCQfH2/8ZpiW8FpeSk1i1nIfA11j4sRtRkwL7Cu5dUzeCJv/qJDi6V3TiqG7WeuPm34wn58ZbS5MJovujNpuBI718DLOVCoYoQ7GbqMSE62tAm03y/Tpedpu4DasnbQGSCFsQld8A==
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Fri, 24 Feb 2023 19:20:34 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::46) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 19:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 19:20:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 11:20:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 11:20:24 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Fri, 24 Feb
 2023 11:20:23 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2] gpio: mmio: handle "ngpios" properly in bgpio_init()
Date:   Fri, 24 Feb 2023 14:20:21 -0500
Message-ID: <20230224192021.22591-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: d908838a-c322-44e5-6b41-08db169c337f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atrnj6Z+TzTn0X3W8k5bucD8MVB/UodaKcaeuEPbju17CAVqyvxaFbMV8OSQpXeqOjxYKjdjN8osWnj60ccMSSgSOC80feZtJ+eunbW28URCDnneUmwWJDOvVpBCooKiEJSRrcXDOKuE8WTZoN9WOwoCKUAclp14h5AIpgczuMseKOntW4lsFfp9Q5XkGsClfEuCg4iYIQrRbXZI9U/x1yaILCccIOHxrAWL/iTzhvIihu6yl/UFY84qVlXxFrLFrwVJtPFMhE73zraD66aF0yQV2d9U5dwN5Yeygx5cD7OZHM9m3PCpBEc4Lymo464tBUjXCIv58IMZLXx1uXm5WXB4oBfyuBcgwOM+bgpQ8tMTHRNlX7Y1+JpLc1HdBAqPjHvqt5wo7z0A631SBiRhouXWhfg+TXZUvKcio63fiNHTlv99aAfgQim3SM13ChbpNkUGEEp37Qbz8jN2zgPCEYejuZJtajxt/j2NCG7M1ZyEfDjvXdoxtHb8vOJCOgevwO7RmxhStreNzzEDrIcvA47kPxS34mSo7rDUpZ8VfdQ6j5PARzmLovn+gf4b6+hJp+X6po+UbdgcJ9bH5Mj1A5jPuCex/6/DdDigJ0jEKaQytxOFwU+YQPrk52bwPmhnknswZdF1yNAswutgo0acupYgszPrpBCFeIhos30dOJmQ/PSXDraewUuam0xRh2ch0pc+Zpzrsb6BPfRZ6L5DqsCcRke0TYmsibTFpm1fECYzRWKhQTESe8eApEvUt16Tz54UcNnhtDZ3UQnLC0FP3w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(5400799012)(451199018)(36840700001)(46966006)(40470700004)(4744005)(86362001)(36756003)(8936002)(41300700001)(5660300002)(2906002)(34020700004)(82740400003)(83380400001)(36860700001)(7636003)(356005)(110136005)(478600001)(70586007)(70206006)(7696005)(40480700001)(186003)(40460700003)(26005)(82310400005)(8676002)(336012)(2616005)(316002)(4326008)(1076003)(107886003)(47076005)(426003)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 19:20:33.6348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d908838a-c322-44e5-6b41-08db169c337f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_init() uses "sz" argument to populate ngpio, which is not
accurate. Instead, read the "ngpios" property from the DT and if it
doesn't exist, use the "sz" argument. With this change, drivers no
longer need to overwrite the ngpio variable after calling bgpio_init.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/gpio-mmio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..448fefc4468c 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -614,10 +614,13 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	gc->parent = dev;
 	gc->label = dev_name(dev);
 	gc->base = -1;
-	gc->ngpio = gc->bgpio_bits;
 	gc->request = bgpio_request;
 	gc->be_bits = !!(flags & BGPIOF_BIG_ENDIAN);
 
+	ret = device_property_present(dev, "ngpios");
+	if (!ret)
+		gc->ngpio = gc->bgpio_bits;
+
 	ret = bgpio_setup_io(gc, dat, set, clr, flags);
 	if (ret)
 		return ret;
-- 
2.30.1

