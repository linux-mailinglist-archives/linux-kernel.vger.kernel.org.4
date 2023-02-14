Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6969685D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjBNPrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBNPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:47:13 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB929431;
        Tue, 14 Feb 2023 07:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3EcrkX3jtI4d+7DQwmGFkNeSbDJWwsIp8zcrHxt3iwPkkgyZUTnyQof5eG34EqWGWfMZuRdqHorbXG9fa1+pxjz3SDs/weQ7N4SpNxoRdkD3Qyj1uLao+/wyFpPAkxl50UQ9//wfAxzD58MLx/TLhOoiTQ2x2m1A366GSqXTHDI+uxIA0EuG9xLy44qbhqbSPRIo4vpgtCAh8ZoLyRLj3LBf5+LNT5WbRLX3Pf8ktmyboWqDpuWAzTsR+cpDMY935tLZDoAQ4D9Vccy3sG6OhTHjOfFAbUUWKUG91DiX66eWVu55wZHMptXY8m8kYEEQtSEwWByIL7yW8TXt0706w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxxUPTfyV3H0E5iB88ltNo4TGm9R40J7X7DdLHK/h2g=;
 b=Quc86zBS80+iVLluuiljt+hmbwjWCohzLvhOi03Bv3Ggpe3Q1FYak7CP5GMl1JqSDVdV76os0vFcqGl06xJ2b6dpHhg55rw375txXE3ngINM8sjhey/finpV+J2HcBjloh7eq64WZaLiB0nWbLjUvicwaChTi+A6qR2nyqCifB/Q1W9QTwMoT8KdU+Y7o+U7EDYR67qMQ3HHXL0G5gPIE0I9hrcKuvU5J/zCtfWsVPhDUQG5OrA3E1YRIwaYhJNm4xVNwowFjTI+P4pqKsQ6DexI7fXdcLQRnrFy1NjU/U1VuX5vpatafp3+NH8Zlyng0z6MfN7Cw7iSYw0iwLH2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxxUPTfyV3H0E5iB88ltNo4TGm9R40J7X7DdLHK/h2g=;
 b=lvgIj8ojsb+FnMxbA68TwFFO+SyncWIjOLXCuME31EESeQ52tiSlpjxjEC6kz0tEJFFdA/yNppUQ5uAE/i7ySyNG8Oj6BRo2P4hVu1a6o9sYb9HM9WUjDYeNeIA8gJ1YPcuYnTAxZRFPnK41iQieGJcjCn1H6WSpfXm9iGO3Hhk=
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 15:47:10 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::75) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 15:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 15:47:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 09:47:09 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <YehezkelShB@gmail.com>, <michael.jamet@intel.com>,
        <andreas.noever@gmail.com>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix problems fetching TBT3 DROM from AMD USB4 routers
Date:   Tue, 14 Feb 2023 09:46:44 -0600
Message-ID: <20230214154647.874-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CH0PR12MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: c676d7b2-f9ea-4c6c-2640-08db0ea2bc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjXYAfsluWfFun5WcNMl6OpoBHoWZtxHtXWjyiIahQiQcqxCZlhAvFjb6eoPd8u9zYLeQVoyeREw4vHsmaf0SJhNZIc1rxUJX8E/Vmr34h/jlCV9+Nq1MyDK/aGe6iWw8yqbwCZcjeghLRp1FpK7Bfg3WJyPt1GOOqZZ+xtFgbiIwyMNw97YlqSI/CxczBQOPgJDHocWRg0I2WTKMS7zp3lzjVHaSJrm4qVx1/FT5SAoggP9Uk6wWHWlfB5gCFfUCorW9o4p5YxrcSc/iQOfu2VJZzFUyS0hVfyBCyzW0k91eXtpEv+ttWRsdjnql88lg6F6aLxr3YtHhxc/m+ounMCq4erdktcQBnkZNMpZ+iwMdSNcHyKkD5pkt96mCmAMWaJWY/SzXIfqnUOHFWBKTJXHPIaxpr/6aX0XuBUhOrkiyJFo0hY6TO+1NOtpnvGlDw/u2/GcQbetCuFwjc6v9+SRzuCAR8TQesmzUlaRCmAH8pMsvq6/uPp5zDFsBcVpQxmYuQgsdi/6INHOgg5JAV7ZJR2pTnhnqiMzAD+SvDLjud48ebrIms8nUBVzWDcB9A4rJSemE88o93+VX1Dqav4lhcw/ZENUeZ3cL/a0lUAnM0YOLAsHa552q/V9WuVe26mkcy6QJ1/OJuwoHr2fqk8cX/Be4CiD4YstwIBR4mej/BhY3zTkDgt5KyWhHp1pyqVUvutUmUJFcuGV2IuJwN4wd3KRTFNQvX7DNoYgt00=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82310400005)(2906002)(8936002)(5660300002)(44832011)(41300700001)(36860700001)(81166007)(83380400001)(356005)(82740400003)(7696005)(478600001)(8676002)(16526019)(186003)(26005)(40480700001)(40460700003)(4326008)(110136005)(316002)(54906003)(70586007)(336012)(2616005)(426003)(1076003)(70206006)(47076005)(6666004)(66574015)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 15:47:10.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c676d7b2-f9ea-4c6c-2640-08db0ea2bc01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TBT3 devices when connected to an AMD USB4 router occasionally fail to
properly respond to requests for the DROM via bit banging.

Depending upon which part of the request failed will impact the severity.
A number of workarounds have been put in place to let the driver handle
the failed requests:

e87491a9fd4e3 ("thunderbolt: Retry DROM reads for more failure scenarios")
a283de3ec646f ("thunderbolt: Do not resume routers if UID is not set")
6915812bbd109 ("thunderbolt: Do not make DROM read success compulsory")

Still even with these changes the failures do make it through. In comparing
other CM implementations, they all access the DROM directly from the NVM.

To avoid triggering this issue, try to get the DROM directly from the NVM
in Linux as well before resorting to bitbanging.

Mario Limonciello (2):
  thunderbolt: Read DROM directly from NVM before trying bit banging
  thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset

 drivers/thunderbolt/eeprom.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.1

