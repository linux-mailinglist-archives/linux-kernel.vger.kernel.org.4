Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC660EBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiJZWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiJZWrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:47:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C4550BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:47:23 -0700 (PDT)
Received: from dimapc.. (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A74CB66028B0;
        Wed, 26 Oct 2022 23:47:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666824441;
        bh=6QiRYUSIMrwPPW/bBvP2JzfoL5s94stAk7lsEZE9m8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxHJGJrXr3g7J0J0RfrP4JFa3nf0DcPezfn4+8uA+S1ghQJkSPIgCGWeSfQj2nYQ5
         JteVO3aWq8EK78cA3C2H9IKn5y3f+biO5ugA3yV6zqc976O+uzJEWaxxXo9zSlRbHY
         qpnaRMgGJ8RVu8iKcErs8ZXZjcuzdVjOKLRI6UrdtQCYUvmL4cDQb4LHR7TY6kbrOn
         s1Qzkg4NpCasK0MI2cO7jirXKaZRQCnbNzD1H9vFBAYe7akc7zKzBndF7ER9yMNaVu
         xLcCOMfL7LuBqXOwamj/BEpoxXF4nOXQru2umqRKw4t0wxANEL4+LZc2lIu0sk8Qgb
         It/Hk6J8WUfyA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, noralf@tronnes.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dma-buf: Make locking consistent in dma_buf_detach()
Date:   Thu, 27 Oct 2022 01:46:39 +0300
Message-Id: <20221026224640.7542-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026224640.7542-1-dmitry.osipenko@collabora.com>
References: <20221026224640.7542-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_buf_detach() locks attach->dmabuf->resv and then unlocks
dmabuf->resv, which could be a two different locks from a static
code checker perspective. In particular this triggers Smatch to
report the "double unlock" error. Make the locking pointers consistent.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/dri-devel/Y1fLfsccW3AS%2Fo+%2F@kili/
Fixes: 809d9c72c2f8 ("dma-buf: Move dma_buf_attach() to dynamic locking specification")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/dma-buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index c40d72d318fd..6e33ef4fde34 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -998,9 +998,10 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (WARN_ON(!dmabuf || !attach))
 		return;
 
-	dma_resv_lock(attach->dmabuf->resv, NULL);
+	dma_resv_lock(dmabuf->resv, NULL);
 
 	if (attach->sgt) {
+		WARN_ON(dmabuf != attach->dmabuf);
 
 		__unmap_dma_buf(attach, attach->sgt, attach->dir);
 
-- 
2.37.3

