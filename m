Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2399F6BA24D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjCNWTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCNWSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:18:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760D3D900;
        Tue, 14 Mar 2023 15:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8HRgX/qT7PNIaSNUyST1aJUn21GADKq9vblq3P5z9iZeqqwq/Jk0iS/uRh03P6kor24Z/3VFNISPKdQqNHu/NnkbldCZNiK7yFcd/2ny15xRddUhTY6m5/RgEUQjV5JfREx5xlCCvrbsqAdSIXaGQVO4zvLPzK/r72IsKyDwjRE1RsS16CeamDe79S27wyO7DEI50DvhidOSaDIZjvVW3/F2SOgU/IncwHl+0Xze2qjRKQVlKsd7EamH5dW1VQQ/jLVDLG0ovQxgk3XzPW1DYsSsfUzAUJzRL3WvDefJDaktIoC3G1CsYEro8Ccr8BvBSZ+OXOTlIjoumDaL8tseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajm4cM/SDscpTP5NCaCBP2YiAnuB7KmMUn+1l3/l/Io=;
 b=EyvydZ2tqbaYgjgaC6gAtcTGYi0z8VSylVM3WtD4viL9Xx0ZfdWJsraXv6XPd6qT7rxcadKRKx/aMzqvOxDYe/QCbhNR+Tau8nrhgUwFwQHcSYA6QiTaBkUhECRYzALyl/OkL8yhFIpqkCZ7HXC9Du4u+Z8Wd/lkqgi+8/pzkb+1ZXbYGIL1+VzKDrIKiaFuCoDHoYU/pOKoh+nXYvJnImmjkBj7XlKsekJOqUNHuphgyiALfvlPEn918CPjiPFHsQn1T9MQkvSCyAfU22kXrSmgfohW7/Nojd99DeMJTAFuq9fKgyiWMNckn2yny5seItFifuIfzEY3EKtsNcZAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajm4cM/SDscpTP5NCaCBP2YiAnuB7KmMUn+1l3/l/Io=;
 b=sQI66LNf0LgNaM1m8QTekxsz1oI+D4ViqQIwcSVtfwGHQUDKXwEUORQDzgADmhr885Ps0MGTyIhyTQo7uIXuBJ9n11ue87K/eQ/KaVFOP+xS1Z6WES5n6Ic4H/Wwn2GxKmoX9INFXIQezzAlDu6h5O//QjJUWq15ycsYbpEufaDLJJekxKTnFIOck5/AJMzmZSACiSK+lS2xFsq+oQW1k21ar4lvLS4AoZ/wPsrIp8JrIS5eSWJq6FMDj+y8OmYPg4ARlwBURIiM1/p26q9P4ByLu3hd4GYhmbcH+VWAaKSzYAWrfmZXr9ofoG9TryiObmABxVDfRAHpF4J4MbANHA==
Received: from DM6PR02CA0156.namprd02.prod.outlook.com (2603:10b6:5:332::23)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 22:16:23 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::8) by DM6PR02CA0156.outlook.office365.com
 (2603:10b6:5:332::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 22:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Tue, 14 Mar 2023 22:16:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 14 Mar 2023
 15:16:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 14 Mar
 2023 15:16:14 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Tue, 14 Mar
 2023 15:16:13 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 0/2] Support Nvidia BlueField-3 GPIO driver and pin controller
Date:   Tue, 14 Mar 2023 18:16:07 -0400
Message-ID: <20230314221609.22433-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 493e7f26-5247-45b2-ea99-08db24d9bef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJJ54gPofO/DzG1JcXWuNT5nD1vcDPhJeMDXIQmRorJ7acs6lYejZhhRi7kmnSJTCel0vULDO+hvbOxFpHYiaqSDNpInr42e3OtE/eTLBpYNK4E+8tkTWsAGc7Ko6aG7dTZ8bL5aoO0Z1m59R/OmSiqfnzbNzALco4bi4XSvMXCqRfv4jjRo09n8QxREW+Ed2TWQAhLg+hm1PKCSE6fdu7CB5sbyLVO96VHraY9I7oY8ivjUh5VCsHvAT5zphiPUR/+GNxtOxEKgaWNlnJjdJaq4iJ6CxKD/m2way+HIlyRy1shlVoSo084UhaKakMgtHNIsns1p9OUp9yJj1kZJ4Q0L1+qAvKJpXmi1STOQZbgLGYj7xhgdRK1mABTpbJwrxPi6sQaR5aCtNfO2yVjwbFFsPumit1iN0pBM74y04EihL4fviuQD2XqLddPv3E1ICAqRqSco3SwDpjqPUuZy5k97S1sDLFSLwqqKR9kT7cL+yV2L+uBJvf04RZm5oUGLaRBlQsqYMx+vmHXhyAyP7IUVnC7TUHq1d8tf29Y0/rKbElvlXuUtcDCkNuYAx5mJG0lJSQhcF5X9BieLcB5i8CLoYJC0yWT9CtUxM76tSWjIcOlYsTUgAO9uMpCkLRnQDoOgxrij9mP0cXNg13BtTgxIiRy2EShp58jxozuNTQNjvd7zQpgd0lzTpkT3oAk0y5ywyglUhtmX+U0dYxJbNZ3VGG0qLanTbz3Hg7gxqUCpOZczD+kd2xVXVFERNXTA
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(356005)(8676002)(36756003)(478600001)(7696005)(8936002)(2906002)(41300700001)(5660300002)(110136005)(70206006)(70586007)(4326008)(316002)(82310400005)(83380400001)(36860700001)(7636003)(82740400003)(107886003)(6666004)(26005)(426003)(1076003)(336012)(2616005)(47076005)(40480700001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 22:16:23.1810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493e7f26-5247-45b2-ea99-08db24d9bef3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes from v4->v5:

gpio-mlxbf3.c:
- Update Kconfig dependency in gpio
- remove version.h header
- use irq_hw_number_t
- release lock in mlxbf3_gpio_irq_set_type
- add IRQCHIP_IMMUTABLE and GPIOCHIP_IRQ_RESOURCE_HELPERS
- remove npins property to use ngpios instead
- Assign handle_bad_irq() in probe
- Use handle_edge_irq instead  

pinctrl-mlxbf3.c:
- change the driver name to pinctrl-mlxbf3
- alignment cleanup
- use PINCTRL_PINFUNCTION
- use pinctrl_add_gpio_ranges
- use devm_platform_ioremap_resource


Asmaa Mnebhi (2):
  gpio: gpio-mlxbf3: Add gpio driver support
  pinctrl: pinctrl-mlxbf: Add pinctrl driver support

 drivers/gpio/Kconfig             |  13 ++
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-mlxbf3.c       | 245 ++++++++++++++++++++++++
 drivers/pinctrl/Kconfig          |  13 ++
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-mlxbf3.c | 318 +++++++++++++++++++++++++++++++
 6 files changed, 591 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf3.c

-- 
2.30.1

