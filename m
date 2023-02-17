Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288AC69AEED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBQPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBQPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:04:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471659EC;
        Fri, 17 Feb 2023 07:03:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg22-20020a05600c3c9600b003dff4480a17so896101wmb.1;
        Fri, 17 Feb 2023 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu+zHVpDWSZggbR75755cKCzNzfoKOjCPk7YtlsBHPo=;
        b=OJsSTZzhCtNjB1MjPwCiiQCEgJL7cG4sZhSpGPCYZcn6G4p4PwHAVT7/tQ3OqC+q3O
         G7GrnVsZpTVO4gj7VRKNIPA4v9sTYV/W53F2r2aqj5I1Rg7SF9PNDXaN33mlkXpXcsGc
         GEUkqcPOVeTLOhuMah45dtd9LIL9asJ68AuM3TsQsaN1gUKz8cQ6Xt6HBNw2CH+srSY4
         zTl6ClPJrh7musB+IHPCnyZukqharUm2oZDq7+wclbDSVCsBMIR2bddCC8iGclSYJ0V2
         YtOdq0nHRQQU+uLmvxTbLlaMp2uu312f0hthMO+BGHVlgL6De+p9yzYnAjOKAsd1w283
         wrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu+zHVpDWSZggbR75755cKCzNzfoKOjCPk7YtlsBHPo=;
        b=g4DGokrcquakdOz1Ft7GJs2rZ+sVY3BZEfKdrz1qJoPvxBQshB9hUUTcBew+w62R6c
         lCkioz+7/eHojBsZZdIE+iQ8mHr/tqqcfes6d0yYNoZ1F18L6DIzkT6L05OCZ/2+7d7E
         v+BE2kYLzo1Bge83EyfSO1ongCdR+l0rh3tyCpODjdTPgIH1Bw2ttTwozf2wYZZd2v1S
         nrwbF8JmfaMh4WnjeEVJMWsrIvqRF5a8KfbhHIU9nBvkwKUVYy7YJRQBaYFxuOUsJ7nW
         +ESdqkbDhIxpsvrGDyLVg2U5p/SJo1uJzxBKkz6V/h8+8AzKoT9WefdLcEGWD2YxVYjB
         xvqw==
X-Gm-Message-State: AO0yUKXTiwlk3iWDV98Xvhf3K2Bu6JvhSuesaofQPS92ZTBJMRzDAfBw
        K+ndMstfwpEibVjM+GOupVWndh6LL+4=
X-Google-Smtp-Source: AK7set8Rrc02KvPFdCS4l4X14EmFf4AgetszjaWzRDGIAQH2zICTX1NPikw4LGlu2Pn9Ifgg6jzxPQ==
X-Received: by 2002:a05:600c:b87:b0:3e1:e149:b67b with SMTP id fl7-20020a05600c0b8700b003e1e149b67bmr5378381wmb.18.1676646212391;
        Fri, 17 Feb 2023 07:03:32 -0800 (PST)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hn30-20020a05600ca39e00b003db03725e86sm5287990wmb.8.2023.02.17.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:03:32 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] pwm: ab8500: Fix .apply() and implement .get_state()
Date:   Fri, 17 Feb 2023 16:03:27 +0100
Message-Id: <167664618723.3316127.12812885602209649459.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
References: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 18 Jan 2023 16:48:15 +0100, Uwe Kleine-König wrote:
> during review of my previous pwm-ab8500 patch I learned that there is a
> (somewhat) publically available reference manual. Reading in it showed
> that .apply() is still more broken that I assumed by just reading the
> code.
> 
> This series first fixes .apply() to not be off by a factor of ~3000 and
> then adds a .get_state() callback.
> 
> [...]

Applied, thanks!

[1/2] pwm: ab8500: Fix calculation of duty and period
      commit: 486dd4e846814016443abfcbfee0b8b3f3b35330
[2/2] pwm: ab8500: Implement .get_state()
      commit: 327437884e9a752ccbf759cbab641439ca708f5b

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
