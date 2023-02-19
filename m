Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459DF69C2AB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjBSVRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBSVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:17:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EE19F15
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x22so4875532edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD9atmMnnpsURBtqJPW0p5QrUQNp837QeANxxAzZuD0=;
        b=TpR55Vci45jz0c2/WF0iVeQh7rywmQY76d+1afkeAR3ER42d2A3TsB0S1WtSUek8Wt
         ntkmMIbEXl28tfBRpAHy1oyl8CxcxYtT5wGmRVYxVwuwEC3MU5Vb3DKSekdtat/YV5hE
         W4pR+jDnY8RQlddHKJ3SK2T6QrA4mIQ4Pq2rTbtp+orHb1jxT5FLrOnyLHML8qRdqdd0
         OtQDBFb+CyQAg6JIGUZTOlGKMpDIX3acaiH/6btt5d0TywQyTI5X/42vybSmxxa/QThT
         lDt2BdBetjDoGEv2hTul8Oi9DTmdeEby79uBZXssDqrLLCONZBUUhEJFVMgaBaU+9ux+
         gW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD9atmMnnpsURBtqJPW0p5QrUQNp837QeANxxAzZuD0=;
        b=m50Um0Q4vUle9XrdpdKQfcMJthbrN2UvZr1y5iUcfQ+y987Wo5pH+8oswIsg2BIHA/
         bgUudouaqBc6E3roiln29uoPXL+QDHX6hWE2n0AZkJipNLxS9ILqiI8Vvv6ZyK3rPx0H
         vaTIv4KCEu6BsH2Zf/8tUWLdiS6jH74m7mf+P7QJD5ni8wd2ZJTA/HF4EoPE4xyby2Iz
         8EhuQyrMT5ppiDCIfskdzmRGeFIm5rK6aosYuFGy9p/HtymP28EV7+6sx6W5mDcsMq9w
         KIIdlC85Gc8f5H614SzFL42jyFNFrYgMXzZxNQ4E7El/+4NlDag+B5WLN/cCBj0TtjJy
         cI6g==
X-Gm-Message-State: AO0yUKU/wplpKBu/6sEn8l6ZXd7MTC/Wl/E+K00HnWKh2fC9Vk/DEpO0
        VuYwsFv5hETN87rwo38h/XY=
X-Google-Smtp-Source: AK7set/fXq3wDuhUZ7o4v3qKI2h1ID7H9bmEnb9sMjrYDJrRuRfRLhj91AmvZGI6x7wUyKCZif+KVA==
X-Received: by 2002:a17:906:2cf:b0:878:5fa4:7443 with SMTP id 15-20020a17090602cf00b008785fa47443mr6702157ejk.3.1676841398012;
        Sun, 19 Feb 2023 13:16:38 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id l27-20020a50d6db000000b004aab36ad060sm40693edj.92.2023.02.19.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:36 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:35 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] staging: rtl8192e: Remove entry .irq_enable from
 struct rtl819x_ops
Message-ID: <c23a034632e06b0d9dcb98bd2311010561b6645e.1676840647.git.philipp.g.hortmann@gmail.com>
References: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .irq_enable and replace it with function name
rtl92e_enable_irq. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c7561e486359..0b6d3b3c6415 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -29,7 +29,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
-	.irq_enable			= rtl92e_enable_irq,
 	.irq_disable			= rtl92e_disable_irq,
 	.irq_clear			= rtl92e_clear_irq,
 	.rx_enable			= rtl92e_enable_rx,
@@ -247,7 +246,7 @@ void rtl92e_irq_enable(struct net_device *dev)
 
 	priv->irq_enabled = 1;
 
-	priv->ops->irq_enable(dev);
+	rtl92e_enable_irq(dev);
 }
 
 void rtl92e_irq_disable(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 10ff4f9ec760..6b5761374d54 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -210,7 +210,6 @@ struct rtl819x_ops {
 	bool (*rx_command_packet_handler)(struct net_device *dev,
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
-	void (*irq_enable)(struct net_device *dev);
 	void (*irq_disable)(struct net_device *dev);
 	void (*irq_clear)(struct net_device *dev);
 	void (*rx_enable)(struct net_device *dev);
-- 
2.39.2

