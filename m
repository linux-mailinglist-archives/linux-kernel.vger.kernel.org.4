Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9355FFF30
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJPMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJPMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:31:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB036845;
        Sun, 16 Oct 2022 05:31:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA0B633A46;
        Sun, 16 Oct 2022 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665923477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qD3P5jMHsGMDFWM0XMYxlTpTliGBHcgI0IoO+d5uMKw=;
        b=bs65FvbUgTVRWxu05wBg6EcttKoaGu4Sl0WaKZCRNu0yBZCRd/0ZD6Pb3eMfVGEz+kjWnA
        cxDRF5w5PyxtoTkL5oHlJ4dZcUJ3OYN5Mde52jKaP0nxwOBW5ef/omAFddoEGidv7csQ+X
        JTozn+2vFRFLGTbz6p0qvbiap9r4fg0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA42813A36;
        Sun, 16 Oct 2022 12:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iE2PLJX5S2MyMAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 16 Oct 2022 12:31:17 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 2/4] module: Update a comment describing what is protected by module_mutex
Date:   Sun, 16 Oct 2022 14:30:29 +0200
Message-Id: <20221016123031.3963-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221016123031.3963-1-petr.pavlu@suse.com>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a12e177ea81f..5288843ca40f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -62,10 +62,11 @@
 
 /*
  * Mutex protects:
- * 1) List of modules (also safely readable with preempt_disable),
+ * 1) list of modules (also safely readable with preempt_disable, delete and add
+ *    uses RCU list operations).
  * 2) module_use links,
- * 3) mod_tree.addr_min/mod_tree.addr_max.
- * (delete and add uses RCU list operations).
+ * 3) mod_tree.addr_min/mod_tree.addr_max,
+ * 4) list of unloaded_tainted_modules.
  */
 DEFINE_MUTEX(module_mutex);
 LIST_HEAD(modules);
-- 
2.35.3

