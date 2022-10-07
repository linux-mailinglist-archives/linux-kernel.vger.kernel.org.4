Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F55F7449
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJGGmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJGGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:42:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48556112AB7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:41:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5BC7C21921;
        Fri,  7 Oct 2022 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665124917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubZ+4Ck86Ph/G26SuwNF8h0CjJlNbh0F0U0WIgCgLNk=;
        b=u0B1gOZKRfVtDSiWXK3FHZ+7ZuhS2wNNXD2scXaLTkjdp0U2MWi81cz5CIcqR4f3bUYv8g
        jBnNrjXqx/FvjTozEfvlu2sla1YODh2H6SsLXM8Wx9NXvu+jcHK0gNago1wWy0qFR2qe/S
        z8XGz3kjUOzbP5zxy3/AUWO6neU04g0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26A1513A3D;
        Fri,  7 Oct 2022 06:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VkUHCDXKP2P2SQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 06:41:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 2/3] xen/virtio: use dom0 as default backend for CONFIG_XEN_VIRTIO_FORCE_GRANT
Date:   Fri,  7 Oct 2022 08:41:42 +0200
Message-Id: <20221007064143.10049-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221007064143.10049-1-jgross@suse.com>
References: <20221007064143.10049-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_XEN_VIRTIO_FORCE_GRANT set the default backend domid to 0,
enabling to use xen_grant_dma_ops for those devices.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/grant-dma-ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 646ca913c05c..c703b77b33c9 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -349,6 +349,9 @@ void xen_grant_setup_dma_ops(struct device *dev)
 	if (dev->of_node) {
 		if (xen_dt_grant_init_backend_domid(dev, data))
 			goto err;
+	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
+		dev_info(dev, "Using dom0 as backend\n");
+		data->backend_domid = 0;
 	} else {
 		/* XXX ACPI device unsupported for now */
 		goto err;
-- 
2.35.3

