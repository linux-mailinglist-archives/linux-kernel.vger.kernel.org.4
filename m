Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F894671988
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjARKqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjARKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:43:02 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46710F4;
        Wed, 18 Jan 2023 01:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lapV3H4bn5UiBPlfTcAYTekuTZQfVDL1DcrsZxEDaY2MQTZ0DwbQoJSxJ2Gn7/cCSjxsFInBirU3yKtdg2kUcpY0anz+b9hd74lpDxl52lZ/km0ZTE3BSJJbOVQrzZq23qcfaNkSxGqtGe++gNnf+k2mxIesUMpkXoKa1Vnl3JBeU32WN21w9X7yy2ZQd1rJaypbnQs26S/OeORTQYavq8QPhrwu2D9JfN5NU6Dh9r6QLCqHRnL8wyRPnfiw7eMVxhZ9Os+ToH4WthgOXqwR3heY3TO85G06Bld+T3i7GuL0mBry/08ondqPpAPeAGcO/nSgAY+bUcw62kLumihQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1aJm+Y1wb3eLWZhwUL7s5BoMUwWW28dZiOPHVRfqcs=;
 b=hzbsAIVNkj4wsz7ZS9zNSAbXOHfGJGvXst6/PPgJuvy/JjwGPaqK94Q49KljSCnBVoqfVD4ag6F6ax1b16pEBAZP12kaXMVCez1UQm66KpLzbi/TxLoD9uFsq4pv/XWrp0+/Bdh2aDrBAwl7HzvuXDw0CBZALW44m9XyQjmJ8u87ahNhKemW68AABssxmEyX3pIZEZJolKrEdG6lLN4MIaxpVUNd8FuFrXlzxKE0qeAcQfIlYl13HxWblT9HGMlmcaQNtaKyO/y8kz84w7Ei1JNq4poakVfzTia5M9W212mfMvzF9m83m0oCZppyUqAJan/qOKQYKxKFIeutsvgweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1aJm+Y1wb3eLWZhwUL7s5BoMUwWW28dZiOPHVRfqcs=;
 b=df1siw/B/68PH2AIZ7lgFLXUt79DpJ/IXcMr+3OXyfndtL/qt86W/fdp7V34FAx6EegCXmO9m661d5YZlbocKnV1keglv/5w0zWXHuKJp82HvfhLRX41ZR4mAFdZRfArLi563gARXJ1V40pDN1nbDmkAHbl4WBGOOVkPw0NgQHYyYXMxD0CVcGs6DVZtg3cUB1zcmhirzUonra0fjH+jgfNdOvuHUVbj5voSTq08AyB0O7sUk9F3ZtWdds7XwWYJHq3/jyCPAKOEQONlkh9p6gicC0ejy11B/D77N0tUcpHbJAS1gwZAX8DWwjtA/RcENuH+bH7O1N/Z4mKvaHOR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 09:47:52 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1%5]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 09:47:51 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4 3/3] MAINTAINERS: Add NXP S32 pinctrl maintainer and reviewer
Date:   Wed, 18 Jan 2023 17:47:28 +0800
Message-Id: <20230118094728.3814-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230118094728.3814-1-clin@suse.com>
References: <20230118094728.3814-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: e523ca35-29e1-4c10-38ba-08daf93910be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiLEmV27GW5JGYQI8uTb4TO+vUxtc+qcoz1wCKUM+CP23/KHWP4BS/t7TMpbU05aO6M4rHePVGwlPmcWJo8f+DDm7obNXqhWWUu12Oi2OQOe1yRSsubLGO2nisCn/L83uw85EEHozcRbgOC+SxU8jTvF/4nuGLikAICBczFB3i1dON+pW7X6mevESGkD3rKkFn1AJrCB8XaEljxJHDbahTvTP7hiLqb2nXtZXyXa0eCZZKb3xrPRCrHwmYnRZRl9v4DcanFo+j5aqvFWF/LGyKhdEWzo2PbPwgLDIppi7rGOkl0AQTKt1wu6oxKzkKku9urmVqFe+1t8uLUHUCpHeaYP0rqVegPYsdcsQCtSMgMQnQmgtGfv7M3ZVxjHwu+QBEFG7Y61Ofadfk+Cr6aTFMRpYZGdDyWHCMtAPJyJ3hahjcj0GKUwTUAc1EIoQ94u/F50iYVEHoaK2kxPM4rGMBMVasZqXaXnD4lFKEOYEr78u3GC2smvqT83DrosFjfrgrbv1Q7mekhD/osXMN95KYv/9UE1xf+729/GfHNvBASDHgQqWJLZNaho1heyzWD4TJUltaaxXVgRDBEo7qf32yzjrm4T0Yz+nf4qG0Vvrtga6IITmerdV7IzGZyYcWd/ZxzJYIu0w6X5ZYf3IyNrWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(6506007)(36756003)(478600001)(107886003)(6666004)(38100700002)(6486002)(8676002)(66476007)(8936002)(6916009)(66556008)(86362001)(316002)(4326008)(4744005)(41300700001)(5660300002)(54906003)(66946007)(2616005)(1076003)(2906002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Pg1FvP6raZ1LQnkNFGFiTI1V6aSk414p8dTvTPCqaGfYql2DhieDjEhcOVh?=
 =?us-ascii?Q?Ec8EewOrm9UcT5D+MZX+TFv+jCBu9nW0gYus3CCALlB3ZnXRApkzXblr1DY5?=
 =?us-ascii?Q?u82Kjbg8Vy7qN7yj2TsWXglgVyPRykVNoicUru1Ba1XcMB4wSEaLJmT9rllX?=
 =?us-ascii?Q?CfWujsi5y6OIcrWJHoWBqolzhYZI9KiD99yqvaZcxFyH6XVke+4UtRbheLrq?=
 =?us-ascii?Q?hqDFjeDUP3wHI2qcHpiwhbP2COMIJmuTysfDRs/fE0WhI9ZOkHM/YDObPISn?=
 =?us-ascii?Q?sAJgy5zggzqnyuQm1olMyWf59F8UibQKdwwwMikNvEv4qYblkt2yUMzwb6qs?=
 =?us-ascii?Q?mvrpVmq57RZrKmNpgsnVhkFcHiSAdyR0Cs33+f1bcvESczVvJDGNKytBkr3t?=
 =?us-ascii?Q?d+XbrPF4ee7F6HTp32a1sB2TEkDwmJiNKudZA6RAp/N8hK1s/SSYJA5m/w3T?=
 =?us-ascii?Q?XHDOjd8pTk1b7ECBQlqY0Xc5JG8ppic1nrsUej90+9U+VG0YsFsiXHCokWZb?=
 =?us-ascii?Q?W06fHx05pOAga4Fc8Ie2Ady3892PeSYN5NaWC1ZxzPGFW53UrubwbdJHVHh4?=
 =?us-ascii?Q?RqzsFD8PN6Lqua+1N2G4BDkth+EkEAyyGs723Bm8qjedzBJz9ja0Xzrz0zgE?=
 =?us-ascii?Q?FwUx1R2a0l1H+QRY2h+OROpE6llNSGb5i6qPEl5aAxbHPPJjozyCbVK8kHHc?=
 =?us-ascii?Q?vZ70GdmbNmUZbB66pIDRQOjmT98LwEkZkcJn+WYYvOe24hXna4dahEBXRk7l?=
 =?us-ascii?Q?SngRFNfsXUeH4Ayj0TvkdYMudaD5Jtn/GoesqXc2D8g3PM2N4hwVzCd18Rgq?=
 =?us-ascii?Q?pwLVFawRk56/lIwhU91CYF1R/X6tnKIDXj9TQToArGmCM+4O6EbprJhmByI3?=
 =?us-ascii?Q?Oa6hEBEsBGwtZsIY1j8jgkMDJIjiY+Tm7BG5AjOPx47DLonIPPUeIUwS+bND?=
 =?us-ascii?Q?VOK40E7wQOCotrF543hzQ1h/E8QaLCXBIMRD1JKG39kGz/APBYEIDtwyfmbB?=
 =?us-ascii?Q?1AMN4rvWWRo4AYDppdcVf0Zw0c9SWyguv3QYzPOHcG4SEmCtk8wMUBHAlkOH?=
 =?us-ascii?Q?LnSwubjfA89SNK8cPfFhvmxXgXbqIkr/8yOsAlbSNM5UUJY/34Nh4Vq3WN68?=
 =?us-ascii?Q?SxfzWw4DCStL94UMgBzWx+r2aNhq5RDKD9VHJtBmgqTIzkWkcokiGjffRYSs?=
 =?us-ascii?Q?TMzpnSvCj+oAKIWwaEtotoGGu+goe8L+bZtK5CERLMFgAQY+z+1kjo6x7KQi?=
 =?us-ascii?Q?JBRerbGr5YwwEwIb4AIGGk4eUJ6S68vr7PFnaNsDWj4iM8emyjCQEAv+eXBp?=
 =?us-ascii?Q?WewSYQ8A+7A20JwdHnvIsuH/veikwHsAzw9pgPHi8CnkJ1fHpX1Qn6E8gD0G?=
 =?us-ascii?Q?vIKAlYskQkqbQEiWML7efL4feerq9k17mLtNnRjp+CMRYsJX/YlmwTzf4Z8v?=
 =?us-ascii?Q?LkOTOCsVwmKMkNpuFIX1o8H5k0+LYBie0F4SW/t785sehOvPkGEaVYTmqCfY?=
 =?us-ascii?Q?yb0/p4F8XjTjl7bXr+nWPhEqhGNKUVzwzYUSkOijsOJkieaHoLDFDC5KkgE0?=
 =?us-ascii?Q?a9WPijyyo6ZDp93WMYI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e523ca35-29e1-4c10-38ba-08daf93910be
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 09:47:51.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik+r5uFNC8q9lclorAaTlrutQpKCbeIyr5dJfFZp4G06677JqXHDwFEvkZCuerN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer and add NXP S32 Linux Team as a review group for
S32 pinctrl patches.

Signed-off-by: Chester Lin <clin@suse.com>
---

Changes in v4:
- The initial version in this series.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd..9c9850194891 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16551,6 +16551,14 @@ S:	Supported
 F:	drivers/gpio/gpio-sama5d2-piobu.c
 F:	drivers/pinctrl/pinctrl-at91*
 
+PIN CONTROLLER - NXP S32
+M:	Chester Lin <clin@suse.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/nxp,s32*
+F:	drivers/pinctrl/nxp/
+
 PIN CONTROLLER - QUALCOMM
 M:	Bjorn Andersson <andersson@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.37.3

