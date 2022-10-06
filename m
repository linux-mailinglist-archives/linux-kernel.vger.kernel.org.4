Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31E5F6183
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJFHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJFHPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:15:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5C3DF34
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:15:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC02219B0;
        Thu,  6 Oct 2022 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665040520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Ps9KwyB3HzeWHTtk+TkXmbcFpLo/S34tHtBoU7GquI=;
        b=mqv/aQ0xhf3jHn27YkkjHI6JbMnzF0R/hfiYz+yvCI+4IpL/79Wa0CyW8t1leaae0aWx3m
        uHS7KHzrKvYdOxsxpiBr+vlF4gxQSdJ2xILjF6blKUTRNxvsgaQNfGLfyfkbRvGFjuUMEd
        4QKwMuqh9zjDVwgXZYgeQ0aTcivnjro=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B51CE1376E;
        Thu,  6 Oct 2022 07:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MqLUKoeAPmNJEwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 07:15:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 3/3] xen/virtio: enable grant based virtio on x86
Date:   Thu,  6 Oct 2022 09:15:00 +0200
Message-Id: <20221006071500.15689-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221006071500.15689-1-jgross@suse.com>
References: <20221006071500.15689-1-jgross@suse.com>
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

Use an x86-specific virtio_check_mem_acc_cb() for Xen in order to setup
the correct DMA ops.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_hvm.c |  2 +-
 arch/x86/xen/enlighten_pv.c  |  2 +-
 drivers/xen/grant-dma-ops.c  | 10 ++++++++++
 include/xen/xen-ops.h        |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 1c1ac418484b..c1cd28e915a3 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -212,7 +212,7 @@ static void __init xen_hvm_guest_init(void)
 		return;
 
 	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
-		virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
+		virtio_set_mem_acc_cb(xen_virtio_restricted_mem_acc);
 
 	init_hvm_pv_info();
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 9b1a58dda935..45b24c1b646a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -112,7 +112,7 @@ static void __init xen_pv_init_platform(void)
 {
 	/* PV guests can't operate virtio devices without grants. */
 	if (IS_ENABLED(CONFIG_XEN_VIRTIO))
-		virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
+		virtio_set_mem_acc_cb(xen_virtio_restricted_mem_acc);
 
 	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index a00112235877..60a7acc334ed 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -372,6 +372,16 @@ void xen_grant_setup_dma_ops(struct device *dev)
 	dev_err(dev, "Cannot set up Xen grant DMA ops, retain platform DMA ops\n");
 }
 
+bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
+{
+	bool ret = xen_virtio_mem_acc(dev);
+
+	if (ret)
+		xen_grant_setup_dma_ops(dev->dev.parent);
+
+	return ret;
+}
+
 MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
 MODULE_AUTHOR("Juergen Gross <jgross@suse.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index dae0f350c678..3dd5aa936f1d 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -219,6 +219,7 @@ static inline void xen_preemptible_hcall_end(void) { }
 void xen_grant_setup_dma_ops(struct device *dev);
 bool xen_is_grant_dma_device(struct device *dev);
 bool xen_virtio_mem_acc(struct virtio_device *dev);
+bool xen_virtio_restricted_mem_acc(struct virtio_device *dev);
 #else
 static inline void xen_grant_setup_dma_ops(struct device *dev)
 {
-- 
2.35.3

