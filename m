Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB06E57E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDRDjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDRDiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:38:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889CC3A82;
        Mon, 17 Apr 2023 20:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDb13+fJXBAm+fQ4i1Zm2nwOJoMcAQcKqJSe+sRcSTwpoH7B+IacJcVk9DnD+EsK7OwrBXNz9jyaxqcvwIpd+MNU89lmwsnzLpWs9ou2kybH61YiZEhw+M2cHdvTim9lEnTqRh5LXn2RKmdI/GDO4QkU3yzbuGI6cfwUCRaJvAYCrJdV6Fm6NbBBW7irr4UOENLMOsaEHKrLNPKeZbuuaVfrbzYewsrgElF0MlXLKQyZmbBAH+w7HgcqABYYTQCTine9q2bBVII7ITeYJrjaGKkpCVCp/gAW0uxXhGcNW0Y5TEz2U31XJIxAQlaazHb53R0itUe2MFETKy2mIbbpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaICu54u62j1McdteOTRVQLSttCW7IxKd8j2FraQSzk=;
 b=l6MBPPO6T6GnD74aq5JQKale+v0R6ee7g9suQQpMHziljOejSynS4szK089JGuubnbc1HpWoGIv2hgRSy0pONo9zu/XbfxFEllvjJNWPkx6VsEaYp82WV39CLUw64VcDOMueyruRFtFCAjqrQBlp6QeD6hP2TDgLtGREJl4p/Yxr6TFF9bmsv10htBQtBV+pplJwQVIhgVe6+hSRcpWcXRXnyIhrREjoyyyns1hl17bNxHWwuHKDV+sIvnk/INjiFJAqk+W79m8j572xfuoDCkH+7bqQCixA0tuOUtjRe8cSnE+VlgVeLWmkwalZ3ELIR5fkM03yT1ABoGy3/NdKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaICu54u62j1McdteOTRVQLSttCW7IxKd8j2FraQSzk=;
 b=gELDYoAKbqaK9oyNXdUXxz9Rq8sTJrpe34hqmHe4CscTuQgdLs1HToYsP52qXymF1gWu2jtifplaMtvmXViD8HMe4kyMLrIHBTqONZC6mVj5jufQNsNWyyBphznohZIsB/ej3Bgvxj2hw4yjrLAm0v91TVeUKd8x8lVZZl0ZqOO3G1lc1WfJRyFkev5CVEZW3Dd4KQ+8tnNZhPpAmnzyTrg5EB36V8Q6E96gUPdy1UR9iW4OxXcmCJSNxFZJOcScgj9XvlqFhM2tnlDzU97zw22aSald4cttjldqQt0afenDtb5VfypgHDXraI430mLDWSPIdcit96GWYCL4mChXwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB2997.apcprd06.prod.outlook.com (2603:1096:4:72::17) by
 SEZPR06MB5413.apcprd06.prod.outlook.com (2603:1096:101:64::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Tue, 18 Apr 2023 03:38:49 +0000
Received: from SG2PR06MB2997.apcprd06.prod.outlook.com
 ([fe80::e95a:e2d8:251e:9434]) by SG2PR06MB2997.apcprd06.prod.outlook.com
 ([fe80::e95a:e2d8:251e:9434%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 03:38:49 +0000
From:   Chenggang Wang <wangchenggang@vivo.com>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chenggang Wang <wangchenggang@vivo.com>
Subject: [PATCH] thermal/drivers/cpuidle_cooling: Delete unmatched comments
Date:   Tue, 18 Apr 2023 11:38:28 +0800
Message-Id: <1681789108-28130-1-git-send-email-wangchenggang@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To SG2PR06MB2997.apcprd06.prod.outlook.com (2603:1096:4:72::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB2997:EE_|SEZPR06MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: c89037cd-b00f-4f7e-f0b8-08db3fbe6c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hre+NvBL4AbyVucbVBczl0OuQ2EWG7W3u1ovfbJH5LBvgQhtp3mx/jrs10tTGfSHB2XZIbg1FznjfLs0EkKeap1S0usFztPD+9uN+vhHG2kbeZZp9ryVltkcXWSCtsUJv7+eRhaIP63mTL9BBh2yxiSwG+A5SDE/OmikqMMkbxWLVlqgnyIwRG37sCQDMyJ3obRqtZtuO4mNly+50JgZ/G8byEpGvp86Hoe9bi9c6l0BbOkW4e7JQHKfJeOY+XWj62eUP968qfKjeBMa8OksuTqCfpLs5mgZX/ffSn7If8yoN/wt/VG1mVJIPCKTJwFvHXbVGsg7qoC/XrBy7knJU+0p4op6PSzJAwXwYFJe3HifD6TtINsNUIFpkzXkV/Zj+03Pj3jhw50DjlbVa/spCjQp1PbLO1PeqSXd8LykHxtgU6OfmsWivaCE73jMdUbGRndxwwuHShCtIzy69sg3vBkxBIrRihBV5r052EcVM2IPAWBeSpLmkGPMes7bNA0/F7q2lY3TiCflTZ0ACC0gQ4gSS+lQik5kK9slITJ9Jgzh+YnBnu8ClwY/ehvLEGatKOYt8qZTDwH1dSp3bNxpnyQ8CTZTMfALdsg0VpQSaHGPLDicjf0G5ey3C/MNenNF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2997.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(5660300002)(4744005)(52116002)(6486002)(66556008)(66476007)(2906002)(66946007)(4326008)(36756003)(86362001)(8936002)(41300700001)(38350700002)(6666004)(38100700002)(478600001)(316002)(8676002)(110136005)(6512007)(26005)(6506007)(2616005)(107886003)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ofmPD/l/krzpCLeRaBA/hr7EA6ohFyyCezOnTNt1dpsUlU9h4pgr0NL1OtjN?=
 =?us-ascii?Q?8ojteOTqSJArFZZN1pmEaawrHGBFIOEoxdQYxqfcIif3eIlI4zQBgtYrqHAx?=
 =?us-ascii?Q?OIT156QBLJE1uWSvxGQ3t2ZomG2eIrstxt49xap0tSo2COGTKJdzrJbbUJ5y?=
 =?us-ascii?Q?KGlrAh/ZfgzjDfpk/1RShGFx/kkVW3up5A739d++RIeB43HsnZa0G3wS4VGB?=
 =?us-ascii?Q?exZIuY2VBt5XzjLIXgIZSKkYEtofLiVcIq5l6+M/WmRyWUs7MOIHyXRrGcUH?=
 =?us-ascii?Q?KyDLxI9WlMQBbL9NegMvI7BVn3sQJM0Q1d2+jgDl7D7/ibaYHTAx5RZWyWdU?=
 =?us-ascii?Q?sCGsgPWzuVnqK5MVwkfRsOiMUk7byPyMyAWIzc1c1V8zfm5XDmTpvXCDXZEQ?=
 =?us-ascii?Q?UTS3cY0jg8Z4cSXdpumj4/4xlCqQxc6CVtWlTJUlXKklfL9a0cXpy7/Oa5Eg?=
 =?us-ascii?Q?EwT0QqaO7D76TPvhIwjg09dyTWbsSKsy03/HLIA5vKSmwfeHi+CluOjFWth1?=
 =?us-ascii?Q?aLTY43DIXGmnz9NrEmEvjFUhZGOsIkDVZY29i33wIK9MvONTcN9hatafrx/U?=
 =?us-ascii?Q?uGblanThieOM7JFVaCleV9X7i9UOwUriYSSdZ3sCBbEX8fR5kaZa0PngE7P7?=
 =?us-ascii?Q?Ef9mbPblRlaOnV/jkUN5YIaGBbz0EhMFJ8lrC3Yl5b2nwtjj0TUOxnMtVSgk?=
 =?us-ascii?Q?cXquw/vmKqsvm1MrmhmtQRIDl5twJz+OOOKvTldehFIBL1EoYlZ6SnvX6D5q?=
 =?us-ascii?Q?ZB6Ad42UsXaZprpl2PXwJCzBX56fvP+074AarqpPYnFS5PdgZDB3btxYKLBO?=
 =?us-ascii?Q?YAqyocKmqbK4AjKAEb2/dzo9axD6jV2cfpsgAMf7/TvujXv8jZ9bYhyakYgU?=
 =?us-ascii?Q?+PiAlStpTYd7B8x+iV1URl1aQ6lvs9fNi4tKef/6/ZHP3HrO5bkG3W0YwmBH?=
 =?us-ascii?Q?Ag7S0zBgbhjCIBadbagtN9WVytOc8VrAc4jIY+Zodg2vMPdE9J8aDQWJnqEJ?=
 =?us-ascii?Q?5Au1ycHACu3MnuOzMt2RsmybKIT+YmjUIbT83mwiITDUzpFJwI+VhyrJ8Unm?=
 =?us-ascii?Q?YB21o3MNffJe0kRCPmH0VGIqBCE87BOBrlZhGJ27WKkcSSXf4/lVRwxsYz2r?=
 =?us-ascii?Q?cWn4jpRttYJjrh8KP6r9xBKolulltLuo0Y721bqgBL2X1nRnGcpgYzfGsjRE?=
 =?us-ascii?Q?tDM00/ozTl8O6WphD6XojbHt532Cv5/es5c9E+HucX/sIrkx6W3ao4mjX03+?=
 =?us-ascii?Q?p+MeYcXm5F0n4F4gEYLTuwVtW9CeOwtwPp9ub/ugbdXnmJH1zXXuXOk3Emip?=
 =?us-ascii?Q?yTOstuc/b+/2MJkuZShLjxmHKugopYoznhGXgbZaz9E148arqyK/YNIlSiL+?=
 =?us-ascii?Q?DOlWMeyqkNZlQfvbSAwM+zTOk2QEwv2eRvlk+SV7KOe9O3ChjgpRqpcZD/yn?=
 =?us-ascii?Q?uH9bQEgeT/tnzYZPB4BOUcCzg7ujLYUwpE98kKNwrqZHj5AS2tHfjTQjAh3e?=
 =?us-ascii?Q?V3G7PJMppnBJWwvZvE0f0rmy8viTCBJUeOIKx3ftJBIkTr4LBC6YTEj0weNb?=
 =?us-ascii?Q?l9dFU9p6ZfTbtWOo+kPFbsI6AWy5jkdua6V/6SXa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89037cd-b00f-4f7e-f0b8-08db3fbe6c06
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2997.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 03:38:49.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y66fzi2WMUHjvDAilsTcAYZiBBMapiVJ54o2VRVGXkvGMQSnp/dWW9PqwuH/mshH5PSECrQCM+160aNLA5g7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function no longer returns a value, synchronize the comments.

Signed-off-by: wangchenggang@vivo.com
---
 drivers/thermal/cpuidle_cooling.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 4f41102..7779739 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -236,9 +236,6 @@ static int __cpuidle_cooling_register(struct device_node *np,
  *
  * This function is in charge of creating a cooling device per cpuidle
  * driver and register it to the thermal framework.
- *
- * Return: zero on success, or negative value corresponding to the
- * error detected in the underlying subsystems.
  */
 void cpuidle_cooling_register(struct cpuidle_driver *drv)
 {
-- 
2.7.4

