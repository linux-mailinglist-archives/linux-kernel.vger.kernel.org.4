Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2436CC986
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjC1Rn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1RnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:43:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF08E394;
        Tue, 28 Mar 2023 10:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlgE5CdSUd0l3psCCiutvZodOBrzAXJvjaZ0w1jQkEyBuwiwS9FvWlQqqDlnBSTPBoljXMeNnSTBT/LdbRKJumBMwa4Slj49fDv7JBxlNCECGSfAGRlpsvjLJXDMrY47/qaRzqwgi1jg6X2nvfNeGbdEmO2JquOgLEipysrvOx448d8VjJeKv3paQZ6FVe8LU5LG5g4UMp5lWQp5uf8BQK+Y8qePxPtYlK2yGgd5ZxFm3G8E7MIccE6Ae0IGbvbL1bhFQdijaKlZk4vgj3X4X03kq2RTkVKtFjcfPnYE1hSC0mDo+O6K2eiZMFDLqAWkEx76l9lgiArLXH1HdEaemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhY/rlU8RYv3+aQouIv82ntGhVizJZfeuwcxLTA0rtM=;
 b=THbXCvFTiRTElpG9DKwUPOo3e2E3kNyPqnuI3mPukDmINIRAK8bwVAUaQSVjZPaRJAtbftKMdj/jLbXwgzbw0nU+6cjevwy34V3z20unKxqbn3ACW/Y9lob15vMWcWpOmZxQiTyWYCW0HjLGJldLGT19ITV68vV0IZpP4wKTVXYfU77XrxlTNMU1va5Pg7scUsgaBppaervgJ23CrZjKYYqevOWgcuc+lu5rT6YuZ9NUjsjKbkeG1u1SyMhvXp2Fh9I8tit8cXa+o2BBdHNk4KvReDM2KhRrdv1h0KXhcyAE9NUOfTNTPFrYfoaspObIvgHOj5jQbqCvRGwDyGHtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhY/rlU8RYv3+aQouIv82ntGhVizJZfeuwcxLTA0rtM=;
 b=sUc4SeGdvQ9tJfmiOjaDyJtiSX3kz8ue5kjJmvHpCtknGDqCjflNb7L2K4pcivmxuvrOttyPFp9tH5PPvcLPJAUbO79uaOoi5NHV0RDmYID1H7s2TjAXnMr9yZHFlwHmwQXN6rv6TCKqAk83gGfsEu/GF6aenSjIcPvkcVOv78I=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 17:43:08 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::56) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Tue, 28 Mar 2023 17:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 17:43:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 12:43:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        <linux-gpio@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] pinctrl-amd debugfs improvements
Date:   Tue, 28 Mar 2023 12:42:29 -0500
Message-ID: <20230328174231.8924-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 015f775a-88fd-43c9-c03f-08db2fb3e4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MypF3BCA53D3YZBDncC9wlpul2rPBqHxGfDmEtPICNDF7ld6oankR7DmM/5psfQYQCTB67zUapgpaIifhKMRoFhvNsUk2wQ83pBealuQLY1YFP+Z3PdojY1T3syRlN0xlO/eQGVMKeL38DvVaegcfhDNW5SPhdKaT0L66VIAxt7Q+3FGIToXpq5ES4I3KOxlEsrMtIuW/5STMGc9MCNNYb1zniSAB3abKaDBQMkfICX2G5Q58v99VkQyiGMAznlEFAJzbjQjdETJW93Xmfpc0XAoVZRBeu+TePkeJH7a+vYZhrg8oZPkbN9kfEJaykz8S+X6qgHkuppj1n8aWQNrF84cvia5QKAjCxt48ooxBwOXMymBugJQ+0vCpNTDL42v1F6tcNHRLZgcd81OxEZE1TYR0i2RRPC8nanOC5Qd7mlk8/Y/QZyze0VV9qhIn6gPT/e7q77El1ZWmBaJ7foZXbilYFljcbSKbpJ64Gy4icOi25iSDV75RWQ37hozTJP8LDq0Z0KyhoIrG1xO2LWgbu0njmXjSyGwcgiKNLS7rKQ/VJH5lBdi/zCkgh0wBiHanLsJ7gqruhO8PJaWKSZgtaAdcHh0QlIWsq7DIRwzDOQxby7jJobXax3xPAfJeT4p2PN9L9QRgDuFDbQUwIpD493IGP1BI8hc+EXceyoMESgkMhY/BCKa/suavw0B2vVYF6NrKttuenGbUEGpW+zb91uenZQPkNbqnvsANarCDHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(336012)(356005)(8676002)(450100002)(5660300002)(7696005)(40480700001)(70586007)(26005)(1076003)(8936002)(110136005)(82310400005)(54906003)(6666004)(2906002)(16526019)(44832011)(40460700003)(186003)(36756003)(83380400001)(82740400003)(426003)(47076005)(478600001)(2616005)(316002)(4326008)(86362001)(70206006)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 17:43:08.4761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015f775a-88fd-43c9-c03f-08db2fb3e4bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging an issue recently of poor residency in a low power state
concluded it was caused by GPIO controller misprogrammed in BIOS.

What happened was _CRS was missing a configuration but device was
trying to assert an interrupt.  This is found by interrupt status
bit which isn't currently covered in debug output.

Add this and also the similar wake status bit to debug output.
As the display is very busy and growing long again with so much info,
adjust the display to only render characters for relevant bits
and to now use headers for each GPIO bank.

New sample output, including demonstrating detection of
BIOS issue (by 🔥):

gpio	  int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg
#0	   😛|     ↑|   edge|  ⏰| ⏰|     |⏰|    |4k ↑|input  ↑|b (🕑 046875us)|0x81578e3
#1	    ∅|      |       |    |   |     |  |    |4k ↑|input  ↑|               |0x150000
#2	   😛|     ↓|   edge|  ⏰| ⏰|     |  |    |4k ↑|input  ↑|               |0x157a00
#3	   😛|     ↓|   edge|  ⏰| ⏰|     |  |    |4k ↑|input  ↑|               |0x157a00
#4	    ∅|      |       |    |   |     |  |    |4k ↑|input  ↑|               |0x150000
#5	    ∅|      |       |    |   |     |  |    |4k ↑|input  ↑|               |0x150000
#6	   😷|     ↓|  level|    |   |     |⏰|    |4k ↑|input  ↑|               |0x8150b00
#7	    ∅|      |       |    |   |     |  |    |4k ↑|input  ↑|               |0x150200
#8	🔥 😷|     ↓|  level|    |   |     |⏰|    |4k ↑|input  ↓|               |0x18140b00

Mario Limonciello (2):
  pinctrl: amd: Adjust debugfs output
  pinctrl: amd: Add fields for interrupt status and wake status

 drivers/pinctrl/pinctrl-amd.c | 90 +++++++++++++++++------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

-- 
2.34.1

