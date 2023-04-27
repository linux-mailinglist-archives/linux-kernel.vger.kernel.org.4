Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE86F0BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbjD0SUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjD0SUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:20:05 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86DC30F6;
        Thu, 27 Apr 2023 11:20:02 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef55901f49so39152116d6.2;
        Thu, 27 Apr 2023 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682619602; x=1685211602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGaeocdiEgYYiyV9F2iOmV2bIeU06kUvSa9gWNEQaAQ=;
        b=CncbTud9qhe+DcKJhNq26tn506iRUu1rMfKkLCE2b8/U1gJkBqgfQ6/Ijmj74d/X4t
         ubcEUUmkWIPVBs7mBIuasRcDauhw51OQbgAFB9Dot1F/ZEAD8FnUt+F3hmuy5oxHmvTo
         Gfsu1/aWMx/SpPRClRUGf9iFhJFJyXdYUJhrfgAvQW09kgRo9ZAwHu0+b2naM+UoO2MH
         h4VqjwYrPZPpE+5OZKh3Sw8wpLJD+6QvdnYOW2CdSRysOvNQUClVEpKEpOHItrG/pH7z
         n4BH3dXTY/WKVp/MYhvjMHHPElYRx0py3WK1Tpn+6ShvW/97Le6gz+j+fMk/XXhzrJ9a
         KmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682619602; x=1685211602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGaeocdiEgYYiyV9F2iOmV2bIeU06kUvSa9gWNEQaAQ=;
        b=UAANzka0m0t8X09pjegn1GERUfh+L/3yV6YYaFWIKI9B/q4gXrJjZGEXJIUvzOPU/p
         tNXCTnczm/nvos/nxcqSmEaphcCIN4K8UJ9Ytm7Xmdj7BFyksAQvRAlYYbpqR6ubZCQ4
         TYOQQZwewBHiQHZGF++nr1yElxaK7nvaVoWc8Fvqv1n1DYpryOUuFGappQqkn6b0QOZ4
         lux0AgjCT+bxZy099WMaRMWmts5DokkXSp5QQiA2sJU/xv1gD1sMxZMUW50CZ5Z4UdBM
         dtey5w7+5y6ujdyREe1eiaPNv8bD6HMSnHGdnoIf3WCw/T3ZVhhQEbjvI/dLSt3hOjHU
         fFhA==
X-Gm-Message-State: AC+VfDzvZ7A3P92u7heaCrPzu6Y9xBucuhbqp43hhOcEGSZj9QQtR+//
        9uccogYp39u5f0Y4Jj/rqJ0=
X-Google-Smtp-Source: ACHHUZ4i3llp4kr7De3qtTeEe/6ksRlGqIo0MkjYvKYBHzrH1nYjOwTETcvxkzY0G2MsJbJkc3bpxg==
X-Received: by 2002:ad4:5e89:0:b0:613:5d6a:94f6 with SMTP id jl9-20020ad45e89000000b006135d6a94f6mr4226699qvb.19.1682619601781;
        Thu, 27 Apr 2023 11:20:01 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s14-20020a0cdc0e000000b005e5b30eef24sm5788316qvk.56.2023.04.27.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:20:01 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH 1/2] serial: 8250_bcm7271: balance clk_enable calls
Date:   Thu, 27 Apr 2023 11:19:15 -0700
Message-Id: <20230427181916.2983697-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427181916.2983697-1-opendmb@gmail.com>
References: <20230427181916.2983697-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sw_baud clock must be disabled when the device driver is not
connected to the device. This now occurs when probe fails and
upon remove.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Reported-by: XuDong Liu <m202071377@hust.edu.cn>
Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index f801b1f5b46c..90ee7bc12f77 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1032,7 +1032,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
 		ret = -EINVAL;
-		goto release_dma;
+		goto err_clk_disable;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1119,6 +1119,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
+err_clk_disable:
+	clk_disable_unprepare(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
@@ -1133,6 +1135,7 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
+	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
 	return 0;
-- 
2.34.1

