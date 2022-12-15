Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1331E64E1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLOTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLOTQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:16:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893FC2EF50;
        Thu, 15 Dec 2022 11:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu9AV+6b41N/70cREgWLsyuM3g6haP/+cJke/S2NZbI4p0sN7J74SIhjx2Bmcu1tdWYp6/eQCbrgkYQK8UGtRpCx1LtjnEsiDOm+bCNtVv42JZMnI/oD7v2wbpWcY71Lo77kXJ7jgDGIfQLTTfE3QeoIwe3GzXCLpJzVEU4X//0WvJZKioupB9MQHmas58FvzyeuDM69laevfiK5BayXZnu4Sq4u/lz6/6HKeRK/AKbe02AoJr7jOs63HSxDk7bewR9pknkW3yQKOaj148Azss23fm42r/M5EmmNEOXHkKhj8YzVYOpm5/CISQQ7/Z/52QV8JSZXEf/R2iXYd8j8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E3vLYTWAlLF9eVRF82qrqHPIq5Z/xInpkLDM3g2Svc=;
 b=P410kSQR9yglT9eoOtJO2c6RMECRnKu315Kl3Hn7flvIJZb485xya4KMToqA5jbs2BFGYhnSBRIINLlXBLSoDqyuOgjKE2gmGIbvfHTRIJti9HC3tUPHj6IIrDxEC7S19sQ7wXZljGSagKLge0u6BxIgCFpasAqB+epJDyJNng0FmP2J1oiy0qFD2poG6lhGNT4glIYKTS00Y2sUreYoJRHD7tX1YIASfHYq/f1Npj11PprCGGnthcpayqgKmERfTrEErklE0zUbb1moTXNtaL2O+bhPwBl+YuNCF8TLuP+0sgodLrW3Ks/uIY9GrESBSRJjyJ8Y2JhNu1tySVYshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E3vLYTWAlLF9eVRF82qrqHPIq5Z/xInpkLDM3g2Svc=;
 b=Gzdar1VFpeuTLp6JgSAY7CGH+TUZdzlPbeuzkCHSaHzpxkPWBOoMgkUh0lzEnEMjCPf+D8OVugHpH8H5yQdG6aW15Kpv2UR3zkrdEKt2yOvVJZZFCJw4CE5lIELaYHoG7DuocOEvHLLjlW5khjocDku4ew7KrF4SiIue56h63Bg=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 19:16:31 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::b4) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.5 via Frontend
 Transport; Thu, 15 Dec 2022 19:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 19:16:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 13:16:28 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, Philipp Zabel <philipp.zabel@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     <anson.tsao@amd.com>, <ben@bcheng.me>, <paul@zogpog.com>,
        <bilkow@tutanota.com>, <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Stop using AMD GUID/_REV 2 by default
Date:   Thu, 15 Dec 2022 13:16:14 -0600
Message-ID: <20221215191617.1438-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|MN2PR12MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b9356f-445a-496d-210c-08daded0df2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fnwlv+U39vFXri8VP2lynd9f0R0nPD8gRVe3ke7B5cRFHVaeXiDkemvj4X0h+p1kFYBNh8EnvI4uoEkWapEhrUsy/YeKEAt18VCdtpcv3dFsIoRN2FqSe268BtZel9YnJy71W/UPBMJVjz0o5biybITWe5lvRMC0elbljoNHv62My2kKJWfQR+tuFbBzYMyGbSkjmhg3WjtPieFs4jI4qZj89z/fPBDHxKRhmJT+G3M1FUSPxEc0kiUACX/SpZQoFs0ozioJM2onhP/9XnkA8CS2rRbRXjj3lmgYzqufQXmUhoJqN0lZTXaI6PwlQIEAxIux/9tQfMrnG0lYzhpvskRRr1Uj1c2VfYuJwF+hgM4E7HRMl4hC7gy0w1rBYBQj5oLsnvA7L5O1l1ar8Cg1NdXOBCq6ASS5HWhWvNysMaGmrdcxARXXE+uyEz3SfXEREtEkQe/T0mrrd8q3dRQjIGwbMcQoh7I8GD/F3pRFxkKfN9ZTlRg/kiiuFIOhD64FD+OmfRfiO5/ezJ94qRStaDz6SGxGrspOgMJFEkSbWfF6TmNRaqFsJ5u3qyrIFPO6aeCMmn1D0BhPwUHpx754YTG2b0EGLDiIUJ7lo4+oPg1ymv7wOcrHL/bgFr2QK7znfMRCd5ftWPFgVrxaHnKYVe+HvOYD8nGAOEr7K9bt8l9HOs5R6kpB3zX95T8uhp0SnhHKFz3vqZmfN8PiYVIWKOJqlVPYUQt8BwXNRTLVa2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(44832011)(40480700001)(2906002)(86362001)(6666004)(1076003)(7696005)(36860700001)(16526019)(426003)(2616005)(47076005)(336012)(186003)(40460700003)(4326008)(70206006)(70586007)(83380400001)(8676002)(26005)(41300700001)(8936002)(5660300002)(356005)(316002)(82740400003)(81166007)(110136005)(54906003)(45080400002)(478600001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 19:16:30.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9356f-445a-496d-210c-08daded0df2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of laptops have been showing up where lots of EC controlled
features weren't working after resume.  They've varied from KBD
backlight, to fans, brightness control and lots more.
In kernel 6.1 we introduced a module parameter through
commit a0bc002393d4 ("ACPI: x86: s2idle: Add module parameter to
prefer Microsoft GUID") and a series of quirks in follow up commits
for systems that people reported the problems.

3 more systems recently reported issues; and so rather than increasing
the list /again/ to add these new systems we took a hard look at the
"why".

The AMD GUID/_REV 2 path was introduced for vendors to be able to
differentiate from the Microsoft path.  Vendors could populate this
with unique code for their designs.  Conceptually this was supposed
to help the ecosystem, however in practice we've found that there
are more machines that don't populate it than do.

The only models that have populated this with unique code for avoiding
a bug specific to their design is the HP Elitebook 835, 845, and 865 G9
systems.

To avoid growing the list further this series rips out the module
parameter support, all the quirks and sets the default policy to follow
the Microsoft GUID path for AMD Rembrandt or later.  We validated this
on OEM systems and we found this fixes them.

To avoid regressing the HP systems that use the AMD GUID/_REV 2
path, let them keep taking it. The reason they take it is believed to
be a bug with WLAN firmware.  If this is fixed in the future, we may
consider dropping the HP systems as well and having no quirks.

Mario Limonciello (2):
  ACPI: x86: s2idle: Force AMD GUID/_REV 2 on HP Elitebook 865
  ACPI: x86: s2idle: Stop using AMD specific codepath for Rembrandt+

 drivers/acpi/x86/s2idle.c | 87 ++++++---------------------------------
 1 file changed, 13 insertions(+), 74 deletions(-)

-- 
2.34.1

