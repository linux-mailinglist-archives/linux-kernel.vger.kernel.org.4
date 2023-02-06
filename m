Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F368BB70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBFLZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjBFLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:25:42 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E083D3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:25:40 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id a1so13977929ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqoL344ahlUSGKEcPeWSWxdzAFVQeuSWEQ2bFV7PfAw=;
        b=GQC7Vdd0ShtHyuYbws684oddqVBcnUscuuhAQE0nrgOMJxSOmJwSONncXrg2FupUax
         EEblB6a6KqEYuoOH1qvl4bpRvNk7xCHyk8FBpuf/Q6e3QJ0YZCpDOf/PkERhTu4a6YeV
         NsAfL3eGNrVdjNRLSFFoeeMExbwu4TnaI8bS4mkQwX93fE5FzfF8posZD3bavN4zHGBg
         EOlze0vpR1vV4CRg7WemHThjOAVeh8wxRsMk4G/ML9uDpVmPn3orE+5VCxtQLLp9wef2
         HSM+WnPTvOKBiTW0QUH9EIaopo71B9xThIHwsKSDqMBoO+FI0QFJsnG5pMvqaVrytIkI
         8WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqoL344ahlUSGKEcPeWSWxdzAFVQeuSWEQ2bFV7PfAw=;
        b=4MmmyqOjyO490kCkG+EMRxLNsDq7qabvwn8aQghci6Cor/Y/QsbYQohklrbyLROPsw
         M2jaj+sNsIH+b60+E+NdRtc3+iqsCOCT5K0yg581B4aaxGF5Tq2h5T6LudZr/FfDCaJE
         yywzMouph/3vumhbHBfKKhisKlXQ99FE+wNK4av5GHZxn2+4QcPoSXLqMJS2xqVvSGlu
         4n90tCAaDePqxkqqvpZ21UGiwCQ3qPzT/t6ByQ+dKMqU10PtF0hUO0Y7cDbXmdUQP9W7
         QrY8IOfvnc8FTS1bvZpEh4QKVpWi7HlrZ0UbVF84yU6IkM9gCKyg33ZdmA3ab+WTc0Ea
         OSag==
X-Gm-Message-State: AO0yUKWgI7I+M+kSQ+k76KeyjUyQQnYf1zlPswijXnCyIm0FC8HSSAfD
        yXE9LSdDA7eiWG/2OksRUL0SaWKaTXLrc5M4nnJT/w==
X-Google-Smtp-Source: AK7set+SFrdnVJOmmGT4T8wNENpdw4jkqUL4JIeIMcevxcJ8Pyit+ExaUYRLjibaZ5z5zrn9F+yeezTbHdktarTKGwM=
X-Received: by 2002:a5b:d4f:0:b0:893:76b2:9200 with SMTP id
 f15-20020a5b0d4f000000b0089376b29200mr315983ybr.584.1675682739722; Mon, 06
 Feb 2023 03:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
In-Reply-To: <20230206071217.29313-1-quic_kathirav@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 12:25:28 +0100
Message-ID: <CACRpkdbtEFCSKX8VcD9bAZLy-PYfwVCRKYwXJmh0hnK2Nroq0A@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] Add minimal boot support for IPQ5332
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kathiravan,

thanks for your patches!

On Mon, Feb 6, 2023 at 8:12 AM Kathiravan T <quic_kathirav@quicinc.com> wrote:

> Kathiravan T (9):
>   dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
>   pinctrl: qcom: Introduce IPQ5332 TLMM driver

I have applied these two patches to the pin control tree for v6.3.

I see no reason to wait for more review since Krzysztof acked the
bindings and the driver isn't invasive at all, any problems can certainly
be fixed up in-tree.

Yours,
Linus Walleij
