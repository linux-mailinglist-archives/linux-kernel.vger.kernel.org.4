Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF7702DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbjEONVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbjEONVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:21:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604F6359E;
        Mon, 15 May 2023 06:20:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64ab2a37812so19867281b3a.1;
        Mon, 15 May 2023 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684156851; x=1686748851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=556nYuO56WZTzYwwksX3EP6QHKSVQy372C8veZxpPPA=;
        b=TqGmbn24ScTKY9syGDRQQ8o0eYzQLlcRl7NpSw5ExsiKGCaDFSrONJXJ7c06twh565
         vTHfQwc/1UBLDbzfExMCdgTQBGgNGHnznYVo0Wh+T9fE/Jh0b76ZIQFZziGRh3/c+TNN
         eEUmVF3x0tVnFmlQevJ/UGKyYLg1rynC1s7UKmIJS9mYmAqtNA8dsU2k+ybl8PPH9z+0
         Rqk+O/hCu9YKk+jd3CVUE+PuQy85mPDDqAvCwGEeXYCO18AYl+X7jA+H1DxrLEUP1JR4
         FK1DlCh2mjC6quS5nP34k7q/jp1tZsH5buF9ULKWfWA08StyywSaDyODaThFnZyFHD7T
         qZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156851; x=1686748851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=556nYuO56WZTzYwwksX3EP6QHKSVQy372C8veZxpPPA=;
        b=HjhaEoKR2aTuYrONhVreFF3f5ExBBFp3kcFTdJMlaHFkXIvIhI+z1KENi+P4Hun4DN
         XEmMqAKTymydP6MTY38x3T9HzWtdxPKdlivy8FhhvJnopTwX737z15NdfrKYn52nxNnf
         SicqDa+CvbNnt/cpym7citz01LTuK0q8t1Rhtwq9tGk0z1kgjYll9HdXAVZ9jzIT9pDB
         /6mhDkhw5ORfhFDaKVhZR33gvMoAvlD9S6a+U1mNlfMmi43r72T/NJHAQObvnqYkNSst
         dPxuVcwvT0LVvs9ruYFkw0KB6EobGa3m1XTulPBg1blXLZh31OysnVVuXAIbUxc/sTuX
         RK5A==
X-Gm-Message-State: AC+VfDwnLMm0Xn2oDGG9PSeurRAiFr93okK0ZpLdnn4FM73ycWIMc2l5
        FVQZcZhRI80k1sEmg6pI1OA=
X-Google-Smtp-Source: ACHHUZ4P7TMRD9U4yfQrRyTpKk/rdXv7hryKTuWdmyx2JL+gPpfogckaAf3qyMxD4IYH+bHMD7YxRQ==
X-Received: by 2002:a05:6a20:441c:b0:101:6908:2b03 with SMTP id ce28-20020a056a20441c00b0010169082b03mr26423003pzb.25.1684156851046;
        Mon, 15 May 2023 06:20:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b006414c3ba8a3sm12147098pfo.177.2023.05.15.06.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:20:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 May 2023 06:20:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tom Rix <trix@redhat.com>
Cc:     bryan.odonoghue@linaro.org, heikki.krogerus@linux.intel.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: qcom: set pm8150b_typec_res
 storage-class-specifier to static
Message-ID: <a1d0c542-0e77-4ccc-b509-66daf1941b21@roeck-us.net>
References: <20230515114043.3452010-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515114043.3452010-1-trix@redhat.com>
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

On Mon, May 15, 2023 at 07:40:43AM -0400, Tom Rix wrote:
> smatch reports
> drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c:323:29: warning: symbol
>   'pm8150b_typec_res' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index 191458ce4a06..937e855a6c4c 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -320,7 +320,7 @@ static struct pmic_typec_port_resources pm8150b_port_res = {
>  	.nr_irqs = 7,
>  };
>  
> -struct pmic_typec_resources pm8150b_typec_res = {
> +static struct pmic_typec_resources pm8150b_typec_res = {
>  	.pdphy_res = &pm8150b_pdphy_res,
>  	.port_res = &pm8150b_port_res,
>  };
> -- 
> 2.27.0
> 
