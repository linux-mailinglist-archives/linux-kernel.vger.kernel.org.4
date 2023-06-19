Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B2735D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjFSSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:03:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD9712A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:03:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso529702066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687197836; x=1689789836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3jx2b9Mk6wTwyAJZvyHLpveP2xgctvjKCyGVRIC4vU=;
        b=sB25lAs9M9T5ef+SSdN+RFXG3CFcWIZZFsFJzWjnOhiNWn185mvbqvNfaY2O/P1hd8
         lDlqHEwGOga+ykrUJD7BeLs46uudS3TXlaJ5fKVgWN7IstFmQlY8ggFEPoAEbkzApcEP
         UkHlegN2faNzCaN76HOVFIh1JtMiuSO/q1P4v1+jg/uRUUfZ/Sy7mvA4AMR788gPyLOG
         P4Rwk5YOtl9y6TRU0Ib9G498Hqkm91nbY3hUIPpIN/T4RxNoRn0ah3ZZw1snX3BRYo05
         lKWZpdcQbJtgvGnbBrupwWNQJmiCRX96y6RnqwjQ73khWrYnwG6+kzKHmYjl2aR9dwuX
         RhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687197836; x=1689789836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3jx2b9Mk6wTwyAJZvyHLpveP2xgctvjKCyGVRIC4vU=;
        b=Q+Ql+N1JpVxSBuni+IeVJ9LqvTRvg9RRNv2MrCOAKqyYE0+MLhoFM8yHcZQLD1araf
         zXbstQTqfT77efmoEzQH7smfa70FsACoJ/I1GJekxo4c4UTe4kYcfHsIzgvWZ3f8THzG
         iCrN8zmKr/gU9tF/jYv/UvUcnujbfz76iDM9Qaa435ML0bSOgX1yJ1EMsbUaC4ChBYeu
         FPN4Bc67ybTtQqXtLDJ5f9jSLTE6/K860bDch0YGGQxoB2G5XjB5ZZYvPULFR5Zl49Lu
         Ew8/5JLBGvuahJkrdepdEWLxIztDMR3LO0Bu583IMCGbhvBziP5x24NBe57MLnH8yTk8
         Hz4w==
X-Gm-Message-State: AC+VfDxE2+uMqQX94PgiWKpaj0cw0JfvUNP4QtvGk2wfzvxBnaiIrEqb
        tKL3rZZqZ3ux3Q6Zc4IusJE=
X-Google-Smtp-Source: ACHHUZ4kDUuvTG8QrUb8lvlWMeevD5EvadoImRGj69UFl7+uh2sxzqE9PJ4vU4H9MA37Nm9RTrlAfw==
X-Received: by 2002:a17:907:2da6:b0:988:f93:32e8 with SMTP id gt38-20020a1709072da600b009880f9332e8mr6314843ejc.26.1687197835771;
        Mon, 19 Jun 2023 11:03:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dcda:2154:7873:34])
        by smtp.gmail.com with ESMTPSA id kk10-20020a170907766a00b00988a6421831sm20913ejc.93.2023.06.19.11.03.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jun 2023 11:03:55 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH 1/5] staging: rtl8723bs: Fix indentation issues
Date:   Mon, 19 Jun 2023 20:03:51 +0200
Message-Id: <20230619180351.18925-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230619175703.18826-1-franziska.naepelt@gmail.com>
References: <20230619175703.18826-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch indentation issues:
- WARNING: suspect code indent for conditional statements (32, 48)
- WARNING: suspect code indent for conditional statements (24, 24)
- ERROR: code indent should use tabs where possible

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 84a9f4dd8f95..1afd1a93bcee 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -581,7 +581,7 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
@@ -1305,7 +1305,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-			memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -2810,7 +2810,7 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	wdev->netdev = pnetdev;
 
 	wdev->iftype = NL80211_IFTYPE_STATION; /*  will be init in rtw_hal_init() */
-	                                       /*  Must sync with _rtw_init_mlme_priv() */
+					   /*  Must sync with _rtw_init_mlme_priv() */
 					   /*  pmlmepriv->fw_state = WIFI_STATION_STATE */
 	padapter->rtw_wdev = wdev;
 	pnetdev->ieee80211_ptr = wdev;
-- 
2.39.2 (Apple Git-143)

