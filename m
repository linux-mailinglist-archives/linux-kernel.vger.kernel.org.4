Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2081F739CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFVJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjFVJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:27:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB330E3;
        Thu, 22 Jun 2023 02:18:33 -0700 (PDT)
Received: from [IPV6:2a01:cb08:8af8:5b00:626e:5b8f:fa0f:ad38] (2a01cb088af85b00626e5b8ffa0fad38.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:8af8:5b00:626e:5b8f:fa0f:ad38])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: jmassot)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4419A660706D;
        Thu, 22 Jun 2023 10:18:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687425511;
        bh=Ib/XVk9MKhVAdq/PW9I6LfZTNNz9ldYe634L1da0PJE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cNGZJRWIJEJqj20bZ08SVZUQGVjovz0AjrSAbe2+zw9B5x++aWZED3bI4YQ1Tvn4a
         ckWexvmoTd1VpynP1/gUXT6Tp+8joUzgHR4OBqgp3oTIKQnqWtgGeZlYxDCcivV/f+
         VkTO16Pt3F2jWB9Zoj+c77GSkCfq5J1ajf/z3gygM2Fdll73jzVt4ZOEJkejSYVcBb
         w5AwZD/p/ymfKdFFDHMBiI9jjPllwKkNz9iwmtdD8NWhNBJ9ghcPq6UxSmVyRg5HZy
         rGI23lu0mqj0IPKJ9zfg3guCjFyIfICo8EAIqoRi1Lxr9/N/rupU6PT+i650gGjjRF
         ff5rF/3/Ta00g==
Message-ID: <512f54f5-60d5-db68-dce3-96cf70519b6c@collabora.com>
Date:   Thu, 22 Jun 2023 11:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 00/13] CSI2RX support on J721E
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, mripard@kernel.org, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, bparrot@ti.com,
        niklas.soderlund+renesas@ragnatech.se, j-luthra@ti.com,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com, martyn.welch@collabora.com,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20230314115516.667-1-vaishnav.a@ti.com>
 <28707378-c4e7-38b6-48f5-63b0834c18c9@ideasonboard.com>
From:   Julien Massot <julien.massot@collabora.com>
In-Reply-To: <28707378-c4e7-38b6-48f5-63b0834c18c9@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav,

  On 14/03/2023 13:55, Vaishnav Achath wrote:
> Hi,
>
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper 
> driver.
We are testing this patch series and experienced some strange behaviour,
with the same sequence of 5-10 frames repeated over and over.
(Almost the same sequence since frames have different md5sum)

To solve this issue we had to forward port some functions from the TI 
BSP Kernel[1] such as ti_csi2rx_restart_dma, and ti_csi2rx_drain_dma.

Can you consider this issue for the next patchset version?

Thank you,
Julien


Here are the modifications we made for information only.

---
  .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 138 +++++++++++++++---
  1 file changed, 117 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c 
b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 1af7b0b09cfc..e8579dbf07b4 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -46,6 +46,8 @@
  #define MAX_WIDTH_BYTES			SZ_16K
  #define MAX_HEIGHT_LINES		SZ_16K

+#define DRAIN_TIMEOUT_MS		50
+
  struct ti_csi2rx_fmt {
  	u32				fourcc;	/* Four character code. */
  	u32				code;	/* Mbus code. */
@@ -498,6 +500,59 @@ static void ti_csi2rx_setup_shim(struct 
ti_csi2rx_dev *csi)
  	writel(reg, csi->shim + SHIM_PSI_CFG0);
  }

+static void ti_csi2rx_drain_callback(void *param)
+{
+	struct completion *drain_complete = param;
+
+	complete(drain_complete);
+}
+
+static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct device *dev = csi->dma.chan->device->dev;
+	struct completion drain_complete;
+	void *buf;
+	size_t len = csi->v_fmt.fmt.pix.sizeimage;
+	dma_addr_t addr;
+	dma_cookie_t cookie;
+	int ret;
+
+	init_completion(&drain_complete);
+
+	buf = dma_alloc_coherent(dev, len, &addr, GFP_KERNEL | GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+
+	desc = dmaengine_prep_slave_single(csi->dma.chan, addr, len,
+					   DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		ret = -EIO;
+		goto out;
+	}
+
+	desc->callback = ti_csi2rx_drain_callback;
+	desc->callback_param = &drain_complete;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret)
+		goto out;
+
+	dma_async_issue_pending(csi->dma.chan);
+
+	if (!wait_for_completion_timeout(&drain_complete,
+					 msecs_to_jiffies(DRAIN_TIMEOUT_MS))) {
+		dmaengine_terminate_sync(csi->dma.chan);
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+out:
+	dma_free_coherent(dev, len, buf, addr);
+	return ret;
+}
+
  static void ti_csi2rx_dma_callback(void *param)
  {
  	struct ti_csi2rx_buffer *buf = param;
@@ -564,24 +619,61 @@ static int ti_csi2rx_start_dma(struct 
ti_csi2rx_dev *csi,
  }

  static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
-				      enum vb2_buffer_state state)
+				      enum vb2_buffer_state buf_state)
  {
  	struct ti_csi2rx_dma *dma = &csi->dma;
-	struct ti_csi2rx_buffer *buf = NULL, *tmp;
+	struct ti_csi2rx_buffer *buf = NULL, *tmp, *curr;;
+	enum ti_csi2rx_dma_state state;
  	unsigned long flags;
+	int ret;

  	spin_lock_irqsave(&dma->lock, flags);
  	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
  		list_del(&buf->list);
-		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		vb2_buffer_done(&buf->vb.vb2_buf, buf_state);
  	}

-	if (dma->curr)
-		vb2_buffer_done(&dma->curr->vb.vb2_buf, state);
-
+	curr = csi->dma.curr;
+	state = csi->dma.state;
  	dma->curr = NULL;
  	dma->state = TI_CSI2RX_DMA_STOPPED;
  	spin_unlock_irqrestore(&dma->lock, flags);
+
+	if (state != TI_CSI2RX_DMA_STOPPED) {
+		ret = ti_csi2rx_drain_dma(csi);
+		if (ret)
+			dev_dbg(csi->dev,
+				"Failed to drain DMA. Next frame might be bogus\n");
+		dmaengine_terminate_sync(csi->dma.chan);
+	}
+
+	if (curr)
+		vb2_buffer_done(&curr->vb.vb2_buf, buf_state);
+}
+
+static int ti_csi2rx_restart_dma(struct ti_csi2rx_dev *csi,
+				 struct ti_csi2rx_buffer *buf)
+{
+	struct ti_csi2rx_dma *dma = &csi->dma;
+	unsigned long flags = 0;
+	int ret = 0;
+
+	ret = ti_csi2rx_drain_dma(csi);
+	if (ret)
+		dev_warn(csi->dev,
+			 "Failed to drain DMA. Next frame might be bogus\n");
+
+	ret = ti_csi2rx_start_dma(csi, buf);
+	if (ret) {
+		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
+		spin_lock_irqsave(&dma->lock, flags);
+		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		dma->curr = NULL;
+		dma->state = TI_CSI2RX_DMA_IDLE;
+		spin_unlock_irqrestore(&dma->lock, flags);
+	}
+
+	return ret;
  }

  static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int 
*nbuffers,
@@ -622,6 +714,7 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer 
*vb)
  	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
  	struct ti_csi2rx_buffer *buf;
  	struct ti_csi2rx_dma *dma = &csi->dma;
+	bool restart_dma = false;
  	unsigned long flags = 0;
  	int ret;

@@ -634,21 +727,30 @@ static void ti_csi2rx_buffer_queue(struct 
vb2_buffer *vb)
  	 * But if DMA has stalled due to lack of buffers, restart it now.
  	 */
  	if (dma->state == TI_CSI2RX_DMA_IDLE) {
-		ret = ti_csi2rx_start_dma(csi, buf);
-		if (ret) {
-			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
-			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
-			goto unlock;
-		}
-
+		/*
+		 * Do not restart DMA with the lock held because
+		 * ti_csi2rx_drain_dma() might block when allocating a buffer.
+		 * There won't be a race on queueing DMA anyway since the
+		 * callback is not being fired.
+		 */
+		restart_dma = true;
  		dma->curr = buf;
  		dma->state = TI_CSI2RX_DMA_ACTIVE;
  	} else {
  		list_add_tail(&buf->list, &dma->queue);
  	}
-
-unlock:
  	spin_unlock_irqrestore(&dma->lock, flags);
+
+	if (restart_dma) {
+		/*
+		 * Once frames start dropping, some data gets stuck in the DMA
+		 * pipeline somewhere. So the first DMA transfer after frame
+		 * drops gives a partial frame. This is obviously not useful to
+		 * the application and will only confuse it. Issue a DMA
+		 * transaction to drain that up.
+		 */
+		ti_csi2rx_restart_dma(csi, buf);
+	}
  }

  static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned 
int count)
@@ -718,12 +820,6 @@ static void ti_csi2rx_stop_streaming(struct 
vb2_queue *vq)

  	writel(0, csi->shim + SHIM_CNTL);

-	ret = dmaengine_terminate_sync(csi->dma.chan);
-	if (ret)
-		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
-
-	writel(0, csi->shim + SHIM_DMACNTX);
-
  	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_ERROR);
  }

-- 
2.41.0


[1] TI BSP kernel : 
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c?h=ti-linux-6.1.y-cicd

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
