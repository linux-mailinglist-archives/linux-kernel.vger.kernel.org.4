Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4C6B65F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCLMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCLMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:23:34 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2053.outbound.protection.outlook.com [40.107.127.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F625E0C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 05:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3obnLT2VYS7G13WPT9/WZKfznIkLWQEQS7Zmz68bubJiSCSDi8+e/Ks/6qQ0IMbWxXd5Mqknjw5+rDhAONxvtGPfwNJYLDdbnNY3psXsQvYMqsGp1rsF9qXDnXG2CzEKAU3DN+UdHdnqwQwnps5dMU+ifGcbcqmwWKLUnrDcmDp0Q75uXdETQxE9Yreu+oX/BIq/THwGBOvbEwC7mprN7sAiZPXE3GNrumwh+JnlTkBvyg21x4WjRHbMxVvOncvJmm6CwQ1zMyf96bigDNSkUXk1w2AHZUFkf2Jey+HbWfI5VFPinPsS9+F04GhxOmxzT9ISilOcUD5g/nDfFQQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTYhso0IGU5DumUnxh3LPxclhK13Y3/eLV5AHDoBDB0=;
 b=e2Em80fYCWR94PiilzxHIxcLrGpu0BAIfAPOJ+5VdDuU6KZU9Qg6g49d3bdFNWitWzWi28+8Hh7g/MLxcNQJFpa646wkTmgFqnr0L7DZwaqYcNPsmQXGaF4Eyfku3SkNfRKDb2R5ln3VrxJksiAPhkxVHCsjEOSpsPR9ApVPXzSV8ZVjYbRNro0R2W/dP/ZS0JZoqqfqfgVg+Z/KekZs8ZTGbOSwPETeICbVvhccmN8NkesNXRF5JQgbDBuGOb7OpgMgDBeZ6+9/AJZk8nNeYi23RWdrT4nOrZ2tt1Q4XnjTId12pVRaQ+yKgGg9Toj+TfySY3YC2tMh8z/uEwJxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTYhso0IGU5DumUnxh3LPxclhK13Y3/eLV5AHDoBDB0=;
 b=yo0A4AiaAKlV5PVA/2Zw2uRTzw9+3Sl9ZjmEtfsCLhZkFqc5yeVM98ZWUjAmNf8mTl8uSPl3Dy3LTRcPnh19RRggmAeczwH9eekP+yXqFbDPmMtqzIas1zlXaFOsz2l14lDBdWSz2mytSEYpRILKF/v7JKYdZ5OlTum51UkKp/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:6e::9) by
 FR0P281MB1547.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Sun, 12 Mar 2023 12:23:30 +0000
Received: from BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e8af:965a:6b92:6906]) by BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e8af:965a:6b92:6906%9]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 12:23:29 +0000
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thorsten Scherer <t.scherer@eckelmann.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slab: Adjust comment after refactoring of gfp.h
Date:   Sun, 12 Mar 2023 13:23:15 +0100
Message-Id: <20230312122315.3562-1-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.38.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::16) To BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:6e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2529:EE_|FR0P281MB1547:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b62699-ffd9-45cb-f55d-08db22f49695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vl6pEfFbjsBNoWJzxqZrDKwWobWdamS9nlTlX5w3awyHD6n9vuCieYnKIHw5D0DBL+k2jbhDYEYSuPyCMhWaqMRslmQT9jb/poXSfC3qGndJbSgFp2TtLoeCBVkmOJuW1Rjfa8QzuE1A3I6tM29eiQYC3PQLSRlg7NY+s7VSFexYDLJChULTy0nEDl9Me6SQVZYcwBozCnvKZR7HfskPZiU12tWPnL6n0n171PBwIjlRvWpZY+WkqV+lUOR7LxvY2CK8Tka/B3DDowDXm49ZobSX/9Qpg6l34Xhkx4s8kqW09swlNVfw0Pqi+B8JimwU8noXuw7pmVTRX3cTtygMVXdHrii+V86vZm4qRgwmS7qSt9OQIOzx/09iNohQGW4jleEIQZWRNL6s2PzkPIwGKjH5I4vYBp9rQiqbYXXcP/XiIZ8toXCTvEo9NRjOCMGTCMt6UAJL+GnG5q2UNySk1uz4YrhN5XI4MbyfMVpjaMpxCscz4FPN1rO7DgeOStKKp66V2QLLQCbm6ddNPlLvxC7iBmdwzLJjWTFcgRo/0RCoDC//ENEpZlaGrNCHOGR3Emn/olV2j8lRIP80mQEXo5lN3aTNyJENQoRfNWjXU/QYmlvyEPmw1cWsEC3QG80U9oscytxdaUZ2NRAJGTdDugrVUbRslfDR6Q9lSbKrYZ7U3MSe8xviFnVSYyLMMCxZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(451199018)(36756003)(4744005)(7416002)(5660300002)(83380400001)(478600001)(6666004)(6512007)(6506007)(1076003)(6486002)(2616005)(186003)(921005)(4326008)(8676002)(66476007)(66556008)(66946007)(8936002)(41300700001)(86362001)(110136005)(316002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZhcyR7Y888GDO7SA+mTge1qHeckGbBkwvGyhuhKR8H6L+ivRZ6HQdudjKSvW?=
 =?us-ascii?Q?UGdk30eIQa9e+sZwejkdaJh0NM7PlXup6/55G+5H6wBRUFKYqfG+bVmjalw7?=
 =?us-ascii?Q?IZ+znXb/FIcraVhdFsiWK3uVI7ZGragJx5DsI7MLnPWEJS+k8WD+4PMle1fV?=
 =?us-ascii?Q?F5x7G9Lr2ENRctv1hTUE95MW0BFws+XHNV1trEZR3SrRU3c3FSbI+8ktjjJ4?=
 =?us-ascii?Q?FsWkgdyUs03Rd96XPFArCrZEaGL2SSYPQ/X7IvETPYi1vz0FPPgJNYH+fm08?=
 =?us-ascii?Q?+q874xPWOBObKFJr811cshlW31a2aHIifpxrlDD8b4K+xMYEzBaHy/odg/bV?=
 =?us-ascii?Q?xbIZpYA4fE+jRvPSO0eSc2Ai44qzNxYaI4k1Xvp09ikypHyMsJNawbkkYU94?=
 =?us-ascii?Q?EZakggoHeo7tz1iarR2Beswkok5Fb8sBT0s5SeYjxJ0rUv+S2dlM8evbZsf2?=
 =?us-ascii?Q?LKa+G/yeG1GgZ19rbchMzlcLMExAfWjLt48aImb3H3kE9c9ybLu2Gq/FmY8E?=
 =?us-ascii?Q?1tmqL/vUr0W2fr9cHOZFnqfNtmBYr2N3cxIKJ1JmLYOD4hnFwiLjGucr6Lwc?=
 =?us-ascii?Q?tpcxXR4+CCrz3JJkarcRtjlB1eOgJoiKRm/WiPb414GsbZ8VTmx6DH/WOJcR?=
 =?us-ascii?Q?CFfHkAlmGyTMkhWB9zP7WBwJzs2a4JibWpmIUeMZSgmAM2FEjkvPQGu6vJo9?=
 =?us-ascii?Q?yrfMnU4WGeOdTuWlTXRzMgbK6C24A/emaRhgZYVM4SZdykUMGq1+c6sJPzt7?=
 =?us-ascii?Q?NCxdfffCzzXNOYC5fWY0QILIJTSjJ9SNwoHSR2gXrdXE7FSLr7XqeeHqmWxP?=
 =?us-ascii?Q?slK/VlX0JUcilX6nsF0YHiYYVtQOz6f70ldfgK9bhge5uVBSt0x57CYZmw68?=
 =?us-ascii?Q?2LlETb/8ZwkfHNuNP+3niYCH5QYhPO4Tx5mI0hWbiOOh4UUeEAz4bAQpa155?=
 =?us-ascii?Q?H9zynpTxLbWh7pZ6V7iLLyh8sNewIosenUYm1UQqw/SFbwogB2otEn958I+R?=
 =?us-ascii?Q?DryYkEwGMgax9qDyH9zHftCxqXmkqoMHYpDBR+xRNUC5D+9901kHW2NS1/Qt?=
 =?us-ascii?Q?bGMoZ3oTTywxUknJktAdhaGZeeWW4tfBSYpAIjYhGShVx62qBr61xuA7Qw1x?=
 =?us-ascii?Q?RwBmHlNyr+wH8wI+SsjTKjpbGeHcuFWJI9K035SHjFbvuNxqkk0wF3Nh3OBY?=
 =?us-ascii?Q?oRfPtCzjwEpFM5XcR+pCUdagt1YS25y0NbG+caszHqYvWT5/OfYhqUgznhMI?=
 =?us-ascii?Q?8yqaGPe8z9FobyddS1Th2lUOH28UOwqMKlHVWSKrvsRDezidbP/z/ASpSgSl?=
 =?us-ascii?Q?0/YODd4V6Jiepw2dCwbWa5+vTX/z/5XIuQPVgA7MJtUjfDuZva/sBBAL/bL1?=
 =?us-ascii?Q?WgBVn1cgfHVqhK0hYPfd1w3Zpdmri19B5cz2MT+w5E8EmPOGG0C/M/NBXxZU?=
 =?us-ascii?Q?QxxvBHoo5YL9fn4abkY7V/6VTDAbeRhuycXtotfv/yqwFTI+QwcRjLVXe9ss?=
 =?us-ascii?Q?PO6CDlcRmhX+1fXWQ5n0huL7sxUyRt7DqXgtwgjd0zLtlcWFC8xM0RID04C1?=
 =?us-ascii?Q?eJk9n33qlZUO6MagRPBxNImJQt1JWaMnpYzCXr9/TEcdiLj1AMQgKP/0EKjX?=
 =?us-ascii?Q?He1RiahvCG+U60ZpHDRHcrTQBqt3x9DIQMtt+DhW8k9NoZoLNkQndjItNqg/?=
 =?us-ascii?Q?qEea1g=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b62699-ffd9-45cb-f55d-08db22f49695
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 12:23:29.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fu5sa0hHHbMrka+z4y0sN4UqhZxm5fBjbwid+UCtCG2ageLiE9gpwhjcgM5m0KRSQz8JVzbHzE22dvK+AGr+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect the change from the commit below.

Fixes: cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 45af70315a94..87d687c43d8c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -526,7 +526,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
  * to be at least to the size.
  *
  * The @flags argument may be one of the GFP flags defined at
- * include/linux/gfp.h and described at
+ * include/linux/gfp_types.h and described at
  * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`
  *
  * The recommended usage of the @flags is described at
-- 
2.38.0

