Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCB6E1033
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDMOnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDMOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:42:52 -0400
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD795260
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681396543; bh=8jRYHdyOLx4stczwHdVkraZpDl6WNFY1n6xs2s88Ih4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XcKoR5cL/+upnaXqW5vEFVtkOztLb/OPL22EeKcuRy5aCKbMwJbI0lmkNMOd97cF8
         U4nWgm3EJLu3+KVDvf2gpegVHJId7BREhcCxvx0qgyQyLCBDTjraGch7/Mh+sNnUpG
         92/s8k/7x+2YqeGtk54ynj7p2UiHQ7d14zQlskNXll1HQ2Y1ksAoVjU0kHOYzrYiPh
         O4AJHBWOs1x1gkwS9kM8kB0zDEJDbBt+ipH34112Kl8ECnMt0m7FFOWkdnvWUFNQsi
         BPcQeMwhwXLQhEceqI+c8OpkxVYB4WBRjjstjTcPZrynKlB+GOgOZrkIwuBvUOfAV7
         O7Z4mjnAAXeZQ==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 95D4518043E;
        Thu, 13 Apr 2023 14:35:37 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH 2/5] slub: Put objects_show() into CONFIG_SLUB_DEBUG enabled block
Date:   Thu, 13 Apr 2023 22:34:49 +0800
Message-Id: <20230413143452.211250-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230413143452.211250-1-sxwjean@me.com>
References: <20230413143452.211250-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QqH1Ghpj5ydBr4pmMZw4eIZhmrwWvj9d
X-Proofpoint-ORIG-GUID: QqH1Ghpj5ydBr4pmMZw4eIZhmrwWvj9d
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
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

The SO_ALL|SO_OBJECTS pair is only used when enabling CONFIG_SLUB_DEBUG
option, so the objects_show() definition should be surrounded by
CONFIG_SLUB_DEBUG too.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5cc56f780241..b8afe12ebba1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5613,12 +5613,6 @@ static ssize_t cpu_slabs_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(cpu_slabs);
 
-static ssize_t objects_show(struct kmem_cache *s, char *buf)
-{
-	return show_slab_objects(s, buf, SO_ALL|SO_OBJECTS);
-}
-SLAB_ATTR_RO(objects);
-
 static ssize_t objects_partial_show(struct kmem_cache *s, char *buf)
 {
 	return show_slab_objects(s, buf, SO_PARTIAL|SO_OBJECTS);
@@ -5713,6 +5707,12 @@ static ssize_t total_objects_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(total_objects);
 
+static ssize_t objects_show(struct kmem_cache *s, char *buf)
+{
+	return show_slab_objects(s, buf, SO_ALL|SO_OBJECTS);
+}
+SLAB_ATTR_RO(objects);
+
 static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
-- 
2.30.2

