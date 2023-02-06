Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339B68BA28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBFK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjBFK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9A2193E6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so6874165wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yih36DUTKHT+LMXkgGyjPXAz+nin4ZdW7iSqMcxFtIs=;
        b=sSNa+1Xrm2NKTdPc8h7CLWC8VVYA2acPqHHZL93VnfRkPYW9H5LSGcpLaELJ9Wyucx
         HCLDEoqWfRuHHvRDQeAVVj9+EfDQYQf+SfgQfSIuybTiyZHTQnzoYBeX9ysjDAbTY50x
         KWyHelkYtl3/RQgOrJXEPct6LhJIkhWRdp+29M5E+I6NyUHSVGzv6HzlO/CPXry2y97Y
         KRu3jLX43nAN3ImLeuH1TZa36XAcmGwcP4j3LKF91LMwblxxDoj9TwC1ZFE4nXaECYf/
         Jol5iBuk6xFkIcEMYHftXn0DFA6QDlsjx9LoLh/h7V/CXPjuQhxVJf7D/7mMGMq8G2Ly
         619A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yih36DUTKHT+LMXkgGyjPXAz+nin4ZdW7iSqMcxFtIs=;
        b=D55hYb6n4mTIL23j5fV+PCnVgcs4XA7Aj4C7tFintGpiK3T09YtKNqkW0RQ1fCF+cF
         1b+G+U4WqUhkymzylrIdqbZaTI0W0gV6L/MkytMoABOtxRTs/zqPp93Jm4hCx0FVHSO2
         zJWYcE67PqMgKXcrRFmrSVIK8P6ZlobxQS4KiSR+uXqOHOXTN9T5o7n8u3q4Ic+9n7l/
         wsdV6B9i/TrffY1/rtQIWoqTKcWYHx/2ywdICRZxiwdAf1AiRxiBQ/8MUdA7PgjAFeQv
         Ho2YvJhLHh4ZfVRKCeGedSLleYuaZkuaKwJDmIFu2NbMFdLeFJBkZcBqOMOcggpURxMs
         qgRA==
X-Gm-Message-State: AO0yUKUp/x0dhdyo7Pp9TMUR4s6CRAKGQR0/E85JXxGHFK9VAAY4c7cX
        wS/q6L6u34l9qR3mmMI8bp80Gw==
X-Google-Smtp-Source: AK7set9CSI8BjuMGdOWTl0pzAp+FYoeGP8ZSdlGp4TXHCz6xz01msdc7zaZh2Zu5vP8qgwTB8rBwLw==
X-Received: by 2002:a05:600c:16c4:b0:3db:2098:17c0 with SMTP id l4-20020a05600c16c400b003db209817c0mr305026wmn.29.1675679307085;
        Mon, 06 Feb 2023 02:28:27 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 11/37] of: property: add #nvmem-cell-cells property
Date:   Mon,  6 Feb 2023 10:27:33 +0000
Message-Id: <20230206102759.669838-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Bindings describe the new '#nvmem-cell-cells' property. Now that the
arguments count property is optional, we just add this property to the
nvmem-cells.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 3043ca7735db..8d9ba20a8f90 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1307,7 +1307,7 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
-DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
+DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
 DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
-- 
2.25.1

