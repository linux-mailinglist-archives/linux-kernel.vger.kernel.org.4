Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5B68335C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjAaRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjAaRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:08:02 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06440ED;
        Tue, 31 Jan 2023 09:08:00 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id s41-20020a05683043a900b0068bd63d34d0so1502963otv.6;
        Tue, 31 Jan 2023 09:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An67hPl3Bhcv071DcbjwsY0TRli26xOZfGCxX8FwvX0=;
        b=BPxI2AvasrC6elThOoj/CbDVTzPfK2krzsevE4/uq/HzIximzqe7CWBL5dgNDm0aFV
         ML0n8ePQ3Tm5MVUQhzl2vCEOkPQ8RS+VgWvu29C4Zm3omocnawFur58B4+5LuJ3kcSFi
         2jPpL3aPlxDLJDsn5J6ex5JEjEwHvJBakJwJP5m49JlRh5x2iKWO9hNUJZT4R+t3H3YQ
         KqbqzYEHOHkiemrpkPxwfEzD+3Z5NwNgATbmMPpcKjOCe4bAMr3+zdczdTPhx8t8LmCx
         l1/033MhK2gLY5j20PsOH2DPvIlGt3/6YmhGgduVyNm4dfaZh7DAQ3B1EATbv2sn1otK
         0tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An67hPl3Bhcv071DcbjwsY0TRli26xOZfGCxX8FwvX0=;
        b=TYLGBhAjX/XyqfA5Bk/QZwUurQsiFTJoSGxLwwf4bl+wML0bryhX5c7Bgewa/mkNB7
         nkfzzdluaiFLnNFf88wM5rxYh+P8VZaWXXuzl0AZTHZFOHL2ItXYx2VwKxHqEmc06x9H
         bJXvCd4Su+cYIA1DZQddEVcG3um4EWMSjOL0JIp9IQy7NxAP5EI7/NS7/9wZLItwBq3W
         6KHI9IVGOWGAY6NhBEFwk/4wQhDLpvFNJvVZp7JsoxYpmBBP/yULaZbI9Gf1IPOwev6F
         H2k6G4vxOQvzdVAYdPwpHSSfxlEB+ZUQ4msq8YrIOWus8dIZddeSU1Hu30ZCHOFIPH9t
         gjGQ==
X-Gm-Message-State: AO0yUKVYGG6iDzaVdcAkMjFY76qt2rbe/hXWciIy4mVFojYaFlTMor1m
        1lPUWBZMVTqd31Nn7w40tEs=
X-Google-Smtp-Source: AK7set+yxaCs7d47iRcZPdfsy9xTDWq2/cn8EMIPvc3uL0E4//KuEul/1WaVmiAtsG/ZaJBZwPRxuA==
X-Received: by 2002:a9d:6f90:0:b0:68b:d266:e6d0 with SMTP id h16-20020a9d6f90000000b0068bd266e6d0mr3997680otq.14.1675184879931;
        Tue, 31 Jan 2023 09:07:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14-20020a9d048e000000b006864c8043e0sm6746240otm.61.2023.01.31.09.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:07:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:07:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: Add MSM8994 watchdog timer
Message-ID: <20230131170758.GA3599352@roeck-us.net>
References: <20221117105845.13644-1-konrad.dybcio@linaro.org>
 <20221117105845.13644-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117105845.13644-2-konrad.dybcio@linaro.org>
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

On Thu, Nov 17, 2022 at 11:58:45AM +0100, Konrad Dybcio wrote:
> Document the MSM8994 watchdog timer which is already used in DT.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index d8ac0be36e6c..a1f17c9e02db 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -17,6 +17,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - qcom,apss-wdt-msm8994
>                - qcom,apss-wdt-qcs404
>                - qcom,apss-wdt-sc7180
>                - qcom,apss-wdt-sc7280
