Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D856EA899
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDUKuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjDUKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:50:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88B93CF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/yJupf6bubNrtqj5usiXLZRp8WPM47E942NEHrpCQ7GiGJGC85FelUDUl5CkyrwakKOe3mrZf4QRp4PTrVUnMzmG03ktK5xPa6MlLiHzVO7iTW/2AGJhrsDWKZM+RLg0kfj62Np630WkOPLrRk/wEY3n0AaQ8LG2ffBSZHM3DsVhWAttKzA8AdeYXwnOtLLwDPZPZMkQua8TUUA8cPcc1rWgJZ+nMzsI0UYr+Poy17bzEehJhgLLDh8NYpr22iRScVQPz4wUTPYe+TOXGoclIvlJ2TLnscbo9atvtUkeRf0bXUafWfO7KwV/W8nq3uIFkPBjfDdFLbH1dabmRMMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLlXcvR2SbAtB3WMLuhyZt6HKuwEbd9pl0xYHE9dkZc=;
 b=MbmAYmBk8REuhmftHn4yb0BZtgkwdueZkjyNtR9ws2BHCHvWImSAh2fYlwpOhwgY3rLqkmSezh1UfvUGG8eofAbm2WoO1hd2/nJmL4P6lOrS3Z+ooUHIXlp42lu8Vd73Rd4kHdwK3z/0hXXdVUknAjcX+fF6r1EtwKjbEZY/6ruKYRACbDripbr7N241okE6j3UaKdtZ1EFmW3VTFAwFr5yqa8hbj9F/vK1uTjPVZ0oSSESQHpGoxtRY9IzEwes4yD7YAnyEzRLLt0ltuJa/PMn6bTtTpuV5zFp8vDOwwsIOcdeL+kouHXeIencFMUnmld+jlOZb4nzA3wT979/n2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLlXcvR2SbAtB3WMLuhyZt6HKuwEbd9pl0xYHE9dkZc=;
 b=k05CwEQDrQY+TFa8RrrZwan6mKkjcZPGgW7IeWRiyMB2GQUiKLWx2pk0xDcBUg55oi7NcK82+GsMEDSH1wtdExGauUzMr50kSAuwl4Onf0kw7BeFFhLbGX7sjVMiNPD1kAM8n1Qvn1WWCbKeMcssvP+yrBuoXJrXOOlvhl+7kHKpp8nfL97j6pU0lElOBiCy0KB+NJYorhP5uBRxso/0WMOj24skac9gBTw95wQRDRyDgutK0sJJBBFsuagpf+BptTHk/U99EzAxDMgSWxT/+escYXV+a57ACB+F47oYou7OlBxAlZx1oiiGORwdBoJV+jD0/VUIM0Ju8XFnZRSP3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4634.apcprd06.prod.outlook.com (2603:1096:400:125::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 10:49:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 10:49:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: make __issue_discard_cmd() return more appropriate error code
Date:   Fri, 21 Apr 2023 18:49:43 +0800
Message-Id: <20230421104943.11878-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 8428019d-2476-4a85-2703-08db425624ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1rs6koQEk1+ow2Iqs4NXfZi7iKjPkTwIZoSPHHToYVXJOmg2V7BBtpvSAG+Su4hGMzLSj0q79pM312sc1RVUiWI0+RTibz4+6UFMX81VDx/p997cLJl+OINE8I1Ds9tzN5qJHGzobPHSuqXTrTlDosHFL3Bu2HLhO0sdP4kQ4xFcqR4CvP8TcOY6wJKb8iZ3e+jaWq9i2qx61r/9RaXlsCeKOpz7pnrUxW/aRZgfQouibJoRkEA0g7bZcDfUCZ7qhOqhzb4dkX9qakZOsBvZI1mawhnJQgBwDV51ZXdwLhePtQqNrZH93JbBEDuSFbCd6sgQzYKBr7/QpRvzEq1i2OEjs7xdA+nqYp7Tz0bjR1E5NSUIYRp21tdltYwFt2E6+pDDsJxqm/LwzlQcOH83gB5wui/wCDYsKQcmX7bmrodJzFWBOPc6St8mJYP2TnU3WnGGorL/g7ycaaScVnJkhAbDIhhlWJZh9k5w23aKt3+i4VLaLn/3OrxypbH3Hnh50EsjZVAC+HZiZj41q84CzujhvcdhQH7QI7WNH+BvEAx5oSKrJkLJJp1GZD9tptWxfsCoXSiG3xr/Szwszy0eOqAHqGepCQUfxQL9rwe62ZSAsgreZAtRyBCEQERYXDr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(451199021)(316002)(6506007)(26005)(1076003)(186003)(6512007)(41300700001)(83380400001)(2616005)(110136005)(66946007)(66556008)(4744005)(4326008)(52116002)(6486002)(38350700002)(6666004)(66476007)(2906002)(478600001)(36756003)(5660300002)(86362001)(8936002)(8676002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3QUVvG0wOnP0JgZFqRADsDk4CbUncw9XtlqzDc8OvK0zpD4WbI2ag7rjhaD9?=
 =?us-ascii?Q?izwlcODnXPq39/eq4lWmCDux/QZLCzPxL3NxTUVbsrKMQOj+SxWtX7edoT/k?=
 =?us-ascii?Q?8EaeiRcTqb5om/ZCMgB0p04+F2X4Ucf/DcOHYn1XJvhAyALH35blMKSYmWaL?=
 =?us-ascii?Q?D7XduV9lOR4BfTEr7XmZcPL17E06Q5YPaYkou6MSH+FIYj89iqWq85H3nyDh?=
 =?us-ascii?Q?raIEkhn+P7ZxKvbRWgwVyuIIQ03CdZpVcU91NDhtduXjat9zIR98z97prPAH?=
 =?us-ascii?Q?d0IvCV0JWpcpWxyvbSvjRvHdPplH0hypehOsSmMSN7A1NSwxaBjpLyIhM7Iv?=
 =?us-ascii?Q?b+bBhmrdPZg/eTdov2Dl0IMO/qDD2lhBur8mJTw0z3fDJ2wynJmvg/XiD+ed?=
 =?us-ascii?Q?XzY7/13dZlPXrhCMz64i3CnRab1I1QeXsWoM+T42i682X4YsasHULz7KyJio?=
 =?us-ascii?Q?JgmKBtq86dD5bNyalC0GPtYVYgnsj/wnXg4s7Wqu78+CsQzbFxwjsdUA6o+X?=
 =?us-ascii?Q?EVAKfej5pB9EuuFIzKBEtyw0lSMNR76Aki7oiTDOvaeKOojska5MDPYP4TQU?=
 =?us-ascii?Q?0zazo3H/Db0QHCExrhyyVDjW0Ttq9xANSGXrKA0kyF80r9Dr1C0/L/RsKWi7?=
 =?us-ascii?Q?0sF5yhwGkrFWfu3cLe5l9rIbS87HD4ElvzvE64cRnVvWtpS0LVGMngZDiH4m?=
 =?us-ascii?Q?yOwU84QbTSWI+Ht6Dr248vs+omH0tcdoy83e1GOMza9GMuey4BGRiEg+Qsug?=
 =?us-ascii?Q?iP/MPyGkXhLZCl4zoKBx5jiR5AV0LTkA3Q2DKKiTKhegDoJ5FkihGkYvaNkV?=
 =?us-ascii?Q?D4tQ7v3umEFLYyxZyrULGUcDu5UEKVO5QAzFFaXiW2eRYANA3hAjdX93S/ao?=
 =?us-ascii?Q?CGMKlWMWlAgZZbBnZ/hEUWz76TdFEYDCRvivcSuBuOVFfblJBwltcqFGS4Mg?=
 =?us-ascii?Q?Gc6gxudz3sy8zWQL4kADxvaYOtBuM68N4g+n1V4+mk5rwJVhB/SE2AwuEG6L?=
 =?us-ascii?Q?3xvjF6TcCG8+owPm3uYxpIWkJ3jJe/E9wwI4ZpyYL5pKfRwHzQFobk9mX1Qi?=
 =?us-ascii?Q?Y1LUvKvCgJ2871zsd9lo1uxHGCTSeaLjy1Gf+xlunyB53vSdawX8bnR9kW9l?=
 =?us-ascii?Q?qdWU/F5icICLEyQu7uBKG6QEXKfsb4iMQVC7+ruEqsdFJWvBURdRZ0ctH4B9?=
 =?us-ascii?Q?2d9r/tLIOUhL4IEmBkKqgkCwlZUduWVjZC6H2pX6MejbNc8A21Xj3t3W4I+E?=
 =?us-ascii?Q?k+bpbL+lqQ3ME7dh4GNclUV7OMEonXgtpLHE8plDM22tliSlegvolWbVuEbi?=
 =?us-ascii?Q?/Bw9hY0J5Na5Wy/860wC1wnQVF6qsRTFun2wI79vc8LeCFIgZvY09NS8YFt9?=
 =?us-ascii?Q?IpN2jjvuX3oDhqiIZL6s/S/0fO19LVZv6eqXLKGIwqbB3O8cEeGslKm0MZZU?=
 =?us-ascii?Q?pkhq2gQLO92IYWBVgkb0e8MBWF5wfVgDtdu3HKZEcaqSXX25BbVo9Rdtom0h?=
 =?us-ascii?Q?FlpbJvJKtip/t6FJBpKe4YTL/pdyJVmzTV55WXyuTmgceB25sINAWqAjiiGp?=
 =?us-ascii?Q?RWmPu3SGJl66nAKWNx5Uks2z4ATOEVJnSyzo/HiG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8428019d-2476-4a85-2703-08db425624ca
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 10:49:55.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnmy9S8Opb7hccq1robMzj/kEAysDkII6InqcEgSyG7k2QLZrcF/Q/rdZ0JRFkXtrVL8zIsj55TBRYrPZvgwpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returns -EBUSY when __issue_discard() is interrupted by io,
instead of returning -1.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6db410f1bb8c..a005948dca93 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1604,7 +1604,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	}
 
 	if (!issued && io_interrupted)
-		issued = -1;
+		issued = -EBUSY;
 
 	return issued;
 }
@@ -1829,7 +1829,7 @@ static int issue_discard_thread(void *data)
 		if (issued > 0) {
 			__wait_all_discard_cmd(sbi, &dpolicy);
 			wait_ms = dpolicy.min_interval;
-		} else if (issued == -1) {
+		} else if (issued == -EBUSY) {
 			wait_ms = f2fs_time_to_wait(sbi, DISCARD_TIME);
 			if (!wait_ms)
 				wait_ms = dpolicy.mid_interval;
-- 
2.39.0

