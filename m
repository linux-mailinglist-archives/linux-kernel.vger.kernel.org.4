Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462A566E328
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjAQQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAQQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:12:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A283B3D3;
        Tue, 17 Jan 2023 08:12:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9E4E01F385;
        Tue, 17 Jan 2023 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673971929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=185VNqtOqrWbrz+iqnibvY2OKcoNRPZvWlFEs/lSiyw=;
        b=DFisV2MPDS3tQ97+t5ehDa1oiSns+MsIadujPEsel0Q3rDNaZ88r2bgBdYYDX/JAu3gGpr
        phicHXPF6isX3ScM6jjUBVLwHeex3nLoYufaOlT/aVGoU7XFuWz4hSLRG5F8adkUylQhyi
        VcXUynz/RJ7SEwQw3AdBsjbPa8ESaJ8=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 4A24C2C141;
        Tue, 17 Jan 2023 16:12:08 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        coverity-bot <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: [PATCH] printk: Use scnprintf() to print the message about the dropped messages on a console
Date:   Tue, 17 Jan 2023 17:10:31 +0100
Message-Id: <20230117161031.15499-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
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

Use scnprintf() for printing the message about dropped messages on
a console. It returns the really written length of the message.
It prevents potential buffer overflow when the returned length is
later used to copy the buffer content.

Note that the previous code was safe because the scratch buffer was
big enough and the message always fit in. But scnprintf() makes
it more safe, definitely.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")
Link: https://lore.kernel.org/r/202301131544.D9E804CCD@keescook
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 55338bfd3b55..a9b7dade0d2e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2716,7 +2716,7 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
 	char *outbuf = &pbufs->outbuf[0];
 	size_t len;
 
-	len = snprintf(scratchbuf, scratchbuf_sz,
+	len = scnprintf(scratchbuf, scratchbuf_sz,
 		       "** %lu printk messages dropped **\n", dropped);
 
 	/*
-- 
2.35.3

