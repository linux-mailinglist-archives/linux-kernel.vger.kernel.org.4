Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0A6A464E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjB0Po3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjB0PoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:44:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334DEB48
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:44:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoKQLOGPk8AxHsHy0i6lAhubP9ZLCWOOdGRNbRfGdCytvHBsdzVHKi1HZ8CERMHU6DPx6RLmXL9fB7Uz8peK9PX24VyfjDxQv0lerFzKxSKehuDcS3F4iGBznfsjhm06jY+RtlnJJEy2/33kyO5gTSyDaCJTcWF8b/BKMi/o66Dl+jCBkFQYZPps3qGIeBo7jNoDmG2F58tvkY2+yX+XHD+n9rIlOIN7FoTDYTKdvFuDKWU30nAAxhmk5Ve8pJI8N+wglg+OZzsD6OmuRk6+itssL8rySndxbQIgFm6X5ROhzoJAX/NwlaJtxBf3RoH8czlucdAk+crg+Acl5pGFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=Oe/S8cacYLo/BNkEVfY4EBfjDVAx6aVTVb2f93udZTktunwH1PzzdLsxw7g0HxUEGFot8o43vssmWRhICBRCE3sZKsojj2vnWGrr/NHzhxu4DBlwt8b7qpqqU4DCXTQOARBICNpOhUltAKdEEvlPy5Ub62Tn8E8iJt+/WhCuD1ZTHIdBJe8cSWGok7QLU7NbdK/v/NKjVGIamHNCfdz3oBTHky+rabBivRyr4YFxOzN6sM4olj1AcAhTW6pW0kk5IuXU59jGaRE4rbek6d0GYJNwFTvc2OjBY9yPAXQiDcksC3GRk0NRRhtXRssdb/NznMeaLFN4VnfY3UzdQyyq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=wgtMol00dP1cE+HXemHsAB/lxzbHotIvqcN+S3IaLirB8PgsbyJ7kJY9VVksc1181MOAIo1D60JYlonzIgCP9lA2/lzzKgcsEt2MZdvjEEm08J2yvZeFqInbCUr0HxZZ4bo51hLc1FCql8KVKkhQoJEk5Dy0iEFLj8elU+8oYMA=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 15:44:17 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::28) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 15:44:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:44:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 07:44:16 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Feb 2023 09:44:12 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 4/8] soundwire: amd: enable build for AMD SoundWire manager driver
Date:   Mon, 27 Feb 2023 21:17:57 +0530
Message-ID: <20230227154801.50319-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 071e256a-bcdb-40b6-12b2-08db18d97bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeVOtGdK9n+TKncLPO4HimEg+r7DgEyG5RbKhPJpGz0bDY9phI8zg3drfObQj4hPQ7exkewKjMGXqLGGf0zH6Z2Ijp0ovybv/qmw4m+2Lfua5DCGvZt144EKUyznLlv55cR/zBAQjtHWtNO/tkkcwTRVzIV9LuWHI9EZRMFbtIJ48Xk076sDmlxobhas/FmoZcW1W1CMne4nNV1e2L1hy68MYrlX3v0MiFDOvApnWbjJgdiHQ5d6GgWkVar5s7SOs2LPKzbnHbz7vq5GAFA2hyj1dbIb6nLnGPdxTCD98CBKqTSAbI6xkc2FoGc+uGYP7Thug+fDqKmieo/T3EnQiC85SB6jC/1UYRkFkIclkl3Q7mTvqpxT0NSvS+4Bs6IFZdX9KDX4un5fRL7nYwqJZOPRpozuGG4zyFEF+CtT5CLLhiUYJhLhxXS5gltMc2IbBZ6vQMBunUnzLReW3jQJ9gn9EZXA1fLYcbTB2dzFOZCaU/UOxqmlduUq/pjhoTKvLWXfB/DKwpGxCAqnQzYJ3Bpps5ZLL1+XReKnYiASsoDwOvw7SuF0ZJIgRMxTUCyDJF60l0eFdeW9oeT/KzOSC+o2ons+widCED8Tk8O6iv6n6EYPMoYAK2cIQnXWsBjIwPjvxQsqEQFKC6VvhSBKU1waNP5rVcUWE3hyK5NR+CQhEL/gbOiCIl5PX5xkRqNMMKmqD5HvGDc3xyxxfyzEiku45AhYeVQG2wf8Ge/h8PM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(83380400001)(47076005)(336012)(426003)(54906003)(316002)(36756003)(4326008)(82740400003)(6916009)(81166007)(40480700001)(36860700001)(8676002)(1076003)(40460700003)(2616005)(26005)(186003)(7696005)(6666004)(966005)(5660300002)(70206006)(70586007)(478600001)(2906002)(8936002)(86362001)(41300700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:44:16.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071e256a-bcdb-40b6-12b2-08db18d97bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable build for SoundWire manager driver for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230220100418.76754-5-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/Kconfig  | 10 ++++++++++
 drivers/soundwire/Makefile |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 2b7795233282..983afe3570b2 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -46,4 +46,14 @@ config SOUNDWIRE_QCOM
 config SOUNDWIRE_GENERIC_ALLOCATION
 	tristate
 
+config SOUNDWIRE_AMD
+	tristate "AMD SoundWire Manager driver"
+	select SOUNDWIRE_GENERIC_ALLOCATION
+	depends on ACPI && SND_SOC
+	help
+	  SoundWire AMD Manager driver.
+	  If you have an AMD platform which has a SoundWire Manager then
+	  enable this config option to get the SoundWire support for that
+	  device.
+
 endif
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index ca97414ada70..5956229d3eb3 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -26,3 +26,7 @@ obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 #Qualcomm driver
 soundwire-qcom-y :=	qcom.o
 obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
+
+#AMD driver
+soundwire-amd-y :=	amd_manager.o
+obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
-- 
2.34.1

