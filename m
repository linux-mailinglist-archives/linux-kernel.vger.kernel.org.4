Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C086F4534
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjEBNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjEBNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:39:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954A6E94;
        Tue,  2 May 2023 06:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxKZxVMtsbg2u7521a3NSFzNxt16VpMK9wqQ0lhjK0PIwRjDhmpsbOJtsBlSqUacjWL8yQLKId68k0dMJvTvnlCltcocASxFgD43ZW/gtqNKM04anpjelM5e2njDGiXX5zchPDJcp5huk92REbw1XXDGmPE6Wz2tkf7/t7REPZ98qHCckdhAk+fnvySDj6PzVxYuKMyo4IXuS4wVDydDhidsFoS2sIfxkzKmIKTIGwNa2gBjbBcKtouqSSvBhaHzrcxJYEsBkeYKhVExUIBo5qIGgfuHfGHSOSY9MHNaxqVqtRv6GnqXCIpobl7eBntoNYz8sT83a59vJU96NT+Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EfsS/5i+Z1WpYHE6AGUyvlsJgPv2m+lL8IKcxVM/Ts=;
 b=lEzDuJ717GYLNx/iEwLXN7cK2zQcMSabfeyxjB/xDxPRbdaoR05ABWt3z87PLnzaQl5tCM2BXEjsYMN4JMmv4lLECHhanSsyL4lo9JXvrq0dndewc+oVAUdvaS2HS1+VazWrzRcqH3wcHr8wj3ZxSd3FyWEV5Al/5RtnS+LjG59MZ4WuV3wn/voR+DDmfmX1ZKlEK90odA6b4DSswHWuFP6nR2R89NB8U0m/kQ+AapMjDEpAbM2jTOOgcZpPDBLwHuVPgKqPRA4oSWcCw/1enhplf55IMY8yhitVoDN/65V2x237G9pEKPwc0eqXvi5tZ5Jw0hBA44GvbkR3dtQDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfsS/5i+Z1WpYHE6AGUyvlsJgPv2m+lL8IKcxVM/Ts=;
 b=yLOxOef0bZN9lxV6fJs9kQQfkmnVIMOtLOdOZVsSjFGT96zGLi9ncGvktv2VOHZP9BFzutfsII0ddIs09KZj1a90rwyxpqC3WUK6OlpOMXUuNwfkT/qLqTzhmKaYJsyoaJCD6TxeWoUFMo1MzIuB6924ZvcCg6wPXxNwZv6n8jk=
Received: from DS7PR03CA0277.namprd03.prod.outlook.com (2603:10b6:5:3ad::12)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:38:38 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::9f) by DS7PR03CA0277.outlook.office365.com
 (2603:10b6:5:3ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:38:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:36 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Piyush Mehta <piyush.mehta@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 16/23] arm64: zynqmp: Disable USB3.0 for zc1751-xm016-dc2
Date:   Tue, 2 May 2023 15:35:44 +0200
Message-ID: <ad019501a851c5730427af948b636316f10b2e3b.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c59c7a-65b6-419d-7393-08db4b128948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CfmdKuvMRcEndZ7qp0C2WxZEOcwhP1xeqbgQEMZ+e6WJN55YXgf3x0B1VAT4+IfG59rk43nf0zK7NCTzSiMaXeBUssZFFpdFTaMFmiV+Ev+SaRL+bqAcXv/ZV3c/nGYVe3YaosP/opRRwHXbZlwqQjnBzMlbwqVPpj1nyDCTPridX1TAm2cjUkRUa3HYb0tz6klWh9dd/7OVsYAGyhUI92fichpAF9X7KSfeK+zSeyc6wZbArL0OQahFUqqb/yYM15mKpAJhC2LhBRuFszx0bYoaV+f8IOi7j/N8VnOwj1Bo6G/qjlxUo7FHzy8aa3qHA0Bg0XgokIM/R4KKGsejALCSHxuxpfBsAtpA2E+xDeHCKKb0QSoBhVHsfTgMMoQ871QNNhPoaYfo3BPheS9u8zHw6gZjEpDuJaJuPhqPeLvC0Xa6BEQi7tb4vYWZqo5nSFHz+wwku4Vz2Bud8+pQ33/DMAGvUZVC6e5Tr7tH5GovmFnjfT9i+p0GoX8OUtHVGA5RunwIMTXga9PZ3jJ31I8dZb42EjFHkqZla4+wF5fZ6x5LuRaKcpg+w0BHYMufWkUjg4zqXSmwhVEBfvFWt7l8D4spX10I+EVLB91csttSA+x7CJbG7iWof3QCcNTyt06SE9kRQQMrRgEkZ6qL5qRDn2o0BHEd6suDirpPjcnPtfmXqR3i0OIUx3X4mj3WniZApDbW7uKTry3LF+PkLQkM2wghZ7KtiogfvfIr68P1lmm1BcSE6iWcIfF5xKv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(83380400001)(47076005)(336012)(426003)(26005)(16526019)(6666004)(186003)(110136005)(86362001)(54906003)(36756003)(478600001)(2616005)(81166007)(70586007)(82740400003)(356005)(70206006)(316002)(41300700001)(4326008)(8676002)(8936002)(5660300002)(44832011)(40460700003)(2906002)(4744005)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:38.6997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c59c7a-65b6-419d-7393-08db4b128948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

The board zynqmp-zc1751-xm016-dc2 support only USB2.0 that's why remove
USB3.0 DT configuration.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index a2031187d9b3..9e7564235b69 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -489,8 +489,6 @@ &usb1 {
 &dwc3_1 {
 	status = "okay";
 	dr_mode = "host";
-	snps,usb3_lpm_capable;
-	maximum-speed = "super-speed";
 };
 
 &uart0 {
-- 
2.36.1

