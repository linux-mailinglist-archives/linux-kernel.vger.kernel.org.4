Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4986D632A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiKURMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKURMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432DCEFC6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D35E41F8B9;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2JvvueNOyE9wh1FqFGLP1e7ObZGjB/Lqr6ycx9tY24=;
        b=oObh6wdNyZY9Dk99j4ViHgNh4V3x7QkVPcXKRIc1vMg0NknSGlK4nStjQ3MC9q31fDkn3g
        VEXegpinTx+uvpuiTMD7CV+Q/YH333P46dlA7hmutWR0nA0aglK+xwBz3QqoiZ+jV+mG0P
        0MNq2GbwWXP4QlFMuvb26vfpljrSZic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2JvvueNOyE9wh1FqFGLP1e7ObZGjB/Lqr6ycx9tY24=;
        b=leDY5l4B4sBPGcsiGjIniDoS7JrKHJETEOsEfHQjeMxhOfosw5yHw4fzoQ38mjrhMZxumR
        q2GPwRTyterJdTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6CDF13B03;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SPMeKGuxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:11 +0000
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 07/12] mm, slab: ignore SLAB_RECLAIM_ACCOUNT with CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:11:57 +0100
Message-Id: <20221121171202.22080-8-vbabka@suse.cz>
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

SLAB_RECLAIM_ACCOUNT caches allocate their slab pages with
__GFP_RECLAIMABLE and can help against fragmentation by grouping pages
by mobility, but on tiny systems mobility grouping is likely disabled
anyway and ignoring SLAB_RECLAIM_ACCOUNT might instead lead to merging
of caches that are made incompatible just by the flag.

Thus with CONFIG_SLUB_TINY, make SLAB_RECLAIM_ACCOUNT ineffective.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3ce9474c90ab..1cbbda03ad06 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -129,7 +129,11 @@
 
 /* The following flags affect the page allocator grouping pages by mobility */
 /* Objects are reclaimable */
+#ifndef CONFIG_SLUB_TINY
 #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
+#else
+#define SLAB_RECLAIM_ACCOUNT	0
+#endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
 /*
-- 
2.38.1

