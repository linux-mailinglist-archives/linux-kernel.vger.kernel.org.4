Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45176B5091
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCJTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCJTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:06:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F921308C5;
        Fri, 10 Mar 2023 11:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNSErk0G6nJOcPP2tmr4XXGKpZ2auep7vuk8r2BhyqtG+nEruULv1/F2TN6bGJxg/AAMnp8IpuFkHUL8w13w7hizDIrTGvD9EX83cmX46qugzK8mfzN8d7bW7mjlYsBaGgKFhVSt7iW9tn3o1fPpSPHSs1CxbA1TUX6bPW7sPt9pJP2EjeYv68wAzNHu8wqFRrOXz5CNih99YRitbl1s15hLD/UOFHHc48vtMqlrF32yXAEwTZPkfTH4NWhNal6eNCag3sE0VVvX2v8D81wBdiX6iJeM8dYHu0w0SqLVq+c4ME+aclIfmdSusy1xKTCjUCE41DORj2Iig7qY6wXGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccpyOUqXwzhN8nWhoV4dQoCUJHgnsAVUXx0SK9bjC94=;
 b=ZE5CLiFldJnRzwdseTvbGz4rjZKd9pK6ooXNkxtJ+Ev3Fhw6zG2mudVQVnXyMSBtAvrdm4/bI/smbHxjfRKQfiZBRcFThazv7EN4GJKZA8lhlghez2y8NjLuKVyZnRJMy5685VJY6FHAazAxiCCbmnLgAm2YpVjFjYT2NUHnRRxtyGAYZMQ4HNCPT+Z4mURCielYwK32olzNBwUCMsRADUJfc9hbE6JP81cJ4FzM2jKSBtOd1jucSe/22RX7xIyGqbhRMSQxowRDWwbNRiTzzF706XlH/EhDO8BYhv3q/EoPXTnyRMWSWPCuluF9Aq+YjdlvaV8AdisWggcru5DgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccpyOUqXwzhN8nWhoV4dQoCUJHgnsAVUXx0SK9bjC94=;
 b=EBHNc90RqKn/Pr7smedTe5vI9rKh6xZqjU7RQCfcE/LhWxilKverJMdnQ0eorcl5iNjett5UHEFoVzZL23KfANDXLUJ7CFfUbApAvFy+Z8y9JifYeUDgJfpT11KZbxCYxeOP7kdZOvICGTOkiHi0cynvu6ct3aFhIRMYT3Gy0P+gPLenUwYLmx/x/B8S5FRyhSYXLiz3d8CPQfp4s8q/6zVgUnICQ038kqDQdpk+ADCCFhRA0ydM80sYFu9005tShhx/VfgpLrFlGJtrtoHJ4scYHvyAJJTc+v6Ii5CN6Brpq98SUEltk8Om+AZE2tPBTz1+J6vFuiZ3oPLajk0BuQ==
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20; Fri, 10 Mar 2023 19:06:45 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::7a) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 19:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 19:06:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 11:06:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 11:06:37 -0800
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 11:06:37 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V3 0/6] Add Tegra234 HTE support
Date:   Fri, 10 Mar 2023 11:06:28 -0800
Message-ID: <20230310190634.5053-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 061deccf-126f-4190-fa68-08db219a9749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQiIqJ3QYDoXOEjjkZd/gbvHYvoz3EGiADuM52fEQZhv9spYQrlx7QERxksoFSg8IU2W+KQ7cg2vee4+rkEv+u2P3MjiD3/2bmSe6BYtvTdSq/uSZH0QrX0iX2557yY0u6LR/VHZ2Kb+4P8DBWSCIfxesyo2LuQ1MELP71HXOI9p5rdq6QRIQXTc2M9UtVgUspcsVIxcPsXmkIe/NC2um80MMeE+wozdaYNXYD6UTrBCD2DICklhy6xI/2BL7rozDMBjR0tu8NDeomqvv6G5DRkLdpCUpibIasCOOJi7P0NIUHyOhrHEW6Ld3b5xT6QkovBPjdVNfiKZ1KX8T3Q1jjHbOmTIJYNhqdxRqESSdKB4COL4lqpJn6WNcTuaop4qPfbfe4R26j42CZrog9p09qES1jpW3OTNfDfBJzVgV53riR+gIVRfeM/AN+qTkavyS5NkNT83PgFDXTzGIiXYrdSOWC9vswAE/dD2y0zJAkW2YPOZMS/eM4TY0un4etEPG9DTa4YxcQ7bibxMlEIiNVDNrwo2lXlnyPhJ6RKKXqzmkVG/KFqxF8uGnIwgt6JpjwAwIILTQecjU2JOGOhKp0PwDb0gq7BmAyGjsdwZZDjChNoUqX6+JiZUZUdcXj3t6K6SYYj1ZvhDY+62Rn+fye/uwTm6Ke/osYLvb1mk8trYniSL8QXDC6xaggDufWs4TKzt+TK/JbUkpDZkyVdM+ZDQAqJ/MV5qHhSxWdSXI70aotKyG3JL3u5a67OXW9waim+oV8xq8hrZFcsuAmWpUbEQSqfMYjfAzvMRqFQDtbE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(46966006)(36840700001)(7416002)(5660300002)(36756003)(83380400001)(426003)(82310400005)(47076005)(70206006)(8676002)(478600001)(7696005)(107886003)(6666004)(26005)(336012)(2616005)(1076003)(186003)(41300700001)(921005)(4326008)(70586007)(40480700001)(316002)(8936002)(356005)(86362001)(36860700001)(110136005)(82740400003)(7636003)(2906002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:06:44.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061deccf-126f-4190-fa68-08db219a9749
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series mainly adds support for the Tegra234 HTE provider. In
addition, it addresses dt binding comments which prompted code
changes in the existing HTE provider driver for the Tegra194 chips. The
comments raised concern how existing code retrieves gpio controller node
(the node is used to help namespace conversion between HTE and GPIOLIB).
To help simplify that process, new DT property is suggested which adds
gpio
controller node in the HTE provider binding as phandle property. To
conlude this patch series:
- adds Tegra234 HTE provider
- modifies existing Tegra194 and Tegra234 provider code to add address
provider dt binding changes.

The V1 patch series:
- Adds tegra Tegra234 HTE(timestamp) provider supports.
- Updates MAINTAINERS file for git tree, mail list fields.
- Updates devicetree and API documentations.
- Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
by default in arm64 defconfig and dts files.

The V2 patch series:
- Changes in dt bindings to remove slices property
- Adds nvidia,gpio-controller dt property
- Add GTE node for the Tegra234

The V3 patch series:
- Re-arranged patches to have dt bindings first before its usage
- Addressed review comments regarding dt bindings

Dipen Patel (6):
  MAINTAINERS: Add HTE/timestamp subsystem details
  dt-bindings: timestamp: Add Tegra234 support
  hte: Re-phrase tegra API document
  hte: Add Tegra234 provider
  gpio: tegra186: Add Tegra234 hte support
  arm64: tegra: Add GTE nodes

 .../timestamp/nvidia,tegra194-hte.yaml        |  31 ++--
 Documentation/driver-api/hte/tegra194-hte.rst |  33 ++--
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |   3 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  17 ++
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/hte/hte-tegra194-test.c               |   2 +-
 drivers/hte/hte-tegra194.c                    | 152 ++++++++++++++++--
 8 files changed, 196 insertions(+), 46 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.17.1

