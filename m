Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CA72F543
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjFNG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjFNG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:59:23 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87514198D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:59:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgx9h3LnCzBQJYj
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:59:20 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686725960; x=1689317961; bh=M4zJl5qkZeh/H9ESI31UdmagVvc
        YkNvG1PgXOWZNocs=; b=j7jCm9UZIjpsToDyjjGhSbYHS3gsT/Ks3FBlGo0ILF+
        jVc5m3oYoPT0AVhFeiPLSJHIWFoU0osv1M9TD5Wuy3wpKsZ9lMlb8pnUIUVMe63Y
        rPuceoFUVzgabnCUEGan2TGR/7iGAcWqOomGTBtIUM2KX1w8nm2fWrHlby13cvO8
        PYQjGHlbU39M7iOXeZ1mPtTk+cua1x42YspLrJiqU4lPSA+6X75FQwAHiSvltk65
        w9IeEyqHxCOzVUvDA0Zpb+70MQY8ms4aJqCFENDgxJeWMClFqMkBViC84hk4Zsn6
        MIiHdOWAnxz5LmPFcufldr9qMv9KzaZ3RkkQ15SFF3w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tnkl7NdCUXck for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:59:20 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgx9h27QLzBJLB3;
        Wed, 14 Jun 2023 14:59:20 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:59:20 +0800
From:   wuyonggang001@208suo.com
To:     peterx@redhat.com, viro@zeniv.linux.org.uk
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha/mm: Fix comparing pointer
In-Reply-To: <20230614065602.29731-1-zhanglibing@cdjrlc.com>
References: <20230614065602.29731-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <258e87a54a1dd59b4f3d62ba9fa42242@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

arch/alpha/mm/fault.c:200:52-53: WARNING comparing pointer to 0

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  arch/alpha/mm/fault.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 7b01ae4f3bc6..31db549ef0b5 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -197,7 +197,8 @@ do_page_fault(unsigned long address, unsigned long 
mmcsr,

   no_context:
      /* Are we prepared to handle this fault as an exception?  */
-    if ((fixup = search_exception_tables(regs->pc)) != 0) {
+    fixup = search_exception_tables(regs->pc);
+    if (fixup != NULL) {
          unsigned long newpc;
          newpc = fixup_exception(dpf_reg, fixup, regs->pc);
          regs->pc = newpc;
