Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13226BBF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjCOVut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCOVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:50:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993D54CB4;
        Wed, 15 Mar 2023 14:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKbdH1HfxjuWjd+UCM3uMic9HgK2YKAfTyZ54Vz/Fq8H8toOtLgVFkuBZV/et85mopnr53Ujv34WUNLoS6DQ/5RX9mGNeefuFb5FrvGzz2o3akh91M5YDt6tTTr7VRysRGhZhSXhW9cxkaGKQRaRfuBKH1X46HdEKCPDU2EFdS5cJGuAUCr+/VsIf6xQiO8ky3akGldGdZtt3akHX86ZL9l/Miw4CBAUrX9qcdV4aqiO0oQJQ4ErZd2gndTLSjmNBm8B2UM2xhguQpS3HfsBHaSft3e4fJ0YWBw8zOgWo6jGSrY5qKaBnioD3aMmkKwvjou18doUgtFRS3NCUv29DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf53NiFaqYMKxuYuOuLfcdW0MTCmgUFZ1LyEJPRYjY8=;
 b=jL8LWPf8ew0UBSYmtE/jQeb+WDrrB3ExGC+Y2oTmxx95UW84HZpTftdnDUoAw5lS2yk+NJ+eb8OZx+Al7aFMAagqpyWqpW9/u6LQNa5rjw/W1ka4dp3+EhRAyp0pFmqgGBOpJ4Q8/Ps2IR5byDb9UmP4yXlKoPKZ8m+ryAZGUevqq9rl+mwEYok06g+VjdS2vpX+qVfqBLbc+yBjNzWHT942lEzP8FGpUVv/i1dL5L2xbOJiKzaAsmEcqXo2Cdv6Kj/pnWeI0lPi9W7/BBoGAbMfKZyqd5YApK5QWwlLwXNrT0odf3GtNYxmagbi35ZDaHp826U6A2GqydKLEpWj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf53NiFaqYMKxuYuOuLfcdW0MTCmgUFZ1LyEJPRYjY8=;
 b=Wm22g87QFJQ1JTgIFH7dimH3tCiv2YS6bxQZ3wgxDBeG1BMl3tlsXDCo2zZrm5159GRJA8J1+yc3vWFKuMycL7kch4Nb/lErH6ysIZMRVAYIuTJoQ1bKFdQ0D5tXpZl47iQmMZzXFM0HXFOuEtIvzlQT/iCAfYXbJQkhN4q2Zx2zpGtJpCDBNm9yQ0QbmxlkDyoP/fMkqTY29yJRRg7AtfUuVQG99M+062hM53dEHa5MX+n7Fgngqj06ZE1NNopI9WMg7CfCjVPly88WMGMR0xo8qrCz+FDFzJA9UTKOXrL5hI/B4KFf/tynbEKswplU9pt8MDTTHceqiQzYUvQBBA==
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Wed, 15 Mar
 2023 21:50:42 +0000
Received: from CY4PEPF0000C985.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::f3) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 21:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C985.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 15 Mar 2023 21:50:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 14:50:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 15 Mar 2023 14:50:30 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 14:50:29 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v6 0/2] Support Nvidia BlueField-3 GPIO driver and pin controller
Date:   Wed, 15 Mar 2023 17:50:25 -0400
Message-ID: <20230315215027.30685-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C985:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a73c8e-b3e6-458b-2869-08db259f52ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mu3gY9s3MyGl9w2AhJIy8VeY7xgAhkvdq7oeK6Wd82fmTyQumcwuuLuzc5w6ruz4bV6HLb/OBHDGFSLS355k7s3ZusZTSjtNL1JXKouqtUGkriiXd1f7ltmsdBIkHX9bUpipjGOa28vl2FrY1sstF6LeOODZ029cUq+45UuWLNnva2nqcjEnbLsV0wGOpwOCJ7tWNic3NvL2sh1ukX5tONFXWmdqyXd0SduvRgTJJ7le9LUGjI3W16nKsjgmPwZUA1Iya95Zw0V7dtbqVcOtQOIfDfoOcShh4znNYhZ1KTUey4/5aXmay2CTOIZstviNj//21QSYy0TePKQZar7AgPmRffg1Gsed1NWWaffhhkIQ9s7vDilwmIRboqsz9FrW6K8QG6+TNDdoMVVduclDPpATKY3lWoCiiVIfNjRZKV6AVR3yVADQ3vMjSGj7frDnAn1kze6iCxLE6rgy9H3EGxgE6avvknb8nZBity/+EAp+FhxTByWDdwtZxBotasz063am85X6MCN5DVcUuTwBomR9UexFxKCsFzFwyZ7HLrRcdUJbWf06gwKOlhDG2BvT/afD7yh0zoTDcxlNwYE7I9XBm8ER3TzG0stMJ+cJCWrjcBf1M8rcpu/5LfV0wZ4damytrF+T2fYvGkHtR2qWOHoqAdUgRwwx4mZsvYliNMKsEmZJqx5shF0WuElzNNVOZtct5vL6y3lhJ4M+XD4aYaLyIDHkmromihuaxbKIZ4xCr2piwuUdpRfXexlFz/H
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(478600001)(36756003)(7636003)(36860700001)(82740400003)(426003)(47076005)(316002)(40480700001)(1076003)(26005)(110136005)(6666004)(356005)(41300700001)(2616005)(336012)(70206006)(186003)(107886003)(8936002)(5660300002)(7696005)(86362001)(4326008)(40460700003)(8676002)(70586007)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 21:50:42.1233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a73c8e-b3e6-458b-2869-08db259f52ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C985.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes from v5->v6:
- fix some nits in gpio-mlxbf3 and pinctrl-mlxbf3
- add err.h and io.h header files

Asmaa Mnebhi (2):
  gpio: mlxbf3: Add gpio driver support
  pinctrl: mlxbf: Add pinctrl driver support

 drivers/gpio/Kconfig             |  13 ++
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-mlxbf3.c       | 248 ++++++++++++++++++++++++
 drivers/pinctrl/Kconfig          |  13 ++
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-mlxbf3.c | 320 +++++++++++++++++++++++++++++++
 6 files changed, 596 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf3.c

-- 
2.30.1

