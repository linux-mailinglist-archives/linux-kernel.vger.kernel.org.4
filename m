Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04176E4D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDQPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDQPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:30:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D464C649
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:29:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n43-20020a05600c502b00b003f17466a9c1so1416106wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681745359; x=1684337359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzwpePrDPa7xmr54v7b5JEOp+2Pd1xHJ2snEcb8e6Q0=;
        b=xXaSXGfkqHywUqrIdSTuJGAOS2HgJQOlGEp1vPBfWt4kLdPXwVzEKmVTiN95xLc4kP
         jt6uY5G34VADtXHyi41pUyd1eX/fc6ehmYIp8G78BwotiHlWZR+7CWP6uVcNWNIYpCnI
         TBOa0nvTTmubsOSWm1ztLzYuTRM1WEE07NSI+9pUT3575MnQJ6j5UIi66rZ9uuglOaqs
         AKTTIjohJAQLbVBhCleyYRR5n5kPNDtHpyK42IV0yJWNxdrY4psQR8lOZ72VvQKFr0OS
         VrmMhFF3n8sMibZpkqcTERyK6rD5GLa87TJxyqJbjLN92pHZ8fjEaBuvPGGCoPrNgij3
         rOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745359; x=1684337359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzwpePrDPa7xmr54v7b5JEOp+2Pd1xHJ2snEcb8e6Q0=;
        b=Eay55NcLt+eFJlbIQvYPHSfqkLNUk3WOJBx0GaxWAQURZuhE6w4PvwQXzF0UgHCPU9
         ifvijEdPdZp2Q4QYz6tn6Yvv+02fbo6bMcRtg1WI145+hCus1a/8n4DX6EbWqa1WsA4J
         d6IybDK76UdBTmXeryz12EKHnV8cgF0fbNVG6iSGo3Vk4Er41q0BmX+1uP4l/1gCGzUN
         NXqSP9wCl4GujuvUC8YhZCF74dXzMwRAktoAjD8jy/CRYrtUnre0c8T0d1xVL/UmGIQg
         Cz4KB2izSth0ONBNNcSBRn36ayJ+UJX3icCcB4V+Nt5Y90tlRNqM4pvEk6x3atJ93SmX
         YPqA==
X-Gm-Message-State: AAQBX9e2pkJBr3guXe4CSrM/+doVB/vNjXFADgmw8MeABok5yrTJn5BV
        2eBUoyVHf28KfpcLMXVG9PRQ9k5HIU1uXX7jcVDvsw==
X-Google-Smtp-Source: AKy350a8R3cCjE1wWQ446FxciFe8xGnzx9tik/JyEKMV1aebQPlDVAQwTU0a+LXIf1Hlno0IQpE1/Q==
X-Received: by 2002:a7b:ce14:0:b0:3f1:65de:764 with SMTP id m20-20020a7bce14000000b003f165de0764mr6377900wmc.32.1681745359638;
        Mon, 17 Apr 2023 08:29:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id jb17-20020a05600c54f100b003f17316ab46sm4097554wmb.13.2023.04.17.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:29:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v3-0-bcf9ba4de46f@linaro.org>
References: <20230412-topic-lenovopanel-v3-0-bcf9ba4de46f@linaro.org>
Subject: Re: [PATCH v3 0/4] Lenovo Tab P11 panel
Message-Id: <168174535878.1042404.157210995107973966.b4-ty@linaro.org>
Date:   Mon, 17 Apr 2023 17:29:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Apr 2023 16:39:02 +0200, Konrad Dybcio wrote:
> v2 -> v3:
> - Drop patch 1 (the one allowing port AND ports)
> - Pick up tags
> 
> v2: https://lore.kernel.org/r/20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org
> 
> v1 -> v2:
> - Remove dsi_info (unused for single DSI) [5/5]
> - Add backlight.scale [3/5]
> - pick up tags
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/4] dt-bindings: display: panel: nt36523: Add Lenovo J606F panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b4b26ab24f8f9ad3aa9fbdfd211e51b051ddb91e
[2/4] drm/panel: nt36523: Add DCS backlight support
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=aecb583cb997935fb4f4a667a8013469528a8d53
[3/4] drm/panel: nt36523: Get orientation from OF
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1eae88fa7b56b3b02d0e003a737fc31d71f3f486
[4/4] drm/panel: nt36523: Add Lenovo J606F panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=4f048de28b90abefff2044f450e882576eb746e9

-- 
Neil

