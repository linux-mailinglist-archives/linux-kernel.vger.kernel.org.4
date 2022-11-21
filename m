Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA6632BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiKUSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKUSQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:16:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AEC4B43;
        Mon, 21 Nov 2022 10:16:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah5pdc4CBNgbW6hJEnLj03KC1YlL4bBwuDUYGWWjDBzjl16l7F9lPOA46gf23Qwgj/9k72b4rqinBfQwfqmlXzH1Qq3Os91togt83xa7bzIBlPB2RJS1nz33KlnTzG7+lb//slhZugGu3ErV0EDhcPMM6W4I/GD6CHKK44v/CgoFh//d+aYyVTUxisd8trldfijWuJuKkmzL07bLeJCOxY204L2jzSBKH34s2MmV8an2nn67l0SBbD1HA42SGnaoTrlk+1lYGN1mYLdxR/l61mZB+algIz1P1pS3dRbDrXFjXslRz0S9Tsr2M1LIjNrBQnb996dOxz5oXe49ElQoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFf4I11PwZ+/tMHVntUFbttF5TXclZIc/h+u0AFrXEA=;
 b=XiWdlgcpeXZkZj13VwkqsxXKhROm7K7oXbVwU4Qs9iOkj7jInXKxpApv4YTT/usBIh7krOwvgTKTe+KrOH/o8rb3G3T4cpe70y6kk9nYeWCVO4WTCrcRMHpOQN2BYZT1BHio8Oeisz4zifVgXh09QCefcdVDDvR89clFehPdoXCJve+ByZ9+cmDxXaUjCkaynhpem+xkZLTgjF+DMCt3JgLtFR2oUHKvIeh9qZxlMVYdv5vLqGUywqH+zMXr/nWPXZCpwgR9t8hVjZI8ZU1vWyymlaLi7lcEUAh3GHmTcRJfDgaoQU38IYeCYI1kxktDK+W5NYC1WXbp6GCZ/uk1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFf4I11PwZ+/tMHVntUFbttF5TXclZIc/h+u0AFrXEA=;
 b=NWDXy+4KYWdXvK8wbXZFskLZawA4TXkhXzmIBCEm2cr4rEP6xDUeS6VkriehZk8u+OuXFDM+3MP46lWXqAGxPTC1cU8F0rKKpr9Y/OxWC3w+VHN2UuiNdkGcdZmD6Vg601HgZZxq/BjDh+w1+a7Gsg5k1EQvSlswfFUSjHv+JCQ=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 18:16:36 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::96) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Mon, 21 Nov 2022 18:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 18:16:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 12:16:33 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 10:16:33 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 12:16:32 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, <jm@goyeneche.es>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 1/2] docs: Update maintainer of kernel-docs.rst
Date:   Mon, 21 Nov 2022 12:16:25 -0600
Message-ID: <20221121181626.149558-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121181626.149558-1-carlos.bilbao@amd.com>
References: <20221121181626.149558-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 90325e0b-62b5-44f4-e6a5-08dacbec869f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZucLuLEh5RZUHMBDOd2WC7NEZs6hkoqMX45LZWgHc0aMNfrnQFmRnOq+A/TgW7ZgM+zTRKv+cvKFGsAr0dP5Jxq6+VEoKfblN1mG2HQjEwtmjnFoFVLCS5/Ghq/a7iP9cRLzZ1Hu70QzoBwDL2R/XmCcufY9V0kjA/sIHKHdkwqoxYX63fcGv7uk92AuVuTBrWqW6WmKHliLxtgpwcKEe+DWBrpGWLvWO1HRjq6YL9Pifw7MWuMLLHiDXPbtwemoxT3eNLmAvltVSZUU6Hy3OZOEMTYL5+CmXwd9UPJWgaRms27F0LDe45+ghqsiQV1HXyM7DWckFtBn51BHTe/1v4Ozo9PCprJzRFXlqSnZpJnCjdzVQ47d5UZcMeo7v8oAlzH2mAh5ih8FqnZtbOA6MJ41/Fb8dLF6Y3siHmm2dTJNepnWeJK0MhxgTOa2zl6q9mKr2KHL+ArF5/WzT8Dog+RYkBwPMJtuLzdLj4faIPSCSgK92kMEovajtc4WU3XPhliSFOpLnITKrGIo36mhMakGc8cZ6Mdp+8/GoouGLuEtEh+DaFe56VX7ByMOGJtu2Relu/wiicBUSwRS6SO/9j+XU3CylUuADliXAGy+u9vDtizmTTCkI6XBISEyccCCftI96kDRp8IDgNyxI3S2f1/j6rYwgtF+GXgvqfygWMLMhaRPO8c16W4XVLNpXKJL9Sv5T1L06j/u2NWqTtn5xzl3lwJOhzvpNu5lQbtIh3mmxeMybqPRq5VLDJegrABbouRFjXAFZUOBEGhrChC3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(186003)(336012)(2616005)(426003)(1076003)(356005)(40480700001)(81166007)(15650500001)(36860700001)(5660300002)(41300700001)(40460700003)(8676002)(70586007)(4326008)(86362001)(8936002)(70206006)(44832011)(36756003)(478600001)(47076005)(82740400003)(2906002)(6666004)(83380400001)(82310400005)(110136005)(316002)(7696005)(54906003)(966005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 18:16:35.6911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90325e0b-62b5-44f4-e6a5-08dacbec869f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set new maintainer of the Index of Further Kernel Documentation (document
process/kernel_docs.rst). See Link for further context. Also remove line
that keeps record of last update of the text -this information is already
available elsewhere.

Link: https://lore.kernel.org/lkml/20221118170942.2588412-1-carlos.bilbao@amd.com/
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 8 +++-----
 MAINTAINERS                           | 5 +++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 306ad373a002..8574b577d50a 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -3,9 +3,6 @@
 Index of Further Kernel Documentation
 =====================================
 
-Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
-email address is defunct now.)
-
 The need for a document like this one became apparent in the
 linux-kernel mailing list as the same questions, asking for pointers
 to information, appeared again and again.
@@ -614,7 +611,8 @@ Miscellaneous
 
 -------
 
-Document last updated on Tue 2016-Sep-20
+This document was originally based on:
 
-This document is based on:
  https://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
+
+and written by Juan-Mariano de Goyenche
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f2ec7c71a4c..91b668dc1217 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10017,6 +10017,11 @@ F:	Documentation/hwmon/ina2xx.rst
 F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h
 
+INDEX OF FURTHER KERNEL DOCUMENTATION
+M:      Carlos Bilbao <carlos.bilbao@amd.com>
+S:      Maintained
+F:      Documentation/process/kernel-docs.rst
+
 INDUSTRY PACK SUBSYSTEM (IPACK)
 M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
-- 
2.34.1

