Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9930774855F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGENra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGENr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:47:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061AEF7;
        Wed,  5 Jul 2023 06:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8KdY2t2YBnGrf8q8C1haXCHurddqnwik7Sq7JlbZy/y5/6o09UfSEgNnDqRwiXDwBGhb7nx2+gtzDmKvyKCzeCV2MoqaszorLSwKybjDiTD13xl43+9t54MIp16tivDg7waA/EC2pOVsKpUB9NdVda5/KXDnAGxVeAhHpbSYgkdBzisz8Aie8v2NSMwr642pf7sAMpMZvzQk0mkY+5E7Cwoy/YkFAXzgMo7MsOePmPh+k6RvWxUenIIw6UD8U9+UbjxWD2dJoiWvk8TIteV0mIez9izhoEfqPGEQHG3mB10e8j+QqDT19ueIYjQj2nE4dyHl1q+LaH94H99S+c/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V2R8tnQm1jj3BtjJAa+Y75ns7Hp5w8zC/XoR7/kX9s=;
 b=KCeM2OMRYtwrEgV/HR3Sgl6XrqqiUWVRvBB7slMwhNuTOHNOUSmOYPH2ap1bl20+3r59tgAx5hhJWDF4qNVITSWByuczDPl1LABcDJaTaXwdEfsi9ay4hMmFgPvaByShvm31RN2ZXkh7QuV2SqZGg2/Y9Hms2qOX4zjdqBemBpbN1639SBE0jNFy6zldeaH8JL4k/QULl4003R1hiWP2rE4RA16HMsz6i5tENfJNZcYh9cDB3XfTT++bNkGlGiH49dJLSu3QUzkSHtlQUR0QjpcVo0crOr+X8H3r5YVL9cdKJzsK9og7mFSOl9a5QRue6lSwPUSKQbbTQKLNoDreVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V2R8tnQm1jj3BtjJAa+Y75ns7Hp5w8zC/XoR7/kX9s=;
 b=O10oKbnrxueJB7xrSTGvuJwyGIov44M7+rcFnC6710/l5e5QYnO/ajS+7ZuXwVjApfuWW0BK1whmzndKIYOoQd3e5cClXCVoaoQmm17DlYonVh4d1lTU2iFjRPffH38sZd8UMZC52lkLkPlM0y2wjRgFlDsTpwK/r8Aztl4sD+HGeWwRLTK2kk9sA2tG8/W9+Hpdx2+p9vbx1qPf4Jh0kyZpwnwZFvqoateb9R6KtiMF4Kg6R79isSAmXahtsOTzekwY+GNHluWMiox3yJZgDK9pzdfCiA5wnm5DaVEvqh6u2Q8j+k+IGk2te2nMsnRyMG93Erpx7TXmzFjcQvWgmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by TYZPR06MB6467.apcprd06.prod.outlook.com
 (2603:1096:400:464::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:47:23 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:47:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH HID v1] HID:hid-magicmouse:Fix repeated initialization
Date:   Wed,  5 Jul 2023 21:46:56 +0800
Message-Id: <20230705134714.2801-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To PS1PR0601MB3737.apcprd06.prod.outlook.com (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|TYZPR06MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: c52bbdab-a262-49ce-f370-08db7d5e5c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PN3EC2cJdBXHs83i6tTjI0N9qRhUCCn+jzgtHRVKmKsU+4EF0yPhF1E/1E8a9GQ+GKBlKAYXZLFUyX+kkYg0oU1JMfQWxS2hl7pwAmIHZH5HmDb8kudbTWFJNHpb6wtjinw/d94l4t4hoFXc6N/KTnmlnhSs4O8KBg0Y47jlzuYuuRj6WzkTk1k8ZqYrhPPsaZYJejJwodWxuQ/I4Slo2uve5ioHvOFBGg3AT2sdz1Bpq+HRc85Z/7DrIoWBoH7zI+C/WNVig6+VuQ2RviQK/ocXLLgXUJ7CbbelJUQMPA1YZyTiQfM8qFzFmw5FsNZIKI5IDuybUTkvBGjkdU/KX1ArHD01ApkGMyqwR65Ehg1sudEVUvUjNLaWcpRjs1dW+qarWtpBZNUgrTbWjPgy94UHawcvb8Qtz/LhjD+pSarV84dXQyXUq+f0sWOjEeZ7hx6psZ+HsahnOif3Q7LkmB+GYg5yTyTvZb3Z2BHrT99Bcx7o3RcVnGtyd/5NNDihTBYMjRHofvhzuSVySyGpBn57M6DH6PapAw7jYURi04R2Ofri53NE13euAX2oIbUrCYtrkyHyhTZ6Tj++lL8tvp8qDWx2FkSfUo+DL94w/8DSzul5XJby8xrPi7i9HrQ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(6486002)(52116002)(5660300002)(2616005)(2906002)(6506007)(186003)(1076003)(26005)(38100700002)(6512007)(38350700002)(107886003)(4744005)(36756003)(478600001)(83380400001)(316002)(4326008)(66946007)(66476007)(86362001)(66556008)(110136005)(6666004)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5V9MQaAY0j7vuTo/Nd2sOw0f81FpVzvnj/36DgMK3iczLrRQauMvQ33c0R1w?=
 =?us-ascii?Q?XhmZqnOWvdCr6Q5430zBm4HvClbSPOvNTv5veoqGMrcdoIsGguBpyndJfEiq?=
 =?us-ascii?Q?fiaQbqIKlWrpp/5MiWSw6zThQWdQwI8tODWmsCfnE6c2AvrAbOLOXQor5+DW?=
 =?us-ascii?Q?0NNU8rF4fUcQHcuq2Vrcpmy572L+6SfABKeMfS4WSyk9bYjgAB8oNFsWWJ/o?=
 =?us-ascii?Q?XyQayTVbjv2Ea81p60InCAqPqpF0hz1LjDgAUvmDqXfP4iaFCp7r20/Avlbh?=
 =?us-ascii?Q?Jtos4drfkXxmuI3Y7ZwftI9yg0Aoh9rE9SvcYdpMFbAU2VOzSTuo+fQbtL2p?=
 =?us-ascii?Q?5NnXpvM/jiFMGcu5nx5tNx+r1YzhWlVyg+iy2yYCshMK6tune3vIuNIsxzXv?=
 =?us-ascii?Q?LdE1y+HavWFSYbXS5eWzEIHszLMJ/iSwGJhrZJZl3G8L9TVsDOKoADwU9ad+?=
 =?us-ascii?Q?IcQ8hk9TUbUojlOgTqCcega83htu9yvwLlu0ptZznEbX2LnGxv1yYUswgCZW?=
 =?us-ascii?Q?9+d3EL4jQeVJC0/lKIrTmn5DosmYyp1pXe20vlfnn8jBA0aWyVAyG3YabxHw?=
 =?us-ascii?Q?0qVH8qUOBQ8JYHd9bM0oq7oKSqmHBvvD8llTAzKmUH5H8dB56hVrdnPF3zYC?=
 =?us-ascii?Q?pnTOH+sIpOywF+w0c+Ju3vXfQbTgXmK2aTbCEdMgZCx6/Nvrqnz9cmR7wQSC?=
 =?us-ascii?Q?JWAm7tfOVKVTev6iHNP0cbgGRB05+OAUJWTnM4cR9VNxUVGn+9dUhsOe9Afg?=
 =?us-ascii?Q?Vv2trLQEuae4L4SmBk7hh0HuCvP3O/iB27gCivTajLDD311P8HT5MSx7X0z1?=
 =?us-ascii?Q?UO42cI7v5QShZXu+BKroQY3Mu60avxUJw0m/o41v7HtLCZUGvj/bftzVEzXu?=
 =?us-ascii?Q?FKpUDztmr1Fp5ZpdsxEIzQHYOgoZsIgUTezp/mKieTIXC3o/32K+mXwH99T2?=
 =?us-ascii?Q?YR6Ec50c91VzC1M4kVPB3oriaIctAhmNs8ixETs8tB+ebgeWBPv9rWL5qt1Q?=
 =?us-ascii?Q?JvLqlOmzl0vziq1OaOaVgEWyadey+DNWkY53fmgrW5Ofc7TyUsCcdM0BS2Vc?=
 =?us-ascii?Q?8Fcxlg2k5w1+SUxtIvrSK+xBwc5iSTKI7T3cAp1FfSsKLeFMzxuouc7HGY28?=
 =?us-ascii?Q?XjgPS73qZUsdA7NGs8aTwSN7MhIRXB1ZIpBQ0kc86myxB3nFysugxQVFOBVx?=
 =?us-ascii?Q?TZOablaredXFXqF7WTrJfpmJGxJhnA8JF+E4FmJNSOcBbSYyiOb63g4OJzy3?=
 =?us-ascii?Q?jKN/auP4+Ecbcw7FV7bc1WKNs7TC+cx7mWMqM+5N9AC2bgVx26qVU0KkxZAf?=
 =?us-ascii?Q?gDN15zAu0djwKWvtlaFaZ695PrczIXvVa1KoAcG2UhZ6wxrN25x4hZj29FV9?=
 =?us-ascii?Q?qrztkVGGcICw0omdrG7ncQx5hDBDibEWn+FpociIi6suOP8qAs6N8brd30i9?=
 =?us-ascii?Q?hst5jtPP6d10B8Lv87Llb7f4lTh8/6zfPQtuGmI+GWt7S+wQtbBSjmC+kLRq?=
 =?us-ascii?Q?3gRtmeMqkPT+aUdyE9LvsJhggygF6UibZm1QkiHSmHyfwsNzKFh5efYk7Khu?=
 =?us-ascii?Q?fphDHE4VavpuN5auy2Vkevm3j0HDrb3PPtjrWPAj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52bbdab-a262-49ce-f370-08db7d5e5c64
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:47:23.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL5DuocRT/I9RhpJKP3J60ZrzpH6SdVDnnP8rycAGyVqVdMGEHpoOn+wX9p1FoleHTGcBO2HLGuE6B3qyU44bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the first report returns NULL,
there is no need to execute the
hid_register_report function a
second time.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/hid/hid-magicmouse.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index c9c968d4b36a..ae3c78ebb986 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -857,8 +857,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
 			TRACKPAD_REPORT_ID, 0);
-		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			DOUBLE_REPORT_ID, 0);
+		if (report) {
+			report = hid_register_report(hdev, HID_INPUT_REPORT,
+				DOUBLE_REPORT_ID, 0);
+		}
 	}
 
 	if (!report) {
-- 
2.25.1

