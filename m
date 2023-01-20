Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F41675ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjATUSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjATUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:18:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6397135B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so6641764wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiygPQ43h/TyrnBCK1EPAnMPnfYQRYi9ihjA+N7LKWY=;
        b=qwAu39Da47bxut80nQTtpUUoYBrQQ9MJzqE01elmxTr8gWBx5gjJVcBR/sJ13pdigo
         yjODR4EgK9UzG9LShkfKFoiAifSKwHjDLvPse3hd7R1FFit+ICidg0FHixWh/R7tdg9x
         53T/lPbeYRGmt4JAJ7lLTholZ1jL3tUTGQbMx9UMgmNglSXed1WcDE1LtGpd44y0YPUg
         8lGjSY/F3xznmNQ9Mq3hbG+wUYryTN9hCVDY1qy+Nvc+oPdAv/y0ewwOZ4PFmyAijQ7r
         ZxDQ0ChjjwyvJLlqIVfzdkLzuWXyrYQmjZRzxYimHODSys+sd6bZsCrGnfTQnS+S/6rY
         td/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiygPQ43h/TyrnBCK1EPAnMPnfYQRYi9ihjA+N7LKWY=;
        b=HFgi0B5aPnXfwg4Y8cX6iEGTKF5CFuAdmguRYH+64oQvYvORPttRYr9iKEN56Ia9nx
         3SeH2M11aSzewvqiAZWcHcIcArsl+sJhYUjPnCL9YknoFH8bLY3Z/pxoD0lHOp98fnJz
         vpsWK4+kYE13kMhXLd9OVAMF4beq6yPWu2OYMFznDc86TKR6CzsxvV91iSr+MoRNwxz9
         eP4j3hCM+FoiPikGppQHWiYF4BxNwCA+8fdTy6mQeI+tcGeJHj3UYDYkF90A7LwnMUVm
         dvtayl8PIuV/l/fHy0P1SlbCQ/5kFnf2pZs3tn3NiVhAO3j8Aeo9whzX5/MXXZM1CxEa
         GQMg==
X-Gm-Message-State: AFqh2kqONCA7LxUBjmtCPR/fDNyi/ChGo87VBpNyKwWvx2fatgim5HEM
        5cGfHm+Eqk6sOZYxnlBLuITbB5EluCA=
X-Google-Smtp-Source: AMrXdXv48gBvnjsBa3XXFkAgQH+M6piUHkXjo2/aUtj/gWWxMn7P8yQxRxOIe1tqUJFaBy1/ulivhQ==
X-Received: by 2002:a05:600c:1e22:b0:3db:2063:425e with SMTP id ay34-20020a05600c1e2200b003db2063425emr1959885wmb.1.1674245901642;
        Fri, 20 Jan 2023 12:18:21 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c5453000000b003db09692364sm3203653wmi.11.2023.01.20.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:18:21 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:18:19 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8192e: Remove ant_pwr_diff which is always
 zero
Message-ID: <a550004dcdeb9e0b716f69033a541457c1f12c86.1674244819.git.philipp.g.hortmann@gmail.com>
References: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674244819.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ant_pwr_diff is set to zero and then masked which will always result in
zero. Remove ant_pwr_diff and use zero direct as it is just useless
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 33e3435b50b2..c969c40c3979 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -586,7 +586,6 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8	powerlevel = 0, powerlevelOFDM24G = 0;
-	s8	ant_pwr_diff;
 	u32	u4RegValue;
 
 	if (priv->epromtype == EEPROM_93C46) {
@@ -600,12 +599,8 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 			powerlevel = 0;
 			powerlevelOFDM24G = 0;
 
-			ant_pwr_diff = 0;
-
-			ant_pwr_diff &= 0xf;
-
 			priv->antenna_tx_pwr_diff[2] = 0;
-			priv->antenna_tx_pwr_diff[1] = (u8)(ant_pwr_diff);
+			priv->antenna_tx_pwr_diff[1] = 0;
 			priv->antenna_tx_pwr_diff[0] = 0;
 
 			u4RegValue = priv->antenna_tx_pwr_diff[2] << 8 |
-- 
2.39.0

