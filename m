Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4014374A1DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGFQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:10:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3992DC;
        Thu,  6 Jul 2023 09:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3OvK0+iyDy6Zw5Bxx2ShGMpJwnXjBUjfSk8Xwk2jGMOSH8BLsHeOtN9J35MJ3i4cDqtNIYm5UdStLYZC1NC7+0IBN40dWsKAX8O9jc7tseT5QcR5bLKLW94Bk4AptYYMgFsp00HbPHZv2UJgjW0N7VpkzFEBHNz66QC6pFWHWE7Is9L/9q04e8ZWjWCLTAm58lVMy7+mX7Rs9gEeh/iK7l3kjR0C2UIKQe/oPEu/hlDjFz4Ool+QYSuGaC3xHNlLQ2yL9Q4bLBy2rETYl+EIL4WhL63FTCuzeRLgUWrViEuG7i7YiudYRNj7/qfg4F3qUJsS6+hT3FM6VPmSKEgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYRFqX2pWrxN382/+66vhZKPjAulKHlFTe3YKwKkqFA=;
 b=Ny/2BX39JolcV+Emv/XIx2SvaU8WloqPTCshb4ZZdqk+mjEawXyZUC8nwbSLJts1ETyaltWRvuFmvcYoZcyuUDWRLP9c6sUxOK8NL7/S07niPmcnl7xPTLFdj4SVPIcFfAocviIb0Pr4HpHWPdA4I6J+ortEMdej1+p0LvKuj1vKRRhOHPWJ2HJu61m1Z4CRKSxZv8YJq60pJM/kN0LN0ZsyX8UTxqnI6NwLCPrANV0XtQL9Va0X/DoIH904wN3pE/Ia0bNXYTD5wT6M+NF04wrCcWF+PsyPQsc1VKR7LrTqrlD3e1VEDXMPdlQ5CZPvnlcK95MpYGQlyM1ufy7zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ucw.cz smtp.mailfrom=siemens.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYRFqX2pWrxN382/+66vhZKPjAulKHlFTe3YKwKkqFA=;
 b=L7LnEUurpc0lh/+4ld5YqPMq5htrg+oSSeS2d7MDDA5ytv0EJMgqYRBXgHmbUSQUDTM1gzcEOwzc602PMUYtL41ovPe0fnc5xg6zHXAvnVRPyvMHB0egg5GKxDvwsuDagEaXLoddsnx3DZNXUyBbaULlEScQkWtAy1PsNXtJBcKX+y/I030RFftfu3cFUNSNYWHzFY0aVyKDJtNho6JUMAVvQ+q55YDwqikXQJ5SL1wns9wi+Nv9Wi1XZ//ranb8EgdS3lh83k9HCpVUhaB6DNlbQ6iTxemJRMgyQjJ9zbOuY9OeUwuNyQwPbijFA1noTKT+xv8Imk47ij0heMzoxA==
Received: from OS6P279CA0139.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::9) by
 DB9PR10MB6315.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 16:10:52 +0000
Received: from HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::7a) by OS6P279CA0139.outlook.office365.com
 (2603:10a6:e10:3a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 16:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT003.mail.protection.outlook.com (10.152.0.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 16:10:51 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 18:10:50 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.40) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Jul 2023 18:10:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/2] platform/x86: simatic-ipc: minor cleanups
Date:   Thu, 6 Jul 2023 18:10:38 +0200
Message-ID: <20230706161040.21152-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT003:EE_|DB9PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 08839401-d9f9-4549-d146-08db7e3b91a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Lq/U3AetfYVH5CFVS3MLuWXArOsc0fm28f/JZbh/oLVoBfmHe5nvFirmvZYJHmnQ1eMTX6jyBs+FjG4Pm990riA70ciXa0wbNhupxRp4jK16hk1JFjbhqrSVgxKq0/pb1mRbcujUkUpoP2Q1Dtb5z5lPKk/6HAlnsAR4qdxCG5s/YI/2SaqIrlwprOkk0lm+xw5xMZ7+dbx13RNnCfMZ7JSXrrcx2/6vqlJR9AQ+avYfPbll/3JvL8gEk6DEgQrZAifUIgA1Z2nwwh0vbaKfNZp+52XW0JECwlAFcEYAxUGcDT4CdwiOmsOgOgZVTO6YHx+I8BSwamu96rjF0HlcL59PBALd/NrErPrcWWNWGcuc/WzAmJa2VtDjEDPdU22IJ8RvjAjfvi3eN7iiEWDbd8dHVxDhucdQFmtQNaFnriVmLTWthglcbPNXypg2T/shvzBVAvn75PESDFfB//+ku8BGbKyyvMs8atKppPTS6q2vp2twiOrJuP37akUGn52AYrMa1avJB02vHjVT9WPOGfOBo3FxHYTXObeVW+hR/+huNZUOO50uAPhTTeeT168d9+6TkF88a3ysfrayTMmTnZkDNkQQla+9cr9wRTTGmRgd/1RkESiVCBShdzVDk6cPztP9c+14N1I0QuZ8iyc6gVtDVtn1mhivZST1ufkt5m9uv8QaJdEVtQlRmq6iqdKPJGQWUEX3p6/sCkYmPd/HEXRbyJxx9VX82/Y0uxIL/4=
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(16526019)(26005)(82960400001)(186003)(107886003)(1076003)(336012)(956004)(86362001)(82740400003)(2616005)(6666004)(110136005)(316002)(83380400001)(47076005)(7596003)(7636003)(356005)(70586007)(36860700001)(70206006)(4326008)(5660300002)(8676002)(8936002)(40460700003)(44832011)(4744005)(2906002)(41300700001)(40480700001)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:10:51.3500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08839401-d9f9-4549-d146-08db7e3b91a2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two rather trivial things i found while working on something else.
Sending that as its own series to decouple that from that other topic.

Henning Schild (2):
  platform/x86: simatic-ipc: drop PCI runtime depends and header
  leds: simatic-ipc-leds-gpio: fix comment style in SPDX header

 drivers/leds/simple/simatic-ipc-leds-gpio.h | 2 +-
 drivers/platform/x86/Kconfig                | 1 -
 drivers/platform/x86/simatic-ipc.c          | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.39.3

