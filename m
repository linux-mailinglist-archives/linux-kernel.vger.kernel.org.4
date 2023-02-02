Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3D687FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjBBOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBBOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:20:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E48FB7D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F56DB8267C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83694C433EF;
        Thu,  2 Feb 2023 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675347626;
        bh=rjlTumiEDosDf3VoaNyjrPYahbG/tYcj2ovz/+QCuKE=;
        h=From:To:Cc:Subject:Date:From;
        b=rjM27dZLm9HA3HJZC6HsZUCqtjXY0zcHHm3bC/m3aQeX55ynmjzNkB6H3m3MSj0Tu
         mjM8RM4/mSLc9uMImlmdmaFXB96F1YWHkAKNco8snQq2m6OXbqdVade/yiYh0wbwjV
         2hDkVBHlm9PilA0HcUkUjM8kqdjdjYWSdEmYVrB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:20:22 +0100
Message-Id: <20230202142022.2300096-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=gregkh@linuxfoundation.org; h=from:subject; bh=rjlTumiEDosDf3VoaNyjrPYahbG/tYcj2ovz/+QCuKE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3jy3bUBdiu/qlfrnlRw0ZvfUvd5dnOfaeLLxadv3wv4v8 s6MSO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi2a0M8xOPn0qcL3P/ZPmDFIVJR3 o7d84qdGVYcLphSU2ZrRmX0+4J+9/qlGftLQtjBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 13459c69095a..4880e461fcc5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6449,7 +6449,7 @@ static void debugfs_slab_add(struct kmem_cache *s)
 
 void debugfs_slab_release(struct kmem_cache *s)
 {
-	debugfs_remove_recursive(debugfs_lookup(s->name, slab_debugfs_root));
+	debugfs_lookup_and_remove(s->name, slab_debugfs_root);
 }
 
 static int __init slab_debugfs_init(void)
-- 
2.39.1

