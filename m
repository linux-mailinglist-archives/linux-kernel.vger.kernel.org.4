Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354DB62C876
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiKPS4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiKPSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:55:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8D2DC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:55:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v1so31413072wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxAP8S2Eu4aEYh0KAu5pbpoJ88gQVgQNW5XO5hPwero=;
        b=tvGSiAfx4PainO26BGO1nxFdvcGFcbyKcgu8TuDJ0dLPi34uBVQdeYUUvy4iyw0XYx
         seME3q8hMvIzlrnUzbRS7BbQtnV/ZSsB0BH+9koQVprpnSxwgskJmwlMGrOKgMwMiJss
         J7/rXvw+itJ6csMD8/1SeMAmVhpxuO8STSZ5RCPBKJwgp8iSDh482sVS30MFLz9Q7Z5c
         X+HL+Jd3XyplIaMp66NDMPd07RL5kePvPJGhzfI6qYPyI2goJnrsbFHV44teNLhuqAcZ
         fGNwpyLM7Qsy1imnMfmqPdDqhgpMto+o5dDBRhadXo8G6KcVzvJ7ubhXknntrjs/cT5m
         Wh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxAP8S2Eu4aEYh0KAu5pbpoJ88gQVgQNW5XO5hPwero=;
        b=A/BlQNHgYtbpfWEYaeM+3xjXZZ/kf4CTDtWwdKg98u8pQkiv5SKgds4LdXsQ7p8SCJ
         R8Z+kdtTef1O9kWntYuBnDSaoMNsp65dX8aEUJCMLmE51rkDtj+kb2OwNmYlRRUmOblv
         zck5tJ+rj/W0pTZQhu58A67JYY3foySQjjAPycAam0eVImlvq4dOEfSVO1XLU8II/YXb
         1a5yhoJY7Y/SbKm8XtPaaGm3yKh6roix9A2qPopm7zQwtQAivgzAm2ALtRPHH4HYO9NA
         +zNjcrS09Zfk5vdMAT1WjZ9HHoT65gnTZteT+MYGziXPK/b4kiNTOe7O+u4QC9Gj0PoP
         OJrA==
X-Gm-Message-State: ANoB5pnzxeMMThLNRP4BLwM9isXilsseBWXgRZyQIBzR+C3UF+iz4JBU
        wkYXoBSNNo3Lq100Io6K8XMr+A==
X-Google-Smtp-Source: AA0mqf7E+XMXGs7SLue0k8khFZllxMnqNgrqD1DYNanh2SGG9Ofr1dSYwpiFrQ7oiP5E2hYQ2PgDog==
X-Received: by 2002:adf:f80c:0:b0:236:5c7e:4b92 with SMTP id s12-20020adff80c000000b002365c7e4b92mr15209965wrp.72.1668624907708;
        Wed, 16 Nov 2022 10:55:07 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b002365730eae8sm15771280wrf.55.2022.11.16.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:55:07 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 0/2] irqchip: Kconfig: Add module support for TI inta/intr
Date:   Wed, 16 Nov 2022 19:54:58 +0100
Message-Id: <20221116185500.40431-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added module support for TI interrupt aggregator and interrupt router

Nicolas Frayer (2):
  irqchip: Kconfig: module build support for the TI interrupt router
    driver
  irqchip: Kconfig: Added module build support for the TI interrupt
    aggregator

 arch/arm64/Kconfig.platforms |  2 --
 drivers/irqchip/Kconfig      | 12 +++++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1

