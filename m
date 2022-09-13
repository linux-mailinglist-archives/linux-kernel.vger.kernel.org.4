Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B95B780C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiIMReW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiIMRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:33:37 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2090.outbound.protection.outlook.com [40.92.98.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E785A3447
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWoRncdEYvMDzl7UISQRCDYD6I+41bqMxL+n91Nn3uZr7JDMlNKHH7wKQzy9+9pxNJRUBdntkmMRtuhSWT0W+Db4IqluD/3o4KbUMFA5bX89OqK9YnnZ90Ks1ygeOtCZ9sOn5EGM8VAomXTIc5LCOyn1C8kS3BomUeIKQLoTlsb84eVZNVPeOThf2tfoevzQG6Dj/3D5Gnvui3+/IsPFuRA0sHy8m1Tv7wLJR4NsG3IyO5DQSbOFhzwh0IschG4fqo3sbQ2xfD4zbtDh88+HKtaqDfFdZ8Rbynip8V1IrRRE/EyJ0VJ4mjcIMrsqPqpcHSmtmXekZZdrBvl4LeHB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFFzN6HyxVDp6++o9aXYTIouEDXFRsFE2Wv04kjX07I=;
 b=kjEjGxbkvFIK4NQKqRbTT+NAKTxcoJ2/QamBg7Lp/7WpIBrpxWfrzDWqdrztank7T5WYPyjzrNPrj/ZD+uC+8WCKB8Uw3sOCqgzP57kEZ4qv1ttbJRBynG2QC7cT98cA9ETqH+kW+ULrdlDCw57vrf0UcLKMBaMPErwdZUA/eMLtticsO0K7E+rCv9AmLG5oeDmy/rUQi/riOZuRNjOYINTQOXHRFTOsplVPgWlopLqPWOwJQW40twYLxqVGOI1EFlNe6P9LmxlKYhueilgC0DTWxR6JiWWWm4J1Lq7uLku63eCeBzLdSga1mJNPrktmraSwZPOUSMqTR+dal4FrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFFzN6HyxVDp6++o9aXYTIouEDXFRsFE2Wv04kjX07I=;
 b=rZmOsh1F6+oivLZKWdLzvqSoDsfKlY7dRvCsGFArE4AHgyfsnPesg/Pz6aeaPkBVslzsX6VObbYilKt/py916voIYy7+vpZsMQNSYbUHD61qPmwPjg9ATE4qVtDK+hei8sgIcm6luGyj1/OfMOL/75iwxEB/lHTlfR/AH5Nr6wSehWZbpal9ulqf7GhBUkWSR9Mf6+59KpqVEO2a4vIjppF56Q19BsrJtHS2YZrX7I/m/tUxFnd0nUIDmlOAlQwkeuhfGd7c9MdIIrdPXeD3fRI/fcEM90YtbFK3zjwp79dk2U1u2xWND9nbAlBb4i7z56OmXM5nh5NIoGEjUfHBoQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 16:22:11 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8d69:1a6d:5def:16db]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8d69:1a6d:5def:16db%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 16:22:11 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] mm/damon: Creating kmem cache for damon regions by KMEM_CACHE()
Date:   Wed, 14 Sep 2022 00:21:58 +0800
Message-ID: <TYCP286MB23233778395A18052E578387CA479@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [8alXQgIZM0+q4CsoLmoSY65t7Jir3Cwr]
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20220913162158.157767-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB2146:EE_
X-MS-Office365-Filtering-Correlation-Id: 26472d5b-8b58-4578-ea90-08da95a41c89
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmpEumVcsW5TnWy4PLAuKi5diZWuL0anliBMc/m3HusdrAa33+zeBwRxYGrjmEZz3PJMC812i/X4KsPkAcJ8ulz5L/4BOD2dVNi52jl3QUel/CfzY4syIQ03/W0XaPevFwQvB8jy0XD7PEa0mxCd8hpKqcRZBBjtFdMqWvGb5DKx6JsARN42xO2kjZ4dyxdw2uto/xvtOUcZCf1fVzzy9nxkaurFaqSKNOAOyrtpPhAiwJ2YG2sUuqlhd/MyLpATl45ip+DFkOqCMmPP2+RRDxFudkDVaeCbGtb9V/aqm3kBatuyJluNVtRNRI92wfSJ2LLvwvfASU1aELP9mRxbspGDhmzA/oJkaKYKAIpgCYcx6LsNGWEQlkKbZUIXvNDcErmlvjT5r/sfLI2bF3HAFhVWbVK3h4+7Mo77KtcGjLsdCEUyt5UcQkpzZXFyMsNbXz/FRg87vvTkrEnrBM+N684gujrl0u2+QGHE0TpTF3IrYBsWYyW0KGMaH0e92o8wFxG0APF9JI65z68/tNQIGvSZsxdCH/0764Nj2UUTQzAm4yRGXv5ue+++FUQDrdLhyFi7qrbeGuAV57LCxu3q0zx/yzyscj1g3yhUL8grs1p21YSYtEYHBSp9McDzlloAz/T5XDqRXzRd5i71CU7KgSF7IyiAfNnZkKAb3FK5aGv59TbsAC7psgCv7BFHzW1MUxmuaPZKcrIYqELCt287Eu/GpA94cr5jERi/w87gHAESFeyBtEUQUV5ow6Go7o88dHY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4f4KM19CMvtPAoRc9ib4U1qG25Caly1A+sIPbKaKg1ULRGRdhGV2g216VHN0p9ToLxgEUR9NFmHBXJLrg/Y/XFLW7FXQ6xA5I61D/6VP3YEU7m9Kv9+cShFomsdPY6oREot5+7KeSsNZDnY4ditia6PxDUb/ykK1pE5y4qQUMJJk1yZi+B4bMXCsn8aa/SbCI9A8ZL9mb2sfUxNO5gLUPKurN1STkA87pNpaY5KBIFoo8oOASaJSOu/gz/s+mr3ussdoY7FiVm7iVQhbEYu1/97PIkJDvswgjXrqCYjq5MvX4yTP0hffb0gsQw3sg07cYjNyB7cQrcGoOwHLkv0X+Nc26q0lwhL2R9r/mCdLgio4j5y1D9QG/qtCRBW08yG5zjr4c15ZxcBjkvk8TKsJfySUQoJuYGMFf07CwpdvEn/1f71KN0I98NZ58+AQ9gmgNHsE2xCA8VspGRpRWGITz0IICrDNVayY29FJ4/idKVPmjMjVvrh0GlbHhu3D6IQudOe0ozhXILOarMhFO6mw4JUzK+0qPl4nKt91PSUQp7HaK/UkgZwihsQ6Sh29vME7MJ+wvkzwtNJ7wOoY3oBEpC+MZ4qcIVN+7Y2DzbyQz6+5/AqQmFuedJdmv9STmCoPVh0X0ExCTO7UXMu3iChLng==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOIOh+Oe8zO7WEM3gN7azAFYTx42hGIdct88SZcrMPAm/r6FVxoyyUYSVm7E?=
 =?us-ascii?Q?ipLFpR4FrDyrtjn87N/aHk4WT3zctaSHV4F5on34aqMS+/69SVRq8u8yWk19?=
 =?us-ascii?Q?Pw4X4VhuT4kTJ5HWi3hnK80f88BBAdNVSdFyK88SBmfM+pWblv20f3lkLiqM?=
 =?us-ascii?Q?9VthD4hynox1PY5SshHyWU+pIUSlSgWb8e7kbefaxRf46oMo+FzbagAx3GkB?=
 =?us-ascii?Q?6AyzGBqeN3Lk4U9g1y5Bq8UUVyBqAWcF4Jl3aVj6uQP4KSv8f7YNpFriooAk?=
 =?us-ascii?Q?eRwEKR9HJCgDO1KmBZxHqx593+WKvXxYZkO9J8I7ATDlGqaDw+NufMIM4Edg?=
 =?us-ascii?Q?0+IEpDGpAeapHCnOsaXKINXuv2E0L1ne5TvxlHae3qZKMCyi8Glc6WE72zUe?=
 =?us-ascii?Q?n7Hd+grBanhaCi+ye66LsHuXah+YaejcLVxUFbv5SKiLzACvu3WWvdySRyiO?=
 =?us-ascii?Q?NYndLNbWNCMq+NMNOZOireHxUyGpkkKSkclUnH87W4+EF+VJHAl2Dx5oIwfe?=
 =?us-ascii?Q?CfpAjkzwS6WjAN6dlNHkRy6Rd2DnPIa5pEewLA7t/l8EBZ+tliCTNAbwTlLN?=
 =?us-ascii?Q?XbEJGjBrxaqN4RStq2XT4tyWvfQy9kmVvqmTZ+jlsHJ5UJdvV0nK0dVgcpMX?=
 =?us-ascii?Q?UEqTjdui5Kw8wvlgkh/fdIT+NFmC+SATZtvwdAYtH/457Uq5MP1nEBNzOh/r?=
 =?us-ascii?Q?9EKP127H1cjNE6MNt0JZ3wDXY8OODizJiD2t3dtyUz0BUfG5H3r/d4xUuBw6?=
 =?us-ascii?Q?QQZ0w4EpIXJoVqq91avtm5BicvPaaY+hMriHFrfGGr4wu6o8qF0gWjjphcee?=
 =?us-ascii?Q?itUjV3Mo3PuFUxeG27X+fdGiVwOejNbxAbbiS8oOPZ/lYnks8uaNt+jFUpUG?=
 =?us-ascii?Q?IcSUHUfkvt3qNPOx90xTGgqznhv4+mogVCCkN67rM+YuZjehYlgiGKbw1TEQ?=
 =?us-ascii?Q?uHppF0UV1Q7XZcDNTaSwO7JKzZx95Rho9IWZc6yJW757xMP123dTwpDzSu9F?=
 =?us-ascii?Q?17HcmkKyTv3xYAgMQ7AhRmoLNXarYlHo91e7yAEIe0+uUGh46o0LdVzIw3U6?=
 =?us-ascii?Q?xC7F9Tn3JULC2mKpY9R1J85UnvE7zrIVTdc/75SszplCXodMUMO+Cwc9mhLI?=
 =?us-ascii?Q?XheADkoEQ3fQkooyvadLlzkCmU9Gqxcj3JkQF+Pg/u9A0IofpaUEzAZK8Xzf?=
 =?us-ascii?Q?3lEp0QLBn73R3AzwIznGM3CDBD0liyz+ncp6fOccGAmUBRlQqUyTSSIy6rlJ?=
 =?us-ascii?Q?038zZOSfPzwPGyxSoRuXU9AQCRLxOfu/4rQvjXommQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26472d5b-8b58-4578-ea90-08da95a41c89
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 16:22:11.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Damon regions are dynamic objects which can be created and destroyed
frequently, a dedicated slab cache is created by KMEM_CACHE(), as
suggested by akpm.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0b1eb945c68a..20163c3c9aa7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1283,8 +1283,7 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
 
 static int __init damon_init(void)
 {
-	damon_region_cache = kmem_cache_create("damon_region_cache", sizeof(struct damon_region),
-		0, 0, NULL);
+	damon_region_cache = KMEM_CACHE(damon_region, 0);
 	if (unlikely(!damon_region_cache)) {
 		pr_err("creating damon_region_cache fails\n");
 		return -ENOMEM;
-- 
2.25.1

