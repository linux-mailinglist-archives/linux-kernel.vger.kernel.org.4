Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74898624B68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiKJUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiKJUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:14:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0E50F1B;
        Thu, 10 Nov 2022 12:14:56 -0800 (PST)
Received: from dimapc.. (unknown [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 69D8C6602A41;
        Thu, 10 Nov 2022 20:14:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668111295;
        bh=Y9B9YrrEmHlNO1aEObVWaFh4UvP89E0LA68VwtlK5tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvJFNfG0veek5/GRaGa5nRrI/zKHIbyJmgP5Wf0I7nWHz14yHRQEDHx4U91zB4+XD
         DSZNDsmp1HtnE+QNOMSbxp9pUzx2JkuOF6lmfXmztWoOfbHEwP6SzHu/oMI5WkiuD4
         oX6vaEzRzRW/siHAWBjRVqW6yjWzyJfTbPzG3MvfNQs8R1zP6AMq/0gU0aPQp1L80R
         yXf2zI9i9HIIVNTDlvjA7BXetRNrmgqF/RdqwW+1JMdVFVILpoEaFunwkrayKHghVS
         4ZSMpbMXyeTxhUhFrD0LReNJC90DC/wylSo3H1ulvMs/kenG8FCVxr2YPwqlzXVQM0
         QMcmyw/jqO+gQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 3/6] udmabuf: Assert held reservation lock for dma-buf mmapping
Date:   Thu, 10 Nov 2022 23:13:46 +0300
Message-Id: <20221110201349.351294-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110201349.351294-1-dmitry.osipenko@collabora.com>
References: <20221110201349.351294-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace mmaps dma-buf's fd, the dma-buf reservation lock must be
held. Add locking sanity check to the dma-buf mmaping callback to ensure
that the locking assumption won't regress in the future.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/udmabuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2bcdb935a3ac..283816fbd72f 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -2,6 +2,7 @@
 #include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -49,6 +50,8 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 {
 	struct udmabuf *ubuf = buf->priv;
 
+	dma_resv_assert_held(buf->resv);
+
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-- 
2.37.3

