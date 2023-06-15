Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF373164B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbjFOLRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjFOLRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:17:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343552686;
        Thu, 15 Jun 2023 04:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPK57dt6ct+NqaVBgay6vkkgOOlESHqEl3kLsZVlT+BBKekYVPlvweiRp/zKUctPX5vnsxEHv9uRDNwgi0P9X5skJQMhZuGILlq9b3CHvAHIHFEFHi1/pNUBs9mBj1mOt4evT3UawOuuWe98vJ5AUQbtBAG+M4E5hl7YIPGSBIYU5wbkf9QCEYWmcr8tb3HQRRnHKUa+jw0ytZUkTaCzAVbBU5VWHaEK4NvEafvtLiTilgXW5vGwEEnKu6lTykIKXaTu6VEx9aKIbQH+JxkOD4J73oEEPJ1UqY7p/zijUd295lmiFFZRRnc+pIi24KJbpkPdHCyvlbhoMK4rerL7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcSdOmTkdnvYDOtkDVxMUhRvgDk4Cq/d+9ibkppK9Qo=;
 b=h2L3vxKFhz9bllMZFjvwOF+Cl9WdCU3VV5PZwiNL9YEvVUf+XmAdqkcwakbXCfJF2wDx1JUZIqlK5pfGrALmlrF1BxpaTzbxhUa0vyWfT55Xui0ioOw0TRV7esLR2Uw274lg7q7n/TunlE37AL5MAognof8mttkI6jUeNbZgoD4WZjqm39z2qmkwCIdpNC+qXOJv2p3x0fUzzs7baA7PblJf5ZQKFcN4IPgP/qQxFAB19sxWVyxwqDj+s6v01Ke7aiXVoeHNo6M8Q4xwwCYtQaIKjGqycjDrY+dE0/xBU6V0hKUiwG9qM+9q05Tu81pV9EQ3WmDKYXjyyHLHohhASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcSdOmTkdnvYDOtkDVxMUhRvgDk4Cq/d+9ibkppK9Qo=;
 b=dtVhgAhNjcSWzMLBDNEmQaerkwEhAYZg3KIQhRbHdQAaUYT9a+ARvxzkeO74Z96aIzDdWtLaJi6x0avymmooTqQQYxydIf08EcEPF/xFeBSSaz+CbSMameN+DtaNAQPXQFRdrlnQmuunPn4x6/whUsmKG8JwsRKuaIuoWTftp3U=
Received: from DM5PR07CA0117.namprd07.prod.outlook.com (2603:10b6:4:ae::46) by
 SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 11:16:56 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::b2) by DM5PR07CA0117.outlook.office365.com
 (2603:10b6:4:ae::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 11:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 11:16:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 06:16:55 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Thu, 15 Jun 2023 06:16:51 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH 0/2] mtd: spi-nor: Avoid setting SRWD bit in SR
Date:   Thu, 15 Jun 2023 16:46:47 +0530
Message-ID: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: a37b04c4-82e7-4c8a-415a-08db6d9207b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n12KEWVstdZxcLZrJuTy1r9SoLFuCvswEGGSJJnrm5GD+ECFHF7oPauu1ZYY1HcdnNIWj1p0R0cC6of4QhNzOSDM0QokoiS/r0hY8TasAz6r22ziUCBojitTlJ07GcA1Syh9RDEq0BosL8hsbyeYhjO1mHgztONRc+McmkPl+66hNlafnCgfbw6KWnjgOXh8mElnGZAfM00toWjJRMEDaLmIZRUqmg4OL+JaCjieNaI4QZrqIrrFGxRGQYyXbnrr349KUF/lys+hivoCOq7GqcsQYe/aFTArYKTT5I/1uTuoRlwjK6mB+osOouSzpvc1pSJcaSyi1C7gc8C18GpGKd1iKtJmtBkuHsUbvv8HzJL6XjMxeMJjqNwhgAQM1begbL3OyRJAMBsxORr9EgNNCm3Er8EJFMep6+7sdjJ/thVMbLJ3FCSmf59vI3QysKCyv7Fff+fZileD8RDOu9zj/QuRiIPVU0yWr8wxXJcVUKZkQ31MqjMe01dAlXh3u776b/+db2JiEeTf7Q4D7jR/gVhyjfBNshJezFrsjmZxVgX0m62Am4hPoZXncV8/W8INvtJVh6g3i0PDT2oi8eA4xTSnpMKA4LMT+N1BTm08HUz4HVYKspOQFZ7ZftC4pArHDNTsoMXZas+3PS5dmgetWtiiPo7lzorf2OmO7iSTinNgnVKk5PT5wQWpSTh4GwEguHuSicELJnlWIAqLpsAx8hHEG/2MXsHs4ejZKE95dOL2TcHrK9W0SPABI946KAMXueiYqWWqwVMEGb5GATEZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(81166007)(40460700003)(40480700001)(478600001)(6666004)(110136005)(54906003)(7416002)(316002)(41300700001)(5660300002)(8936002)(8676002)(70586007)(2906002)(70206006)(4326008)(4744005)(47076005)(426003)(82310400005)(83380400001)(36860700001)(336012)(26005)(186003)(1076003)(2616005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 11:16:56.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37b04c4-82e7-4c8a-415a-08db6d9207b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the status register write disable (SRWD) bit in the status
register (SR) with WP signal of the flash not connected will configure the
SR permanently as read-only. To avoid this a boolean type DT property
"broken-wp" is introduced. If this property is defined, the spi-nor doesn't
set the SRWD bit in SR while performing flash protection operation.
---
BRANCH: for-next
---
Amit Kumar Mahapatra (2):
  dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting
    SRWD bit in status register
  mtd: spi-nor: Avoid setting SRWD bit in SR if WP signal not connected

 .../devicetree/bindings/mtd/jedec,spi-nor.yaml      | 13 +++++++++++++
 drivers/mtd/spi-nor/core.c                          |  3 +++
 drivers/mtd/spi-nor/core.h                          |  1 +
 drivers/mtd/spi-nor/swp.c                           |  5 +++--
 4 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.17.1

