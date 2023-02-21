Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F169E92B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBUUx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBUUx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:53:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A8252B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ee7so7306344edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/frlEDrunz1ZlsA7cE8Bp8/LWLs4gKEjmKJVVK0XiGw=;
        b=fYYbDihoqXRluw30lsX0FqgiqsEDtP7f7r0jNvcYBFk0U4tzlJWkplDoy/SelboeeT
         8blaGWBNah2pMlz/Dpa0aF9hMdwcA41q4Dqc0b8QSM3hq01xUcBq86MBoQmPFdLGtf2i
         nfwyYR/D1KtIrLXv870KFibp6RFaaRyXoxrc0/pJhNkhSXrdAD8vX2rsZkXsXPb4E1gK
         OHf+Obt3ImxrxUAmcAT8K6kitLtCDt1jelwNI3KagJ1s05lgs1u/ekVDdQQ+N9DJ7dLu
         cQWPMm/rLjVowfr9hEhFALRZ2sVIhL90j37q4wf0zIRK3bOwT3stbAHJJkFfI2DhDtVR
         mi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/frlEDrunz1ZlsA7cE8Bp8/LWLs4gKEjmKJVVK0XiGw=;
        b=gqToJBoD2GYxrAShSvY8s8e6+CG3HJ1yDsJd4xmzdMTufwcRVmTLNA/89uj58uTUr/
         yAg3hxuMp8u2/f3syqNYOMLzKP4OUD1itbBVSrf3WWd+ITblkgMF7Mvb5HEbueDAWpAi
         63/n4MAOecISJ9IPHKV4yasHBYTBbsWzj/JicUjEJDH3HxtxzwnTZYSRsBzAteX8/vzz
         V/B3+qUXvNHxClpdNfgk6J5RuNGF3rRTbAgznEBfhpwRXPHAYfvRenzLipkv+9fecUBA
         qbf9+iNPhdbW5XutVNOldmDTjZek0Zx/dSfkdCDRnnOnNiJOW/MRPDo9x+0ZD/4/LYbN
         hlSw==
X-Gm-Message-State: AO0yUKWtTnFuHE7DGtODyVyWuqrFSSLEQw4HUeOnlKSTMGHdSPds4r/4
        jjLVQ+enl1rNTldsQf+UW4596jd/DaA=
X-Google-Smtp-Source: AK7set9NJtmtk+CxqG7WBxvoJags2o6wNntGo63fD/DhDVsI2YEnh3XJg+pNVUZ3p2rWdKh75cLm9A==
X-Received: by 2002:a17:906:109c:b0:8b7:1cb4:a5ba with SMTP id u28-20020a170906109c00b008b71cb4a5bamr13227323eju.5.1677012814335;
        Tue, 21 Feb 2023 12:53:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090681d300b008c16025b318sm4743497ejx.155.2023.02.21.12.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:53:33 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:53:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: rtl8192e: Remove entry .link_change from struct
 rtl819x_ops
Message-ID: <9b451317eb4c13db007476c30212ffb09ced2356.1677010997.git.philipp.g.hortmann@gmail.com>
References: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .link_change and replace it with function name
rtl92e_link_change. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 0c1eb75f37f6..2d2f9d4a0ff5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -27,7 +27,6 @@ static char *ifname = "wlan%d";
 
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
-	.link_change			= rtl92e_link_change,
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
@@ -762,7 +761,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 
 	priv->rtllib->softmac_hard_start_xmit	= _rtl92e_hard_start_xmit;
 	priv->rtllib->set_chan			= _rtl92e_set_chan;
-	priv->rtllib->link_change		= priv->ops->link_change;
+	priv->rtllib->link_change		= rtl92e_link_change;
 	priv->rtllib->softmac_data_hard_start_xmit = _rtl92e_hard_data_xmit;
 	priv->rtllib->check_nic_enough_desc	= _rtl92e_check_nic_enough_desc;
 	priv->rtllib->handle_assoc_response	= _rtl92e_handle_assoc_response;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index e572915c1fd2..fa72f8891409 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -205,7 +205,6 @@ struct rtl8192_tx_ring {
 
 struct rtl819x_ops {
 	enum nic_t nic_type;
-	void (*link_change)(struct net_device *dev);
 };
 
 struct r8192_priv {
-- 
2.39.2

