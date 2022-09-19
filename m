Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C45BCA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiISLPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:15:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05471056F;
        Mon, 19 Sep 2022 04:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQrNe2aBq6+Ryn37uZkebABJXYWQB3WV11k/Erbr8WjTdI7fwJIkgySQjXTwjcID19tksMMGxl/g48y3KmI34g2YfoEVNQlMzs6I/sqKlMc0H8WaA1FcYOf43kPVi61KPpk2RuK/ahK74uVXzLmsuY1E5XDHlJftadGaDGqF4wELdOmrulWAE7SXeeigYGHe+D9/Jpdm7Aa+Ia/bAg+ZKdOYn2kgMVXWxETQ/gVVL1QYw5v8ZyTwb4Qy1XNtaHgyAfCfwpS5HSe3uhUw5UZDaitS1dURiPYxIxyLuxQMhUl0EMM2os7+PeoIBOXHpgDoNGgumIrUGNcbt0YXB5f7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMse0NqRRlDPFqRSYl4YRrOAmyV4kWG5ZKnkF8HUN3I=;
 b=OoleYjOQjFYJPmkmAZAInTVQjr3SPKMJ+3iTZmwZ9GvnaQj+BrLAI39xWUxxDCUPbKlLStzrbxhdz16iKN1asy5y3ZBWRNo3H+S42eVv8Q7zbE2/bWKVJ9XACtJMkI7VMw4qIL2Nkw4fXk9r4mbyaKZMfC7Ir8DT3DjjMTbnbIiXAopfQYY1OkukEh07rSk1IKG50h3uwv/wLjN/noDV+zC/XqUTQHOZWIdo8TilmaasFPwS3hlzpfHGIX9nxrRVfFaupI/6GIO37CdpIG8IP5s5dDAyq+3nSFw2p00R250R2X2HxX5okFJKPxteDjoacPGElfO7Hbm5e015Ru9tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMse0NqRRlDPFqRSYl4YRrOAmyV4kWG5ZKnkF8HUN3I=;
 b=lRuCaqAUiLcJvvZPSuMPplkYx7O9nzeM+2glCuG6Ctqpq6NaTNP+VUjoeV3j5zmMdpVghcYgi/spc4urWIHQfv2r0cmRqebZ75WM6aperRA6w9R79LryNgRZebAXeGBZW8eSg/LUEB35fLcpb2VkLf9LxtqmpotHOUUCZ5/p4OFNH/hut4EqYvkwkhvKCvI3XjIN5Vt3Ftw55aPqizjtmrcgpl/3RlqXbKfKdWIo7Prdx85eg3nqb3YepXZ1RhOC+5k9Ht4q5VH0ARiS3nj9S/jQ+iKuAtFg3Mm34pRuR/IgtRbJh+l/6oGJZLjWOSiPPssOPNaV/UCRsCBBdbZ4qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by PUZPR06MB5618.apcprd06.prod.outlook.com (2603:1096:301:e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 11:15:39 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b%5]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 11:15:39 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Azael Avalos <coproscefalo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] drivers/platform: toshiba_acpi: Remove duplicate include
Date:   Mon, 19 Sep 2022 04:15:18 -0700
Message-Id: <20220919111519.19491-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4173:EE_|PUZPR06MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7841e5f0-b3ec-44ae-2658-08da9a30487a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjZ+06nxuiv8skEbk/L9I8/I9RfHv+Tnu/cW2wXPX3xKgkN4zG7U1UeEFYddliDswzXsVj8/q1O4b4n4EM5E+BHOlwnaOkvEeKpe13w9bUFoLomJrNNRi4bUC8n2yT23GWl++OdKpQ/PsWM+uSqsWPw6RualcCkb7Q2R7aRKHblLzYjpdmXX5BTj6EP5mMdrqJgQkp9SkxlYJID8PIEbPm1DVyKh7EFj5xCi+XhdoVsRRjUv5hWdd+E9KEG1azvRljRvwh/g4jUCfkun0e5q7pTcaL/b/x8w4oDvEGsJRCNt/2Bao/GnY5Rj/TBrxr92BRvugmHwvGE4wKjMsgIrvCUBgoaOqQi3PCiGUZ0nforP8OWD/8J7xZr3R64KxlSQs6qUleR3lp8QawRTOy8v/BO/lCpv4sjCNz6/J+/k2ij7p17JhkHJeh1SQgrsGC5AuRYQ4bgv1dPHHDlesp8eGVGx3LRxbfPflpnWQ8vT6IqeZvOLEp3wvz9mVnzsI6WZMsQj8zhzNLxxrmC4z/J86YrQEQRUvg2JnfsjVcErVnaJ1EecH3ci0tTPD6I5QUd23UZXtUUCQMDhTD6hSVJMO1I9RYy3AUgOprBlAUZXWPdTJVFGDUd26n7GQFVsPqcnrAspkoKD2ijdZRmFOJWQI5Qf69dVGQ0x3gcCbcgdo2hjBsSVFZfpLVN5PjE/aqi4YIuC94BPvM4r7hTGsf9+2MM9FB5qJBMQIR6LWyXnUzKRjj3M6tA41sCTXgB62UAt1w1djxQRrO2U37TmN8AQSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(6506007)(4326008)(52116002)(36756003)(2906002)(66946007)(86362001)(8936002)(6512007)(6486002)(26005)(66476007)(66556008)(38100700002)(38350700002)(8676002)(41300700001)(6666004)(107886003)(478600001)(83380400001)(110136005)(2616005)(1076003)(186003)(5660300002)(316002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2diy1n94pGflOjG8X22g0tQOAjdkDfwk4rvk1cqs5X81s3ut3CFL4XJnMK21?=
 =?us-ascii?Q?OdFLGdBmFCptzu/km35wHHQXSwiUYi5bKN2QLpKm8Zb8ACQY3C0mjn9DEYIg?=
 =?us-ascii?Q?2LgN8TSOJctGpQrOWrgKFKHah4Qgpc85UhzVifZVGT6huOmxQCZMwKoLL3Pq?=
 =?us-ascii?Q?GVGH8srazZ2fG408TkPzjprRattiusZ5xV+iS73WSedIQPigQ0lCTdxg3kdJ?=
 =?us-ascii?Q?CcbA3l1u0I/yQKu5iTyb9fw9ai3yKptT5118wUinpmlFzq8s+qe8tuD1g0GE?=
 =?us-ascii?Q?7Uq9BQo1HLUki8BPJn4bSNIFLugLiA36PpbUblmGYD30NfjEJ0J5GRCQ2OFS?=
 =?us-ascii?Q?dvjtK8Ml3NqrG84rNnd4oNx3rZNoVoZj5CNwpmUMKOLxDo44EVUvYkAtBbab?=
 =?us-ascii?Q?UdpCnL9f+Cd9XZyRwyIQYifbchUqbpCCnmV69kTJj1OdS993bjVAzAmtqFK0?=
 =?us-ascii?Q?RfpoVDtnsdP5fZapapqzB9BqgqFF5Wnyg3JnJDoOQRzHKZnp0Sk0QvbsfeX2?=
 =?us-ascii?Q?2oxy47OqmibE0QtrPn6UFgO77YfRulgff4yFP07UfOcnB7t1XcLrUgDsxFSb?=
 =?us-ascii?Q?+WPHrn7qeW0/ReGBqFh+AMIzvG+JiPTQgZn3IIzCe9hFqZ/cDMRFJnzK3hxZ?=
 =?us-ascii?Q?sXwgc5GMa/CJ4RqG7GqbkIVLBZWT1XSQeXGL6GwurHPd162brFYvG3gJgv3k?=
 =?us-ascii?Q?Wj5sde08Lhiqr6VNPUTJdchqS+ZNq2ukvR9gJRxDf4tychlLcZwZMW5KXg5r?=
 =?us-ascii?Q?zV1d0BqPZlSIY5FpHg8+N1SLJsztS3LWMnifyoHsJDUCrbcAnklYf9Qu/fG3?=
 =?us-ascii?Q?8kZ8bpQkuLkKnrC+2SFM/yWWzf2IfrWWrAHmOIwv6/BIvS4olkvRqKOLB9e2?=
 =?us-ascii?Q?k08u/UHDwPE9LeKObtVBullJoGI4coM127iI4P8sJzBYWvn0xDBXHcG9j0Yp?=
 =?us-ascii?Q?O1EDvYWyM8c7W6XpHtqK5+N4YZYq/xlHwPhKT9Oqrd23dvLCKMUZjA1+5UVJ?=
 =?us-ascii?Q?wdZ00VIStXIBw8oHKKKoJzcByu1CFaiUrgsmDWsuC+xOnUa4P4+LquOYWk7s?=
 =?us-ascii?Q?Ki2gwk18oMl2SZqIXExj6o8/BmsAU+wb1wZkvM3hkMc7epOtX3vt7tvCwga+?=
 =?us-ascii?Q?7kMPNEU1cSeK5G7nlVsSnCMGg/y8yb7Q1NXT5RSzV2Yah/slhrzqdoLZdk4c?=
 =?us-ascii?Q?alD0qfPqrnfiLE7dBWOnczI1jdVoDv8pIv6++K+dYowsilfngTCphV+EuBjz?=
 =?us-ascii?Q?L5oSHi6OPhGXfNJE+/rb3v+n5M+EIq8mDaJ8RD+bj24FeY9SlILRst0aQlwU?=
 =?us-ascii?Q?pkHtgv6wzHRmHBAnj/Tzx06Ho9IA0cM1FadQHCR7Vqswk9RsI3+WRjB4Lhaj?=
 =?us-ascii?Q?R4UfNkHbkMd8mvzQWDjIoJ3av1vhnGn553Thdy6kBmGZUZhl/XizQHbZBenN?=
 =?us-ascii?Q?JLmvdBzNMmsgouQc56ZyQSWYPz/BXlaSUDqxCaZdxLKpd74HeN6FsMybMTIp?=
 =?us-ascii?Q?eq21xqz33YxeDfuY1TQ615EJ2fcORz+nfNfYN0mH3S7nCNCnUahUpvdcsJE8?=
 =?us-ascii?Q?1UwoCio92ieqEDzbL0B1FiZKBj9vexk11rThUnmm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7841e5f0-b3ec-44ae-2658-08da9a30487a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:15:39.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNh139F9miVcWpR4GX+j51VcHExsfH3GLmeaSmO3OnNmt8Y3INAOfCWAPK4/OqUsC3gx30qPcCrnF46MJVZc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate include in toshiba_acpi.c

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/platform/x86/toshiba_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 43cc25351aea..b62a08ec5f45 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -39,7 +39,6 @@
 #include <linux/workqueue.h>
 #include <linux/i8042.h>
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/rfkill.h>
-- 
2.17.1

