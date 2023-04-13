Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5886E1030
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjDMOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjDMOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:42:51 -0400
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A50974C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681396536; bh=rfau5OufM0BiNWhby4onOK71jyUiBVhrPZSigYK+sks=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=OxAmEuHTfbSVCKdAfkQv02ZaI1VeZo+oqjWjiC0NDnzKYZ3QYcB9qQyCqVjceU2ns
         rxhuI69vMigg8bi+XZKz1aHRqvd2Fh79cHKvc0lQ77ndsMQ05s7rXerNHiGe+prOm1
         gOsnVWdqjcuh0XBYfv+WIC50Ias0u2u6N7+9OgmvK90VpGloW7Ibfedr8mrjBZ6jDz
         AowZ4/ypEnQjcdRWoM2TE4resLxelcNFFJZl/CWzbHUKZRTSPNDZ9ODt+1/nfQv6xg
         6hLraqC7BpImr5CalHFlNHbXvDZAuL1MHtuYMiiJly2ZfZGeuwTLB36ChB3fqlHhkG
         RAmlX0Fi5l1hQ==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 540711805A0;
        Thu, 13 Apr 2023 14:35:30 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 1/5] slub: Correct the error code when slab_kset is NULL
Date:   Thu, 13 Apr 2023 22:34:48 +0800
Message-Id: <20230413143452.211250-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230413143452.211250-1-sxwjean@me.com>
References: <20230413143452.211250-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 51lpZUJemfRvfvuXf7GNT1NeHV8UTyvG
X-Proofpoint-ORIG-GUID: 51lpZUJemfRvfvuXf7GNT1NeHV8UTyvG
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=989
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304130130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

The -ENOSYS is inproper when kset_create_and_add call returns a NULL
pointer, the failure more likely is because lacking memory, hence
returning -ENOMEM is better.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 28ca576d988d..5cc56f780241 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6225,7 +6225,7 @@ static int __init slab_sysfs_init(void)
 	if (!slab_kset) {
 		mutex_unlock(&slab_mutex);
 		pr_err("Cannot register slab subsystem.\n");
-		return -ENOSYS;
+		return -ENOMEM;
 	}
 
 	slab_state = FULL;
-- 
2.30.2

