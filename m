Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823A6FF00E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjEKKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEKKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:42:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F52D45;
        Thu, 11 May 2023 03:42:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30644c18072so5637669f8f.2;
        Thu, 11 May 2023 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683801776; x=1686393776;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=PrLfI/6EF+lP+FmpMuOvP8uhLGdhvalpprKj2cFd/lA=;
        b=iQPaLyl/16gHXplnypDmmplXN8cK9AUkOoCh1217AYWB50gSLr5daJsYPcWDAVAs7w
         RWy1f7RPnZkr+xDDDhuNHYrgTeKqnIXTVwEW7Y74jPCSW90WrBzOh+DTy6xLyOfCD+3N
         y/dRrW4l+VwusPY7BDDgE08yQaWAxF5hHunkuGrrrQ4+jhNY+SkV8IFCBUeUuxY2euzu
         QO6h/kSlsOcDI4t+P7AV+0xVKBy35K+a0fv2wb8gRNRaZBxwMn5oY2aPQT2oOBU1Tbkt
         Ugi+N4Kn7IcaawyH/STzUmQ1hCEFzighxHukX1AyMWlSAnXDDo0uDRMZac1ib8e0vGZD
         auuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683801776; x=1686393776;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrLfI/6EF+lP+FmpMuOvP8uhLGdhvalpprKj2cFd/lA=;
        b=KINq495I6jE8pAJJefmq8bR4NNUqEfOtpUBk6SwALGUyTA7BNICFfD6eY4LCHKDJD7
         +gbJkUq/iOYSSLqLY7f6aahlof9rjmbc2Qte97abR4QZ0WoMZliw70E82n4TUfyxxMCV
         7DA/igP5/sNCGvlIhl3SlWXCydD1o3T4VS0l9I8OJzuL+hqit+PByhwxLbF2p7lK7J5z
         AVVdwmET7zNVWjmpFawtF1I0PdnPHaDizVSMYtTcNb58I46vA09dUFqSKyKLw4o0XCWh
         5h8Hma27HgYDES08xIpaR7Ggycp3ejj3hCK2ngyRWk29HlqOhGHFaqlRxAJdXYmmcNHt
         bgdg==
X-Gm-Message-State: AC+VfDw9Kexji8Uw1KKFQVmJ5ixgcXvI299SHKF0o4iVUNw95txO/sHX
        5itmyCqrns/Zw8pKh2c8aK5iJtCoVGE=
X-Google-Smtp-Source: ACHHUZ47rYP1ziytFCzBKE9uLcP9fev839NJloS4WCDCBjc6Jf1ncpn+PmAdYQmPZjV4fw3ayrmxNg==
X-Received: by 2002:adf:eac9:0:b0:2f7:c224:cd32 with SMTP id o9-20020adfeac9000000b002f7c224cd32mr15575438wrn.10.1683801775603;
        Thu, 11 May 2023 03:42:55 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm12591622wmj.45.2023.05.11.03.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:42:55 -0700 (PDT)
References: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
 <20230510112349.939991-3-aidanmacdonald.0x0@gmail.com>
 <7b3a37e8-0210-c539-5b5b-bf8e587707ea@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: ASoC: Add ESS ES9218P codec bindings
Date:   Thu, 11 May 2023 11:15:38 +0100
In-reply-to: <7b3a37e8-0210-c539-5b5b-bf8e587707ea@linaro.org>
Message-ID: <7Zga7RBqLNcaG5ylTIY4Qn7CUdE1IJsW@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 10/05/2023 13:23, Aidan MacDonald wrote:
>> ...
>> +  ess,max-clock-div:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Sets the maximum MCLK divider for generating the internal CLK.
>> +      CLK must be at least 20x the I2C bus speed or I2C transactions
>> +      will fail. The maximum divider should be chosen to ensure that
>> +      CLK will not fall below the limit.
>> +    enum:
>> +      - 1
>> +      - 2
>> +      - 4
>> +      - 8
>> +    default: 1
>
> Why do you need to customize it per board?
>

There's no generic API to read or change the bus speed (SCL frequency)
for I2C adapters, so it's impossible to calculate a limit on the MCLK
divider automatically.

Defaulting to 1 is always safe, but means wasting power at lower sample
rates. If you know what the bus speed is you can use a higher divider
limit to save power, and it has to be done at the board/firmware level
because that's the only place where the bus speed is known.

>> +
>> +  ess,oscillator-pad-bias:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Sets the oscillator pad drive bias. 0 - full bias, 15 - disabled.
>> +    minimum: 0
>> +    maximum: 15
>> +    default: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#sound-dai-cells"
>> +  - avdd-supply
>> +  - vcca-supply
>> +  - avcc3v3-supply
>> +  - avcc1v8-supply
>> +  - clocks
>> +  - clock-names
>> +  - reset-gpios
>> +
>> +additionalProperties: false
>
> Instead: unevaluatedProperties: false
>
>
>> +
>> +examples:
>
> Best regards,
> Krzysztof

Everything else agreed, I'll send v2 later today.

Regards,
Aidan
