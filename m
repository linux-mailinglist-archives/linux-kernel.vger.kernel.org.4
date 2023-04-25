Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A260D6EE11E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjDYLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDYLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:35:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64833C0A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:35:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so45329325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682422547; x=1685014547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwmJNsQVa3Vng8gKvvvDPoERcEJfaY5DKNCyYTI03Sc=;
        b=VX3fhbquFA6+uaUkxCbdF8qhQPGlJ3GsF8c9PdpI+h0WOsnjXM1RCXEf4tonNaw+D3
         NsWHe+JKhcv9o6BPzOGB9v/5MbzbG9WdTwpTki6gon8SzMH2vIc+K/zIH00jL3Xs82M1
         CqLj9oIl+wbJtPwnLB8XwDdCR3O7Pk28Cxyt5JdB6/11mqcld+V0rRJyeOScTPy/7i2A
         suB5tHBIi2HqGQP0tY/aG05fpcsfCg3MH3dwayJEhazdhahcPB7lx82j0tu7AOKoxOZ4
         1IXtdVKzR3QaB50SzMWtaEEw/T6/cGGHtOzhrM2f7J429vodm3n1O2W8CNPBLA3FNobU
         fi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682422547; x=1685014547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwmJNsQVa3Vng8gKvvvDPoERcEJfaY5DKNCyYTI03Sc=;
        b=OIaiDczmflRZJX9dpDOGVDG2b5InQ33I4ZFpbS6NZJTGN9sLEGil0trsugIA0l+05H
         iOM35VAa5WzCRqRU2F8NXe/AUd298K0tQaMkwAgDWF6j4T3RgSSOLelOlpEhi3pa75bZ
         xKJgJlLAajPAPSE5m5hviPfSUy4JoheFYOUIjQraVrz8Wo4EGR0ifIaXV5r0nXqBIKs0
         pR1xk8taXLR2IpA1caQ0+Oi3Rd2M0SEyVfuFn/r89duUDo/VtWWYv819E6S5v2Hg7iwY
         Sg8zo0smbASxgTEx07zIBWr9La09+hmioxR7GzFS4rVnu4tnbG6OByds5P9BKqOy29E4
         W0sA==
X-Gm-Message-State: AAQBX9e8UyCsDetQaNO37TBDNGPcGCoAfsRHy8LxNPmZ0FirIeszUli4
        /OlLHEmGtvhzw5s+ummJSdyU2ebJRX3y8djrzpc=
X-Google-Smtp-Source: AKy350YYSFveOR4ot4iXXTyDs7vO3lTymAmSY5PrZlIY90fzb4Alo+fO49znGJgXFo2VctM6yQ5kbg==
X-Received: by 2002:adf:ef51:0:b0:2f8:6c01:3bfc with SMTP id c17-20020adfef51000000b002f86c013bfcmr11572765wrp.30.1682422547195;
        Tue, 25 Apr 2023 04:35:47 -0700 (PDT)
Received: from [10.101.1.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z17-20020adfdf91000000b002d97529b3bbsm12825907wrl.96.2023.04.25.04.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 04:35:46 -0700 (PDT)
Message-ID: <5100ca4e-f3c4-b3a9-2379-aab6177d37cb@baylibre.com>
Date:   Tue, 25 Apr 2023 13:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] clk: mediatek: Enable all MT8192 clocks by default
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20230421111125.2397368-1-wenst@chromium.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230421111125.2397368-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 13:11, Chen-Yu Tsai wrote:
> Currently the base MT8192 clock drivers are enabled by default, but all
> the other clock drivers need to be enabled by hand. This is extremely
> confusing and inconvenient for end users. For the MT8192 platform to be
> useful, most if not all the clock drivers driving the hardware blocks
> need to be enabled.
> 
> Enable them by default whenever MT8192 base clock driver is enabled.
> 
> Signed-off-by: Chen-Yu Tsai<wenst@chromium.org>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre

