Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A716B38D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCJIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCJIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A962DB3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so17339096eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msAKBo8aTzc9Ggd6g1HwoQudAOedzcnckHsa9qcUuhU=;
        b=PzmwXRfMGrJIqx4xxVlb9XULjKpymRYv/u7KKo5I3aB4ihccXSnVkurxp8VjDYqVnC
         JfKZgG+LjfQY86kxUQyadFXLr3qUrkX9/DwITbpftNDZyfrGt5UKQ4cSP5CVdAvP8/8U
         cyRB2N8XU6M3CBY/HLOxaeSA/bSDQ1ix+BHV1SXvvSGAs0K0X6/3cP8HTwwnv6dqr28n
         fcygIkgSKCU9Xthq6eON9P3rgwVWtddSpzJ7/gVd7RMPESnjaEUEJB7zbJFwPff7MuzC
         G9ky1RkvmKhgyrJM63ww/3nMqJJ2j5jIyKe9+UNCjqg/oGeKteOrSFWvD0l1YE5czzDd
         t1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msAKBo8aTzc9Ggd6g1HwoQudAOedzcnckHsa9qcUuhU=;
        b=y21iEt8rLSkBAKSvo19YMnHDTg6CDIuy6HpLyxpAEY0z+alwo6+ZiEhjRYMb3KCE8k
         ddbDpYS2/Lsv10NpWHkGbMgtHivbPOxv+/IqgyUiCZ80Cu+/vILFWXLywat/Y/Eu8db/
         Rp0TzzBDZ8TmcQ5BRDzVU5wbMNmK0PZIoFuoAIBXq+YjL2tmCeOIz20OehegvSOblxLf
         XFfCghNjpBtQ88hZDRtQMZT7A5Tf/qf8Rm/0KLIkLDzeZG5ScqP8z5GlT28SldhMUu9u
         TgYH4bTWCkMOxxZeJwwF3ePySjAfuH6x4HuX3KM+81ySFW3wUIQZK9594ihRmsHjHcf7
         zw7Q==
X-Gm-Message-State: AO0yUKVkZCQ0xSgBz+WVPnQT13f9Ah3ISSlPGDET1M/Pji8b5ZgHXEKk
        cFotNkGr9ISU6dbkhV9BBivW1L9O518=
X-Google-Smtp-Source: AK7set8PRabUyEPOVX0EH2+KGtKBA2MWD26erh7YDXt7xGRcF62/POeOCoHiLP/ZLnf4MU+I4ApfcQ==
X-Received: by 2002:a17:907:8746:b0:8b1:7fe9:162e with SMTP id qo6-20020a170907874600b008b17fe9162emr27434749ejc.47.1678437309325;
        Fri, 10 Mar 2023 00:35:09 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b008ce5b426d77sm697888ejd.13.2023.03.10.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:35:09 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8723bs: rtw_get_raw_rssi_info() is not used
Date:   Fri, 10 Mar 2023 09:34:49 +0100
Message-Id: <20230310083449.23775-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310083449.23775-1-straube.linux@gmail.com>
References: <20230310083449.23775-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_get_raw_rssi_info() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 32 ---------------------
 drivers/staging/rtl8723bs/include/hal_com.h |  1 -
 2 files changed, 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 792636fe3270..852232102433 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -898,38 +898,6 @@ void rtw_hal_check_rxfifo_full(struct adapter *adapter)
 }
 
 #ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter)
-{
-	u8 isCCKrate, rf_path;
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
-
-	netdev_dbg(padapter->pnetdev,
-		   "RxRate = %s, PWDBALL = %d(%%), rx_pwr_all = %d(dBm)\n",
-		   HDATA_RATE(psample_pkt_rssi->data_rate),
-		   psample_pkt_rssi->pwdball, psample_pkt_rssi->pwr_all);
-
-	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
-
-	if (isCCKrate)
-		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
-
-	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		netdev_dbg(padapter->pnetdev,
-			   "RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)\n",
-			   rf_path,
-			   psample_pkt_rssi->mimo_signal_strength[rf_path],
-			   psample_pkt_rssi->mimo_signal_quality[rf_path]);
-
-		if (!isCCKrate) {
-			netdev_dbg(padapter->pnetdev,
-				   "\trx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
-				   psample_pkt_rssi->ofdm_pwr[rf_path],
-				   psample_pkt_rssi->ofdm_snr[rf_path]);
-		}
-	}
-}
-
 void rtw_dump_raw_rssi_info(struct adapter *padapter)
 {
 	u8 isCCKrate, rf_path;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index c1aa7f0a35f9..17d5cfb66a36 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -150,7 +150,6 @@ bool eqNByte(u8 *str1, u8 *str2, u32 num);
 bool GetU1ByteIntegerFromStringInDecimal(char *str, u8 *in);
 
 #ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter);
 void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe);
 void rtw_dump_raw_rssi_info(struct adapter *padapter);
 #endif
-- 
2.39.2

