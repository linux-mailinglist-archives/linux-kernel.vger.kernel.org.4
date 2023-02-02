Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7985688175
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjBBPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjBBPP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:15:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF29A80FB6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:15:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A2A761BCE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA4BC433EF;
        Thu,  2 Feb 2023 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675350958;
        bh=d2XBw40Rb8AxKHAimNs7K4RmZkV7XL+DsegnFjh7AAE=;
        h=From:To:Cc:Subject:Date:From;
        b=T9UJifDL74S8Dd1VjvaNyBPy5pllWMxeOl52Zrugg1whBH7JPnZZ6+HHphLb53nVs
         pluNnjy3yiaf2Ese25sGm5bXu4dk/0GBumaPbRg2knqCc5yLZ/qI8S50co4o+1AL0K
         IBuJlz5+lbJzQD+5c3YIY1EYoLirc6XdiK2Un80g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kernel/irq/irqdomain.c: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:15:54 +0100
Message-Id: <20230202151554.2310273-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=gregkh@linuxfoundation.org; h=from:subject; bh=d2XBw40Rb8AxKHAimNs7K4RmZkV7XL+DsegnFjh7AAE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3L6/68bM+Vnyu2aluni3XX5bLnXq/dun7h0xrOZJtLofc vzRzZkcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMpHoTw4Ljc9py1378cHP9uY0713 EIOzpxTvBmmJ/0iPNzrGyYop3T25OMTuH9zG8PnQYA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fe1da9614ee..e2096b51c004 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1915,7 +1915,7 @@ static void debugfs_add_domain_dir(struct irq_domain *d)
 
 static void debugfs_remove_domain_dir(struct irq_domain *d)
 {
-	debugfs_remove(debugfs_lookup(d->name, domain_dir));
+	debugfs_lookup_and_remove(d->name, domain_dir);
 }
 
 void __init irq_domain_debugfs_init(struct dentry *root)
-- 
2.39.1

