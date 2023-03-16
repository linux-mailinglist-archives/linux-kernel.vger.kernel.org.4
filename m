Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E040C6BD49B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCPQDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCPQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:03:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BAA1EBF0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:03:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so9538464edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678982606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+5yg6ZbQ0SExT381wy7aXWOHC1xlGr+X1Ld1SU9mtg=;
        b=z4O3i0DZ3ieWCRjy4RmXqfnsyzxRFtTCrznus41qB8MuYY98Fwdr9s86/FXDA07oT4
         zETWMQ2qCzzw0dwcqtUg0zgdQ+3Ao/ffxQuWhTOxWTHDjc4ZHZz9qP20IZ0oQoe8uwRL
         H4Y1eHbesJ4RIMyPXszDXGlM1lN9wWExp7cMt2eu1EGxdFAa34+fFMoSWqBIJRsJpBa2
         1rXh0xzg3a6dziif4FVghXllwaMNRONBwX94RgGZYcm0QzZpeTLorQ12CQ/NCorvbZN0
         F2Hmk0HS5vcWzOrIRnUIY46Lp4gFl7B48DxkJ9ePr2q4FOX++wYjRXBCnuKe2MQz7wip
         Fclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678982606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+5yg6ZbQ0SExT381wy7aXWOHC1xlGr+X1Ld1SU9mtg=;
        b=hJrt6HG2tLyKN8xk5dUPzcaE9Ay7+lDXaJ5svJKP4itRz+fEH8j7ImY2G/zwwqkgWv
         xmMZaKTDRn/PZf6RLSL3UwjAS3OukVtamCX+qXmRc6TqhwWQyLMH31gOvriMD5odxgWs
         MxzQgRZq3LOL0/xHQ4dKxSba6iifDZuIEDpnrBdxqb0ybD8I6+KPAy156YLsie/R6DDJ
         ZBLj71cJVleqtO7foSNVJbsL5tBYc4mLUVHL87K9N8K4grPnaqm6DNBSBevD71H/AkWC
         uZ9LCrxoxCg3ns+ybwTHp+9t/q/zTRhg5kstE7H3txotqn33ZzrNEQOlEK1wriB7p8dM
         3XIQ==
X-Gm-Message-State: AO0yUKUAigTay5/FUoI2/cO5H8YZcr3mZMrijnQZV0njFA9Lbl4PLU23
        RpP6VsYFUxWSFIpf07ou4ENStrw66Z3Ziqp9YHI=
X-Google-Smtp-Source: AK7set/jElk6KsvQPACSimpCKocXRgKWv4U85ydCqzxJHHxw0Ii/Kx0ZmWgwOC2hxqqYeG6gZFerGg==
X-Received: by 2002:a17:906:1ed6:b0:92b:ff31:45bc with SMTP id m22-20020a1709061ed600b0092bff3145bcmr10522037ejj.44.1678982606653;
        Thu, 16 Mar 2023 09:03:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id v22-20020a170906859600b009311c9d33d7sm335338ejx.184.2023.03.16.09.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:03:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] platform: olpc: use SPI device ID data to bind device
Date:   Thu, 16 Mar 2023 17:03:24 +0100
Message-Id: <20230316160324.78856-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver defines spi_device_id table for module autoloading, but does
not use it in id_table which causes W=1 warning:

  drivers/platform/olpc/olpc-xo175-ec.c:737:35: error: ‘olpc_xo175_ec_id_table’ defined but not used [-Werror=unused-const-variable=]

Reference the SPI device ID table, so it can be also used for device
binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework the patch - reference the ID table instead of __maybe_unused.
---
 drivers/platform/olpc/olpc-xo175-ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
index 4823bd2819f6..62ccbcb15c74 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -746,6 +746,7 @@ static struct spi_driver olpc_xo175_ec_spi_driver = {
 		.of_match_table = olpc_xo175_ec_of_match,
 		.pm = &olpc_xo175_ec_pm_ops,
 	},
+	.id_table	= olpc_xo175_ec_id_table,
 	.probe		= olpc_xo175_ec_probe,
 	.remove		= olpc_xo175_ec_remove,
 };
-- 
2.34.1

