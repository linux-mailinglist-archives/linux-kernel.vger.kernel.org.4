Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B107498B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGFJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjGFJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:46:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1233E1998;
        Thu,  6 Jul 2023 02:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVyHdxtcG7AkrPMQQIhmgmjl8QNp6G8nO72wDrUFeR8pA9TenCagqjCNn8sFVJl4JLT/UU2vQbaHHyEKvVRu4PLv108UzDcFy66PkfMjJfBejY+NTk/fZGgu8oZWYwLpnd75IEoVPL3l0chM4zhm/JbBf83X3nJwYmNaUGoRYJdd9loZBx6+w/ABAWhh/Rbusj83lyVF+wZsQNka6trMtF/99rZqbiEuqrQlpyIfh5LpcWuH7zgVZqe6wvSU+OX28rWwkp9m9BXZelAIHSCvQlKsJVEOVl+OeXNCB0bDQ5IEadYWasm/TClhZ0fkJtQIJYRL/mzzsOI4xyQIfhqcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiiEpQ+cMYPLgqjF3mPFq23LQsFlRsPDqCNv/OAPmGU=;
 b=i+A7LyHt3kIVVCdKbMzCHLN35SOOl9HRZBfoIHKVrWgiJVrBs1s000ZFohtk5ZGvc8IgEBAjFyr59vkdjllj3xhnsdKO62LMc5NkTcWUjgMCO6GKQLiNXLMv2BNsjzMBa1Rg410yYcJjkt5kb3vX6fcM2uRmFtWG6iMW1Uz31IOKtPwBa/Z7ziTkv9MdyGO+wMAeynKnbJAr1YtayNQPQMcVEuVUNZkgM70e2iBR9Cq3eHvRemmiTfsbNAfV74Vz2kxpfchGYO0rsdjkcSZNu9kzPD5sf7P0wxi+yCQsJXooL4kgFpoACjHKZru0Pz7lRSRijeWD0TMx/ippPjP4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiiEpQ+cMYPLgqjF3mPFq23LQsFlRsPDqCNv/OAPmGU=;
 b=I6WwLkktiq04EHeqPhBVD6gnrSFlSyyp/zoTscmbjSd6mH/XHxu303bD0+Od1tXfdDgkSFMHfzhAj+Ev0xDD3Fq882ADxpXqhuJllI7AlCI6YgRA61caY33w2cw8p9C0R7z+V3AoFOg+jJT/J/JTsGA+e8XXsxVQt5F6mb2xEIgIPCgkwdqNrNOQmkOiZT6TqinQhQ/EkYGjiwWMdFBljCPgEF9LTUaU0zRujRjk0xuYZMSZ6v6fM3rJHkfmDmxr0L3TOjEcyHqzMXEI8leas/eT+vDuTo1pTj7ZpMYXA6RK9wJwdMsnMw32bFDabuiyViewjhzP/IZ9fq8gN0iKag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB5147.apcprd06.prod.outlook.com (2603:1096:400:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:46:46 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 09:46:46 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] tools: perf: Two typos have been corrected
Date:   Thu,  6 Jul 2023 17:46:34 +0800
Message-Id: <20230706094635.1553-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a77f569-358a-4c53-e2ea-08db7e05e99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /V5zAP8PolwMd9NqgX2N01OZYVaezG8utiRztgmXrYfTom/Ncv5zFyj6M5P8Q1zwQkdxAXVZJLx1vSDCZApdx7Da3rEuXDCVrLfYzs2hNTO495vM2N4+uPbRo5uVN++NEjkM8Xtj/1Vmp1mT1jqFw41dWEl3wF59k9qNfqKIy6gaxvevXYRJmtGoZGTWUi+jp4Q9t8BxdjvWLNArmQ4oOasxgB3XjUymDH4EGECoEuQWXYeJMu7eSHsj7KdpE6vLfPdTMAOeHIk4KdK3CeM3WvGGmMcJag+IxRBFLcwiAyadMuGUsD3BYmJO1W9/LxHK/UcN13Q+TaZv/AdD4c8PkCLaIRTxaP1ncs5gIwgJGaTlA22yl8zJGyRZpxcmMmIblmojFlVlLujwXFjbIPT1ya8wjn+RyWIyCaVWh6h0lncbBzrqqAirxDsBWNsPJObVBsTRO2oGPVLmDD8pbCrcjuSjdQ3ZaAw9KlkBdXJSzySDirxfvumEaezzhWYzvouzhJm5v/sq+TvMCNsBtUBTxy6mZ9AitgydRxc40GlI1OUjIUmz9aJnWR8jZrXh90G6pj3NpwOC4YNGBLoliPX1xIqoxLtHAa62SIx1C5G0kX8NgqT1l2FuyyWKgddzTR47qAinpX4eRAtXxJxEOHdS7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(38100700002)(38350700002)(921005)(36756003)(86362001)(6512007)(6666004)(6486002)(478600001)(52116002)(186003)(107886003)(6506007)(1076003)(26005)(8676002)(8936002)(7416002)(5660300002)(110136005)(41300700001)(4744005)(66946007)(66556008)(66476007)(4326008)(2906002)(316002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QhVZX7yFvr1k4kb05JSlVFyoNuN5q/XR6NDfurCg7pvByIUnKMEK0Lu4yZON?=
 =?us-ascii?Q?8HR3GyRt8fggDEI2A5hZuHwzR37s8k5ysMLUKWWccZs9hoWZfeYYomx/zvei?=
 =?us-ascii?Q?waQvmWTnh1xHvzs1XeIHGApaiyjJNQAcheDuqpnu/dJMo5SyFQF3n2dh34vx?=
 =?us-ascii?Q?Cictq96FkBCTltHV+4XhDoIihJAgnfi79LUOKuTHV0wZoGFD9G/sWPsyh89E?=
 =?us-ascii?Q?cgWfo3TvY6BKP9yqT2BQg8gONvywWA6j5IUWTQvf8w/YjzJ0koE7/DESs8X8?=
 =?us-ascii?Q?GysVnMkOVRYWnSGU4S9HAq1Jvittl/91R1Lz2Ksp30k2O5Axtts/UPNBpWJt?=
 =?us-ascii?Q?3W04/KzVefW6x8pqKKaNWk6ikiuO00k0/ZX0dcILYp/01lEnC0GCq6+O7oTG?=
 =?us-ascii?Q?odCuFHtHyuWDjwItp283DVt7ZBsCEERFLkcRc3voPRWLHuOHBV+xrAJ4jI9u?=
 =?us-ascii?Q?D+EexZ7BcJOp2MUCH3rY1nr0ygWY1Xojx3lOMGdM0LTOz93xnJONU4QFIw0D?=
 =?us-ascii?Q?j5tVTo+4nRyDAKL2NAKqR+ec8AXr33z3ApcbBdQOvxKNNiyvFI8GZRa+N2gm?=
 =?us-ascii?Q?seAnfoOGdY6B9WxQ92lUCHLSv8lq4hET3CPhHG5f+2sJv8gPuRdmPYarPNst?=
 =?us-ascii?Q?N+JqbD06GR9KTTmIDRyRWSgtLSXwG2Rkq4RiIlBAQUFSsCrmSOfWV5xxsNw7?=
 =?us-ascii?Q?eORyfYoiWrQPma1l2X40mr2eakZdbx9GoGhxADRwnENJy3bOSXtP3sxb6Mnz?=
 =?us-ascii?Q?+0/f2B3G02UZtFTHbqWNyo6q0oTKs0bjHk6qLTN2jAHuTAn5gWnhnLeItcTO?=
 =?us-ascii?Q?IVrqRzOD7goa1t0r6VQuliJKC/g8zsh0jkctDaqYGnkLbkV04TT/PiHSD+ZK?=
 =?us-ascii?Q?EZBsHhaP/hOHZ1lE1fIRwRmflAH4p4QPQcQDMO6qYfkxb8Ozzu4HtO+CCffh?=
 =?us-ascii?Q?n88v2+vCnTs39zL5G4JX2zdPIF157hiM53W9/Yn8m0yUTYyLEA7f1+2cv8Z5?=
 =?us-ascii?Q?KRivNGgJi1p3If5BT/eTjM2Y9xF96iP6VbkDA2gzHKwt9GsYFiXaa2oRq1/D?=
 =?us-ascii?Q?ezGf4D6eJZ0WzTgn2yxbc9eYewFHmN7QgYBmJKigjQzB8qLjMs6Vr25YNrpg?=
 =?us-ascii?Q?/MhaNw5hcvX2s6Cltfb6Ju8twtqrk49hNh7Y/d1FIU1iEwyc7gsnEUzF3FeN?=
 =?us-ascii?Q?2VHMBNrxAOEr1PfUtWWF/XipTq0CPu9+QyFZHlR6utlBAWJujnBcL1yzxfha?=
 =?us-ascii?Q?wYmSkwtWKYJf036NErJQd0WkzmGh5fzeOjkxe1lCOnghK410G4XgQh0YVTSB?=
 =?us-ascii?Q?HURGmgRGrXDsZZriz50VQyNC7wihwowZg3Vf6GwiBoZzziJKn6IUxURVZL9c?=
 =?us-ascii?Q?jhYTg9GF7NpXv5ROACADg/P/kOxXdA2UdcUkAJ1Ccm1x3TUQvzzcyT3dcGrC?=
 =?us-ascii?Q?xu6YmO+BUlig8wltAb/6Dgq/i/BMaOwg8TpBnG6m8LpAyRXPNiUyt8EpacOr?=
 =?us-ascii?Q?bULAUlcpheMVKV824xKCtY3ws0e15L0qvpG9p25bb4VPbNGHpcUxHPR2V6IR?=
 =?us-ascii?Q?1qoLO429NtfBDNApovhA/Lq15Q4XDhQ6rsSTne57?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a77f569-358a-4c53-e2ea-08db7e05e99f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:46:46.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf60h34RsvDydg9DzGaTjezQvvIQ5du74n1OybZ920I3qokCkxD9jD2HSFP5Nq7bdjup7628XnN5xL8GywIVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wrapping code, use ';' better than using ',' which is more
in line with the coding habits of most engineers.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 tools/perf/builtin-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index e8a1b16aa5f8..57d300d8e570 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1915,8 +1915,8 @@ static int data_init(int argc, const char **argv)
 		struct perf_data *data = &d->data;
 
 		data->path  = use_default ? defaults[i] : argv[i];
-		data->mode  = PERF_DATA_MODE_READ,
-		data->force = force,
+		data->mode  = PERF_DATA_MODE_READ;
+		data->force = force;
 
 		d->idx  = i;
 	}
-- 
2.39.0

