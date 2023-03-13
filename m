Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD86B731E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCMJtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:48:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0A16893
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:48:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k25-20020a7bc419000000b003ed23114fa7so1754850wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678700937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HkyQXV8Sx9ZiihnRIEst2K2Pia3Osr/efAg4G6vW/d4=;
        b=YyIhi+qBKXeCniBQqYHNXvbSy+16jKMevR5pLkpADFaOLjyEDkhC1KEP/+/NtUNqLq
         WRtlKz6pUBPcjb4ZyHkYR+Zyfd5tzUnvH6LkYPU3ym7PxHURP+R2tVeHPQy2VivX91IT
         y1fpoowiLZ5AIV5uyXZQofz9T9bTRjLbAtZezcwoN0COtmR1SagwpWgKbSX7Uy0Y4arS
         ZrrAO5teJRJXswXBzMcBvdjWuTjdZy4iAzhhGImwEyt0elgs8DBIKVuZUNgkQQVkwcPY
         thb/JLkAv46ioNhodlfr0RgdHBKOennanVxscJu0TTFISuJgGIXZiyCXxRzFJLkzQ/jh
         kKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkyQXV8Sx9ZiihnRIEst2K2Pia3Osr/efAg4G6vW/d4=;
        b=zevxFlC/OOuMeXbuvApEdn9FU9tHD+4eHk4rNXIFF9gmqonAYtMMPmCD1AI0XUHltU
         WthxmvnkoQAQzYwppZSwebUqfuAoMAMlFhDpQnjYXCvFv58asjSXDzDlxR+ShagZAq+X
         vxCRYFSLF08qtux8QPF/SsiatB+H8009+2Rogiy3813U6qOfyZloCVAVQQY1WxNSNh76
         EKXiE4z7j/n8QVpxlT4e1CmbUSTW/2dsCKVDQ4b8TJpKo44nLthnr1uRAjaqfabHzO0z
         KwlScmB3qwwfyGlDYLgDDO09pP7i0VscLc45d1pqiL5abOZ5tpHvUsebJ2Y7UGsUpGel
         oGAg==
X-Gm-Message-State: AO0yUKUOohfPT6sseTX+/25tK///tFJs/PpySdKIdgHuydy7S5Ol+ACD
        DgDTkSAHD/bgLkeftMvyHmQ2+DfL728uwYlwQkXo4w==
X-Google-Smtp-Source: AK7set/o8hyLBzsXl3rkE65eXXSwq1sPMaL90pmRe5O2/veHyLmLBgHIUUgjnFdyrjDZ5pHpoAQCsg==
X-Received: by 2002:a05:600c:198a:b0:3e2:1368:e395 with SMTP id t10-20020a05600c198a00b003e21368e395mr10237994wmq.33.1678700937004;
        Mon, 13 Mar 2023 02:48:57 -0700 (PDT)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600c2f8100b003e2058a7109sm4732704wmn.14.2023.03.13.02.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:48:56 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:48:54 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: lp855x: mark OF related data as maybe
 unused
Message-ID: <20230313094854.GC55049@aspen.lan>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 06:35:55PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/video/backlight/lp855x_bl.c:551:34: error: ‘lp855x_dt_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
