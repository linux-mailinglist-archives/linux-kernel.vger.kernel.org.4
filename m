Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A86490C0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLJUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLJUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:54:30 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10017066
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:54:28 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d128so9470121ybf.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q16cxr3s5Ib/3QCtLbMCElaACH8JgEzemBLFcm7MiOY=;
        b=R7AKYZndABWJMDjQgvNBO5XgFt85b6LX7zTVDJMZsdueHvaM+Z135Q1XPrHodiM2He
         MoisOf/uej3tuCrxds1VVXgZUfv+Zsr+8qUU5pZfgDFTzmtvyZdG0MjGg8x1PKFkAUBI
         0MQeqI3t1694tpSlNEgAIQIRHMOhvgxLZg2pE/tDFuju9CMuV2Je18n8RJIWAJm95tUO
         kDAZfMfk2qaV1HlMAYERx41LZ1LyDJNPAYF5tKfkzeCAFnAQLdUnq+IjXfTSYbgQufM2
         NOptWSc+ja72x5n7+7N9AkvsNqfa5deh7gFQao7PIXNUogBqPT3+vbIVE2NYHyR8fPFh
         UrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q16cxr3s5Ib/3QCtLbMCElaACH8JgEzemBLFcm7MiOY=;
        b=SP9pVdLSQLUWYfY/5g6ebx47VQLlSBcYp7OqXrikaFujaAzBNkC4OyKvx9f1OTBMeW
         MRzKuZq9FM8UMrKZKETQTKPe9WZjRpbQU60le8unBRfTmy3YcJnQa034QiQBu3znovRK
         RZuGPN7DzISFyWrNE6fiF8cIkFIWAwe/ANXnCnVQg4nxyiQxxzFyE/6/VZAj7lznwo+W
         jNMh8OfHmBS+T8g+0yUq7byWsbVKsd/5p0A94kxJ54njsvuLNCBZ4t0xm9XxnMNx4OK2
         fzqCmyqmHjyVDyhD6Tc91dfYnG7qr8HMYKlv6u6Zz7Vh1lbehkkbM17At6DM9QYnFiHO
         NJcw==
X-Gm-Message-State: ANoB5pkiEW8lg1iZC3AbBm6PSAMGAVtplIEYIGhNejN68NxBTJwpsbg7
        8gchtZpMKQVwv4uMQ6aFvhGhsgECC3Cs5eLifAKWuw==
X-Google-Smtp-Source: AA0mqf44ulwHZCa6/pZ9L/2X+QF6ko7HvjIj/me7Y25mH3+MX+Gpz6y6Sw/vv0/48I8yKLLFWHcXUZ3+TTtMDLEtJzI=
X-Received: by 2002:a25:4dd7:0:b0:6f1:535f:2f38 with SMTP id
 a206-20020a254dd7000000b006f1535f2f38mr65304962ybb.153.1670705667741; Sat, 10
 Dec 2022 12:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20221210200353.418391-1-konrad.dybcio@linaro.org> <20221210200353.418391-5-konrad.dybcio@linaro.org>
In-Reply-To: <20221210200353.418391-5-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 10 Dec 2022 23:54:17 +0300
Message-ID: <CAA8EJppJoc8bCOgFjiWagbiVOF3RCFWmEEYObcErv26bfeuM9Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] interconnect: qcom: rpm: Use _optional func for
 provider clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 at 23:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> It turned out that - very unfortunately - msm8996 needs a binding
> update, adding 2 more clocks to the A2NoC node. Use the _optional
> variant of devm_clk_get to make sure old DTs will still probe with
> newer versions of the driver.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
