Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F0B69C0F6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBSOjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjBSOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9BD4C1C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g7so387411wrd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cznqdx01/faUtAoqSoejbDua4FcHXQ+/pRuK304PkQ=;
        b=cBxhQu1MiOuL3c2L69272RQU7uQ6pCjBn1d6SnryOcPwzupn7ueF8v5MEdeVNvBhYS
         h4/TwVhfcN/MN9hlwB8QyTpNx+kdobugSn0/OhyFNEDgT7L7qRjm7Cd4yrhANU2OyGFV
         H1Qr5jUOIf0mZbTCAggAc4iJl9V8emZbfsBOze00UrhXGJ08aOO5AGUd+PT7QEfvz79i
         gjL7hSex7iEmPfKugolaqZ8XvolQH32Po+izM+zymyRhbarpF73Z//ViWIr/peUf/x9o
         JmHUGmsJT3ZvAFbajR3+xKxLS2GpaGjNTHYlrrha9gLDylB2mlXJOMZaHZIIyaTczr82
         jyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cznqdx01/faUtAoqSoejbDua4FcHXQ+/pRuK304PkQ=;
        b=Mjhay5pw0cU87svCi1HAHGpRNXy0iu1fgL8BFvvq1KYBuW6NCp7lfTVG9zoVpi009T
         7ihiN6JVuakcc58pJOdAZDvXNfyVfGn7U7x+QdbaVBKlW8zHoDYwxvZFDGYf5HaX0NDA
         Xc3uAb9tR80S7tOOLUmcL0IJRQ2ffgepUg/gvpxc7mkdOI5m0JasauWWwQVuHrg5/oaM
         u9qhJrQXv3X8s+gE7KnBem1zE6vaLXh1JqfS0vCSttm+G6Yu5LXycYo3q6kLPC+Jr6tD
         XFYBqPNHDDTCAwNeJGZGtnLI7Qvx5FwR9ApoB/8XuKltGF29txgvVOH+qjgZVUc6eaSw
         Xk2A==
X-Gm-Message-State: AO0yUKUbGTX0xmNFV5fYmVkB2cqEOq6Sde59+sFAWcViE/KHgK/ecQyS
        +V7ucP8WO+kGtBwe6qBeDbs9aw==
X-Google-Smtp-Source: AK7set+LnJkrxCtM/Mt4QXFkrHuNKO4fIAzFAlp1XOjSJ6bYXltoBh/a3YeqKMC6XlgtTD7NaFAy2g==
X-Received: by 2002:a05:6000:1866:b0:2c4:669:fda4 with SMTP id d6-20020a056000186600b002c40669fda4mr642159wri.0.1676817497552;
        Sun, 19 Feb 2023 06:38:17 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v1 16/17] thermal/drivers/acerhdf: Remove pointless governor test
Date:   Sun, 19 Feb 2023 15:36:56 +0100
Message-Id: <20230219143657.241542-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone parameter specifies the bang-bang governor.

The Kconfig selects the bang-bang governor. So it is pointless to test
if the governor was set for the thermal zone assuming it may not have
been compiled-in.

Remove the test and prevent another access into the thermal internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/platform/x86/acerhdf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 61f1c3090867..71b9c1f922d9 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -697,13 +697,6 @@ static int __init acerhdf_register_thermal(void)
 	if (ret)
 		return ret;
 
-	if (strcmp(thz_dev->governor->name,
-				acerhdf_zone_params.governor_name)) {
-		pr_err("Didn't get thermal governor %s, perhaps not compiled into thermal subsystem.\n",
-				acerhdf_zone_params.governor_name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

