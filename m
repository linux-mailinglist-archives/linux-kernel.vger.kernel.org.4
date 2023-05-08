Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724CA6FB5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjEHREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjEHRE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:04:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC66E8A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:04:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965a68abfd4so901902466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683565463; x=1686157463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi45PIje3d99S5Rhbns6y1+h7O43mda3i5nO+S6p1H8=;
        b=C5bVvfVTTkwp/ZJXnxiwbH4PHUU0pDhVHmDLkH8lqa6KEGbTk+vr/tm0AJsOgLSk1g
         Jy73g/xzP/3qSDjc1mG13tD7+ab8qY6mddp578yKaNlAYYhjuFFBa0p7V1LpM8cOV81U
         wGUOw1yttprXHYoJ+snmIMfGyr3JCNpLCuZ4TmdW5NAcxWN8OcJU/fjGW1o0WmtSPoFM
         Crotz147eD/0SeLULPtw9Up9bTlNhWaQrCxvUNaNFa5gauiXlFGB4K2ArC97+ESE3s9r
         EpqrD0Y/d5geTtpb5a3mfdYBabn74zcjOTlCzBFuvRCkhGJJ94CYnRudKjMozMYmajcS
         c3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565463; x=1686157463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi45PIje3d99S5Rhbns6y1+h7O43mda3i5nO+S6p1H8=;
        b=eruGMOkVVUEbJOkUxTJxbBJLCJJIwSYEsLFtMEbdYw77+/Nuz3f3QMm14UEvFKqOTE
         AndSpl9Qbt1vbPVMNsvJHxb+nyf25LtiNCBNk6JHZzKgtmpfx3jF6As6nm5sEyWosJPn
         lthpPt7Bd2D0n4xmt20x3y1xgGi4pKH9/6kiBe0+pXrh9TcvtUQHN+kSynaKCH0aX++p
         Vp3iLHXcZMvvA0VRVF5SYD6vZfKzK56XWyieEDDJkIOohiYffueeHLtr1mhNKfS/lqI9
         jn5OB4l0OpTEu2cQIfUYO8mlnwT3pgrPsDjNtAjWNM8hZ2wMaq9MEtgaCcXgWX4VTfyM
         KNKg==
X-Gm-Message-State: AC+VfDzDeoTH/DaqFctH49vzqTvOzLin3fCsqIItNa/P+3oslQhBc87C
        DJSpnCf+KD1x6YCDXHG2aBUmew==
X-Google-Smtp-Source: ACHHUZ7ZO6FpRVwpnLDi5avxkiSWWlpjq1OD70XpthViHbnyRXSTTAmzAkndGYmz2lrRBfAmX6D+oA==
X-Received: by 2002:a17:906:9c83:b0:94f:449e:75db with SMTP id fj3-20020a1709069c8300b0094f449e75dbmr10517083ejc.52.1683565463375;
        Mon, 08 May 2023 10:04:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id lh2-20020a170906f8c200b00965b7bf6aa5sm206862ejb.52.2023.05.08.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:04:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 2/7] ARM: dts: exynos: Remove empty camera pinctrl configuration in Universal C210
Date:   Mon,  8 May 2023 19:04:15 +0200
Message-Id: <168356544396.281925.178670933903097512.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-2-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org> <20230207210020.677007-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 22:00:15 +0100, Krzysztof Kozlowski wrote:
> The camera's pinctrl configuration is simply empty and not effective.
> Remove it to fix dtbs_check warning:
> 
>   arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: camera: pinctrl-0: True is not of type 'array'
> 
> 

Applied, thanks!

[2/7] ARM: dts: exynos: Remove empty camera pinctrl configuration in Universal C210
      https://git.kernel.org/krzk/linux/c/5f7255459587c5f0297eaa2dfb551f936789b082

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
