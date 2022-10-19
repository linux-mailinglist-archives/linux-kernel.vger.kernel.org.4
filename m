Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F796037CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJSCCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJSCB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:01:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25FE09CA;
        Tue, 18 Oct 2022 19:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TERJfWL2lL8Y4K/Yib1taM1pWBIH+wpi+o57fcW6J7FDmk4vQV7mOY7Vc2oL5d3Scg9fElTfXEkdlZUy3FX3VmLjk8yqFMGqff/1Z9zXe8yCobkCXEl0bSjaDltHpLVs7sW+kniVIk/o3qcPLd7rR/lqy2dVYiX5WTK3w1Zw4QEm6Z1r1zBoETbBUlZhm7+ssLFjIt+s3Lz7D3rn81NTwlPxZJXJ/+rwzrLZbdiQWQDOVBtqmPPjaDX3rka15g5+E6meZrH6n/DcPFnvBfR5dKMj7uw6adSLYUH0Ra4mBvR+5hSo9FZgc/Vjusy00ccRKjmaRV/6XS7INd/iGoR3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci7xfvTxFr+RaQcMiqvYpphr28+f6HWD9sJq02tQ07Y=;
 b=WYgKv2hx9I+CRVSir42zC6cqafuhrdqC9T6BB+TPWHCHSFswpyaHRNrOEtls2gmr3Mk996O1er2Xiy/jjZxnI8m9yY6bVGd8/TJtXdniRu8ADDRRCUTxX2zC2sdlIMhjMoRxf/AG9BIH5cv1xQWKhmQ+zbUzofKtIeXrnCH3HX9j67YH3V9goD8m7ZDaoUDjWo8EdK7QNTU+BSsMhAAzAS53AJUB9R5oa4h7pFXYcgd4LBNXfN5QRAVBRrf7rswg0em7/es544b8qwL4v9yH+zALvhC/9l0zdjOsHWF7OnuN7vOZkQ8NXgTfnr4ik/7XgNzIou+D+vQowCb/U3KIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci7xfvTxFr+RaQcMiqvYpphr28+f6HWD9sJq02tQ07Y=;
 b=BPFOBQjg6+PAtcoadVZcn+aw27HATpSsqGpgQ9LnJFBlnXXEox/8E5bvmPxV2gjf2SuWuIkQeCbiNA+PH9kFg9XB4uRKeOsaZOyMHCs/RSQnIUl2dM6BA7hbEw3DAo4MS4I6Xybj/7w9tHZxxRY0NUqhU12ifT6YRwY28OWdPn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB7246.eurprd04.prod.outlook.com (2603:10a6:800:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 02:01:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%6]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 02:01:47 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, guido.gunther@puri.sm,
        marcel.ziswiler@toradex.com, laurentiu.palcu@oss.nxp.com,
        robh@kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v13 4/6] drm/atomic: Avoid unused-but-set-variable warning on for_each_old_plane_in_state
Date:   Wed, 19 Oct 2022 10:02:24 +0800
Message-Id: <20221019020226.2340782-5-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221019020226.2340782-1-victor.liu@nxp.com>
References: <20221019020226.2340782-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VE1PR04MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d66238-c97d-441e-86cd-08dab175de5a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 248fR5zlcfKIXRF39oTp/Ym2kuWgfpshBs7bn8gAp6cPmQXpSPfX0xYGqLRgwpvcPYs+kYmK4/vkM4ICHVgzdXU2HcnoYXIT4FFk/i02VMFirqzi2UNYaOV+3F7QFtkUn/mrVBw5yVJAJWZISXjI+oCruIqy5xR0hw+Q5ODFlU7pTI3ovVdg57XIhqbkY5ql7cZWKNcL6GbIzLwvY0plukb8X/5e2QcgBy5bd2o15fIMbCissFJkd1jlYHxbSDdqrWfmv/zShmA8xBIU89wRYpLJlPnGD1PVW0U+zC+Ou6yDnwvXqjGNZlbCIZPXBERg7ZwFTADzKOEyFjDGVD5vualzFeeF5LmyoohWboAmkRLPVm8v/RfkETlIJqT2Xhj8j7r1HQ6z28z9BmoOmUqs41effPpuLoW/KqlLeiZDBKZrN/eB+j4cyTg5Z9dAO+DUUnjD4wvrdIoy0WAYXx1bYwjHKBFipQ4Wp4W+TjQbr35ano0ucwatkDF7WFcHzMaeWwc/n5EiqjVZaBIUp/gK4r6IJxLm64gxdIuOaWpqVbQvIXv8Ua6Dm7+E+S1cK4Xr6kkny9njQiQJjUi8ko4NCKzma5CX0/o35E/oN7jMlr4w7HuZYL7S6VuWqH2CzeIahyeY62lkmSpHYZYsb+wCdUjWlH34iKt2OjSEuGnMll2rLi/BQbBLuyChtE9yXVAPzkDhWPqd7TpkJSEmLK6q0N4oIn8aaALjHkVlVTXtdcq3k9v7DY4wYG0SuXuKDVI9IF+QRkHkBzTuyVszl37piA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(316002)(83380400001)(8936002)(6512007)(5660300002)(2906002)(2616005)(1076003)(7416002)(66946007)(66556008)(66476007)(8676002)(86362001)(186003)(52116002)(26005)(41300700001)(4326008)(6666004)(36756003)(6506007)(38100700002)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3LCkoaNXVA7ljq186FJWKiMgV2ZNCGN8/nkW6DNOC/PUH9cK1z2vZEhFJA6?=
 =?us-ascii?Q?9wm1Ho4XGAFx+JJ6ZzbmJ36Kd92QH4ue6ysQTc+fXbOZ1Xpj9OZD6UrJHwxP?=
 =?us-ascii?Q?B2Ee4WpM3WJ20LGvgOov3RYkHz5xUBunv/iPkMbJ+6Wb4BTkKoELoKIE/bYR?=
 =?us-ascii?Q?j3qHYn4jwiUrT1RBS5awJDjmeBUxSg0w+0uIGp9LOwc7Y2w8B/Ffn6hY3VsR?=
 =?us-ascii?Q?gix9uxv3aZVTvfPC22GTczMiwlfdG2paivXosLdf6Pj6MJHIsXxUYEG5TNK1?=
 =?us-ascii?Q?B6+h9uKQ1NKxUIFIXYR8dsv2HqwEqxfn8Wfgqtys0m9oJxhREnQcIhXHYUo/?=
 =?us-ascii?Q?spQy2ZLAW+T83vJrbosC3wVixIvFx5J88V8S+9JzzlHyzfNzCs/JvD4H+f6o?=
 =?us-ascii?Q?7IpVLBh0iLjUrXM60e/S1nPeBVunW+bbnYfgzXEGmV7VTfLLtCC19WVjd3M4?=
 =?us-ascii?Q?VQ92qBoZR61ux65pRUxDj39Oh5TXvnU8kw2xZuO8jLYPc+tCfkFOll1hmpWB?=
 =?us-ascii?Q?wYOTSxh9HyTM76Y63jt6sQVAWaJwNLJDohzfyR+rx+uRDS6I8ILrDcRy2KiY?=
 =?us-ascii?Q?PytxUl9i+AXwYtTvCh1xUnpZAVOBRzC/4X/DAG48fByJoRSDvZwh2PNMjnTB?=
 =?us-ascii?Q?B74UZVZyy0Fz5/F4tD6BKFzUFsxJnElnRnu/t1WhvM3wnuxKcf6ToMGHmENJ?=
 =?us-ascii?Q?WW2lPYJF0nIa/5yHk9CzLMPp4PEWoGceaSIAmUkEwpCemUmCnp9tX/xITxqj?=
 =?us-ascii?Q?1LOzOdFwjoQPkd7Q2Pvu2Q09E/ocXSyjOFAxqef78QmzSvYQekQFXA3uF20P?=
 =?us-ascii?Q?5ZpJmHkyvQ7LyNCuCz9dAFBaQMhTEJ4MlGVcVPhmh/ZzpcMCV/TgYN/PZOoc?=
 =?us-ascii?Q?XE15EKY8huQeRdnJCh2aMvivjajKVCdHeB+/5SSYhZv1TbitewB8uh1HvuRJ?=
 =?us-ascii?Q?YOOVtY1brjdLcpkIkie6ZSkO5maF8IVwFdXSqJp1mCSl8vrHJ8flKnV9ihXh?=
 =?us-ascii?Q?iw+P0DzDroKE+YAgGK2R8oCgoFjGbRLPL0gvWbmy2bM1VyIaj4mAsyt6Zrkt?=
 =?us-ascii?Q?I3LyzJ7vttKQCLZpSip7p6lD9n+81tU5073oXXGr0v9qBF9yhAbBH9ExaNtX?=
 =?us-ascii?Q?2ZyHIzPJKQwijjdC8Qkaj/aUtq1byMNf2BlqRBAy2SeEokZoeqyhZkkw5hmW?=
 =?us-ascii?Q?VCiAkZD6pTbwQDRgAmwrc4gTtyHucGkwJjrbVXZfO+Hi3HcAxnC0H9biaoEZ?=
 =?us-ascii?Q?E5nu8K4ZpzefmVXSOnmes/BMflXvmRXnhzjZVDInZVfqQ+hxR24N7+k+RNC0?=
 =?us-ascii?Q?NVsgkbrjF/F21IjYsrqcbN42haAvYbkxfVjr0LnXtQm3N1pZyTWbxKpbtUdM?=
 =?us-ascii?Q?7dJYYCgBNsM5JjkFFtkXyeJK3OJUmEJvF1DxyXpBSgsjP4BS9GyHqG7HJRan?=
 =?us-ascii?Q?w0kP4dVTmj99BS1XqDZC/m4cOdEjCNdUNw9YhjZU5tS+9grI/235pnz4JoMV?=
 =?us-ascii?Q?824GyGfGM0de5dCp2OjEHutc9juoF+0ySB57tzBx2klnrt6rZlYaADPgBntn?=
 =?us-ascii?Q?Klfehgr7gVhdUE5vUwQehZbXMDu3IECT1o20dcL/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d66238-c97d-441e-86cd-08dab175de5a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 02:01:45.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTKRVBTD5tknwoHXFRuW0jGPDXtRdpI5zLphVM8daxmbbWyalBza56BqVsH1PFqI0daGPQoVUeBTCWoVq+q8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Artificially use 'plane' and 'old_plane_state' to avoid 'not used' warning.
The precedent has already been set by other macros in the same file.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6->v13:
* No change.

v5->v6:
* Fix commit message typo - s/Artifically/Artificially/

v4->v5:
* No change.

v3->v4:
* Add Daniel's A-b tag.

v2->v3:
* Add a missing blank line.

v1->v2:
* No change.

 include/drm/drm_atomic.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 10b1990bc1f6..bcd6ff9d18e1 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -947,7 +947,10 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_plane_state) = (__state)->planes[__i].old_state, \
+			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
+
 /**
  * for_each_new_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_state pointer
-- 
2.37.1

