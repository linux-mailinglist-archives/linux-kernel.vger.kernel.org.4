Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF75F6182
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJFHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJFHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:15:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E35817A9D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:15:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 547FD1F8C8;
        Thu,  6 Oct 2022 07:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665040514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CshijtaHr92stGSDZHMzCA/tn87geqWqdgj21TRuNc=;
        b=XcbUCD9o3PCb96W7Lx2pJ43DcJkjWoXykE9e7nTT/kS3m1zFb9YDxpuUVs2na45rQC+PCh
        sSh5iPuz1gLVgaZnLLoLdLvXZkXtz3YLIoZEYeZhhm6DGcwghEs1QYGawjNYkSah65JQsq
        EYuLVLQs3J+dFpZRCHv148T+yFFyXM4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17F3B1376E;
        Thu,  6 Oct 2022 07:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7+JTBIKAPmM+EwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 07:15:14 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 2/3] xen/virtio: use dom0 as default backend for CONFIG_XEN_VIRTIO_FORCE_GRANT
Date:   Thu,  6 Oct 2022 09:14:59 +0200
Message-Id: <20221006071500.15689-3-jgross@suse.com>
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

With CONFIG_XEN_VIRTIO_FORCE_GRANT set the default backend domid to 0,
enabling to use xen_grant_dma_ops for those devices.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/grant-dma-ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index f29759d5301f..a00112235877 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -349,6 +349,9 @@ void xen_grant_setup_dma_ops(struct device *dev)
 	if (dev->of_node) {
 		if (xen_dt_grant_setup_dma_ops(dev, data))
 			goto err;
+	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
+		dev_info(dev, "Using dom0 as backend\n");
+		data->backend_domid = 0;
 	} else {
 		/* XXX ACPI device unsupported for now */
 		goto err;
-- 
2.35.3

