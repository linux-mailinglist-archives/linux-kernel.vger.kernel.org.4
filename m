Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417F363D98A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiK3Pfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiK3PfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:35:21 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A158FACF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:35:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t1so13462413wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ollth9LvKVA7JWRjE8biQu+3eEzKzMvsoDBYHMsXKH8=;
        b=w/kWhLywCOVt1ed+3YA9pU/z8cM8jEc/z1waVW5ddqCgYnadPaKJ3XiGpq2ojRRSZI
         k3JPbpX3DiHZAX7MpNfAClrB3vrWIzCLhQeU44l7ot0I0uaqE5ZwZhfaYzIJYZRyCzvx
         7NBbcC0wuLyWcF82sV9tinwj+rvg2nIx8jalQNuh5IBazTMW5yvqdlnYtwTVMXoBc+Ax
         evPplaYjb1yRdKvNBQFUuFvUB8qZJPB9SYA96FWd5eY6w2AGAlHoaULD0DDUJFvRiJQG
         p5uPVs8pvIpNmOld3CyHYWFjntGXefCxBq5i8/wxbjHu0nLVMjvfnI4nh53mhIvm+f20
         L5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ollth9LvKVA7JWRjE8biQu+3eEzKzMvsoDBYHMsXKH8=;
        b=2qdZ63/fvliSo+nRbMnRqvDXN/ocv94l9NRRg66i38AzJEEkybJoXCClCCzzOdXecp
         ISibTjmVPrtyI8h32MCpaIBfYoBLPAsHt8xw0dVq5QWYOPNvJeDqNpH9Ip/4whnR7VNv
         tUufJQVq2A4c/wzoGWDI7UbDqup4mwWP4+ff+XnaAYo5ko/ewAA/txmg110NeDZT4LU/
         mUlzwUBa9I3342KecqEAaaQwrXt/UJWCAc0Fj6eGeKDuFqepPVFD3HWF0XNEGtSqhIdi
         qlf/Ws3QO+/PXJwU9aP7j+oceLPRNtgIvMJB/YASdXTlpuB+xbs+KrpkrRsens5IPzxM
         r2WA==
X-Gm-Message-State: ANoB5plLxRcC8aAt9PNhaXoi8dR0Iil8Urhwqc8bBQgw8SOQ9Lpk76NZ
        Lj01hrnWcUfzy8fk/YJVrgEeZQ==
X-Google-Smtp-Source: AA0mqf4eK05an46lUSADsygGYj6YbeCIHWbWkSUKjAIYam5U7HNdVQYycIkts0qBNKwGV9Zw+Vloaw==
X-Received: by 2002:a05:600c:5010:b0:3cf:b067:416c with SMTP id n16-20020a05600c501000b003cfb067416cmr33797088wmr.134.1669822518964;
        Wed, 30 Nov 2022 07:35:18 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id h130-20020a1c2188000000b003b4fdbb6319sm5971128wmh.21.2022.11.30.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:35:18 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/3] dt-bindings: input/touchscreen: Add compatible
 for IST3038
In-Reply-To: <20221118182103.3405-2-linmengbo0689@protonmail.com>
References: <20221118182103.3405-1-linmengbo0689@protonmail.com>
 <20221118182103.3405-2-linmengbo0689@protonmail.com>
Date:   Wed, 30 Nov 2022 16:35:17 +0100
Message-ID: <87h6ygsbey.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 18:21, "Lin, Meng-Bo" <linmengbo0689@protonmail.com> wrote:

> From: Markuss Broks <markuss.broks@gmail.com>
>
> Imagis IST3038 is a variant (firmware?) of Imagis IST3038 IC,
> add the compatible for it to the IST3038C bindings.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> [Change from IST3038B to IST3038]
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> index e3a2b871e50c..a58c045d2ba1 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> @@ -18,6 +18,7 @@ properties:
>  
>    compatible:
>      enum:
> +      - imagis,ist3038
>        - imagis,ist3038c
>  
>    reg:
> -- 
> 2.30.2
