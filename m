Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D92666BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbjALICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjALIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:01:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC6B855;
        Thu, 12 Jan 2023 00:01:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207C0B81DAA;
        Thu, 12 Jan 2023 08:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C18C433F1;
        Thu, 12 Jan 2023 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510504;
        bh=rIsx0xaNZAYS480UUhX/JaCVGkmDjFTLm68eqsstnoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XptHMLSatgZQiQ7UfRofLz+jyvbhokGj/sZjH9iDbCzJfAlYYDn7+wWuANEyGQxOx
         GuylhbAIXQBE0A6H5OSihIWhUom1vR82j83pUg6wsrcvwFX8OVKMOnsCg5fxySKJpY
         AR7spM7/QQdyFE9+ToCyIqFhucXF04RN+E+vjw3nOC37ZISDzFmLvMy5hENNIeZli3
         5rFEBZferAtawCiwO0uRxXsbdfXSuHyNjm721sDhGYkqms4kfrIPC7eXHI+MO9HT9L
         ReQZwFLOzoYXA8sJcZQi10gz+WOZlmczzxK2St+P7qs1cbJCip2h+1+TjWvcBQpkXV
         voIA4LdvLqeWg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/11] tty: vt: use sizeof(*variable) where possible
Date:   Thu, 12 Jan 2023 09:01:29 +0100
Message-Id: <20230112080136.4929-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112080136.4929-1-jirislaby@kernel.org>
References: <20230112080136.4929-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of sizeof(type), use sizeof(*variable) which is preferred. We
are going to remove the unicode's char32_t typedef, so this makes the
switch easier.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 561c82e120cf..3ae0212f1aa7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -330,11 +330,11 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 {
 	struct uni_screen *uniscr;
 	void *p;
-	unsigned int memsize, i;
+	unsigned int memsize, i, col_size = cols * sizeof(**uniscr->lines);
 
 	/* allocate everything in one go */
-	memsize = cols * rows * sizeof(char32_t);
-	memsize += rows * sizeof(char32_t *);
+	memsize = col_size * rows;
+	memsize += rows * sizeof(*uniscr->lines);
 	p = vzalloc(memsize);
 	if (!p)
 		return NULL;
@@ -344,7 +344,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 	p = uniscr->lines + rows;
 	for (i = 0; i < rows; i++) {
 		uniscr->lines[i] = p;
-		p += cols * sizeof(char32_t);
+		p += col_size;
 	}
 	return uniscr;
 }
@@ -469,7 +469,7 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
 		char32_t *src_line = src->lines[src_top_row];
 		char32_t *dst_line = dst->lines[dst_row];
 
-		memcpy(dst_line, src_line, src_cols * sizeof(char32_t));
+		memcpy(dst_line, src_line, src_cols * sizeof(*src_line));
 		if (dst_cols - src_cols)
 			memset32(dst_line + src_cols, ' ', dst_cols - src_cols);
 		src_top_row++;
-- 
2.39.0

