Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B26F427F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjEBLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjEBLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:17:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E471BFC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:17:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so36316765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683026241; x=1685618241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hC5rYIWvK/tkRAoPAEF5edYxUmmDzm+5+7yR1xwhyX0=;
        b=dxhKeusNbXgpsiW1CpqtUWcJK9plsg0Ezqx8fKwR0zapkU8N3hAGXDFmSDhCiB6w46
         XVdt76X/wBAfL5WxSmINEmhZ3rxgkeXQdM+wozMGQQQBDpYr7R9h6cj+zRwJH/5cBbWR
         cRo/jwT083+CMmIMSImONFUnlHgocMCxXlNgI45kpy/JicSeJPaDEhV97la20RnohU5f
         Xt5hCpW4cF9//AvzGDbxn+p3xgGFMEYbGxMk8QvpBflWwvQn7BI2Arxol3s5E2WleiZ9
         qlLwtugL5TMWQ59Xj4RxXRWRaXxFj1RM6JOFjfXBE/cEuW8F9chZ1nuBm9YYFFHqIP5u
         EAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026241; x=1685618241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC5rYIWvK/tkRAoPAEF5edYxUmmDzm+5+7yR1xwhyX0=;
        b=f8oU7qUnFYzXfdIKB4BjuZ0Tyuc8CGhGJe+cqD5mln3PohsjafPzrvR0aWKyhTmpCY
         rQcSriUmRkFBmHxJko2pGdwqoZ7gIi7gni0HqsyLwpTihVIVq/ABycUBwBx4vH57TLc6
         rmWRiZrxpjadoieLkL3Ofxv2Vy9clf/sOV9MQoxnZdAUqvIxceM8iCmoXEAJAbTEDw6K
         LJFENx8oP2hpxlgab1k9UxDFRuVDeYDE0fi+fp2KETqLCO3Mo1/y79ciTjYbU2U9rT6t
         wDCAK2l4+MvfFdwf0XhHCsQAnNdNYb0SUto21vm+nNnG6St2vJwopootri1jFfr5F7iN
         +e7w==
X-Gm-Message-State: AC+VfDzgyAjWHU+BwV7lt2ig8lmxWtKmferEWBUNJv6c0HIHsfK9fpLu
        CEdJNSdEGbmHcjg7cCR2If4DRQ==
X-Google-Smtp-Source: ACHHUZ5zpyqpXr+mFRT0QdK4GBZ6IFbr+l3lnDvYTS2KPabZ8s1ZjpQNTuYHyGo+UuIIUaf8/iI6jw==
X-Received: by 2002:a1c:f019:0:b0:3f0:49b5:f0ce with SMTP id a25-20020a1cf019000000b003f049b5f0cemr11338031wmb.12.1683026241502;
        Tue, 02 May 2023 04:17:21 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c365500b003f182a10106sm35223317wmq.8.2023.05.02.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:17:21 -0700 (PDT)
Date:   Tue, 2 May 2023 12:17:18 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: backlight: ktz8866: Add reg property
 and update example
Message-ID: <20230502111718.GB15678@aspen.lan>
References: <20230428160246.16982-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428160246.16982-1-lujianhua000@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 12:02:46AM +0800, Jianhua Lu wrote:
> The kinetic,ktz8866 is a I2C driver, so add the missing reg property.
> And update example to make it clear.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
