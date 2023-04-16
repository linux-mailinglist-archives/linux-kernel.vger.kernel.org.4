Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5AD6E35A0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjDPHUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjDPHUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:20:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E8448A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso5880065e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629615; x=1684221615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6KW2PuE6P/kp4akhCiH7Sdg4oCedA/I/EoMEq7tlfU=;
        b=CZn/S7FnVfpzAK2O+MIC993MubTweoYi2b0kLcTR3DfnbjRf6cQ4pzcSSmkDpfSzm9
         R8VObwR6/8AG3HzELGMGv8dDvLzys99MxhaOU4bAfCKZm+toknizX+Tl2sfK2N3p/9yJ
         3G2O7PvMV6OfSOIWZ1ZRXVUlrp18DKWiCflvdDKrQXC/h5UOx2eEbNSXHh0xx05p8es0
         xu5ahE5zI/MlpLX/gHB5+4rr1CGB8Ns7uJQMADOYE02YOwp5bF+XvQMyKL+gaXQW+RSg
         MxrvIU/3puKczz5nrPJcfN1HxSNuYyhAj01Ko8tHcqgO+huRw5MfTQcmcZrIn4BTDVsY
         qFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629615; x=1684221615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6KW2PuE6P/kp4akhCiH7Sdg4oCedA/I/EoMEq7tlfU=;
        b=JSUKvngj4yh/bQD+X3ot/g+jS/Xmck8YCfqEzqei1TXLd1MeXFlfvZ6znfu6vUfI4U
         MfDzLjemn0fM0eNlmGI4fBbnifQ1Dwc3wNOH7RuVZ3Qe6uX4m1GenQGCag0w1Opj1tlN
         YEueQv/cyTwMIfUS3RYriJREZq9bg41vQZkxsIT/0iCuiK1VfQFMdi4g6X87oTKKhi4c
         EgGF/KauONx6CiWBA/kNBlqD6ZJvJmAW/jriwOGpNAeYJiTEPvGIpU6NIfS4EcMbFc48
         AMHrbPff0k6j1Ffzxic/BvejVPRH30m3IpDHjt2URlwjp8xB4HkYDQ9SounqWun8CLG8
         C7gg==
X-Gm-Message-State: AAQBX9chHwyzMwk9S2tG7EPA9oG9gzCVjiyWUxLrbV4n+Dh0FaD7Q7gM
        AIQJmiI4Oy9qmM74yKGKKYs=
X-Google-Smtp-Source: AKy350bGjtWeR3gK8kXbPzhir2vkzZs20IZA8ABoWWJWn7J+vjLNB6cMWP/Dn13R6eMaDYboT9i/wQ==
X-Received: by 2002:a05:600c:3ca0:b0:3f0:a845:f215 with SMTP id bg32-20020a05600c3ca000b003f0a845f215mr5380689wmb.3.1681629614746;
        Sun, 16 Apr 2023 00:20:14 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003eb596cbc54sm8547121wmi.0.2023.04.16.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:20:14 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:20:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8192e: Remove unchanged variable chan_forced
Message-ID: <3f218531a9d31c399d1351d3da7f9ca13d20df0c.1681627603.git.philipp.g.hortmann@gmail.com>
References: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unchanged variable chan_forced and equations that have always the
same result to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a0c6d117211a..88ff54173a1f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -249,9 +249,6 @@ static void _rtl92e_set_chan(struct net_device *dev, short ch)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->chan_forced)
-		return;
-
 	priv->chan = ch;
 
 	if (priv->rf_set_chan)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 51240cbde0d3..0eca73e4540f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -392,8 +392,6 @@ struct r8192_priv {
 	bool		reset_in_progress;
 	bool		force_reset;
 	bool		force_lps;
-
-	bool		chan_forced;
 };
 
 extern const struct ethtool_ops rtl819x_ethtool_ops;
-- 
2.40.0

