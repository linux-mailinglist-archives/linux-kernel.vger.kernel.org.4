Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C34C6D4D63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjDCQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjDCQS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:18:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6AE1722
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:18:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so119433921edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680538702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+/t8CyLe9nfcDqKwIQawjACJQBN8x/E4vP+2k7N+Eg=;
        b=YhpzdJTVjt1sqFg0V3bxZbRxGF/mmUwNEsRrp56tbIqpxVJmaaxtDJgJTaRjTZ6QDO
         fj7o0FD9aq/7FuaSuZjQFfpwYMY+GkTqythW6MM5faKdMRaBCvBQn6VAohwZ5DqqnCKL
         5Uhq7uIkdT3QSPPZgIvV579qBocUpf5sTTDpiluYJ6b1AmhYPP0xgL6njEIyLI96wVqm
         8I94x8gNn9wfUPcVVALldInOPjpn/f+m9+coV4A7gCe9WXRdjqtaEv/6o/DR+EQtJKi+
         AzD9VJitTCkbcghskyMmHpqtGHZ126ZQCGlJJp9qKGfsWpJx2kdBmwdhzt59NtZiwipQ
         cnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+/t8CyLe9nfcDqKwIQawjACJQBN8x/E4vP+2k7N+Eg=;
        b=g8jYtnRO86hFhU4OL759S77wOkUPSBPOQxZPeDoTCO6ZUPKuSURzvl6j8EaSAiz64a
         4qwg+cogheV3bCbibjjT/ugcvtYEsmu9TRUEv/XdiROxPTYGNbudOWWuggvP7+a9mHsW
         SOE2p41jXBA2tTiZgsdORzGYmexe35ehKrrhlzCdL4r8ZUV+tpIP9TW0AT0E1JtUcgOk
         0+YDqNCQvkydCODvkXpjwUeTZknyYObXzlkCeeJEc1ywNjFbN2fXTAqRJgS8XBVl3vbZ
         dyFRAf72NKNeb/awy783aErvyrgs05YVjZXOwQzphi302Zcr3TJpaoj5g4NsCRrkuOQx
         a/5w==
X-Gm-Message-State: AAQBX9c2K4VWq059vsCDXMIjK/DwBP22t6xEfUSQiTqM4J7r6zpwcS4F
        Oc1L9O7Pft0RL0jfC2H24/oSaw==
X-Google-Smtp-Source: AKy350aIeQbOIRRVUTKAxAF1kiU8gVIcRz/m8Z6zg5sP40aDrQXUxoB55vCsyEAaR8HjUQSPyTwgyw==
X-Received: by 2002:a17:906:612:b0:933:4d47:55b7 with SMTP id s18-20020a170906061200b009334d4755b7mr15075594ejb.2.1680538701840;
        Mon, 03 Apr 2023 09:18:21 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008f767c69421sm4758065ejc.44.2023.04.03.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:18:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     virag.david003@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        jenneron@protonmail.com, devicetree@vger.kernel.org,
        replicant@osuosl.org, ~postmarketos/upstreaming@lists.sr.ht,
        Henrik Grimler <henrik@grimler.se>,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, markuss.broks@gmail.com,
        alim.akhtar@samsung.com, robh+dt@kernel.org,
        martin.juecker@gmail.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 0/2] ARM: dts: add mmc aliases for Exynos devices
Date:   Mon,  3 Apr 2023 18:18:19 +0200
Message-Id: <168053869552.329664.8971511513108688025.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230402144724.17839-1-henrik@grimler.se>
References: <20230402144724.17839-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2023 16:47:22 +0200, Henrik Grimler wrote:
> It is convenient to have fixed mmcblk numbering of the eMMC and sdcard
> so that assigned numbers will not change from boot-to-boot or
> depending on if storage devices are actually attached or not.
> 
> Anton Bambura has done the work for the chromebooks while I have
> looked at the other devices.  On the chromebooks, mmc0 is used for
> eMMC and mmc1 for sdcard, while mmc0 is used for eMMC and mmc2 for
> sdcard on the other boards, simply because Anton and I had different
> preferences.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: exynos: replace mshc0 alias with mmc-ddr-1_8v property
      https://git.kernel.org/krzk/linux/c/37f9514e618f3b95125d7eda8991a7ae3b17da96
[2/2] ARM: dts: exynos: add mmc aliases
      https://git.kernel.org/krzk/linux/c/3ddba33dc270209868de79f695e5b27afa49e230

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
