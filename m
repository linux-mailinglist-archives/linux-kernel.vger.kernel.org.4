Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795D3690631
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBILLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBILKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:10:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78423C51
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:10:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id z13so1175295wmp.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WgvDq8izpGDGgZG/G1lE/XLQlEGXPYj1Wz0Qt9tGmU=;
        b=MhWHyPJGIXaSxsbjFgj67SzyssBvo4G9mgh272nqIhgw5vv4LCVzdz/+R6wX6mm8aN
         mAg1mUQFFb13A9wWYtBvQ+Gx/d1aGII/0dkxnmLymp6khXt3vYp1yrGMoe2F1T9g52IX
         P7j9ETg07RVQR6+qge3XVXwXJ3skIKMoDGco0+Xzo+SL9JmBNY3UfTTBmDf8VDJWiGmB
         ew/qS3F0oT/enovL1w0ibv3S0sxW/DjJgy2HpyfbCBFNrwqb+PcZxZcg12c5s3VCjvWx
         g2DQqFC+bKcNhrK6taU6JPsvaitVRTuCVOKppe+WuPxKyTNDyjVPwTKPuJOrY1mx9dgP
         0mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WgvDq8izpGDGgZG/G1lE/XLQlEGXPYj1Wz0Qt9tGmU=;
        b=C8dPCwoEYGmkNG2AoQ4+cV4rSYeqGcVQPVQOVZUXtWdyyWWT5Q/m8vGkdBYeV4TpCd
         YloEtjMQ1Jb+XIwK4RpgbZU5ZgjuF/9F85ZwplUTRJkFQEYtr2coZyfJwJ1xrCMrlaFb
         QyNToRcgp01ziBLMQqpBqQ7TMPCu8rTTbXiLZ9Hh2gPQuOAMOrY9ufHL+3pcuaWKroyi
         cJS4MHgQHBNKjMB+YpCSAKk+nTi4Hht/oFgz6glUCaF0oiC2Z09otC+gmjBMh76VZtEG
         hjHBKLOaFsKrSTiJ4C4vyEnkdkaXnP0xh+/K4L5vIXhB86+1CGO8FcKjVIMOk0Uc0IdD
         xd8w==
X-Gm-Message-State: AO0yUKVcau+ytzl1CmzBvRiof8Dy48FIc1jr4QOtcb196Tjujp6Vg9ql
        9ZjPhkxej2zNfthgIErVnGgVLHf7V9MVwh41
X-Google-Smtp-Source: AK7set8Gruv2WGMHN1T/zyEgxfFJbCMFrlNv7kLGkXH1/1Te/R6LXe8qHMwGjLyKvEy7wagU+c8nHw==
X-Received: by 2002:a05:600c:44d5:b0:3df:30c9:4865 with SMTP id f21-20020a05600c44d500b003df30c94865mr9411756wmo.26.1675941047805;
        Thu, 09 Feb 2023 03:10:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b002be099f78c0sm963207wrr.69.2023.02.09.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 03:10:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 5/7] ARM: dts: exynos: drop default status from I2C10 on Arndale
Date:   Thu,  9 Feb 2023 12:10:39 +0100
Message-Id: <167594102110.781687.18442933896252736402.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-5-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org> <20230207210020.677007-5-krzysztof.kozlowski@linaro.org>
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

On Tue, 7 Feb 2023 22:00:18 +0100, Krzysztof Kozlowski wrote:
> status=okay is by default for new nodes.
> 
> 

Applied, thanks!

[5/7] ARM: dts: exynos: drop default status from I2C10 on Arndale
      https://git.kernel.org/krzk/linux/c/4804e14912bd48db57f1aec0d41f6f92fe80c870

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
