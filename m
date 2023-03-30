Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F156D0C28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjC3REY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjC3REW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:04:22 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1A72A2;
        Thu, 30 Mar 2023 10:04:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id cf7so24368083ybb.5;
        Thu, 30 Mar 2023 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680195857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlDwVnjXPjHRMPhMgjQhgcuV4GVG8mC7w2wq3ycJVpU=;
        b=hw3Ylsu5/V5zmwUjbFQXMniyjy0U/PBm0rpdJF50D+Ie8uy9rJHxKVvxxJmPY3Hs3q
         1M4MqLLDVv5JqgU/UsXaZwyRl7KbI0l47/T7UX3/d62GpHY8de5mJ11QJ13H8Cmz03Ma
         +4gQUV0qQn6nID4G7YOmp6D0EevpJGx/UTqTwyLwjI0qMsW2YCLWaLK2G/5FjQHe4d+n
         5MYUswOsAq+rLvzT1GsBXRYI7+e9UXnwkqt+zuDy6CcVi0nd6MLj1iRivRDonheBtSII
         Mq1jNw+S4d4hemsSqdukbojl0Xt3VqUiXukBKaLr1R+wogW8Cu/6mfTKAoihnh2Jpd2U
         vQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlDwVnjXPjHRMPhMgjQhgcuV4GVG8mC7w2wq3ycJVpU=;
        b=uhoZvyOtVR5aSqJ5D+GK2Efkjp6bfXvYdKQm4YzvvIMGnKinylM1XpK7l+m8fgpxoI
         irorWhvf490j1khbOCiBVQrCz8/aTv1QfZ0ThjGuxi3CFIQDLCEVztxBCE+56RuSfUDj
         V7bwAarwTViGuagNLZeYfvbpz/ZpimyLW1eMVkuzT7pBPXu+xult0gjuDR5t4Z7omhmU
         tySXOkbAaqr2Z785REah3Bvilkl9j1TjSmpHKffhLLnswHCMSUgjLan86GU57e7y1jjC
         YE82mMFlnqTGhQc5hohjgj4VERE/GRXYk0m67LoWHJd6m7xhhpUAnJtjqlGpQosSlMze
         Gudw==
X-Gm-Message-State: AAQBX9c12qanvZdmL8+J/4nL6KqpktFFODIlpfrD0l8n5ruG9YRrM39b
        ZcZlRBl2JN1uu4UDFfW30jZmTMR7I7U=
X-Google-Smtp-Source: AKy350ZS888I2zvXwETSVCnDXVQBy76l3/CT2E1Vs+5IucefI2Rh9djzDoE+4XCUkMT8UWj7OcLeQg==
X-Received: by 2002:a25:6d43:0:b0:89a:338:b74f with SMTP id i64-20020a256d43000000b0089a0338b74fmr18782917ybc.55.1680195857269;
        Thu, 30 Mar 2023 10:04:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b125-20020a256783000000b00b7767ca748dsm4261822ybc.42.2023.03.30.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 10:04:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Mar 2023 10:04:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-ipq9574 compatible
Message-ID: <caf973ad-91e8-41b2-a801-123bfc54d12a@roeck-us.net>
References: <20230329053726.14860-1-quic_kathirav@quicinc.com>
 <20230329053726.14860-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329053726.14860-2-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:07:25AM +0530, Kathiravan T wrote:
> Add a compatible for the IPQ9574 platform's APSS watchdog.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 6448b633c970..6910533aee50 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,kpss-wdt-ipq4019
> +              - qcom,apss-wdt-ipq9574
>                - qcom,apss-wdt-msm8994
>                - qcom,apss-wdt-qcs404
>                - qcom,apss-wdt-sa8775p
> -- 
> 2.17.1
> 
