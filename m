Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2317472D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGDNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGDNhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C810DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YugR7qg+47CKkUzT42JQXyU1w/C6D1rI1xXjfCEmlhJHGEXM4a1c4YY4ixQIIk+EnW3JQzdGScvnSYJ3V1wc4jCrEzfkQo5Ki6qIe5Vc/jgaVk6IboUh2QBVcmDPx1ulFRGIeHXbMqmk7c6U4c1DepEyRISNX7ACyJrL7iHSoo3+suyA19f0gFONKYd044gZpEX/1wU80RvUk45SHLxMP389NI93Arr06jAwWuwh2ASJ0U1M5mikd2ohIdeVuJ+VYnvhBPrvGGz+1scdEv0UAmxT8BAZRyrC2y9u5MLvVhINEOIsHNU8+9app1LEH9jlNVbyoJOpDPpkbW/u7Pmnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWNwGHOybxnG2KaL+sDWfXBLEdb+fyWZFnZXLh04aPQ=;
 b=L4eSWdTagWjAXN2ix2J5ei8w/pjEh9OgbtwX1xRAF60z7ZzsHFwqpy6kYWV74ZS9BD2TVuOY+sxYInoKaoJIq+lkTxZECzh/WeC2lIokjMrkwYr4Ir5Wf/xLHiA22fcZO7426RcmZHUB63N1ALoX2Ji9ItqYiuA8hl4ufP2WfqlB5BKR6i8KWKnKtZZxRHkpvyZWo03xiNBzoqfm8VWM24MKzplxZLsUSYDAAcQeZW5hebeTTrMp1Gys2ZKFyhMhXUHCXxwb8E8p4sUBb4ATH1lo6FBaBUp9/PrDjOwQmdFOz9FexdUMKcbFZrVjYNa75sQlA1l5oyk0HF++ywFKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWNwGHOybxnG2KaL+sDWfXBLEdb+fyWZFnZXLh04aPQ=;
 b=qAcBoI/3r9MJqCcIegmsbIlf54cYpEVPuREJn0Vnzz7ZHFNNW/klFyK/fGYbQkxwP9vPVBRBESfY1QXPngtvxmPureD0vs2LDphleMfiOUl6YVolGon9HDVpo2RyfuGKxbg/8w/d0ynklN9m682/DJzbReeXm7IbSnl1hkh4SBb+ZG7btU87dADkxZIJtr2gknVpaHonxFeOB6GNUifOGWbxCKMsi+o/F7Hm3VJjAfrBk3dvg6CXoRs8Alc8jMOn1rjf3zkKo090Nn6t7f4uJ3sH5N3PkCF45C5JtLB30LozaaVb4xhjui4l4lcX9cGoESBSP5VT8jYwS2SoUJXa5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5708.apcprd06.prod.outlook.com (2603:1096:400:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:37:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:37:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mailbox: mailbox-test: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:37:24 +0800
Message-Id: <20230704133726.28861-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704133726.28861-1-frank.li@vivo.com>
References: <20230704133726.28861-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: f6dd4d00-a779-4502-8cd9-08db7c93d562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wketFsCnOrYjCMWDDPqRI+85v5b75CSU1rcWSEKrxH712cvkTqkX6pYDpw4NrWw02eCTPzz1s5EfoIBKSeV5ZdB3Yuw0u7Oppmi1wQXCWennTSJR9XWzhARb6YdHMBnQ4ankTG6uohvom4q2poaeDpZo5bHTe5cmDwM6pO8pn1mX7LybeA3zlaVVHkVVylMDgCmEUy/pTYgYxuON6pPUuWtLcU/pvpKpoQABZ3q0w5ZFBlmw2A1BR+LE5j2NRLxkDZ379i4MOyXcldZlYVOeuuIRii+HZdAO4XMR5soOy6zoGucr6s4VHpGL5phVvYcvqiTr2fb9pIUrcGuxHuFJKs7e+LIs9XiEHzkjUIr+9cN2BGKhiZBzuU2U1Xf8FyD2c97YW21QnIiutG7rVxyc9qfE/62puJLmaIwv8IAHMwtd+ycpyZyOQfzTtpev8H5yBy9QZU7r0G9xua4VxeR/GdRXG8Yz2Jw2+9VuWpE7n0Aevi3gDwmx3/mgFng5sB1VCoZnscxqfWUwNlwqUsSqD2jrTFGqLyZS0sisFdlCI/C/XUCgBvY4quwop6DAiYFceDnzRURAXg/EV7mt59Efsi7JiEeMMDSL9C6m6388QhOeDn2HHv8Y4PHTTM0eToq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(6916009)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(15650500001)(52116002)(38350700002)(5660300002)(478600001)(8676002)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49UHEbcmL7dkKjGRc4hT7kpWOywGP/AwJ8Q9T/YJ6wcUUngLQicmIXNtuqvL?=
 =?us-ascii?Q?i9a5oLQIjfk2ltSgRPtulBE6O6jvGedkzNs8Zt0pKQkRDiGJKcjFDX1KgfTI?=
 =?us-ascii?Q?8TwNxCzDUegM9Ji3P2U2Ev73SV/AQzv5jklFK21z7OkuLZnQEfRRD7KvWhw7?=
 =?us-ascii?Q?8zZUAnE426RsaYGNmjkL7aL+9gz8jcJhQt6ILbdE5ehF17jnxe5JROmpwgTU?=
 =?us-ascii?Q?dezzgm1KVhcG7AB0XE/IzCzEKrlGmzmthODXCaziGvk01A8fD4FfjUHrWS6d?=
 =?us-ascii?Q?ZA8q6qGmc1umBti91DgQkuPaewhM1AswWhurDN4TPkiAeTZZSGaRL6hQWW7r?=
 =?us-ascii?Q?0pnWvkgzqG858AXGMTLyKOz+ry5VriV6Ek3uTJee2rxh7O7BAMji3H6JQpIo?=
 =?us-ascii?Q?k+d9P+vvY2EWiorw35DMohib2kGZgaelJZfxq9Kj05DwGr4/9jDA2/XELtbe?=
 =?us-ascii?Q?gMAv8zpe5upPnSV0CoE7qnUOEGV+gOLCHjxLwvOKillketC6r9ATFEAkWHMs?=
 =?us-ascii?Q?iYmbiqcbwLPtpHYl9rpTcUga2ER1ZUQHMzNFIqGDbI6SNIQdPvYzwfcQJUXg?=
 =?us-ascii?Q?hNZGfGgY+5NwueJ5/ONgTS/72c7RfK2lvqgghcRiy+6wrBZ9/9OSk2IsCc3j?=
 =?us-ascii?Q?aYXSEL57Sil8n016r42JWz6Djfq28ZcMYDIn30TI7j0AK5xCOsCZRa8YFpnr?=
 =?us-ascii?Q?5/rp7T7H6EbCdSeGXnwWNmuCrbOJmNIS5JpU66u5gmWVo8BZOgfNDh6tQfWb?=
 =?us-ascii?Q?zysI4zfe5jKw34Hvrh36zgPIcONe1sn/EKNYdirnQWMZmlUnZz+dLCqWTvBY?=
 =?us-ascii?Q?2fFsDnO/n+4wBSJump6mT7u4bOFR+wm/rFHnhRLw/DzpWGSGPlWHjs0O8TwH?=
 =?us-ascii?Q?StKFmkXN0m7xDdxz78tl9aUB1P0GWBk8YzUSn0reN+f8R0EgQYLyjuztgmIw?=
 =?us-ascii?Q?fQpN7tkU1XTkh39a7SNYfyeTuUXML7u3SLTKPTl8tKHvoptc9LZD16iZqrng?=
 =?us-ascii?Q?89ENaTTzjOV6cpY8cBTdj8L0fiaG23Kt0PxYEfCM0CClYEPfjdshdkef1xjH?=
 =?us-ascii?Q?qkEx97HADMl2vTrYgDcAOjVQpkla1+0yYSs3SCrrTToYzjlBqfsticihdrLO?=
 =?us-ascii?Q?o6GaW/kncOZnfLjw1J/lRkCqaNWtGPvAG51PWNXAc4OURL4gdNq7bIN7zNNu?=
 =?us-ascii?Q?7iiRbxA2+EoEZ+9vuLyiXEPQX2kFpq2T6eKVsv69C+NX9RLkXvwdyQsV87bk?=
 =?us-ascii?Q?DNlAVJ4fntahVfWfeYMsp16ONA9xd4ewOD70y9ijjddURprajiQe+NfTECa8?=
 =?us-ascii?Q?6Cxp8VuqF2yi/PnOlSH2TczfcksYUV8bl+9sWomJ+xQ5X2mQisp6VshlUNXV?=
 =?us-ascii?Q?t9+24kZ4atCZ8U9gJdXI0RFNcy8pdHYSvGcxS3zBuI+1EnIpAWQTnRqInqH3?=
 =?us-ascii?Q?axUm9aRolvdaosUnzi5w2A5b8bzSPIHCd+bF/Su5EJoMhXR2a+3/wdV6BTWp?=
 =?us-ascii?Q?W2OA1OTBVkF5uAwTY0Ph9K4mdmBBwih6UaaMKMiqc45CSSpgHPuhUG8qWacw?=
 =?us-ascii?Q?uhS22ETXq4Bm06Ov5HYCVpIOGKh9P4w0UmHxtw4L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dd4d00-a779-4502-8cd9-08db7c93d562
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:37:38.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U39WJp/wniqejM3v0OSztpRADl0rM+hn/54wmBrFfgg0hIKRjxYFZpEdlCuCc8lg22JbGgznRxPabGKKHiA8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5708
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
 drivers/mailbox/mailbox-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index fc6a12a51b40..91b68cb884cd 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -367,8 +367,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* It's okay for MMIO to be NULL */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdev->tx_mmio = devm_ioremap_resource(&pdev->dev, res);
+	tdev->tx_mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (PTR_ERR(tdev->tx_mmio) == -EBUSY) {
 		/* if reserved area in SRAM, try just ioremap */
 		size = resource_size(res);
@@ -378,8 +377,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	}
 
 	/* If specified, second reg entry is Rx MMIO */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tdev->rx_mmio = devm_ioremap_resource(&pdev->dev, res);
+	tdev->rx_mmio = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
 	if (PTR_ERR(tdev->rx_mmio) == -EBUSY) {
 		size = resource_size(res);
 		tdev->rx_mmio = devm_ioremap(&pdev->dev, res->start, size);
-- 
2.39.0

