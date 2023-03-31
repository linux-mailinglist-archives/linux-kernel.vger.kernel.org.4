Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CC86D18C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCaHla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCaHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:41:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE3E072;
        Fri, 31 Mar 2023 00:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnnkVYxN2JHQmduQLDMlvmvie8g6GMaoul8vaaSEJTer8LUJP/0T904qEZ/Oz9rkkSQYafULYA/0Lxx/u4ZmyVUg6WveU4mGXa4E250+dts8fJW0+eMUAilGsYumqcZX42sZ9Icf7neMvEgSXFth/kY8baDhTzbUb/NqA7iAXgFVUnLZICQ2myZSVFrdcVx5lNScHPQW5REmVQfQcWfzTi842F4QVeoWXIWXCt1VPRpm5FiT0Vhqb0OJaYvGBYiwDAj2P2ax4xoEuwMhg0tSCIMiNgG1WjVG4J31Lxy5JuodkNSS3U6312mjBIhBgwoWS6wkpvq2jG2XLuXrAPGF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRdZQLxZQ59lQlB5USihwk2Fts1WqnOErNHDVr93jOE=;
 b=Vc1CHoILTxsHoecw5eObbx0ImBV0YSUJqwJ6PQroVfg6IwRtXbNsuuI1AlA3bEyJX3oRW9p9sHOEjbWgZTCi0BvHTYaR3VuUqQFAwUDm2+8JTWEYU/cb6d3WgGZ8hcoDJVfK/FdyS5Rr+mEbMuU4Ro9cNR/wAtPCsUR6l27/wyqRHla6SC/RFSq7lwR9vH7YzPi7zf/Vs9WHhcnujeMAx6AED0vHxTeEjVL3qaIHq4d1IFlEauQfmkk5qqNTQZ4+PB+AcydCKPJY06BBU814OPSS4QXhnCwvZtQhNizrjxLmISy/ipvXgft6Uwq89S4kFBf7Kui8YWUYuO/ndJpfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRdZQLxZQ59lQlB5USihwk2Fts1WqnOErNHDVr93jOE=;
 b=lxwy8BQ23w9KPQ1TZ220x93eC+N05JOCoQv0Hn3BzEHrbhlibCmjmQa24l4BC9nc57ZmnRJthNlIOr+R8QAEGTOKwkupYbmdEinTHDNIZHSP8RkDqtxkh2FIekjBf4H1zsz9J2uKg1U+UT3awNemXdMSCHgxRQp0apLYk0bPXbU=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 07:41:23 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::82) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Fri, 31 Mar 2023 07:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 07:41:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:22 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 31 Mar 2023 02:41:18 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V3 0/4] watchdog: xilinx_wwdt: Add Versal watchdog support
Date:   Fri, 31 Mar 2023 13:11:13 +0530
Message-ID: <20230331074117.356339-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8579fd85-d91f-4ec5-5eaf-08db31bb534e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTcy+SyAUMTpW6vv2WLvIqTV5/Zfg8P8aIRt2KJs9qljcKajsiPWWJpNz9Q38ty8j+hgpUET9hboQzfXshjAC457weSuEFy91VfkBvRphBEi9bg8mc6iqyltW8QGvzp5hJNMfDwicp4/TdVGQd0Jp/QgbyXnkTOyTbQ6edvx/W5azPTMY4RXGgBP4EZZN9+RNQYJp1KjruZN/BrJ5Cmjgv4C9XP6wZ4e1L5OR0YE0iOJUuSp0+JcJgIPfl3+Wkaiv0av0rgltycCY9cSViAFtIcHWviKxsSocylzvkaECa8Cn4o6jUSOxTOxFuOs9NpnS2V5wV0lJvD5fXvFhoBmRJeyl+eeoS+eRijMzuBEb4HFVZvd2gUWR2q1/vV5Fk8cT0swc7/jjqG4NJKYEIN6KlzMNBtuBV8wqImMRUgSGjkFuQgSF4N7nlF/iBwFuAFpBxybmgDypXF6SdWU45ad9kvv0xhGbcZWXRdj09teIqxHhgPnM8zW0nMjZAPXBIiQdwBM+foCTw6fICb45qez9cgJ/ISkRFBq+HIpz6+BsBdqQhRwof3AjgMSt3UAx+1xy3ztLFQvoaBgR65me2OptaKq55YuAd9FioeXZ3hFsrkELu3LdFNxBT7vzVqktf354ewvVExi/OLe5QWI7LBpUzR2YbfxXbRxteTmRuJ9gKOhUFLux63zAx8VT9ywfQnxZTFfCxGKLV/1B6APYQoa8mmY5a/pjnzPRUUe8vWzoVg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(36756003)(316002)(70586007)(70206006)(4326008)(8676002)(478600001)(54906003)(41300700001)(8936002)(5660300002)(6666004)(82310400005)(4744005)(356005)(82740400003)(44832011)(36860700001)(2906002)(26005)(40480700001)(1076003)(426003)(336012)(110136005)(2616005)(186003)(83380400001)(47076005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:41:22.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8579fd85-d91f-4ec5-5eaf-08db31bb534e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does
-Adds dt-bindings for versal watchdog driver.
-Adds support for versal watchdog driver.
-Adds fragment page for xilinx watchdog drivers.

There was a series[1] sent earlier to add versal watchdog support using
pretimeout. In review it was discouraged to use pretimeout for open and
close window . This series is a new implementation of versal watchdog.

Srinivas Neeli (4):
  MAINTAINERS: Add fragment for Xilinx watchdog driver
  dt-bindings: watchdog: xlnx,versal-wwdt: Add versal watchdog bindings
  watchdog: xilinx_wwdt: Add Versal window watchdog support
  MAINTAINERS: Add support for Xilinx versal watchdog

 .../bindings/watchdog/xlnx,versal-wwdt.yaml   |  50 ++++
 MAINTAINERS                                   |  10 +
 drivers/watchdog/Kconfig                      |  18 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/xilinx_wwdt.c                | 215 ++++++++++++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

-- 
2.25.1

