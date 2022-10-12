Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9705FC9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJLRmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJLRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:42:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1DFBCE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:42:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r17so39522941eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F+/oGLzREG21Yj0uftDYL1IyCwSjsexCNfPmeCYYK5U=;
        b=j7mlJDdtav9g6vWHhzB0NwAdum8QysC2za2V7GrivI/Px5eW1urR25/m6DIOgTwa2z
         N7Do86PkEu10oKl5S4Dl/HsMgMoPZmu1QdafheG/q9BqAeH/4gWGmms7wQNlGqFWSZMr
         xCP/NgrU2d8KsGwj/W4HbnB42/mUWL68QTz2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+/oGLzREG21Yj0uftDYL1IyCwSjsexCNfPmeCYYK5U=;
        b=W/h4RFcRcwsJV9E07643hza6K0gdXDoHjP9N8ZhzD2SI3fgeGb5jSnVY+6kU0gjV6T
         A9uAVM+/EUKxEsOwSqSwEVGFgzwOCLf9FQDHpYp/YomuBxbVrbATNBCxenNHTThgoiaq
         NnfLzq2n3Z/P7yaI7Q+LVwJr62bY/S9T0J9m8CLwHSnRrn1K8afqfLHcsfKEUkX2rzoy
         lpcV4Til6VrkeV9UfNFoRJUA4bST0Z0lGFIuDJLAJVo3UJxbAuQScQIJl3N2swZrG0kY
         UjQvckvEtk2NUT1ZyC2Z0RpD3xg02PZhz2evTx9PO/jHJXFsnUpMpjB2NvOOXnEwe4ho
         gJNg==
X-Gm-Message-State: ACrzQf3L5ndACariyrOFhqDirIp27obGrrUcqfr+kihZ9+A/aeGascZx
        yZc+pTxcwfWiDlukCX8agLJNkvFljHbWdm10
X-Google-Smtp-Source: AMsMyM7DLnRL3ttAU8dMqQ+k49Fmuz5GFYs/emwAogtv0zK6zf/EcRorS96+2nJieGwkJRXmDWhGAQ==
X-Received: by 2002:a17:907:708:b0:77e:ff47:34b1 with SMTP id xb8-20020a170907070800b0077eff4734b1mr22250336ejb.493.1665596553476;
        Wed, 12 Oct 2022 10:42:33 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906301800b0078defb88b0dsm1619686ejz.73.2022.10.12.10.42.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 10:42:31 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id bv10so23735327wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:42:31 -0700 (PDT)
X-Received: by 2002:adf:dd0c:0:b0:22e:4bf6:6c08 with SMTP id
 a12-20020adfdd0c000000b0022e4bf66c08mr19368307wrm.617.1665596551460; Wed, 12
 Oct 2022 10:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145116.46554-1-krzysztof.kozlowski@linaro.org> <20221007145116.46554-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007145116.46554-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Oct 2022 10:42:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WN+9DJp-3Ny04NmOLau2RYibeJayEtB7x0uT-YoizFQA@mail.gmail.com>
Message-ID: <CAD=FV=WN+9DJp-3Ny04NmOLau2RYibeJayEtB7x0uT-YoizFQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sc7180: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 7, 2022 at 7:51 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> +      drive-strength:
> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +        default: 2
> +        description:
> +          Selects the drive strength for the specified pins, in mA.

The "default" of 2 is not correct. Please see commit 768f8d8e45f9
("dt-bindings: pinctrl: drive-strength doesn't default to 2 if
unspecified")

In fact, are you sure this even needs to be replicated here? This is
part of the common "qcom,tlmm-common.yaml" bindings file, isn't it?

-Doug
