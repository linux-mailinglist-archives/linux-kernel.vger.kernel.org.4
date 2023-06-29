Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C3743C02
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjF3Mhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3Mhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:37:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281501B4;
        Fri, 30 Jun 2023 05:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt245ibCfjZqVop8VQNlf2yxYf/vplLGuYeM+hMxt5a1V1UFkxBSfZGzNdBtBbmVf95ssURSK2YkLOgTjkpDxt+nh5mPTMaq83jDm/ZrxMc3djpSF0Q43sgJKpsOWlC3L8cvpuLOGzR5Yv9j9nAhHLN2PlLX3l7GTvlLL0p0vcSkbPimkUU+AAycz8Q4WW5mK1yl9WL7kvehn0+cCamH7b2wA+pDkYZ9K9lat914bJNsV7iMRRcIHxjpClTdWid/4GiW5y4g483jdDU+hOr6FqOhZwgUoEcrmlY+3BDaHl6Q7SOjN4S8Yq1KLoTfAF3xxMjwXoJfMEv4TjpMmmpqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvU+4emVaOWoXWU/Y5gen1tfKdOurL2XUOUgchr6ZYY=;
 b=oEVI1moCp8w0w5O2VYt5Pze5hz11coe3Xdytl4zDR8m2cFQ0g4Kk3ggg7hkJI6j+i/yAHURGGKmFnN1M59HeLm2YMVnzJ+GF0bWwBFsHwbwUxR6/TD4Jy9EGpnrsHwwZAUa1ufb/dWMQrjP5976vuyLh7jYKte/LKeTTrTZx/A3Xua6/PY2i8MIggp7y+Cpc+cvzEaojvfg82PONoi1YwcUK6cCGA9CGIvPogwy+3C5cmOZbZhEcBleHA4XMpEjtQgaX1xJMqvZdubhHJjZ+sv7OU0WoFxDN7EZdIm112LT6HqUf2cOFb9lhmOVymuCyULb7Z351kONx+qFgGatprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvU+4emVaOWoXWU/Y5gen1tfKdOurL2XUOUgchr6ZYY=;
 b=cuWXpxBd/6m0DlzfDFt3R8Q/BwvXs/XyqKhfmfcU3k58SCkFLhU2dNICXEHbJs+nMIudQWPwaJkM4pBfJ9fLSzS5atKDXIDLX7kJqP/t9YFQZR6C8RECOExKQpqq/A48taMlGvMOoCEUIMHlmqtSBngMa8mjHff0LEN7AMxfS6g=
Received: from BN8PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:94::43)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 12:37:26 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::3b) by BN8PR03CA0030.outlook.office365.com
 (2603:10b6:408:94::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 12:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 12:37:24 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 07:37:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Add sysfs file for base frequency
Date:   Thu, 29 Jun 2023 08:54:54 -0500
Message-ID: <20230629135454.177421-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a3fc03-5868-4ba4-411d-08db7966c1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLYF5Mu2mlXM3IA/uVSV/sySXKywfTgnek9V4goeaf6r9GBt3jNGuIGRbMig2GP5ulnLuktHs9lJo368pd5VxU3TrMXtFAUHlpjrUksiG4iLa2JIwCxT0sme2/OvMVI5zawCGTTD1jSXW+oUslvD1BolTLQIiJF8HWpNue6rmsJAO6R9yLj4uapFurQKaTqX/K84+DZeq7C0y+tcbgaq8pHejj3Kl6m9sR/5PGLs8me4LYAE50E9b8mZZt3o1yRGLjnHIkHhxD/+O1BUSxj8afXzUjRoGji5LY8CZ5MC8hfl9nxYvBTNF1vwuL2dCCeUl+5Ys/dMQL8TzI28kOyl1y/1oLjTi7l1lZehFJ16KY4x7KpqGYJyqAkjLIYs4Rdwl0ljdQ9RuwytIOgT96zawc1CGy4/3BLoy3VIiLMytpje09ETN9H6nVr9q72U79bjv5ODoezOWFtx09hVO5QzMbpFo7oulX6Wgih500JtEExGq58Wz46Mi8eppI9GL+fSl1rV5jvCte+WbOsKFJLnbDLTJLtkwgq7uxJPpjBzTJ6A2ySVbM0uPgfmv5HnOvG8cxjggNi4z/UNSG4ChXBYV2uRNtEjvtKfHN6D0UFVB2eLDhglyS8vaDfHOjNo6PlCHPnBdG97+Iklc8zdVkGHIud9rLywXdANNZNnprWFUSNbaIng+HS2SqTlcpETAfMO+QyMjfPa3v9geeAzvxv5vMregPO538IGt9fQhV1l8ZIUAwKsYZeq+fDaWouGS4s2XYSVmxRxJjt6DPkA+I/p1dRRMoZllrhGyiwZckLowss=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(1076003)(36860700001)(36756003)(5660300002)(44832011)(356005)(86362001)(47076005)(41300700001)(8676002)(316002)(81166007)(4326008)(70586007)(8936002)(40480700001)(82740400003)(40460700003)(70206006)(2906002)(478600001)(186003)(26005)(16526019)(2616005)(7696005)(336012)(6666004)(426003)(83380400001)(110136005)(54906003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:37:24.9437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a3fc03-5868-4ba4-411d-08db7966c1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some applications may want to query the base frequency to tell when
a processor is operating in boost.

Tested-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Co-developed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst |  4 ++++
 drivers/cpufreq/amd-pstate.c                | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278cd..e68267857e859 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,10 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
 firmware, if EPP feature is disabled, driver will ignore the written value
 This attribute is read-write.
 
+``base_frequency``
+	Shows the base frequency of the CPU. Frequencies above this will be in the
+  ``boost`` range. This attribute is read-only.
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 81fba0dcbee99..0fec66b3f7241 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1037,6 +1037,19 @@ static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u32 nominal_freq;
+
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	if (nominal_freq < 0)
+		return nominal_freq;
+
+	return sysfs_emit(buf, "%d\n", nominal_freq);
+}
+
+cpufreq_freq_attr_ro(base_frequency);
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1049,6 +1062,7 @@ static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
 	&amd_pstate_highest_perf,
+	&base_frequency,
 	NULL,
 };
 
@@ -1058,6 +1072,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_highest_perf,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
+	&base_frequency,
 	NULL,
 };
 
-- 
2.34.1

