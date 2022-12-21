Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67338652FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLUKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLUKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:45:49 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B02736;
        Wed, 21 Dec 2022 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xsapQokhKn3g01DS/Y1LIgKzuSsQ+5ZMsJck6mWKddQ=; b=h87ETB5hlJd0/1Riw1TT6BCxuE
        XkzUMOEu+8h+bFtm0a24kV7+MWp0RdHvE0vV+WrbbIUDr0ncdKNRUJPPwLH815XCivhmWrNHTPPyw
        zLtq32W51tYVA2nTL4UTR+Fbw7MRGO046pKaHmCFx3TZd+IRztU7NonQOVSJ+OnFrrgs=;
Received: from p200300daa720fc02bd853fbc229daa4a.dip0.t-ipconnect.de ([2003:da:a720:fc02:bd85:3fbc:229d:aa4a] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p7wbT-00AZ5f-4S; Wed, 21 Dec 2022 11:45:39 +0100
Message-ID: <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
Date:   Wed, 21 Dec 2022 11:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.22 02:10, Mikhail Gavrilov wrote:
> Hi,
> The kernel 6.2 preparation cycle has begun.
> And after the kernel was updated on my laptop, the wifi stopped working.
> 
> Bisecting blames this commit:
> cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae is the first bad commit
> commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Sat Nov 12 16:40:35 2022 +0100
> 
>      wifi: mt76: add WED RX support to mt76_dma_{add,get}_buf
> 
>      Introduce the capability to configure RX WED in mt76_dma_{add,get}_buf
>      utility routines.
> 
>      Tested-by: Daniel Golle <daniel@makrotopia.org>
>      Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
>      Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
>      Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>      Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
>   drivers/net/wireless/mediatek/mt76/dma.c  | 125 ++++++++++++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt76.h |   2 +
>   2 files changed, 88 insertions(+), 39 deletions(-)
> 
> Unfortunately, I can't be sure that revert this commit will fix the
> problem. Because after the revert, compile of kernel failing with
> follow error:
> drivers/net/wireless/mediatek/mt76/mt7915/dma.c: In function ‘mt7915_dma_init’:
> drivers/net/wireless/mediatek/mt76/mt7915/dma.c:489:33: error:
> implicit declaration of function ‘MT_WED_Q_RX’; did you mean
> ‘MT_WED_Q_TX’? [-Werror=implicit-function-declaration]
>    489 |                                 MT_WED_Q_RX(MT7915_RXQ_BAND0);
>        |                                 ^~~~~~~~~~~
>        |                                 MT_WED_Q_TX
> cc1: some warnings being treated as errors
>    CC [M]  drivers/net/ethernet/intel/igb/e1000_phy.o
> make[7]: *** [scripts/Makefile.build:252:
> drivers/net/wireless/mediatek/mt76/mt7915/dma.o] Error 1
> make[7]: *** Waiting for unfinished jobs....
I'm pretty sure that commit is unrelated to this issue. However, while
looking at the code I found a bug that would explain your issue.

Please try this patch:
---
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -422,15 +422,15 @@ void mt7921_roc_timer(struct timer_list *timer)
  
  static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif)
  {
-	int err;
-
-	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		return 0;
+	int err = 0;
  
  	del_timer_sync(&phy->roc_timer);
  	cancel_work_sync(&phy->roc_work);
-	err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
-	clear_bit(MT76_STATE_ROC, &phy->mt76->state);
+
+	mt7921_mutex_acquire(phy->dev);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
+	mt7921_mutex_release(phy->dev);
  
  	return err;
  }
@@ -487,13 +487,8 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
  {
  	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
  	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	int err;
  
-	mt7921_mutex_acquire(phy->dev);
-	err = mt7921_abort_roc(phy, mvif);
-	mt7921_mutex_release(phy->dev);
-
-	return err;
+	return mt7921_abort_roc(phy, mvif);
  }
  
  static int mt7921_set_channel(struct mt7921_phy *phy)
@@ -1778,11 +1773,8 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
  				   struct ieee80211_prep_tx_info *info)
  {
  	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
  
-	mt7921_mutex_acquire(dev);
  	mt7921_abort_roc(mvif->phy, mvif);
-	mt7921_mutex_release(dev);
  }
  
  const struct ieee80211_ops mt7921_ops = {

