Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE274CF52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGJIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGJIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:00:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A7FB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:00:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9936b3d0286so546845066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688976023; x=1691568023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgj45cMQ8fbHZJEPaedkT94SZAiskNOhiYOLw8ukyxY=;
        b=DtGN8JNRpbFFQLNli5r5OHgdaTMgJDXd4zVxngKE4WPBa6H8PRewdn2LdcBzrJVCpf
         6RKQrkIOuO23P0Gbpy//4xizqdb6BNl3oQgGKP6obZzC2PAbbGd7LNJwyshLpv3Gj7yw
         APQ0k2R3MLalmLZWetLumwP0/w756plGqiGy4qYRTd6MMVPBX+cbAv1/JKIECH59OlKq
         oAgaOvS3W/ylYtWuUlqOrEQGZlC2JQml/SWsQFyuPn92j4lhhzBaJNKzMaT1E9zEzhiy
         cU44l48j5sI4mazXZy4z+IU1UUQVUpdKcuFsCJ6cwSWgYN3JeGEbQPV5dAUXXLbRb7hz
         5xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688976023; x=1691568023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgj45cMQ8fbHZJEPaedkT94SZAiskNOhiYOLw8ukyxY=;
        b=hbuyTe/CZ6VLKZiCRUeA9agjetmL3+RIQLclc7rgRjCnItfHuu29rXvS5MkXFbe1XF
         evehAYV777lxcNjxGU87negxVqR1w2MlMzRGFf3R/SGDYj7SODQwkmwjwoe//Dwo3B04
         Gzr7Ur3prNPPwq/i0+cC5rzkte5yzSeK/5lfDXG+GM66TEvRQAAI/p5b/EFWCZtesrMZ
         kBJbIu23agSpNDJ7ESti3qqjqwYZi5iW/s8Ul0VosB14VH0MpGKYCGOE/+Thr6TQIf+D
         vW+Uv0I2OoWwSiXzOH6F6BHdzfteyK21n3pdo4PVIESPFJcr+tWEtiHbdTN9zPzzOVCy
         G/Og==
X-Gm-Message-State: ABy/qLaq+7nM6IiZ2PjdRPfivof5eJWe84TZeatXA63ulAVW3GLyLJLA
        d9RyKyWRbupY/qTgsZJca79WTA==
X-Google-Smtp-Source: APBJJlHCknvNzOQ/uNpwV+f9LgYPvw05rCyeOAKGA/OT6eFMR/EynTQE3BFh18+i+0NL/LSNCxwwCA==
X-Received: by 2002:a17:906:151:b0:994:673:8af6 with SMTP id 17-20020a170906015100b0099406738af6mr2057645ejh.29.1688976023448;
        Mon, 10 Jul 2023 01:00:23 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id br17-20020a170906d15100b009930c61dc0esm5819123ejb.92.2023.07.10.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:00:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/4] arm64: dts: exynos: minor whitespace cleanup around '='
Date:   Mon, 10 Jul 2023 10:00:18 +0200
Message-Id: <168897600949.19079.11019882842666346111.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
References: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 02 Jul 2023 20:50:09 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> 

Applied, thanks!

[1/4] arm64: dts: exynos: minor whitespace cleanup around '='
      https://git.kernel.org/krzk/linux/c/fc947ed0b294a18d712c9e94e54722442762f45f
[2/4] arm64: dts: fsd: minor whitespace cleanup around '='
      https://git.kernel.org/krzk/linux/c/e366be1a67b894d4d4732a26f027753db09a9805
[3/4] ARM: dts: exynos: minor whitespace cleanup around '='
      https://git.kernel.org/krzk/linux/c/cf19cc977b732942f265558f57f17e0dbd02d2a5
[4/4] ARM: dts: s5pv210: minor whitespace cleanup around '='
      https://git.kernel.org/krzk/linux/c/798bfb676ce436c4de73def56ac2f51dad116090

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
