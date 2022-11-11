Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C40625D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiKKOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiKKOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:45:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487D27342A;
        Fri, 11 Nov 2022 06:44:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r14so7908647edc.7;
        Fri, 11 Nov 2022 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2JELu3fGxOmGVkXFeaA5505l4a1jidBqZD8y7rjuSU=;
        b=b80kxGzyFjuVt2eWN8RdQk5+0NuwtKPWjqUSXTc5WYzyaOpzmSNrMNy0GOL36yky+1
         ng87cTyWuvq/QWxswMcvQznMQUnr2vtZH41F5gC83Gyxsv410qy12vkzCdVK6d4JKxPJ
         oHgjHGv1pUNhRGUKAY88lWR76fsqnt1DFCZYnf+6Hv4Px+7b9sVxUbVht4cMxE0PI1cS
         wJFJ/WOUSskHlXGLiVNUk9b4kK53549crKkZzRuc/mrDXOXGYIc24IT7e2uBnhrK96yC
         on3ATboEwCtOA1Lm5GqQoMrnraGuGjZSGLLJzJWElx9PKQDpLyQKskMJmxl9fADRI2s5
         yjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2JELu3fGxOmGVkXFeaA5505l4a1jidBqZD8y7rjuSU=;
        b=BaNUT5o15PTDQGJ8ttp/kRWkh0+brls5Dge6sPhVfbXwb7PS8oMzbI7Q7XdPE7dVoe
         AamIBYGpAaDV+Zyxf4WPY27kE7E07eEWnViklLuMJiNrG0ee5hgXX6+MkT39F7wQ04h7
         HNPK2dXb4MGl1mUNhHyKHkDmbtyYD5v0PivheDiK0HZg3xp1fqzkWp/SEaxecpN8YqOK
         p6W15jTDLTh+UeGlc1f1Zvp5Wk2ok+UJ2X07soVH1eaYpH4V3MMlehP360/xHK7qGDt8
         8nHDchEusZbHvQ1IwZ14xwveI55yO6+xt71XfMWBE4CJcFn+x/92xbKqCpJ6heMwKcqM
         eF+Q==
X-Gm-Message-State: ANoB5plLRaTdKUu3g6CRuICPL2JZN3FJNTZND7/bohYgmmC39T2uEl69
        krTcnn3s0tGk4/DWln9Hk0E=
X-Google-Smtp-Source: AA0mqf6APIwDf/9nYycKA9AOhb4lIHvy+W14xqMDOq8PsbKJX1i4YgbyVJiYdjBSEicldwvSA5U5fA==
X-Received: by 2002:aa7:d38b:0:b0:467:71de:fe10 with SMTP id x11-20020aa7d38b000000b0046771defe10mr208586edq.63.1668177892262;
        Fri, 11 Nov 2022 06:44:52 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id iy6-20020a170907818600b0078de26f66b9sm943496ejc.114.2022.11.11.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:44:51 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/tegra: switch to using devm_fwnode_gpiod_get()
Date:   Fri, 11 Nov 2022 15:44:50 +0100
Message-Id: <166817787160.520183.17377804906951332813.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y2neBkfe6b+MzQGa@google.com>
References: <Y2neBkfe6b+MzQGa@google.com>
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

From: Thierry Reding <treding@nvidia.com>

On Mon, 7 Nov 2022 20:41:42 -0800, Dmitry Torokhov wrote:
> devm_gpiod_get_from_of_node() is going away and GPIO consumers should
> use generic device/firmware node APIs to fetch GPIOs assigned to them.
> Switch the driver to use devm_fwnode_gpiod_get() instead.
> 
> 

Applied, thanks!

[1/1] drm/tegra: switch to using devm_fwnode_gpiod_get()
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
