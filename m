Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5374ED9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGKMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGKMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:09:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3651B10FF;
        Tue, 11 Jul 2023 05:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apjuC5o2bnq5iNMVpbWg+1OeIn14p0gHYUYoV6bBdknuNgZhg1IfeCAAuCsA67exk94NMiVLwM2HfG54MwEd6Ql0PP5FiK8d6ivjnz5y1r9qeachSonf6YKwVV0+WfxhtKjSdqAHEli4ShKHj8NM5dElA65W5mS/aXn28Di3yWYi9XTc2wVUueCIPfI9/XEvVMAKJwGJhLLP8mIR+WBnbUchVisyr20Zxs+qCUOLvXLxob//v7P210kodP3p57f1IoJqouxZr2c7TsqAprtfzjKzIYaHeqQOJgi6YA0J5RPamMi6SOc2M56ABesxjwR7SRjXROcf9/z5krdPg5tpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUkrJZqLL/Lf3ew4XcsaIE/AEA6j2GTgQIV0XAQV32k=;
 b=bPll7MRxYHBBip4lGG/33AhbhbqP1qdML/DoGLqi4gS9OHJz56+KG0tf2tNFViPJamYDUEzulC8rDLbeIH+unr++cQKGLN2/so/fEpNkqeVuRZYW/jyUPOGb4eE3529hr2T/kICueh3YF1hqow+MQn/cM/TLnLuGyiNcaRMnubXu+zPKXTbG5OltDLMyirF+ZcVQCUrITPLYtUIQNluelcV484mOGVyIE5ev6lF9dOR0Ww39ATt6/7n2aCDfo0GgamlWjor8Ow3UxBgiDe/cWReR0xXUo9T4JVIcnWOxuiqgPydnDn+ZGzbnHZyRssBWCVkUCVb83Kri0rX2UpJteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUkrJZqLL/Lf3ew4XcsaIE/AEA6j2GTgQIV0XAQV32k=;
 b=l/vKu5ZzXtCc2iuQvLnhmEDRC3hOE2coxHq5NQh8cVSZVpwT/aADEjMjnKunhibWbg9rlabF7o2OX4+zNfNTvtvXq8pWBPg5ZJVoxLjgUeDLB34vcfPSgnL6hch+nh+x/G++NL7zaAP0iGSdJZGU/FHmz+mHRZudwhdMXORbHRVkd002vRzmmRbHFY/TiGT5K3rGP147beodPcnAOVcp+C0nKIFV38cQoM9cRfnmKKebzEc2BXoqYrpUA49rCYtrcTefIWythTiabhIzfso4n3STs0lXNV8DHjFEi1VE+wDAhi6hxtByuK68x3Et4xi42MuN/v6SsEdSRYrMDwCogA==
Received: from FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a1::9) by
 AS2PR10MB7639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:645::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Tue, 11 Jul 2023 12:08:54 +0000
Received: from VE1EUR01FT066.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a1:cafe::3) by FR3P281CA0094.outlook.office365.com
 (2603:10a6:d10:a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 12:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT066.mail.protection.outlook.com (10.152.3.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 12:08:54 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 14:08:53 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.237) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Jul 2023 14:08:53 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] platform/x86: simatic-ipc: add auto-loading of hwmon modules
Date:   Tue, 11 Jul 2023 14:08:42 +0200
Message-ID: <20230711120842.30044-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711120842.30044-1-henning.schild@siemens.com>
References: <20230711120842.30044-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.237]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT066:EE_|AS2PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 272a718b-c106-4e06-6b46-08db82079907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjXBuLOfbnBQ+zDkDsrmEhR1iE4+SO8cvgrcDpDTn7X2oFs69U8NMIosj5KRFRDIfOXgNvAdex6r/J3OxSqRFllCKEkK6EAE1exuR+JWxfeg3Icx33DkpEIMCSBYIn1Igy8Hyhij6weQlGuR0bI8YqJnqfAaTssQuj/o+uDJXsDml2SfeXAfzJ0Mh5g89uWvrfLlQNIncx7u/cyqNJclvGKO+jTO3Pt1zqXcnoQO2lfc9h0R7QVHDWEwVPxzV9ypvYRyd6lb3xDk8WT9WvwhDht1/n9KQ+mW8n0VPX03IQGdKdgjLGwlttROwYUsKXaCj+eX0Eb8wJGt0LnjoxGW/A0OmngmOHhP2rLDqBuNuYErMJssMjhyaouwgJxwm9oY+LTB/Ipz84bIsn3He4Exe62cPO8kT52aEJ9qsvwOHF0gXleOFdzHpdJJVXopkDeM90U1fUCvN513vyJc8DZecNVES2oQN51xn+fN8TN2p+LmU5TqU4WsVySZShjg+G6Ll/0nxymK4hkwL7gFmympzi/OnkAjaaovUv6xcM6EJr1+S56HFy5NpO1rYpbCFPQDWWp8qZIn8EY4ZELuRAIpbaKvR70BWe5kFAM6pIc/a19M98eDDEdM0x92oRHZ9RYeHXxuwse/4hxtd7hQrhTrujL32EQgzZ4NqHU5xjNyrZV6/Sg0Dl/WxWCtRxWN1pzjOBrC9hAPctmqyGT6VrQ+R5DZZe2iw2ITSY8248FUK+MG6GCKBcfikBHj6FAteswwQVYG6KwtY4SuITABqNbT4A==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(316002)(110136005)(478600001)(6666004)(70206006)(70586007)(16526019)(186003)(66899021)(4326008)(41300700001)(8936002)(8676002)(40460700003)(107886003)(5660300002)(40480700001)(82310400005)(86362001)(1076003)(44832011)(26005)(83380400001)(36860700001)(47076005)(356005)(81166007)(82960400001)(2616005)(36756003)(82740400003)(2906002)(336012)(956004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:08:54.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272a718b-c106-4e06-6b46-08db82079907
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT066.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7639
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to know which hwmon modules to load one would have to usually
first probe from user-land i.e. with sensors-detect and create a config
for each machine. But here we know exactly what machines we are dealing
with, so we can request those howmon modules without user-mode detection
and config files.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 71487216d33f..403dc231bef7 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -153,6 +153,21 @@ static int register_platform_devices(u32 station_id)
 	return 0;
 }
 
+static void request_additional_modules(u32 station_id)
+{
+	switch (station_id) {
+	case SIMATIC_IPC_IPC227G:
+	case SIMATIC_IPC_IPC277G:
+	case SIMATIC_IPC_IPCBX_39A:
+	case SIMATIC_IPC_IPCPX_39A:
+		request_module("nct6775");
+		break;
+	default:
+		request_module("emc1403");
+		break;
+	}
+}
+
 static int __init simatic_ipc_init_module(void)
 {
 	const struct dmi_system_id *match;
@@ -170,6 +185,8 @@ static int __init simatic_ipc_init_module(void)
 		return 0;
 	}
 
+	request_additional_modules(station_id);
+
 	return register_platform_devices(station_id);
 }
 
-- 
2.41.0

