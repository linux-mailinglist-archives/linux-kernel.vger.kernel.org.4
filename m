Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D57D5B3C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiIIPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIIPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:39:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12C4198E;
        Fri,  9 Sep 2022 08:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtvDTCxV6UO/HdifpyTeBmHDX69kon5QeDS0MQ+YXl/8doOt5hNGg6xW8IzrdGi2C9OMhmJNd1Udc/ZYqWWhkpnNBQYXFafrIK4G9Lv9TadwLHvixUc20+76rDFIAQ16Qpvrz/B93QCcKwaMKX1smoqr96ak/zLuUAc7W17wIwRBWFcYxMF/I8B9uTh1hcYb/9jbPNVjgFslziWYqzOjiLFjzd1m7TgXi4DCfoXrVIOo423yWsfvHNeAQccqpmo4VbHng0Zk0XdCRd9US33ePuvOqvulTYLKy72R8hiMgKSsP+1uaDADNYNYp3OGunDh8wZg2kKH6AYnAf6FekhvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPfocOlO429aXhkHTH+XfUTDqLEIYIgpWdwP4Osq0Xg=;
 b=TgGZNiU5Mm6TQMvkMAekdDMQKAGX0NMOQiKStLt6vEXo3bYFryOXzVrkg1xwX1URKle6PI5k9yLa0rwssw9kWGrm7Nr2HlTChQkgrjpnioyCjkECe648vIZegDBPYeqkScL0sw3GfwBdgsXUA0PDOqhkyLvPIakiPoKGBSDZ+GI6eT1s0p5WPavSW+RD0kUbwKM5y2jAm8f06YNwZghvMrMIREOvcXjax+9OCQA+QnVts0i17J26EnuLqmx28U8zx5JMQgSp8I7zF9+OQIVdbL9U3FkOlBbVWUt2tWY9QJsIHfbgm+/UDAS3HT7oYThY2EEdwieBs/0uPr2dyNkOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPfocOlO429aXhkHTH+XfUTDqLEIYIgpWdwP4Osq0Xg=;
 b=LqU+djQQ2bIu2M5OsXGvYXJqn36T4Zpwew7Ri/lyoM6+OjCX8uHqv6g/tZ2AgHWPBjbTu8bgY+2pfNBCtdoINtKLA8hGIuLxrCRFOaliP2XmDg4f47DxdLugsD9oQ/Ia1iehRDljpMxtCW9ToWRyuM9aDmUkL47C1fCLwqn3F7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BL3PR10MB6091.namprd10.prod.outlook.com
 (2603:10b6:208:3b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Fri, 9 Sep
 2022 15:38:14 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::38ee:4bfb:c7b8:72e1]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::38ee:4bfb:c7b8:72e1%7]) with mapi id 15.20.5588.020; Fri, 9 Sep 2022
 15:38:13 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1] pinctrl: ocelot: add help and description information to ocelot pinctrl kconfig
Date:   Fri,  9 Sep 2022 08:38:02 -0700
Message-Id: <20220909153802.3370088-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b06406-496b-4141-293c-08da92794ea7
X-MS-TrafficTypeDiagnostic: BL3PR10MB6091:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIUyfOn9GI4WaI9j0zkAxPn3LnuVDgD58QrT+nGndu5DTAQPTw/JtjRb83BhRmVT1g7OGAp/nYR/WSYXRUszpzfL0BQEUnZLyS/p/9ByoKKsgqa7xkhguMO8zDygO2j0W4Osy/i0YxRHv3pToS+JLOzjd2LZujdo9rr3EY6gLtvMnwrra3Y2mPR00aZfqg/UmFsp2sjOVeAIdoFixIWuK3fGtPMiva47kIlXnUVdaWuS9J9z+E5VmAFEGCUxNmogQQUm4k8bSo0mKAlgWtGS1oWIF67MNgVvg+i8/uOBYFeyz87/VN/cu8KoeV3FWN5TZVgz2fvVQKuUDpuTeRpfMQKib5MLI3xtbHnuFs/ecYsr5K11NZ3+WLXi+ip+Ko1IMYllmHoKuvG6Albgwo2Ttmsc3Rdw/R4PF0BNL1MCHdYmG4SfqI1iwI8TtVhcrPccC0ax6OMAEK6gzS0RP9ndoJLU/k/G/+xry1sME1+/h+ulcJNr++SRHogZQJwh60sC71yJz3N+sAQpHWdYx155phScfX2knZk5lT1FokF1IOjDy4N66XrBRTxv6sdU4+JNkXWr5BD6iEBV0SPkYoTjatsTSqWgnwkVHrtRcwYG9/T0Nxb9YZtu6UxyGC56u4wh+TlvsZOY7FoMmr4r0KRwhey3YgX7NIW3iosgkf5rCBQpO06apwbLbDxeiXq8fsSKXHk5FgtyXHgj6rJxi2LPBKJfnJUO2Rdy6VKbYJxPCYnDb6h2lYro7T6SGl54TPpukWIhPC0WVCtKdrtnaY4JdDnI1X9kMWwhwo8VwwA/6PQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(136003)(396003)(366004)(346002)(376002)(6512007)(52116002)(41300700001)(26005)(86362001)(966005)(6666004)(6486002)(38100700002)(38350700002)(478600001)(6506007)(186003)(4326008)(2616005)(66556008)(66476007)(36756003)(66946007)(1076003)(5660300002)(8936002)(316002)(2906002)(8676002)(54906003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztl/6PS52woTmMkpPK/OoN790msUzxsumbRIsKBxm3js4y4RmhwxPrr4R5O4?=
 =?us-ascii?Q?G1hGMqEcYvnhqP+A/ohpkulNa1OT7peLHrHYOKtuJYIGm4CajGge2YS6MQIw?=
 =?us-ascii?Q?GzsGeZvVhZsBYGMbJAAPobop1rKCSWzQy42IYkb8eYnLoMqKpc0SN4GsqAOV?=
 =?us-ascii?Q?chRRnozS+3saraPqZQrgCPZZvBxFg6HugEvMxsPlwV7WbmR2MxbhW/yUTJMY?=
 =?us-ascii?Q?PVfHSp36jS2WsWewMSvMTFpJPXHTHrrCJoE5Egl+2v61c0JKiODGjUqTSFIY?=
 =?us-ascii?Q?QqO5oJlRsiUonLc07HwlicbItjgrqPpwiqx+uHgfReLtL7jLH4hRPJrd3/l2?=
 =?us-ascii?Q?a0Zz3Z0wQjUe26KQZKv8ybKW1MEEQzboXlHyBG4TMd4eaR0WuaQi+xN8AWKT?=
 =?us-ascii?Q?1VBtpbxTipuKY4eosdrc2hCSS5lGw0kcP/YTfEuEJA55vgEH9umZvOOmqBDd?=
 =?us-ascii?Q?aTGC98ontDqhg0qILPCLCSzoU4OfK6+cmWbZbeiLRzqhwWcl0OyJrueHdqt0?=
 =?us-ascii?Q?REAC1OKPNDwfIZY+GJqYK7zC9gQfiecdRWuDxhRdRRYUYnaXGIWo2vmOKHtk?=
 =?us-ascii?Q?AL0Bux+zfnLnERs/v/xz0E1pbS7DdKq9GvFSHLJ+HY36qYuReEUifEi/FEOz?=
 =?us-ascii?Q?3X6BpEEkRq971ojJeQ0VshKri/9zcxMAuUVxLAo6B3VEK6sRztQaMW8uRisV?=
 =?us-ascii?Q?x1iGxY/zaYhsRMnhrmfLczkLDhjuH9mlNCutUWiw8eB96sZyFdQ9vApCXBJm?=
 =?us-ascii?Q?N1JukDQiYQx0Eno9yNz0byu1noUEHtUyyR13bACr72pKFOJbE0/JqyhAG8Ce?=
 =?us-ascii?Q?enBfgERR+NDkhjuD4tCeqw6rzeLlmMjSrMhxRcfmbOx30kshPCMhbNHow7p1?=
 =?us-ascii?Q?yTyrdLt58suSr86qHKe0DtdOGsYHVJZd2rka4IrhyNOzjkCP3QubtaTW1ja/?=
 =?us-ascii?Q?ao3Bdn4FQHQVAg5UeQALevQkUSKewU1tSZHcLaqcpGr7ArKLXIB2ceSwUCFz?=
 =?us-ascii?Q?5R0xW+rchfm6RdJRoCT0FBTMoQmsG2K3zjASlx3eXXA92al7iWRXbGNSVS9A?=
 =?us-ascii?Q?axxkHkuXm8h8y+LF1eC0Qizu5o8f2pQaXcon3JF/uku0/3xwcKD+pqGY5d9i?=
 =?us-ascii?Q?U77qhJLP+CwLCCBPU1qgb1MT7iL/WwVwaqnqYsgfW7vwFyt//ICg5AP93hgE?=
 =?us-ascii?Q?qTmqTFCV/NtCd2ln0iXQaPaq3qjGmxIA0inS1p0OvTemuUWfMAJrbDbwcN/z?=
 =?us-ascii?Q?VYUXf3e2o2YzJMyMiAn8ifNpbQF9KdkjAlihY402PQgCjWXbsTMzVP7k1eYC?=
 =?us-ascii?Q?ggzIb5Llha1JyEhVSk/FJXZ1zZnd+tSu38S8SJxMD8RBBt83kmpfqdkJ2hce?=
 =?us-ascii?Q?Ob4TLXVuMTmZ92Ne7lt2IMEMghBD2xAlfoVeVqVOKqONYinIn0Y/Eq7TLXLp?=
 =?us-ascii?Q?cTj46XauNyHpESE3YKROwIMM8MvCfVcpMrLK5njzvDWO5R6mwKHv0t1yhwpj?=
 =?us-ascii?Q?jtbFCFKV37mlIKUD/4EwDDc1cpGlhaFnP3/ZtpXCxrffGFctqlHLugJ1BhPk?=
 =?us-ascii?Q?UvojxLhwMLvW6/Hp6CAeHVdO0HiUrntH5x4QwDIVYf6SyZRNq34PF+Enmi+B?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b06406-496b-4141-293c-08da92794ea7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:38:13.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TydocME+JAcNfsMzZ/54jEW7WdzUcKRK/RJJs2jHxUHGf89B9o/dAkrz2cQhTj2nlVoJ9XbqqwRjC91/ejO90dRH/S71kgOU9WEuvIhhHUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed help information and module export name to the Microsemi Ocelot
and Jaguar2 SoC.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---

v1:
There was a race to get pinctrl-ocelot able to be used as a module. I
lost the race to v6.0-rc1, but still have this reviewed patch with
documentation following me around - I figure I might as well submit
this.

The last patch submission (with reviewed tags) was here:
https://patchwork.kernel.org/project/netdevbpf/patch/20220803054728.1541104-4-colin.foster@in-advantage.com/

---
 drivers/pinctrl/Kconfig          | 5 +++++
 drivers/pinctrl/pinctrl-ocelot.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d768dcf75cf1..50815f126595 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -324,6 +324,11 @@ config PINCTRL_OCELOT
 	select GENERIC_PINMUX_FUNCTIONS
 	select OF_GPIO
 	select REGMAP_MMIO
+	help
+	  Support for the internal GPIO interfaces on Microsemi Ocelot and
+	  Jaguar2 SoCs.
+
+	  If conpiled as a module, the module name will be pinctrl-ocelot.
 
 config PINCTRL_OXNAS
 	bool
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 340ca2373429..f635743a639d 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -2046,4 +2046,6 @@ static struct platform_driver ocelot_pinctrl_driver = {
 	.probe = ocelot_pinctrl_probe,
 };
 module_platform_driver(ocelot_pinctrl_driver);
+
+MODULE_DESCRIPTION("Ocelot Chip Pinctrl Driver");
 MODULE_LICENSE("Dual MIT/GPL");
-- 
2.25.1

