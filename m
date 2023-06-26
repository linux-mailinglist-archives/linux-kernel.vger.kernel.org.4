Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933A673DF85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFZMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFZMoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA56E5F;
        Mon, 26 Jun 2023 05:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWJo4uYkbN4CBjiRNVhEPSrkmN3wFJcLsvgnFiF78GFyAMiHitPlGZkgpDUfBJ22+2HiOAJilJ4uIgn14E6t+6IvNL+lie7NTVK4VTsfPAuOTQPwUOqRHINWsHv8vKhyb75+rqkQ8jJ81+lZwfh07RcLG4iLAR7kkOR8zSa+Nq4DmV+3KJFG2SOcXNMqsHaidA11qE7uYCXms2T6iBSgCQlGUz/C66u31scJ5CVZdWmDrYpba7wVvZZyRGJku+3FcYDZQteU5pQAbjufKzo/FG2FlAkcCGVVuuqExw8s6BK+l67TNutqGcPdZH78U+sRnxxIds57HFFnSW9CPTT4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxGTsAwncuXzWJKAN7hRxKXYlt1L21kJGv1I+pqlCXM=;
 b=SvKOjXPyggxPVynRt5ezl55p7P31tHfuIWraR0pmCTIqujXac2bGTZDjZOs5kZ/C2esIcl9QwbIQTeiyRA1gXRRqK6xSbOXALv9F74lZgljnsPsQ3iqB7F3SNXJUnp3vElGWm3/QjoKDcoGCCp3bT0q15dHXLm3b6gjHpVpsGM7i6gOjby3pho2Z0DxUxqj3q2LvvGYiG6+GcBs4yCCZ9u8+8OWGD9OiV7sK6IxEUMdCjLgbzXpfU76VYgsHEGq3AhmO4zjiK8fbVBfFNkx2a6taZL0ZdGo0MpvNHwt8OeS0SQ5lZJllZ8CimZlgx4omdxDibb0kR16+GhfYTEaPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxGTsAwncuXzWJKAN7hRxKXYlt1L21kJGv1I+pqlCXM=;
 b=WkYBm+21N097RJy0yrSUV6d0SwpF0uBFXMdd8w7u0qo29YiWa/1Lm5Q3yZxDLF9OnYAdbvXDtFMDhq8fm6DtBifx2+npd1m4eFgMdZTuVV62pGF2NxzIx38oC22uqdDoJgMeQkgTCylwbh7uXOW5XgU83Z5Cp+SAM7R/UI8dRLFafOfnMiyzeY/Ndgsy8E/AphxvjE3XShs59CJHOJSKI43v3q07+x0mczg2+/duejSYdPiqwdkLBnPVSfLQHleJWcdptZuu+4JEKOOfPacuNi07a0HbnnsrVKOajvd+oKiH+4KCZpYT+nJkYoqstXTWKF9mJf0bsz0EAXnoy2LB/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:43:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:43:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drivers/thermal/k3: Convert to devm_platform_ioremap_resource()
Date:   Mon, 26 Jun 2023 20:43:28 +0800
Message-Id: <20230626124334.15100-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4d439f-6471-470b-aa4d-08db7642fe57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpOregUXZooThNZJlvTgDQKDHZNWjSAIYKPAF90yOl0ehI+7jz8Qr145C4Uj1q/0hnMgceX3+QzCDqVTUq3TCfsyLPpstxraiKMK48svRRT/TP19tdgGzq7+wz0L99XJpFpwQ/eUtwQzSjJHitEQuF0tRYcj35F8Auz3+RHgiihnyaDLbZaatVmKHwTwjrOJJu1JkKyMebAzD7E9tLDuZd99bdLpRUQALIYrk68UEZSP+mmj766U8wDgtd34HuPjciS/mqb4zVkE/FrnNJiw/pK3j2flU9Rivxxv075mCFROB7xHjKC7h9xTs4hNP84yqW+4zclA8R88A4Lv3+xpSp6F7PJ8Wh5C3zet3kI2B0Iou1Ab8HnD5g7eKvuI1+4tUIvOF47ZQgMRpHbjm2aPTvVEIg0xo8XoQbny0BUKoULoEts20l6qlp+mCKOBz19wShT43/Y1ZoD/ptXEY2rPSvNRxbV+GMTT3bMFRN0JcZORN07EcF1St4ZxD8SyM1Y1JmVeXngJoJuPRJFqWxUnfSGaAgtn20q48k8HMd96d9/V4bE7o1Yw3iQyvw4FcswkfyEHf1Uw5b7p0je0Ie2rFzpVl2DTFNJK5z/LP3LTF4Kcxg0yVhA6cUu3EkoIaK38
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(4744005)(6486002)(52116002)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(41300700001)(110136005)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(1076003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFYK302EK4pl+m0/9PfC8E6nrK/tLtzb+M6Ei6ng3KoXztFFeyNqt09o7FmZ?=
 =?us-ascii?Q?xXrCRzN6FZ6RhXksoUjeWaQ15r+dbaRMU3q2omWdwNyidZ8sQ5zcKmrurQpe?=
 =?us-ascii?Q?/4T+wNVCdV3gunwtqEKnxgM/xJIu8zoQhxTVKRdec3cIZa/UFmuT+rYQQa2r?=
 =?us-ascii?Q?pfC7cUsPHUYjgPkj9D6vTSITHMNCZRdLC38bsoSylVQITNxIqenTQha14Yy8?=
 =?us-ascii?Q?NsJ12cbeKT4Us0bhgoxRO3W3D9nyYzHHpMW4Y3f9i7N+AQCC5DmJjq9JwdWc?=
 =?us-ascii?Q?fF2D2EWvh9XXS2rvCztFhLUyVypQIQlt0ENxaq4mUnZi/QhDpTjkzWpgv957?=
 =?us-ascii?Q?J+MJBHX9HBZSacFYeyCWnFr8EdGPYBGa2WANR4NtpJxwW/tpt+Pmn74UT4Yd?=
 =?us-ascii?Q?VuPqK6ASH+cEs2+8v5tKomjki5nCAGp65elkXAu79Oy9trIrjGNXqYpRo2kn?=
 =?us-ascii?Q?8Q4JV2XYhIZx5R3BXCxFD8TqWez3xei1XCqySktNNlKF2Y4k3oiPs0zzSP1s?=
 =?us-ascii?Q?HQ69L3v7Mui8WBb8BkRJG/ArIy7mbY67P8RyLG+uvu2pt/zqEOL3ej9SqcoG?=
 =?us-ascii?Q?CnFIKhTqb89Ahq0/y9bJB47PiJzjTWjASz663ISezSjFUFGNqAcA8X8e0NN9?=
 =?us-ascii?Q?eox9rJ2Bv6VSC447m3tyGWEa98rIwmcB6mQoPoMqfjEGbcptV8vxH4fDjS75?=
 =?us-ascii?Q?s1BxrmpZLM0w4S48FL5JoLRlyq3/HVWPMoQAZuxXcLTycqdwFTpRuYtP/9jr?=
 =?us-ascii?Q?Ga/vTFZR6RzClr5y+X/J5WAcTav3SjyYGXMJT2vkxCtgJY/oMgDMUD7g44V7?=
 =?us-ascii?Q?Al7F5idsevnJ24H72flTNqQy4ejzdhOatdk1MvvDzi2v02cTyc3SiEiQBtmB?=
 =?us-ascii?Q?2LZq7yhcbEIIYioloaLuJgNTQqAkEctDOU9s7llPjr1n02gt2GFkle+hSkLM?=
 =?us-ascii?Q?OtXPHfdFn0i4BE/PvCE0/79Uz5ojDJbWJHbXCop03L4GIKX5dHe0nGqAbjx8?=
 =?us-ascii?Q?1TK+fztBLOgjWRtpyAR1CrZhLIOBlJxWeO8KEZfPkvIo5uk8Z9vVEPONi7gU?=
 =?us-ascii?Q?XREmbSvg7loLC6LHY6UCxzyVmJrY/jRTZKOrKOV0R/hoDPtKP+r4E4+bveFB?=
 =?us-ascii?Q?jVHK4ocIiHDSAirxYZywFZ5iAsJm6tq288mw5+0F8UFIc9DLVQ7fhVFwtTDS?=
 =?us-ascii?Q?phYi4WG74uZKpIvoOfiOBQ3BFxZ/RpmiUjOyreTwk02hvIEsuCd8TSakQM+1?=
 =?us-ascii?Q?UqppEMhuo7h9Vh14Ad5fM5zAI46NktOn6DCs3Ly1CqlDQvPBUF/9WKJVJkVI?=
 =?us-ascii?Q?ZF08Sb0KyuYqWcMdI7shg9z5rs1N5ouLoruj4/nrW12gX2aO9fFLAYZSAyu5?=
 =?us-ascii?Q?kjexoEa6W+sHSwdvXcoZ8+YMhXd+czip3Fm5XE2RefYQVTHXxINsKl6ihGfq?=
 =?us-ascii?Q?UyOynXKvDUFSkNP83NGMGfGdGotstYN07vNLTwUcckAeZ4nUZkVm2HxLGDUA?=
 =?us-ascii?Q?W3r9Acx7AB7kWXi4oESfZQCAH6TH0IosxAzleuupVtLWyW0ZIkq32gOl5ZaX?=
 =?us-ascii?Q?Vm2WsrKYzZDxlqq+NzSxYYwgwa7GGS4L4NMcxu9j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4d439f-6471-470b-aa4d-08db7642fe57
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:43:51.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUuahRRtJ2z3IcGWGeCqDCRwtbdCtnyl7/b7HqFB9p9IeF9hgwbx4mXaow6KXF+Z/BZ0y3NrRtnVeNIXmmJ27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5320
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
 drivers/thermal/k3_bandgap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 1c3e590157ec..dadb5d070455 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -160,7 +160,6 @@ static const struct of_device_id of_k3_bandgap_match[];
 static int k3_bandgap_probe(struct platform_device *pdev)
 {
 	int ret = 0, cnt, val, id;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct k3_bandgap *bgp;
 	struct k3_thermal_data *data;
@@ -173,8 +172,7 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 	if (!bgp)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bgp->base = devm_ioremap_resource(dev, res);
+	bgp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bgp->base))
 		return PTR_ERR(bgp->base);
 
-- 
2.39.0

