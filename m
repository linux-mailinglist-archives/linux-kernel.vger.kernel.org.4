Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB49620C88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiKHJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiKHJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:42:06 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D7432BBE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:42:04 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B325160015;
        Tue,  8 Nov 2022 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667900523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1m/wXqz3m3Z8KOPX0vHt3R2SNBbCLX0ZfbTz9ZhUWoo=;
        b=WftMKg6BPP2Xu50Spqn4fVqH8JY5SYueG8mkI4sNRhCrcIymX/IkKiz7Snk79xhcQq3wmX
        bx0wVbb2MP5kIZ34j20Bkdm1FceSW3SoNSH8qpOkix14H70mWIxPSuO+l51ZeRBBXHWcRm
        5ybD9wO7PzvD6dFvUAaj4Itl4BYy2qHs/Q3XmfMCC2QjzU57R7lbIiJ4Xtn1/ADhjHzJA2
        ehrefxKU7Hj+LC595rHJzkVdKfYyZEm6KanGmErVIqSWsj2x00ceBakndAHQWGJ0vMqeDy
        jsRd4ueswMbaPhlj9E60Y91wG2SS5rwlT4pVCmHz9Xz20E4hUT863b+YhkNuYA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH] mm/kmemleak: use %pK to display kernel pointers in backtrace
Date:   Tue,  8 Nov 2022 10:43:22 +0100
Message-Id: <20221108094322.73492-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, %p is used to display kernel pointers in backtrace which result
in a hashed value that is not usable to correlate the address for debug.
Use %pK which will respect the kptr_restrict configuration value and thus
allow to extract meaningful information from the backtrace.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 646e2979641f..b16be8891ae3 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -358,7 +358,7 @@ static void print_unreferenced(struct seq_file *seq,
 
 	for (i = 0; i < object->trace_len; i++) {
 		void *ptr = (void *)object->trace[i];
-		warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
+		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
 	}
 }
 
-- 
2.38.1

