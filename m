Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965046D6A67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjDDRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjDDRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836444B5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cn12so133617667edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqPgD/iPpDsbHZcAXUeeUavFA2MxWf1NdZYvsMxlqGU=;
        b=kbcfXHB/OdnfMxWx68lSgdoekOL26dxAi/dLe41r/5LzrX671939MlHlLh4aHOPW5Y
         FJHF1j1nqKdsXeIJVbAr1NH4v/PeloFSbpblwvh9C/tSc3yChkYyIAq1MMrU9uhr0xCb
         6o3mhRvWoMSi1tamKGGOPR9iMFclUbbDrlA8y4uSdNEBdTB4Shp+00vWMDzWBwfLqKib
         6jy4j1rK+98L6KXUO8JICe8Pkb3iL/e89DeSP2JbnTjjNHSVZUMsSFWgmi/rFgbJn+jV
         dtYQ8x4hOuQeMUgmKnuNv1V1GmOFrPlpc0i/jsOT+BGK4n6bSEEz7nWB7pKzHv2x4+u7
         W+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqPgD/iPpDsbHZcAXUeeUavFA2MxWf1NdZYvsMxlqGU=;
        b=z6M8E/nIR74WC/QPsq8Um1u5Q02yi1zE6VeZ5r8jSJ4o/zBh1+qDbauDqGtCEKP6BD
         t7fxLs62NoGSArAstmnKh5M+tzteAiDzTcAtHDjgv32HH7l4UB1uat1veieOVvg4RsNs
         LI6Gs7yqYFK5eT+9FPbFSnpsH9/fPCl2jkSMlBsedfArYZMVSBiu+OJGPJly9CTw3SGy
         ePDu7mRYmt5bswpT0XpdLbT5dkPLlmevVPDYsD4HpZtHF/LnkQzef+Gdi0SmDjkiayXd
         XhmBKzGeFamarrMxtMF5PtCN6L8m/Grtn27DmKRNj2QIjYWOL64P6mLJ7cbhX4RPT6h0
         YRAA==
X-Gm-Message-State: AAQBX9dUwTBB8IuagJP0HpzF/deydBCLRD9/f5LT/8AtaN8y9Z04XdQ4
        6WuMvCSmFTDptOhORw915GXd/w==
X-Google-Smtp-Source: AKy350bGQLOIAitsi9vliIeBN5Wtntogmr+4OD2TvfszxOgb8Q8zWp2s14jkNLHymawXlAdyYTIJeQ==
X-Received: by 2002:aa7:d809:0:b0:502:91c6:fa8f with SMTP id v9-20020aa7d809000000b0050291c6fa8fmr157668edq.42.1680628950336;
        Tue, 04 Apr 2023 10:22:30 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/40] of: Update of_device_get_modalias()
Date:   Tue,  4 Apr 2023 18:21:15 +0100
Message-Id: <20230404172148.82422-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

This function only needs a "struct device_node" to work, but for
convenience the author (and only user) of this helper did use a "struct
device" and put it in device.c.

Let's convert this helper to take a "struct device node" instead. This
change asks for two additional changes: renaming it "of_modalias()"
to fit the current naming, and moving it outside of device.c which will
be done in a follow-up commit.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/device.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index c91bb5899256..351c505ecb50 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -248,7 +248,7 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-static ssize_t of_device_get_modalias(const struct device *dev, char *str, ssize_t len)
+static ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 {
 	const char *compat;
 	char *c;
@@ -256,19 +256,16 @@ static ssize_t of_device_get_modalias(const struct device *dev, char *str, ssize
 	ssize_t csize;
 	ssize_t tsize;
 
-	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
-		return -ENODEV;
-
 	/* Name & Type */
 	/* %p eats all alphanum characters, so %c must be used here */
-	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
-			 of_node_get_device_type(dev->of_node));
+	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
+			 of_node_get_device_type(np));
 	tsize = csize;
 	len -= csize;
 	if (str)
 		str += csize;
 
-	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
+	of_property_for_each_string(np, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
 		if (csize > len)
@@ -293,7 +290,10 @@ int of_device_request_module(struct device *dev)
 	ssize_t size;
 	int ret;
 
-	size = of_device_get_modalias(dev, NULL, 0);
+	if (!dev || !dev->of_node)
+		return -ENODEV;
+
+	size = of_modalias(dev->of_node, NULL, 0);
 	if (size < 0)
 		return size;
 
@@ -304,7 +304,7 @@ int of_device_request_module(struct device *dev)
 	if (!str)
 		return -ENOMEM;
 
-	of_device_get_modalias(dev, str, size);
+	of_modalias(dev->of_node, str, size);
 	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
@@ -321,7 +321,12 @@ EXPORT_SYMBOL_GPL(of_device_request_module);
  */
 ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
-	ssize_t sl = of_device_get_modalias(dev, str, len - 2);
+	ssize_t sl;
+
+	if (!dev || !dev->of_node || dev->of_node_reused)
+		return -ENODEV;
+
+	sl = of_modalias(dev->of_node, str, len - 2);
 	if (sl < 0)
 		return sl;
 	if (sl > len - 2)
@@ -386,8 +391,8 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 
-	sl = of_device_get_modalias(dev, &env->buf[env->buflen-1],
-				    sizeof(env->buf) - env->buflen);
+	sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
+			 sizeof(env->buf) - env->buflen);
 	if (sl < 0)
 		return sl;
 	if (sl >= (sizeof(env->buf) - env->buflen))
-- 
2.25.1

