Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE66BB5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjCOOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjCOOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:24:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9004126BA;
        Wed, 15 Mar 2023 07:24:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46B3D219B6;
        Wed, 15 Mar 2023 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678890292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=a+KmZa22ry4Mgykdv6ds4+NZZU+jJdD3ovXoAnBercU=;
        b=fk+lviOJUYNIIWxZOQhBR3LYVKPlSO9Q7aIZlYx+5Pqh+c8/whk6rzTCZ0lz+4kEWpcKes
        mGAIJV8WYHa9uLpVrFRSWralgJptO3m9XhZotPURxqBh7xCYEMxy4fW7iahXQwyLGKiDhO
        f6MrDxPvgubph7iVYP2ODp1BgAZ/eyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678890292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=a+KmZa22ry4Mgykdv6ds4+NZZU+jJdD3ovXoAnBercU=;
        b=PKcHYVjHTS3FQPTGcYiDe8udkvAtI9bmDIT8yZfNAEK1cRYJJFKSqBfoGSaTRmG8uUprMn
        4NPv5OFsvmDfgjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2732213A2F;
        Wed, 15 Mar 2023 14:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dV3kCDTVEWTaRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Mar 2023 14:24:52 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH] ring-buffer: remove obsolete comment for free_buffer_page()
Date:   Wed, 15 Mar 2023 15:24:46 +0100
Message-Id: <20230315142446.27040-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment refers to mm/slob.o which is being removed. It comes from
commit ed56829cb319 ("ring_buffer: reset buffer page when freeing") and
according to Steven the borrowed code was a page mapcount and mapping
reset, which was later removed by commit e4c2ce82ca27 ("ring_buffer:
allocate buffer page pointer"). Thus the comment is not accurate anyway,
remove it.

Reported-by: Mike Rapoport <mike.rapoport@gmail.com>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Fixes: e4c2ce82ca27 ("ring_buffer: allocate buffer page pointer")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/trace/ring_buffer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af50d931b020..c6f47b6cfd5f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -354,10 +354,6 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
-/*
- * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
- * this issue out.
- */
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
-- 
2.39.2

