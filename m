Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213062FB39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiKRRJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiKRRJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:09:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25AB8C7A3;
        Fri, 18 Nov 2022 09:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYMTvz+sGiQvMi4TnBcyMouwGsYsbAy+amNVpahdKSwrLFUAyMcJ7zzPFHIxJXxfYqjqXlZxjTDJdWGn3hwzJVEofD6bY4++TEIj61CddN3I3tXVDMuG8gx1VMC3M3uIbqkOtUksi62IroBSueJRq2VPEIVoVQ8Uq39oaMYXsDPYAzcPJsZb2TBZySAnkqcHluop23WBx/dHEou7042hsgjki1UPXr7fjbU9bs0E2IR95TAWZKibxh1QipCZBklxpuuaUETw1EiskOp4nwJ6NSoci1HcIRFNF9pjy0OkYA/iwxNPr2w4+Tkssp/9IwjPe4na0fF514MIGe9wxPgQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl1UoATgwF1IFnrp+n1iTJ1Errjm4cUStff74u+Lz04=;
 b=X0hK5KmeTPjFf3B3NfNhSZu6XZKzI1X+hhz/FnIMfFMt8ZDO48Mpv8LQeJwfD5xTot4sPoYZO81FKYQ4rEgfxUtmmYkU/Cjp9yiEwlqjSKyYUppojjwaH4fOGnfzmQN3ndhFBuT10d98hNsNP3MGBYHqfnR46kcRm4GMlt09pZrIVQe9ElIYdVN0nHUSvAFjIJ93SaG+xUVws3ILP4rIYPloHN5FtxYF2BSJN6S5ygAbGv5OkHBF69iKyuLOUydIviO/n7QOfHsPaEPLYw5zxQQHm5uHd+WCffLUQAqddREeZQj3wBKP4CjW+UjMF2uBHxqGL62YbwpVOmmduQTQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl1UoATgwF1IFnrp+n1iTJ1Errjm4cUStff74u+Lz04=;
 b=YeTn5BZkBsxyxDtsUmueUkckxb/JPDHvRJzFkA5fDni1oNey9kh9olpLxtp5kbQGmTTAJpl10sfVASvx2s+yL8cSBW5Hsk4Lz7jslNXPuWZS/vVEff06VJ/ztRjOX5DxVkgYjXhLOmRMLCPhHmmfaOVK9A6987FyVp2ZdQTEuLQ=
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:09:45 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::31) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:09:45 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:09:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 09:09:44 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 18 Nov 2022 11:09:43 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>
CC:     <Dhaval.Giani@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bilbao@vt.edu>, <ojeda@kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH 1/2] docs: Update maintainer of kernel-docs.rst
Date:   Fri, 18 Nov 2022 11:09:41 -0600
Message-ID: <20221118170942.2588412-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118170942.2588412-1-carlos.bilbao@amd.com>
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6d901b-9edf-4080-2f57-08dac987b0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2aOV6NkxjrIlrZqaIFv87+aMgrb+cs1piJigu8MCNLgbniS6nORRMmzjt2R3kx6lARMvyDUkgVLIC5ZLC1VL/dwpw+SDD78EsXBq6xSgs29bFixK+maxmq4GIqP9pUSBKeUKz/7LlyFTeFcGMmz3nDEACfuutqEbiwrFnkN1lQVgcU9cN1u+KGm5NPIjEZfMtUNAD38q7kbC36DTEMVWCISklv6TTkWhKF3E4Mu9DAmq9KC5fBGSiP+HycY4Rj/K3TXfLIAGWbFkO/d89A0LYKZV26RdZclaiAvY9G1iPEfZu+SN/1LaWn6uhOZwBV/CQ9UeUE+wsfhcQf7HSRZPnQfbyvXxy7wkIlV9XNMcxww2rBNGhzVEpg06+ViQxwyy/pPpS4c/fSiklYo5TreT6mPeAaSzV2i7pEZivw1PON9qrISbex/6GB74cjSzI3o8t7r2YcRInla12aGviQsEzSxLwctdUEY1ODi3liUlByK7feQWRAl4gOLYAG38C5gOmV5Us4jXBwvoyM3PZDaBIOk94sxhvUGUwDSLzsvOsw37MEXRaBHoIXgzOYkNLLP+n57RGW/nz38uIv5hrnhK9B99BNT00xwd7cUcVEVY1oR4GeuZTI29TBZYcO2f3EMEYiI3f8orCrfeEO7/dPTttEgI0tVvxXNRbZGYmi2i+mItrRH7ETvgjeuDm3o7RU1c5LT7ntqRD3wBtqR4j26EoEYuvQLDQG1GD96BniwXtpDYLWbYGZm8av5bIW+LjES3jMyAqOIdJG+VB0nLOpLsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(86362001)(966005)(478600001)(82740400003)(44832011)(82310400005)(40460700003)(7696005)(83380400001)(316002)(186003)(2616005)(36756003)(8936002)(2906002)(26005)(36860700001)(110136005)(54906003)(41300700001)(81166007)(15650500001)(426003)(47076005)(40480700001)(356005)(1076003)(336012)(70586007)(8676002)(70206006)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:09:45.0669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6d901b-9edf-4080-2f57-08dac987b0d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add name and email for new maintainer of the Index of Further Kernel
Documentation (document process/kernel_docs.rst). Also remove line that
keeps record of last update of the text -this information is already
available elsewhere.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 306ad373a002..e1fb1139548b 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -3,6 +3,8 @@
 Index of Further Kernel Documentation
 =====================================
 
+Current Maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+
 Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
 email address is defunct now.)
 
@@ -614,7 +616,5 @@ Miscellaneous
 
 -------
 
-Document last updated on Tue 2016-Sep-20
-
 This document is based on:
  https://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
-- 
2.34.1

