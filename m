Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61B734D77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFSIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjFSIVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:21:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A9E7A;
        Mon, 19 Jun 2023 01:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds2eje9/6mfayRqPKze0wOP+0GmRPxbjwYLHgPMEgvkm1jpjk5+vO4VRB5/0RPMweRzRu0gP+SKXLMZnNz+qcRjuNlmWnI4L68BsOxkpk5INxZStkrSW9h4usSrt9VQ0Wo+Y2NZ1dFGgCK8VlAAgwT47wn3PEju4Hdo/jxDtABwD20Y8+JaBkBvwU/sAVVewBSaiT5u7PGpoRD9FljXhv7eobQrho7Ix+DyzLsBadOvsQzj7tAiyRqzO3ldfdyuYArnZ126cb/u6DEv/RxoPvRi8CD3vh4Vr/wW32Qpt3reu7DuG9jq7oH5lItvFwNHqvHpsRC9Dwm62pzOJxFMD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxr2j1r7ClnjuyNGavJzDFLpVnujmCNeTe2yKqNjr08=;
 b=Jyd5JL1wmFXJLFnhN/k+ngmMFEm6y5RZo+slf5WB8axmY6YRYAJgiiqe+f8Rq4NwweSjk12/Y8hz5hVBtIwJ0rv/lcd9ABiNbctaznEWT4essR0E4srxiComz3FeT5Gg4+FTs9z/Yw4iKYLmd26PxHOHgAICm4y3yT3ceWiAlxkR01aovgYhYphdmyedOTWCNAjqqEIKTmDNzj6Mm++aDWJ3r51/5/rVsR6LdE/zgZU3+xmifali+xVzJDnTegJo42JtrM9IcL7scMRx022iz8eeoq2mZ3jK5Az/11gv71gBfSHZEf6myu1OaiuvUPwMy60WNsubMUbE3U4wjfjpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxr2j1r7ClnjuyNGavJzDFLpVnujmCNeTe2yKqNjr08=;
 b=X0AX52VTfuM2LmEuTn8B9qaNKt8kUf4GofPySI3xge+CoSzohNlE2W5PvXFWTlVl+dSgpCOIVmRsD7dbYkm4w5NaPNDxcJuTVqK1lcW9chrYSIQXGkONTP9kx4fgUjCqUqRowiYrzCSXG3E0bU9m64c4xeGym+Yu8FmmMLZjcnSMr0AZPMRaFAAXt40J7j/I8HaI56QA3+H75KfvTfL2L0FtbGN092jXGbFxRFCaGLeKDAkwm+vNOj24531v4AkTsQeEVDrhkKov8p+enhXIyPmN25ouFNVpdrSf7ieZb9xewSOFJ9VfrMv7BnQ1NrCCKHnGJuiUO3fgekMXfiWuvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SG2PR06MB5010.apcprd06.prod.outlook.com (2603:1096:4:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 08:20:56 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c%6]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 08:20:56 +0000
From:   Li Dong <lidong@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Cc:     opensource.kernel@vivo.com, lidong@vivo.com
Subject: [PATCH] tools: Fix incorrect calculation of object size by sizeof
Date:   Mon, 19 Jun 2023 16:20:10 +0800
Message-Id: <20230619082036.410-1-lidong@vivo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:403:a::25) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SG2PR06MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7511fc28-7b1d-4b0c-8db9-08db709e1aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/+O7X8LZiOjdknsrTlw1rxk9V0BPlCdwrWtwmnc7raHYpWm+pCk0i7V0eq6Zkh7W5/cX7SnSOJwzR7Ja/gYJqMZ7GaC0q0bp0NMZMBcKD8/JLFjswo41oOWAc/UnMxz93qQwYQfAD+4zJsDQ1yrOSXmZV8/Y2Ax8HSQSRRrjOfns1Rqr08o5g/t4qwdDqS/ViVy6W/EmAO3nhGSYri0dXLhyNCVGSkSdMohiBBXmztfKcIJ7gTgo1QH797f4X64aMEOApFwURVVe8Wefcq9jldmH4cwOgfujtMq+Tziy9qqUIe7R3VwfI2AEx1ldg6+85IyqtrWeFJ1qw96NF6UwKffPPFB+2XBmpiHh6htIDdMmxrEt0EgQGhBQmYjKD3Ytfo3+qzsC6OsAUk29mmjHhCF5MyotbVzbeXyZ+leL8jEk+foGDuyALoxxHGo+Caq0fO2sIsqTc6+Y7q1TjeiZJGveSfAA0ZLSN3In1LDaYWMG6w9k6ufgtL4LTermi5DfwedmSpC1/xIinLE1kdGcNeX4i4YRfcUv+mfMDdE16SjxZNAfywcCIVCAm3HpQdhEsf3xgja63DenKdehenDNDVi5Z+yKPW8nG3/DSTUgkXTh6wRaz9kHIs/LQiWzDQlmxJYC88IJsV7vtOW/JI1NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(38350700002)(38100700002)(921005)(36756003)(86362001)(52116002)(6666004)(6486002)(26005)(1076003)(6512007)(6506007)(107886003)(186003)(8936002)(8676002)(5660300002)(7416002)(478600001)(110136005)(316002)(41300700001)(66946007)(4326008)(66556008)(66476007)(2906002)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?je4YmDguM6ZAGZXRABvQF/vmEcPPebhfabl0x5DB6MBhrKKFk4X3gloBr/L0?=
 =?us-ascii?Q?VcBCp6epYszNJAZxtrJzfXo1V2mohXOc2NrPVDBJEjXPUEihCloEJ1okhnwE?=
 =?us-ascii?Q?ohBKRY68mejfI2NaKRdBGKeW7IL/aeDINGMntYUh3NCRtnRh+UaCsmV7D094?=
 =?us-ascii?Q?z0xdORupBSP1RDO/mfekNlIcEf2BRe6nYeXlwPAOu8ynoFfIWm53tnigIkMW?=
 =?us-ascii?Q?NWjq/yyqDrNuLB2QojGjk1hazDWQgy5+oYHwa8pf8ItnRrmhaFSNGBr8ZoK7?=
 =?us-ascii?Q?jq+GqZ0zsoewcvFLatFUUyNPyVdzGXZMO8lQCylK4XW4rQEW/crbX6vMaGwv?=
 =?us-ascii?Q?IYHyRYK+Woz4FFZYNMf4yUUJW76SpGC4Z0lunN1OHx2hzeWQr2etJSXmA5Vm?=
 =?us-ascii?Q?hBpGlXsVjdWm6X3evR8Xz+KtDuFigF1lwKQX6QH32j/rzssXpzRlwsRcfepS?=
 =?us-ascii?Q?X1TSMHRrLIZiWlW3ZqR3bp9V0C3Rqp8iNO+p7eykMVb3ZQ6n4PXcfJf01TN1?=
 =?us-ascii?Q?f+iZl9vm2BLL3j1iTtEw8Ds++htcrS733+8qzQDl2WgJmgUHtOoMd5t7s7aR?=
 =?us-ascii?Q?QFHmEB9zcu5XQOdfTfzTqpy0VXNCm41Us7XBXrC+hBm2BZlYHCdWQNSrcK97?=
 =?us-ascii?Q?hafNkIiLRWVzTG+RQSkKIQhQUgId5sLO5tUnVXM9PzWiNzPqmI11gatqG0iV?=
 =?us-ascii?Q?kBiT85m0OkQTmzXQwXhsUn6+lew0/Xx1DL1zlEujG1e2GTpy8BnFWiwosNMr?=
 =?us-ascii?Q?DyNnD7NCrr7EG0Aa9naWvT51gPMtXOx4AONqXxylHOFvBpBO0y401TKJU0CF?=
 =?us-ascii?Q?FPfxk3HjxK9kSLIyGRT4B3DPpsGERC3nzpm8Y7etAI4u8nMlnUwnn4sZM4jr?=
 =?us-ascii?Q?US7u7kvgtNQPMP+EAOPoTbiiYmqUyvXFnHFAtvrnjpqqNTI/vfIVxVza5E0x?=
 =?us-ascii?Q?+9oar7Pl07gmsjHxS0OP2p5KuBbw6IdzBFX/iTw0HVv/ZSBxJvDLL+iBwMM6?=
 =?us-ascii?Q?VpjND1+GENcv9mVYVqd6/c5B8uLSxulRAiidX3JqYS4dP7/6Yo/u8pYjmqx0?=
 =?us-ascii?Q?GfEackiJEMDZrGyhzXNLoHGLupK0hisUhI48F3X6DqdZM6f9JCC3LsuTnWk4?=
 =?us-ascii?Q?Cwwn3XapW8GHwinjAuW1EvoneWrywu8K6/42rl009Xhg0tIloiAbstTwEhBk?=
 =?us-ascii?Q?EBM6oJCthHPP7SXxECU3TeTajE9VK6H8iKF8HxZj1rJ+fpISYr127BecIY0u?=
 =?us-ascii?Q?+r7+JPCcPs7jxNNsKLqVsaoV1FgixlKpKMOi21BVWkd2lpjWY2xjwuGrp0K2?=
 =?us-ascii?Q?zLuIX48Wg/Y57RVWzeQfDIb4dlS34BxCqcbFyrLK9HuJQx5TFotzif0qrWiV?=
 =?us-ascii?Q?bu/US5lKC0RxIZJCl+iprXqVBuNbx4JGqkrIW+PhPf2N5hqzoRYSlMrqkU4q?=
 =?us-ascii?Q?MBF9dLRMxZtaxVPYVa3gjPPoCHnxGQWhFLn6RV3+SQLhCCYqlLWrfW/20nkE?=
 =?us-ascii?Q?7xse0fs6ukbLrZ05GVwUWVk0v/f4zByOMrO8lGh+ij8FNx4yBg53TA4E0CIh?=
 =?us-ascii?Q?kL/EwLLBedr1nt6/I1AY0BLXHvOqf2QUEWHcL+79?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7511fc28-7b1d-4b0c-8db9-08db709e1aa6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:20:56.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1u30Z9TD0TQyfxoVosFRnbyI4fQuQ1xszAwgYtWJ7Sxn5ssEZRtlY/emUI2VEAb6QjdlmgfKcuGjU1MzLsnAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we need to calculate is the size of the object, not the size of the
pointer.

Signed-off-by: Li Dong <lidong@vivo.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 59063ec98619..25fcd6630a4d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -771,12 +771,12 @@ static void set_regs_in_dict(PyObject *dict,
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
 	char *bf = malloc(size);
 
-	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, sizeof(bf));
+	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
 
 	pydict_set_item_string_decref(dict, "iregs",
 			_PyUnicode_FromString(bf));
 
-	regs_map(&sample->user_regs, attr->sample_regs_user, arch, bf, sizeof(bf));
+	regs_map(&sample->user_regs, attr->sample_regs_user, arch, bf, size);
 
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
-- 
2.31.1.windows.1

