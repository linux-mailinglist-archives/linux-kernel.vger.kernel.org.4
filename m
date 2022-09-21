Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6025C0062
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIUOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIUOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:54:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16712635;
        Wed, 21 Sep 2022 07:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPRHgjVJT79EwXXw0iEqpzCz1sAefk5E7kWaZpmJxhkT+vB6leKxRcJj6ydZcygCmGkNdYcgarfffakqaxR7WkmHadVdWsEZp/nV+tMhTAHjeI/wlQIgN12czMWd1P0fFHCotfjp73E4BbSbF6nKa7bjZa4bW1t9xcFDMO14rwuTpnCRkV01Xu/Ufmw4b+OgbiASj3KvlsvIYzqBJ5l2p7R/AcD8B/iu5QLFJCD/+ev5l0Z8VP3p2k3lbyY3HWsjFMw0uUgE22/0LGHD+lJYywmSp1ySjo611T6lpIwARS6J/BKtis0DCpbgW7tkW7Jt//mFU9ACXi/CxIZV1n9Sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E8gmCp5J+D4o+yU6a7f/TKclI8vXfKIRf3e7AUIxEE=;
 b=amYjZJMdeKhinbnSlGyazDMoqu2mr9lm2encPO0JB8XEfF9Vjew1zxrxAqbW9VzJ/1XXs6nf+6pdTqMrCkriaPyDkJCPJqQHCP8/RnIPckcJC/WkpqLP8ojXmEnV60rHKOPxYoCiJK+Ww9y2+YgZUdHazKLpYddkBTQYCadgIo6IyGszX4nNPU5wPICqB072NG6IAb68KGXx50SkG/wpYKUMmsAmFu0uFqpvaEYChzb5ymuQdLuBVpqgZwyZcSq0rQIipZJgwe8kV86U9aUw0NoPAOLxUTqhYBk2qMf7zSmvb7UrKwyhv4HtoBntH14PHGv4sAkSaI4x+Kq4UNTPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E8gmCp5J+D4o+yU6a7f/TKclI8vXfKIRf3e7AUIxEE=;
 b=QrwnDY8AAoOKYHn1RJHl0ZwmJvXaS5LfHZfKcBfXwQYn4JGu6ZMC0e2Zcc25THxawbWXiKVCfkJq7JB6LN1Zz+Z7ZBgCEqpZvSs/uQuvN7tAAiOe8DgIqN66b4rFN8kFVLhBkbe2rEFwDcWDtJMBZgZIyPFBHuGCsYb/lfofrLk=
Received: from DM6PR14CA0044.namprd14.prod.outlook.com (2603:10b6:5:18f::21)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 14:54:38 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::d6) by DM6PR14CA0044.outlook.office365.com
 (2603:10b6:5:18f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Wed, 21 Sep 2022 14:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 14:54:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 09:54:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-usb@vger.kernel.org>
CC:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>, <sanju.mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix some hotplug event issues
Date:   Wed, 21 Sep 2022 09:54:31 -0500
Message-ID: <20220921145434.21659-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5b1574-c710-4104-4d73-08da9be134c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Brk5SI/7pqwAPgq24eY8IQMO8U4pVShd2IvkpRRgxhaxRl/YoWAYI68N1KT981aPpR+Fqi+5+F7kDnBOIc9+FLwxGSzUEJurXP7ICIOLdtUubYitNKq7DRTs4UDt2ZWOc78UaMZNMBs9Ob6/gHkUgMvT3Mx0BSzQSvwwFLHn4qaWs9uEwdQ1jSHxbv7mvwHSFHIiYFEK3GXFzq28PWMgOb84yl5fX74K0I9/ofnEhnDpygNRZnbKMvR0kc+2e9G3giauw1I67mpzarcv20bBvKUlucdBq5KmJ1evlqg52CPLYKsBlUoR+pX9IJ790N09prNy1JwmjhcYk4YhSCyc+M9PTnLsyOdcAjBT872086Clsz1WsQMsNVqlrVMIIVPfllgmXsUxYkKyeX6oez9P7g+JyT640A1RRFl2L3miJXMn8p6rhu4euMeMN6UnIqqf9GcPnfhXDb2WJeZjKVTMn1P56tkoNpbvrQNkI/Upfr3C4nWPFeMLyrUREhgAipTB1TZvL8qmxrjHkSB7CvtWjuA94TjfDSb8PYXv+2OJuVDlnQ/gHyG+rCD0iF5rWC3O+Jt0G4Uj+3R1q8w1LUFTVlj8xIbn47H1y7DP6TnjtT9AWg4pzMeL0mEfdsFxh8rChhN2MPV4JToXdqUStzN3RlqDXWSuz4VE5uTHi8wZo8rkZpbip+4n1h0KFSyaJaR4OvgEHw1xaYzoJj+RH5BYwrfM4ja+tuj40qyL6j8CMQr7hs/lsB11w6OgpzejaakTwZIIxnRB5kkV+nNQlBsyff5lGirYVSLvGxZzvUgBXw+rXyNZxMefQ+w08hocdVnv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(4744005)(36860700001)(44832011)(478600001)(186003)(70206006)(54906003)(70586007)(36756003)(41300700001)(86362001)(356005)(8936002)(7696005)(4326008)(26005)(81166007)(82310400005)(336012)(82740400003)(40480700001)(110136005)(16526019)(5660300002)(40460700003)(1076003)(6666004)(316002)(2906002)(426003)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:54:38.0479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5b1574-c710-4104-4d73-08da9be134c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD Pink Sardine it's been observed that if another CM has run before
the Linux CM that some registers may not match expectations which leads
to a non-functional hotplug for PCIe devices.

Explicitly set these registers that have been observed to cause problems
with hotplug to the defaults of the USB4 spec.

Mario Limonciello (2):
  thunderbolt: Explicitly reset plug events delay back to USB4 spec
    value
  thunderbolt: Explicitly enable lane adapter hotplug events at startup

 drivers/thunderbolt/switch.c  |  5 +++++
 drivers/thunderbolt/tb.h      |  1 +
 drivers/thunderbolt/tb_regs.h |  1 +
 drivers/thunderbolt/usb4.c    | 19 +++++++++++++++++++
 4 files changed, 26 insertions(+)

-- 
2.34.1

