Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9E6BA063
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCNUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCNUFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:05:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48B30199;
        Tue, 14 Mar 2023 13:05:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so15228223edd.5;
        Tue, 14 Mar 2023 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XGXvs0ITat1ZXax2nuiG9HnqxC3NFYEPJinGjqM7Qo=;
        b=FHwqi6k2Pbfwxlx87QG3Ul5Kd7sv0X9DI/oWX9lF6BGIQtxxqDiC2xnXtWFFF/hcnr
         n9zCFNL6Pu35FbRP9YiNTKstbgw+SEkjdv1Y5a0JhFF5ZGmlkWgNr7X3kA+lJZjqVeFJ
         Mm6GGMFgs4/5qJgKpQmfvpJUTVEbM6TsRJjaa6s3JoExg0x9bEK6NjpK/yyFjNN9Oak3
         Bwm/5MXDIvov+RLli8egLCBLc4ioN0if2kTIejiBVHfr7PlLJcVSP0n1oUPSidAKyYKk
         D2gQNAY6DHFIRDEht3GyasELTUino2LDeX409tM9uUF6Iq2wObfLtxxUJhAYud7h/hRl
         xGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XGXvs0ITat1ZXax2nuiG9HnqxC3NFYEPJinGjqM7Qo=;
        b=VSQBflmdvEfeV6hnhO4vCmyog4eAAYY1Ody++Tpj3Npfuw+WJWfMJHQU6Yohm++aLi
         vM0RtZ0nVjIIWVM7Av/dHXRa6fmeuKp3RqWXfbmVI9EebgHiRz2OHE47RBYMmUVSIcby
         TOGpkwoITKcU6okThCK0FeP57Icr/vYvOTKrFIstiB0D86CBqe0D0xZTXcFlc8EJW1lZ
         yX/BQreVfTpxmFb+Qwl50PBCC8pmk849gticiYMtaeTTYAsRlIUbjBc28fXfCUZuREg9
         OwoPHY0VyZXXAUZAuwGK/jubr+cZdIkMsbu8IIDuO9b7D7Vl+Zj2xhtvKI6kszWqlnAk
         Cbug==
X-Gm-Message-State: AO0yUKVSNeoteYa1i9ZKeUGTpX1fvvx7ZN16+OwfEFCVUNaidf6csqpc
        txgF1mmIurb9ndRovwsibas=
X-Google-Smtp-Source: AK7set8hUj4QjdDm+ijiDf9LUnE1MtORn47ZJsuHaWn6Joj/taxgFTUrG3jHA4aN+kKHh+wc/HvpYQ==
X-Received: by 2002:a17:906:1f51:b0:928:ace8:9f07 with SMTP id d17-20020a1709061f5100b00928ace89f07mr3060748ejk.12.1678824300526;
        Tue, 14 Mar 2023 13:05:00 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906375700b008cff300cf47sm1534950ejc.72.2023.03.14.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:05:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/4] Input: sun4i-ts: drop of_match_ptr for ID table
Date:   Tue, 14 Mar 2023 21:04:58 +0100
Message-ID: <21805180.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20230312131514.351603-3-krzysztof.kozlowski@linaro.org>
References: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
 <20230312131514.351603-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 12. marec 2023 ob 14:15:13 CET je Krzysztof Kozlowski napisal(=
a):
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
>   drivers/input/touchscreen/sun4i-ts.c:392:34: error: =E2=80=98sun4i_ts_o=
f_match=E2=80=99
> defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/input/touchscreen/sun4i-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> diff --git a/drivers/input/touchscreen/sun4i-ts.c
> b/drivers/input/touchscreen/sun4i-ts.c index 1117fba30020..577c75c83e25
> 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -400,7 +400,7 @@ MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);
>  static struct platform_driver sun4i_ts_driver =3D {
>  	.driver =3D {
>  		.name	=3D "sun4i-ts",
> -		.of_match_table =3D of_match_ptr(sun4i_ts_of_match),
> +		.of_match_table =3D sun4i_ts_of_match,
>  	},
>  	.probe	=3D sun4i_ts_probe,
>  	.remove	=3D sun4i_ts_remove,




