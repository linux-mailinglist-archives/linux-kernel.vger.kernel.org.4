Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F66B11B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCHTGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCHTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:05:39 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE9D5A62
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO0vrueUqqzXO5TizfTrul5Wnl59cF7BkXYVZh4ttUU=;
 b=mviJigO4/TuZyIxxYk72hy1mh+TD7Rc/HpLPegLcHvYZJ3tY4oZ7GkVejPFVpMPuTfraHZ0fI82XcwEk8Xp2mvEgELBEpcNwaMsYgZUWpub5bBoYCIQfT79iePhnRhENEzbvJeJ9KKGNTFvXGqNax2PJWxWKF8C0kwFzgWlcFZI=
Received: from DUZPR01CA0284.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::22) by DU0PR08MB10368.eurprd08.prod.outlook.com
 (2603:10a6:10:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:04:51 +0000
Received: from DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4b7:cafe::c) by DUZPR01CA0284.outlook.office365.com
 (2603:10a6:10:4b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT036.mail.protection.outlook.com (100.127.142.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 19:04:51 +0000
Received: ("Tessian outbound fcd8b5fba459:v135"); Wed, 08 Mar 2023 19:04:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e1273d90c2df332e
X-CR-MTA-TID: 64aa7808
Received: from cf525201d89c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 12CC331A-A4AF-40F1-ACCB-2DB6AD3AE8BC.1;
        Wed, 08 Mar 2023 19:04:44 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cf525201d89c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Mar 2023 19:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE6g3r2aCNSl6lMSzBdeoRCXRNxOWkfKN0V0DjRs7cezAiVrqDsgAW5KEXhDd0T2ZVZFUM5eIIOnSlG65QykJTR0b1IB6H6YNHZIJcg0pwtRyrnLrWqhN9H0YVRJ2dVjqKHi1WMmuP6Le81sRjaquXaKhEk0DLx9TDitnwlbSBtpMXSaBajbeYZa2GAohX8U11iaPkEFsKOWto8z9jJj8nzQ/mtPrqj0c9dM8LDkSd5RGo5V/oHarsYS5leIFzCiNgNhLHTs0y05j8SN1m9DYZTTAuV0H/I2C26uEoBL49G8MIoSKyjhM2MbEO4HZH87VGmCXBKZ2rct2/fwSLCG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO0vrueUqqzXO5TizfTrul5Wnl59cF7BkXYVZh4ttUU=;
 b=YLAxYPFGiByt5iGEnCi0+x7lUJ88rcemn5Wnu8QF+k8e/4ZELG6vmr79vT+9nmWQ+LMnjFQH7CRbXPT9gB1LIRPBNWffXzE2cErRtCytTVmWeAcsNBF6ohKx3op+uXnAFbYaED7YyokyLpqXd8h/iXqvcBYofOPgx4j815D+5B5fAaM0hQUZu7tAxEJo7afyUWHCSucFWTMijljn84lnzYZFb7Z7EfRxNVXuosSEpxtL8+2V1rs9j2rUQbj9uC0vWx5mOGUahncVZpytLZUExAWNT355lbCzsXHBR5Ie0A8MEXjjkW7Iy/uqafBTD+5ZmbhdV37Xbo7Mb/ujIW4sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO0vrueUqqzXO5TizfTrul5Wnl59cF7BkXYVZh4ttUU=;
 b=mviJigO4/TuZyIxxYk72hy1mh+TD7Rc/HpLPegLcHvYZJ3tY4oZ7GkVejPFVpMPuTfraHZ0fI82XcwEk8Xp2mvEgELBEpcNwaMsYgZUWpub5bBoYCIQfT79iePhnRhENEzbvJeJ9KKGNTFvXGqNax2PJWxWKF8C0kwFzgWlcFZI=
Received: from FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::20)
 by AM0PR08MB5395.eurprd08.prod.outlook.com (2603:10a6:208:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 19:04:41 +0000
Received: from VI1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::b0) by FR3P281CA0048.outlook.office365.com
 (2603:10a6:d10:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 VI1EUR03FT019.mail.protection.outlook.com (100.127.144.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 19:04:33 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 19:04:27 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:27 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <nd@arm.com>, <acme@redhat.com>, <catalin.marinas@arm.com>,
        <izbyshev@ispras.ru>, <joey.gouly@arm.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 4/4] tools headers UAPI: Sync linux/prctl.h with the kernel sources
Date:   Wed, 8 Mar 2023 19:04:23 +0000
Message-ID: <20230308190423.46491-5-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308190423.46491-1-joey.gouly@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: VI1EUR03FT019:EE_|AM0PR08MB5395:EE_|DBAEUR03FT036:EE_|DU0PR08MB10368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd9efac-e355-4d69-7a18-08db2007fea7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qgzQoIFkQd6NohS+8iDtn9lF+wfcdzWtgFFZNtLtCLFF86D3Zl1TBa9EQ6MlzRg3KjZN7VXMg67WxxrcDsinHs8v1WpIJjAC75yV9dcUy+TmUqY32wkUEJVBlQO+Us3AlcdS00MSQGfVpBgWJk+P+7UaH9Z66AXgW0+60i2D+TNlT3QffVfGYuCFuA3XBLL2QDeSYgcSd9ZXuwMvGhT+S5g0vmSJjdVXjTLT4+mzkM+tawfLI0KjWJOomVlAnQ3h3rFg6y/kzfGQaMUfdf9sh9ULWZzPGUR71hUqU8SfShyN0+t9otPPc8Eln7zcB2pHCijrXSb1G5bU/LFLElOxcp54CXAkvlm1CJmG+cbxDaUnEMi3gfl5FvvZgGP3g5ZKoKxsxmgoYinz4hvGgmtkcrXdWb6AAcPZ0YepNAAkGPLw5UzTsKElJW0iDxJjaozExOT0i5S/H727EDJIRPmgScYgei/rYiUh+QkGlv2s5enEBGU6VDbuhg8kIYqOMPkOD95fEhSWEwZysMMCE/UcOmFqeDwAPxb/Q70adIYbkH0K1TzvmawaPKNmur05fUycSL+0vWUeM604raMO+s19tZ9uxsU9eHoD8XkHR0a67biNLqCgVkwWK9/u0EDXcei0k8rRkr2bJjT8CXeQlq8qqbVH+dMiUbESlJBhOYSNTsGeP+yd088Um78DUgOO65FHiMLFgc3nQL5zjXi4uRGgRmyGUBQ07a1+9R7c052w1dQ=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(478600001)(36756003)(186003)(81166007)(54906003)(82740400003)(426003)(44832011)(7696005)(356005)(82310400005)(40480700001)(70206006)(70586007)(8676002)(4326008)(6916009)(26005)(2906002)(1076003)(2616005)(6666004)(336012)(5660300002)(36860700001)(47076005)(316002)(41300700001)(40460700003)(8936002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5395
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fe11594b-c6a5-49c0-f655-08db2007f3eb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mETkH8+zvZqqR3LKUCKbsRqs7B5SCG3x1IDEbtpK6CZDBrDK7+6pag5qP1XBVOMjR5uWmdIhSbgf5mPcLbu85M+8bpmUSMIY7YWKlh7BKK8vhsKVT3oHUBHCIKnYk/ckUIbfIOPewc9zgSRJFlJytURzdeLoDmQVDAL1HfV/cNO319WQWZcGhe2aK0mW7Zi2mNLaiiGsaE/fkxFNT0QGEXj4ElapNeeRByvnuYYoqIrJK9n3eXmwy+545ekSeq1Jg2F6xrVmAfbMxElr2GrTN/cSNuDqnfBnd3xWbS8SwrKBZuisKuugTj7wvh+vzOVoXR7/WCyjATF6vmMGt/Uw0j4JcK/InNqxTxhLNl6slXrOQh+32ht8WGUTM43ImD4MmDi1VRC46gtHmhlVzLY2U3zuVcbpcsCLRx140JMcCWqg/+OmknMfvwCFZgrIyxrWzG3r75euLoYfCqfzoSl1+L3cuDsN6vNQOrUex9RTTE7/+2prXlkkRGyfBa6Zw7x4RuhIZMRVtRrAFySuwtgvypIVciWSVD7kglt+a1AEq0eR8WB5gTanMBDjM6EgRp19W7uwgNRtX//AfeV/SHlHmHgi3rzuTy79El82ruYEtKLdfH8qN0zI0wCJiImwtAXHjGOd5oNifmnt1xTPQQYr324mrbVLPvH8DQ3mZPKFlJqNA3iWxa7j1C56etmFYbY06eRklw/aW+BQKgRke6rXbA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(4326008)(70586007)(81166007)(36756003)(6862004)(44832011)(8936002)(2906002)(41300700001)(1076003)(82740400003)(5660300002)(86362001)(36860700001)(40480700001)(70206006)(7696005)(8676002)(107886003)(6666004)(478600001)(54906003)(316002)(47076005)(82310400005)(40460700003)(426003)(83380400001)(2616005)(186003)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:04:51.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd9efac-e355-4d69-7a18-08db2007fea7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Sync prctl.h after the changes in b507808ebce ("mm: implement memory-deny-write-execute as a prctl")

Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
Signed-off-by: Peter Xu <peterx@redhat.com>
[joey: added commit message]
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index a5e06dcbba13..1312a137f7fb 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -281,6 +281,12 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Memory deny write / execute */
+#define PR_SET_MDWE			65
+# define PR_MDWE_REFUSE_EXEC_GAIN	1
+
+#define PR_GET_MDWE			66
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
-- 
2.17.1

