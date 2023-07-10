Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DC74C9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGJCqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJCqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EAEE6;
        Sun,  9 Jul 2023 19:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niSo7uJ7zk5LBBsq9olz7S7+BvWybLTrESo7vo6WC3ndvwTwiXuCiLWnRppxOKIlaZlA43MsUnTp3cJQh1GSadNVtbNGpcNRSjreQ9YeZp7l29wdEEF5MIgtPXj3pXZk4DKOQnHON0D1+h+JaTiWEw3BK8SqnLr5MUG5stM5wswnAZDTW/vKAa26vjHOZNMmlOMfcZsJ38lh3pidAoTiTOf+fUjsQK9L1VoFEulOAqXUlIDZuElWxCTlWs8EfnnVpWTl1gQt3vFkSJE7BNvNLK4AG5MDc0RO0GEnVrM8aRpqwyGTYxvqy2A5TszsRibeCo9cNljw4ssZcbCkEbCgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clT28NDDnXG0lYtow9Jcn0FNxd+1sybluxxuiLZdlc4=;
 b=eIgJr8FBGK7uC71PiPAnQPDyBx9BDub6ITGUBCsE4C4BBLT55Xjb8o4mxJg76Xoft48VUUk6Lm5ZIKYrUIg9O//0FaxjdUOxbQTwWKoK2vNNKPu44ENsA0lM4MFy0wLLA7f87Db1L3UZEzEb7qHzeFpzk8m4ydxPCMYpFzc1S17Ie4rCXsVb6uPw0tjCkeyUZRPfV7yofMwhPRkxo4FWHAHZ6UvAlyTSxdcSrwi6E38VvIPenEJFhsSO+pScfvQe39Q1Z5Uak7OcHIl2O9HF4aj8CSmyG8d0JQd2Zr13RpmeOobzK91BaMq8nj/mvlEXKHHqEjSaReda2ur/OO6L7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clT28NDDnXG0lYtow9Jcn0FNxd+1sybluxxuiLZdlc4=;
 b=QSSYnt7zQC200JpLxmNVJiGUMPb5i/i3FEbgwOhV3PyzsuN6+c/uJob+r9DVXAhe5oSfmIpPssjp1OkiOf3YHdwoxjo7oxPDJNUeQc8jyLXTIUtJnM5EYwlU8gFLVS8p+MEC4T3f19JNT/00765UtPzdB0noHCujudIot4y+aJcHUqwdtEgKV3n/IwzuI/eBswLiR1Inn8crLnTsy066TZty7azHwyFrSsIxglUl+JwsGLdTs264f10b5DrYAKK2oi5k/EibdO3OZG7vkKKKL6fBgXf0KZURntrjXBdKWYf+dAM8vNNmgvtLFXOnfKSfCjVsG+zI1eeyS7Yud57svg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] ata: ahci_octeon: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:40 +0800
Message-Id: <20230710024550.59544-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 4207ddb6-1b7e-40ec-d3b0-08db80efcd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSRuTALeMR66fzbiFLV5onVwXpMDKa3r1YrBLONfUhFoQ2e/y81Oa66ca8PpgCHXXWRoVZTfuznCAcuaqk+bXygObV5P0tR0HkudS329PMNxeu5EQJyj7jRURqG9ky7pIQoY8HzQbV96mwBZMSb0XrrIZde3mSVc8i8Dq6gt74oZdOjt+6rsqXqJcCDwUwX+ghujaBRe/1rO1HZ1lFR0qjY8txFWHSInVn5x+Ylb3fwbC59aleReibSZpM92FcN5j2aEKO1m1H+sZ8BBPaQQXdKqYWdel1rQAc7tShI7bDn+KcZ3HDaSqX4MOw2dkT+kLqXx3ZFyk3rMbPuXjyGaHiHyJPh0o/XDljngzRtAq603fMbMW77VjZ8IhwTjBxpmXeUure60G9sAIMnbq1i8sVt+mPyWeV8VSD+yFLYqa26cRWNMFaMP6f5IffSHWN/7DriFj89FC24vXsrcht1lzqNRxTjM4Z3QxLXfVnpjujG9zqOBZPcWreTL/FjgaTrY/UD1rpWM8GBBDMkEQR6p5Q+UhxBmeq36h5ysc3+XgzS4MT9Gi90vyNFYCL03xBRXU9DpDEp0Qg70GEbksvBJReMyw/aGiZc2xqyH4cQJq6kiyVI9j1Gob9bh2X9xoyp/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(6916009)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6i01x0X1JUs98tlAgISyLg1hbEWCDby2S+AIPHojXOnm6p+zZKX5xjvSJV9D?=
 =?us-ascii?Q?Oh8DpKHrrIi0CqvYWpZzXsBX9B6n1lx+asD4bI6/u835AH6O0uCXapCUUvKD?=
 =?us-ascii?Q?PrYdvzP5tYF7ZuO2zf6+wiYPo0IjruuO3cjRJst3B7WwIExljPBvarQoutK6?=
 =?us-ascii?Q?UYJAiSIPgfX9rOBn2TroIHl3fBwhfJiqiOtNsspX7lAdPrjpvt7jpYjG/mH9?=
 =?us-ascii?Q?6j9YaEP8/aAm1GBtg04rr452q1PYmAzcRtTtnjchhmjWoeDmdK4CfdyvBilY?=
 =?us-ascii?Q?FORY2pLw/FF7GopWO9jANIzEoYhw0YY8ysWCGLdDtGEysRKzuUYTWMBifh7O?=
 =?us-ascii?Q?1o8B6ciZpY/VirOSj7jc/+cyjM3rOjvz6veZOkY+7ebCPG/BkTaULhNhGmlW?=
 =?us-ascii?Q?ncni81ETTjACrWqhF2ZxFj+et2lyzlCvtNCEY3UeEME/pKvzMUeTQMWageX0?=
 =?us-ascii?Q?xG5FiPElOu5vYfBhUYCGWmXEaPHk29UV8jDTW6ShGscDxJybjGqfWHU1nWWX?=
 =?us-ascii?Q?CI0p7K6Mo+mZG+fXjhRqO4MDXOir5SH+OIodfgCS637OrmUb1877Zsx3iKk3?=
 =?us-ascii?Q?5NiFyjUQwJOabTPGQ3hY9puIEbfofR8Bhr46/LNBIZgmWCO4VVopWnId1Qkk?=
 =?us-ascii?Q?AL7ZHuhggYvmxSWOOJlywBPeMDC30R0HvypISaU1SxFm65qUVj6tBFI3+Y69?=
 =?us-ascii?Q?RV5Om1aqj/Z3nx9cV+D5ukWaWjy66KvCwsRvtEN6J8sIJ5te29rd2n6kjCWk?=
 =?us-ascii?Q?58c22b2MoRsvD9W+s8pSjxBbapdpUObuVpsryuyn/cD12i2pCB91QKTt+EER?=
 =?us-ascii?Q?LroRRBpnrB6QPvelOUN9r4XErPpfx3+TrR88MoareYNRpgFs+WR0CrwHoqlP?=
 =?us-ascii?Q?MHwECXJ/L655v+FmpvDrGbobHsatbBHW9T7coquUduEzwNrFT5sbJuTWjhuu?=
 =?us-ascii?Q?WHpzK2/FIFEUfhX4O+Uhk3GpP72l9plBNZm5SOzXAkaIVxkKGbnWpfD4eSKA?=
 =?us-ascii?Q?lwVXPzyFQYsyzFFFL//oxIavqvDmV7D70ZEACvsWtv998hu9IWSZnSBB95Rt?=
 =?us-ascii?Q?ig1VLIOwY0FIbtoTYxAAnmG3nOSI9NP8Pa5Yr+hso4ixA3qicHvw0ZuBYDU/?=
 =?us-ascii?Q?VCoLZagNe/ADTUx99EceoYQAxas19NjvV3FyGBiSdVyRKcK30NINGSo40gum?=
 =?us-ascii?Q?6Bg3jleKTVN6YCidg/6kPVf7FaHpQr/WEwzlJJ4lIj3sFEQIc0JNWfg1N4H0?=
 =?us-ascii?Q?OgDgW8i9wMnFDPa7v23IhoQ4z7kvOksMkkOb2QmLEGrEb75bxVTYrIpGtjI9?=
 =?us-ascii?Q?+S0RgA5yAy3ahGe4SrxnwcNkpwizoEzcK2s9GAH8R41kSVIIHhQVp6ERBkVJ?=
 =?us-ascii?Q?SuheQ0Jg/HKLlYWg+S7bpsqNNI9188srER8wYcLHcejVO9SEAZmkHoaFIzrL?=
 =?us-ascii?Q?ORFo37IuI8PtYbGkgvmXKEiDPHm2Y9K0iZbtTOUiM3YsIbvy76RlpDIToawf?=
 =?us-ascii?Q?tmUKXVSB3uaIXrtIZ/8rePyQsB0lYlH9M9w/xhxYFsOCOytFmEJXjOAmms91?=
 =?us-ascii?Q?stYn1bd15VflLUkUJGtp2LzarGD33jHEsbDquztm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4207ddb6-1b7e-40ec-d3b0-08db80efcd13
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:03.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PufvXvKri9hQyXgVNpVK2dr8cBibCfVObJUP3WPmkZ3SXNOn83i7O/8TglPxVel0dRAHiKntGJEq7uUbDRrGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/ahci_octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index e89807fa928e..9accf8923891 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -31,13 +31,11 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	void __iomem *base;
 	u64 cfg;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

