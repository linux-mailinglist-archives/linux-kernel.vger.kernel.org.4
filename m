Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5E7203B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbjFBNtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFBNtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:49:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755B136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:49:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso20965235e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685713758; x=1688305758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8bnl8GQKoT6cwlD325NEGqoE59ixJfMqJHln/m0Cg4=;
        b=eyC+VMNvjOptGOgTy3U4OFJbTt6xWOHDjCabC5yB27fsk2QH50oXNro0SlTWPns0jT
         ZDx02HwzNB8dOK+3qicBybjCRdGSHIdOfxaAnZnYsUz7bFQlSOg86jtOIikz4ntYJG/B
         5qNOfCSsRMtrhBcQhGiTC99FKW0hDXMkZ+dR/y9zL4R5yRKNLdfbFqWUQlvmdJZjm+L3
         jKCEoyWxymKV3NewlctpoGnnAEElZ+MJUqVcE7QEGQbIyZTxVMQ72GhxN1IvwM8NuWXs
         skhEgm+AgONtaBqaA+XavrEF2zH8psnsBWXRtZeFNK1hLwW132sRjLhIDUJhRvDcNmtL
         dwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685713758; x=1688305758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8bnl8GQKoT6cwlD325NEGqoE59ixJfMqJHln/m0Cg4=;
        b=DIfpOjXY68YppuZ1tgO8hCbqUGQcfJuRVfsiRa0aSd3GNNkMluGrAAvWX+gZK11or+
         gGw3ck0nxA9wX7y6xHngxEfif74hR5NzDGo4+r5D0SGaUITCwmd/3XYqjVC7+rtJ4Qyc
         d18SrNU7fqrYQH555UWHdLrubJDdb+TyKfku3PU+C9aIPDUpD/X+SzqJCnDdcVGSTK6a
         FIdGtgF0C5nAPLahLP5sJG+ZquEu2kH9Q3K3esdX8K8HYZmqcbThZkq39XzSF24xXagz
         HFepw1RMcPXLVrzwapw92k7A1+EFha2Tw8Lqa1OgEeE/fg5pn58zuEYv1m1zD8ItAypG
         0RbA==
X-Gm-Message-State: AC+VfDznHo9WWuVu2RpGE2FTYXXD1LVFPLk0LauTBHEsbDOyORqTT425
        j0n2zeFe+QdV624OwT5uL0xVDibrYZb0+W5K2bZ8aQ==
X-Google-Smtp-Source: ACHHUZ5S/JA1hr5rSYxSnxg7uYsN2zZpSGqYIEPOQJaeEmxWuJhheGTMro5peQL6aYr6JcOsOeeO+w==
X-Received: by 2002:a05:600c:2903:b0:3f6:1bb:1dce with SMTP id i3-20020a05600c290300b003f601bb1dcemr2073697wmd.13.1685713757900;
        Fri, 02 Jun 2023 06:49:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6786000000b003078cd719ffsm1752941wru.95.2023.06.02.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:49:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     airlied@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     daniel@ffwll.ch, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230602091416.107850-1-yang.lee@linux.alibaba.com>
References: <20230602091416.107850-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] drm/meson: Remove unneeded semicolon
Message-Id: <168571375715.833434.17616843568511143973.b4-ty@linaro.org>
Date:   Fri, 02 Jun 2023 15:49:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 02 Jun 2023 17:14:16 +0800, Yang Li wrote:
> ./drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:117:2-3: Unneeded semicolon
> ./drivers/gpu/drm/meson/meson_dw_mipi_dsi.c:231:2-3: Unneeded semicolon
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: Remove unneeded semicolon
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e96f099c8544a542f7cd37d2e51ba52786adbbc7

-- 
Neil

