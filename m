Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF174A913
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjGGCmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGGCmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:42:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2619A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfK4/PUHAeSrTlof4yQZUT4CjJ1w4sJFAe0jk6D98uAb+gtacZ1xFYj/RE7AvDGxpM5YKdaaSVN6+a0QGushpuMSeMLBc90KTFg6way7/9ZkT5riEgKIWynt9Kmhc68kHT2eJo4iHlBoyAJkbhpdipdqKQuxWRxrAdhYxt/rH+RYIW7eIKW1ps+bGy092K/1WmawyMhlqOzR4fmFjNY8aDQ62V5bJ5px3DccfafADx8htULK+MOluCJcRmQvX6Tn3HqHvnZdCH9yi/eyuC5qAyQuvfMhRczi0bqKaCs9C/GcR8Xtcx27aN0O1Yyz9SW2jBJrGiileknNlKaYrJEyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUoNBOyR6FQc1wYtGFqcwqFYgvPy0l6AIiaNA3RZKso=;
 b=jOGm7iYBSz4qhVMMhB+PWd/KBwuH8RXFrc+Y3Tsgh8Jdrh3UTZ13JxSLJfRK3LfycLbXAq9sI5gG/4WPV1dJHAjPq9HTUxgtTHF/b4XnzjWVuZvLxuzHivoq0Fy/4DPqZb9DtEmotBGmt82nvNmrMBmNWu471K0wlNPEJXSfa2Y3cW3R6wTWomGrqOh8tWpePi+p8cQ3muuIT4J/NQXqb+1reTusk6oRPNYnqYPp2NpZS8iv+mmScJkKimZ3VnIodxpPn+5p1jlag9yvmMl2VzZybpSf94gj97H0ptVcp8A/8yyGI7GmjKNMqRL8QT8p0v/G1hxtlceFihFjJTLcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUoNBOyR6FQc1wYtGFqcwqFYgvPy0l6AIiaNA3RZKso=;
 b=AQf3iBeAiApJwNALygKSRBP1TdltgifBysw/OjlyPhe1HAUC/f3HjmB1phXXK9mS+ZGImFhLnHkq4///U1etXYJba39OzQCoh2OhMM7D0KpqMgM8svdCwaNCbpsb8JSj7xvrnJmMR8HpPF9ihPLNft7FZqubGao6bWXGO+lNjYEMqlU6mV2SwOXEs+/u0D4HjLeFWn+4GoHupAr1/ZqDvTkRNC77lvIw8b4hndXN4DrSFg0kUmFpuVUxywBqbY51uEpCe6k4ivpMLvVLqZiWVqgeicFmkwh2qv5/KgLybAcnbPZJUdXzdU1l5DKIUUjZ9zh+eSo31lLCP6gcDTsfEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4482.apcprd06.prod.outlook.com (2603:1096:820:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 02:42:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 02:42:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] misc: atmel-ssc: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 10:42:21 +0800
Message-Id: <20230707024224.78907-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: c6879d2f-e198-4cfb-ca0f-08db7e93d15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5kFko5jvG5B9VGUehikau3LVkaxyqbP93jyrneh461JRy3FpWhLVodt64HGiVCfvHDEFWO3pDseaKs4m9+ARPAvofO7TKRg0KnPluf9msWxyNMoaX+NkxSm8BZ5zP93BQJT2PP4JAL4LAr1ehNje5t8l8wIfxbCcHUEQ3jKJcYiaetAnOzLegGSYETEG9O2yFPg+ntk6uxh2mu7Pbs7RinKGA5Q+6UscJVtj0Zzvb7ZC0nw9HjvVXGDS6vW+BgS+7EuSNCEwR4uL/TkZHp8ir8XIkZcs0oYF3CQNPker3Bj2yZne9wwZaebtyHiS0ALJ/vr0hjUEINQJQJmR4ech5CDHHJzvSK85XHgF38GaBJ775+ujU8O5CDi3sd2Vyza5h5TY5tX+8Z7/XGKi+/CEEzO/yQiHpUVnoUckvK3gBvI15D7VvQNXAdTSlzN9Py1jiQV1p14O/UZ8a6sDTRH+T8O/kINuGOyUmTyy62qphWnXf12kUannujzfeIhc3e0z18LfihwKJvWl1acSaC9yVL9YsiAWDdQRrdZM7SMJg0D1kA9VAmopceSkgRLAWl1fllBWQuP3DFq1yOmKyM36dEiCukMACFlbT22/0N6diAjvafRz/3iU+JlG1YLc91l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(6506007)(83380400001)(38100700002)(86362001)(36756003)(38350700002)(110136005)(6512007)(6486002)(6666004)(52116002)(8676002)(8936002)(5660300002)(478600001)(316002)(4326008)(2906002)(41300700001)(66476007)(66946007)(66556008)(4744005)(186003)(2616005)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0D6XZJLVcXWxdSVfelTTu5dU/94xPOtxIKh5No5tYL1KAIpU1DmRkw0jE7u?=
 =?us-ascii?Q?O8JbvLOfupDCIM3qI3yIVmM3uNX9HT7Y7TZY5BJ6aNQ+/exA2vhSHTI+5Hdd?=
 =?us-ascii?Q?QkCg07scsgj95Kp0G564KcRIEuHHkyxlUbjrDn1TQ0/mbij/VHy1zRSyy6hc?=
 =?us-ascii?Q?5nTJK+5a7YPEas3Elz5Xj9DO0jlE+TCMPINjoksE3w0/ue61QnAQH9EKCDYB?=
 =?us-ascii?Q?N5zAN8sRv/e4gqgLNxgenuKHSAoT1doR2DVKA9zQY2+qx+yD6nocotyg1o5t?=
 =?us-ascii?Q?xnXmlnTPblRXVv1FbxV9xz5J0mZohJEZHEPwE9FYcxB6W4SqjT/QSrKVawlM?=
 =?us-ascii?Q?+5FIQvVcAbDePpGFVAGUAirwLlOuwcdh2PKObvB1sew0JTiXuctGWfN3cIDw?=
 =?us-ascii?Q?rYz14wg7aYsAaNGY535Fl1ZlbWo7KDRwtLH2j9ddcLpNCg0sTls7FxmTgQaG?=
 =?us-ascii?Q?bn/0HaEPITLML/+RgEroZc5UvMoPAmFhWWDL0S/XjeB/9XflzQY14+2Oib4s?=
 =?us-ascii?Q?82yeqkAkboqHsnnTPp9pMDB85D0E+bfBc5r7NoEcpZDnTrD3tS0IXSVwhXEQ?=
 =?us-ascii?Q?YoaRLFUT1bmiKrk/MdRg++OMhQNsy/HChzoH/hWpDnoZLcMTBJta4hxEoKv1?=
 =?us-ascii?Q?hfgq/dO4tz++As3ImbKikEI40GD4WSFbIFHEGK4F7SZETTkj9qLu8WW4MyXl?=
 =?us-ascii?Q?b+fFBi/+NeJx+ADdgpv0mBaDBKyD30wNPAQoQsFqGREN82ewriib1vulBwlZ?=
 =?us-ascii?Q?YVeXKAzH9V00mjuBChmsrQDP55Vd/lzNJhvFotUUNnwXYx94ZvhRK17WztP/?=
 =?us-ascii?Q?5VNA1xU2bspuVEP2Ju8t1TZD8dTJj3eLnzeapN30U6IMp/SgrORhl3HE253N?=
 =?us-ascii?Q?kjt2YWva7uyrqw+mBskuT9hjHmu9KK+ielyRyFQnQ2d1/C/zrZnSSp0IitvI?=
 =?us-ascii?Q?e2ZpwQSJ85E46noIfDAxSRLciBsusWvDkyf+7hDGHQgT16uCDtEbv43QkXQa?=
 =?us-ascii?Q?oVLWubUJD0Z14vfMH1Vfqey2+E2MLtodSZR5MwXk1dHx7/TdSWoJ723kZ7F0?=
 =?us-ascii?Q?p4aMNPkK6XxHFiMfqcIDoBok10MGQSw2lgGPkx2VlfuBDfQlo2UDdbs9v79X?=
 =?us-ascii?Q?+GXqGR/diKnU6yiAvIQB2ob4yrEZeXOPE8txll+lIOKyKpOSe+ESzK2bWVqq?=
 =?us-ascii?Q?qIYNSCWs9sGMgKMwEqlbo3j83SzN8A/H/vYnF+V0dLsgTPuWF4eVbFrHCW2o?=
 =?us-ascii?Q?AX8eNLBEipfvOHxq6LZ46Yk56WWckW+qPiobrYOEEsFzxlMzXlYBKvENFFik?=
 =?us-ascii?Q?vf5f2r2gzBQaumkV6LtzYW6iOGRgQ9CMfcePz0adOmsZmHyPQFuF6/iwQrAk?=
 =?us-ascii?Q?KME7tQkev5nt2w914wV33q9uEJ/K4DPUwejZtWgPkeMUVtx8yww63RrlC+Xv?=
 =?us-ascii?Q?s658wWWF2Ra0xoiS6P7JvtAc8trtblosDC9x+lmz7WfLejj1xfr6g0WeebBz?=
 =?us-ascii?Q?4HiaDLq1s41jLBaLmVGL0HlirXH39laX62Hu/SGpmwy3wfTEunl9kYuX2Mf/?=
 =?us-ascii?Q?rqEm7NfUsPAx0eOY7wl8bTAFJ8E63UshhY1rfY/S?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6879d2f-e198-4cfb-ca0f-08db7e93d15b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 02:42:34.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuVrZXsjzcg9FwulYNuzxUYyamqrO2/Qa8ZnuE1p2SQDItCcXxbMfuide29IlTv2NSXch44HMG5UwoHPxWB0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4482
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/misc/atmel-ssc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 7f9f562d6433..ee590c4a1537 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -212,8 +212,7 @@ static int ssc_probe(struct platform_device *pdev)
 			of_property_read_bool(np, "atmel,clk-from-rk-pin");
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ssc->regs = devm_ioremap_resource(&pdev->dev, regs);
+	ssc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(ssc->regs))
 		return PTR_ERR(ssc->regs);
 
-- 
2.39.0

