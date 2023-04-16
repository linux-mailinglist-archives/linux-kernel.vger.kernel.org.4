Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AAC6E39E2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDPPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:43:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D6C26AE;
        Sun, 16 Apr 2023 08:43:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7606d6bb669so36459839f.2;
        Sun, 16 Apr 2023 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681659837; x=1684251837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFn5R4xXzuvnwOnRhG3Vhya1AEqvHvNArnfqEJR1x7Y=;
        b=RPGCj6RbG27UEGViRruRGBWBJLUbnTs9IMB0y05AunSX2LTybgsQFFG+xkwbS6Uf+9
         tMwt9rLA57orOj98V4Z2YHnypLsGYm7F0LpPz06Im1/V39oobjpUeQFhdk6jykwzC75N
         twNZoJkLaL/fijF19RgUnyuwNvkxBV5i1yJNoY96ffRI38W3Zv9L9LGbnONuFnf6V81C
         jdOSfzwUw6RZzS65ITgbD7rgGdliHkywvTptYiTvQBIUwopCaE70xcbdge3qZqCnne5T
         PWWV8JRO7zFQ021HhqFv1h0Ezb/IAcPpzggZdObO+dwoBcLVjfBzljddM0RzrFFpnt68
         g2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681659837; x=1684251837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFn5R4xXzuvnwOnRhG3Vhya1AEqvHvNArnfqEJR1x7Y=;
        b=A7yihYPt+NICN7Plo5XGk2zsb2ihwj5KwmoNEqBaY/ixDp1KgQkaX1FVfTLJtRvOHi
         m0nLE0QuJj+dxmcEVg2g8PZoFTh4hgCbp8OS56orqOjDneajrec4XiMtUSiISLWlA3gb
         yBwSpwTkIjT2Kx2wPfTYvA4TmRWHMyZnJlUxCdDIcF0byJDesfSIsALcYWuqBtYCJLE0
         t1gJVM1ROFISCcwKHqJSPNxmU9VkwO9QV2ancLyb26GiycEfOxXy+pfF7vto75Q2rRLn
         Qt2sJI56hSo2vmpf61KRLw3N8ZoLmRjl7PBvSRD9UA55U8rbVbY6UhCKegiRkBZrkfla
         7Jlg==
X-Gm-Message-State: AAQBX9e1FZC5q4CHQgrh+HMAlAHuogzPO4KLGTwWsea8t1D46k0DRSbh
        g/JAsHLAw/j5xuR84mq239OI0zJK4nk=
X-Google-Smtp-Source: AKy350ZpMx84dPLE9eO18JJEM0NfPihoCSRCw4RFiUudqaj5E6BLXeL3qZ3w/Bo5NH376PtQUCR63g==
X-Received: by 2002:a92:cecf:0:b0:328:3002:9732 with SMTP id z15-20020a92cecf000000b0032830029732mr8005995ilq.16.1681659837673;
        Sun, 16 Apr 2023 08:43:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y42-20020a02952d000000b0040f9f562bfesm670449jah.123.2023.04.16.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:43:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 08:43:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-ipq5332 compatible
Message-ID: <e1b88c17-2335-43da-b5e2-f9e150a87b0a@roeck-us.net>
References: <20230320104530.30411-1-quic_kathirav@quicinc.com>
 <20230320104530.30411-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320104530.30411-2-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 04:15:29PM +0530, Kathiravan T wrote:
> Add a compatible for the IPQ5332 platform's APSS watchdog.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V2:
> 	- Pick up R-b tag
> 
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 6448b633c970..8060a87d29da 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,kpss-wdt-ipq4019
> +              - qcom,apss-wdt-ipq5332
>                - qcom,apss-wdt-msm8994
>                - qcom,apss-wdt-qcs404
>                - qcom,apss-wdt-sa8775p
