Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1471078E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjEYIei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F671E44
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:33:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso1782950f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003634; x=1687595634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYOWcd2IcetwoVsS4nntw9yoShUHzHzbCdiQYPACYvQ=;
        b=eftV4gtcSYARUqlFtsn4ljUnFYv3T8UTXV/aDdPvA+L6DwHFRZQyFfnlc/dFvSbYxF
         GhTSOTNvMoBUt3XvdUgEoJelWAdOix5O7ZAuExkMvhz7kFNi2J0+jd3XUkirrA0rxbf4
         UWDurJFyvmawdR/1DbvGG4qaq7/b678OkY2ixXfM5miqoDlQyo6HAHnXNV98CSHW/qUI
         6a3Jzm6Ok94YnbGiBkSbjUxHZx53sP1lwwxEfUVWUQjwYya+JaJY2ub0icSDyytjYNuD
         wVeZY7zLFJvtZHz5udGWyLb576QwY0ekOnIsxGwD4b0KU4NHCB3h92gLHE8stPEWFq+U
         0yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003634; x=1687595634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYOWcd2IcetwoVsS4nntw9yoShUHzHzbCdiQYPACYvQ=;
        b=J68Lszu6mXDbZjfQzwrGOSdTElZoXoPJ+Dchf86xREZdZFCEX7C+8Ev3kStjIBQcu8
         3f/o77ZEkoGGVmW2iW9hNd8LiHYoUyCUiLTcEkCWHbivaLZDNqhtPJNFUxo9jrDmbwc8
         +gpl78JMNaPqCDIOLfMd2g5b0g6enmk4xuhDc5VP0ztoNXZ9OlpZ1qrcgXKp6qI9c5Vk
         jfcl49rBUTzFADdganQuaWaGb+rv+lT/uorhvZJJBEfwSJZWbu+I2OoI+o4aN/B7Uzr2
         Ekkl6N/EKVtmiagJpzHoxQIILzUxSfceHBT89CTPEZBuZWtT/guliMi5Tdq4BNSqzbjS
         oYdQ==
X-Gm-Message-State: AC+VfDwsFK3TdlEJ3suwdE+JntkAbZDsY1yqsHyIllKVRZMfR3W1N+az
        6zB1IHZUKy1k/kpjrf577gP2IMjGeQZJ8iaPLvY=
X-Google-Smtp-Source: ACHHUZ5bw3W4ft6+BDmBbOM2v/LDguqVSUO8lTNgiBRlWmWHzJKHOEUjQ921LscmcUFb0h3MjlNxmw==
X-Received: by 2002:a5d:6a90:0:b0:2f9:61b5:7796 with SMTP id s16-20020a5d6a90000000b002f961b57796mr1967724wru.29.1685003634518;
        Thu, 25 May 2023 01:33:54 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:33:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 10:33:10 +0200
Subject: [PATCH v8 01/10] arm64: defconfig: enable MT6357 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v8-1-7019f3fd0adf@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=WTUqVHBR4HvQxOd4r/5AfIRd2ez+/KjC4aOa4tZxgIk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1vfSiKtJv8aAT4IOZB7Xz43lWuQgoRCFuoC3/v
 0aNnrHmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURRAtEA
 C+Il5XUr1nBN5757SDW91yT55UdcKbq8nqrRwSxq7ytwJdRUxhm1slyroZBqq48WQQe4D3KIi6mA1p
 zNpyVVQLjZrZd4xQYncj5GgFQv4S6Tskc41gtVY354CqS5rqqqTYhvyuVeBKol3DFDYWvMPdH7LlLf
 lSbfVtLyqqwh9z8x48dXNtze3WOzDtgBuKwaICwEmTSIQe76pdU+ByiUJq3YgE04WOLBEQSnrdfUMH
 PtkE2ocy9gtv0FswLjQyjgWGgwXaC9ROdATOrpEkbnAhFAevGCQbiU30/jYN3N7gWOV7NBWel1xpHD
 XgOTBHbwYedJuCUxxPjEHNkupqWfbErhjDZzHbKub/pRW+v9+0TxXqbnI/kiuMK6OA3/NHag207Bpf
 ZWd6Egq0PqDrr2oRuHDv60AATm+t6iYKuUMb3NEXAkYGWMd5vOBTkOdAdZK5HnIMH4oCaNqSHST2q1
 cSBE7ZpyNDpvwcA4Qr4CdVgn4eiqbABOjyrVuB0bmqdhCL5AEmI84DeI/QJWMMZ5X1bKLKeEi+vFRa
 qhXMaDOJ+JhMb2LmOuZUvwf3585zfHNyyVvTrS5xLbIPalOMMqTIZPGHCDlI0frge3McO7DEf4IoaR
 3esu0i3iVMlAlNSJ8pv5r791MpK2I/3++4doJNxCsdcefHpy3/XZA9B4q88w==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the power regulator support of MediaTek MT6357 PMIC. This driver
supports the control of different power rails of device through
regulator interface.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..ed3fca298314 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -708,6 +708,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m
+CONFIG_REGULATOR_MT6357=y
 CONFIG_REGULATOR_MT6358=y
 CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6360=y

-- 
2.25.1

