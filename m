Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDECE69C2AC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjBSVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBSVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:17:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5A199F8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id er22so4720081edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJzRMtb6Oi/vr369AWzX9RrX430GIMHRsf+vAntxEl0=;
        b=VGUlv9bDsQzX2DEfv5HHv3yUl8lm+2lF5JJENsRL56LksFQftkYBNF3cW3HNODCk4+
         oSmBW2zVEMbWkpUntpElgIw4JTw6jIl+pzqBDkmIy1pu4+WeyIQAWL+AIJgHdBwSW3OE
         03zJXmu0dr3wykIye7Fyt4LoO3auO0q3QYGaVnQWv/93JrZqQEU+I1TNttxJ7Bw8JH9n
         8jLd/O98E16ZPV1qOe+9svJLsZCYbmnRXItgARLcwNVqu8Dl+ZeY2ExntCFpOfPmwN3Y
         j6ayyl3i68ksvSjviT7GKmUpUlFB9YR03Qq4LHZyn5Q9PtUfUK8vL61Nx0uIMAEgvNNy
         o7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJzRMtb6Oi/vr369AWzX9RrX430GIMHRsf+vAntxEl0=;
        b=ydqyNbV8bpRsYbI08rEnS55mHCyIXpXt9GZ3EJrYlNx4IefiGbhjNm4uwknmgtz1i2
         lVOMr+Zl5atyiv2HfF0Sok4g6rj6nDXpfhJ19XZ9eYWUAa5/leafUy8KoibU837CJ972
         8wHaslVcHE/73dHKhNunqJ9bBKNYCDf0VC7DlIjRbrEoUsijT45wn8+9GLJAiPXx5pLM
         UCSkEX5QmZz1eahWHv06lcO7aGU6ZyEoMb9GaJXWColFtJo+CwCLyMUSW1WsmL5U530J
         Uh5bv91ggekIGTqusYUWuz/Wwmtcjdi0Zc0vOs9Nb40t+6UjQQgutPPhpxxIr4esuoYF
         snGQ==
X-Gm-Message-State: AO0yUKWb7TjDntPJYFBSYm5sLwc84e511Hj6XE1P1Yz33Q613ORA1Lpz
        HxQU9vuwliBAUgAMzob4vesYWIIjhUc=
X-Google-Smtp-Source: AK7set9MJAmP1IeGDp7YZE1Qii+Ju+oJT/p25bqlOJjVBP5deeZos9Q6jk4ClDK7Fe8VjYggeO9XOg==
X-Received: by 2002:a17:906:150:b0:894:4341:77d6 with SMTP id 16-20020a170906015000b00894434177d6mr7445896ejh.1.1676841406142;
        Sun, 19 Feb 2023 13:16:46 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ce6-20020a170906b24600b008b1fc59a22esm3620692ejb.65.2023.02.19.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:45 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:43 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove entry .irq_disable from
 struct rtl819x_ops
Message-ID: <6d981b554a73ca965096e434d687b9827b0b96b2.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .irq_disable and replace it with function name
rtl92e_disable_irq. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 0b6d3b3c6415..978088ab076c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -29,7 +29,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
-	.irq_disable			= rtl92e_disable_irq,
 	.irq_clear			= rtl92e_clear_irq,
 	.rx_enable			= rtl92e_enable_rx,
 	.tx_enable			= rtl92e_enable_tx,
@@ -253,7 +252,7 @@ void rtl92e_irq_disable(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	priv->ops->irq_disable(dev);
+	rtl92e_disable_irq(dev);
 
 	priv->irq_enabled = 0;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 6b5761374d54..eb2b1e2ce4a6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -210,7 +210,6 @@ struct rtl819x_ops {
 	bool (*rx_command_packet_handler)(struct net_device *dev,
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
-	void (*irq_disable)(struct net_device *dev);
 	void (*irq_clear)(struct net_device *dev);
 	void (*rx_enable)(struct net_device *dev);
 	void (*tx_enable)(struct net_device *dev);
-- 
2.39.2

