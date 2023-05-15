Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF06702A40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjEOKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbjEOKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:15:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB192103
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:15:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso18473226a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684145716; x=1686737716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1c+SeNkWf2A4Xiy160mQbs75FOVXhfG5tI3XlCflVaA=;
        b=PQwTnwoTVrZyBikP8ikwXMNrOZyEGhNIV6TDxPZ0tPMKDhZ9TlKLKEns2HT3GWbe7Y
         r4ue7zSIyi+RfBXq9N9rO3Ken/y2cj47300WnRY40LqaPg4DWX3wNQmYHgT5pBiKJZ10
         rhTAGaLF0sujPIkFpTnk7aixl0mwjRYU2XHH2TlHR0QHj/m+bNkH8VICLi69AtA6Hqnf
         Gwydt6YFyfkf3A6MPme8IpExZyB5GKkK2Ei7sMUbNlTXw1kB6cH5zRoadFrb7gRMANHf
         hKGg3wDSGj7xz3JwHQnATfAYgZ5MhCxScqnb9PQUqqtCby7JX+3A1OpdONGaHe6svqe1
         4UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684145716; x=1686737716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c+SeNkWf2A4Xiy160mQbs75FOVXhfG5tI3XlCflVaA=;
        b=dtxgMU/Ad6VZL57M1TszH8G0CtL/Ra6hyG4FBcdlGcmGVQzbN2geQjzLrzRgWF7LcU
         Ne1HozlPWKL/nUHFGnQ7zAEpoS4xVI11UyDHQJtsqeQhbJyEpHc0AtUMwHEb+NruE2ck
         M5v0loSFBA8jgR05Z95myZ33Kwv5w74sl3XJSNkjbyXsnW1UtxYLbFJu/ON8+4NbKM9g
         6t4dA6c2sGQFkwAyF5+I35LIzFLcrrYq/+LRFFv7YdCr6C6ik/eLHhzuBWjqZls3F6I7
         G2BmGU4tCWzxTDI3papn3nKnaMKiP+erzVsHlS6Kk5kF2TFg4NdUmIbjMoKFoCsXHzIF
         dsJg==
X-Gm-Message-State: AC+VfDx9CTQ7r+cFW25UP0AeHNEd1fKPu3ERH717CqRDNVLLkk3JKEU3
        mNJ3Nl+2hFFX8maFXSHQqg+LpQ==
X-Google-Smtp-Source: ACHHUZ6exVH9Slyi2MO0TG463pZshcSqmTjOAHj0jmECxl3Ck+ouTbXHTJL3uL9Dpv5RPnt4GvhClg==
X-Received: by 2002:a17:906:dc93:b0:965:d7c7:24cc with SMTP id cs19-20020a170906dc9300b00965d7c724ccmr33694648ejc.23.1684145716070;
        Mon, 15 May 2023 03:15:16 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906534200b0096b4c3489e6sm750834ejo.177.2023.05.15.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:15:15 -0700 (PDT)
Date:   Mon, 15 May 2023 12:15:13 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add microchip USB5807 HUB
Message-ID: <20230515101513.rr7i5wpajlhla27d@krzk-bin>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f4f6ec47-9e6b-4978-b229-53520227ed28@emailsignatures365.codetwo.com>
 <20230515062502.29273-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515062502.29273-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 08:25:01 +0200, Mike Looijmans wrote:
> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
> This driver resets the chip, optionally allows D+/D- lines to be
> swapped in the devicetree config, and then sends an ATTACH command to
> put the device in operational mode.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v2:
> Rename to microchip,usb5807.yaml
> Remove reset-gpios description
> Add maxItems
> Add vddXX-supply properties
> 
>  .../bindings/usb/microchip,usb5807.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.example.dtb: usb-hub@2d: swap-dx-lanes: size is 32, expected 8
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.yaml

See https://patchwork.ozlabs.org/patch/1781103

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
