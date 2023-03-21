Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642046C31D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCUMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCUMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:39:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01F3A89;
        Tue, 21 Mar 2023 05:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MawnTCdOopxh4mRgpQWW9QEgwEhHfdHTB8BqZtK6iHCmkfxvNxSU4fUdT7x5+Z3ArGIOJm6lNzP3SZrrmhYe6bKujA/SPJDrNszoBK0s7W32PJoUNwPtHHd0zZjnozNUbq1MXGaGcU/RAtYsAxm3ekniDSvy/WRL7kBgWtwuwEIOQHb3rDjn7EOqLVEgX4N1I8uym7A9AnXD37q46m5wgmjs3ifI53w1JQzKVafTALOrV4CfvWyFNsqYTg5ynTI4N3GkafXnAot7agFDcmrK4E73U+lKB/Oi68fNjYz+G/FJIbhYCc0zjHUaGGVoU12FTKtaQa7xdUYiuPVSidVuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbRoW6+D7/O7l/79tpnWPBKbEQ9EHSjRvBSvgdbmFG8=;
 b=LpfRstEfNxj+qaxbwFmWtItxxfWJNBjMGmlZSp0kvpUKdrvXspxZ9WSR7yRSdrJqvg8g78lzgJLuwwgNam2vp+GAhiW0aiO9dpgeoIKlYCj9DhTjgRnSPpGkubPo5UH2U9GD4lXqBpT24UFItyZW4iYZ3Nvti9MYzflw5D+dqvS1ZJ5gfNQIOPRdM5i7lv1SdvShbufvpDVbUAaiQz1LkHM8UNWEQVv5Vew4r0Z+R+9LhVmSGamIVNrHP1yPnX/gtNVhWoeiTlhKeH8TIDtKYrWNhbwSMpoDDBZQ2Luqs8CoRKVS95dUluXBsVRK8yHQmNX7kV+H0iL2NiXaJaDFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbRoW6+D7/O7l/79tpnWPBKbEQ9EHSjRvBSvgdbmFG8=;
 b=t0nRSzOhO3fK9aqHvZCTlQM9ZuWEvKbXrqfXIny6Ic+2nalw2vqq2giilgIIUsZ89NDYgH1XIQl2LDlM3ZZZetGxpJq79ziyps8wamkhnRGEVJIgAgt4Fnr0WIty8ogWBr2pZwUUZbbE3C+lA6w4InE3zxD9PSoRh521o3KTV90=
Received: from CY5PR14CA0007.namprd14.prod.outlook.com (2603:10b6:930:2::8) by
 MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 12:38:44 +0000
Received: from CY4PEPF0000C97B.namprd02.prod.outlook.com
 (2603:10b6:930:2:cafe::c5) by CY5PR14CA0007.outlook.office365.com
 (2603:10b6:930:2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 12:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.204.84.17)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Fail (protection.outlook.com: domain of xilinx.com does not
 designate 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C97B.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 12:38:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 07:38:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 05:38:41 -0700
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 07:38:37 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <robh+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <davem@davemloft.net>, <kuba@kernel.org>,
        <steen.hegelund@microchip.com>, <bjarni.jonasson@microchip.com>,
        <ioana.ciornei@nxp.com>, <likaige@loongson.cn>,
        <harini.katakam@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH net-next v2 0/2] Macb PTP minor updates
Date:   Tue, 21 Mar 2023 18:08:34 +0530
Message-ID: <20230321123836.6906-1-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97B:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b58eab-539a-4c00-b0fb-08db2a093422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDxxiNC/XmAXB+1x+ZLPQZEsGr7oC/eisATrUZcmUk4blCYmMvl2C9tjHX+hakIwTLQKSoMPxFYAgoBjSf7NV14BcwJjeGuG5bFV9U7YvDZZrH0llupMPil6tAjHyAj6dZl0JpNUG5fbw4AMAJUeQQw04xhX1BmsGn0ufY9ceE3m9F4Enr3WCsdSzUOdqkIl1JEQXl1ma9Ki9s9w3SEk+QPojWhHuviLSrMROHui2Xr4yPek4O+D9Pt7p/BV/yLrKLQZNj2Eua4PO3GNiOjWdPFqlYdRFVOgxFd0KnoawPuR4QcoBnsvtVHNk/uRu+t3Fpt3O/8Ga15JQQhPJpUdExC2HEWvCF8CMeGKjS2fOh65qy5ptYgoKsmLur7lpUms6d6HarK+knpETcfnZlHj/ky5tdXkivNlsuaGUyMUQn7ZzCWwJQENmurYInZ9Hh52FTmv+dH1nj2W24Jmb0YTt9WNivipIfDVJXP1w0gnlnqYTazMlcm17l4CiQaR0OCIQ9GwsU6JdiJMMkXdu7DQ98SXUnn51ENd6mYKgcvL+W/PiJv6igTHDZemQdNdNfRoGmhVnCzcUi2I4bRcJ13iXl+qV7wbm6X/iJw30drpLF5fJ4WSb28bGaFrbiXcrn0ff4YzpDUfw59PfE+jPRu6jxg0k7idr2ozU/AF7gPQp4CX3nW/6i+OTtVqgmpsFgJUIwW71tOKucXFXQrF7gPRMaS51honc+Oq9IoPlkLcVr8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(2906002)(5660300002)(15650500001)(8936002)(2616005)(7416002)(4744005)(44832011)(36756003)(40480700001)(356005)(82310400005)(921005)(83170400001)(82740400003)(81166007)(426003)(35950700001)(42882007)(336012)(47076005)(83380400001)(40460700003)(8676002)(4326008)(70586007)(70206006)(6666004)(110136005)(498600001)(316002)(54906003)(26005)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:38:41.9560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b58eab-539a-4c00-b0fb-08db2a093422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Enable PTP unicast
- Optimize HW timestamp reading

v2:
- Handle unicast setting with one register R/W operation
- Update HW timestamp logic to remove sec_rollover variable
- Removed Richard Cochran's ACK as patch 2/2 changed

Harini Katakam (2):
  net: macb: Enable PTP unicast
  net: macb: Optimize reading HW timestamp

 drivers/net/ethernet/cadence/macb.h      |  4 ++++
 drivers/net/ethernet/cadence/macb_main.c | 15 +++++++++++++--
 drivers/net/ethernet/cadence/macb_ptp.c  |  4 ++--
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.17.1

