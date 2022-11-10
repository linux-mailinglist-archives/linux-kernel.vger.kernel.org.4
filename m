Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63F6246CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiKJQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiKJQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:22:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D11A052
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:22:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a13so3924441edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2zQjV69cVqfMg9UmNwS5DMRljPslOxp55HiAK4Gclg=;
        b=Lu4vI/oqFw0QnjtBCApP5VmT5fxeRK8EHWRX6ExQxVOG3595l2etuZETq5ZKLkgChJ
         lIm54cezWKfRNes/WNG0LM0hvm3PbpjK9WwMHnvUR7UA56wy0MGf3gc0kUJZNNmclmvA
         Zwr9wVYAA41rykOFiBh4azDpzhzl2U7ZPRgB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2zQjV69cVqfMg9UmNwS5DMRljPslOxp55HiAK4Gclg=;
        b=np/3/8yvME82ZKesyX4rExd5Oq8+ewSHKeoZpZov4y1UQpknzRxeiCesQ2CZMpKNQV
         WBxh4cqo9tb2r0XaH7XEJgorwSdqQoLCjagtLLwDoFesIDZ86YkvhRYIKhB6KTC+9uND
         VF5kTJ4EsbgxsiC4DOEgvqflw6b8Z2lZzBrEXFwoJi7EHlVv2yxmdxDga7zacffJIn0g
         u2M+vZb4Wvx5QvbmrwvSjQBhDT7IOFdK7mcZir8u31R4EJM8agEpOLmsFo3wXPpY8HaI
         Wmqy4qFJv6PISMxvF0fFr2TN5J60k5VexliRMtQ+BtB7q0mbsRUAJsDYVE8RXtnoHL+v
         BjoA==
X-Gm-Message-State: ACrzQf3FV3eUc6EEWNJGbkAJ87J2Ir1UWbDPfw3Un542fAclZinzKBfL
        mcM0UEn8ME58zcPwM1QxNe7UOTzdmrAvQEe5
X-Google-Smtp-Source: AMsMyM5HN/Ejm/UnNiFCygjxsgQTu9C0QNXUkVaA6kXmSkvs1EwMpo8ND32J5WTItEcfv9Ey7N/V/w==
X-Received: by 2002:a50:ee87:0:b0:461:a09b:aae5 with SMTP id f7-20020a50ee87000000b00461a09baae5mr64441474edr.24.1668097373045;
        Thu, 10 Nov 2022 08:22:53 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id jr22-20020a170906515600b0073c10031dc9sm7319229ejc.80.2022.11.10.08.22.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:22:23 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id v1so2986298wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:22:14 -0800 (PST)
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id
 g12-20020adfd1ec000000b00236880f2adfmr42499149wrd.617.1668097333487; Thu, 10
 Nov 2022 08:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20221110070813.1777-1-quic_sibis@quicinc.com>
In-Reply-To: <20221110070813.1777-1-quic_sibis@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Nov 2022 08:22:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vb54LpX7P7qJt4TNHVv13muaR0Me9SYskOg5N8ZN9RkA@mail.gmail.com>
Message-ID: <CAD=FV=Vb54LpX7P7qJt4TNHVv13muaR0Me9SYskOg5N8ZN9RkA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm
 reference boards as LTE
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, jinghung.chen3@hotmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 9, 2022 at 11:08 PM Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> When the modem node was re-located to a separate LTE source file
> "sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
> weren't marked appropriately. Fix this by marking all Qualcomm
> reference devices as LTE.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Fixes: d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs for sc7280-villager family")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> v4:
>  * Remove duplicate lte source file [Doug]
>
> v3:
>  * Fix incorrect tag usage [Krzysztof]
>
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts  | 1 -
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
