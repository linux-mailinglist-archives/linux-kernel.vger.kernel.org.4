Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88B65689C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiL0I7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0I7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:59:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEF064EF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g13so18771357lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbR8qz6wS5XA+MVJzbHXZiK+aUgwbKxaugtwRJh61nQ=;
        b=o52vghbuY6ZVpBuLjQdn6P4QMVd7TA4V1br63TkBl8psvVrOeaDF0pdkAwZyIXgUld
         AV+JoYEITtQ28ZArVk1Nq6yIOy2xU36pbynODzYSoHH/GQEZUsQDV0CNbLG++M04fCRt
         kpnNET5MN8/gcKnqqdeHjApZ2HrWkCqBK4eq5klnYYMEP5zOoOIG9kC76W0s/Jt9D2rx
         AIV47YM/XqFyQtlzxiWECRUBtdjvnAvSv2JNCLH39XksPBhnnOlItssNBEUSLShC/rRc
         lpE1LXtWTyxUhlXSFrFoBbKY6vz/kLbCoUB6dliOdQBxfcIEu1niffKOuZjlc0/7Xrcb
         BirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbR8qz6wS5XA+MVJzbHXZiK+aUgwbKxaugtwRJh61nQ=;
        b=G9xpYS4WH/tliGogdrx4KohBgg1TA+TMWNivDnCJEBBP6HtxQXKSAFLg3tIlbrItCi
         94gHoFRgys2UtORMsjF0yw2ni026JBJ+4TMF9HyWjZQV3Y9DVz7I1bTMY6B5smy32bAX
         2iGYD4lEOxG4x8094zVeB9XO/1oFLpbOjxSHHqXFXiDMEL13p2/Rm5maqSIKY6CQ1u/6
         vYWnVPMnuhor+w2lNv8NgamVojgWzov1Osl3ZjX0kDngcS+jGlZdYlWK/yATGj+9S5cw
         c1pFYhK9Zo7dUKxVv0XWHKIxSJTYvCQmcaTUanQBhU9vQpt4pT4M+i/qLig1kMRXHsjd
         BnUw==
X-Gm-Message-State: AFqh2krT3vbUGIqFpsrw8QTzaxweUR8TdijG+e/aoW4og6+rhbnUBgZ3
        zyolYv567bbItWwE+rmfcWIUTw==
X-Google-Smtp-Source: AMrXdXtmwYb/vfjV0n06AV71LnhqbJo+oD3VpkcZlnWm+laFIrNwnQ1dYolp1pN76NwJ2oNCpcU/dA==
X-Received: by 2002:ac2:598f:0:b0:4cb:df5:92a6 with SMTP id w15-20020ac2598f000000b004cb0df592a6mr779565lfn.30.1672131588704;
        Tue, 27 Dec 2022 00:59:48 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026bf0d71b1esm1534837ljp.93.2022.12.27.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 00:59:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     dmitry.osipenko@collabora.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [Patch V3] memory: tegra: Remove clients SID override programming
Date:   Tue, 27 Dec 2022 09:59:40 +0100
Message-Id: <167213158105.15520.15913236649862406836.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125040752.12627-1-amhetre@nvidia.com>
References: <20221125040752.12627-1-amhetre@nvidia.com>
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

On Fri, 25 Nov 2022 09:37:52 +0530, Ashish Mhetre wrote:
> On newer Tegra releases, early boot SID override programming and SID
> override programming during resume is handled by bootloader.
> In the function tegra186_mc_program_sid() which is getting removed, SID
> override register of all clients is written without checking if secure
> firmware has allowed write on it or not. If write is disabled by secure
> firmware then it can lead to errors coming from secure firmware and hang
> in kernel boot.
> Also, SID override is programmed on-demand during probe_finalize() call
> of IOMMU which is done in tegra186_mc_client_sid_override() in this same
> file. This function does it correctly by checking if write is permitted
> on SID override register. It also checks if SID override register is
> already written with correct value and skips re-writing it in that case.
> 
> [...]

Applied, thanks!

[1/1] memory: tegra: Remove clients SID override programming
      https://git.kernel.org/krzk/linux-mem-ctrl/c/ef86b2c2807f41c045e5534d8513a8b83f63bc39

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
