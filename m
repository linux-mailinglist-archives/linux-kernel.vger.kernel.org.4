Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E26FF660
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbjEKPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbjEKPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:46:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A07698;
        Thu, 11 May 2023 08:45:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-966400ee79aso1133728366b.0;
        Thu, 11 May 2023 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683819919; x=1686411919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xTtwDH0h6ZC1J+u5TGXBVnDx04bkJagkqS0GL4Cl9s=;
        b=HGke3Utl/C9TQvDOKgcVN/cyReg5F2qCx8t6WTH8Qc+hf7XbWQd35Qe5FwH0U09/dh
         jyFukCHufWfG2fn5a8bwTqWFmgNyzc4Pr4M+3g6CBmpK5rrn9kww4BVWEx5u2lkEqt6l
         6QWPYWVhavKoUtxJuUn2PfSM+oqJUSvHdzhV2pJ5hAJBpy/kaeGOQhau9sEOb6CHfVc9
         v6PaeKbgt6W3jvs3G3FL1w26svXavvy9mFa/iLO8fsL7nWhyEcTe/4S/D/C/07VFjvmb
         VO2ASpwK78Kmg3g79eMBzTI0TgtrfQ3xpqfv0wsFfK8aoi1CGaXxrmhzmRZIf9gUSmvO
         O54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683819919; x=1686411919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xTtwDH0h6ZC1J+u5TGXBVnDx04bkJagkqS0GL4Cl9s=;
        b=k0WroCSS9Oze3LF4oLvJsJc4VbYzvvuQFKLYsX7Lo8d4EQPJLicDiaKzt4KNvxthRf
         BmjwgwE1s2nzIN5uBsmbBhq3Ze6jjNiqColDHoYTcAE3y7badlwNwZsUzPzW6Wzf4Ehc
         i+pd566PvH2SwlqNI6CTqFkub18h00J2BcTXuyoI0hjSv1mBVo1SAeHTSS2gq4tBQnIO
         HwvX1HMspVAfN86D9G65n7NRBaOYpKa/YOg8MonOOunoDUU1mjfzviYBUoInSm53cvcl
         O1ViYj8+RwrEnoBRngKz1shXMor3CZsfJmpUJ63yORUR+rnFL9Mx68FUFHM7mbowLzzY
         lPuA==
X-Gm-Message-State: AC+VfDw88LyM46xOhP4/2wJnVclZtbZuckcUQ6sPAd0WGNEh5ocBg5fQ
        6G8fZHEFPxDhWsN6GJ6KYWQ=
X-Google-Smtp-Source: ACHHUZ44Zq76h9r+t5vJCRO5BA4NUFEYuovdWgA8hUG9a9O4KSb/P1SHOMJQ02KV6TwLWdNFjrqPRA==
X-Received: by 2002:a17:907:3e1b:b0:967:3963:dab8 with SMTP id hp27-20020a1709073e1b00b009673963dab8mr14005143ejc.7.1683819919012;
        Thu, 11 May 2023 08:45:19 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b0096a68648329sm900399ejb.214.2023.05.11.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:45:17 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ARM: dts: sun5i: Add port E pinmux settings for mmc2
Date:   Thu, 11 May 2023 17:45:16 +0200
Message-ID: <8259835.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <7949169f581cab37175602188f44bc26e79a45c0.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <7949169f581cab37175602188f44bc26e79a45c0.1683719613.git.noodles@earth.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 14:02:02 CEST je Jonathan McDowell napisal(a):
> These alternate pins for mmc2 are brought out to the 40 pin U14 header
> on the C.H.I.P and can be used to add an external MMC device with a 4
> bit interface. See
> 
> https://byteporter.com/ntc-chip-micro-sd-slot/
> 
> for further details on how.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


