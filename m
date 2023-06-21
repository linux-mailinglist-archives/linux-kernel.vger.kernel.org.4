Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B408738C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFUQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFUQ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:56:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED219B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:56:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9741caaf9d4so745676666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687366608; x=1689958608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBrF3iaP3Fd6iHn8cw7cCxGg4FZTsp6oWE22ClcY7C8=;
        b=cKhePLXwx6t0hrmDLcxb9ENEo0aFMmx0Sw8StfTjt+rKzM2XM9CZz9rwpm52Jj9pQg
         n1P82I5VZj8I5F83Be1tPIFYy4yQzx95MEw0CMUZ1GPBA7DzYOGC1s/CtnMx30D5vttf
         qiXtqIObkE6v+TPp6CBr7j4Mqcgy1GunKv9sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366608; x=1689958608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBrF3iaP3Fd6iHn8cw7cCxGg4FZTsp6oWE22ClcY7C8=;
        b=QQX5ll2W6X7Qfqr3CkXRgVYPGppYSjNi9SDXvm3Bja93k3iVZJt1jh2G+DIP2cgzVs
         KqspGUpvLcL2ZrqXToit4BdWTHnZLWuunKb32kquG4ImBXivwrhRCCxDAr8wgAw1KIGi
         UL6S5kwHCbzL3Pe5U3H5glXfI+JbeTGZaTof7Cb7WjTpqcuylSEsZEt41g/aM7fQqW7L
         WwWor1u/yxB1yITlnbnsp5wdnee8jgPrI7cgoST5BZmKCtj5Tf1t2SzIrEXEQbdE3vbi
         +FDbuY5IEYHM0WdWsBsBUVk+ZXNSYaxWyMl2OlMtzEm4POgs1U5OzqAPmLzEu9rrc8j7
         j8EQ==
X-Gm-Message-State: AC+VfDza5C8nuGxJrnsGSLxo6hozwNoNWR6pAG3ZYLMp2WbogQ3HFVt3
        7s+xlmzEgQzUx6vHeo58po+Eh4Xm/dUhxswG/ra7otGX
X-Google-Smtp-Source: ACHHUZ5RkfjFTCSizji8qol9gDzPcrF59y0lJeTMBSnTu02wtamFpWX1HEYju+DMmMgMvMa7twwjLA==
X-Received: by 2002:a17:907:2d28:b0:973:940e:a01b with SMTP id gs40-20020a1709072d2800b00973940ea01bmr17004997ejc.60.1687366608239;
        Wed, 21 Jun 2023 09:56:48 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id qu21-20020a170907111500b00982cfe1fe5dsm3282630ejb.65.2023.06.21.09.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:56:48 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f9b4b286aaso7475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:56:48 -0700 (PDT)
X-Received: by 2002:a50:9e65:0:b0:51a:2012:5b34 with SMTP id
 z92-20020a509e65000000b0051a20125b34mr630898ede.4.1687366587250; Wed, 21 Jun
 2023 09:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
In-Reply-To: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Jun 2023 09:56:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqirzpMwq8wto2B9cDGVf5JfirAQRargKWcZLpFhXCVA@mail.gmail.com>
Message-ID: <CAD=FV=WqirzpMwq8wto2B9cDGVf5JfirAQRargKWcZLpFhXCVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: firmware: qcom,scm: Document that SCM
 can be dma-coherent
To:     andersson@kernel.org, SoC Team <soc@kernel.org>
Cc:     amit.pundir@linaro.org, Will Deacon <will@kernel.org>,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Fri, Jun 16, 2023 at 8:18=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
> normal TZ. On TF-A we end up mapping memory as cacheable. Specifically,
> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
>
> Let's allow devices like trogdor to be described properly by allowing
> "dma-coherent" in the SCM node.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Bindings change new for v2.
>
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Without this series v6.4 will have a regression where WiFi / LTE won't
work at all on trogdor devices. Any chance you can send up a "Fixes"
pull request with the 4 patches in it? ...or I could try to convince
someone on the SoC tree to land them directly?

Thanks!

-Doug
