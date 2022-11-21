Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25831632A77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiKURMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiKURMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA862CB9C4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACEF41F8AC;
        Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIAiT/GWezpGGl+wQsu7Tv56r8ovXdCIcTxm0/tgheY=;
        b=GvgIJH/oeJ3busNpCVt+0e739h8ng7Y5p0H1Yvj8Oyyz4VNlMSoMJeSSkcRWIVIi+rwbOm
        9iY7YqAVIJ3Q1bniJXZImm1Ex1ohYTS9h9AbyfhgjeSYdiWb6qiMTz0AxzDiwJ4mOMYjiq
        Wm6Ff/tkvltO0fhwoQ58ct2GtyMQF6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIAiT/GWezpGGl+wQsu7Tv56r8ovXdCIcTxm0/tgheY=;
        b=EtJakSavfVgdRtpd6s1MaFBxytPX8OtTNWjLrPrxQfI+w+LmcN1V+PnY15Kz29QVD5t6PY
        jcDi72IIpNYPBRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F54113B03;
        Mon, 21 Nov 2022 17:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id INVuHmqxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:10 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 01/12] mm, slab: ignore hardened usercopy parameters when disabled
Date:   Mon, 21 Nov 2022 18:11:51 +0100
Message-Id: <20221121171202.22080-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_HARDENED_USERCOPY not enabled, there are no
__check_heap_object() checks happening that would use the kmem_cache
useroffset and usersize fields. Yet the fields are still initialized,
preventing merging of otherwise compatible caches. Thus ignore the
values passed to cache creation and leave them zero when
CONFIG_HARDENED_USERCOPY is disabled.

In a quick virtme boot test, this has reduced the number of caches in
/proc/slabinfo from 131 to 111.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0042fb2730d1..a8cb5de255fc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -317,7 +317,8 @@ kmem_cache_create_usercopy(const char *name,
 	flags &= CACHE_CREATE_MASK;
 
 	/* Fail closed on bad usersize of useroffset values. */
-	if (WARN_ON(!usersize && useroffset) ||
+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
+	    WARN_ON(!usersize && useroffset) ||
 	    WARN_ON(size < usersize || size - usersize < useroffset))
 		usersize = useroffset = 0;
 
@@ -640,6 +641,9 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 		align = max(align, size);
 	s->align = calculate_alignment(flags, align, size);
 
+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY))
+		useroffset = usersize = 0;
+
 	s->useroffset = useroffset;
 	s->usersize = usersize;
 
-- 
2.38.1

