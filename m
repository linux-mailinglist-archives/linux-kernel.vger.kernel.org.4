Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF273BAB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFWOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFWOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:51:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF9DE42;
        Fri, 23 Jun 2023 07:51:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so9128135e9.1;
        Fri, 23 Jun 2023 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531911; x=1690123911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hC4ep1+h59om4yauA1VwwcEbv3QwCe9F10dzdxhuHQU=;
        b=YfbjPq9z6gFIGNRuz+ReAScxPdPSebNU5HVlEND/mu2ZnwtAT604YYQLMJZFLx2/me
         SK4p0hat9LiqoaVhKfK09nhdZF7XF9yVboJKxXZ4ikk1380AxIvH3qtLelifgi9P7skV
         d5akFbBbrm23hp3IEg5TgsoothfdN6NG9ZUK+7jpP6Npy8DccrS7Jq1qgbF2rmVQAPdr
         kU7w7QGYgeusZuEOlhXL/a3jGJ5iSgSSh5HTeQO8JGVKITSpdlTaV7BYYbQIM5TbHfqZ
         AUy/G1KszZbSr1KrNv9wIUSsw3oyTGB1zYl+ux/Knn7C16EAE2QVBRYDpcTX9sI45ca0
         t9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531911; x=1690123911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC4ep1+h59om4yauA1VwwcEbv3QwCe9F10dzdxhuHQU=;
        b=WF5lLpl4lpG/BvYN4uaTsCKTKVwccCYn7bZYXmnPWTXRu0/QQpXWMtWosl2RY7vCzb
         lDdnAzTZ3pEagcQN2MVD8frVlQTE4l5xcAZjHRPVVjzZCKJL+TWYjdSFUjfgBg4d8r6l
         LuTO1Cr4Q5LQ7k2X4HHR0ZcgIOLRzhmdH4w+glTcyofoZIbMpPgV3XiahgKngMYZFCKZ
         ZeHTsT9ae5pqQXc8oV5SgOuhs+r1cvEevS0unuiGbNkh6foB1Iujk9WscIhMGTpINh/x
         L61wgMyR+pma9l/xpOJt201d8yiGMb0HbFaY1kD2hi2MRbCMYtalhMtMdQYGbg6Qob6A
         gEdA==
X-Gm-Message-State: AC+VfDylFuX50bR8ehHLIMNhyt7B2q3pXQNjamjf1aPrmwomDxHZNJC+
        dgx+VmUe+MBdxZ9S796NIT2Smvpnkkg=
X-Google-Smtp-Source: ACHHUZ6Dk4pM+se4xyfHwCmBYL3MyJh75PkWBKlN4YAmeSKs1UOdNhra3R0MVHuhaYCvWBw9i8QldQ==
X-Received: by 2002:a05:600c:cb:b0:3f9:b4a0:6061 with SMTP id u11-20020a05600c00cb00b003f9b4a06061mr3980562wmm.34.1687531911041;
        Fri, 23 Jun 2023 07:51:51 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c285300b003f8ec58995fsm2606046wmb.6.2023.06.23.07.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:50 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v3 0/2] Support PWM on MediaTek MT7981
Date:   Fri, 23 Jun 2023 16:51:34 +0200
Message-ID: <168753171954.1191890.17208643012944908213.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1682007088.git.daniel@makrotopia.org>
References: <cover.1682007088.git.daniel@makrotopia.org>
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


On Fri, 21 Apr 2023 00:22:20 +0100, Daniel Golle wrote:
> Add support for PWM on the MediaTek MT7981 to pwm-mediatek.c as well
> as new mediatek,mt7981-pwm compatible string to the existing bindings.
> 
> Changes since v2:
>  * improve commit message, adding that alphabetic order is restored
> 
> Changes since v1:
>  * use pointer to reg_offset instead of u8 reg_ver and if-else
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: pwm: mediatek: Add mediatek,mt7981 compatible
      commit: 88c66e018aa8b5a15d7fdba9908c01260c657bff
[2/2] pwm: mediatek: Add support for MT7981
      commit: 967da67a745fb73fd0fc7aa61fd197b76fceb273

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
