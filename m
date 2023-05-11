Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E335D6FF8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjEKR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjEKR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:56:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158761BEC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so15864683a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827772; x=1686419772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4dB7ekFw9CND226UK6hDbOLw5RQw3W+5HfLFUcbj4M=;
        b=bbR/Iw4/ew2hIHwNU+7OUJPMCzpe+fygXMahE/LKLF+gcjmdO+4nHREaCVAeMdmH65
         e6dCm5u+M47kxLKoBxb+OhqSWHEi5xRLV6OrJIOEtM+E1WjocefEPG7CQtfjlPeHu19k
         DVrgQncODrfTrNU5cIaTv8UB4WIBqxRpCCQJ3PmoRQ+w4rS2ziuKi8pGj6YvwiUyMfiT
         AjbAG/BuGt5fP0fury5cMbkP5PpuV4OxfkixqtkNkOXvMLbGVxGxFA06bl4ei5OUyhhc
         W/zmHzqd/PDw3jbbXnP2AqsQ5IdZn3IvXbaKJaVkF21+ewSe3FJkB62dDxLuyujsc52c
         u3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827772; x=1686419772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4dB7ekFw9CND226UK6hDbOLw5RQw3W+5HfLFUcbj4M=;
        b=aBXUOlpBQh5Z9itIkO7vvIZnzOBa2i7NeB3c4PZStH1mg6lPgIfiDqD6lTXhFhON27
         OY+mI+lqxP5kPVAE2lqmoS7IEt1V2lVyQJqgKf8GFH3O9gDq+GbFvStV+9c5Vrb0gfsZ
         6kgMWSp7RUYL6idSbBojtPXcpzK7e9decmvnvhYnVB2E+XlZBHnBcrVnfNXhj7nyOPW8
         BAc5h0thRSLzZnXcMdQwzWNSIxk+uFWFsACcRBZ75mIMoOoUcpFazVnfUSPqswbdbezs
         rGdThTeZJUgGA+Q1bwuGsFAOe+eEG6bLG8VrebCH/Dt4tQzhXFMJCyqr5DMXVp8dSP8G
         9nQA==
X-Gm-Message-State: AC+VfDzz5y64qslIgSAELu9y8CqXJye6G3KhCqt9a4SbibwUUtBO1As1
        cSDXvoV3Bto0oLRmnvD3uo9LRQ==
X-Google-Smtp-Source: ACHHUZ43Ug69juLszCcJpjwbZpXFFRAoD+U6n4kLO4xvc/1wdpjiZySCb57QXtdQcSrqwxeXJ9NMzw==
X-Received: by 2002:a17:907:6e10:b0:968:1e8:a754 with SMTP id sd16-20020a1709076e1000b0096801e8a754mr12746345ejc.72.1683827772136;
        Thu, 11 May 2023 10:56:12 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b0094ee700d8e4sm4247029ejb.44.2023.05.11.10.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:56:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 1/4] rtc: ab-eoz9: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:56:06 +0200
Message-Id: <20230511175609.282191-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-ab-eoz9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
index 34611f6dedcb..143650cb7822 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -455,7 +455,7 @@ static const struct hwmon_channel_info abeoz9_temp = {
 	.config = abeoz9_temp_config,
 };
 
-static const struct hwmon_channel_info *abeoz9_info[] = {
+static const struct hwmon_channel_info * const abeoz9_info[] = {
 	&abeoz9_chip,
 	&abeoz9_temp,
 	NULL
-- 
2.34.1

