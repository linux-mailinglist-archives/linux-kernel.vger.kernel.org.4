Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C385BCA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiISKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiISKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:53:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C40FE4;
        Mon, 19 Sep 2022 03:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBwBp6qdBbjWiVuDCPpn+mo2BvUn8L118pMiBZo5ykAItJPoFiJMykFuSvOHsqXnv7mjFg0GGFo5ooiE4RhGb1VCOoE+EJG8taNFf2ik1WvBeafc5BFO+fKPYqtWuOqvaIrMpSoWgDXIFqO6BajttbqUrVu+/WRej+iMI60E5ofWebAjGNXZEF7WBYNYAXAlp1EgX5BIe2rz2jTALpZhRVPofvDy/Bi2t3UQs7rrV/ZKJJzVwC6SBRp4imqDfqY88ZqAAAsmohEkGDcjRPkV6EzR9bw2wGhzWfrUCd1VVp4ar10EJOPA1J0k1ESvpofh502caEzNd6X/65BkghSJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8zF2PJbLGyl4PM+bzOWdXv0wA/hE58x9+YwIKwVJV8=;
 b=QFM6zIgq72/UuGGwRzdcyZ+t5TUddqZYfyD6/sZ/eki2ytVQ5j0aFUzxoo2jveouIvMLWQ8HrfuXXKPRTsyAsq4s9UkXp1CrtaMnYvWuTuZaGQjebVaSxyyOeQVur7Sj/yEg7IQQs/lBypK6+ynm/1XZqOWQGtkTD/yTd5eFyOBEUTTiUvffFa1YR6nufQS14vAvPFt8QGJ3SFwpWPR6KjlHxDZwuhKNaq/nSVo7bjtkEIqeRat92x8ZR7r0NZanpmf+IsrJOIXjWBN+6otEuM8Yh5KmwcsdGCCcJzFyBn2BOEKu2hR8R67q/52pFgl7MJRQRxchm8/XDNE4JXb6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8zF2PJbLGyl4PM+bzOWdXv0wA/hE58x9+YwIKwVJV8=;
 b=S/oulKYr9Na8g3UukXqJM8Ke2zJbFGLb6+bRtOY/C9IrUV/tA9V8W3loRQ2QbelQLjxtLvIJShhfxxAtyY00BmRljaKCOdCF3rG+BidSQtvpswyy0wiFHfv4LJEYw+NRqUSbx9aZ+hI3nj1RD1aXHevBJJlSwdBenqHn12kHt20=
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 10:48:51 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::24) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 10:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 10:48:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 05:48:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 03:48:49 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 19 Sep 2022 05:48:45 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 0/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc error after resume 
Date:   Mon, 19 Sep 2022 16:18:14 +0530
Message-ID: <20220919104816.4075019-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3033c425-d975-430a-41cb-08da9a2c8a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1opQccCqaS0fO0g77uw/o14dZAT0PCsdRl4vIni85fKT5AeVmg5NTpFtSf+x6Vy2laKlqv7Eu90OvkUD+oEzcvNg3cC1uT6tNvCDsP5eWa3a0LqNGEJ6MAcg5lZmZrMwZCEaf7SciV7E4ZFaFCSdXF3PycAH97fC0IPW3tX86Egu7mtKqy9MVdHzsVBJp0RBDHuFubpzlGe2kfEEekfv97Fyakxn3i3d9zffCL5dg9mV2mY2x88WF3nVy3O5gz811E0xGGfp5Zx6txpEIfOPo64Ab86pfGkCia1wMtRhbj5zJuAFP9nsvOM9srowKXVMVMz33UhvbD6g2lUVXctINMZdGkycUrxFLBFCfcOpQ6rF22iYiv8i0Kx3DchC19HThsgp/oOe3TqgQ9XdD0eL2Qjwh0oPEMZrw7cjetlyaAuevLkOWh25+fCP0D6C34WOCnbmppMOqLnyH0F4pbr9cQ7KZvTWnZWwTsfOJrkuMQaqRHIBUV0+m/mtaNCiDNu+BiOktFkQ0yMu6klx/6tx4vuR5vNFda5+2Ds/fVfOzr4Xyfb5A5NleKtUN7T0oYAOI5O7MmP7tVe0F8IZtTWALzuR9+x6g6jAs8IHtitiOMIihjuOTcv1JzVyLAPz6do5rGtcIgoXvgq8fUnmFZl9Xpze9yTOa+ah/jPnuPDkdVNvwTV0MrB/7YU23WCTpfCQ3Cp8AbIp6ga312DmHBgrK2EL6I72XMxCUM5xDV7oJVBD8nBM9P9SVGShms3NHa1gykscHu91iTNixQcswor925mPO5C+ebqJKqmfGq6N3B6nAs8mAJTB01ocqQmduWxumsQc3tA2/V/E+pLiRRlJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(336012)(426003)(2616005)(83380400001)(1076003)(186003)(356005)(81166007)(86362001)(44832011)(47076005)(36860700001)(5660300002)(41300700001)(8936002)(4744005)(82740400003)(40480700001)(70586007)(8676002)(4326008)(70206006)(82310400005)(2906002)(40460700003)(26005)(4743002)(6666004)(54906003)(110136005)(478600001)(966005)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 10:48:50.9769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3033c425-d975-430a-41cb-08da9a2c8a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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
Changes in V2:
- Addressed Krzysztof Kozlowski review comments
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

