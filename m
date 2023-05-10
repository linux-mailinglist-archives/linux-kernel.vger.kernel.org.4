Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7156FDCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjEJLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbjEJLep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:34:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5989E26AC;
        Wed, 10 May 2023 04:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME1DCfqlj33h1hhVNfS3vHUbEqTkbsmStaCUlWFlRR6T8MKjGqgSOvdKZOgCAyjmtMoiE4IKLhlepVagKt+ujDc1j/20t/hIdV/GlEZUJBUT/fXwq/UcLxYmoVfsJJoWnLCMwrSylGwviQWQG4hcsMSFHvZhe8I+HE9lIiF7wPHbbfgkSUBeUy9rHeROpbsraDBXV6MWO4wGoW350b3HLXbXDzu9Rl+FYiLNzNvo0uc+zkyX57SAAbGtdSKB3yXRIpB3/Svc2PcFM7EifXeOOUPKYXK1E8HaG+liRLYLohg1FRvAZWEeIhaEpDpmVA7A/lf/crUaMbS2PRQxbS/kVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQiD0eprwdqkzZWduZc/azuCFkABMaziA/5+KrAUH70=;
 b=eDlRjiFX3XMiDZqRi66bnsNL/FAxztfg/b1Ip6apDygul3HjDrqH8U6nJS66kxMcIYgx7i+yFGgJ2wKKNY2KxiYOwymDNxVQpX5FabKcHrNEtUcveLE0CYjvuqIKjI9Z2DGA2A+li6rZC0BkvshjkuGaA3Z3L9tJHpxYl9XjDRN9YJrY8yvUPfhjYLYr7RBEKQ/DMbZCilVKKx87OglCvQcwyNqDPEPl4c3ah1H2nQSYWcuzNfuUPXSSpj1j39eck5hilO6MpU7UmPkqg5+q/yzDqx0t2x2F2bb5n+OZUYQuXPzQQtYUPIYWC/yHQH4J7VyGV7GyGg2Hlp4Y7xwnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQiD0eprwdqkzZWduZc/azuCFkABMaziA/5+KrAUH70=;
 b=PwkuKCs5H2N00LciC0yIFDMljricmmQd4a2Idp1qzeh8HdVtavL3oyq2rMRJU4kV+nM/tPqh/Jl3bd6A+H20KhSzRKC5oTMCOxG/B+erRMcenu6KitROKFWQVvXDx8t7ngvab0eUA8yR+/SPCmQ/lPQEB7z/uH+uwXDAvrNgqt47IlUY1cgELROO2vZjmNxeFEMTqnePrTUw7AoRH2FLy3HODqDHDLrr2UlKDzCgbXe0XBJ6drOjTricc8onfUMYlBLgn0xUido2gZiM8Gi48OGTgMIg0F9jXqnPzuHuLxshregAdyHDf2SZWQ/uAO/yD/sqtE4e3tD6Nz0GR8ZtRQ==
Received: from MW4PR04CA0308.namprd04.prod.outlook.com (2603:10b6:303:82::13)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 11:34:41 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::9f) by MW4PR04CA0308.outlook.office365.com
 (2603:10b6:303:82::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.19 via Frontend Transport; Wed, 10 May 2023 11:34:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:34:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:34:24 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:34:22 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 0/6] firmware: tegra: Add MRQ support for Tegra264.
Date:   Wed, 10 May 2023 14:31:24 +0300
Message-ID: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 963f90c6-6d15-4fc9-0e65-08db514a8adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpXA0MIglBw7wuN7TTYY9Gz0eYsN2w4+O2RHMea8mrSq9NaNnfapOEkkqH55GmbU2QQwNeTDmXzGyBcn/0ByeRvR1X0UlZfAOXicUrkgYpkXUCraG3jylMHJRd4opbsFc3RXwq0hYO6r99u1SV5ezkcQj3K2Hu/lQGcA/WmOzVqHAIZZexf+7U5meebZyFe08iTtbPntfxnRStYrcoDBr4+LwQQh38D4R9a+UGKxFbu5E/9BCiRzHSX3WBj0GoKoR167shLdAIk6zqfmgA5fe1tELmM+UOd+5vjezKodTVmNJD2CJXL9EYD6DmoOreKMviycYWjySNRyBSmictm3W7NmmseKXGF2ONz4XXy3AbajZtQ4Z8Ayvw4vY1nG1aMESjnlskVPrixpngHIG57RBkbzVka4GGIL3riE3LoLmOo/AKVsTd1gwP/zUHDFwL0EACc3n/L+jJEmHzbJxpS/4tdvjzybPCCvbkce70cv71erOW3B8K1ChcB2GkpzfG7l21WEilDIskSW4qRUkhrjzp31ad4tT0qX/xU3wEe62kBmATGA01gQUwLpqIyKZs848XRsjuKkDRE58xxt1mpIr3ujvrZSr8w80X2llj+6E73YK/+QY2dmAKDPZI1i9eQmTrHgz2wed0CXBOBZPAACRn7lbRmlFA4QfDyAXqe8iV0TAesXzYGre/zB52AzQNv2tS45aIHr+PU1Bu9dIhyezkjHNQV6CaVvSU1vxKA2rmYvverVZ3Rw0zJC/eZCLbB6
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(8936002)(8676002)(1076003)(26005)(82310400005)(40460700003)(478600001)(186003)(40480700001)(5660300002)(36756003)(2906002)(7636003)(316002)(110136005)(54906003)(4326008)(82740400003)(83380400001)(6636002)(70206006)(70586007)(356005)(86362001)(7696005)(426003)(336012)(36860700001)(41300700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:34:40.1226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963f90c6-6d15-4fc9-0e65-08db514a8adc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Tegra264 the carveouts (GSCs) used to communicate between BPMP and
CPU-NS may reside in DRAM. The location will be signalled using reserved
memory node in DT. Additionally some minor updates to the HSP driver are
done to support the new chip.

Peter De Schrijver (4):
  dt-bindings: mailbox: tegra: Document Tegra264 HSP
  dt-bindings: Add bindings to support DRAM MRQ GSCs
  dt-bindings: memory-region property for tegra186-bpmp
  firmware: tegra: bpmp: Add support for DRAM MRQ GSCs

Stefan Kristiansson (2):
  mailbox: tegra: add support for Tegra264
  soc: tegra: fuse: add support for Tegra264

 .../firmware/nvidia,tegra186-bpmp.yaml        |  37 ++-
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   1 +
 .../nvidia,tegra264-bpmp-shmem.yaml           |  45 ++++
 drivers/firmware/tegra/bpmp-tegra186.c        | 214 ++++++++++++------
 drivers/firmware/tegra/bpmp.c                 |   4 +-
 drivers/mailbox/tegra-hsp.c                   |  16 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   3 +-
 include/soc/tegra/fuse.h                      |   3 +-
 8 files changed, 251 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml

-- 
2.34.1

