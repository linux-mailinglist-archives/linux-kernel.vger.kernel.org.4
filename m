Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582236C8CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjCYIiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjCYIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A819103
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:37:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-93075ee221bso14108066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xenSdzUtugeb0/CqvxP79YZC3E7VL9ki06QF+SB8Qys=;
        b=Ius8gLpxU5pD8x0/GazMtCB5q0CKLg0MZ7i75GOUkkNagH+fBhqR+TACAHnRUmsK/F
         iNVLNgyNtTt+1j7Izciy9FaeFRQ9rIPBXWkBRxrE6Tj+7d0kEfJwCf3thyDY1Jwn3kAq
         Lg1uy4yU5PGZPUjARM49UkUOPaxWNH6ZI73wln1orZXvbsIoQ7rMQro9LilLy58wzhcZ
         0s5/3Eyd0rGRUADt5ijACRAv8pvDJgmfspSJDmB4wc8g/w7CPuVpx2PVJ+1PS7bOa3wW
         E66OL4vDKGDTr69qnYcFZjXBpgMXQa4lwL05+/SmkCF4UqkfLwObjjWJe7qQUxrotp02
         AOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xenSdzUtugeb0/CqvxP79YZC3E7VL9ki06QF+SB8Qys=;
        b=KtRYSQEBC6ahceBo+Xtm05iF6hMrbjWt5KSZuanJGR8u2QT0Zha7QVa9JXIJuNGbhw
         3U1McyXWMTHBYu/jM99B7759bac9zMMKFTxCQB/6iqO7tInlQhTvbeK63zBdVupqk7Wo
         UGSqFkx0F1Dth3k3lBXkEvXXelUiehEO5iTrp9EU5d6SSzySNRSJlTg+YyrW1TNI5HNI
         MoHAow735D9qj+etQDHl4g8hNoOeobeT8NyX1K02ZbjymwKqqjQ+Pgyrt+3z8ozAp4U8
         c7x76UNETVkJxiUeO6e5DXo6PvKdsvW9THF/MrQ9JiUOIuTAlK3e3hVJri4E7KdT31oa
         j7wg==
X-Gm-Message-State: AAQBX9dcqoKCimsn/PwWRrKAK0EpDxdlV8bL9asRxp/bGxdJ606AlZ1p
        ADZgmCAm/MO4Ln1+DJUv52Q=
X-Google-Smtp-Source: AKy350ZNYezsWUfDKJfhwp03UyPDeI0FJ4MnyrevIjAc9ybsNWwRCArAjcUnF6EMsvwpUTDqs+NT/w==
X-Received: by 2002:a17:906:51c9:b0:92f:27c2:13c0 with SMTP id v9-20020a17090651c900b0092f27c213c0mr4213970ejk.6.1679733424236;
        Sat, 25 Mar 2023 01:37:04 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f23-20020a1709064dd700b00931536d461fsm11431573ejw.20.2023.03.25.01.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:37:03 -0700 (PDT)
Date:   Sat, 25 Mar 2023 09:37:02 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove priv->rf_chip in
 _rtl92e_get_channel_map
Message-ID: <b8c5a719c6f8930adb87a4ad9bd5d368ba5f348b.1679732276.git.philipp.g.hortmann@gmail.com>
References: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679732276.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv->rf_chip is initialized to RF_8256 and never changed. Remove
condition in function _rtl92e_get_channel_map as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 8e4e939d7617..ecc3f0c6c267 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -895,13 +895,6 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if ((priv->rf_chip != RF_8225) && (priv->rf_chip != RF_8256) &&
-						(priv->rf_chip != RF_6052)) {
-		netdev_err(dev, "%s: unknown rf chip, can't set channel map\n",
-			   __func__);
-		return -1;
-	}
-
 	if (priv->chnl_plan >= COUNTRY_CODE_MAX) {
 		netdev_info(dev,
 			    "rtl819x_init:Error channel plan! Set to default.\n");
-- 
2.39.2

