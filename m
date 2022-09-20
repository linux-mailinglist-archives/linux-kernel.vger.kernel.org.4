Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621EA5BDFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiITI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiITI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:27:03 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6C67CAE;
        Tue, 20 Sep 2022 01:24:22 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oaYSj-004etn-0W;
        Tue, 20 Sep 2022 10:20:49 +0200
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
Subject: [PATCH] mm: Make failslab writable again
Date:   Tue, 20 Sep 2022 11:20:33 +0300
Message-Id: <20220920082033.1727374-1-alexander.atanasov@virtuozzo.com>
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
read-only failslab) it was made RO.
I think it became a collateral victim to the other two options
(sanity_checks and trace) for which the reasons are perfectly valid.
Here is why:
 - sanity_checks and trace are slab internal debug options,
   failslab is used for fault injection.
 - for fault injections, which by presumption are random, it
   does not matter if it is not set atomically. You need to
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
 mm/slub.c                 | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index 862dbd9af4f5..7c15d312e0fb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5617,7 +5617,19 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
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
+	s->flags &= ~SLAB_FAILSLAB;
+	if (buf[0] == '1')
+		s->flags |= SLAB_FAILSLAB;
+	return length;
+}
+SLAB_ATTR(failslab);
 #endif
 
 static ssize_t shrink_show(struct kmem_cache *s, char *buf)

base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf
-- 
2.31.1

