Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7660074F83F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGKTHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjGKTHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:07:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838E1705
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:07:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so51306915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689102427; x=1691694427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiKY+2beK0kCEqS1A96DIZRMWb4AnLYgZxNxXLWwG2U=;
        b=h6FXsEQbXFMh20Wn49GsVSXv+r5kcFSzASidZcZQogdQPOpB1rPdM5OAZdd5jrVB6O
         cw5j5Gb4np8LzchdYpHbJTxMERdOlAr8il5qwMeWUCZjYdF+RhAAReLyZHDEu2FMCkBe
         jcZzIZYptqifgF5fzmqHUspsQf/p9xMPo9+YB7az5qtrmzTRYMLl56XIYNGPpPKaRMBa
         JpFGLFttsZOg29QAKsGgrzFoDRd8GfT5m/pHY4qzmk6HHpAc/3oIwFeN+vPwGFZ3FbsK
         vZQS8YsKzwiS1o7CFwsV0YaISQ0aDnmf35eJvzxUgm7ErSeuI5KU0Le+7u+1HBMHiYfM
         Gjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102427; x=1691694427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiKY+2beK0kCEqS1A96DIZRMWb4AnLYgZxNxXLWwG2U=;
        b=c14IHIVbbLQrbUPPxzYwXZwjxaw0EmFoOiM1r2IBDh58H0q8e5X3TOjBiidNA67p8k
         GujO+S9syI2AQTRPsXurfKy3cZ7vO56mB9neN7yYfHgV6ADP3K88jVMibkF5Q80iKviM
         vWtypUiyBP4hdB9FudBefJZOczsLyHX9p/5ioyWzOdrWqKkPByp94d9k4ZlBiOEMVju1
         /nr6hFaFhUmfLXVFimYji4K2i+Ym8oBrrNENX3sqOGZ4KatevxG9jjXzrhozjd6jBf0Y
         YHqLT4Xj1W+/jNoEHycpFdkXQ1lQgRqloXvOalAwBl3ZuNVVGVQy3yr2NxDlHlYkZWvy
         Zpzw==
X-Gm-Message-State: ABy/qLZQ1l6eP/VansySBdDZXw5y5/ENxSyGmxu33IpRdomQhDYP9Z4m
        oaCsB5SnbsXZjRZczYc3/IE=
X-Google-Smtp-Source: APBJJlHurYatwNkDp+xpUDw2/YvhcTA4et54sMfIUl1FP7F7759BgOtkXz1fc2PtqxYMmdfKLVQV3A==
X-Received: by 2002:a5d:6607:0:b0:311:3fdc:109d with SMTP id n7-20020a5d6607000000b003113fdc109dmr14483727wru.1.1689102426786;
        Tue, 11 Jul 2023 12:07:06 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0031432f1528csm2940339wrr.45.2023.07.11.12.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:07:06 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mans Rullgard <mans@mansr.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/3] clocksource: sun5i: convert to platform device driver
Date:   Tue, 11 Jul 2023 21:07:05 +0200
Message-ID: <23140733.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230630201800.16501-4-mans@mansr.com>
References: <20230630201800.16501-1-mans@mansr.com>
 <20230630201800.16501-4-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 30. junij 2023 ob 22:01:28 CEST je Mans Rullgard napisal(a):
> Convert the sun5i hstimer driver to a platform device driver.
> This makes it work again on A20 and other systems where the
> clock is provided by a platform device driver.
> 
> Fixes: 7ec03b588d22 ("clk: sunxi-ng: Convert early providers to platform
> drivers") Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


