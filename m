Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23F66C2997
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCUFGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCUFGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:06:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF02D48
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMEg1AJUofC+hftoYIMqjS2uB/KEg1oWLVTbEaMviAhFdSMYBA2NGFBpvN1ywHf100LOYTfXdEzAMjKl0uKOXLVRr0jx8n3MXbu8sd6LlybsN6x7kk3Px9GhIXu8KOSL2XEnfGns56Eg60MBlnsygu+NBT4falvpgsC5vd2vUmuK2M2PMCpRSPVdftc4PGc5nzDq2v0V5SnqJNaxf8+ayA4xsHngyEV3+Itu8p4FgUGIN8Ib5JUkDttJT4GUxO7uP4JsGy1w8W4k5JImT5alpoVJljua1BjkeqHHcmErJTbVf7ik//ROf3v15rmy3VeGG8mXE1JtS/2aM0hokgDA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgTe8QQ+Zh1KjsdbOVRXi6U/vuL/rwB99IRwTNI0mFU=;
 b=aD9Xd1hxYZU5xHHOc5Z6jQjnLwAKbt9BQtH324mGBHEAigInfWtNvEfBSS3f/UHs2+DOwyJ0d2rjgP2xZ84Mt+fNKeS+cE6rbu0PSNjWraJLVKxSVo0R8HJSrNwgNPOnOSnjwicKGTqwo2IQo2aDwsEECHSTzBcZfC4tEXQWIvQFhiA+rh16zlrNglI/ZBLdd6MaeZSEjGknTj2IPGPQdmBq1mizT1mUI3yngI9wypJE+j+FEKYX4azyEmjHip1VXmrNZdVbBcK4QW8+Egzll7RGmwZtM4zW9bKehRG826TjPBlxckmSECJ+tQYTAU8H7S2h8ddfoL8DNXlL5OjR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgTe8QQ+Zh1KjsdbOVRXi6U/vuL/rwB99IRwTNI0mFU=;
 b=fC+Km6GeKd6wYwl6A8Wmu/MWhr5d/j9TLTHusUNnOvi8ZwtnJSYxkHLwu0Aq5mu9Eh5eGVl3Hca4S7emRIlMs+2cZtrzLnREcMpzwftjNjkZ+ot/nL75E/y4nfY7hsf6xZncJKnoZsGtnZhg5zvNoyosdHEF7CWMdPD/f3WwzjU=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:05:44 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::3a) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:05:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:05:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 22:05:32 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 21 Mar 2023 00:05:28 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <vinod.koul@linaro.org>, <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <claudiu.beznea@microchip.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V8 4/8] soundwire: amd: enable build for AMD SoundWire manager driver
Date:   Tue, 21 Mar 2023 10:38:57 +0530
Message-ID: <20230321050901.115439-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
References: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 052efd6e-9349-4742-65db-08db29c9ec98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYo16ZCXj1hSFsPDFCQN5lCepNjjto/T1Lvm3GCxeldTynyAUh49WSZsd5IMZnDgsB5IucWE4b/GljNI0/kghDmwQLJy49O07BsJk8Jzdu6nn8QHFgqqN+RGnU1Lw/2k9kfjaUrzAFdlt4JHkREV5UGp6bubhtnfWtsJzUM+z7m5aw288AJpdQ5MJyIKAYTxfgMTP0lehtNt9FfwmMciwIG9mj4//eMcFOg5LYwiCAK4hH7DuLsBn48YXbncyJzPVnNySgY9or71rLLiRoQSeIZK+mA+PNjDLGgZSrk6U3mIEnifgO+hehKv8l1FG6tcZtbZr8+VgdX1An6X2MubxF0UzsrU0LbuSDqUuVTvaH3YA6NcpUcarPPXoKz1ZrE9dDJmPb6FGRY8sUJB/ExjfZOE1opAdEu+UgTAm5BZgmF5kj5KrYYKAGeKXbo9BR53sHlDWNg812evAE4dliZwDtuYfJOu597SjIgspkNVOsoT1r/yAzTtTjGOlAxotbn+kva/05cxqHWB6keJ4LTmZJIKhzD/nyus7UA8UG5tuEqP5IKGjkZ0UI74tDJNDxreIKAkr28tABBJBE9ODkLrBIIwZ5/jDZDIi446v/hRFuzD0v0FY4RR+ROqppGFFbr41fKwh5YfxCXmwlIebW4ColEBdCVOMQIXVr8USzr9zLD/6s95PnCzozKK2qS0kk5P59sSsO9Voq/2rWUalCs68O1/evaMtjGW3vqS/VmGP7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(426003)(47076005)(7696005)(86362001)(54906003)(70586007)(40480700001)(316002)(6916009)(70206006)(36860700001)(36756003)(4326008)(8676002)(5660300002)(41300700001)(8936002)(2906002)(478600001)(82740400003)(81166007)(82310400005)(40460700003)(83380400001)(356005)(6666004)(336012)(2616005)(186003)(26005)(1076003)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:05:43.7163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 052efd6e-9349-4742-65db-08db29c9ec98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 2b7795233282..fa71c9a36df7 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -18,6 +18,16 @@ if SOUNDWIRE
 
 comment "SoundWire Devices"
 
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
 config SOUNDWIRE_CADENCE
 	tristate
 
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index ca97414ada70..9ad6bf50f1b6 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -15,6 +15,10 @@ ifdef CONFIG_DEBUG_FS
 soundwire-bus-y += debugfs.o
 endif
 
+#AMD driver
+soundwire-amd-y :=	amd_manager.o
+obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
+
 #Cadence Objs
 soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
-- 
2.34.1

