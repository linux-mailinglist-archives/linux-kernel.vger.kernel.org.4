Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B996B67781D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjAWKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAWKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:01:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A474C0A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so8521802wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBW99nl/bxZsTE1SNWWJvTeEp3Nq/6dlA/kis96/OGU=;
        b=utTGrb/3fg+7tKVMVMXYVYrKAKW0FRoIeNF1MdJG1DSB4hTuxJ8tO7TdOM/KYj+eOq
         bt/gt2WC4QzDAwlOF8pO67FEmmCVTM0E11nD0utz17Q7jayfIAFYJidKi7PvN5vLOFP3
         +T2o9zBcZxSXF/rfoFcLfATPe5gOxlm75dbV+OuFQ5juOAjCfsTqubQaFs3n4G/qEWsU
         r4+obCpbDN+8CqWZ6VTOpxONRmVYLi7+xeBjKwM0KA8MnI+K7gmebwDLmERjOUUoHQ/E
         OBgepXJLV48Gmwrtw/nvsWWzlqFoRkbs9woizoq3yAj1lCDmXhFr3ByqDdEFauk5V8LV
         xn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBW99nl/bxZsTE1SNWWJvTeEp3Nq/6dlA/kis96/OGU=;
        b=PZcrXNwSsIzhzGExcXNkzWONN5IEi4OBPMMK0j01vWuoDKC8jb6geidnfbeAzrdzIb
         y+BBDgP1pk1HKEAWGXB2cbjNnAEuIEiHMJJr7+R8J8YQCpCvEwXO+zURJxUhhGWIWuwF
         IJzPobq41Pm9FDsSe44WyXa4+pUWCMBQjF0xxAWi8kJSc1MMSv+vSorulZe0tBfQx4H8
         hMtONhVH045yjcxn9Cb3b/egK1cqpZhcda26R1t2JJ1D4XcP5zeUliW/7VauMep5U5+f
         GkvmOzPnHot/2VIV81QwHrChgZ00SB4VzJPFgFf9Aju2R+wQ3IRJlY3LH9v5Zdv8AGm4
         BiiQ==
X-Gm-Message-State: AFqh2kqDvgYlUidKkPvvDgWdYFE447K+1KJ/4IT1ajlUSwsLxsq7xgGl
        YhZgXj4rrbhbHx+JIo+gyEmUmg==
X-Google-Smtp-Source: AMrXdXtTrVcaPCCBSgFX/j5Ycf6bevTbzhzytfwtX7u/nET/Yox0ixtMdIVw19MyyI5EXWgbe2l5GQ==
X-Received: by 2002:a05:600c:3545:b0:3c6:e60f:3f4a with SMTP id i5-20020a05600c354500b003c6e60f3f4amr23476158wmq.1.1674468105235;
        Mon, 23 Jan 2023 02:01:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm11050831wmq.28.2023.01.23.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:01:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kukjin Kim <kgene@kernel.org>, Inki Dae <inki.dae@samsung.com>
Cc:     phone-devel@vger.kernel.org, Henrik Grimler <henrik@grimler.se>,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org
Subject: Re: [PATCH 00/11] ARM: dts: exynos: DT schema fixes
Date:   Mon, 23 Jan 2023 11:01:37 +0100
Message-Id: <167446806832.57213.6257020240038382720.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 16:53:53 +0100, Krzysztof Kozlowski wrote:
> With this set of fixes (and few other earlier), all Exynos ARMv7 boards
> successfully pass DT Schema checks! All! Hurray!
> 
> Please kindly test if I did not break any boards...
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[01/11] ARM: dts: exynos: correct wr-active property in Exynos3250 Rinato
        https://git.kernel.org/krzk/linux/c/d15d2a617499882971ddb773a583015bf36fa492
[02/11] ARM: dts: exynos: drop unsupported desc-num in Exynos3250
        https://git.kernel.org/krzk/linux/c/49434cd203ed3af220145f2e5e5791339dac347a
[03/11] ARM: dts: exynos: correct cd-gpios property in Exynos4412 Itop Elite
        https://git.kernel.org/krzk/linux/c/78b93ffef4ad1800f884e4892c1bd79ca5512cba
[04/11] ARM: dts: exynos: align pin node names in Exynos4412
        https://git.kernel.org/krzk/linux/c/f370a3d0fd16cd260248c387cc085dcb8a6d32b2
[05/11] ARM: dts: exynos: add ports in HDMI bridge in Exynos4412 Midas
        https://git.kernel.org/krzk/linux/c/74ac07e485bb01e232c7f3d67632ffc9b64604aa
[06/11] ARM: dts: exynos: add panel supply in Tiny4412
        https://git.kernel.org/krzk/linux/c/c2387ee9a318dfb7cb5a7a210e2825c62d4932cc
[07/11] ARM: dts: exynos: add backlight supply in P4 Note
        https://git.kernel.org/krzk/linux/c/f845ae570231bcaa677df65af620896fdf3c5705
[08/11] ARM: dts: exynos: align HSOTG/USB node names
        https://git.kernel.org/krzk/linux/c/eeb0fd23bc0fc823032dd2a2df22651ce8369aed
[09/11] ARM: dts: exynos: correct SATA clocks in Exynos5250
        https://git.kernel.org/krzk/linux/c/712c852a7b0dc0ac66fa6b89997f4f952483a5e4
[10/11] ARM: dts: exynos: correct HS200 property in Exynos5260
        https://git.kernel.org/krzk/linux/c/865b7ea364f892a3de7838eec04628efb945939e
[11/11] ARM: dts: exynos: correct HSI2C properties in Exynos5410 Odroid XU
        https://git.kernel.org/krzk/linux/c/5dd60c69047ee3fd92a9f64b28377f4819536d2f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
