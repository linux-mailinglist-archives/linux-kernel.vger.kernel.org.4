Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9415669105
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjAMIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjAMIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:31:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6232EB9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso21952556pjl.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6aCau9ok9jH3yQCwJE8fQSOUiSa5PU6TOL3Ajvf4Kc=;
        b=P4Abup/1crUAKOjiLS9CVd2u9Z4bGK7XrA/T80YBSDRtaBicQ9skHpNtYMFTNUZj4b
         cd8VprJWowx9l5bxPudCN2e0R+OMo0h/3HH/KqlLQOvfKW+0YD2YYxxlpba6rO53GL3T
         V7kGpyhOTyQbJ079YIX9tOAE2gyC4VDS8GZevi1TkYwY416n5L/DUxgmpVVmbJA1vXPR
         m+E5ItcNclqzK+bWHaXhO18Wwi5iCh4NRa3Ewjg9y/Nu6qybbSpAwwJv+5j1UTh999IZ
         nBx62ff1ALzWmtca5ldC89Uv07GWRzfyu8tDLxHOEspaqHqPH+y+mGE26qbdI6XaFh8m
         hN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6aCau9ok9jH3yQCwJE8fQSOUiSa5PU6TOL3Ajvf4Kc=;
        b=qlPqtvRPoQUoGZ2C84eA7ARaHxSY8oTVAcuG7vh+ValciRZf7S6fD64PkJRM7XnjhZ
         43hH5NWsXNK+KfVJakKky+GL2MpCOaUP9smh+rjZm1/3EO0M1cVuwSyrlnvXy2ZLbh79
         S0D/yPRjZHTeRmleq6rHeS3X50cyoecwYKIYJwnIyhXCWEAT+QdraHIz0JK7IO9EGyNe
         mX5WsR7dMzgTIXDHeAnTJW42oynhrIuhyN98cG1UZ9a91y6XrZJybFGcFx6ClqvTfWAM
         ZYf7noeHZ5ZUwtf4I+PM3OMWb8FiTp80cw6avIq/E4EnrRjVvg4d117L5wQEBoetSqfX
         ueOw==
X-Gm-Message-State: AFqh2kr++8DF0Z44O4zTgCaRvxtQFj+h2YCNcZnyqcGXWeimaxU6skg9
        DKlzBNgewd65bO5x815IYCcUV+4Nl8I0t4tFHcc=
X-Google-Smtp-Source: AMrXdXutgN/1k5TOpIahm7WsLSM8kJM/Szm2ytCidUNk36XLqKrU2uNpyFMQjv/K+zPim+MwaLZSDw==
X-Received: by 2002:a17:903:1343:b0:194:6103:1e18 with SMTP id jl3-20020a170903134300b0019461031e18mr3938051plb.65.1673598686241;
        Fri, 13 Jan 2023 00:31:26 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0017f73caf588sm13466123plp.218.2023.01.13.00.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:31:25 -0800 (PST)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH 2/2] pwm: sifive: change the PWM controlled LED algorithm
Date:   Fri, 13 Jan 2023 16:31:15 +0800
Message-Id: <20230113083115.2590-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230113083115.2590-1-nylon.chen@sifive.com>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
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

The `frac` variable represents the pulse inactive time, and the result of
this algorithm is the pulse active time. Therefore, we must reverse the
result.

Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 62b6acc6373d..a5eda165d071 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.36.1

