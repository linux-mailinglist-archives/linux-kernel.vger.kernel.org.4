Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487FA6D29F7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjCaV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjCaV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:28:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A424430
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so94745444edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298092; x=1682890092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6eeMO2fOkTmQFtQvQlgUDTMHxNMIRBK0p3MGXvUrqc=;
        b=NRmG9bnKsan4+8PU/mmgHL/s1dDmkW2yglzBB9UpGMXu8E7Eud+uG7q76n03riVT5n
         ZBaVBw8+G+Uf1v/nzPiL+bweIUWFh3+TM4+y08A5xclaySnckVIJbI+8ENxfoNC6c+C0
         VVf2iiG7Dat/Nt8hQr9/6+yTIxP3nJuwZCZerGycFBhJkAt2Nn6Z27XX+GeVB9pPQOFr
         R50JXql/vqgtalxz5EOlf0UI1WH5fEoJkVRQqmYWzT72KwX0M2xy8cC9Ox67XFAUywwg
         WlXD5C6GMfxBIiJdoN3TTx19KlTeuCR2gfNk6Ywp8JvI52KwVLODZU8i6aHzckstm6xu
         cPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298092; x=1682890092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6eeMO2fOkTmQFtQvQlgUDTMHxNMIRBK0p3MGXvUrqc=;
        b=YPJyev1peYkFAv25cVY47WADibBXfA7MjRNjqM76I9MwnlTh1W8fYfQ8MqC2H3l+/w
         iB1mG2r8efRLdF3hhC1qUixji4a00pQYw9G+hPUdDv9zXM8kWJyFAoZD186c7as9/TIc
         2oyotnUK1ghF4jwGRcmZObupQMt3zn39M9AmSoe+dngO5c6OcrjU+m6pUihFAZ0D34OT
         l7C0fpX6i0inG/Kzfct8euk6elrIlBkYm7KCJRAYh7v+vFVMrUri6oxVpLEh/dQjzEsq
         SUt3hn0ojksmphu3Jhcs+rmhxYpCgwnvw7R/LrhbDKub/WHEU3gKzAR7GDNkIEjvO8TA
         /xGA==
X-Gm-Message-State: AAQBX9dlXVEHUhGIo4rirWPRyJ7hOyhiqZf0AZ8UiTb6p7TJDkm6vr/L
        EeBF2PT8F4PzO9Y+/KlfywQ=
X-Google-Smtp-Source: AKy350aEiQiP4G5X3dx7V6sMsDzvREAngt9bWeT7p6yDFAXhqy2v9do3VMobs5Ni/SpTBfIfdWq7YQ==
X-Received: by 2002:a17:906:519d:b0:939:5398:768e with SMTP id y29-20020a170906519d00b009395398768emr25210213ejk.7.1680298092270;
        Fri, 31 Mar 2023 14:28:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709060c5700b0093e23d03d72sm1381763ejf.177.2023.03.31.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:28:11 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:28:09 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: rtl8192e: Remove local variable Value and
 powerlevelOFDM24G
Message-ID: <9b17cf3828915f541aa26b02973f4e9f9ddd1776.1680297150.git.philipp.g.hortmann@gmail.com>
References: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerlevelOFDM24G is set to priv->pwr_track. Then Value is set to
powerlevelOFDM24G and then only once used. Remove both variables to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 2100d9d4e940..a6ae76005d56 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -518,10 +518,8 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	bool	viviflag = false;
 	struct dcmd_txcmd tx_cmd;
-	u8	powerlevelOFDM24G;
 	int	i = 0, j = 0, k = 0;
 	u8	RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
-	u32	Value;
 	u8	Pwr_Flag;
 	u16	Avg_TSSI_Meas, tssi_13dBm, Avg_TSSI_Meas_from_driver = 0;
 	u32	delta = 0;
@@ -530,14 +528,11 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	rtl92e_writeb(dev, FW_Busy_Flag, 0);
 	priv->rtllib->bdynamic_txpower_enable = false;
 
-	powerlevelOFDM24G = priv->pwr_track >> 24;
-	Value = powerlevelOFDM24G;
-
 	for (j = 0; j <= 30; j++) {
 
 		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
 		tx_cmd.length	= 4;
-		tx_cmd.value	= Value;
+		tx_cmd.value	= priv->pwr_track >> 24;
 		rtl92e_send_cmd_pkt(dev, DESC_PACKET_TYPE_NORMAL, (u8 *)&tx_cmd,
 				    sizeof(struct dcmd_txcmd));
 		mdelay(1);
-- 
2.40.0

