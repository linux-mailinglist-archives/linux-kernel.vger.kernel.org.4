Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D756069B4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBQV1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBQV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:27:01 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C75B778;
        Fri, 17 Feb 2023 13:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQhCD9hkk8/CbwWmYVVO5BQL+uc4HWSetCGJz4qyzmpTzO00XLgnSy9Pdy3YIIlQl32y59E23RqXhXs9ogj704JCU5Zfu7a+R5WFeyHsQS7zZ4Y0dwkQ1jGmuUe1AGaO4SMXIf2Trk1IVyR3226FTr9TBHmlNfWA4JZoCy/e/bDKZD4hIUK95t14hzRbRN1ElsxXvNGwfafDf9JuSVil3dXyuuTlXe78Q88227LxFUTwJbgxScs/0a9g5emHDQtqfgiwuxkL4iLoX7tAzAe5p1ZULbXpkXHHXKH71z5WQGWw0KSvifa0DGxDN01ej59SE/aecaiJ5hOu4XH/nReMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7cBqskYjqRz8gbokM4CNwDnCMkbCjx2zxgQ839T9yQ=;
 b=bhT8u+XG/rfRSviMsf2CLpak/FVARJHV0epbIFKSao1FuGP4tKog7XUi6Y1grcYkXab4YYzx40QEGOVJ1KqPuPPFgtOVABhb9q8m958J4h+50LQ3+dlJPipGkoLZCk5d2G1A6kInj/ZEPbaz/ROQb7G38fFtjrupIqNqwo5IHnr3bDRVICoOwemzM5vyciPglc4s7DKiCgPOeyh3EWN8zyuCsOqTEIBApYCPS7XijbCIrd6yMe0XqTEu09+wEw/xgEF8mE0pUrmp0WrtElxTiUOF34/5t2FE1TRmKNOzm3cK5Cz6o7qfUz2+O8/QALDlZp7IUJLIM6jIIXC1U00D4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7cBqskYjqRz8gbokM4CNwDnCMkbCjx2zxgQ839T9yQ=;
 b=EUwGw2ttQhcub/7ftct3DNFmaUBq6SEZxcMZ+sL3QU/m7f5dkS/t/SzUOoGDY6zj2A1Y1zNum1ObNNz8j4c3oC7Aq/vsw2Tc330QRZ8UpJT4jaEC6aWPTkx+iyLocDARNItij0dNgMPm7fza3kfIBNJHBsmCaZ+hwsIEl6KxDhSDLea9fByXLmg2gXsKGw0rzsHkmR/mgkmhenk/taLCKwSKbnNvAlAKPzHh9mX9Kk0m6QZ3jt1UavXGJDN7FCd0z0NqEGKmK8A1WZNxAegHCUQTlnfBEzIJbgSJMn5SCTVu9w+qW1i0g6laSJJ1ADRRz4frq3ov5k6M1svXfT7Knw==
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 17 Feb
 2023 21:26:57 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::63) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Fri, 17 Feb 2023 21:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22 via Frontend Transport; Fri, 17 Feb 2023 21:26:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 17 Feb
 2023 13:26:55 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 17 Feb 2023 13:26:54 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 17 Feb 2023 13:26:53 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v4 0/2] Support Nvidia BlueField-3 GPIO driver and pin controller
Date:   Fri, 17 Feb 2023 16:26:49 -0500
Message-ID: <cover.1676668853.git.asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1676042188.git.asmaa@nvidia.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a74026-994f-48ea-d32e-08db112db252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LKo5FYpZ2pJdpuc7nwtNnB6/oTmXa7dZ5I8/vN5Zv1/QKUfV/UNxYI+I6DCkXyVLSDd+n/pFaaD6AmPnGlmr9YJ9MhzlJDRbdTKPkszY4K1llVxLk+Mk3FZUO9bvy1RGir/trcjqUVzv3iMVWa7zfWdh+nNm9au4dNhWfHLrf5z6PUJw0Vz3ax2xDAEg+K3nh39olVOa5TwQbP7cz40pHrvI2/E4YuEml/AurxQ3rOHMNlTKEDJaLjlxlCPsALgG2Ry4gozmZqc1b83RZzS81WsPoCCag7n1gkF/XbDW7ZpiPVYJ81y7sx0cT/yn+nRp7YwxkMjOgXUFEZ5N21Rwg/0C56KxbG6Yhq89TG91vLzj8VeErsWoNol9NCbx9DUpTRovKwgVMSj0dDRj7UYK8LOLp1u4bdiLv726k/4QGazQPMkiuhOSaIL99Ibj5fNhmNikdJF+XV2HmkuLzoeo8wmE3Vhf4Pknk3a/sgLTsU9zG9tLk2ehpQYe6STUtOAZn4010EG6fPgaxJoLvA/ovqaxUuI3phI+rdearY0AJ3kj32+KN0Iy319kgado86CXvwAHJmqcSSnjm4097amWTOMVV7M0KyLF5B8cqck57xhk/OZ16ouTOfXZIilHPoLa+2Lxt82FVFgw7EgTL7RerMe/Ol1wxf+fu9YCG6rN+S4SA4u8aq6wieEdSVGQ15mtRbSKhZGOKEWZ3KI6CzJ5g==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(41300700001)(36756003)(356005)(2906002)(70586007)(82740400003)(36860700001)(7636003)(82310400005)(26005)(4326008)(47076005)(110136005)(478600001)(316002)(8676002)(40460700003)(336012)(426003)(2616005)(7696005)(86362001)(83380400001)(6666004)(70206006)(8936002)(40480700001)(186003)(5660300002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 21:26:56.4623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a74026-994f-48ea-d32e-08db112db252
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the BlueField-3 SoC GPIO driver for handling interrupts and
providing the option to change the direction and value of a GPIO.
Support the BlueField-3 SoC pin controller driver for allowing a
select number of GPIO pins to be manipulated from userspace or
the kernel.

The gpio-mlxbf3.c driver handles hardware registers and logic
that are different from gpio-mlxbf.c and gpio-mlxbf2.c.
For that reason, we have separate drivers for each generation.

Changes from v3->v4:
gpio-mlxbf3.c:
- Update the Kconfig file so that it is conform with checkpatch
- Remove unncessary headers and add missing header inclusions
- Make irq_chip struct static and const
- Replace generic_handle_irq(irq_find_mapping) with
  generic_handle_domain_irq
- Simplify logic in irq_set_type
- Replace valid_mask with gpio-reserved-ranges
- Cleanup code

pinctrl-mlxbf.c:
- Cleanup code
- Update the Kconfig file so that it is conform with checkpatch
- Remove unncessary headers and add missing header inclusions

Asmaa Mnebhi (2):
  gpio: gpio-mlxbf3: Add gpio driver support
  pinctrl: pinctrl-mlxbf: Add pinctrl driver support

 drivers/gpio/Kconfig            |  12 ++
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-mlxbf3.c      | 230 ++++++++++++++++++++++
 drivers/pinctrl/Kconfig         |  14 ++
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-mlxbf.c | 338 ++++++++++++++++++++++++++++++++
 6 files changed, 596 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf.c

-- 
2.30.1

