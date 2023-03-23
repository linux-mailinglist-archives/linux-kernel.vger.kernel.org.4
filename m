Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409796C7265
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCWViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCWVis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:38:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD51DBBC;
        Thu, 23 Mar 2023 14:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVH83l6uxN4vVTfamhNAiv5YQkLXxJFIOUYK1iLRTVBLbMajGSKnPSskyLZ0oae391W84lAOSdRdfRtCERR/EamHfxym5OoOjemJmZX1BIs0H7RWiQO+mRVr68M7eOTd2MIrtkMappvTyh5UsyaStMP+83vRdWCe4097jZHPgt4YO+l4vt4tR4zDyHM1oVZyyXDJQ5EUhzc1Jj5YcwoYydDAof/Ao6IaN8Xm6MS5esYcSPPwElZ74YmW5K2QTOGSIFBX9QDPeSf04sS0Oq/h/Ru8ysvF4h2j4aE2UPfcUco1q4KuTSdaeA9DN7pjiFbAOmnuHjYSUIrHTt/1XGDbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Li8FOXq4OLHje5zYwNX0eKBXeZuW+mI405FUcEg9oA=;
 b=e6F3AlKj+WZD0jS0ALCLxx0t41PNC9r1HfGvJD+08F2CAD0qzwt3JYdPkOyP0j98PKqx19+YGqoiWwnwR6tjpGp1jIhJXWjPWeOKKpKVdBOQKyF8p3kE0DYHBRfkugOOhKIAxmPoV5bof63VT0cIXppkCurR+YDq802fa30GU8Fw4s7nAr6S4BWs1Z7GuZw5SpBuvutarAjmPvjel2ZI5lD/1Qb2TSY0lXkww39RqtCs6cjSVZD+77LRYhN+bn/CiT7xXRGshpSoRN4ky6CVZfsc26Z/oZfM5NNieqBZGk1/x2xmwCHscTUOGdzW59CZGl3uDD/Z5gGBe/NMh++Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Li8FOXq4OLHje5zYwNX0eKBXeZuW+mI405FUcEg9oA=;
 b=yeedQIMqZMtPBZtSy9ecdpv+84fdnjFGNrG0zKL0vJ3WALdPlz2nsN2Ww9hxjQL+CIcWvQx2+ncx4Oz3Qtnpz0OYdaPRaHrM77zKvW1xaVG1DBPqZRLlrgE7af3Z19re5vQqs2nkqGQNfuw8eQrgwCpmzUDNstHbFhlleuhtOLI=
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:38:37 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::a9) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:38:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:38:36 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 2/5] efi/cper: Export cper_mem_err_unpack() for CXL logging
Date:   Thu, 23 Mar 2023 16:38:05 -0500
Message-ID: <20230323213808.398039-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323213808.398039-1-terry.bowman@amd.com>
References: <20230323213808.398039-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: c9428e2d-00bb-4faf-62eb-08db2be6f5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cqzsml4W9C+B97YazR+uUpCv4VfQs3kBUi9uTPTajXs4XeUngsASZ2ubDONBg3gztPHdl6R4J/oBW1vaXN9LQYVhgL8qKuzeMditrLXoq/d1M5CSiH/Xvp1QJjGLmlvc0HHFMJSb1/g9s/sdUG0xOA4kHSC1GvKXfCsMV7NyH9tLcoTWYsfvUsjaJ8wk+q8/0rKa0+bWjbfqxs0sT20KwGgycdpWtLuC49+xyOsr8rHXjX7DJVEQ5Bz+HKnqtst9UAOrEkLuLDGxKTCosMW+FSmtBYu/VpT4aa7qhE4dU0B4vWdUK07kCh29ihy5KqBOajIG3+V7v6j+i6Z4W6dJEpcDmrLz+J+9ZzL+3PiK9Z0+0igZY9I52uI1yAEKU3U+Gqgm7JhHgGBdffgkO4nPG0i3153NbzS+fwg51Ei1izKVf/S/+fvjdWLCG5T/Coaw6l5Tc/ofEeSIBK+SWMeshvzlMcC6cd9Gj9ZmXxq5PRXFSoDPUewTCPDFXw59L/siDi6R7BR3+BPbC3qPN7bXURugsGSgtQMmXobqiLFEK6jbOt2qPGSjCUQA9osqWdwdeLqrUUiWPQtkJWhUGoNAo+R7hZ4Lwxq5gPQlimuFxAtS7Qpuy1h+SIAQuplcsWWSIgywRwE9gSBJc1TCdqHRRodPADu6slOuQ3CfMH7u9VuHczyK26fYvgJOKiorTNFUhfxI6OL6M/4SNZLXTNmaMFDK0Y/hoBFq1oMFUJUyHoM4e/0UugwuIuuKW53Ds+Ex
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(8676002)(70206006)(54906003)(4326008)(4744005)(110136005)(36860700001)(70586007)(6636002)(44832011)(41300700001)(81166007)(7416002)(5660300002)(82740400003)(426003)(8936002)(47076005)(316002)(26005)(1076003)(6666004)(16526019)(186003)(478600001)(2616005)(336012)(7696005)(86362001)(82310400005)(40480700001)(356005)(2906002)(921005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:38:37.1510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9428e2d-00bb-4faf-62eb-08db2be6f5f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
logging. This is not currently possible because CXL is a loadable module
and cper_print_aer() depends on cper_mem_err_unpack() which is not
exported.

Export cper_mem_err_unpack() to enable cper_print_aer() usage in
CXL and other loadable modules.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/cper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..ff15e12160ae 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
 
 static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 	int len)
-- 
2.34.1

