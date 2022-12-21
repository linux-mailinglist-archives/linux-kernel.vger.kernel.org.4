Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B0653245
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLUOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:12:53 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F57262F;
        Wed, 21 Dec 2022 06:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PeCUpd8Uy+6+evhJTTV+5Lf937g78nRc8Y3A+g1BOHc=; b=QIz7u8/Uc+4J4IY5RLMLK9m0ie
        ChvmCZtN1OyB6Twrupz/fiO4sq/mH5SIVn2PZH8BzXkyBNQlRyfhzQwDrfg7c9ZaKY+20Xvql65zz
        z5BhB4uXLZlvSOAeWjCz7WmqE81XhrY4FE79Ar5cdQYfnUjY1VmfYCLM33vhLYOOh8f4=;
Received: from p200300daa720fc02bd853fbc229daa4a.dip0.t-ipconnect.de ([2003:da:a720:fc02:bd85:3fbc:229d:aa4a] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p7zps-00AbUk-Jy; Wed, 21 Dec 2022 15:12:44 +0100
Message-ID: <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
Date:   Wed, 21 Dec 2022 15:12:44 +0100
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
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
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

On 21.12.22 14:10, Mikhail Gavrilov wrote:
> On Wed, Dec 21, 2022 at 3:45 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> I'm pretty sure that commit is unrelated to this issue. However, while
>> looking at the code I found a bug that would explain your issue.
>>
>> Please try this patch:
>> ---
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> @@ -422,15 +422,15 @@ void mt7921_roc_timer(struct timer_list *timer)
>>
>>   static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
>>   {
>> -       int err;
>> -
>> -       if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
>> -               return 0;
>> +       int err = 0;
>>
>>         del_timer_sync(&phy->roc_timer);
>>         cancel_work_sync(&phy->roc_work);
>> -       err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
>> -       clear_bit(MT76_STATE_ROC, &phy->mt76->state);
>> +
>> +       mt7921_mutex_acquire(phy->dev);
>> +       if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
>> +               err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
>> +       mt7921_mutex_release(phy->dev);
>>
>>         return err;
>>   }
>> @@ -487,13 +487,8 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
>>   {
>>         struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
>>         struct mt7921_phy *phy = mt7921_hw_phy(hw);
>> -       int err;
>>
>> -       mt7921_mutex_acquire(phy->dev);
>> -       err = mt7921_abort_roc(phy, mvif);
>> -       mt7921_mutex_release(phy->dev);
>> -
>> -       return err;
>> +       return mt7921_abort_roc(phy, mvif);
>>   }
>>
>>   static int mt7921_set_channel(struct mt7921_phy *phy)
>> @@ -1778,11 +1773,8 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
>>                                    struct ieee80211_prep_tx_info *info)
>>   {
>>         struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
>> -       struct mt7921_dev *dev = mt7921_hw_dev(hw);
>>
>> -       mt7921_mutex_acquire(dev);
>>         mt7921_abort_roc(mvif->phy, mvif);
>> -       mt7921_mutex_release(dev);
>>   }
>>
>>   const struct ieee80211_ops mt7921_ops = {
>>
> 
> Unfortunately this patch did not fix the issue.
> There are still many messages in the logs "mt7921e 0000:05:00.0:
> AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0xffdc6a80
> flags=0x0050]"
Thanks! I guess I focused on the wrong part of your kernel log
initially. After more code review, I found that there is in fact a DMA
related bug in the commit that your bisection pointed to, which happened
to uncover and trigger the deadlock fixed by my other patch.

So here's my fix for the DMA issue:
---
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
@@ -215,6 +261,11 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
  	int i, idx = -1;
  	u32 ctrl, next;
  
+	if (txwi) {
+		q->entry[q->head].txwi = DMA_DUMMY_DATA;
+		q->entry[q->head].skip_buf0 = true;
+	}
+
  	for (i = 0; i < nbufs; i += 2, buf += 2) {
  		u32 buf0 = buf[0].addr, buf1 = 0;
  
@@ -224,51 +275,28 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
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
-			if (rx_token < 0)
-				return -ENOMEM;
-
-			buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
-			ctrl = FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
-			       MT_DMA_CTL_TO_HOST;
-		} else {
-			if (txwi) {
-				q->entry[next].txwi = DMA_DUMMY_DATA;
-				q->entry[next].skip_buf0 = true;
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
@@ -567,17 +595,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
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
  		buf = page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
  		if (!buf)
  			break;
@@ -591,7 +611,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
  		qbuf.addr = addr + offset;
  		qbuf.len = len - offset;
  		qbuf.skip_unmap = false;
-		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
+		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
  			dma_unmap_single(dev->dma_dev, addr, len,
  					 DMA_FROM_DEVICE);
  			skb_free_frag(buf);

