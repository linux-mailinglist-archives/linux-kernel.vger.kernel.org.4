Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A408D62EDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbiKRGx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbiKRGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339720BFE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so7753051wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odkf8d759zAm2S3kf+yGGkjhpuHSduq3rr4jcrJwJ2g=;
        b=brqjbNMhx/SjMyPuvrG9Vu2y6fKP5ogOjLJ0h8NLtuXXzp689AEwXb3I1b0M6wIfr6
         ra40wLbBgDTtulD2gSu62yEDfghJFFRW0r8eiJlhXJv2bo+6bTQ2sgD0V5zQ+o1Z928p
         DBFki4aIIPI1qtvP8CM0MfICI0E0Oky42+XILgNa66RPJaNoAWb8D0L2l23ulifzaE0p
         uZMMAAJeAoinA5K5aTlD4W2xpVUmEsnQmQ9+hNX1CPRFbRvVd1SJcM2lAiLzt6H8iKbl
         NR7fWWQEhg/vk1mDW+e+cw4X1UjEfJOAwofRG3+SAnyT+S2a+PUYUbhgZk8yHOtEzKxZ
         ODRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Odkf8d759zAm2S3kf+yGGkjhpuHSduq3rr4jcrJwJ2g=;
        b=p1Atbx2Jf7MBL0Hppy8zOKnFG12n/qSPMe04hvQcacSZsnfxo6sNbXoKqy2+wLNmkQ
         fCx5fIMODjeagNm980GyNWEEHUJy5HS3R4FjDII32cnNhE8c7fOvPd9mU6JtTzhDn3PR
         F/J7MPDLP5HypLmE87oGZG13CN//dE5K01kqO4P4i0VSCwuNAZnSlwohr6T0GxMkqfPD
         Wiw90rThfZ6cGi6AhQhaT9qx+1hn1Z3f4c9z+pxPNyAN7kArgWnHoXnQeEA5ooxHEfeu
         jRfhNzxOQwziLVPb9LD7IgwCPJqnQxHYVw8LTICNfO4cAHraXjaqKvS2lUH2683RYr0q
         Cuqg==
X-Gm-Message-State: ANoB5pnjJ1ex0C4uGApUxtqkTiBpV0w8MGgqfqdLTuQzpOd34e2O4y0C
        j1ssjQOA3NL03lkMPRP8YBdRr8jNfCSHEw==
X-Google-Smtp-Source: AA0mqf7x5q5L80ZNww6Wg0mGWRtH6jmdE16QFiMDzBv2zVqGhoPTsXsYziLPep9cN/QLt+veTJ3epw==
X-Received: by 2002:a5d:628e:0:b0:236:5ea4:68c8 with SMTP id k14-20020a5d628e000000b002365ea468c8mr3431594wru.132.1668754380771;
        Thu, 17 Nov 2022 22:53:00 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/12] slimbus: stream: add checks for invalid unprepare/disable usage
Date:   Fri, 18 Nov 2022 06:52:39 +0000
Message-Id: <20221118065246.6835-6-srinivas.kandagatla@linaro.org>
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

slim_disable_stream() and slim_stream_unprepare() are exported, so add
sanity checks preventing unmatched/invalid calls.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/stream.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 7e9c818e66c1..1d6b38657917 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -414,6 +414,9 @@ int slim_stream_disable(struct slim_stream_runtime *stream)
 	struct slim_controller *ctrl = stream->dev->ctrl;
 	int ret, i;
 
+	if (!stream->ports || !stream->num_ports)
+		return -EINVAL;
+
 	if (ctrl->disable_stream)
 		ctrl->disable_stream(stream);
 
@@ -445,6 +448,9 @@ int slim_stream_unprepare(struct slim_stream_runtime *stream)
 {
 	int i;
 
+	if (!stream->ports || !stream->num_ports)
+		return -EINVAL;
+
 	for (i = 0; i < stream->num_ports; i++)
 		slim_disconnect_port(stream, &stream->ports[i]);
 
-- 
2.25.1

