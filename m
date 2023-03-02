Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71626A8609
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCBQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:17:32 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881474C6DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:17:31 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x12so4067735ybt.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NI0M23snSIlgG0WB5X2PNxAxhc5m0Un7hrDW0ghCa80=;
        b=PTdLDVC2te44CKlxyoUIJr1Tf5LUFqgnjuh2ICOBH6DN95EnmZ7tlSIGlHOM7WLni4
         erjAQCUS32nHlzuEgalmNxo+9TENi8HmIGol6VNKv8zT62nPlUzBhZLexSDnb2qp6XDR
         3L6+dJchw7Z+4+Y0BglmIbMZNpVoO6XtgHOHpJy/BNp2hlVjIgAORw6ChiL+0Wogw8rt
         66OIR7lXthImjRC441/C3M05HZiT+P/QqHHEl4jdlD/7n4C0kqU/mHHRKHe9xiT2uyFx
         6PTeOLT5gZ/X5+cSZ+CrlxOEyKjFC6t8nscJnK11BG6dKL3/ZnMA8IHb/9G5TAD/Tamf
         QNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI0M23snSIlgG0WB5X2PNxAxhc5m0Un7hrDW0ghCa80=;
        b=a6KzYXSx1eMnkOcHa6rjNq7QV2+4djW0Ux2OWjUbFDW8C7cEju7qRX8+4zQtXFwGMr
         kh2NOE0ynKdd17Mx3kL8v9mZbYjvGRahqVqgGYB5pwjMPIZy5RQx41BDw5SOco9xR8Hb
         ihm1pecS6v5LPwoAgmaBVlpknoXrmsqtXOK1pKYvwCZE1gwb5SJRrwlL4JjX9xNCGSMD
         95bWiTe+R4PZlS9K6KZFJwpFzu6HrKunVKulMnJLAWVz9S+oCD81NZ/PIsR4UM7srMxz
         obdjuylSTVfsg7vTwlA7dYtjRmhsSrF7wI2uir0pnGN7bVvQYetQaWw8EfN2ys9HAb9v
         U8gg==
X-Gm-Message-State: AO0yUKVwuBii2nvIynL8FzudorYk/Sv4rCQOzQRDYZGJVGxH9oFDKYHp
        uth8GCnYO/AaVFgrDpmf/ndgV35/J/2Nz9n+wVEC7Q==
X-Google-Smtp-Source: AK7set//Hf/uYZ6qY7gZ+y+C9vLjqGy41mZdgp9xBSwR+UQU8Q6plH3+dR/rhbu2vqltwmfL6OV8E+1WBVIFuRPVctM=
X-Received: by 2002:a05:6902:10d:b0:a4a:a708:2411 with SMTP id
 o13-20020a056902010d00b00a4aa7082411mr5711651ybh.10.1677773850767; Thu, 02
 Mar 2023 08:17:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677749625.git.quic_varada@quicinc.com> <8f62ea9941fdb425f63f8389e10a370d2ce0d117.1677749625.git.quic_varada@quicinc.com>
In-Reply-To: <8f62ea9941fdb425f63f8389e10a370d2ce0d117.1677749625.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Mar 2023 18:17:20 +0200
Message-ID: <CAA8EJppArws0PO1XQKsYB1H9OjpsHDRPwKgHtTGUkvDe=mdq_Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] phy: qcom-qusb2: add QUSB2 support for IPQ9574
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Add the phy init sequence for the Super Speed ports found
> on IPQ9574.
>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 2ef638b..c59413b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -915,6 +915,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
>                 .compatible     = "qcom,msm8953-qusb2-phy",
>                 .data           = &msm8996_phy_cfg,
>         }, {
> +               .compatible     = "qcom,ipq9574-qusb2-phy",
> +               .data           = &ipq6018_phy_cfg,
> +       }, {

The table is sorted. Please keep it this way.

>                 .compatible     = "qcom,msm8996-qusb2-phy",
>                 .data           = &msm8996_phy_cfg,
>         }, {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
