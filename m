Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0176967A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjBNPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBNPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:10:16 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069B1A4A4;
        Tue, 14 Feb 2023 07:10:14 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso4730653otq.9;
        Tue, 14 Feb 2023 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6mohSiJsKKJ6AZ10l+E81NnHMmEZM3vAl6O1sHdJCQ=;
        b=JI2qS/w6WtGHJMSFVBoUgef5V8Qcl1fUxS7fWI7t2XsIhAMl9BAa81iw5CQ1h/kDz+
         oaU0agLdXAmbIfSywjaiePW4nY6vXDJD5Zaf+tk9UgzfBU6w+CGB2JENpQqDZpvYcob1
         5Ll1g7SHhPRMt7cMlT7DGjIX2uW/bpRwtnZTknxdo5DUKYwofjXHrj0S/oNo2pLR7HAD
         pBvtda2qgcJZ7GkgWDkkBsSHvPJDNHMhxSLglC8mDJEqkOZP9tW6P7vtLYztCktaYckh
         Uoiun+Y6dpvucEX8TYzVsA/8cdU2ZxTX2PfQ1ZD2mCoDzy5HBmS1crNsjwLLWqEsfRw6
         n5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6mohSiJsKKJ6AZ10l+E81NnHMmEZM3vAl6O1sHdJCQ=;
        b=zpeyFRliWoNc7jcZthvX4xdXPf5Wvj5FCyqq41DUbbsVbfCutO3tvKInfdZdMyTkE/
         1Y11VZHezZaFyQq//ncSVvmzhG98GCtKGRAKoEYCtdhAEy0QBKiNnmHwg6Ksg/EYCEzG
         jOnCygmEbwBPA7Jc1pfihldmeTsi4p/M1ijP7z5mVgnWC3FXYks4Ri7o8W4vHOoZl+qI
         /XuUoogFP4EiBQDzmIzMF219hTJ5Bx4Ttp6PG7uwEDLvH+WtfwM1LocoiKKIGYILo5sT
         XUz9WbbB3BDWWkv8lshpFcmPUc7dlFK0YSwS8GJWyhJpbU9lDOslene589b3bbQXjU2v
         C+5g==
X-Gm-Message-State: AO0yUKVuAOjHZYweEBhswRcgBTTDOIGt/wb3cmCPzH7XZ2rtRVtnXKPd
        bu1KT+HbJgQgioYUoDZ5TnE=
X-Google-Smtp-Source: AK7set+pvGIHWYpob8whK17X1mbgvscQfZu5/E076eALO6X7G7uDPfjPteSi0dR7ZRKTm+SrJthz2w==
X-Received: by 2002:a05:6830:1041:b0:68b:e2bc:3f7 with SMTP id b1-20020a056830104100b0068be2bc03f7mr1135007otp.18.1676387413767;
        Tue, 14 Feb 2023 07:10:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a23-20020a056830009700b00684bcc9e204sm6384470oto.78.2023.02.14.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:10:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Feb 2023 07:10:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Message-ID: <20230214151011.GA742354@roeck-us.net>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214103936.1061078-2-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:39:32AM +0100, Sergio Paracuellos wrote:
> MT7621 SoC provides a system controller node for accessing to some registers.
> Add a phandle in this node to avoid using MIPS related arch operations and
> includes in watchdog driver code.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> index b2b17fdf4e39..a668d0c2f14b 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> @@ -19,6 +19,12 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  mediatek,sysctl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to system controller 'sysc' syscon node which
> +      controls system registers
> +
>  required:
>    - compatible
>    - reg
> @@ -30,4 +36,5 @@ examples:
>      watchdog@100 {
>        compatible = "mediatek,mt7621-wdt";
>        reg = <0x100 0x100>;
> +      mediatek,sysctl = <&sysc>;
>      };
> -- 
> 2.25.1
> 
