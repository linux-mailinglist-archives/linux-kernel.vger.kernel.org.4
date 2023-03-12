Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6D6B66A6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCLN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCLN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:26:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7F22A2C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so7451151edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BDbceQOAYQgK567jHrWA72I3uGpkeTXZrFRx2w9d3o=;
        b=cL1a8hHuMXeYkEGX3LBxkMgBkge8437xuLFULeTSVWmsUkdbORF0gWFoJZZA192NAR
         9oIaJkGaTrtoCvQlz2pCKgv3tXlwwYYNOh8ikLjLO53XnPxTLGlelYjkr9p8CC/ryt2l
         hZYN3OvN5htU4GO7/1hrZqxET/S7hRdW6l401MzVNKBZ2CtqJj1QTzQxDXCP6+WyCiJ1
         yBW1KVxSflb4ytp4NdVqBZQRlJxRqPy9Hb2+OrHvZicH14WSLUgIS84O7ALh4R43WWk/
         +51ed5LCGOUiWg5yErC7NNltpUeE5xTqvoW+N/a/8UYja+VU52oN2CZzitqdi4a/6aom
         cCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BDbceQOAYQgK567jHrWA72I3uGpkeTXZrFRx2w9d3o=;
        b=drqbbj3HJTHDtr7dnwIajev2kiLbdun1TTxn/BvFcfxAD8rvLZ9RmJ/5dNA0sX5xb1
         KWD8rFaortHHpBe4pi/dpBCyqhJGI4aL41GrqdBC6f8B7gKrYw6KimHz8c9ctkxy9Y0C
         rFFjRmCG4/b58EPRfQkeju4AlmKLnEou3kvm7ABVrP8LgV/nBecQwafXvInUjxErYTKp
         J8vtZZj15US9zLje929qyu8teK4ETh6vHempE9Fu/5DApPRM6HGf4CLYfAcZhfGdBYFr
         YYhqXxiHhx3EqjSK0057Vl6V6pomnAQo4bTUaP26LRknLET/wvRkz9PyCmog60EJ8GEc
         4M7g==
X-Gm-Message-State: AO0yUKW587lguEilUjA9FaAZVDHa2em2oQTMDDCGDHHEY2jtFk4dR/um
        YA/heR1WMge4P6YVe/Iese6KNQ==
X-Google-Smtp-Source: AK7set++lTLlA8S8P3AdKGyhzI1mOg+z+mc5k7KsLLhrAjG3EMSUe5pGtmzlOeA3xn52a1KyfrwqyQ==
X-Received: by 2002:a17:907:7205:b0:8b2:fa6d:45d5 with SMTP id dr5-20020a170907720500b008b2fa6d45d5mr40522268ejc.71.1678627587914;
        Sun, 12 Mar 2023 06:26:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id xc14-20020a170907074e00b008b904cb2bcdsm2262530ejb.11.2023.03.12.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:26:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] platform: sony: mark SPI related data as maybe unused
Date:   Sun, 12 Mar 2023 14:26:24 +0100
Message-Id: <20230312132624.352703-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested as built-in making certain data unused:

  drivers/platform/x86/sony-laptop.c:3290:36: error: ‘sony_device_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/sony-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 537d6a2d0781..9569f11dec8c 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3287,7 +3287,7 @@ static void sony_nc_remove(struct acpi_device *device)
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
 }
 
-static const struct acpi_device_id sony_device_ids[] = {
+static const struct acpi_device_id sony_device_ids[] __maybe_unused = {
 	{SONY_NC_HID, 0},
 	{SONY_PIC_HID, 0},
 	{"", 0},
-- 
2.34.1

