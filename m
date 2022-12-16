Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBE164E605
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLPCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLPCpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:45:25 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355450D56
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:45:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG1njk35k7XbtFNpXHKyBjiH0ejWSF5Npi8Tud1rGGv+T3ej1n8NLnjc3fatC+qtW9KSmb3DnIS7jOND7gFyitn8dPVYF4FZ+diidzMrqFXwiokSPV678dpIklIuGWk2B+uR52ZtF7ZzIHIp0g97tQvSlDQ/00huCIYANc8UgtwK2A9zeDv3RqGmV+x4VgSuMl5mT+2sn4Ci8R7Wo9hW13EGfGF+Tf0f0cjVknTBlgey4bdbhnWweF8PWKXm7wIV5yBghYo77ADjWTArfT15HGRL/azWll7FEIqDiqb2qTh/0DGIA0XcaJg8zubepjDzFU0G/DvRFAxL5ktNYHTkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJRIeGppwo7Mr5928wii4L3Lv7c2ElSW98Xo2Joi4NA=;
 b=XlnA1lfK1sSgWyHi54NOpEHmgoYTgBoqNgG5Mhb2F+yhX0SJCNvZJ3nwoOOeDqLgMmx+iYAOPLYL6hZBcpXdmo6UmjSTHmvFka3J9IA1B7gfWH/FghHEHrB9b/3W6HpV9tBDxe+s/RgBjLMWJIZ35jL3eoVGLylwT3YqsktNc5xV1+wKCTdHpOUD/s9DU5GLzGNeI0uhQt9dV4Dl4lZy7nPFNnkLEzs0KKFplDAilJK+iy0anasNFZ3oTIbnxH/yMmZJWCYBpP5E6qxXF10W/cjy+YsUj+Z7H9YRfMRJw6E3jq+dN8IB/7puqS5Zp6e4fxjaOF485t3WRF58gb5iMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJRIeGppwo7Mr5928wii4L3Lv7c2ElSW98Xo2Joi4NA=;
 b=O3CuOGifOx5idKgnKMbLO+ISrmKt7TZ770MzWCgv2Y/dK7fXO/bnvUF+mLTzhB7HP/YRSISZKJ2Fvww3XiZ1/uRmPdu3AZC2+z7wA5MATApP03FhypdgiLTz/FepG/HQjIOcx4jw/Vrw++KxNX7PGRoZekrDYTs47638k/oQQiPEqnE7ZTVYUbjHUilJtvCm0qIrl+UbTXO19tNHrew3XcRM4OylbGy0sCDFhWUzuBDcQZl5KnRbzLLYY2Jh/J71enrepRBb+tpNcoCVIxVn0oJ0UlXpwnJJB1qHRyXLADSAaQUIztwQ2sB4VL1kDe2u3fMC3/SYUSEyttyLjT/QBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4481.apcprd06.prod.outlook.com (2603:1096:820:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 02:45:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 02:45:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] MAINTAINERS: Add f2fs's patchwork
Date:   Fri, 16 Dec 2022 10:45:06 +0800
Message-Id: <20221216024506.77048-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4ba58c-34f3-47ea-7d71-08dadf0f90c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT0U8Z8n7g18ZyrMZ8djmBx18044LxdaP54qqN67n8COaMrtx0EQsVbeajJ0YuqoYT1hHtyjGGI372GgvnwfJVpo5d3gcgmF9c6z5kLgQDXCQNixJJB/bPIzexXQDr+NLNW4CGz2+TDu+eJV39MI45cKWhaxHemiNDaG7TwJP03GoY6Z52x5/kcjuMgXCtPYvZT36ZdpQewYs01VCe/p5NskOGNvvxDNqguRPuruW2H23Ovulg+pGTH4WkekFcygSs0E/wgJPF+NJ69NLYDWyaKXbSWU88t37Dt1AY9gAMJ0xCyhn/uiYA7e/uQ1EFHIy7tuJvIy3eR2c+JnkQiFBgXvxVQ5ooVh8/YQzgLWsusm4ZorzXbhSPAtfUdRjKADjisBYGIlvL/aHCBBt45zosjXH+VFC/G9rUT2dY/MF30POEGmsIM/XAelWCw4sZI3046aneeeGkMfHPh0WWsOAo/I49qgb3mwzHoryNt9EgAlS5VfwIUBqMG24er3CBTT1TpUFO6LRDI9w4RWRa53tajnBxV2SfcyZLDj9k+xDSds7hR01jV758VKe4C3k6xb3/3n/T0gBDjU1DX9rDLHWegA3mZx0eECltOdYvnSoxSVJz5A9PplGpHRXr7bzyc472tW5Oi/51QCdvozIJ+kEwmaDcGdL+UzUTUZisAzOTmCZt9mxF2bfKrQwPTJmoD4dWxeq3dR3iJzEYGsv3hiQB69J7NzC7yrHzjt9FAAbZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(5660300002)(8676002)(4326008)(8936002)(66556008)(66476007)(4744005)(66946007)(41300700001)(1076003)(966005)(6486002)(52116002)(478600001)(36756003)(316002)(2906002)(186003)(86362001)(6666004)(107886003)(26005)(2616005)(6506007)(6512007)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9C3Pz+d7XeSezE92vZ1kFUsgzhcTqLy/piEqs2FmJJkEckvreqvThQToQVuc?=
 =?us-ascii?Q?TDu589RO4x4XyfXWHiB9we/S8rmLHYE1oBlBHd7IW9XYZK1f7WsRAKrcKEf9?=
 =?us-ascii?Q?/dO7pyR42rEArVQJ3G0JiiqYzHAXpYskTBQ2LptxAZPJCajAYM//MzaaTW0e?=
 =?us-ascii?Q?k5HTefgeD7heL3RcoDT8uCGmINEv240BVFHYdMFCW4TC3LopKueNHIpuhYov?=
 =?us-ascii?Q?CfKYd67+oKfqGxW+j3QFDj59alb2V5zu/NeOtsPkUBQ/A1BJK6EoiRGBXKc4?=
 =?us-ascii?Q?wUn0tV8Axs/lkUVMvB2mj2EgFfaRBN2vJxx4BL1eoXgWuQ5bGZXL+5yz5mYq?=
 =?us-ascii?Q?aTi6WiunZe/eliavs+J8FKmdySXK5uj+tCTwx9Z42+hGtFj+C+Nyr5Wf2F3a?=
 =?us-ascii?Q?VC0dH8RO5Nk4Dmvc5QhZ1xeiZ0Kj/EEnwjhpKsnruNE7vDgBHZ0GdUOfTMMY?=
 =?us-ascii?Q?+1i/813+HH3MKPF/uEE/ynZRZ2Bjg5ZTlgHb9tUf5PfpcNpRjGAHcV8uRsCu?=
 =?us-ascii?Q?DBajeN6txHSNZ6vXfbQt8/nwy6w1xkQdOoaLfQWw31eyHrNKrLk7SZM8UMmT?=
 =?us-ascii?Q?E6gAgy9G+XPnuGOZ0Od1sGMNQoGB2QKABKoZ5tzsNv3hTqZotLG0k50pjnAU?=
 =?us-ascii?Q?K5GA3U+BsqLM10d/wtY0Lhtsx9C6PCc7Lu3bBFUVZ34RKRZ9b6tWie3+7MxS?=
 =?us-ascii?Q?6G8L/sChieMPw7v1pkBCze2giGW92F+yW3TU6GYsj1Qq7k+RVkC+Wl8V70Yp?=
 =?us-ascii?Q?SvxP9zOfS/6R9c6xTS8XGcscHkHHi9TYigFKwG6jQ8f5j8lfBf3L3ebdzCie?=
 =?us-ascii?Q?RprLnQgaJ5S8ro00nZ6h+MSrFHiZwbScccTKIiYnBUg9hZiPnyWNyzasLSv1?=
 =?us-ascii?Q?l0xAaaVmhXz4pPvsYp/3/hY8RERroyeZm4jA5uSfpGuDeYIC9+VoDOwax6mI?=
 =?us-ascii?Q?wK9HHGGYCaFpdDpC0wCC0osZo/CWSN4M8tK/HuUNSe9N4P8N1RBhLPD3htgf?=
 =?us-ascii?Q?879VeUO4qnpn/kgxFzL8/dUUHjbpEHBOQAk1EFll0C2zNB2UOR236mh4N6QR?=
 =?us-ascii?Q?FIiI+iTDcTfO6+lWvjAkLJtASKEGXc2ym+Klyqh0yNhCibTFXn7xQDP6K+9G?=
 =?us-ascii?Q?hEh5WJx6mqB0QQnedqmQE/dRXPaqxwX1q3H02QQcb89duH08HECtLRAe+eZe?=
 =?us-ascii?Q?T5A6aodqBE7AAEPJnxjfhA8Tky9OVXza30BBe0IY2TBxtulKL+RG8mMH0I1/?=
 =?us-ascii?Q?59y2NVOmVmKWDWiqXqpYHxOMLkFjA46bfcS/Lbpo2ExkStk9ctrig4BE2kBy?=
 =?us-ascii?Q?rc1tYk1vozaQ2ADaKbgTKMDyfZOxtm8sHoIHGFj9F4ebpIjEKX3gvgD4cljg?=
 =?us-ascii?Q?jMFt4Odd9lqIIiDYP/OqWzxOP4sMBM/mp5fnD+jZo3tqQQMIW8l5RmVEARek?=
 =?us-ascii?Q?P5R5BERIysbrFkGbjEdS+O0zJCQI+vTZW/Eq7JEAhUfw25USfDuZF20N4VqO?=
 =?us-ascii?Q?XKFjrdxWY4UnNDhDEP4PtWJw54CVFL0CZV3cfwErrZy3SCmQteB4enQBgr7W?=
 =?us-ascii?Q?14ki+UXteh4TC+FHUZFZQMAjZ3yx+yndO/MP9Md7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4ba58c-34f3-47ea-7d71-08dadf0f90c3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 02:45:17.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOCKAoewSLUMHaXasIMuI2wbLkHfUgB2YX6ycRV1VZaMjXf8RgWp67//SvrfJg1A1J/LYLpRMnP+f6m6obf0vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From now on, f2fs also has its own patchwork link, thanks to Jaegeuk
for starting this tool!

Let's update it to f2fs entry.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a608f19da3a9..d1fbe7d15d86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7889,6 +7889,7 @@ M:	Chao Yu <chao@kernel.org>
 L:	linux-f2fs-devel@lists.sourceforge.net
 S:	Maintained
 W:	https://f2fs.wiki.kernel.org/
+Q:	https://patchwork.kernel.org/project/f2fs/list/
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
-- 
2.25.1

