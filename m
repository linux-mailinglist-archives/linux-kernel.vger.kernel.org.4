Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E825BDC60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiITFY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiITFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:24:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A295AC4A;
        Mon, 19 Sep 2022 22:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvMAtvlY8cAcAQYs7xslzqcaSnqwVeRlNRoO+NBETCBtp/Q2chV1HlB/1zFCviJDCKXpO4h23dYngK8Dm1xAiqfJWqvIw+8IBPINGDT9+kndDXPHnBGAt9aXix3fgcS595dQDtA/49sPA7fTyGTnxEMlqZKa13V1TSQ1UHquwzREsUuw4b1HnK+DLHqTh7GeiRxyNheBaJzE+4W3O/9Z6NujJVXvtQV8V2PnSXglp0XEHU7nvZjn31q4iPa6GaP/Jeq3wJAytnfgYLpM4zmTGosLalcu2bXUExqKmUzWh3+8az6QdAiYKXKYbDH9vptGM+BXhS75797pRUp04P3tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH/cBkCBIAe7R45yR+eN4pD9+PKlfRsvpL/yWyFFx4Q=;
 b=PomMoRsowUEn9Jbpjs5bpyQkL37yH5YDJfO95oNwuBngG4mGcqPRWV55uSkTUx9AtqjMH2BtRqwlPJVt999DX9ZAr0mNG7WgJd8umKUA62In2gQqzXRhjh7zsbrSo+lt9DF/H67x0OOY1KNRncadEyZZ8cjP4z9gK530kOzJ8J5CsHCQKx6I9MgPGpe5bZGJuet+Qp3SaUlzhhwyOlSyhfx4D341hjRoKzV199YXCLEp/CpFFRrl4tzTL4N1mJ/Ucr87ZdDWHDRrOJxMJNLdbpmkZJFJ/5DcW+WAk50+INc15vG3RZG7ZzQp7uKDR0hZEsTlEBv8/XIvdAwYeD4GFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH/cBkCBIAe7R45yR+eN4pD9+PKlfRsvpL/yWyFFx4Q=;
 b=CKDgVC5Haa4qzeCp7ESa8kLn6lYkHklaZXilipY4sSHUGo4wxvIGk3fs3eG9kcCj2H+SzrXCRWSgV8zd3C9FzgdwLeW4dHFDMgDfn2zZfKtD+gCD0Vv3gSKW5E1oGky05eifFjmkut2EcfmDuDWuWvEHD0V8joUgOtrV1KRMKNU=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 05:23:05 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::94) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:23:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:23:04 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:23:00 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V3 0/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc error after resume
Date:   Tue, 20 Sep 2022 10:52:33 +0530
Message-ID: <20220920052235.194272-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|BL0PR12MB5508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3278e26b-c040-44c4-9adc-08da9ac83278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlyVftdaJAn9xeaP3OrUdGXIS9/Ip25vEwdRc+4utmvqGXnIh7aiJyvWPSxzD3YU6dR0gjZFr5vebz8On/EHdaK+2nRCevyRNWaiITqLmkWvwkpu7khQoz5qB8x+96sRuEkX1ngdvMvCKXQsdnpZA2O/aRwnK5726qc8hkGrby9NfYZuEDx++MyTAcOmyB3jDrf/VQODP4YhQ9LJnXCBT+dwkIslJmtPBsY4c1zREamnmA0IkyOESdb3Yuprbq+X2tNpufkDgzjuMWHZJj127iTdfjQbTa/xC5tSvcwo+hB7c2hE9RcAT0MEaY2RVeFfDZNVaR0PdXJiST3VsHwdAkvETPTs0YyhkkJTVoxUW3VFwuS6HuFThVlRXBlbFP76FqxfRFYSRT7N+0HD11zPpjuQSFtCA+phAW7MrmcFr4ADTnRejBaacW9vynlD3ZtOlpwxRiLA9iB7z5NLc1nAAExDoirK56t2ho+HJBrg+hbdDl7D3jG4lP3ylqhPJUISHM6au1gdiVMvuoPUIeVs1Z2bqUzSdgY60zqxIs9S2EnLrkU7iayiWMihkHbVFUXxPabpEQo1ymRCHt/pAoM3ETJSLEUQ+tU8pwKjWH5mUXRzHVNNHMlb9G949ckF8iv1dCbAd9w9vu4DI9XFyJrL1kWvozebdgBLO+Fn58DBI2+Sk6GtcamSBnUM79nUx4c1H+ZEd1fSn/wv8bhGHVwz2wZXrvz1A9+16ZeYfEoJjpD4DBitr0syiGQ+RpkFmIHnmuRO/lfXH/AQjbfmS+oRCB4ydzBR+gJ4Sdc2IILVcR0JT47ISnZQREdrdRW2GTZ8DvNaTi+A1IMpRC5FVGUtCj4TcFnE3BeKfcPKCB52BInSkLWMY1NEiU7RUITLTFnQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(26005)(2616005)(81166007)(2906002)(966005)(82310400005)(478600001)(5660300002)(356005)(36860700001)(40460700003)(82740400003)(36756003)(86362001)(44832011)(426003)(336012)(1076003)(186003)(6666004)(47076005)(40480700001)(41300700001)(83380400001)(4326008)(70586007)(110136005)(8936002)(54906003)(8676002)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:23:05.6310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3278e26b-c040-44c4-9adc-08da9ac83278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch of the series does the following:
- Add a new DT "snps,resume-hs-terminations" quirk
- Enable GUCTL1 bit 10 for fixing crc error after resume bug
- When this bit is set to '1', the ULPI opmode will be changed to 'normal'
  along with HS terminations, and term/xcvr select signals after EOR.
  This option is to support certain legacy ULPI PHYs.
---
Changes in V3:
- Addressed Krzysztof Kozlowski review comments:
 - Switch to amd.com with amd SoB and ownership.
 - Added Krzysztof Ack for DT patch
Link: https://lore.kernel.org/all/6499fa0e-3e07-85b4-0800-849db7c2593b@linaro.org/

Changes in V2:
- Addressed Krzysztof Kozlowski review comments:
 - Update the quirk name and No underscores in properties.
 - Modified the quirk description. 
Link: https://lore.kernel.org/all/e15168ac-b5a1-0c15-cfb3-34fb518e737f@linaro.org/
---
Piyush Mehta (2):
  dt-bindings: usb: snps,dwc3: Add 'snps,resume-hs-terminations' quirk
  usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error
    after resume bug

 .../devicetree/bindings/usb/snps,dwc3.yaml      |  7 +++++++
 drivers/usb/dwc3/core.c                         | 17 +++++++++++++++++
 drivers/usb/dwc3/core.h                         |  4 ++++
 3 files changed, 28 insertions(+)

-- 
2.25.1

