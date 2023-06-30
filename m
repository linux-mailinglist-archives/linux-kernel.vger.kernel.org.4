Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177E8743480
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjF3Fl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjF3Flp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:41:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85814213;
        Thu, 29 Jun 2023 22:41:07 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 35U5HZ9Q009019;
        Thu, 29 Jun 2023 22:39:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-type:mime-version;
         s=PPS06212021; bh=zTTuOVHLLRNqld9LMcmgbA2VzRMGfPUVak9+vWIfmcQ=; b=
        CY09Zt9rM+9KV/RawATK/bqBD4yHaX0NXnVaJQQayhMz+MysO0GpGe9qngKA5cDS
        vWOZ7UJTiyp78uS1yxa0PFTqTZesI+v1GWmFW3f4885IzrVVyMJG+y9Y0tk2J+cQ
        ArBBgboUMDw2IS/U6ZZmgnpMm7vuGmtyUdNgNoXHsDMyhQDGY6FcnbRhKZs927Yr
        OmBnNwCFY0CmOasu6oIHeAJSE5xk8+SqwTtu9Y7KMBmO4Mbv9tU+o/Qj3yeCas0q
        OVMUTwkQn+j0e3x5UAxnqmk2Pg4znJBg77WsVRVYfkZ2Aw/8FI6YyK4e55Mf/PZ+
        htCXDT1EA1VP8/b3XfTgIg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3regfb4s27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 22:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayulh41vIRcyZyHpknAUGuP/wl4qL6xAFcYutEUPIISuyoCtSEDRZcxvVdS/XS3DFh2iHKM3x9RRCA5H1iVIBMDmTTqAUDYnes/+IK/gb+OvockeQSeBFjprhFMhz7wX3RbjTNr7q39b/2qgOsynHhjdWZw1K/IfJVtX7fcJ00pOltPDb+eDjWU8J3+MVFO96LNBIbMtpkALFGPt6LPSAIKDbm7Shh8jcpNJ/qsj3yvgFyJc0ffWLqQXZGPGnVHSH6rJsEYbFODxTaC0XfjRjIOdvgdusExUw5t3OuxWJMzlqj+5OoY6CrBkRV5OTaE/gneVl1crOx+Lv6K8pvsVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTTuOVHLLRNqld9LMcmgbA2VzRMGfPUVak9+vWIfmcQ=;
 b=fmF7+OuXzM/AVKjNDqF6mukQcGbzv/go4YHtknxDY5nzlIVDDgGJGyx1HsETyKfLOAZcSeDj+NhOY8PS3+JXVLOvkCLd2gJUNn0xvtCTYB+Qolu7apAY3m6tPtArB0vnaFzmpEnnctI7TjjwpzjjtOhJd2xp5RFZgEqwDjtPZ6hIWii9UZS3ds6CNblSQG/TttxebvHPtW5ssg/xgWbBukVkVmgrhBhaQeU0AKAIosJG5GU8m4HvMtep2JBGs0tSEVC4FeEVZDBQ24KnJI95wa+4UmyXY2AoFPjfNK0kONtduMUI8n6bK+qQ8sk1QjzMmyq/dd7p8g2vIbjfkmUzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 05:39:33 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6486:ac38:1d24:b030]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6486:ac38:1d24:b030%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 05:39:33 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] watchdog: core: stop watchdog when executing poweroff command
Date:   Fri, 30 Jun 2023 13:39:12 +0800
Message-Id: <20230630053912.28205-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d84118-b2ab-427c-97b3-08db792c617f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/a/Q3bD3APhK+2focGcjlm001pNIvTes7Qtm98QVppuSweHEoyhiKoIM4raWZy4Zgvp3N7GQokkqKXFS2XKBQ2dOAgCPveTO3YZBFhn0uGazXaFT7n6KaXrFz2aH34CUZ21Rt0eLpjodVoVflPwguDgZspCMnCeZa6XhfZfifQhhjyXJPjZ3eURHiOdmeqanR7KGlQIUG2cdWwMAKf4zCptk2L1bye0gJQvf7BtOK6M8C7ttNU6FrwNPOkBcOHfd4zYXx50PXE8NTGSBTIy/ggQkCIQCjxfpEecfaXRuaQWWXBEt3QZ1IgT4uKUWurhQ/MtnLI3+taYLm11PPUbmLx6bdAo5kDKs4DKWKSTRazqVlD1F0T5+gN8dzT/Dba4ZKb56LEw1vHqRvihPlsdGmNs4mpfptwxXxV7PcuVS2cBj0Li7ACR5p27VbtZ5uUnW/Jiz5sinfBLSNcHzm2b+Zf5GTP7EsAX8I1FkDm7Uf5YqhKAQyqvRqjSrrqk8Y+P0E7MHp3CnHs6Z4I6Oovlbr0XMCHk8yMnIOXzvx+LGy0kTPB7CBZ1Q6U3BE0J3DzpJkCIX2wl2XjA03nU4/Q6nfDbt3vRQ9CoZuL8/7dvMIjUtbKEAh+wipShZziRa8n+MDA70IbOJFcZl4YvHKJAeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39850400004)(366004)(451199021)(6506007)(36756003)(66556008)(107886003)(6486002)(83380400001)(478600001)(26005)(2616005)(6666004)(52116002)(6512007)(186003)(2906002)(1076003)(86362001)(316002)(5660300002)(66476007)(38350700002)(66946007)(8676002)(41300700001)(4326008)(38100700002)(8936002)(207123002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shkUgEXNNGIoGiWmY9hQ6vwMzJHN3/ja8bW81qXUvB+C/d4IwEtVluTGSOtL?=
 =?us-ascii?Q?3DJu15yiLdlhAiR8Q1my3g70P7TRM1MNAe5kKjUyWb1Fs3233MUIjlbMMlch?=
 =?us-ascii?Q?mPLtKWS/cMixXR4iBscI9m3fE+WLyLlWJgDc01Y2qlEaLhgBxCzZavZeUGw+?=
 =?us-ascii?Q?RHHRhoVpW/FN2X4DhvA/bITCuwKx8EgWyPhiDyc5mFW+DyvjhoJ5C/AOi6Xe?=
 =?us-ascii?Q?BF73lOT7xbkjk9ft1k7YKD/880xHBCzCeQz2DkHDYQEoi711vblTLjUASGYS?=
 =?us-ascii?Q?cwc2HCNbY1ZZtlvgWZzw6pDGv/W2YGKzyW/Wxzeck4lvTwijHnRSwNUd5s1J?=
 =?us-ascii?Q?MUrJ2uFH2MJDSNMLZEOEmoyogA9lnwKxLfme3QRPkL/ZQ0RAyrRFVmgAUP2D?=
 =?us-ascii?Q?1U1F01R4cDdXhU+mfrAmBtcbU0+qvmYAVsL3sUIkzvg00CYDijCwg5WVAysM?=
 =?us-ascii?Q?xYPA/MW0LUFf1XOkbUkadoFWzPheYnR4V68PC9cHTMZfFOSWRTfG7q9yRM1b?=
 =?us-ascii?Q?fIn13enffCtnIv3G5qzM07vQ49zQdZ9+bDK+l7cn7aS+Bg6XXwCOmxvGppYo?=
 =?us-ascii?Q?LQWoioTFwjtHffWRXXQSwKgsyfQHiFeszrN4SuMnBZ3RUgJx4QvxzJgUKek9?=
 =?us-ascii?Q?ZPvSOXzdl0daQ4hoEHEguVZlSvxHaIurfFQnW29XCwT3Ezh1qZMvMVK0y12m?=
 =?us-ascii?Q?/AXNP6YCV4lohL1PxDdBkY3tTLPrWSK1+hFcHDHTzO+KuNyIKpbQkxVhPg64?=
 =?us-ascii?Q?CO0tZoZqL4PyyIBMcuLL87dvXWFlveG32kfLws7eBYRE6k+w8OD9PRNGmL7V?=
 =?us-ascii?Q?iK6MjXdLNQXJCTGPIbfOxFG4ER6HJYKdwS67KnJJxoM1eI3SuszBAuViztC9?=
 =?us-ascii?Q?lRuMqP5fjo7XgkZBg81zN58v6gfuVPHQhOgSt2AlT0FRH5CUv1KTNUyvXBM7?=
 =?us-ascii?Q?w5EOkrJikUgtiOdwjE/Fk/PKjCH6lHc9PHG9zf6TyM9FQl8VgpQ5MNE670h3?=
 =?us-ascii?Q?GS6xSOGkSl7EUOVtgpgZ1Oiew0ZY8ZOyQAc/fuKAZa2PGipiYTXoYiHBi466?=
 =?us-ascii?Q?DgAU21zPYKKcIyKyLYSHWnX90C5rl9n0tk44zw23JKSg9Wh4wz5glgr7stsK?=
 =?us-ascii?Q?MaT6WzXVArr0ldiXAWBFgw7wk8NY3DU9JEj/D5h8be0snGrMwKLTRfldKC9G?=
 =?us-ascii?Q?SBzHYAb6bp688yBjv4/99DtVbuO5Oa7/dhpfyB72sOjwFc+e06vtJtiq9+Ps?=
 =?us-ascii?Q?ItPuPMEfxq98tLK6sY4fEzlMxkvKZhHeO9OemPkSQ20p7JATYq7yor7lrpRV?=
 =?us-ascii?Q?xHxeF9sQWgoHrSgj9mKEXYVe1zFOoApgI4gj3+No6XxLAjy61dyeEu11UrZj?=
 =?us-ascii?Q?Uxx+ndsne5r1sILHnF8TQKbh/C7nSe12lrnU1HXZ77F3B/aNHN++LOZRXoop?=
 =?us-ascii?Q?5jpPL0Y1FRKiULO5gdffS9TM4E16cUbEZeCsYx09n6DcvylyyfuHCcUuSFVN?=
 =?us-ascii?Q?OBBX1l5lL2919SU0OXEhAvub+8viNe1JFXSfyNmG/w7P+UEAEpjuYyNo7ZkA?=
 =?us-ascii?Q?Pp1dCyujk0qS7/LvzGrWKfzgdVNAV9nD+HmdUhR9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d84118-b2ab-427c-97b3-08db792c617f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 05:39:33.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm+XXQwJ/AClnd0OYOrVDpv39nrg3oB99C7pwCWtSRCrdQGQU2rVxHXsXSWb9+ZhzwZvQcPEmqYf2Ki+BAf4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-Proofpoint-GUID: H04wvppI2e1hbbetamkj1KsVxL0XK_bG
X-Proofpoint-ORIG-GUID: H04wvppI2e1hbbetamkj1KsVxL0XK_bG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2305260000 definitions=main-2306300048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Li <meng.li@windriver.com>

On some platforms, for example, Intel SoC FPGA platform, the watchdog is
started in from u-boot, and so kernel will create a timer and work to
keep watchdog alive. .But when user executes commands "poweroff" or
"shutdown -h", the system is reset when watchdog triggers timeout even
if WDOG_STOP_ON_REBOOT is set in watchdog driver. The root cause is
that the watchdog not stopped properly because the SYS_POWER_OFF case
is not supported in nofify callback function. So, add this case to stop
watchdog when executing poweroff command.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index d4c5a736fdcb..5b55ccae06d4 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -161,7 +161,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
 	struct watchdog_device *wdd;
 
 	wdd = container_of(nb, struct watchdog_device, reboot_nb);
-	if (code == SYS_DOWN || code == SYS_HALT) {
+	if (code == SYS_DOWN || code == SYS_HALT || code == SYS_POWER_OFF) {
 		if (watchdog_hw_running(wdd)) {
 			int ret;
 
-- 
2.17.1

