Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D86D4668
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjDCOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:04:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04B170F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kysREfUSaRlmHrb84g4iw/QWEM/Oz8PHP3TkPrP+cYt9RYuMzQ9W3rq9gkjaEcnA77ghcbVxxnGbA93gnwNhygKTDtxwVssm59AOiYbEu8d9P7StHP+CjNjGtReQV8o3dYOGjGTQnJFPoZI0eba7yznl4+gua9LCacKPy4daIFAl36msceFqdeY5/ZY4I1pgT7bQrDi6jD3qrmzSEad35quXw70wc2iU8Ozs5/NZ1dlluQW2rxv7wfS1Ozs/MT7Oz6WXCoWh7DkXcUtPwKGhPEUz8P+DxNeg0P8SYWyKJzWDaEHwrSA6FhPSre/z2oM4jpNqAwHtk1XW16Qs1FTtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7DhGdpw8hz08O337spbyEK9LgSVlWUSkHK2i35rVBQ=;
 b=L84JjZ2Zjii/ari2TDoXzNksVC0VoMrcja8qKC9DUrDG6MqriCDRPob17qlvtsBUo+W90t8U3P1XaDk56Hrnq7eCPJRUxCXZHk7mI3YNzfcG6/myRRft+Baa567oALGM3s3h7iYwepElux0Xnx08KWhBho2YD6soY+6zpHa6u8ubeZKkc7pXyeCQxXSekevhyYwf1VMz9Zm+r41TtJxTlFCtUvCTIa28/cP2ZUNXl77KZGIcOW87huaMqaY45djhS3BXecl3T9nUF/pa7M6ZmnnU9cqGwWOSSIcDC9GepmcA3B0McXydsubDhHMgoN277arfK+ayo2UFxg/vD/34aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7DhGdpw8hz08O337spbyEK9LgSVlWUSkHK2i35rVBQ=;
 b=CeL1YIRxRhGm1NCaH3Sf8JVWx+94deGGF6W5eifHkD9DRGqIFMRaVqB/nN+dh/edUaN0SZZ7/87+glUlfWqXuyov8aSL3N0U+ALGFb9Xyrjw/X1H+NWFIEG3TT0MY5FISeN2XcvBWwjKgDrOPVHH9u7u+kEUOq1lD8uRSya+0Z8=
Received: from BN8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:ac::23)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:04:38 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::e3) by BN8PR07CA0010.outlook.office365.com
 (2603:10b6:408:ac::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 14:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.26 via Frontend Transport; Mon, 3 Apr 2023 14:04:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 09:04:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 09:04:37 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 3 Apr 2023 09:04:35 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <nikhil.agarwal@amd.com>
CC:     <git@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH] cdx: change struct bus_type for sysfs rescan callback as constant
Date:   Mon, 3 Apr 2023 19:34:16 +0530
Message-ID: <20230403140416.28183-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db192c4-cff4-4629-2155-08db344c5ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsFgdo6YHeCiCBDi7l4Xvbli3DY/8YEHSISGP8fMoqFlgAE5jzK2H4tNeozSirfUkSNg7iCnPbEdcgUcMp/ej6onGE4jvBmG2P+r9X3QaAdUB5W/Pq1J1eHMMfq4FaWASfSzgN0RErTmH7d+F/2xp1e5un9NB0qN7F/tM4NXkDN4lUPxJPn1oQL6iC03Qo1X0jlFKEzq/InVzZKsT3U3x1tBZ8jpoZFgv8k9UOVwuvr80IqyaTyfm57tJLEzxqMKw5FZq67FScpH5rvnY2gTwqNbqt3BRFGZSYIWGfEDlfIMwDsC8542uqqkAzavhBvM+bX70wwqRCTw1jYBuM3acws7635cOyInEySaHqn2WCvIlJNDb7yj3wjLTsxF4vIXj28OTnAnCWMjt5wprh93fNTBqIcpxyEf1V7FcuM98Hk88ohGGmcM2Nhb28fMJ+gJ/aFfJbYOK4zMcE8b8kzakGE1LEMew6U0OUylq8VUfaOr+wuPWY6D+dP7B3O25gRaiRoCUMlnQf4gtx819y/wiLE6sto7uF7zqHNY3wooBbndKvsalbSbWvIHQtobC0kfCNg/uUr9XMqP6gukQbY6lvVk8D7056CArLoox/bU2rd2amo9SpsSL5mlWhmHBjo3p46XCfLEi5Y67UnFle17ExTCxcNv5mf/FzJMlZdLb0qVLSvZI7d091FFF6VdZUp79jfjDgCdAYgg4nMC2ltl+h4doR+eObzTSD3x7lw9KRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(44832011)(81166007)(356005)(5660300002)(4744005)(82740400003)(70206006)(8936002)(70586007)(41300700001)(4326008)(8676002)(36860700001)(40460700003)(36756003)(1076003)(110136005)(54906003)(316002)(2616005)(47076005)(6636002)(82310400005)(83380400001)(336012)(426003)(86362001)(478600001)(40480700001)(966005)(186003)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:04:38.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db192c4-cff4-4629-2155-08db344c5ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As store prototype in struct bus_attribute has been updated
to have bus_type as constant, change the CDX sysfs entries to
follow the same.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---

The bus attributes are marked as constant in patch:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=75cff725d9566699a670a02b3cfd1c6e9e9ed53e

 drivers/cdx/cdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 67c32cb2c006..38511fd36325 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -363,7 +363,7 @@ static struct attribute *cdx_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_dev);
 
-static ssize_t rescan_store(struct bus_type *bus,
+static ssize_t rescan_store(const struct bus_type *bus,
 			    const char *buf, size_t count)
 {
 	struct cdx_controller *cdx;
-- 
2.17.1

