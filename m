Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23262EDF2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiKRGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbiKRGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863C882BDB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a14so7839943wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPoS5c0NA5mvn5v0/8jSYk8xg57iIs+E4GUJ/bjMpqA=;
        b=h81TVeZbl/leUMsap5jTYhdnKO/oRjIKH44NaE+7GDX+NGkFsEnPBoMCfHEYS58Rmm
         uN5LbyhomsSTAWdbhR7gzYX9BGf9/iqzKl4BcHSnGvPLH0b10+ifLdUtjs15O/IMeZUC
         YecV2dowkgGNG5R2Z9c1iyTAhZ1LPea69V3cjJi3Yy8v/rdkUSN+a4T5+6HHFSxBV0b/
         Dkp9VH0jFimVX0TIOv0SE5+C1WjuqAp8F0S5J6rw8/bAMzADZ7sKdjnHsznWYsOGDg36
         itHGbCJTTskcsUjkhiUefdPQjFv5pRNCVg6POrKjosKAFnAt5lLuURjgVZoSUuBKmusZ
         Y79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPoS5c0NA5mvn5v0/8jSYk8xg57iIs+E4GUJ/bjMpqA=;
        b=hnF5wRZT612THJVOVX2sAqLAUZ132TBah9OImdToZOpvguI9F7qq6L4vwLEoin7tBG
         bCHKztBYr7ekfOoaoC6liaTI7uXwfuVbrXGRUkWpHLS5d66LYCYwOuOFeb5fnyEQBFwW
         HbvZy+OKiqBsX2nCyZdkcmo4waMTVrt9NO+58yhFTuNnIY6ahXS8l8LhgLF/1J6ssoaX
         QlYlsinNgi6OXYVk5Dx6dqcy9JLJQxJvyoJtdCkkZvFaa4WRqzixFSw2M3VYrDF0W/9e
         eWGWrY9ViJ/dg2CIpyOw/TC1ewmbrGQPpgLHMk+dVFsuZmAjf3fzDWVf4gyrJDPAse0s
         od7w==
X-Gm-Message-State: ANoB5pky9+MZbcIJCiKq8UPLj8vLriAtT1qmC9T2iic+JkxhPPm5knsW
        jE7Pn3xhx0mwBPo6BPlXqXFy1iaVWpcRuQ==
X-Google-Smtp-Source: AA0mqf5/RaNXw8btHfpSv3l2rJqWOgL9UWgUyr928qTh4bKKfL0EpWPRsBc3UL7jYGEhPyGpLfSdZA==
X-Received: by 2002:a05:6000:18d:b0:236:5fe3:c459 with SMTP id p13-20020a056000018d00b002365fe3c459mr3400195wrx.219.1668754378043;
        Thu, 17 Nov 2022 22:52:58 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/12] slimbus: stream: handle unsupported bitrates for presence rate
Date:   Fri, 18 Nov 2022 06:52:37 +0000
Message-Id: <20221118065246.6835-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Handle errors of getting presence rate for unsupported stream bitrate,
instead of sending -EINVAL in change content message.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/stream.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 73a2aa362957..7e9c818e66c1 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 {
 	struct slim_controller *ctrl = rt->dev->ctrl;
 	struct slim_port *port;
-	int num_ports, i, port_id;
+	int num_ports, i, port_id, prrate;
 
 	if (rt->ports) {
 		dev_err(&rt->dev->dev, "Stream already Prepared\n");
@@ -221,6 +221,13 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 	rt->bps = cfg->bps;
 	rt->direction = cfg->direction;
 
+	prrate = slim_get_prate_code(cfg->rate);
+	if (prrate < 0) {
+		dev_err(&rt->dev->dev, "Cannot get presence rate for rate %d Hz\n",
+			cfg->rate);
+		return prrate;
+	}
+
 	if (cfg->rate % ctrl->a_framer->superfreq) {
 		/*
 		 * data rate not exactly multiple of super frame,
@@ -241,7 +248,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 		port = &rt->ports[i];
 		port->state = SLIM_PORT_DISCONNECTED;
 		port->id = port_id;
-		port->ch.prrate = slim_get_prate_code(cfg->rate);
+		port->ch.prrate = prrate;
 		port->ch.id = cfg->chs[i];
 		port->ch.data_fmt = SLIM_CH_DATA_FMT_NOT_DEFINED;
 		port->ch.aux_fmt = SLIM_CH_AUX_FMT_NOT_APPLICABLE;
-- 
2.25.1

