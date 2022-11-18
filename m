Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAC62EDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbiKRGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiKRGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC09BA25
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id cl5so7755720wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1GWfZ4uzYzmnr67NmD4tsi2YsHKS/xeHdETJ6KMLlM=;
        b=a0Zzlqh0gX13yS2eKMav6mCCc+0Ey9tXxrv2O7bmfcHClr6NT6y9+PFnYY3t36i8Hl
         0uQ/Xh3x5oRUlm17eLk4PtC4GxosSyvDGn1hl/xcYCX8WRHQujk07FLCIXhp8fjAm4an
         zzQIdHvK9R6LxFRPv9noKVYQgwRo5HDmL4zWKCpMyQhhn+wkcAQEbFdJ1xGbXeKk5VOR
         xvneEpeVS1ttSjvPG8/95PDAzLB2wHNDDvOcBKOi1PDwmhlVgO82HqQg14gyfKpD7zYX
         Q1AG1+POmdMxCQiwTaqHLAxg38+pm/N4q/kQXXBrA8cVkv68+qxb0y2hRaIyabSXCSLN
         a2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1GWfZ4uzYzmnr67NmD4tsi2YsHKS/xeHdETJ6KMLlM=;
        b=URxRifD0tT5/mzWa8bJq4UOhPWLKFrYasThZDpzXROrwP/SCxote0qnPK9gimm9ZAI
         fB62vlF3trLLDwInk07jIRob8ofAVHWfKvJdZwEGjfW2uuDTMrdeWwmt09Ju/kvhFM9H
         BrzCa6SIt7Qnmu9xbEc/SH1ZI3Wv6jspFTBNaQ4bm+DlQQOrqJTyGtI0ORzGIciHv2fg
         FRptf2SpJYombgrjBgA/TD1NZB/GHt6Tr4ee49sMGhnlKQDp38MZnYwqBitBkOTEBmw+
         uTMTv1XZZ/R7FprglavwVX8BnV7iTekgghnC8q3OtdWf2EwqQorwfKGFOW5qh1QCxOS8
         g3xw==
X-Gm-Message-State: ANoB5pkXWASIzE78R/m0l4pl6uHKgBnMsl2c4Dyorgv20p6XBlts9g2F
        GvQw6K8OQwVKz/9JNukjfFiDfVh8Ns3N7w==
X-Google-Smtp-Source: AA0mqf4QdDYo982x+bTxoLY7e3sCvmZukMTC9W4n9/wX0cbx8Puoka3lwmtdTafAo9UB1OwzHW35jA==
X-Received: by 2002:a5d:6746:0:b0:22e:39c9:a4a6 with SMTP id l6-20020a5d6746000000b0022e39c9a4a6mr3436893wrw.170.1668753594562;
        Thu, 17 Nov 2022 22:39:54 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/13] nvmem: stm32: add warning when upper OTPs are updated
Date:   Fri, 18 Nov 2022 06:39:21 +0000
Message-Id: <20221118063932.6418-3-srinivas.kandagatla@linaro.org>
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

As the upper OTPs are ECC protected, they support only one 32 bits word
programming.
For a second modification of this word, these ECC become invalid and
this OTP will be no more accessible, the shadowed value is invalid.

This patch adds a warning to indicate an upper OTP update, because this
operation is dangerous as OTP is not locked by the driver after the first
update to avoid a second update.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index d93baee01d7b..bb8aa72ba2f9 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -132,6 +132,9 @@ static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
 		}
 	}
 
+	if (offset + bytes >= priv->lower * 4)
+		dev_warn(dev, "Update of upper OTPs with ECC protection (word programming, only once)\n");
+
 	return 0;
 }
 
-- 
2.25.1

