Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7962EDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbiKRGkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKRGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96E82BC0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o30so2977523wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAGSEtoMjiEA8z4zpCZaH+zh+PxwDmjtLZ+/VPy/B3U=;
        b=aRsrluM2SXV3g9vL62gj1RsXStNyAiuKd+wb+Jl3GF1e1XsaGlG2ZtvbFW/87pJomu
         L04yPhiXj74Em1HmNCTCZU6erO4ZoXxhg78mRyFQ4UsLclRiJcmll4wcuajyMuoBs0r9
         TVp+xewuomUTezXmuWz7bIgcHJQU+3n6fSDFVnNSsm9RmXW3la/OdI6Pel+8zgKTanyq
         o+nXHotSrSNKFywLxx0sVvg6w/GXUkLgXiFZ2VhLQ+zeae0ORfqENxTD0czL0Y/x2rys
         MHUofO+f1ndJCJf201cUSZlAvssiPIChJtU1B0KU6sxHowYsIZRhR6+DwEcaxDAIIXWv
         deMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAGSEtoMjiEA8z4zpCZaH+zh+PxwDmjtLZ+/VPy/B3U=;
        b=B4IogNG5GIij4+ogjrDVMA+/uqsmL5Mr6BItwtqeRDxauaF9Jvz3Yv5/iQuus52JeN
         dDyQyGYTXdh4Z4+QP0EBBT8Ne+41QKqgio6TJFgUT/+8c7We9yJs0qaAljemK3UHY13H
         L3uqvbdcGBKhYh1Txu/GmImB13h4VKFTay2U+FEhUS0iDeRDlrdh8HcUjSZzqEfHn6hj
         bz3m9nR+Vw2c0WOcTsWUEcJAuq4JuubWPMKPRt/N3rapA+u94nsJlBAWm864TDIrBV3N
         knNFev1BLx93LD2BhkS0qz6vMvVdP34u5T9NfE0K/7y2e4bXWf1u87McbOA95ElEyg92
         IHSw==
X-Gm-Message-State: ANoB5pmcio8rIHvkwh9Yocybbe5IVsoPpwtEkY1UnO7rUSVe0aDfL7fq
        N1BrMBjzTjc+MA9oDoatd7TzeA==
X-Google-Smtp-Source: AA0mqf6mGfskwlFBQTLbjy4/WVkZCd3yR93mTHX9YcpQpTaRb+Yj7RR8FRzObUZHpl8OZG+oCs2bVw==
X-Received: by 2002:a05:600c:188a:b0:3cf:8e62:f769 with SMTP id x10-20020a05600c188a00b003cf8e62f769mr7524563wmp.52.1668753595820;
        Thu, 17 Nov 2022 22:39:55 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/13] nvmem: stm32: add nvmem type attribute
Date:   Fri, 18 Nov 2022 06:39:22 +0000
Message-Id: <20221118063932.6418-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Inform NVMEM framework of type attribute for stm32-romem as NVMEM_TYPE_OTP
so userspace is able to know how the data is stored in BSEC.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index bb8aa72ba2f9..6de565639d5f 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -160,6 +160,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	priv->cfg.dev = dev;
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
+	priv->cfg.type = NVMEM_TYPE_OTP;
 
 	priv->lower = 0;
 
-- 
2.25.1

