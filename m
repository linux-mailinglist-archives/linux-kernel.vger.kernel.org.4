Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3599C612B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJ3Po7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ3Pox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:44:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C85FB1D8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 08:44:52 -0700 (PDT)
Received: from dimapc.. (unknown [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 539C7660225F;
        Sun, 30 Oct 2022 15:44:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667144690;
        bh=9L1UGeJdnkFYaRnE59XJ8gv48CnIdhLcIsE2uZ/nI0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrgMQ4JJcS/wCdnXA8AG/2ltnRc/459pzQVz+tPEzTYMw+l7wUlkqJ3gZn7BQsjRv
         9EqSxbTZQnHVfP80TN7xvKFBhY/gqWfvUuzxwqLZJzFlY/fllOOfADR9n2UjVY/Ovw
         vC2W3JH7CUfTxnn47rZPq8ltpqZkp44vY1VcNNd7WV7ugzd5Wn+KLCw30/TaqhP6IR
         BTFkOYacsIhlK0YpHKh2lzNCdwaG/NrrN6UBYAaGFaRd+fLrIv1r9kp7pMPoIXazJr
         hYSBvQpvrwDbcLRpxvHRM31eY6ni/XCZvj9Zmntx78pHz5itR4y+dreooXnjBow/ia
         PZ8gz0SH1PJQg==
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
Subject: [PATCH v2 1/2] dma-buf: Make locking consistent in dma_buf_detach()
Date:   Sun, 30 Oct 2022 18:44:11 +0300
Message-Id: <20221030154412.8320-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030154412.8320-1-dmitry.osipenko@collabora.com>
References: <20221030154412.8320-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/dri-devel/Y1fLfsccW3AS%2Fo+%2F@kili/
Fixes: 809d9c72c2f8 ("dma-buf: Move dma_buf_attach() to dynamic locking specification")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index c40d72d318fd..13bfd2d09c56 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -995,10 +995,10 @@ static void __unmap_dma_buf(struct dma_buf_attachment *attach,
  */
 void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 {
-	if (WARN_ON(!dmabuf || !attach))
+	if (WARN_ON(!dmabuf || !attach || dmabuf != attach->dmabuf))
 		return;
 
-	dma_resv_lock(attach->dmabuf->resv, NULL);
+	dma_resv_lock(dmabuf->resv, NULL);
 
 	if (attach->sgt) {
 
-- 
2.37.3

