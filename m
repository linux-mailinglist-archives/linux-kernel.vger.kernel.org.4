Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F336CABED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjC0RhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjC0Rg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:36:58 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F32117
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=xi+9McRtPlTN/EBgexZWmMQt3u7zyZsUNU4NiGaVw5E=; b=Ea
        0fWQBCPjgN0TeRUT5p2E9N2uL60mguHHPO1ITQbMlfeckXrtYLWZSN37zTtPsMDgBi1U/DWAKAHTO
        bpMbmM36EPnInvs8tqYpSXJ2TJA6ahFzqUxM29fkAo3uJAKnPGegJF2kbxkhw0rM7/hrNFuN5lIDY
        U72fu7+1AcVExQcLhjpJl3c7Q/xl6lgGPIyDVtRwPpPrqmN0t7iUByDdknprWdoiDmHXEQhnL9vFg
        KBJtxojfpazGzh6iyH0kjHnU0balnkqBUEK1YddM/eZn8vj1/dh8G5Bfjxe5yNZeHpM/bk2qORqnG
        a+m0o9N3Yk0NjZJp+MDGopAsfGgwSpaA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pgqm3-0006gE-5x;
        Mon, 27 Mar 2023 18:36:52 +0100
From:   John Keeping <john@metanate.com>
To:     linux-trace-kernel@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: mark get_lock_parent_ip() __always_inline
Date:   Mon, 27 Mar 2023 18:36:46 +0100
Message-Id: <20230327173647.1690849-1-john@metanate.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the compiler decides not to inline this function then preemption
tracing will always show an IP inside the preemption disabling path and
never the function actually calling preempt_{enable,disable}.

Signed-off-by: John Keeping <john@metanate.com>
---
 include/linux/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 327046f1278d..6954e4ed5bbf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -964,7 +964,7 @@ static inline void __ftrace_enabled_restore(int enabled)
 #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
 #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))
 
-static inline unsigned long get_lock_parent_ip(void)
+static __always_inline unsigned long get_lock_parent_ip(void)
 {
 	unsigned long addr = CALLER_ADDR0;
 
-- 
2.40.0

