Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B826B2D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCITDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCITDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:03:00 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C327783F9;
        Thu,  9 Mar 2023 11:02:56 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id nv15so2103181qvb.7;
        Thu, 09 Mar 2023 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678388576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLJenGm5ch14w3UeDxfYArjzsY1MQxcLGblkePHk6S0=;
        b=Quqrn8ga7PRKzhxtmOeUSAz33cDzmtzf/yBjjlR8UZ5N8I5c2XX9KJ3qxzokKbibyu
         iFgQ8Z07JBkiVMWOcOLRicnbT0PlLSCtFisJeXhhITNLCbbwbUXK/IAk0WGmZeoBFC0d
         M8np1/e/+uv0+5YOi+OVSQwBOUia1CZT2X+Hyz5yhSNc6uCR0VrIytUjPfjHUSzgQ8w0
         OcbOKJNCu3YCgnFdBPhYqF+nN9e6Pg2hne2FsDq+CQbLb82GnApXVdzOX3GS/qnn71KL
         ZIUMQMoPk7UqQKHh8IFgJcdPnk4yBwgHVavdCFU2k8iaw3oPZttM+APtQZLtfeitjzCp
         o2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLJenGm5ch14w3UeDxfYArjzsY1MQxcLGblkePHk6S0=;
        b=ipzres8e5kGTujjQUVmCLCSzk+zQwdCP4WEMAwugBIUYamfA/er7AQc/yr8mBzR/d4
         EdMvSrRkDyPTgC6HyUfjcZmaNjerQWp9CAQS4F97WS01eJOEiLBWzotIXVmqQT+p9sls
         c6Qw59Dly4qaKCFWMEw8oG/IZeY54glfrSeu0ZRMIV/me4k92fsUtyF5E9bsyMW7Dih/
         5Jj8ypAS4J3XUrSuVjLgsSUS8UnlJIqKxhiCIDuCebGk6KE2OSUGd9SkEccCnwum+DU/
         vgIZ9f7dzxjxhQvSaA2WolmNJt9wzu+m9Ogf2mhVsYgW828Pn8CBTJPkH3pnMDHXImIo
         wPdw==
X-Gm-Message-State: AO0yUKWl1aTKmkc8te60wg+2srgPgUPK+4N+uxYiIj7cRNAKjEngNCZ/
        RuZrmHUD2aaCGzQsHRYRfU0=
X-Google-Smtp-Source: AK7set+1Vkjjy9orTfluWus7fOsPaT01h+Ouem6QnwN/B4E/NHICAZpDWH8Z6Y/2WfT8QZpZLC1UnA==
X-Received: by 2002:a05:6214:ac5:b0:53c:818f:b093 with SMTP id g5-20020a0562140ac500b0053c818fb093mr47994778qvi.19.1678388575835;
        Thu, 09 Mar 2023 11:02:55 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d199-20020ae9efd0000000b007423e52f9d2sm14033627qkg.71.2023.03.09.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:02:55 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH] serial: 8250_bcm7271: Fix arbitration handling
Date:   Thu,  9 Mar 2023 11:02:24 -0800
Message-Id: <20230309190224.687380-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arbitration of the UART DMA is mishandled for a few
exceptional cases when probing and releasing the driver.

It is possible that the DMA register spaces are not defined in
device tree for an instance of the driver, so attempts to access
the registers in brcmuart_arbitration() would use NULL pointers.

It is also possible for the probe function to return an error
while still holding the UART DMA. This would prevent the UART
DMA from being claimed by an instance that could use it.

These errors are addressed by only releasing the UART DMA if it
is held by this instance (i.e. priv->dma_enabled == 1) and
directing early error paths in probe to this common release_dma
handling.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index ed5a94747692..f801b1f5b46c 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1014,14 +1014,16 @@ static int brcmuart_probe(struct platform_device *pdev)
 	/* See if a Baud clock has been specified */
 	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
-		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto release_dma;
+		}
 		dev_dbg(dev, "BAUD MUX clock not specified\n");
 	} else {
 		dev_dbg(dev, "BAUD MUX clock found\n");
 		ret = clk_prepare_enable(baud_mux_clk);
 		if (ret)
-			return ret;
+			goto release_dma;
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
 		clk_rate = priv->default_mux_rate;
@@ -1029,7 +1031,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_dma;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1116,7 +1119,9 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
-	brcmuart_arbitration(priv, 0);
+release_dma:
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return ret;
 }
 
@@ -1128,7 +1133,8 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
-	brcmuart_arbitration(priv, 0);
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return 0;
 }
 
-- 
2.34.1

