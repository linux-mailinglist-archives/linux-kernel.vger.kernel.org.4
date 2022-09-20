Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE45BE56A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiITMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiITMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:14:09 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392576B67B;
        Tue, 20 Sep 2022 05:14:08 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oac55-004fqT-6p;
        Tue, 20 Sep 2022 14:12:39 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] mm: Make failslab writable again
Date:   Tue, 20 Sep 2022 15:11:11 +0300
Message-Id: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In (060807f841ac mm, slub: make remaining slub_debug related attributes
read-only) failslab was made read-only.
I think it became a collateral victim to the two other options for which
the reasons are perfectly valid.
Here is why:
 - sanity_checks and trace are slab internal debug options,
   failslab is used for fault injection.
 - for fault injections, which by presumption are random, it
   does not matter if it is not set atomically. And you need to
   set atleast one more option to trigger fault injection.
 - in a testing scenario you may need to change it at runtime
   example: module loading - you test all allocations limited
   by the space option. Then you move to test only your module's
   own slabs.
 - when set by command line flags it effectively disables all
   cache merges.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Jann Horn <jannh@google.com>
Cc: Vijayanand Jitta <vjitta@codeaurora.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pekka Enberg <penberg@kernel.org>
Link: http://lkml.kernel.org/r/20200610163135.17364-5-vbabka@suse.cz

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 Documentation/mm/slub.rst |  2 ++
 mm/slub.c                 | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

V1->V2: Fixed commit message. Flags are set using WRITE_ONCE.

diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index 43063ade737a..86837073a39e 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -116,6 +116,8 @@ options from the ``slub_debug`` parameter translate to the following files::
 	T	trace
 	A	failslab
 
+failslab file is writable, so writing 1 or 0 will enable or disable
+the option at runtime. Write returns -EINVAL if cache is an alias.
 Careful with tracing: It may spew out lots of information and never stop if
 used on the wrong slab.
 
diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..57cf18936526 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5617,7 +5617,21 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
 }
-SLAB_ATTR_RO(failslab);
+
+static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
+				size_t length)
+{
+	if (s->refcount > 1)
+		return -EINVAL;
+
+	if (buf[0] == '1')
+		WRITE_ONCE(s->flags, s->flags | SLAB_FAILSLAB);
+	else
+		WRITE_ONCE(s->flags, s->flags & ~SLAB_FAILSLAB);
+
+	return length;
+}
+SLAB_ATTR(failslab);
 #endif
 
 static ssize_t shrink_show(struct kmem_cache *s, char *buf)

base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf
-- 
2.31.1

