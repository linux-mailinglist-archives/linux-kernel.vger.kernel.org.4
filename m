Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BA62FA97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiKRQoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242259AbiKRQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:43:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477526EB5E;
        Fri, 18 Nov 2022 08:43:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so3215991pji.4;
        Fri, 18 Nov 2022 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCoTXso4ukr/aOj+PyBLVl50EP6vJzd3ZaoBL6gF4Ig=;
        b=dPoqJ3Y/oaNVTvWZsCHlXQBdtaybM++8iviOsWxK3/l9G1fysrlgKpeEGTFD1lN9Ic
         X+IvBJLgo7dld7CFvUQapUsATf14MwxAYiKYEsHQ3MT4+HfBuTG1ZUhcuU+7ZbbNIwjL
         tbsLwmFIp6r+ORJQRAbsEnK/+Z1jb81kSYLLfA0UaqX7C3APyp3czT7hAgrSxD2PAjBh
         /1dq5boT1In3A89LYTaHCCgPqmcEDOEDF2XUEWqLXaHlQkuKIk+TC4gfXwhMtGYwv4aH
         OkXJpOD7jCcmYIokR7IdRpUWuXVRX0evxNlkn+AWeWl9TaVNkKWbGtryz7HAuFNAlH2R
         qmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCoTXso4ukr/aOj+PyBLVl50EP6vJzd3ZaoBL6gF4Ig=;
        b=rTce/sT6I88oDa9dyUNQ63te3ihYgh2OdFXxWCKtTCfk2uXeI6HWsNhvKsJKxqG6n4
         T7kPG8qbYIWKTRZwyQIfngbldA6zENzX/biHxyOTKN/DLe6v5fFILf9o8GFIr/JUQgqd
         R+OTBonM1wQAjBp6RjVlAmssUkSSOK+ecIwvcDa1WrwTZ2XNphKAbFZzBvuEIlveTzZN
         zyOe0JXUGKa5+Ks/rEpXxjftUq/hrm0Yk2f93G6q2cntRtVhpq6LfFJ3sAIfQyiJR7IN
         BAhgGdjlDpQdHA1Fs/Z0xHZwuZHYgMP93Yhgz/oHW91cR8jVAJnD6hj2D5L77a3ZFSTw
         Fw0Q==
X-Gm-Message-State: ANoB5pnQ3ea1HhBKDxpyF487GS+i1P5pu0NaW8XW+QS2gu1WnagrvZJy
        GAdml0FIuCORpoEzPqCjb4A=
X-Google-Smtp-Source: AA0mqf6SgYNjINnOXfgTSDlQ9zLwcbpiKDFjMVTF2wBATfO0CoNe9plV1D3vCgGvOU1foQNFkKy/qQ==
X-Received: by 2002:a17:902:e94e:b0:186:5613:becf with SMTP id b14-20020a170902e94e00b001865613becfmr369558pll.46.1668789831601;
        Fri, 18 Nov 2022 08:43:51 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b0017f72a430adsm4011031plg.71.2022.11.18.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:43:50 -0800 (PST)
Date:   Fri, 18 Nov 2022 08:43:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: DTS: CI20: fix reset line polarity of the ethernet
 controller
Message-ID: <Y3e2Q9jeGotRlwqV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset line is called PWRST#, annotated as "active low" in the
binding documentation, and is driven low and then high by the driver to
reset the chip. However in device tree for CI20 board it was incorrectly
marked as "active high". Fix it.

Because (as far as I know) the ci20.dts is always built in the kernel I
elected not to also add a quirk to gpiolib to force the polarity there.

Fixes: db49ca38579d ("net: davicom: dm9000: switch to using gpiod API")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 37c46720c719..f38c39572a9e 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -438,7 +438,7 @@ dm9000@6 {
 		ingenic,nemc-tAW = <50>;
 		ingenic,nemc-tSTRV = <100>;
 
-		reset-gpios = <&gpf 12 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf 12 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&eth0_power>;
 
 		interrupt-parent = <&gpe>;
-- 
2.38.1.584.g0f3c55d4c2-goog


-- 
Dmitry
