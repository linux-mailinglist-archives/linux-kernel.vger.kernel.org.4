Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A6606411
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJTPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJTPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:16:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649314C52D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v1so5798203wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=RoVWDS+6us98y2R3xVVuRFTC0psLeObFBgS6ys3P90R004o56af2aFVmsgxuGaYe3o
         yvh3L3zf0ft1L/QdjnISb1KD9wbS5GC4XO9wao1XXVkzuEexkm1qk3cmPhWajFKBIH3R
         3NHEzL3/5a1hXuXMB9Oj2PD7qN0IqLCDRQkdRp4qmRGFVfKwqVyv+iCWEgJeJ668X0jH
         zYLTDSyXTa6gkUmVt+a4kKZDj9OFGnmG+9CTV1oq/TrtmdxkfG6e6KYStPUzSRjRS/cS
         l04pIPTXQv2q7NEWdM51WIRvgiEYpf3jo3j9/M6LaVRfjM5F510GRg5PbWwf7iYD0cnI
         lU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SdKoJam1KKdYl+ZS8hBn9qpHaB89KQkUoXzOnMw6QQ=;
        b=vl4aXklMXhiopGGoCxTpOjQRL5B6DToS01vvrpnTTWFB6tjrofNcoWKu83hPrzBN7f
         rYmEIk0z+QukAYvSmIjqWunzCf7zGZq8kP+KdJQnHKlDnSAanvYGIA7RmIogEO3D1dmr
         ZcPhRmfelNTtHIpc8r5uQgYTFSo35EwJBj2BJFn+P7owWomMfbGzG1xYS75cwV+QfGNW
         LXkzYwc6jG/+pz3uIFDelYH5904XpOAGRB5cZQ3hdDPKHAm6SHC8gxzL/0b+LlYtEN0U
         nhFXwpOsedniiF9GC3Uj9Q5AD8Z4UZNgG/ZbDnMeqKbJUDiIe1G+TUTrqXRyCqmhWHuJ
         xOKA==
X-Gm-Message-State: ACrzQf0lzeTEk+3XtbQ9a3Ghe5/Z9EAI+WqDLaMp0kdaumRMWZXYEXuH
        AdKnvGhWQknYcb9VHr4UJ8ca2A==
X-Google-Smtp-Source: AMsMyM4Huzvk/t4yhYDc/tqivNqlwpwOp1HAl0w36xihDrFVdaxzty6GhF8rG+Go5IfpBBvmXIIKxw==
X-Received: by 2002:a5d:65c6:0:b0:22e:36aa:65be with SMTP id e6-20020a5d65c6000000b0022e36aa65bemr9043960wrw.531.1666278979136;
        Thu, 20 Oct 2022 08:16:19 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:18 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v6 04/10] pwm: dwc: move memory alloc to own function
Date:   Thu, 20 Oct 2022 16:16:04 +0100
Message-Id: <20221020151610.59443-5-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding other bus support, move the allocation
of the pwm struct out of the main driver code.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index c706ef9a7ba1..61f11e0a9319 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -196,13 +196,29 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	dwc = dwc_pwm_alloc(dev);
 	if (!dwc)
 		return -ENOMEM;
 
@@ -226,12 +242,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	pci_set_drvdata(pci, dwc);
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
-- 
2.35.1

