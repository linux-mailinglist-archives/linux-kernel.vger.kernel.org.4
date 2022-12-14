Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822C664D16C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLNUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLNUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:44:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C73C5D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:44:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b2so47452912eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yFCyq1MsS2DUmVNiT4NLGdkj3gexodwQji1RBiXJABY=;
        b=mqNtF9nq2Kal4In/4Es3hyEnbjqLi1RdLqZjSQhPhga5Tw0woEZ2SCkCJ4vK1JaSES
         56/a0xuCyvCt5S/P9dBpvrfc+K25+Y/0jrABtDSSWKWesPBhGvZA3Whs0tIO+YzCnS3q
         LBJjA4Bb+LJ2OsxzoRSINb3Mbr4Bque8F5AfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFCyq1MsS2DUmVNiT4NLGdkj3gexodwQji1RBiXJABY=;
        b=2+O/7HVTrK21ap9ZmfrakSvMffalZ5eQqTKZO1SAl3w0dYvYG/mtx4mgofazMKJLa7
         0yQn0i/XJ6U+6RD4rmJT2eGW/yHp1bQiPZlRH8IF6w52jE8DRh+PQ12CkF8T7771nBit
         rAUtXR7fwHPXtOBdAd4Rj1YKYTiQtAhmlBKoChrjY7E17JmWIGk0LqjjhipxY7p/1ltY
         Ay8cJ7ojIvAzU/OaBmQmDXEIbVgqWehyS0rcpJUxmE40US4+9YhQGQI7yss0lwuhLwPR
         Co4d/vqZGZ6Pjad8OlqgECa7ydaNmOowKOxa7hJhzYn/qqFFdGL9n7grGtBdtPrFPhxX
         Je+g==
X-Gm-Message-State: ANoB5pneiB6uZvjUovTmmc1SyGQoeQXriWujbWKdglly5/e0HBGm6Tit
        4qMquNfsQ3f5h0S2nPUFhSdThYxqQ77dKohzV9s=
X-Google-Smtp-Source: AA0mqf70SAh0+JjmfnOYuirOopq9s14cvYpVkrEYYcC7uTD8iPH0HXAYCnuk/9SKq7Q3+z2q/RbYbA==
X-Received: by 2002:a17:906:840d:b0:7c1:4b17:3323 with SMTP id n13-20020a170906840d00b007c14b173323mr17858429ejx.7.1671050647196;
        Wed, 14 Dec 2022 12:44:07 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id kw21-20020a170907771500b007c4fbb79535sm354399ejc.82.2022.12.14.12.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 12:44:06 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id h11so1005855wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:44:06 -0800 (PST)
X-Received: by 2002:adf:fd89:0:b0:242:1f81:7034 with SMTP id
 d9-20020adffd89000000b002421f817034mr27228899wrr.617.1671050646198; Wed, 14
 Dec 2022 12:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
In-Reply-To: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Dec 2022 12:43:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WKJQqPvwuBYrZNZ8venrPuhbB9LOraYZ7a8TCr7-tt8w@mail.gmail.com>
Message-ID: <CAD=FV=WKJQqPvwuBYrZNZ8venrPuhbB9LOraYZ7a8TCr7-tt8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add zombie with NVMe
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
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

On Tue, Dec 13, 2022 at 7:48 PM Owen Yang <ecs.taipeikernel@gmail.com> wrote:
>
> Add entries in the device tree binding for sc7280-zombie with NVMe.
>
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
