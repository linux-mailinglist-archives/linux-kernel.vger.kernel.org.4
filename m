Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C046534F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiLURSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiLURRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:17:54 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6F64CC;
        Wed, 21 Dec 2022 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5NQmoVw/q+8tvK2V4iRPmDMASULYZoPw14pX4rYwT4A=; b=E4Y1LY7caA9JODGRL9bGLDuFlX
        ViUy7CY6OeLy2kulFlgUTl10dcq9zU5QzOLVVP3z3yOI5IkKdvPfksiET7T3rTJTioWn87fdKm3mt
        +rpgLeWHCYHP99FJtDfIqdrCcotbjX/LeTXqR2p1naZOs7ywIHuQqXvg0wRE1m6r8U7o=;
Received: from p200300daa720fc02a80cecba4b8062d5.dip0.t-ipconnect.de ([2003:da:a720:fc02:a80c:ecba:4b80:62d5] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p82iD-00AdKg-7f; Wed, 21 Dec 2022 18:17:01 +0100
Message-ID: <3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name>
Date:   Wed, 21 Dec 2022 18:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
 <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
 <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
 <CABXGCsNJKy2SQffeU+uaua5SM_77YiGKdPLRdzSF3F+ShpF+5w@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CABXGCsNJKy2SQffeU+uaua5SM_77YiGKdPLRdzSF3F+ShpF+5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.22 17:46, Mikhail Gavrilov wrote:
> On Wed, Dec 21, 2022 at 7:12 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> Thanks! I guess I focused on the wrong part of your kernel log
>> initially. After more code review, I found that there is in fact a DMA
>> related bug in the commit that your bisection pointed to, which happened
>> to uncover and trigger the deadlock fixed by my other patch.
>>
>> So here's my fix for the DMA issue:
>> ---
> [cutted]
>>                 qbuf.skip_unmap = false;
>> -               if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
>> +               if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
>>                         dma_unmap_single(dev->dma_dev, addr, len,
>>                                          DMA_FROM_DEVICE);
>>                         skb_free_frag(buf);
>>
> 
> Sorry for stupid question.
> 
> Do you have a separate branch?
> I see that the code is differ between master branch and the patch.
> 
> For example in patch the line:
> - if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
> replaced by the line:
> + if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
> 
> But in master branch
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/mediatek/mt76/dma.c?id=b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf#n604
> after line:
> qbuf.skip_unmap = false;
> followed the line:
> mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
> without if condition.
> 
> So I'm stuck applying the patch :(
Sorry, I worked on a tree that had other pending fixes applied.
Please try this:


--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -205,6 +205,52 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
  	mt76_dma_sync_idx(dev, q);
  }
  
+static int
+mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
+		    struct mt76_queue_buf *buf, void *data)
+{
+	struct mt76_desc *desc = &q->desc[q->head];
+	struct mt76_queue_entry *entry = &q->entry[q->head];
+	struct mt76_txwi_cache *txwi = NULL;
+	u32 buf1 = 0, ctrl;
+	int idx = q->head;
+	int rx_token;
+
+	ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+
+	if ((q->flags & MT_QFLAG_WED) &&
+	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
+		txwi = mt76_get_rxwi(dev);
+		if (!txwi)
+			return -ENOMEM;
+
+		rx_token = mt76_rx_token_consume(dev, data, txwi, buf->addr);
+		if (rx_token < 0) {
+			mt76_put_rxwi(dev, txwi);
+			return -ENOMEM;
+		}
+
+		buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
+		ctrl |= MT_DMA_CTL_TO_HOST;
+	}
+
+	WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
+	WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
+	WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
+	WRITE_ONCE(desc->info, 0);
+
+	entry->dma_addr[0] = buf->addr;
+	entry->dma_len[0] = buf->len;
+	entry->txwi = txwi;
+	entry->buf = data;
+	entry->wcid = 0xffff;
+	entry->skip_buf1 = true;
+	q->head = (q->head + 1) % q->ndesc;
+	q->queued++;
+
+	return idx;
+}
+
  static int
  mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
  		 struct mt76_queue_buf *buf, int nbufs, u32 info,
@@ -212,65 +258,51 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
  {
  	struct mt76_queue_entry *entry;
  	struct mt76_desc *desc;
-	u32 ctrl;
  	int i, idx = -1;
+	u32 ctrl, next;
+
+	if (txwi) {
+		q->entry[q->head].txwi = DMA_DUMMY_DATA;
+		q->entry[q->head].skip_buf0 = true;
+	}
  
  	for (i = 0; i < nbufs; i += 2, buf += 2) {
  		u32 buf0 = buf[0].addr, buf1 = 0;
  
  		idx = q->head;
-		q->head = (q->head + 1) % q->ndesc;
+		next = (q->head + 1) % q->ndesc;
  
  		desc = &q->desc[idx];
  		entry = &q->entry[idx];
  
-		if ((q->flags & MT_QFLAG_WED) &&
-		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
-			struct mt76_txwi_cache *t = txwi;
-			int rx_token;
-
-			if (!t)
-				return -ENOMEM;
-
-			rx_token = mt76_rx_token_consume(dev, (void *)skb, t,
-							 buf[0].addr);
-			buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
-			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
-			       MT_DMA_CTL_TO_HOST;
-		} else {
-			if (txwi) {
-				q->entry[q->head].txwi = DMA_DUMMY_DATA;
-				q->entry[q->head].skip_buf0 = true;
-			}
-
-			if (buf[0].skip_unmap)
-				entry->skip_buf0 = true;
-			entry->skip_buf1 = i == nbufs - 1;
-
-			entry->dma_addr[0] = buf[0].addr;
-			entry->dma_len[0] = buf[0].len;
-
-			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
-			if (i < nbufs - 1) {
-				entry->dma_addr[1] = buf[1].addr;
-				entry->dma_len[1] = buf[1].len;
-				buf1 = buf[1].addr;
-				ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
-				if (buf[1].skip_unmap)
-					entry->skip_buf1 = true;
-			}
-
-			if (i == nbufs - 1)
-				ctrl |= MT_DMA_CTL_LAST_SEC0;
-			else if (i == nbufs - 2)
-				ctrl |= MT_DMA_CTL_LAST_SEC1;
+		if (buf[0].skip_unmap)
+			entry->skip_buf0 = true;
+		entry->skip_buf1 = i == nbufs - 1;
+
+		entry->dma_addr[0] = buf[0].addr;
+		entry->dma_len[0] = buf[0].len;
+
+		ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
+		if (i < nbufs - 1) {
+			entry->dma_addr[1] = buf[1].addr;
+			entry->dma_len[1] = buf[1].len;
+			buf1 = buf[1].addr;
+			ctrl |= FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
+			if (buf[1].skip_unmap)
+				entry->skip_buf1 = true;
  		}
  
+		if (i == nbufs - 1)
+			ctrl |= MT_DMA_CTL_LAST_SEC0;
+		else if (i == nbufs - 2)
+			ctrl |= MT_DMA_CTL_LAST_SEC1;
+
  		WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
  		WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
  		WRITE_ONCE(desc->info, cpu_to_le32(info));
  		WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
  
+		q->head = next;
  		q->queued++;
  	}
  
@@ -577,17 +609,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
  	spin_lock_bh(&q->lock);
  
  	while (q->queued < q->ndesc - 1) {
-		struct mt76_txwi_cache *t = NULL;
  		struct mt76_queue_buf qbuf;
  		void *buf = NULL;
  
-		if ((q->flags & MT_QFLAG_WED) &&
-		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_Q_RX) {
-			t = mt76_get_rxwi(dev);
-			if (!t)
-				break;
-		}
-
  		buf = page_frag_alloc(rx_page, q->buf_size, GFP_ATOMIC);
  		if (!buf)
  			break;
@@ -601,7 +625,12 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
  		qbuf.addr = addr + offset;
  		qbuf.len = len - offset;
  		qbuf.skip_unmap = false;
-		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
+		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
+			dma_unmap_single(dev->dma_dev, addr, len,
+					 DMA_FROM_DEVICE);
+			skb_free_frag(buf);
+			break;
+		}
  		frames++;
  	}
  

--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -653,6 +653,13 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
  
  		desc->buf0 = cpu_to_le32(phy_addr);
  		token = mt76_rx_token_consume(&dev->mt76, ptr, t, phy_addr);
+		if (token < 0) {
+			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
+					 wed->wlan.rx_size, DMA_TO_DEVICE);
+			skb_free_frag(ptr);
+			goto unmap;
+		}
+
  		desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
  						      token));
  		desc++;

--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -764,11 +764,12 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
  	spin_lock_bh(&dev->rx_token_lock);
  	token = idr_alloc(&dev->rx_token, t, 0, dev->rx_token_size,
  			  GFP_ATOMIC);
+	if (token >= 0) {
+		t->ptr = ptr;
+		t->dma_addr = phys;
+	}
  	spin_unlock_bh(&dev->rx_token_lock);
  
-	t->ptr = ptr;
-	t->dma_addr = phys;
-
  	return token;
  }
  EXPORT_SYMBOL_GPL(mt76_rx_token_consume);

