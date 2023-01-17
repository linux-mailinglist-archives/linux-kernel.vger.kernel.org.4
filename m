Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DD066DC25
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjAQLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbjAQLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:18:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0834543
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:18:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r2so30208478wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F8FAq9VHh3X8R5TYntvycSxeEy9zUQAgESTqIenWBs=;
        b=M5VfcbtCsw01lCDWxI/FmN1NwPgHEaGl0oYAzM601jiZEYylOMcXYVVJhuUhmk7pjG
         QBt89h3Ns9mtXc7L+NCZzXAY7XD7Vm64GAqJJttlTNlrLiovRqG3Ymy/OnUXp05uJ0HJ
         78Kxu/Rogv1S2Ptj4YH6pdStOrJEYUSqy0EAyb106MQ+skNCOfQYNeuzAhJuz7JeiY/d
         GTDetXITOHiRaUSunYV684bH3dfhrlthbtzSQ/w6SGiJGZontYwMDMYTN2agesepRCY0
         X+pzAW8mUHHHYgxNoFE7KR/mKsmmti9I3bDqSn3KTQypJ+KiiOh3IOM6Nv/WQepZuDvl
         fHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F8FAq9VHh3X8R5TYntvycSxeEy9zUQAgESTqIenWBs=;
        b=Y5Srcs4u5oVNl4zSyaKQPK3Wr29wdcZRkLsEqUcstjzm5XVzsAuAd+ReIL3rupS+Ej
         wbVu4x+jhFHwpi5H5ZdUsvpCMFz0eVRn5BpgRWOgtQH7yeghBNwbBkO8YmujhFvr+fbn
         1nqp7wXamuFHiL8XOlqGxItzqPJS7wOWbV2RdCn0kngoIRbjrlrPgZZaksQFLwS8iek9
         KfbjmSAqcuE1Z7gUsdTwWLJ+BtqKSK6dNdMVvyqLN1vkZWjtk6WHkQ2LwgSCqOMOYZJb
         DgziKd1DJyUNdQEGEOGq3UflNIXrBMI0j4iGBKlgKdU/2tbY1PndtBWdLZ1MetSb534/
         FbvA==
X-Gm-Message-State: AFqh2ko7pfw3ARVPdnfR6hkv3c44paGTk6YjmIxSS+iAOv37m0Wtj7hi
        THLT4dQKWAJHTIB7ymNfkBAyAw==
X-Google-Smtp-Source: AMrXdXtuMwXDTKjRMyG4UHHCTHIY3tjmlqLwu/1pei9KsF5NZ+G3lpmedGWKLrTweXTxfyPz75A61w==
X-Received: by 2002:a5d:6505:0:b0:2bd:dba2:c17e with SMTP id x5-20020a5d6505000000b002bddba2c17emr2414593wru.12.1673954288574;
        Tue, 17 Jan 2023 03:18:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm28466717wrp.74.2023.01.17.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:18:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        rcsekar@samsung.com, alim.akhtar@samsung.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, aswani.reddy@samsung.com,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        pankaj.dubey@samsung.com, tiwai@suse.com, broonie@kernel.org,
        perex@perex.cz
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 3/5] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Date:   Tue, 17 Jan 2023 12:18:01 +0100
Message-Id: <167395418605.64421.15917174672513679108.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116103823.90757-4-p.rajanbabu@samsung.com>
References: <20230116103823.90757-1-p.rajanbabu@samsung.com> <CGME20230116103903epcas5p2c3e87c1df31b6a53e26fb1358a53f634@epcas5p2.samsung.com> <20230116103823.90757-4-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:08:21 +0530, Padmanabhan Rajanbabu wrote:
> Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla
> FSD platform.
> 
> FSD SoC has 2 I2S instances driving stereo channel I2S audio playback
> and capture with external DMA support.
> 
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
      https://git.kernel.org/krzk/linux/c/7f62af80dc62b82bc18f72c674e4c81c5ecbfe37

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
