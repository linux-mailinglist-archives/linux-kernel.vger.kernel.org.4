Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BECB65CBE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjADCkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:40:20 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F170E93;
        Tue,  3 Jan 2023 18:40:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln93VpYJFz9lAb5pxwuqPcBjrSA7TeCHwzhx0rAmhBHc8hm32YhJz5ERRadd484Vfi7Rxbg54WRC6TvB/FfPYnYyz/bOw279DuvZ0keEgulWYoZUF+clteyNYmagydP6EKU9Aw42Q664Wu7MOGTr3DPBxzWr0pCqclrPVRwB3WctwjoRY4fb3oPzK/IPX8mUKp2ad08Eb7uHCDYDWaxSP57HfIy8jc9C2INmVWMYFEE7hxZJNp+hzsIOnkMwCDUeBbId5lPgb3JQd1fNPI8EijVRaVnSceWQNXbovww6DQPzNkpKxcxniChDfXElkXUPGsiY9mBaLFfjXLbxuHme1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym0tgKsmNuNBBYjB9nx3qvF5lf/s19DQoccHtnQUM20=;
 b=Ecz1DOuoXbE2KxMJDCdectVG4sqvW7DcO7SyvZ7ogVdlxOHn8+yGWdIflNz5E1T7Zua+WkqokoQlRVw3iUlGgUJAzj3FpFLqqsRmXpV3dcI7+ydnU3Z1Gn+TqRhQibGqECv98nMflsfkqoeQdsZHhnLAEKCmDUWm4X40q3sWyViEIRO3OgW0gsAO1srLWuMpGb+pl0vm8kSe9eWu/Wj7MA+VPgQoRZohXKmKWnFGe3fCnX+Pv4fDz2o94Mu9mpfMI1vUji5CNl/ptxqMXulakujXyrWzFru4NZEZKLPsIV3qxDZgDSOBMvIAGlNF9Y3nEUYYHcHLf7WmVhHq9qTgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym0tgKsmNuNBBYjB9nx3qvF5lf/s19DQoccHtnQUM20=;
 b=CqkVkEZE7d9jYQNUHqnmS2Q9IRJBa5mh9a8iiuqpE2SU2BAqnug362/y0jIUIVZ+dGhqIWjJA79KnrQpBifWqLh6h0vOGGhZU9syHGBrL1TkdYeqwzERn9eelHBCecimOW+sJ2HX4JDA6G3w1e+e0sV9JIiCzoBL0tyzWvTC6es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 02:40:16 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.018; Wed, 4 Jan 2023
 02:40:16 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 0/3] Add support for XCVR on i.MX93 platform
Date:   Wed,  4 Jan 2023 10:39:50 +0800
Message-Id: <20230104023953.2973362-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 393263b4-e9d9-46fe-7566-08daedfd0333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QsQid15Gm+d7hCWPY8Tb+SqbRfxnrSFKA3Css+2xDNcRAhdA5FveonmLE1Z0g5Pguc1na71ktDxF3teZ4q+WGt1UDdjhXSDcnXeLMVq9lICBuTemk2vNT5HcbiJc3OXL3HeVXtQfW7pkJZD0FRaGtEytOGJdq2ttT1xHCRYZxaPzInhEHD1r6AbQRDnqxcGtJr/Jg+Qh1KDkxOLeOYq+Z76ESc/4hfmfnGrJXDAY7BwaW4xW30F+ECpH/1ilJxfGg9h7o8Xcdm9x4upxLcToDiKu2VdOl8g4Aklk+nLl0R8OskyJqj2YNzZKBap6sFoaHcjAmXyLCOgZYhiNAlrpgikQ35X7S6Hob0TgKb4QbKZEbgq3XU+msm72q0J3GoMj0FgvqXsVEK+rFH14izuVK1+9kkCVgCInmzi0P0L48dtjfZsghEDr9T1qfSmlLsyZNhPDuD6KcH7wVwwwM076VKtlRA8qGBu8eDPtNFJ/2AhByb0sI3b5PZGX2jrBOM7jhzhEZIYA7VCNmV0N97W1XwZ/1LzilXm2mK0rnVWE1MpxEOXOYD7nJtwcc7Jh4TyimpXJlFPVN8SPsj5OwT/1K+qoz97TGTeMguDWbY4qV6NzgYasoA9ZKQd5X+WWnI/4iApkiqaEsyA2KoYboyBaL+sdjEt4mKkqwwF8uSJLfkxLW5RM7PBHswXVbpuq4F8G9VjGWZkRkqJo0Yr/WmDK4yxYqp3glPmN6aIiqo7DlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(8936002)(7416002)(41300700001)(8676002)(4326008)(66476007)(5660300002)(66946007)(66556008)(44832011)(316002)(2906002)(6506007)(52116002)(6512007)(6486002)(26005)(186003)(478600001)(6666004)(86362001)(1076003)(2616005)(83380400001)(921005)(38350700002)(38100700002)(36756003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGeyugmnqP8R22Abu3PuSAB5IhuvyUpD5RYy4bI+lWlSmS+rXu1XeRMQrBnm?=
 =?us-ascii?Q?gsF9ZSFQnbQ6RSxSBYMpqPWQHDkadBXnMJZaZZsShn1BF4Cj5AeHZF7RFSjD?=
 =?us-ascii?Q?wp/hxS00PAncAzb3LikpSQxPAYfMXtAF51UKgVs36LvfY8xuux09GrnsUdBq?=
 =?us-ascii?Q?h9pqevL7+XAFfh4lwYKItD80dSfcQYGtEGBpW+BaDgPFdoKBzABZIhlgsNE5?=
 =?us-ascii?Q?qICRRid7znE7G9jZfv83JbacqW/JRTSNgoRzPqmPDgz3mXEARE3ahQM/jD56?=
 =?us-ascii?Q?B22/mASrZMC7hYMnvxmbnEi4EvGppNZ0+4ALaPQldRvNkITqiZePZF/jW+CY?=
 =?us-ascii?Q?9lZ6OHOArZcDHJo2ziG1EsSou0+i9A9jNZ4SqxL6KoIxk3F7SzOb16iRwFQ7?=
 =?us-ascii?Q?Aaatydj0LOOVq6CQxOqzQ6lKqgRP5DajDc7qfbUFTaZexQRzYu7dW6tEqfMR?=
 =?us-ascii?Q?+2NHLccRfMATodrSYM0+5CAXwDEotrFHxz6HFM7gdmR0N2tvk1lwS4TyFKQY?=
 =?us-ascii?Q?mC6Diih6zYJMjt6q5TP3ope9B7iWfPmRS50T02bvqjNWdDIEf7dZHaBBlppk?=
 =?us-ascii?Q?pOee8u5gakYIky56ZRtErbPKfvGkJkfkSXeU+DdWcGqTCmRLh7o66xNKxLnO?=
 =?us-ascii?Q?1BIHV80GxddjW8ymoga1pc53m4R4wtCNYSkX204Mg98P2/cJ13dkr9XElVJ+?=
 =?us-ascii?Q?F9LASDYWAGizfj0qzCWHaDYxFKeSGoqiM2qiWq6kD6tpsZjR2RVdrv8+vpmo?=
 =?us-ascii?Q?k/WhFfXoQGhqulhedIzXL9qblRGgPUPMTKeBEhrB4pRwPbUoNaqmTRZmzoQG?=
 =?us-ascii?Q?t1Oh2btebVWX4BAmWCLzRmc3sEsz4XVjiA2ExxecjR9/OZYKxpv+ZvrZOvoh?=
 =?us-ascii?Q?IBB4RAjbVMmQgmAfVCbLhC0fkpHJrG+NS/RBssDodGntO3Xg3wkAJiNEadh/?=
 =?us-ascii?Q?Gk2+e1IC0ldeFeuE0T4yLfnsFSbm3pWyvduObXp5AdM1lvOQpZqt5nTmc4bX?=
 =?us-ascii?Q?LOD5MmcdtZYOsLtbfbuiYcxyZ+GziKNZsgFqNpN+VeHbe8RFSdFWmwX0zoUO?=
 =?us-ascii?Q?sd1evNI1/CHXrCtwkTivPvFkTkhGMJ7cziuUYNZScqXtd+BEhLy6L937q49o?=
 =?us-ascii?Q?z+SeE49LMMbpE9Q1mmWq9UdMvjHONIzrlbDhTon8OMFQqp1to3QW8rFuWYFf?=
 =?us-ascii?Q?9VIop8h2XWnIUBGzCpAt5u/p1bfrisDVug4V9uj8arEhfngR0CNAPTMDnBa7?=
 =?us-ascii?Q?MIXemwo8D9Urz65pb3jOppwuO3JT30s3EwI1ts2eRmfNcplUNdvsFOWeavtY?=
 =?us-ascii?Q?Xm8YsJZRJ1w+EUqIt+62URzIBaTUkOA6A6cg0P5JEiu+oieutpA2OW7kDKxh?=
 =?us-ascii?Q?7eqeFOMy8+dw5T6+6ypmMc8YIK9cMGvzaGX8CCOzowOviJr0yDagX0tLLlbg?=
 =?us-ascii?Q?MlctNmIGNoOqr8THJD6KJ0Mswjq121yL2CzA36r7GIZuGgJOeJoLEuoBODRi?=
 =?us-ascii?Q?kyWp7/Sn3R0HuXknagIKat/A2bXZY8F43il3NCt3rkzKNTmmkYdHDf9V5vG5?=
 =?us-ascii?Q?VOtcGh6l0fAcf7VLJ8VocWgAfI0B3vQZYXVkD4Ti?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393263b4-e9d9-46fe-7566-08daedfd0333
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 02:40:16.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvJXmnlYAkslpPivywMcPwBDRbPCei4KA6NgIgLMHZvOpFlZNKutfCorEP6lzcOYd/spMo6k5xzcpBZNA/CwgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset supports XCVR on i.MX93 platform.

changes in v2:
- remove unnecessary code which causes kernel test robot reporting error

Chancel Liu (3):
  ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX93 platform
  ASoC: fsl_xcvr: Add support for i.MX93 platform
  ASoC: fsl_xcvr: Add constraints of period size while using eDMA

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |   1 +
 sound/soc/fsl/fsl_xcvr.c                      | 155 ++++++++++++------
 sound/soc/fsl/fsl_xcvr.h                      |   7 +
 3 files changed, 115 insertions(+), 48 deletions(-)

--
2.25.1

