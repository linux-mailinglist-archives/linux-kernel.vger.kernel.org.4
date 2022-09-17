Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5F5BB647
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIQE03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIQE0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:26:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D64156B92
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:26:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y17so48456260ejo.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=48TrLh74HqKrzik8Fk6DUHkcVjt+dZhNAckkfUJzuE0=;
        b=nUG9lZNtYC0PSixanDyWQ01k0z7hFlVsMAq1nmESd0yXJUYonLPqfiwfr3RBLnddgp
         JKF+xomEA8Ni58wanXtGYMqBjruQeLpqQsRfqB8XIH4nF/d2ASIx4KOv7RziHH47E61K
         WquRHNnAxSoJCqbRAt36lS661wpczPCJredbxPnhJnvUQxgErIJW5bsh870/067DghUa
         RHZsgk2rHIYNGXuhfZba1CzyeXpC5BMGFvZ0aOL/M6hbVuDuuAUcQPoqLpC5lHsXYuEQ
         7VEMVG+/rrDS3ZvYWRhNIcIA6HVsw6RVtwea+PrgMY+BY/LkMIY8SU/du/oME2pVweM/
         SlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=48TrLh74HqKrzik8Fk6DUHkcVjt+dZhNAckkfUJzuE0=;
        b=lZ3NFFD7IZjFzlDn6xjOctAxlSRjTcs6/exznNuzWlbrvOaQTExjgMoGdEqmki4FT1
         xPtOColQkzhEizvQjpJj/swCZmJzLrBg9NZQN3V3YcIGJxqAvRPJsugulQxCHKv7vHbs
         myqVIkNffgrP33kGtdusEpqNF/kOs3o2Mg2vSBf+be216xBW/cF+lu8bpCBL0LXpajU/
         cF2ls3I0LoYZAoVbJEk9/bRIrNYECGMAOIqNqN64PQaBFeKZRFPqZ1mBqcinGiiPQG2D
         3MKAOrDaXXZT/X8BQZ/3XodUq5qiVX0Sa9f8kWkK4U1+9nQ6Wa/I3w8Acrnm3IPignAN
         OiHA==
X-Gm-Message-State: ACrzQf1fXz8zsJD7jmNw7xeM6gfL8U5J5QVWJlFzW6THncI+DtF4bjwK
        8AGlpjSTdqIfRnMtWnfUXIc=
X-Google-Smtp-Source: AMsMyM7/YuX8xKItHriaHDm0U24H0J8mZmYHBA2MagMxvOVL2b+hd4tuQ/0WnQYLOl7tvrVZCAUpXw==
X-Received: by 2002:a17:907:9718:b0:77b:45b6:b047 with SMTP id jg24-20020a170907971800b0077b45b6b047mr5605543ejc.479.1663388761412;
        Fri, 16 Sep 2022 21:26:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090630ce00b0073d7b876621sm2153632ejb.205.2022.09.16.21.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:26:00 -0700 (PDT)
Date:   Sat, 17 Sep 2022 06:25:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8192e: Remove ftrace-like logging in
 rtl819x_BAProc.c, ...
Message-ID: <2c41e6856cd37b4f3e5cb1108272bcc24032bf64.1663387785.git.philipp.g.hortmann@gmail.com>
References: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663387785.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "Unnecessary ftrace-like logging" as requested by checkpatch.
Remove multiline macro as it is not needed anymore and not liked by
kernel community.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 5 -----
 drivers/staging/rtl8192e/rtllib_debug.h      | 6 ------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 8 --------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 6 ------
 4 files changed, 25 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 7d04966afdd9..4c907fb16253 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -100,8 +100,6 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	*tag++ = pBA->dialog_token;
 
 	if (type == ACT_ADDBARSP) {
-		RT_TRACE(COMP_DBG, "====>to send ADDBARSP\n");
-
 		put_unaligned_le16(StatusCode, tag);
 		tag += 2;
 	}
@@ -183,7 +181,6 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
 	skb = rtllib_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ);
 
 	if (skb) {
-		RT_TRACE(COMP_DBG, "====>to send ADDBAREQ!!!!!\n");
 		softmac_mgmt_xmit(skb, ieee);
 	} else {
 		netdev_dbg(ieee->dev, "Failed to generate ADDBAReq packet.\n");
@@ -247,7 +244,6 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaTimeoutVal = (u16 *)(tag + 5);
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
-	RT_TRACE(COMP_DBG, "====>rx ADDBAREQ from : %pM\n", dst);
 	if (!ieee->current_network.qos_data.active ||
 	    !ieee->pHTInfo->bCurrentHTSupport ||
 	    (ieee->pHTInfo->IOTAction & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
@@ -330,7 +326,6 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaParamSet = (union ba_param_set *)(tag + 5);
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
-	RT_TRACE(COMP_DBG, "====>rx ADDBARSP from : %pM\n", dst);
 	if (!ieee->current_network.qos_data.active ||
 	    !ieee->pHTInfo->bCurrentHTSupport ||
 	    !ieee->pHTInfo->bCurrentAMPDUEnable) {
diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8192e/rtllib_debug.h
index e3e8302945eb..f6b23defe225 100644
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ b/drivers/staging/rtl8192e/rtllib_debug.h
@@ -46,10 +46,4 @@ enum RTL_DEBUG {
 	COMP_ERR		= BIT(31)
 };
 
-#define RT_TRACE(component, x, args...)		\
-do {			\
-	if (rt_global_debug_component & component) \
-		printk(KERN_DEBUG DRV_NAME ":" x "\n", ##args);\
-} while (0)
-
 #endif
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9e6d7c5716ff..e4f5f4ecf4d0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1584,13 +1584,8 @@ static void rtllib_associate_procedure_wq(void *data)
 		ieee->data_hard_stop(ieee->dev);
 
 	rtllib_stop_scan(ieee);
-	RT_TRACE(COMP_DBG, "===>%s(), chan:%d\n", __func__,
-		 ieee->current_network.channel);
 	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	if (ieee->eRFPowerState == eRfOff) {
-		RT_TRACE(COMP_DBG,
-			 "=============>%s():Rf state is eRfOff, schedule ipsleave wq again,return\n",
-			 __func__);
 		if (ieee->rtllib_ips_leave_wq != NULL)
 			ieee->rtllib_ips_leave_wq(ieee->dev);
 		mutex_unlock(&ieee->wx_mutex);
@@ -2062,9 +2057,6 @@ static inline void rtllib_sta_ps(struct work_struct *work)
 	if ((ieee->ps == RTLLIB_PS_DISABLED ||
 	     ieee->iw_mode != IW_MODE_INFRA ||
 	     ieee->state != RTLLIB_LINKED)) {
-		RT_TRACE(COMP_DBG,
-			 "=====>%s(): no need to ps,wake up!! ieee->ps is %d, ieee->iw_mode is %d, ieee->state is %d\n",
-			 __func__, ieee->ps, ieee->iw_mode, ieee->state);
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 		rtllib_sta_wakeup(ieee, 1);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 70a62ca0f69a..f9589c5b62ba 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -364,8 +364,6 @@ void rtllib_wx_sync_scan_wq(void *data)
 		b40M = 1;
 		chan_offset = ieee->pHTInfo->CurSTAExtChnlOffset;
 		bandwidth = (enum ht_channel_width)ieee->pHTInfo->bCurBW40MHz;
-		RT_TRACE(COMP_DBG, "Scan in 40M, force to 20M first:%d, %d\n",
-			 chan_offset, bandwidth);
 		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
@@ -373,7 +371,6 @@ void rtllib_wx_sync_scan_wq(void *data)
 	rtllib_start_scan_syncro(ieee, 0);
 
 	if (b40M) {
-		RT_TRACE(COMP_DBG, "Scan in 20M, back to 40M\n");
 		if (chan_offset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev, chan + 2);
 		else if (chan_offset == HT_EXTCHNL_OFFSET_LOWER)
@@ -571,14 +568,11 @@ int rtllib_wx_set_power(struct rtllib_device *ieee,
 	mutex_lock(&ieee->wx_mutex);
 
 	if (wrqu->power.disabled) {
-		RT_TRACE(COMP_DBG, "===>%s(): power disable\n", __func__);
 		ieee->ps = RTLLIB_PS_DISABLED;
 		goto exit;
 	}
 	if (wrqu->power.flags & IW_POWER_TIMEOUT) {
 		ieee->ps_timeout = wrqu->power.value / 1000;
-		RT_TRACE(COMP_DBG, "===>%s():ps_timeout is %d\n", __func__,
-			 ieee->ps_timeout);
 	}
 
 	if (wrqu->power.flags & IW_POWER_PERIOD)
-- 
2.37.3

