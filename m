Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA76DC2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDJCaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDJCas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:30:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C92707;
        Sun,  9 Apr 2023 19:30:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-632cf805762so353551b3a.3;
        Sun, 09 Apr 2023 19:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681093847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91oVa4U4E752SRKAZUiXCqWTpRWldtV5m/eQGoWFvDo=;
        b=GvjyKFfrXQTDTegaGVK2x3sG0Ip6I3hXwmxFfOJmMEaHR3FIpZXlAWKenZDLqvBSPu
         puqcCBoYi4yqP7Q2ciPTlbPkpHDluTpkF7hud2O5kOk4VFK2ULK9zwJttHL/uKGfaGog
         BKABVer4EjKFxgiupm7RulsPxONmCa7ZRqa0D35uiB3BGDbX6SGxzSuYFXegS87cEUq5
         3+hAyEhRKhiMtgQrVBGdxi22HvKUi10Z4RUlTyIkSxrwpL7FlqeB3Bh7ZTseIp/AOAI0
         PAdtNlIAJSxK2ziOqKUNi8wXjnbEcUV5LaFA8ruWLlrtsFeobb1d+bArks5aVsd+sCy9
         mttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681093847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91oVa4U4E752SRKAZUiXCqWTpRWldtV5m/eQGoWFvDo=;
        b=vX92haYdFAOd9Mp+G6LvbvfI517iqTfdy10Ef5vWI/JtaYP0oemAJGOY/ebf4bEhml
         11ORY7PJLJtOa2gvQ2e7PDCniAuaXUyjM/khlf448c4MMoKCw+1ZZ2jGNsMBtl9dJJVg
         OAgl5EcOSfH0PWE0b5B0iS9gdUDgtejtlfThLivtOg+b62nQrWK4fj1t1ZR8BKqx93h7
         uUz5gHHQMIzpVwTrcBiSEv2LDLU+ANUgs7Y4fRNzABPKqfIJQsvvzbiA1eXWlyhQOU6x
         FbzV1ygEqubzQvqTQqvPIrRIsEPBehtRxiXJLaKEi52k11GDQxxwMUJ9mjpLr+AnxHbA
         bO3Q==
X-Gm-Message-State: AAQBX9fUoAfG+Q5yJBjMz/lahOcV8+uZtgB6AYOW190i20/Ril9af7Oa
        r8YGAGrviPPDKuY8BMK5GGQ=
X-Google-Smtp-Source: AKy350arnos9p4x6ClCP16vCSb7Y1qpCkhOMhsM+5TChYcKYrgNgkdmDap4qv4y7/IEV5piWIUV7pg==
X-Received: by 2002:a62:1d4d:0:b0:625:fe95:f120 with SMTP id d74-20020a621d4d000000b00625fe95f120mr6471688pfd.8.1681093846702;
        Sun, 09 Apr 2023 19:30:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:803c:4683:913e:ce04])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b005e0699464e3sm6614117pfa.206.2023.04.09.19.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 19:30:45 -0700 (PDT)
Date:   Sun, 9 Apr 2023 19:30:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, aisheng.dong@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] input: imx_sc_key: add wakeup support
Message-ID: <ZDN00vwyCOzFrDYt@google.com>
References: <20230323093141.4070840-1-peng.fan@oss.nxp.com>
 <20230323093141.4070840-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323093141.4070840-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:31:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add support for waking up from system wide suspend.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/input/keyboard/imx_sc_key.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/imx_sc_key.c b/drivers/input/keyboard/imx_sc_key.c
> index d18839f1f4f6..234f23cf9990 100644
> --- a/drivers/input/keyboard/imx_sc_key.c
> +++ b/drivers/input/keyboard/imx_sc_key.c
> @@ -151,6 +151,8 @@ static int imx_sc_key_probe(struct platform_device *pdev)
>  	priv->input = input;
>  	platform_set_drvdata(pdev, priv);
>  
> +	device_init_wakeup(&pdev->dev, device_property_read_bool(&pdev->dev, "wakeup-source"));
> +

I wonder - could we move this to the device core?

>  	error = imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE, SC_IRQ_BUTTON,
>  					 true);
>  	if (error) {
> -- 
> 2.37.1
> 

Thanks.

-- 
Dmitry
