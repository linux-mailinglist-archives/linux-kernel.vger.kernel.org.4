Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC556DD65F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDKJNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:13:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2027.outbound.protection.outlook.com [40.92.18.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35957194
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlhBdoc2ghhdJSD76OfmDL+xGUMtS70RI1+Bg9mGEDA+jnx69OvYAsniw5g/gEVVJDyr30pUXK+vWEMZYDPxzG3/LO96wv5qunzomNCaq/q/mu2Yw0H63N+PtdAWUfT78Ea1zNnbi88g0iHdXohubbtivGWe83wiQa/6mY/dnRHMCmoPVd5cV/XTuZR8tgSumbecFG5Z9QhSEKeEN2iPo53hrzWbtvYgG6p78s8VPQ2ozS7E6zwNTJh7C4Y7EmWifrrf4O+Ike05vFHxs4keBxYZutZVNFx27tP47pDnxsjNe1nlxR9azKIdZ0YveRdkqDRFIWEJOzcX1ytqO4jn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysWDO1E1Qguu9cbVBb9TCcMU5YCWzLbPnhRc9UX5iwk=;
 b=PXBMpJyYXbBJC2TClni4KgGTBP5oXT2F1QXK0/pQ2SB0f+4qBvWprYmjvC83HxQkgbiLU645hORp7ApFKtnFqQDBvv5S3yJD+a/EBUGJfY7UD2kg5Tf5StsThOvEp4qZfvvg77DOLyp42QxEtBDyJtdOsY0Yd8543TAWYVJVB20Fg2188FFQp0ptol21vAGboR7qZ2mmVN3sw46gx615DmNLBuUIxILkOiuKEjN06fJjgSY/MJDVtr+obePP2k9/XqN3CnOOOLgqYt3CiSbxeLzZpGhXfW9FqsIoYFBEbemXtpKSrqzMvgrWx8+9gLvdmurc1RDNxpHdZ6IUH9OlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysWDO1E1Qguu9cbVBb9TCcMU5YCWzLbPnhRc9UX5iwk=;
 b=AVPxnYn4nLHMfAUFRIpNSW64L5maOexcybcyCVUUzDq3q33TDtL+bka7PiQt6DDSdFQLNY+bm7YhXNXYClUIDs5qWOPsZY/AYAUwWcVDXfQPA0CFWmVMDPsYD2bpnb7HsvaW7M2YCgq2to4d0+INqzEdH/VKaYwZ2IhOoPK7cWCUZ0yXR7H+mJQ9BdGlnXH560fnCTVjVbhX7t23ZNxOBBTnXFZCk/sZipWaZwUplFQz+IE0wZwU70XAmdjsc/9Mp9c8nAfBBr5g+nIFNTVy+psjV6qlOTcIB9v5D7H9/xSHgAcbPtLYweqxPmfeMnMHDRzxGcBCwhfWyw2Ly24GpQ==
Received: from DM6PR22MB1836.namprd22.prod.outlook.com (2603:10b6:5:25e::21)
 by SJ2PR22MB4283.namprd22.prod.outlook.com (2603:10b6:a03:538::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 09:13:42 +0000
Received: from DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c]) by DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c%4]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 09:13:42 +0000
From:   zhaoxinchao <ChrisXinchao@outlook.com>
To:     bagasdotme@gmail.com
Cc:     ChrisXinchao@outlook.com, akpm@linux-foundation.org, cl@linux.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        vbabka@suse.cz, zhaoxinchao <chrisxinchao@outlook.com>
Subject: [PATCH v2] mm: Fixed incorrect comment for _kmem_cache_create function
Date:   Tue, 11 Apr 2023 17:13:22 +0800
Message-ID: <DM6PR22MB183653311FF3549B7D473020C59A9@DM6PR22MB1836.namprd22.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZDQXl2wMk271w3xy@debian.me>
References: <ZDQXl2wMk271w3xy@debian.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [N0Oww7afXAT05yCJA3nlqQzV+FjJ764q]
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To DM6PR22MB1836.namprd22.prod.outlook.com
 (2603:10b6:5:25e::21)
X-Microsoft-Original-Message-ID: <20230411091322.13232-1-ChrisXinchao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR22MB1836:EE_|SJ2PR22MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6009e71c-beca-4861-1030-08db3a6d0b3d
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrMtPHFZlEBY4ikO6W38docLDNgQsW6hSQfTRDBcmM+Yyc6tGqeHTNpDzXlQ9muiIDrTQuvrm28iO+8weQ3kGqbsnXrym5JjEMubcsfwIDkPpsfOtV2ISWK/2DtPbSeKhc+qFdtlsQu4RSk7b0E+5Jnx5bc0giGdZgTtvR3zsx+4okRQtitC1A05woVVFiw5w89SiCAV+qTgqnR9m5bG4PeRI3b3jWLv+nSAuiA8qX1MBBSvg49AO76nZI/SXktt0DiXMosyCrjuc9zXC+wZLfAzd7DsY0UAqzrISnniyDcimMZxRme+sgYWcjzHKA/g5E6YDzTVoJ4qqsdR8x/xffmCx78EZQyQjztnFHkUfFtLz6I05dCejeXYEmk7w4NFgXKvumfT3looDpYhrnQ3PY4TGnewJnrme5Mi8RDsxQfntTNSsA9atE3YmOS7+J3YE4kRQQOLQZI70MbLhzoARdjNz8gyFBp85KyjMfzgZo/DHKc68ua+TfXx50maK4KtFQ3FpEdGKmg+AlxD0GNjSP/fMwCNbxvg8/c4K7rmOLPnE6Nkalj5yZgkEvhAGaouTsegyMlOyLDlwY4wTLoUy8tTunhO9CRrDYLjg2H/6XQaAHmy10vUoFWTLfDrg3y+2XZLUYRznyYHIus58PW58C80UlZ6KPI8Paz+5v96uRLmS+NIgzCjcgzFOSg1heYJZba0gxRg+cUcF8biZY4vtQvP6slqyovbKEQ7n3s3YMjBFXBb2ulY6Rb8AHEX7vdPpYk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ftmT4OdBPdY3p2CejwwFha9/LlPPrRhVf4vUW8AhWYIVO5Ek/73f3CQZSvnnWyLGKNAz17HGpcZckx8NnRoHA6cyKQoZ9VL/N3R/o6Hg4AvC0qUlyjiKA5jgTB29cDnTLxJeuWM5OgIN1JR3gGRPI3vzgp81NihIO8Y/QSuMiIhhoQ/Y0900YX2xiB80mbSemJng0BpiWMFyvF9kYdkim4gdUWT58H/G8yKzWNwpJhVbUx81zCqlkHyAdD+8jQwy5hr2c7wISLu7WH1CKoNbityuJ7qkz7kpYmvhzT0ptcz4ym4rBciDjWRtZedRE4f9ZrUWHUyHkdfb6G6wxXrVu0WDVsAAVK80/MmrnIBUYPzNsqLAKePsn3zw0HRuvfiaYFXVpHxz6nTqIEXpW1DXLcQP5sTbdL2xzBqXj0cg8Qf5YEfRfQbytvTXaNO1r1CIx25yauTuVitVB0dt1LHTfxsJL5gXshTWtBAlBLzLyGEw17lvSFtbIWj2stmb9UvN/wpBiSnTB7KfKYeYEBE2TGJE+dKiimceYp6bk9N+bA7ila473mwAB4v4ysou5jur5FAXrWP0/ZL9YR3n2VyRIK4RvkDT6LaJVvvz8cbRCgnE++iB92bCkwISnS4wgQX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfRA4gXymRXaroXhE2LsbmH8M/J9H7zYLLrn/uElBW1goeLzM53TlMpopPYv?=
 =?us-ascii?Q?geDQYikjtu6M9iM/vbl65VFat4YWWH1OsGAI7Te24f+RvxUlS/bBris2Kt1n?=
 =?us-ascii?Q?agY0nK3KTd7wm+mbigNBbWpWs4A8buuPNock/mPRaNZEGKJJb/D0FKmAzevR?=
 =?us-ascii?Q?mkLzlJ/qwIaEST/l3LGWr41v/q8nag7+DuF8oN4WoM+U8aO39u6dKhnWpTzu?=
 =?us-ascii?Q?mrpiGhpAtWurxKm0SS2/5ZyIc2MIMhdzAerqYYVzAhZf2Dn30252KS08SSfH?=
 =?us-ascii?Q?aIY+PdEAFU4U9jb/U6U45/lcWRU1W49C0S48aWwd2Dnz05jhquNWD9FNVbhW?=
 =?us-ascii?Q?XfIJcBGXSx6pYmu+GTWUBOwk+Uh0zpcirOXybsyN+LrX+Mnc8xALiCobmRFf?=
 =?us-ascii?Q?+XTfGGX1ex8IuZ64xm5zIQ60Iv4Wu1iPGz0+bvPFKh2PWyVnDTLdTuPCm63Q?=
 =?us-ascii?Q?dSiS1VnwAvPO5wAY596wVjm2WOeOSqsYeSOH4mWyNwv7Qic25imfvJV9b4TF?=
 =?us-ascii?Q?NKA73cDp7IN559BRQlsSQxmjH8hXQK3D5O9oSpYjdOSjuJ3DBktQEVNqrL6o?=
 =?us-ascii?Q?r7l8UCgIgi9zRzxuA//dY17F0xOXueD8i7eEEYsleGD4JObJGHLpNwxlu7Dv?=
 =?us-ascii?Q?J7SNgyLFva+XfMVWDculQbxM9LQGpFX9IOeo5cDIBi4CMqrzriI1KIPc/X44?=
 =?us-ascii?Q?wRrbGfvtdla8XtDlrXUS+mB89a8C7Jleg9OgTOys7LROV9+f6RbOdTpj8Qu2?=
 =?us-ascii?Q?ErMTgdWRlaYnoTF+u0wvG25eq5t1nAg5AtKGn0O3pOVAhBvfLn4P91RkRAvB?=
 =?us-ascii?Q?ENFvDLRegOGczSPChI/vWL0rN/pXbEDqrcUNoln0ew1AptlB2KLDlEYP6QGI?=
 =?us-ascii?Q?FH/s/UJq2PkstdtZz8EFRtqocS3yFCuY6F+D4yCsX+4NshuA/Qd9lTA4Y5Lq?=
 =?us-ascii?Q?VHlK/XF6aqghYWKy98yRFn6cYpd2F6adkn1ZzHZOui9etSrS6xgpVZmxTAKL?=
 =?us-ascii?Q?+ofAdhzVwKewHsfgQww67oRCNtn/0CW/GV0SId8HpSg8bB9hTAgl7hHt/003?=
 =?us-ascii?Q?w3IuiYrJhkcLiolAP7e/1a/XFudbjZjaTiIzkBJHIXo5XhYJIbY/WTbQMTwb?=
 =?us-ascii?Q?GSSf8VViVBU/8F7crTjIppjs+MdoflF3UsFHjW7SVItFY+pWvKIyzj0JbePr?=
 =?us-ascii?Q?sNwr6s2bJRmV8s/Y7hULkOLjFupB7Z95Mc6RAeWBSFwYqQHUQtRJ/xkOeVA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6009e71c-beca-4861-1030-08db3a6d0b3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB1836.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:13:42.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4283
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaoxinchao <chrisxinchao@outlook.com>

Actually __kmem_cache_create() returns a status :
0 is success
nonezero are failed.

This function has three return positions. In addition to successfully
return 0, the first failed position will return - E2BIG, and the second
position will return nonzero value for setup_cpu_cache function failure.

Signed-off-by: zhaoxinchao <chrisxinchao@outlook.com>
---
 mm/slab.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index edbe722fb..399daa4d0 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1893,7 +1893,12 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
  * @cachep: cache management descriptor
  * @flags: SLAB flags
  *
- * Returns a ptr to the cache on success, NULL on failure.
+ * Returns zero on success, nonzero on failure.
+ * This function has three return positions.
+ * In addition to successfully return 0, the
+ * first failed position will return - E2BIG,
+ * and the second position will return nonzero
+ * value for setup_cpu_cache function failure.
  * Cannot be called within an int, but can be interrupted.
  * The @ctor is run when new pages are allocated by the cache.
  *
-- 
2.39.2

