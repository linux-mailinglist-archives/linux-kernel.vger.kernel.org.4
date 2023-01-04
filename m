Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4B65CBE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjADCh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjADChy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:37:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A99E3E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqEFQSHXlj32zlGOItx1Ikaq8IwhykNC2hSZhob8GV7szHvqcZIE05vuwv66N5sL2C0cJ+kuy2gr2su5/av03qFt2KiVIjw81tJM3ejhP5NIk28usbsmL8+u7sxITbUQ8y6SEQ1hf3DwAnENn2PljODHSNW7QfuJqaKrRSLorwO/kgs4IjXn2ng30Tv6sI8uLXV6sudpb86VYBWcmHhEos8tMrINY2ak704bu4R3QDBruP77maddT6LbEz4Shgx5KwB3SmQc/b2XObUW5k/ciaSSBKxEAOhXXQw9vEIPFE5OGzKGz2AeMtSCB1GdnLdHbURUAjIUABO+Fous0+NnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wJURQphI4S2v9tbwmjJrLYq43L4evErXJ7tv9XF7xw=;
 b=c2T67JRF3bl3g+cZ/gztEfvBLX/5SDgPCo8/K+tyyG1TiMdJygt74iwPP2tuuWSYGrO3bGEkCbMGV+0iZosRIkFlTD1m91dKO8oImcDePqPiAh9HuhbA8fhjv1gSygmJLJSwgm/adcCR6+hFT99Fjl7ML4IrCqLUyDEULy9b82Jx0vSrihfo3ReRSnfSIgDBvlhvBXTVHVh+fs8oV8/g6pXz14Hj4kbkR2jh6WD2cm2A4EpWt8cGunT+DK0uBJy/LDHUrXjknIUy4U8x/J6HmyYE+RoEhEG4H/D3y+FumIGaZDmfRItBTToIqaY6amgk+n4OFydSaQfAh6+e41RT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wJURQphI4S2v9tbwmjJrLYq43L4evErXJ7tv9XF7xw=;
 b=dYEMgLQIS4Br/3yMW8g8jvGye3YboIol4qjF6govIOfSeBm8xV5FsBecMMTbHVFSqdvnT8NFPBketwX4T2CEZbwSczNn0C6gi703IsLoqZLa6ajYOyjvIWnLkqBjfP98yWRUXRHQeFKaLa7nAwkgnsLbdeAU231sfYqJBxHScvzZwLaI2gwAc94mKpnkySC1FHUXeVvnEh9kqxX34QnlUSBLzoNd9rZv2zkGhXBu9wVCxBwCHco5AJhS2Qmq+264tl7cH6gE5+4Fij5RzN6KyfITsI/kMC0gbj5TZOcFt9J7ZJMltfSDciWKSgVEsjRGp7lzlqM24v5kUdnpDEiaCg==
Received: from BN9PR03CA0248.namprd03.prod.outlook.com (2603:10b6:408:ff::13)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 02:37:50 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::af) by BN9PR03CA0248.outlook.office365.com
 (2603:10b6:408:ff::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 02:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Wed, 4 Jan 2023 02:37:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 18:37:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 18:37:40 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 3 Jan 2023 18:37:40 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v2] arm64: gic: increase the number of IRQ descriptors
Date:   Tue, 3 Jan 2023 20:37:38 -0600
Message-ID: <20230104023738.1258925-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 54310cab-9288-4618-dcac-08daedfcabd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgSTx/XD2SVe/hXXeenEA8XIsElSHzGk+0bgRUoUmwbXOcMO+gHkn0J6xLdO/qXSeB7CcNBwew5BoHyAsJcJ1/mmY11drHNcm4nd87SGlRUPU0xMp2SP9AHiadl/n03wRgBc86RtSX7zRAhN3J4ioRY2azEeH1XgugC3O8TA7DVFMAHq92B17iv4lZBa/VIKIuLmwCqYsmuRToD2UD+dUVJ+Whd+BBtWEKXyOx3MGUjEqRS74244hM+5BIxRi9RhNz+zHwC/gSTp5LljLQHAxWD5Mxirz6xKutkvFP6iofJehj1VKwEMz+Zg4i8KcWYJoP7/MVPzIIYPYHTZng2YKDTraCvNHwMxhlMh1UYrp58KLOM7rllNPQgEi3SAlvRM3ZSn5ok21YSlLtDgroumFHFs2Bh7VaW44uJ5dDKdWus8cMpgraDoQmDPZ49szNnWsLcFUQNdrZx9wamEtl53ZcC6zs/G1Tpd7zpdoNWHZlFjb+NPx+c05YQuGJ5Q4q6gqh6C31W8WUoNumfiOx2855g/GZNy8pphVdUHREaHmaWVwspet1k8ARk2B5YgNC6XSWaeEuu4lH8Lyqxz6GKjncMahM07hPk/KKkmpEebR5E87+2kc3UDf6GL2QBkFwItkr4Xx6Zl6CgegTYhUQswcfUDkFQnCVwoc3V8wrZJa8Xasw63AsimI63bD32+ahG5H1DsPD3fvz0JjOte9s1k0A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(86362001)(82740400003)(4326008)(36860700001)(110136005)(54906003)(41300700001)(70586007)(8676002)(70206006)(356005)(7636003)(26005)(186003)(107886003)(478600001)(7696005)(5660300002)(8936002)(2906002)(426003)(40480700001)(316002)(2616005)(40460700003)(82310400005)(1076003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 02:37:49.4907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54310cab-9288-4618-dcac-08daedfcabd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value of NR_IRQS is not sufficient to support GICv4.1
features and ~56K LPIs. This parameter would be too small for certain
server platforms where it has many IO devices and is capable of
direct injection of vSGI and vLPI features.

Currently, maximum of 64 + 8192 (IRQ_BITMAP_BITS) IRQ descriptors
are allowed. The vCPU creation fails after reaching count ~400 with
kvm-arm.vgic_v4_enable=1.

This patch increases NR_IRQS to 1^19 to cover 56K LPIs and 262144
vSGIs (16K vPEs x 16).

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v1:
 -create from v6.2-rc1 and edit commit text

 arch/arm64/include/asm/irq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..3fffc0b8b704 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -4,6 +4,10 @@
 
 #ifndef __ASSEMBLER__
 
+#if defined(CONFIG_ARM_GIC_V3_ITS)
+#define  NR_IRQS  (1 << 19)
+#endif
+
 #include <asm-generic/irq.h>
 
 struct pt_regs;
-- 
2.25.1

