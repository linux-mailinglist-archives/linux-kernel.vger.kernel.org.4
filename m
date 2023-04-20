Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05306E9B09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjDTRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDTRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:42:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2762108;
        Thu, 20 Apr 2023 10:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggl/AKrgdY5Q5lgFeHdGY1vWB+12eZe0teqjbtt2ALlB1GMdFetGyOEMfn2uCerbq+ywkzdFJ7bjUw8RTiwlReHQ7t7e9jrCn+euotdRVqUBJNk7DFMGTo2Ub0lj86KH+cUaH1dnsh/qWbdNJ7z6R6kHScrpBWE0P8ZJOPnbp5be5LEjofM/ZW6yrx0nCQFb+jCi9XS34td4YDN6ztukOuKSk5Jx7CIKxtbGQfirKrsHrb/1OfQTfMEzZgBchRT+Z+zfay3JTHkh0ib4PdzH0FO+jMVuXFbe+UAFHtNoSUtBvRPqJljAuOz71n1qbM3Apb6VRhBGoDgjuHezK/j+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnnrAGZogwoJoiQuAQAosRAP05xBVUfb1c7z93jX8mg=;
 b=EL1sxgThyvu3KiYJzWiPvmyb+dMf6zML9Sr7hJlwbvtx7dw3wAE0j5a53778mo6o5GeENHB/gtu0XKnAFdOYjtmq0eoa4pBqHdTXPDRVNIlrSHIxjb3uiDIAsmXkQZ85wA+bg6tcX9DBmvfv8NtAwkK9d04j6c9SW21giIYviUqRIIHWl9uRHFytt/85U7LxLp7nFC4TbAe1gJG5vYMGJ9G9R6diOrrphjfmqO5shxqDa1vCqdkOX5Iw4e91Vb203tDkU5RHnGRohlQqlWdKrzOE9Vi7ZmI5nwER+KjXUgvBi1cBpqAk2R0YbOgRXFFSEA3sDQx73wFyXLTBn6joBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnnrAGZogwoJoiQuAQAosRAP05xBVUfb1c7z93jX8mg=;
 b=NbgvtZp4aI1umsJbOWFXa4GnXNBJr5I8uobLpiu7WOPb9p1cFhLuSPA91ulzyeSuSdGxCYJjtGmZiqnJtTPODHtbuPqj7jklzg9ooiIULmke8O/tHLoBZz1PXHxtx1xxcLAOmqTvSjSJJSN2A57C7RkV/0RLUt5aWRr0qfRVZl8=
Received: from DS7PR06CA0026.namprd06.prod.outlook.com (2603:10b6:8:54::16) by
 BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 17:42:45 +0000
Received: from DS1PEPF0000E649.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::57) by DS7PR06CA0026.outlook.office365.com
 (2603:10b6:8:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 17:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E649.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.16 via Frontend Transport; Thu, 20 Apr 2023 17:42:45 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 12:42:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 10:42:45 -0700
Received: from ethanolx1adehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 12:42:44 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ray.huang@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Update copyright notice
Date:   Thu, 20 Apr 2023 17:42:44 +0000
Message-ID: <20230420174244.3100866-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E649:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c99ee7-d5f0-4288-6ca6-08db41c6a691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2OSt6XFJwVBzXFVPOuq2vVvkpB9gyEezE4LjA6ZGsoYPxYIVNL0PANfEtWaDSlrjij8YlqArzrrzFEeXCuoOP22vWm2eRLOiOQ74WeM4S2TIXBuFaopas3vdHEtw51r54EkSwucNc+q+6T+IPiOkljbAq9SpqmBZypSEemYeCTtMju0jdAYCjyzbw9GqeZ8LsuT8vvKYGYUnT2NDdJ37OXHZBDoOuvkXf05L3IrBytbYIdpdJt73aVO3wkYJUMDQFnYdhSm4Njswx7tp36aYQ0PEHmMVdPmpAOJX9c+FOkG5VecPo5cBR0fgE5/wUGTMrxJFWCV2ee90oDcRD+gPWfyENzxTRlCWLbbt1wJ0ncS3MuYQlvfXxuKR9TMMGAX8d/lAp1fGItXQkfXfjjSOB1eR/ly++8IqNRvRCdmiksPF2jiFQKY5iq7gBJNsXd/YufPLbA+eZnPpOS5OAlR5JWo/ZgjdlUolW4YEOA1r+lcG+hSyUKCLnkXXi56kYB3FZ1tH2EW+/8kIiPR8fJCKGf+ATLiuJIRVA3Juta2MiDkfy4SN4ET8ZzxtUTA+7IcfOqcJA6sM3GGwyrynfMe77VkkCZQvly1msCK9kkqObxtcw0koKra+Rkvpvu00q+9Gk9iudahP+diiTaqe7XuI2PL4dXKfM0vhvYA/RiH8G3oNZ7hk0MQRGLw33s1hH3TQ9iVKKp15Pmz1GrPa0XJl/7vnU/NisbjOq753Ey8kpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(15650500001)(2906002)(8936002)(40460700003)(4744005)(8676002)(44832011)(5660300002)(82310400005)(36756003)(86362001)(40480700001)(7696005)(26005)(1076003)(110136005)(478600001)(2616005)(36860700001)(83380400001)(47076005)(336012)(426003)(186003)(316002)(82740400003)(4326008)(450100002)(70206006)(70586007)(356005)(41300700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 17:42:45.6154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c99ee7-d5f0-4288-6ca6-08db41c6a691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E649.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most recent changes to amd_pstate, such as guided autonomous mode,
date to the year 2023. Update copyright statement accordingly.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 include/linux/amd-pstate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 1c4b8659f171..7bbb39c4752b 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -2,7 +2,7 @@
 /*
  * linux/include/linux/amd-pstate.h
  *
- * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc.
  *
  * Author: Meng Li <li.meng@amd.com>
  */
-- 
2.34.1

