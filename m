Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95810741F97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjF2FMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:12:53 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:59008
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231204AbjF2FMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:12:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0CGbmk5JRcQ7re/jWLqxWbTTg88yjoARe7JFWuIHW2R5vr000tIZHysbL71Ox96gbKX+cZf7EKnbglHN8kjD66YhN7YFovjsCb85HHpk/IhyeutsuBN+lGMx2N8mS71pIScmIYGebCFzGP+sL8qtLrVLEO+FJYjqnzFJeSwOZl77tGap90dUlf3v5Blxxn3aSv/0ONt/nuLVyvzZGIJsuC1j23mnrSBxhwnTOUP38KBwi/4zKNqQzTQXd+asPAt/cA/I0H5cAdkVk2tNbh91k8ieB3+Yye+mF5YC5hNXhcLx/yO5drEs0exMTKcH1prEKDX7zCfqIBD4hWzx6arcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAgdfubI6pwq0yqSukH//XbBNRMzoPCy8LJXH5OUHxc=;
 b=dpmEszFXBiM1K/vMVNhXLkOsTxs+5ke/BlhRe7+OVJVgvnj9KCrxSh5JFLiAZhfK3FIeC9RLoBPb1mjaYioK1gg0uAysbLeBcx8hpb5RSXvzAZMpDe6gKxfsp3crE8mspQfkSmAaisOl+vDElmRpdRodUv5Coz4xUvvW2m2R8IIS8eMzlXUmdy6LaSk9fzT/T9SUhnZ+xh6Ak5B7uLwqeJTtiglkB+pq0klYSGNcMkzOE/Z1NJugc0BgS0llVuBqOjxMUR/4zzo0l7DV6wRQ9FIDGsd39Jd+HBAUV/JVsgEdJ+uER9YUJHlIbsQDMFQ+U6OAAWB1HkfYQkRZDUTzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAgdfubI6pwq0yqSukH//XbBNRMzoPCy8LJXH5OUHxc=;
 b=HfX9g2X7fMwC1bALoHT7s+QwYirHD1yx01p4Rfx5AYavoHqOfBgm2Me1lskiY9F/OUVvnJSeqKNW7cCww9D10NNapf9biWntB80y5OphS9nfuSgeW2gVbRi+NOHZn5MN2NpiNUGbv6VAh9ZTgW/lJPRhbSOra+hHy3uEQPR8shFm/2fgYDrUEoPQJqQXAGIny4NtOVS9AkN2RyeyT6gkal63X8L2IzkIG9SABDF7gwa0DCxKwFAYrlFL0RviwZ6FdbQnFsS40jfxhY467egFMa8U6jRCXCaR//l0PBnRf0Jk3RBpNmeFfeOGjgoBgAF3jRlUYfmjcjqO80P8PYqiag==
Received: from BYAPR04CA0031.namprd04.prod.outlook.com (2603:10b6:a03:40::44)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 05:12:44 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::8d) by BYAPR04CA0031.outlook.office365.com
 (2603:10b6:a03:40::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Thu, 29 Jun 2023 05:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 05:12:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 22:12:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 28 Jun 2023 22:12:35 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 28 Jun 2023 22:12:32 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] Few audio fixes on Tegra platforms
Date:   Thu, 29 Jun 2023 10:42:12 +0530
Message-ID: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 7def737b-9da9-4088-0a85-08db785f77e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI7xlo+8Xdr2s1h4pxOJNx1Bq2qGpMaTj1oCcc9ymaOsrL0vNrzMQkf+Cf+7WAe36rRyfM2Of/CCGMELZOEglea6rvQsCeYZZa+V119N9VOgKFg1SFVlF+o3qcLwqGaANDmwOdp7ThgeAIf3fs73h7r7FaVJXJUDlQWtWaDHF2MIH/QlmRnvqYLlMSb2xmQxkiNWfur+zGW64GkSgBBuYP0KgH5V8C/mkpNsmaV6M0K/k2HnCICLQ8k78BoH5NWxNLn+1YlrLomgj59sJx0hC+9JKrcVifhuyEDg9o1OR1hJ0Zpnl15k0tCy74WbFRWTQ0IBkJ7LFyTrGb1cACMu0XvwdCtwc/EjcratZp0Uhm+RMgLwMAzTjZHUE6kKfgU2tbqRmSFXbAq0aB+OQoRNlO/cgDHE5o9XnkhGDiALmhTx6caWhxYYASEoZmFAVB67r7O2semTJPgJcp50DsMlOs4ITm/g3+ObkBvkH+UzZG0slAB+lisdcx/JVmw6s78ij32mUvJmjQ2OYMyHNRo/pWRS29G772mSqfBZEMO1a9+o6pKkqTSIEieis6Rz+vLRGIntChJyfkp0emwDn7+GO2xpPKbXAcAY1xU22bE0YU1psW4XK+917GENZYdTwsMGTN0hsrA7/zqzahEZ2VpwXCibVvLNZLd49dWcM7bnQypf966cPRt+LL4XU6GpAv9GM8Lk94cvUrG04inajXo9t/5r8KPx8Qg5g7+MtcD1/nY1rhxxnryYwZQAIh8Fqrfp
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(356005)(7636003)(82740400003)(36756003)(47076005)(83380400001)(36860700001)(86362001)(54906003)(8936002)(110136005)(7696005)(40460700003)(6666004)(41300700001)(70206006)(316002)(8676002)(70586007)(336012)(426003)(26005)(186003)(4326008)(82310400005)(40480700001)(2616005)(478600001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 05:12:43.0089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7def737b-9da9-4088-0a85-08db785f77e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some of the issues which were observed during an attempt to
enhance automated test coverage on Jetson AGX Orin. Below is a short summary
of the issues and fixes:

  * Sample rate coversion failures above 48kHz.
  * AMX and ADX test cases failures due to incorrect byte mask.
  * Atomic sleep in RT5640 codec which is present on Jetson AGX Orin.
  * AHUB clock fixes on Tegra234 and previous chips.
  * Minor cleanups in ASRC and AHUB driver.


Changelog
=========

  v1 -> v2:
  ---------
    * Few patches got accepted in the original (v1) series. Now v2
      addresses comments for remaining patches.
    * AMX/ADX byte map fix patch is updated with more details
      in the commit message and added TODO item in the driver
      to improve the logic.
    * For RT5640 codec patch, the threaded IRQ is used for
      only for rt5640_irq() and rt5640_jd_gpio_irq() is left
      untouched.

Sameer Pujar (2):
  ASoC: rt5640: Fix sleep in atomic context
  arm64: tegra: Update AHUB clock parent and rate

Sheetal (3):
  ASoC: tegra: Fix AMX byte map
  ASoC: tegra: Fix ADX byte map
  arm64: tegra: Update AHUB clock parent and rate on Tegra234

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  3 ++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  3 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  3 ++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi |  3 ++-
 sound/soc/codecs/rt5640.c                | 12 ++++++----
 sound/soc/tegra/tegra210_adx.c           | 34 +++++++++++++++++----------
 sound/soc/tegra/tegra210_amx.c           | 40 ++++++++++++++++++--------------
 7 files changed, 59 insertions(+), 39 deletions(-)

-- 
2.7.4

