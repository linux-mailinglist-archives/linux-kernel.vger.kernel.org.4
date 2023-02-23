Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9796A03F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjBWIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjBWIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:38:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E1C65A7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:38:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 284F63783B;
        Thu, 23 Feb 2023 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677141482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OjqLWavRD0c6v8aVSvb9AaJsN7Lwf9zVFC8nWTsOnEs=;
        b=XcoE4YlvtCiamYLn8g2S1Pj6VcaqlTj+gK7/cEw7ISx8Q/iDAJzhtWF7Zw5DeGF7XJiC+C
        ooCyNKSmxcbUBM8q+AnHcQBzl2DbK8eI4khAxz0FyLFsZtOb10x1OFClrzxXLbp9XpDAml
        qSo8ro2tRB43uUi1XEdkQgHSoP8xaNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1E3B139B5;
        Thu, 23 Feb 2023 08:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VjLNOekl92OCTQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 08:38:01 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     johan+linaro@kernel.org, Juergen Gross <jgross@suse.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqdomain: fix regression for Xen guests
Date:   Thu, 23 Feb 2023 09:38:00 +0100
Message-Id: <20230223083800.31347-1-jgross@suse.com>
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

The recent switch to per-domain locking caused a NULL dereference in
irq_domain_create_hierarchy(), as Xen code is calling
msi_create_irq_domain() with a NULL parent pointer.

Fix that by testing parent to be set before dereferencing it. For a
non-existing parent the irq-domain's root will stay to point to
itself.

Fixes: 9dbb8e3452ab ("irqdomain: Switch to per-domain locking")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aa5b7eeeceb8..6522dfb2e49c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1172,7 +1172,8 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		domain = __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
 
 	if (domain) {
-		domain->root = parent->root;
+		if (parent)
+			domain->root = parent->root;
 		domain->parent = parent;
 		domain->flags |= flags;
 
-- 
2.35.3

