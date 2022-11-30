Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FAE63DABC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiK3Qff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiK3Qfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:35:33 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4154AF0B;
        Wed, 30 Nov 2022 08:35:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRFZ+xjD9e8toJdBNXbE4PKe1eBD7yL9fzTuCd30/GVzVGh5Ad4zImZRpHm4n9mySt3qSjm6F0eV8h5bL1NZ2zlhAD58FYUIXXnnykwXUDXCPDVkWOjcwzY+Uvt553OSJ3y8zTUfuJvqx7hxCW4zWH4jItZ+rPsKX7TejeJfL93k3B6oYR3HVZvd00DaH/9VB5Fa+NzzmO19uMpIdE6BeeuA5slEtFMSoqYW9Oc90Gzu0gB52OR4XoPjjo+w2oVP09zE8wj8yy7Kdn70Gc2iPDI4as8etO2hR8FwtS37Z25T+doCZ/l0KgDHll5G7yonF5QBBE3WysWFTsclITlW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0UzWaJtJmPy8cZMVj8qhRjOsoGj78bI0g28hMxk7H8=;
 b=WI6ne55w1BMYQomEIARdk9k2qxJ3qbORB2YPGNiTmP+3NphtTxXMGKb965ainTlWffKMxvQPTJHCkdmnEaiyWk0AvIo0DM+zVrI+AKP/n6AgykeCG61+wwpXvf9C5m736TgqKtHNreYXsK3c92ayRnGQKGmWOZxO/NIjGlm6WOlkbFSEb6vel5XVHO7u+TW3t/6GC6E01HtQ96Cw/ZHNiIZVJdMLoMEYpZLhoKYpCYbZI0rCWUxBqYtaOqJHHMP9bGeeWIf2oBr7MwxaefAwkMXxZkBzCdLdFfoNSdbkczcWmjmxPOiGO2N8T3q/scE+dScifTQ1/XMuH1LSLWX9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0UzWaJtJmPy8cZMVj8qhRjOsoGj78bI0g28hMxk7H8=;
 b=BCiVdaj3tXRpgHjUVAOD6PXOHr2xcIs+1v0aTTKbydJss/ErsFY5cVcxd3ktRY2bEavUly7rFFYfu8y/1A0pchRMPre+9kD2e+t1+D9zvY7ztoTm27CCqUekiIsavZCaq4MTf3QkjsMMFRkhJHjEcV53A3/byc1Dtob1wp3mq3U=
Received: from DM6PR02CA0149.namprd02.prod.outlook.com (2603:10b6:5:332::16)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 16:35:30 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::93) by DM6PR02CA0149.outlook.office365.com
 (2603:10b6:5:332::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 16:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 16:35:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 10:35:28 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <frank.rowand@sony.com>, <geert+renesas@glider.be>, <afd@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Rename overlay source files from .dts to .dtso
Date:   Wed, 30 Nov 2022 17:35:24 +0100
Message-ID: <a14e9ec0af23eb349372fdcdb534d83652b5a449.1669826117.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|BY5PR12MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5c6747-f902-4ff7-d7e8-08dad2f0e499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LC3aHw1FQXEt0IzS8siPSaDR95WkPPxyE0pD6iV5Hf1lG6NfN9JKj4HUylwLQkXrLqV+H/fu9ZGbbzdl22/cEvBr5nxkqINlQcEkbql34G9QIvZZ8N/F32iS+R294uI3fKg/Y+YIwLSNdUWS6dOfG7ywxMDrMD1uNBp8E878owoSrtispSVsYKuh+DzTp4yWSqwpVODEzn4BfrwefsV/K6Yp3aJgv99HMs8ArJZ64AUei9bTN3NCgCZpmuKkdQFrzmA/4LcpHEBKrpEgIakcYJ63VGSlOr7pLMtvAI7zmH4dqD0DXI94g8AnN5nqpYQLFg0ED1jX9cReXp17B8xapSMId+EfJRDUpjXifExPHsryERVjFCdEPFqCvVPPJJ2GvyMGrad91wgMdWHjvRz9Z/uzN8HpUSA9FugWGMRjLpjkKz7yf6W8AGyKjmDvHJ9B7mgMHJUiDTYb7rKWELR83TDp/80yRRbBslqB2YkEuPkk8PXrspNx3fiA+MJ5TNY5l4mpbC2KH3DLQOw4c4z0RjsUVQ01b3wh0agIO3JSATeJXchfC3bXYR2WCFRVO+xuG9l/PVI7n9I1W7Q/6NlOiyW6cBcdPqEhIgmuozxf1dl8hUGHA3Qd3J8CCNao4aFA5p2yVVOea7uX7Bczb2FVpQYMDEAA9TPhzpK5NjRzlUF4kyoFlVHwRbDBI8qmyiVEpmn1xzwSbqzKcA+46HjRNCB/BcHvovlz7ZMUzTkbMxGYm8Z5rFMRy1ohFzwvrMnnoe+3Qep/LphfzrMR7UL7IWmFjKy8WiMpGSRLUFxDNUY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(81166007)(356005)(186003)(86362001)(5660300002)(26005)(8936002)(41300700001)(8676002)(478600001)(40460700003)(2616005)(70586007)(336012)(6666004)(4326008)(110136005)(316002)(36860700001)(44832011)(82740400003)(2906002)(426003)(54906003)(16526019)(47076005)(83380400001)(70206006)(36756003)(82310400005)(142923001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 16:35:29.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c6747-f902-4ff7-d7e8-08dad2f0e499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on commit e87cacadebaf ("of: overlay: rename overlay source files
from .dts to .dtso") and also Kbuild changes done by commit 363547d2191c
("kbuild: Allow DTB overlays to built from .dtso named source files") and
commit 941214a512d8 ("kbuild: Allow DTB overlays to built into .dtbo.S
files") DT overlay source files should be renamed to .dtso.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}       | 0
 .../{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}       | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
similarity index 100%
rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
similarity index 100%
rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
-- 
2.36.1

