Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AE6A11A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBWVIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBWVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:08:04 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD1158A2;
        Thu, 23 Feb 2023 13:07:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsQUnD82ril0vMdzpCBhLiupj0vOTdoGX95NSBEK7A/zcU+l7CD8+xvZwwEHbgoEYwMA3Enn+6QzNpxG92sjR4+rIAsxPMtj8r6WeJ3zi71UAUDTwdtOVt7SFE4IT1oJIoB1fmLlF8XNqJg8ZjVmtHi6oPyzOTCdm1CnSFvxDCVqV0EjalGRoeybFujQbzIOZl2MOWcGKSpBi/eDP43u2/rSI2LQsUeB0dBydR7FzD/jrfft8bWxHKLsSRHeR+q21XV/Y2CT4mClrJ6s842FCGcpBQvdGJGvWmjpcGV8vtHS3A8cdD2F8NsqhoPyi9NdbqlfueZwUUypFwk7WY8UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9You5mHFHJWIC9EAKj6Nmvq+xb9oPUCufVcykvBJ2h8=;
 b=VWztuVHwDsTx9HqSSv2sPZDn2+oeFUl8wla3imGJXtyORAzZstw+qKSs1NnVzJP0vp0ntILKbsXyIVhrsXdu6GgyLnZQrCum5FSCBBJgKvLH/o9AB/8kb6JQZyufbkamGTLWgMsgveQvIFnqQyC/dvLgypwbFqXad3l/M7yN/1o5ilSRSd1OdozG/Sc8ZMg08XoDYGlnCntAnWGJ0Qd1kpfzmOy5JRb8m/eT2qjzPv0MiRi/kFv5fyepOez/D+HjC5s+OUojGuVb81gxvpsI9TbsXSABO4iN0y3FlSwNtUfHogQI5BysbMifIF0wFf+mlFc8LkoiTdO9dLt35qdF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9You5mHFHJWIC9EAKj6Nmvq+xb9oPUCufVcykvBJ2h8=;
 b=tuz8Hm4zta9/0gzBjEGWjcGtoyFjiF7jKN57sTXz++M8QAPUfL3hkCQiJmkHFE2mQtFojJDIsMFJPexJEw/KoMyVJxX2WyQM1RtGy2AGvsr54Jxm/V/2rj2Hu03OxT44ry/s6fePXLD8StBRwZC91DJ4nzc+FvaihGHMAkUUkhI=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 21:07:55 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 21:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Thu, 23 Feb 2023 21:07:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 15:07:54 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Fix problems fetching TBT3 DROM from AMD USB4 routers
Date:   Thu, 23 Feb 2023 15:07:40 -0600
Message-ID: <20230223210743.9819-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 117c3b92-18dc-4fde-cb50-08db15e2089e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8DrVc9XYB4OKlYbtl9urPUgfRtlJQfWWEbuZqrLY5AMthE8ETBnfjQaC5bgI/mYEifqGmEYTVLrKXEW17H9VVeRi0MopG1TGKIREqeeOldPduKNq6mu9x9TLhqPgPBtR9BxJvMjtN1oiThPg8upymlu+ssxm2XLBAu8+zVcioMt64jaIs+w79n7IvQwzxz+O139BUNeALkFkZBBefs0VSVlDFSrHScieLMcvOy/XFDGR1jMa/6BtIWGhoc0OayElJMBv6Ycp8tPYUpto4NEYJLgbUdffLQND+KuIUDfZfXk/+0dGOJ5XXMKJTx4MmE6a+H4bL6nL9a32xKOSJxbXGpxnLWW0i508fDGeyML8VpfEfRCmVuB7TOhzTvYy/mrPvWyW3uKgj0n1bcRU9+SCoiKl33YbqvvCcVTmV9YMAMEXa3hYIM4RQS2/5AmeH84H2FoBy4CTS8lEeR350Pp3w8Q5lPs0G7oQO52c+GXLMjWNd1QpbUP2cdbXBBP67w1JYsmLr107d7gnmvPP7XrdRCiF3qdn+oN+ZmM7vVn/xEZ+lrMCNzgPaCLpkVY4cmM9RzhkFjqbBWf7YDk4eC46gJEkx6zqQibfQPlRaRX0rGwaVo6hg/NCONQuLFKJXskHL7bBAPCz+j0MNsAmo33vgf06cRRC2fJSw/YfJrW/Phw+JYTxIhjBdB9T1dqJhqB/bPPu/3WfetBxdXgyPOeKgS+rNGlkDIJuAteH/83sp4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(2906002)(186003)(1076003)(26005)(16526019)(6666004)(40480700001)(478600001)(86362001)(356005)(426003)(336012)(66574015)(2616005)(47076005)(110136005)(36860700001)(54906003)(82310400005)(7696005)(40460700003)(36756003)(81166007)(83380400001)(8936002)(316002)(5660300002)(4326008)(70206006)(70586007)(8676002)(41300700001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 21:07:55.2911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117c3b92-18dc-4fde-cb50-08db15e2089e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

commit e87491a9fd4e3 ("thunderbolt: Retry DROM reads for more failure scenarios")
commit a283de3ec646f ("thunderbolt: Do not resume routers if UID is not set")
commit 6915812bbd109 ("thunderbolt: Do not make DROM read success compulsory")
commit f022ff7bf377 ("thunderbolt: Retry DROM read once if parsing fails")

Still even with these changes the failures do make it through. In comparing
other CM implementations utilized on AMD systems, they all access the
DROM directly from the NVM.

To avoid triggering this issue, try to get the DROM directly from the NVM
in Linux as well when devices have an LC.

v4:
 * Style fixups
 * Fixup for wrong path for USB4 devices

Mario Limonciello (3):
  thunderbolt: Adjust how NVM reading works
  thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
  thunderbolt: Refactor DROM reading

 drivers/thunderbolt/eeprom.c | 219 +++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 97 deletions(-)

-- 
2.34.1

