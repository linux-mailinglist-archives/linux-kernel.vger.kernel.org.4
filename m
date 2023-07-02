Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89110744D90
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGBMQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGBMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:16:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99DE48
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 05:16:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b80f2e6c17so28670775ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300176; x=1690892176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LI5xtyL2k2cBitbepn6US1F6e5Ej9j9z5n1WZ2zQtfs=;
        b=cAi0AivaoyBUmInw7KpCb/jsQAYZS+Rq+v2vjn8Jtq2wlacDU2vUHAwaSlPNyzDod4
         UTJWJy7s0Xa3OhUh5xMPWzhh27yf4/vp2lzAe6JJz5Q8+POegERnqiY1hd5jXN8UwV1i
         pUwapcc6ttM7NjnGdnIzxJQzZlKH13KBiK1+nh4/YEZ37jtPS8baOjBViZJ0Jud3bQ3V
         HZdMrSYkfhePqAAurgUQTa9HtJHBhULxOUSQnS/xfPh6Hdwg1xuCo+N1ao7XCq5Ucncm
         LcZR7JRR5cFbQY1XTqHX5UhosyhAMeFEWBTd2YF6fWZY40ZEjQyXR5SThR44aFi1QaQx
         0C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300176; x=1690892176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI5xtyL2k2cBitbepn6US1F6e5Ej9j9z5n1WZ2zQtfs=;
        b=OnTgKMNBSpjHB4Yn8qpBfQLhB9DnrL2lurhOzT76msAvl5gfuHyPtzK41W9jA4iyqZ
         8pMpUnjFfwfLoMQ4283Kd4PdHhUbZ4CRfhcuFwNjbpkvJkaRAoTslqozwQxttxv5tiQQ
         8Ac6J/MHLS0Fxgra8FTinssftdfD3o8BDlB73VNXfkuM0iT2/tgMmui0LbW3SgCFOqOv
         2GIKAro5Je//tEH2/CF33Pmfs5e2DVgkofmMgXmcwEsEyEOiR1ANM0Kn2LugXf2XG32Z
         69slCRfBRGXrhnFtHlNqus6drVorFtdvJIPDrUz7/q5sse+dmTuEHQJpNxh2qhyJYZXO
         fLpg==
X-Gm-Message-State: ABy/qLaa2eWcO7RnEDYk5e2P3S7pgYa+vw0FA3yKDol5D0nVuUDNVZeg
        irjclBmM/L55bCLkJLTmhO0=
X-Google-Smtp-Source: APBJJlHF4Wdd3nuQiVZBSb9dYApRmcLqlVqkm3nVD3k3QUQGvK3mgSNWcWdCX2B2hqCBuE/YtMC0RQ==
X-Received: by 2002:a17:902:e9d1:b0:1b5:361:cefe with SMTP id 17-20020a170902e9d100b001b50361cefemr7811279plk.52.1688300175778;
        Sun, 02 Jul 2023 05:16:15 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709027b8500b001ab2592ed33sm13580074pll.171.2023.07.02.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 05:16:15 -0700 (PDT)
Date:   Sun, 2 Jul 2023 17:46:10 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH 3/4] staging: rtl8192e: Rename variable LowRSSIThreshForRA
Message-ID: <ebea3e75dc84a6d77750c0598ab12d04ad55c676.1688299890.git.yogi.kernel@gmail.com>
References: <cover.1688299890.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688299890.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable LowRSSIThreshForRA to low_rssi_thresh_for_ra to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index a535a63ce9f7..d266d2d047ca 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -278,7 +278,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 	u32 current_ratr, target_ratr = 0;
-	u32 LowRSSIThreshForRA = 0, HighRSSIThreshForRA = 0;
+	u32 low_rssi_thresh_for_ra = 0, HighRSSIThreshForRA = 0;
 	bool bshort_gi_enabled = false;
 	static u8 ping_rssi_state;
 
@@ -320,15 +320,15 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 
 		if (pra->ratr_state == DM_RATR_STA_HIGH) {
 			HighRSSIThreshForRA = pra->high2low_rssi_thresh_for_ra;
-			LowRSSIThreshForRA = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
+			low_rssi_thresh_for_ra = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low_rssi_thresh_for_ra40M) : (pra->low_rssi_thresh_for_ra20M);
 		} else if (pra->ratr_state == DM_RATR_STA_LOW) {
 			HighRSSIThreshForRA = pra->high_rssi_thresh_for_ra;
-			LowRSSIThreshForRA = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
+			low_rssi_thresh_for_ra = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low2high_rssi_thresh_for_ra40M) : (pra->low2high_rssi_thresh_for_ra20M);
 		} else {
 			HighRSSIThreshForRA = pra->high_rssi_thresh_for_ra;
-			LowRSSIThreshForRA = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
+			low_rssi_thresh_for_ra = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low_rssi_thresh_for_ra40M) : (pra->low_rssi_thresh_for_ra20M);
 		}
 
@@ -337,7 +337,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 			pra->ratr_state = DM_RATR_STA_HIGH;
 			target_ratr = pra->upper_rssi_threshold_ratr;
 		} else if (priv->undecorated_smoothed_pwdb >=
-			   (long)LowRSSIThreshForRA) {
+			   (long)low_rssi_thresh_for_ra) {
 			pra->ratr_state = DM_RATR_STA_MIDDLE;
 			target_ratr = pra->middle_rssi_threshold_ratr;
 		} else {
-- 
2.34.1

