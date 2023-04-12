Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2F6DFCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDLRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDLRvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:51:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37BBFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:51:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so4436398pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681321894; x=1683913894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMFvx9R05G83emmjiC6gGYYP7XR7L+4xdX75p1GZrA4=;
        b=HldBkYFSTk2eIYOWRcFGEl663iNXGLalkDcFYdEz5SWbBBlKj4aPP4Oluf6I1Cl6nE
         X1+UJm09/5ED+Ki81aiikT/OQHBjouJ608sLyPgAuviTfTcTuspXzL4Xi5dU2DiA61DR
         Zfgpohc99MMg5T3YioxT1M3VaHhNQA8zI1envtnlZlLmi0JzTfBOaBAeKquj65rVNPdI
         nlQbYjc8yN5e0f55gFqYD9OVLPRH8fi91MPql4ZfV+0P+qi9irtNdyZWnL7O1M10O7ma
         aY2sBq/ZmYsbDcWdFRARqARjPtZISbEdn9kjBIxsSiontK2GtunZVfvTKXJJ1vvq1LB/
         qImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321894; x=1683913894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMFvx9R05G83emmjiC6gGYYP7XR7L+4xdX75p1GZrA4=;
        b=WB96QK0YF0duj2/SwrlrAyr77mJCSpWQnGjqwVA1cGVu5W0bDiyBzhDIb++i3yWWFj
         wwLbgThK6ZDW4rytHpIGfuQDVaE4epuIdapKjg6YdBZJ8kOGA9BOtzjHzL+exwlKjydc
         eK3W3L2/hE5EtPgWwaL1faUf+zRxn7HhjFR7+Rzb8yXeQgDNbJ+hbfgiQAUjn932Ets4
         TQG3+vLvfRPr5vXKUC4rw+Az8YtLzBiFJf/MBRYiY9QMVfMVu2Ur6GojAQiHt7wEOVVz
         o1/Vtd4XWbAqZCc2Li4dks9ErzENAr87AsbpZlZRmNqAeOcqzTNXWkfWrwGWEWHA4wIc
         PFBw==
X-Gm-Message-State: AAQBX9fzLDb0jZuU5SRQj9bAHYfwDHiaS2cUprf1OWZ3mlweoLKIuuV1
        6Q2bUNDbrNLjiacWmaWxFT4=
X-Google-Smtp-Source: AKy350bvnCp4sbVZIaf3Tejaf1KAm75vhciwgnputsc6uH0vVYKeFmabQjDWsIYrseDixHYsnuLTxw==
X-Received: by 2002:a17:902:db10:b0:19c:b11b:ffca with SMTP id m16-20020a170902db1000b0019cb11bffcamr28373130plx.23.1681321894400;
        Wed, 12 Apr 2023 10:51:34 -0700 (PDT)
Received: from Zephyrus-G14 ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id c14-20020a655a8e000000b004fb26a80875sm10719885pgt.22.2023.04.12.10.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:51:33 -0700 (PDT)
Date:   Wed, 12 Apr 2023 23:21:29 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH v3] staging: rtl8192e: Fix comparison to NULL of variable
 rf_set_sens
Message-ID: <ZDbvoULAO6wdeso1@Zephyrus-G14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions _rtl92e_wx_get_sens and _rtl92e_wx_set_sens depend on the
function rf_set_sens, which is declared but never defined.
Hence calling this function will cause an oops.
Because there is no definition of the function priv->rf_set_sens
will always be NULL.

As a result _rtl92e_wx_set_sens and _rtl92e_wx_get_sens will always
return -1.

Hence,
* Removed function definition rf_set_sens
* Removed usage of variable priv->rf_set_sens
* Removed functions _rtl92e_wx_get_sens and _rtl92e_wx_set_sens
* Cleaned up the variables sens and max_sens used in these functions

Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
Changed in v3:
- Fixed description to fit within 75 chars
- Added suggested tags

as Suggested by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Changed in v2:
- Removed function definition rf_set_sens
- Removed usage of variable priv->rf_set_sens
- Removed functions _rtl92e_wx_get_sens and _rtl92e_wx_set_sens
- Cleaned up the variables sens and max_sens used in these functions
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  3 --
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 45 --------------------
 2 files changed, 48 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 2b2d8af4cf6e..a949a3833cca 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -234,7 +234,6 @@ struct r8192_priv {
 	struct rt_stats stats;
 	struct iw_statistics			wstats;
 
-	short (*rf_set_sens)(struct net_device *dev, short sens);
 	u8 (*rf_set_chan)(struct net_device *dev, u8 ch);
 
 	struct rx_desc *rx_ring[MAX_RX_QUEUE];
@@ -274,8 +273,6 @@ struct r8192_priv {
 	short	promisc;
 
 	short	chan;
-	short	sens;
-	short	max_sens;
 	bool ps_force;
 
 	u32 irq_mask[2];
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index cb28288a618b..0bb657fda06c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -311,10 +311,6 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
 	/* ~130 Mb/s real (802.11n) */
 	range->throughput = 130 * 1000 * 1000;
 
-	if (priv->rf_set_sens != NULL)
-		/* signal level threshold range */
-		range->sensitivity = priv->max_sens;
-
 	range->max_qual.qual = 100;
 	range->max_qual.level = 0;
 	range->max_qual.noise = 0;
@@ -807,45 +803,6 @@ static int _rtl92e_wx_get_retry(struct net_device *dev,
 	return 0;
 }
 
-static int _rtl92e_wx_get_sens(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	if (priv->rf_set_sens == NULL)
-		return -1; /* we have not this support for this radio */
-	wrqu->sens.value = priv->sens;
-	return 0;
-}
-
-static int _rtl92e_wx_set_sens(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	short err = 0;
-
-	if (priv->hw_radio_off)
-		return 0;
-
-	mutex_lock(&priv->wx_mutex);
-	if (priv->rf_set_sens == NULL) {
-		err = -1; /* we have not this support for this radio */
-		goto exit;
-	}
-	if (priv->rf_set_sens(dev, wrqu->sens.value) == 0)
-		priv->sens = wrqu->sens.value;
-	else
-		err = -EINVAL;
-
-exit:
-	mutex_unlock(&priv->wx_mutex);
-
-	return err;
-}
-
 static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 				     struct iw_request_info *info,
 				     union iwreq_data *wrqu, char *extra)
@@ -1066,8 +1023,6 @@ static iw_handler r8192_wx_handlers[] = {
 	[IW_IOCTL(SIOCGIWFREQ)] = _rtl92e_wx_get_freq,
 	[IW_IOCTL(SIOCSIWMODE)] = _rtl92e_wx_set_mode,
 	[IW_IOCTL(SIOCGIWMODE)] = _rtl92e_wx_get_mode,
-	[IW_IOCTL(SIOCSIWSENS)] = _rtl92e_wx_set_sens,
-	[IW_IOCTL(SIOCGIWSENS)] = _rtl92e_wx_get_sens,
 	[IW_IOCTL(SIOCGIWRANGE)] = _rtl92e_wx_get_range,
 	[IW_IOCTL(SIOCSIWAP)] = _rtl92e_wx_set_wap,
 	[IW_IOCTL(SIOCGIWAP)] = _rtl92e_wx_get_wap,
-- 
2.34.1

