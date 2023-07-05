Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A17486FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGEO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:56:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F2C170A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtIcWl7CeZFwUkwCKdM168cBkyXhDU7ATVupyf9JxB5M86l0P5DiB+zypyRukvJE+GDqBOyYwg4MbM4l0eSA7GcAT2E0hSV7BhUUgAEv5gw2ve3zKprMktKMwQEYyW7vrdz8uX94P3zYAoYTc868XVNKsqbHs+DI4gSS+EwZopt3DRi6eXklDmqEXEnex8o1MeSFiJP8+n82LXQRVrG608SkREJRKU0rZYFm0ppsArBHBk1hUfnJq9Bi7bZraSpt+d+Btu2faoVR44DPUUtnL/n4JBX0Yhb3cjCayLQSmATzuzMfbwyUmrlHKD06alNYekBQHRI6JxgETB/1s7IUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNpj9rxmMueM38RTB/u25xlpE2eVTV9JiOMXsZ2osnk=;
 b=af03WAoxc8G/u2sLUAWK3hd7YiYkaUXzpHZHGzwHADkRUoXgpHem7nPRz/3SS7Rcw7yLx0bJZYGBFKWt1Omix8bxMX+HOWdI9UUdblNBy84m95V7l2yy57Z7xVugXfWLzCUW6XuAIfLy9GC9GhlKA4fxWtw+fjCsENojSZS66hTFECq4bgwZ7nek8jb7dGJwLg7JEY0vw37VCpSRU1e25Px916t1HPTECfPTBKhj4HoGwBsDXtngI0yAFHa+Nk2p4bi3ER5EeRAdz0ArnpfDk9kZTOTrwI7ojDb7CLg1nPLn5vqz8lsnHyInMTDIG/N1FnNGiEqqUHhHFN04EC+qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNpj9rxmMueM38RTB/u25xlpE2eVTV9JiOMXsZ2osnk=;
 b=csdmlkV3tRi6XgL2U2ynT6Gexu4UACtb8yhxD2vwqCvehwwnvcI3ub+Sic8heSAqck8nXijABPYS4oCjmuZqlMbpZGuzIb2Cr6Z98YekiHgQwWl5U6xLIzVsBBUH+4PbwIEjTlu7OJSD5PyPht22xgpbuuloDDtGOXklGy80xThY96CBYjzg/Y5W0TVSYz3w6v79I/Bin1qDUmmLtKGv19TsQ53zoGJNM7LYdHu328j2Ew1+b7paTfTJfTl4cINPSHb8tWcArAinOHYRx6pNg9SuQFDM/yt3DbOYyfOnwEHCKGRK29gMCwt8MDRlqYuSXH6Lwf3qRl6HBWB72FPmqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by PSAPR06MB4390.apcprd06.prod.outlook.com
 (2603:1096:301:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 14:56:21 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 14:56:21 +0000
From:   Wang Ming <machel@vivo.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] intel_th:Fix repeated initialization
Date:   Wed,  5 Jul 2023 22:55:57 +0800
Message-Id: <20230705145608.4602-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|PSAPR06MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 72507412-8254-4ad3-a541-08db7d67fe76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpgXtiUzxnuw6VVFVrzme+GHPQSCmVCNbDOaIWNFsAiI6UvH3qHF8fbDhxjhNatzZh3P8f1EHO+cpJC8elocLaFQ8yBfo4CMTs+NWEwC6fKHU4/1MoO4TSOhWZ5DrOKMDiQ9f1E2BkedA3H9VGJce0ELl6aaATqEgdbk9bWaWdad9kR6JFE1gCkJzRLhByn6vOpib8Vw+eZpzFWQopPORBvMApmTjOWGba392fhKqxIW4ScRtfvSzKlj85Jhm249cuuj64pTPyl3LvBFj5CLRpm7Pl+Y2ffvwOO55A15yr+c2RMq/Qy35aci0TPmNIAW1DQI7isKgjSxW4YkSWb5l+xuBeuFXU1JT9AfQ2gqAnX99w97tWsGPHWfd3YhgJU3HXNUpmZpMFtxodA1l3zSyA4JsiZ/2fuwM2wPbWozPDLdHPHpJ2gvvzQ5p0TAQPuXmIJQi8rdGjuSGX3oV5QfxeB8ii3PR5d3y4X2XvBVvoxjBJUzt6FKPorstrUgHFZo0MqE60jx2HBK25v64Mg29DPJtp1kacsYMGkssRmKcXykT4IhVZA7jVeyxaQWXKBqiZANPnOj10wE1lwQ68rtGB4mwctW9tqKIc4zMKC1HF2oE1gUWJKgdjxcGNoJgClN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(38100700002)(66556008)(66476007)(66946007)(4326008)(38350700002)(2616005)(186003)(6512007)(86362001)(6486002)(52116002)(36756003)(6666004)(26005)(6506007)(1076003)(478600001)(107886003)(8676002)(8936002)(4744005)(5660300002)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbIzS2947Pv05Bwx6QTOMmRXsg3a5uIFGztDsU4JFZJwPB2abohr+TLk3stX?=
 =?us-ascii?Q?Nt7J31I0mzj5A4llS+89fb9bhHf+6eeiER7XoZZVCbnHgM88+u3mwmEhYvuZ?=
 =?us-ascii?Q?kIRRiG+dQcMXxgqN7HeWvbVw1va9AdxtgzIqXPaNMla8RFIEVWyCl9sTR6cK?=
 =?us-ascii?Q?/hBLb9FRVm11LH+6ZenS6a8MpGs0h+blw8pnC0yHpqcGQXpRFiVOt8jxBwnT?=
 =?us-ascii?Q?mJFBg4FGu+zyh8el1dGVrn4Xt4eUx/uf1/6CIXY9bZP6ib9mB3W9tdsaJXjK?=
 =?us-ascii?Q?gpvO4BNUCSkzxb3OH8OHDtqPKa5m1qec2lnctosseLlpZnAg+3N9N8MnR8tG?=
 =?us-ascii?Q?3HowyM/MZvrYBstSth1ynQ0kEhUQc7RCN5a7jKuVWY3NiBzP9ZGJpFUPTXCJ?=
 =?us-ascii?Q?tfn/lk5m5Zok4s0Ixeb8g80R4aJUPHlvc6ljw70D1aOLTWF16ie5xaTyjML7?=
 =?us-ascii?Q?OLoC7wJICD8Upgw1wM4MDMWFRoSNavYN1+UurOMVqv6ULC1zCNUAryXh4inm?=
 =?us-ascii?Q?JCD9Z6cl6TvbXlepzuGMdfVoBBpmAS8vZ+bZsTPGvwlUMG3Q14ITFcZodS08?=
 =?us-ascii?Q?b4AMsfUzZNOuc7phLtCQ2LUSUL9qQIHczQwlR2Ozlj7g5HFYBtdA59IsBEUH?=
 =?us-ascii?Q?WzTDoGuX36kYQqU837QQLnVWU4po2OPN7dDPqvWZX4uS+ZS2GSpJpGF8wvf3?=
 =?us-ascii?Q?gcs2Mseg1Umr/tmYBwHvJmRKBFLfHH4KT0S0Rzku64C6T6FrLYvRo0+3k/D9?=
 =?us-ascii?Q?cpDL/Hmjr4Yhwmy75jiDUN3WjOg3nkrublrqwF2VxW2U+/tZaqjEpzECcQoV?=
 =?us-ascii?Q?OPFbHNOF8SOJ+JvHG9FeTVeisrhZ7AZYmAmiiaFG3xcQYfeAXbyskKmRmBMU?=
 =?us-ascii?Q?op+OhOvRpDYH97lVLEqfrtuUkyiy4bMdlQahwFrI+M10mZdV7B9KSlEkULF9?=
 =?us-ascii?Q?AmtJhx6wD9Lc7vNBZhzmMT3n7z8q3kr/ld6n2PfJ1XRXxFAUE6r9T7xxuEm9?=
 =?us-ascii?Q?pWwYvvbS48HjvfG6FLE4W5ygIteDXEDO1d9tyR2CU2c5Ytf5Hq5JCP8wjDVB?=
 =?us-ascii?Q?1fTNt0XJ87sKIQmFpQTy3GlKmsXTfsOdDRtWEw8it0qUAM1YKkCNBkToT/Uf?=
 =?us-ascii?Q?8jUcUYdQx8pZZCbU30OwdNfpQUs5LGscbrAibS68/eaoxl5+vLgxIbVp4+6g?=
 =?us-ascii?Q?RtMBE6yB/LfMhdJDQcgGmNqYQqLMo12CP9riH1ibebQikJknMfUfrCZflPIV?=
 =?us-ascii?Q?p9nAURhWQpUo1HZlPdFpYARhaMqp8aQ1NWg+hMh5woMBltsyjDnWkcUCIkVg?=
 =?us-ascii?Q?HcP5ocxjjkTd7lYc3cS1xilbURqLlsfq7jAwrheussd/0NYtuwbP8fWSYVIa?=
 =?us-ascii?Q?O8DZz/gr7V4w2mHP7zhBRArLEmB6jomclCjo1cctlvX1JuqFPmcdkXYYAEA/?=
 =?us-ascii?Q?itOm+nKXMj5ltMva0I/SbL3Oal4zvVtCQI1MtaOCzzojk1iDP+e65lWqHQql?=
 =?us-ascii?Q?2JgMHgVe9YACVA1fCYpvEYp9EdFVJTR+Eak5JjIM5HUx3xsgTInA/695u5H/?=
 =?us-ascii?Q?xfgUVJOv9IETO5vOvVuREoLq901FoCJ8PObLQiQz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72507412-8254-4ad3-a541-08db7d67fe76
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:56:20.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pTQZGiMAG18sHx9Hx+gHzSac1PopPdHl/OGtBeH/L6uG5G1e1fF+oSu4KSAvVXB+PGRfUn28Q2MSma3WB9yAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In intel_th_set_output() function,
the second assignment to hubdrv is
meaningless.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index cc7f879bb175..804c2f27b159 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -1048,7 +1048,7 @@ int intel_th_set_output(struct intel_th_device *thdev,
 	 * hub is instantiated together with the source device that
 	 * calls here, so guaranteed to be present.
 	 */
-	hubdrv = to_intel_th_driver(hub->dev.driver);
+
 	if (!hubdrv || !try_module_get(hubdrv->driver.owner))
 		return -EINVAL;
 
-- 
2.25.1

