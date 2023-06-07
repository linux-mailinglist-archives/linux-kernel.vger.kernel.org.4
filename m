Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E7726734
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFGRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFGRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:25:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2109.outbound.protection.outlook.com [40.92.53.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE11FE9;
        Wed,  7 Jun 2023 10:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIMQUlGY8ix9icudO8ibb91fnMbnFH0LsxJbQKW/zhqiOmsuwlWGqzQxWv4KYjKWuAmzbvgnN98SGKepndLV8WbvAhs1/uuCKiaJy7lYdvnyDm3l/0Vexc+W2Ag1BJkAoJ6BqVzT55gqVWiYbMkAO/sUxHGxlAsgMRLkkiIh43547b9Q8p9K/ULJSLCONitmQNvBC5DHP5Oll/CeGnO8uriTV2TT4u7TvcaVqw9jei7XfFtDc9aOdny0lyY/4mnjyns8avlOANVirtFqaCvnJYroOtmlMKDXZXhNYFd38zbrSrDHCvPbrC6DA/Dvy219R/dYpiE3q3gVGsSgdA6Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaF1w8VO8XGhwWF/rwXqBwwfIRSACmUXPpupGkJsg4w=;
 b=UrCTfJiFRCRlGXQ/evDyTtPMqaGoctf1mT9vCKHtN8AFAaUyG9WEuqzggFXoq+1/Fi3RpM8UY1F0DKRai6p3UqwG0AMiXEVtPEzIS77b6kF7llznLoX574zAbndxj2B3oLcjvTxiQGqRvC3MLP6m7W/pMwuH5xltpd6P6i82PBx+1tBqToRnZ7IY5U+scNviTuprkvfvqf8deGQzXDbUbIX1XNfbrmpLq/8JeCm6CTqpmVLrI1UeUrnyVQh9urUXun2NjhsDqpP7BseSyAQ968QbS6Ry/oj6eCQW2WTbXzPg/LKgKHOLnjuh81f5Fqj6OA593ksLTkWljdYPP65bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaF1w8VO8XGhwWF/rwXqBwwfIRSACmUXPpupGkJsg4w=;
 b=mmb8uDEMOOroi4qPHNIlsweSitULAKSodtaCMT22XlYr+d0AX0i7EX84Bk1F45Skwr0+RvdSOxBNoWTAQBT/+4SEUbtW7zzqLkX7N6WSJFDtiC8ormzzHzfgSOggcAhgWNcZ8oJyBKO73iMA1myMQs+O6U0jU4FLsV/B89jowXurgCyqUY+Xque4oO0tYq5ZiXdf0GGTGmpBJg4ScbMPdSPEmJi0ST6Qq4QmVj7+BelnMYQsFK1hpRVPW6SRYkZ2amzJIvO9LgDsDWadFWVOBzkUUSjuZ5SxiHYPjTuymmxS3zZIXezeaXh19meUZmA5/tmvE26zTry4+SbSIvY5Fg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB4396.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:25:00 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204%7]) with mapi id 15.20.6411.021; Wed, 7 Jun 2023
 17:25:00 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     kvalo@kernel.org
Cc:     quic_srirrama@quicinc.com, quic_kathirve@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 1/3] wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()
Date:   Wed,  7 Jun 2023 17:24:37 +0000
Message-ID: <TYZPR01MB5556D7AA10ABEDDDD2D8F39EC953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <TYZPR01MB5556F7C9F8E5BB5F5E1C8770C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB5556F7C9F8E5BB5F5E1C8770C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FpcJ3u87YcuYIGVpuOHeodVHoyG3T5CiLiZxi8nKzY0=]
X-ClientProxiedBy: PH7PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:510:174::10) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230607172439.2258343-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 63519b4f-7301-4026-0dec-08db677c1eef
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwXpdfrfzfVGwTZpgc3WKBgZZ1x/hoAx3TQvdZC6sFjWhcwX0ir1I2cIEhkvHSWBESfoG09YSU24NzA9ot1wvFy6BLe5lj+BX4Dkr19NxMrueaRzCFuFwpIPCcsuYQ1swXUabgn49B8/1p6IsyeiUUhBjYI9vrIda8Ui5cTWQj9+5tvLWIRTDMHBBqva98TIYZz/0dKhpPe8fvv1aCoNCCv9vbfagmS9b/mgsFlOcUt0ZGntSWsyYsNrOsBIgrVNtMi6/Xe1ctiNBGit3606KK/8ZzCJFrvNBN8+XwZGzVOMb3nFfFohv0oY77B/O6IZ9h3EgRsSmcjMAbq3HPo0QaPnhFMCKPqea3tgR00DuR3IXzITjxOSH2bGjsSrQcySOdfWI9R137v8ap6lyAN54rUFfxZOvGo7JsvtYPiQaXH1P3KZzKybw3uI0DhMjOg8a6elmV3aaVyQcSgOwHGeX0huj0GtT5otOcte45eHg5HGZvM3PMP/Yh5yhWCxJlGtimpsNrRkQnjHmT5mKY4393MmDh6rVV4F12G/GH+f41+1BuVvOZ4BFo+7Oi7MQZzpDG2FEjpjF/zVvjccZa4TgJusXd2s1tkMRBEhybVbh/pTrjTQZGsh+RyTiRKUGgXBkYb/2ejR3LVWWyQQe4VQRymZnqGW7K39eObeb33xyYlh6witzPQia2qCCYAtWZBpykxGJTqZ0NPMau0AWxJSeU8+6YUKeZABTVHfxcINN0rMZ+Vx0HxbXaLBfot4J6XoSn4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwxCwGq1uKCwIuX63DcBHzr/QYFlYrjF6mSTraBFf2XybHnlNAQANTiUvB1LgjG4TMhiBvlb0EpPspu4XI85O24aXUoUmwjQrTxDFsgtdatbv8YkCfRHiDH57XAfeLCCFB14j0k/u+vo0n3o6tec04/XScHxUcC0QyQ7B9DwvIrI8KeQnrLsk1BJ+HcDt466FYulh2sJEN8AR7iKVLgxQrp6ZQr+Kmyevq0U3vKhPHxpoR0zcAhvq+VCJjz7uFjqqHhC4AuS8jjPy6h2kBVk+CbaEXQ3wykcsMWguChVpui7MhZ3cU6OvR2Pk/pRXWHZydnrQijgROXXuqS/s/lyYaoxbA1v5YdfJOjwwOM4bQyvzjjAB+X790q6qAx51fcdp6GhWpTjVvMjFAr9J3LCzituZqIqfWKgzCTEol5nIPr2tlvUK7fhsF5hs3kFkWS6GnhhFc1f89CMKRLfVYuRF8hkdq89TnEn0Dqb0DO2H6x0RAaEeV4zEZEXFOc4Ynr4Uf94KRnev1wG1dDXE6OY89VgkskjJgu75wFVWjS/s221zL3xXoWqOyJOcsFp4+Id+HqIquYxlV8C9oOFXgLpkH5LevF+iLVoKs30t9s+xcWAqDwlJwP3yWSWa0n1COCH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QwyavinE5Vjncv5fbmSTgo9m7qtC4xdCDTKhZgjMfE7LRNduYhYMKBy3298k?=
 =?us-ascii?Q?+eMoNN3n+66oF97P4O5dw4DBcrmvYnL/quX59nhatmfsE5sWp5X5G+rR2okY?=
 =?us-ascii?Q?e/Bgm2cW6wIm5IjLw7tnVByKF2rnqjTgiF0e/M20NSfBMoCyQeZ4QpRm0F+q?=
 =?us-ascii?Q?yXScGr0wtJIlVdg/AwUEP9QZPa5JDaIsteaiwRJbZKqB7mrCW9QkZvtEMKEB?=
 =?us-ascii?Q?79WaTx2Z9DHWIWjYVd2a3tc+3SQynYZLyknJf9oCJOxGvKPE3rGzcNWq2dDK?=
 =?us-ascii?Q?IgkLgYUezGBiCRw6PjAKQUcmPm410BiiL+1RnEM8K9NxSwKOXQv7iUKrUGyx?=
 =?us-ascii?Q?ODCB/8RhxEgLHZZkjRcXoZC1wx7kFZEWJwhrmxS0Ba/u+OnJZ+DlIoDpl1Re?=
 =?us-ascii?Q?kgwh27IZzsJtVCMeN+dVjwEQMMJzalEAN54SYvWPd3qHLN4JsIRffMfMfYo+?=
 =?us-ascii?Q?HdB2C5nsihDWipBmObbUDIJPbkSJ/0ixeWgoDk7c4aH4P/LoU6YbhYQD7wg8?=
 =?us-ascii?Q?JD4Q2Y6EdyMfjrQTA/CbjYAQAsDM5h5jFAtdukajwyu6DUAjsGdUJe9hvAkV?=
 =?us-ascii?Q?d092RbNyo87Mfdu68QRroXHh+1bsnD2JE0DQJl8vRGMwOXdJGH2Gcm5Wb3rN?=
 =?us-ascii?Q?BTuDJ6rhadwte14oPOM6tihQ4+qRv+fhLLvCwKvO1j3PElIo8wcKF5OTeHmA?=
 =?us-ascii?Q?UsBN+Gc1sIFMsClNVKtpgAJWwcseUN0acb/cBlTSlhAluWwjJklvFbhmUZ7F?=
 =?us-ascii?Q?8+94R5d5XiOMqPj/L60ceNDBd7iotKz+crJujJjflff/fRpp9s1ZsEStllY5?=
 =?us-ascii?Q?jlPej2yIYaD8M+WRvPMyVEeHKmXNkbpGqiJbuXdcKNrZ4pMyWUTlnyqNNNSW?=
 =?us-ascii?Q?leAlVk2eHoWAu6FzNUw5oDtpHctv8WYs/O1pt3Vl7SGOdad0Fm1OZSZApCfW?=
 =?us-ascii?Q?9rINHkvCnOiQRhEBvLotniHyzwFLpgBvmgzRfBDTZnP+tRhHakHa0t4dynO1?=
 =?us-ascii?Q?xOkDmokPiThWXEOj4/XEO5l4wtYUosaLUd05ODJOqEZ3RofFT1Nqtjf5EQ6I?=
 =?us-ascii?Q?agwlYvB3DCv2BG/3A68PILiuYhxj7dEOzW63UIRgixe+0//DOM4PoOpdsXcJ?=
 =?us-ascii?Q?h/zbxJ+IvOV4TE3Zd0tkWU2gyKQgUCZtrthi5p9UoyTX+pdxaXymSijUkts2?=
 =?us-ascii?Q?MgjH4EvnNMPvkqA/gfLZwGojPKqdU965rvb352y1a/BGWl5uGP8228/mwRw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63519b4f-7301-4026-0dec-08db677c1eef
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:25:00.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the IPQ5018 WiFi will fail and print the following
logs:

	[   11.033179] ath11k c000000.wifi: unsupported device type 7
	[   11.033223] ath11k: probe of c000000.wifi failed with error -95

Fixes: 25edca7bb18a ("wifi: ath11k: add ipq5018 device support")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 5cbba9a8b6ba..396548e57022 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1127,6 +1127,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	switch (hw_rev) {
 	case ATH11K_HW_IPQ8074:
 	case ATH11K_HW_IPQ6018_HW10:
+	case ATH11K_HW_IPQ5018_HW10:
 		hif_ops = &ath11k_ahb_hif_ops_ipq8074;
 		pci_ops = NULL;
 		break;
-- 
2.25.1

