Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6D67E2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjA0LSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjA0LSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3D4ED6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so4650109wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUNPIWp5WTSOCDKia5k+jXCL26J1A9hep40mE5FWQns=;
        b=mrM86jQgcEMJkJmxip2tIHld39RoiLb0WGp8HkmoxEG07MUByTNx9/o0BPk7WddBOC
         L0cJC/vQL9ZTkROoFVxEPG48hzz9sLP8MEUN6bJZuXsTrEMf/pTbOMfNiydtIg7mZiei
         SS84fkDHVvVBzeMsna9qvfteFFnm3iYGCRO30hOhiNPcwXUk5dvAf8z47WqQQTOzIwX2
         IyiDuir9eYr6T77+rOp/hdc2y7I7cNnN1VPpriJqkZUfUtd54vHu6jIHXD3fGO3/bTSH
         nb/55PCHGTniN6Q/4euLXjsbqlvzSTEjzgWO4sQkgHNcNdNRCaGy7I2Sb97SP/TD8rqE
         v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUNPIWp5WTSOCDKia5k+jXCL26J1A9hep40mE5FWQns=;
        b=CPBaWSDVsZyktlyaZ2fjhncoKcMLcfmxwuICp2Z+YzMLw9Jz6oGcNcJ6TegmdauBAa
         /jlzikyrEFpHgl7vDQLHzBMMFk2maSMSBChQZ+79GRBV7hSs8rk9NFC0Qh8NZCBv94RP
         wC8cgiGB2k7YzW1J4pMAwpkHkNuc7nm9gNMly09cNNb0eLtbV3AvngZkIO5P01c2IDNf
         qTx9fnUzFqmqHTody+b/vxlsvOVTQagtnSeE4Gwz1bAO0h70TEnbR9Jz6xThpt/7JmdB
         BXbWJAGrOXrLbJDrIsQb56Nu8b/ncYJkdAp7a+HVIJv1enJcIHRtmlOKOLydK+D5RTDW
         YC4w==
X-Gm-Message-State: AO0yUKUr9Vnl4Askmx3GFTG3Gw/q2C/HePPP1YMzR9O0+32XlmIUW+aZ
        xPKIst9L4kijrMjdKR033BfcmQ==
X-Google-Smtp-Source: AK7set96IIR9C/rDOlE7hI2CkBFLlmCpCdvmKuDNmhBXzWj35w5oHUUOxzupcUqUs3WyX4yEheS7Lg==
X-Received: by 2002:adf:ea08:0:b0:2bf:bab5:1284 with SMTP id q8-20020adfea08000000b002bfbab51284mr8649539wrm.63.1674818273939;
        Fri, 27 Jan 2023 03:17:53 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/37] of: property: make #.*-cells optional for simple props
Date:   Fri, 27 Jan 2023 11:15:38 +0000
Message-Id: <20230127111605.25958-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

Sometimes, future bindings for phandles will get additional arguments.
Thus the target node of the phandle will need a new #.*-cells property.
To be backwards compatible, this needs to be optional.

Prepare the DEFINE_SIMPLE_PROPS() to handle the cells name as optional.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70..3043ca7735db 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1256,8 +1256,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
 	if (strcmp_suffix(prop_name, suffix))
 		return NULL;
 
-	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
-				       &sup_args))
+	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
+					 &sup_args))
 		return NULL;
 
 	return sup_args.np;
-- 
2.25.1

