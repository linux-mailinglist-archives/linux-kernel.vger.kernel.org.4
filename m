Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7416E1031
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDMOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjDMOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:42:51 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 07:42:49 PDT
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D996E9740
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681396550; bh=JAgRIwnVPHjbTYshg0Cq1C5avnVLUoxXJ3pl2kvDPSY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=xO/T7yXeroPIvZvyiZbh8x1/X/oIWsBNuf3i2Jxqpee4hQabZaqIUSllys6W3vKOm
         fhBd5rqPfi0VHzmUG9xcCqs8YguaGRJxQfSBNX2RKZgR3Tlwc58xclavJ+aEuMUzDp
         e+MMrxFCGJH3sSBXM1INcprrw70wNtK4REsFYbv98wbX7EM8cHX+lQQUUVBqFY7Dq6
         /ezTu0fwfSbI+qIgj5EbOxPknN9Z23QwKU4ckcDnydsfIrNH1Ov3I9Qa1QnevgbUFT
         /Y/EKM+m8TSExEgq4Ox2jjM0CBZTPFZL/jgPmrlbTSuScAJTlidSuIG7euqikTjLSx
         IuTLBj7bt7/LA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id BE746180985;
        Thu, 13 Apr 2023 14:35:43 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 3/5] slub: Remove CONFIG_SMP defined check
Date:   Thu, 13 Apr 2023 22:34:50 +0800
Message-Id: <20230413143452.211250-4-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230413143452.211250-1-sxwjean@me.com>
References: <20230413143452.211250-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y1U1vCSTKtKD3BAtj30KeORsRiE5ZfNE
X-Proofpoint-ORIG-GUID: Y1U1vCSTKtKD3BAtj30KeORsRiE5ZfNE
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=980
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304130130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

As CONFIG_SMP is one of dependencies of CONFIG_SLUB_CPU_PARTIAL, so if
CONFIG_SLUB_CPU_PARTIAL is defined then CONFIG_SMP must be defined,
no need to check CONFIG_SMP definition here.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index b8afe12ebba1..d897df8fe7e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5641,7 +5641,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 	objects = (slabs * oo_objects(s->oo)) / 2;
 	len += sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
 
-#if defined(CONFIG_SLUB_CPU_PARTIAL) && defined(CONFIG_SMP)
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 	for_each_online_cpu(cpu) {
 		struct slab *slab;
 
-- 
2.30.2

