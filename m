Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836F5BDCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiITF7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiITF6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:58:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638710D3;
        Mon, 19 Sep 2022 22:58:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAF761F8B3;
        Tue, 20 Sep 2022 05:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663653518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aoSDN2qGfxPVg2ZtR3RCnNgdpjv9RD90HMCgzYD+Sdc=;
        b=Po8NCp49RQfswaj8iJPHpYEeGN3ux5P7zORk+jRAYHoFdrcbnyd1V+xAbqOAwlbhrQoJ/L
        I6mPDkipEo4RAMXPWGCkjIYG+Ganzuv326koJUQzUt3Ls2ZFNPHOf+AUIbQHuYTz/PSCYD
        hrMJIb0ZlYjzJTs2Qecl6gycz1kvsgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663653518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aoSDN2qGfxPVg2ZtR3RCnNgdpjv9RD90HMCgzYD+Sdc=;
        b=mOfSpbRC7QJQRNnnlxjF8oFHbxL5BlQ1RotQ1mo9UNhc19yh3HFQXwAHwQcX0+VKQa6aJC
        QfiVM+QygdFBcSAA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC6BA2C141;
        Tue, 20 Sep 2022 05:58:38 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend v2] clk: pistachio: Fix initconst confusion
Date:   Tue, 20 Sep 2022 07:58:38 +0200
Message-Id: <20220920055838.22637-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

A variable pointing to const isn't const itself. It has to contain
"const" keyword after "*" too. So to keep it in __initconst (and not
mark properly as __initdata), add the "const" keyword exactly there.

Note we need to update struct pistachio_mux too. On the other hand, the
clk core already counts with "const char *const" already.

[js] more explanatory commit message.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v2] as suggested by Stephen, instead of switching to __initdata, make
         it real const

 drivers/clk/pistachio/clk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index f9c31e3a0e47..2f4ffbd98282 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -31,10 +31,10 @@ struct pistachio_mux {
 	unsigned int shift;
 	unsigned int num_parents;
 	const char *name;
-	const char **parents;
+	const char *const *parents;
 };
 
-#define PNAME(x) static const char *x[] __initconst
+#define PNAME(x) static const char *const x[] __initconst
 
 #define MUX(_id, _name, _pnames, _reg, _shift)			\
 	{							\
-- 
2.37.3

