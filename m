Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7E6F2451
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjD2KqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjD2KqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:46:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963972103;
        Sat, 29 Apr 2023 03:46:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504eccc8fc8so954383a12.2;
        Sat, 29 Apr 2023 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682765161; x=1685357161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF33tdMj9iVHCsjXUVoEa1ZEru2AhDHukTYWsA8encE=;
        b=GzY0hb9ZJ7kqcVA7IpKup7QloI+q7itlRzF8oDh4ZKLP+PVssTD1iBnizxj1qDsVZw
         DYy5JYtT3a4Kv/CEpAS1SwZKwtkgJfg1apgqRHbSqfUe9q2Rq4O8tGi8UZElslfhHPRp
         DFhGGo/MCEno4f8wRkQSyG5+sNBMBlpwkxk/AwE+oFJNm9NqrDO+aiJpCdkL15Rh9sI/
         MC9fzIb9h3xrA1GkQ682kgP8TVt0kIQCBZwS9NXsfRsaZa4pKPbyJEwyAGUYOwrphM9C
         mT0LEdpUXC9wLuN8A3VZG3tRFQ+xOZYfpHvdEFjjApyfZhe/vR1ZTFdLXZhQqlDU/MFb
         Agew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682765161; x=1685357161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF33tdMj9iVHCsjXUVoEa1ZEru2AhDHukTYWsA8encE=;
        b=NG+GG/3Di82OP5g+7oqHWHkf7jsz3w+FoRsSor7jmXbNS7tUiDgJeCMxT/lUJpQ3Tz
         MyhLkPh2gaRaDZfMvSIOaGWRsU/GocW+kkkWd4xGEkyrd3FN5XT3k07uUwF4ui6ZdGkR
         kK2VeKMOC0xByOe19pnsO7+rZykYVJwloqNuNV2n7dfqtNwdidKsM1KhpBTvTnMur7em
         Yq4a+Zl1HuRqBGn01gIP1KlUdJhK2kfPOl6beGAkd7AnTT3hlp3UH6buURZJQYBdk3sn
         5Kzio/u0aZBJ9UWrV3CVzEQyYV0eoET6LZ67WdzCyGuO8iIJ3zFKva4x5niViPkMvSZL
         wpng==
X-Gm-Message-State: AC+VfDx4+D6pOtDerDqk3lDxYmXKlRwXmJo53i7muWowRzKO6kYx/jzv
        fsBDU/RgRdCi/NrZNkOKhQw=
X-Google-Smtp-Source: ACHHUZ4htWkiNf32PrNqaTd4pbSLyAPiCrak2mmu7yE7zpf3xoPvebX7GQiQEr92CjDQD1rqMPYpfQ==
X-Received: by 2002:aa7:d641:0:b0:505:48c:3266 with SMTP id v1-20020aa7d641000000b00505048c3266mr1040474edr.20.1682765160956;
        Sat, 29 Apr 2023 03:46:00 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b004bd6e3ed196sm9952522edv.86.2023.04.29.03.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 03:46:00 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 4/4] arm64: dts: adapt to LP855X bindings changes
Date:   Sat, 29 Apr 2023 12:45:34 +0200
Message-Id: <20230429104534.28943-5-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230429104534.28943-1-aweber.kernel@gmail.com>
References: <20230429104534.28943-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
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

Change underscores in ROM node names to dashes, and remove deprecated
pwm-period property.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 38f4ff229bef..a6a58e51822d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -58,19 +58,17 @@ backlight: backlight@2c {
 			dev-ctrl = /bits/ 8 <0x80>;
 			init-brt = /bits/ 8 <0xff>;
 
-			pwm-period = <29334>;
-
 			pwms = <&pwm 0 29334>;
 			pwm-names = "lp8557";
 
 			/* boost frequency 1 MHz */
-			rom_13h {
+			rom-13h {
 				rom-addr = /bits/ 8 <0x13>;
 				rom-val = /bits/ 8 <0x01>;
 			};
 
 			/* 3 LED string */
-			rom_14h {
+			rom-14h {
 				rom-addr = /bits/ 8 <0x14>;
 				rom-val = /bits/ 8 <0x87>;
 			};
-- 
2.40.1

