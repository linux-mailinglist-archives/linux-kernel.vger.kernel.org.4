Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F172806A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjFHMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjFHMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:49:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67A26B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:49:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6532671ccc7so491708b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228552; x=1688820552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YkIAhLvLnVwhb1623YqvVKWgPZype03kjxLPtMN1rsU=;
        b=n+U+30vobooxgtQnaHc1KysZzSn6jdERYhOotJVB4hboAx6NrJumODxFOdJmZ5DVtc
         Rs6M5zIv+HTi015uuZJEVVUq6FifOjoHeBYLNh115+x3CLbJAxjVGM5lEd6NUp4M4OTG
         R/sKlueRfruZvQzLiy/iol6Zx7OEbiOPZldEwyV9m0NqWdJV766peMNlT+bGgfwz34QU
         1kKBi7/kL9N65y6V/mYW3u2V21U4Db51tGnIpBboUWvuqoj+MyyPPDWVJ12GNzQbjxZ/
         hbFfY4OG9tddUCgGs41XycnC9gSMTaES7Ipd74smgKrbqrPykhVjLjOf78R2AdPFTTbr
         tNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228552; x=1688820552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkIAhLvLnVwhb1623YqvVKWgPZype03kjxLPtMN1rsU=;
        b=Zb3vyOcmU23C92sN6CtXUFzlN0UYhUSWe44Z4plvzIH2oSq5L8iXLvl2H+XgA25k0y
         FtwKEW6RVqQ6OvvoD/0We5hqyKSHkDSGkMwcPvggG6R4MKjfORcQIXIJymPF3CVdxOmt
         kOewubK05yP334nJ3fSyO+JHI4rSpHU4gBhtg34DVaOEHeUAb6Qe8mc8CKnccJk1Raxx
         rT4fBZs/p6jixFjNDpw3UsMUOYchhcgJhy0IO9CSLu6qZjVcj/I63Ay9p6sUYKKzae3o
         Yds87vdyryauulUpLnOBMs85s4jqFd2XrM7ejV/ex5Y/tXJXjSv3MAwJsQZYvXsyxWzk
         yrbw==
X-Gm-Message-State: AC+VfDxm9pFZMzaDO9z1HMQCJP9YjGx8KtbeDQhfprGaMi12BHjMDtnn
        5PUwUlkJr68JEeMr2QZk/7UC
X-Google-Smtp-Source: ACHHUZ4iAqD/Jz411eyAzEsPuFH5BlY0kU8cHNTBiM1PkXwV+u8COwWL6C4wUXsw6nqiPx/Cjqj20w==
X-Received: by 2002:a05:6a20:549d:b0:10c:3cf3:ef7e with SMTP id i29-20020a056a20549d00b0010c3cf3ef7emr7532523pzk.42.1686228551815;
        Thu, 08 Jun 2023 05:49:11 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id s12-20020a63450c000000b0051b0e564963sm1185367pga.49.2023.06.08.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:49:11 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:19:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH 1/2] USB: dwc3: qcom: fix NULL-deref on suspend
Message-ID: <20230608124900.GE5672@thinkpad>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
 <20230607100540.31045-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607100540.31045-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:05:39PM +0200, Johan Hovold wrote:
> The Qualcomm dwc3 glue driver is currently accessing the driver data of
> the child core device during suspend and on wakeup interrupts. This is
> clearly a bad idea as the child may not have probed yet or could have
> been unbound from its driver.
> 
> The first such layering violation was part of the initial version of the
> driver, but this was later made worse when the hack that accesses the
> driver data of the grand child xhci device to configure the wakeup
> interrupts was added.
> 
> Fixing this properly is not that easily done, so add a sanity check to
> make sure that the child driver data is non-NULL before dereferencing it
> for now.
> 
> Note that this relies on subtleties like the fact that driver core is
> making sure that the parent is not suspended while the child is probing.
> 
> Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Link: https://lore.kernel.org/all/20230325165217.31069-4-manivannan.sadhasivam@linaro.org/
> Fixes: d9152161b4bf ("usb: dwc3: Add Qualcomm DWC3 glue layer driver")
> Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> Cc: stable@vger.kernel.org	# 3.18: a872ab303d5d: "usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup"
> Cc: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 959fc925ca7c..79b22abf9727 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -308,7 +308,16 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
>  /* Only usable in contexts where the role can not change. */
>  static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
>  {
> -	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> +	struct dwc3 *dwc;
> +
> +	/*
> +	 * FIXME: Fix this layering violation.
> +	 */
> +	dwc = platform_get_drvdata(qcom->dwc3);
> +
> +	/* Core driver may not have probed yet. */
> +	if (!dwc)
> +		return false;
>  
>  	return dwc->xhci;
>  }
> -- 
> 2.39.3
> 

-- 
மணிவண்ணன் சதாசிவம்
