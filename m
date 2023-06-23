Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808373BAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjFWOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjFWOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:51:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1594E7E;
        Fri, 23 Jun 2023 07:51:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d20548adso737801f8f.0;
        Fri, 23 Jun 2023 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531913; x=1690123913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJWtnTqZGQqiTeKl4r3aFL4RAd0yKamdEh9nm3JU/uE=;
        b=nZcAJ+sOqOwPNZAQ60lFA97QCbjofCc+XbSeSieNhhuKrWMtiE/O020aJCaGZig5Lf
         M+2Ra8MPpBVqUhcStWmEYd2ObUzA+kQ3K8H2ePAsYG1JWTf3WWXWaROYVC6t7QX+mx6J
         ESspbYNZ8OxGO/MfZaT0ORXOyftuTisX0q5bz1doEqX176Xd3AyztjKHNHN63UimszRn
         Dqv+xetGcZd2+R0LFeA2aONQHwXzUPMXk9dRWS8mqvQ8vpJvPrOKCvsRr9lGz/T5jW+G
         bbfDKveX+aL7d/d/Okx6QglyYu1YT1lUbE8K9aKT4exUm3nUwLqWGufz9RjrDc1FYimv
         EUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531913; x=1690123913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJWtnTqZGQqiTeKl4r3aFL4RAd0yKamdEh9nm3JU/uE=;
        b=WYehHfDU/yBusayWkcf6YXa5LybZix2sh2aedojwRd6UTW49XKK3KM/R1odeuyRhiW
         KVSNaUpOEbd+GAppbmuwVcLxCJv7YHDKBiC1C+2nNp2eQASghcc7YT5XGTcwOIRlzzMR
         ih+jHVUyJeZkPcW5NOYK5gpRaATIGg9DBK7PxG921nwwZa1+8blKle1G+jW/3y5p8QuP
         WckyEFqJOZWFMYq+w00HIYsuBobw4nl3xYPQuTkG3nBW8qoougT9Nc34CZXz1cLA47p4
         xU7t/kfO1NM8ZvolWkuUtcd8ynw5VqjEMOh+s9PSOpalyx0LfVTHaV3b4I1wjfaLewYH
         cTTg==
X-Gm-Message-State: AC+VfDw1Yjl4MOZLfZQvSd/xwd3Ajzn4dEsLmgP0xEgm0frbRjFqSypG
        C7fYJXqQZEj3yAAw3qgFCDY=
X-Google-Smtp-Source: ACHHUZ4EBaf4UIgKOYCqelucvQ5eoSxiLNvK3UwYGIN9g04VxMMagZ6W8cf/YKjEZ8A8mLc9ODWWzg==
X-Received: by 2002:a5d:5642:0:b0:311:13e6:6504 with SMTP id j2-20020a5d5642000000b0031113e66504mr14242204wrw.47.1687531913116;
        Fri, 23 Jun 2023 07:51:53 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b003113ccbf388sm9844475wrt.13.2023.06.23.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: (subset) [PATCH 0/7] dt-bindings: restrict node name suffixes
Date:   Fri, 23 Jun 2023 16:51:36 +0200
Message-ID: <168753171977.1191890.3520383079920452323.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 30 May 2023 16:48:44 +0200, Krzysztof Kozlowski wrote:
> Tree-wide cleanup of DTS node name suffixes "-N", e.g. "pwm-5", so we allow
> only decimal numbers.  In few cases narrow the pattern to also disallow
> multiple suffixes, e.g. "pwm-5-5".
> 
> No dependencies, can be applied by individual subsystems.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: pwm: restrict node name suffixes
      commit: 05b743db9d8cc4e51b3eb77889d24ab9aa2bf169

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
