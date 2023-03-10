Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43C56B4808
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjCJO4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjCJOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:55:43 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E11269B0;
        Fri, 10 Mar 2023 06:51:05 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bk32so4379457oib.10;
        Fri, 10 Mar 2023 06:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMoNKpUzGv+uhYFfBBCetA1xiKlZTK/h0rVA394M/W8=;
        b=hOwcUGKbX8/RNsGWXsjktflvtXeogQ2fxjEkrwsaITKvTNy4dyTpn0SgF8Cbu6fkFM
         rpn7Pi5cgK+ApMLTTnwVAoblkHZVMRi8jjLNTV0UFG+76shHWI5QW6t384xGyiG2hH1Q
         12TLPebtdpUVMxHDGgZzG77q6UiRzyQW5oyaCVnGpfN8vvQgv2faTKYSuQ7HKQQqjI19
         hPW1IIapOE6u5247ZMgkFYpP6pcDZbvKMG/cRcvQLoTWIPiJOhjA6aJbim0E+ONlrREe
         wA/4crQZoMAkjFM/z3ioOcQtpWW8s9sn7Q3z4dK4UsRywSnr562g6H4tZijYVq7wFBoC
         /84w==
X-Gm-Message-State: AO0yUKXPEtWugKqBmxOSBmBZBRUAa9qhR8UcLPO6cils8YPigW+GN9gG
        cwexMb102ug86sD67Mv1RY4ewg0YBw==
X-Google-Smtp-Source: AK7set9uRxETYeNeSa/nmWQcSII4rCsfiuzpPgBDnL+Bh4mjLxjd85eQc5NPTqtZ0mG125wfC1MTBw==
X-Received: by 2002:aca:2305:0:b0:37f:a346:bfad with SMTP id e5-20020aca2305000000b0037fa346bfadmr11019963oie.47.1678459723339;
        Fri, 10 Mar 2023 06:48:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r85-20020acaa858000000b0037fa035f4f3sm930989oie.53.2023.03.10.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:42 -0800 (PST)
Received: (nullmailer pid 1547226 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] w1: w1-gpio: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:36 -0600
Message-Id: <20230310144737.1547200-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/w1/masters/w1-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index d4632aace402..530c77b8d062 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -87,7 +87,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 		 * driver it high/low like we are in full control of the line and
 		 * open drain will happen transparently.
 		 */
-		if (of_get_property(np, "linux,open-drain", NULL))
+		if (of_property_present(np, "linux,open-drain"))
 			gflags = GPIOD_OUT_LOW;
 
 		pdev->dev.platform_data = pdata;
-- 
2.39.2

