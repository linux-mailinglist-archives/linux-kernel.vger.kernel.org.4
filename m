Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD985BDBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiITE1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiITE0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:26:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B113758B78;
        Mon, 19 Sep 2022 21:26:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso1219668pjm.5;
        Mon, 19 Sep 2022 21:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rfUpzYsI63frIDNqdmtPpUE/MEzLhWYo/H+oG5zg+h8=;
        b=UbE8mSCw4zn9exu+f8n6nmg2N5VlvTNPteV9yQ84pmabq9FyvlDwWZUtyEB/gFIPcL
         YcHgfHgRkZtRpwpIw4rh/OmS0bSbwYkynpmB2cY3tswQTH8tLkoHlsuMUMAbiJnKlh+Q
         vwa5wxZ4thbiZY9lmUsdSvrjTGzmNW8t3wOPRDunGxfzfbPlbGVv/9Me9VhJFoX/T51r
         4Xhh3R+mohFH245CVSTeW4fNK2LjuD8d8XQ0HqsO6yu9zp7usqoXjBsVJSSobWmdVKwR
         3LF0ZJaV9A4q4w35HbOOOKioeuArN7unkZ3Ir/X1LxHGbywXfs1mqeWitwBj/iFm6QTp
         2d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rfUpzYsI63frIDNqdmtPpUE/MEzLhWYo/H+oG5zg+h8=;
        b=a0F+Us3NM1cilvMDJzCQhBoXu7oqQ2odWarwGgTHwA7DykhYDsfypvvTMdvF5z4Nlg
         EKIHwRwGLnDTBFZ4CaAaDNUThYcQlP+3KqVDX5uRpfzkFZ/6h/zBYgoFHuMPakxNVgpK
         6XtNOLH8uY0UK2tiS1LTEqxq8I5JFpDMBMKS6am4XqqHjcxk1lN/lV7FabnMabm+zWOM
         grE2TvY2a4JREgNajSGfD6lX4ljlxG8mbxOwtiMTGHlSZs7e5R9mN1aCw2128Ulr7Qr9
         xtmfyNNWC6/WRWEkdpXPqHCCj2AQWRCwTSjiOtbwtDQS9cY2LlVPFGy+NIfcwa/R45VZ
         DNnw==
X-Gm-Message-State: ACrzQf0bJa+q+7uq2I4QGKYkVNnybXJLPCe0aSLgHtfE9ktr8gUCfr4M
        iboU2hKUeRI0CQnRRfA1nJPOQbZ2Ais=
X-Google-Smtp-Source: AMsMyM6Eo2sVwAvW4yjDLBtQUL5K0AJwz1fwTFJsPODUbnZKBr5vLscVdpLogQsr8lAuEC1TZag7Eg==
X-Received: by 2002:a17:902:e550:b0:177:f115:1646 with SMTP id n16-20020a170902e55000b00177f1151646mr3148201plf.112.1663647976320;
        Mon, 19 Sep 2022 21:26:16 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a024f00b001fab208523esm337518pje.3.2022.09.19.21.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 21:26:15 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-input@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Input: egalax_ts - do not hardcode interrupt trigger
Date:   Mon, 19 Sep 2022 21:26:08 -0700
Message-Id: <20220920042608.1865560-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
References: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
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

Stop hard-coding interrupt trigger, instead rely on the platform code
to do the right thing, according to DT or ACPI data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/egalax_ts.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 9e9b1c52720d..8333a512b605 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -203,10 +203,9 @@ static int egalax_ts_probe(struct i2c_client *client,
 			     ABS_MT_POSITION_Y, 0, EGALAX_MAX_Y, 0, 0);
 	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS, 0);
 
-	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					  egalax_ts_interrupt,
-					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					  "egalax_ts", ts);
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, egalax_ts_interrupt,
+					  IRQF_ONESHOT, "egalax_ts", ts);
 	if (error < 0) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		return error;
-- 
2.37.3.968.ga6b4b080e4-goog

