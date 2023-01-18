Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF4671551
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjARHpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjARHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:44:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F9470B1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 18so48329114edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+ByaNjNMsFVHh2+86A0e94ppJsulN3YnOrh35qT8wE=;
        b=j2OAqho3+opiA5EDso1N0iVJ8/kZBW3beSDtZYYdS3aPzzUkwS3SAm8pEm7EOhJvHj
         bD9M4bDvOyqr18y7V47tHmJBYuZdk/OE+ASdFx8OmVeX3tCGCwQwdhGNbvJehuQk0eAF
         0aTsmD0w6JuhPMalUOQNiq9ehLy1eaIo106sCXsThKMH4jcNTgIyOSRrDplzzzF66K0K
         4yemZrWlRo9tZ57LkQ4UQd3h80UZnLR/2cYO8eOEz2frQGffpIIghK/BFw83SpRLYJB3
         TxJqHDt0v6cvvaG1pCCZZzFis3R22em/z0VT2pjChkvDO1lYdLVCQYkLm7XavJPKiP4n
         3I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+ByaNjNMsFVHh2+86A0e94ppJsulN3YnOrh35qT8wE=;
        b=TVYW7GVA6a/E35qIhYHtBkS/A4Tx9uiakO7elcgnp6eQG/9AN+Jgu006VO3PnQ7rme
         yT4RXmISMwmHhQ2WNkLLh7pcH8NzEe2uf7NPXv7KEXTViosARGQIiIusJ1EGObmlHjpd
         A+OU46xlMQFV+hLaCf/mQY8obKG1CkL1ttEr7sV0eHmbdmprCEMjztudtRcdDmRY8lgx
         wVbBuE0yAqpZQBGNCTspQWvjIHq6U7MrhMGXAAeBeFglxd8DkDcPCUhse1+FGeRX1Cju
         BVS9LCMJ2+N+DwL8cYxggEN+9UyFQH138rfiXymnur5kKyCa4nXc3TVHsosEY3jfgluS
         EgyQ==
X-Gm-Message-State: AFqh2krN/QOGt7Lbu6TQPQ4BjHkCzfa57wEIIbkQUMQcsvY8PEQgKLrr
        h45VaLeK3iTe2IHRscCY2m+Acw==
X-Google-Smtp-Source: AMrXdXvUjQ2NHklo1tbpD/3j6iYk5a1/tWpve9YdingtRsyKNBuxJfJOQGbSkjfFInM6pB6qhXtJvw==
X-Received: by 2002:a05:6402:524f:b0:490:47c3:3d7f with SMTP id t15-20020a056402524f00b0049047c33d7fmr8255387edd.2.1674025773120;
        Tue, 17 Jan 2023 23:09:33 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b00482e0c55e2bsm13596984edb.93.2023.01.17.23.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:09:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 08:09:16 +0100
Subject: [PATCH v2 2/7] usb: fotg210: List different variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v2-2-100388af9810@linaro.org>
References: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are at least two variants of the FOTG: FOTG200 and
FOTG210. Handle them in this driver and let's add
more quirks as we go along.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/fotg210/fotg210-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 8a54edf921ac..cef12827e797 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -127,7 +127,9 @@ static int fotg210_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id fotg210_of_match[] = {
+	{ .compatible = "faraday,fotg200" },
 	{ .compatible = "faraday,fotg210" },
+	/* TODO: can we also handle FUSB220? */
 	{},
 };
 MODULE_DEVICE_TABLE(of, fotg210_of_match);

-- 
2.39.0
