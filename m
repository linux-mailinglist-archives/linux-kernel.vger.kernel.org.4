Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532B873BAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFWOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjFWOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:52:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53946273E;
        Fri, 23 Jun 2023 07:52:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so7341735e9.1;
        Fri, 23 Jun 2023 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531925; x=1690123925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3keFXyYxAjQYtSZa6MYtEortI8BrTUPT1JTwkzq5vU=;
        b=V/C/eQtE7bkb3qRA18sldaife0yyK3/9rF2RuIMXV5U1f8na7mIjDXCldVpaBbaqNX
         RTYx3naOUEX3CobqEzScq+3kq3/8jkiEilQFwIgzmS22QYac9ygwXSeb+/ZSFKPk/yIq
         Q+f4U5IQZweGwZmjwmv992My8vdQQG5ewoEOJLOcIjdZeHSzoOmRCgUaCACVaJvmmagV
         ZaOC2g/OJUGyMYsNyHGef6SOzUq1qvfGMQOCp04IxVzi4hyvo9uoA14M9MBx038r3sne
         NxXOQzS1NC65IWUJtwzfRGBh8a5WGhmyGSvle9+vQMJIhd16QsjhqBTyApsvk05mS9xV
         ge/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531925; x=1690123925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3keFXyYxAjQYtSZa6MYtEortI8BrTUPT1JTwkzq5vU=;
        b=IdxJI92wDa3d+BlYs7fsc0FMHBUcNapO30duU2E0IYJondcHSH1QqiQydj8umkgv5t
         dDtUJHu6/mf2X/SEOaNCZtHCN8nG/5lZ1PI2qhgQ1KixzmRdVB3OeCzy0qedJ+LWdTbC
         WR6obdT3dvUjBKAfMdGrrt9WZ1DT/8VtQw0jYG03iPVI8EDnLPl+HU2hX3KXFHhdM6XT
         COJp27rV0yMC0IEkwJ6Wyp59BqMrhd0Oxavjh6TmmtPTSD8X3xC6iYaLwfe6HJGLMv+W
         j+f9uC24BUOT4YqvBtL26YxaAbupUl7ewJuMeGsuov4FVncDyBY55jN5jwssYeNfqlNy
         Rf5Q==
X-Gm-Message-State: AC+VfDxKltR+ju0p3OcAhtis0mNM6EGUXyo/lhDMdWqzPdpIuTE8x+mX
        HqkYRcfxc1QMQ6Oqkx2n3RjzD9krLTY=
X-Google-Smtp-Source: ACHHUZ4s7ag/+YAr5I+URwo1+sTL7+qmBGPPj8zPPmPW079qM6s3NeI17ljypQKQztEiAX4gcbAGaA==
X-Received: by 2002:a05:600c:3b97:b0:3f9:b535:381a with SMTP id n23-20020a05600c3b9700b003f9b535381amr11838348wms.10.1687531925110;
        Fri, 23 Jun 2023 07:52:05 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c285300b003f8ec58995fsm2606614wmb.6.2023.06.23.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:52:04 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-pwm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: Add R-Car V3U device tree bindings
Date:   Fri, 23 Jun 2023 16:51:42 +0200
Message-ID: <168753171960.1191890.8754582983989632537.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
References: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 02 May 2023 18:53:29 +0200, Wolfram Sang wrote:
> 


Applied, thanks!

[1/1] dt-bindings: pwm: Add R-Car V3U device tree bindings
      commit: 5442c33f218b1aabbe699db978e407317a231d10

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
