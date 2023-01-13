Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3266A3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjAMUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjAMUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3E25565A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673641065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V54z6rLYX2VOlDzoy2qPL6F5L+cbM84DrtMdlJiXWFI=;
        b=BpHbHXXsPXCmweM39OLplnegp0/V54uJ9cQmjT8AzjfsznBNJykRUMBNWLcV/ZVw4FcRFD
        yIMjbiHdPj7MTTAF6KtVRxfzsRjwVhYYn6rSjHE7YJAAoM8hycd7PuDmNpPfYMihRsbYZE
        bq26FPqLqpWjAZq6zqnRKGuPkrNVsFA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-h3mmt4EGMjOf6SvgpWWj5g-1; Fri, 13 Jan 2023 15:14:33 -0500
X-MC-Unique: h3mmt4EGMjOf6SvgpWWj5g-1
Received: by mail-ot1-f70.google.com with SMTP id e20-20020a9d5614000000b0068401872536so11011034oti.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V54z6rLYX2VOlDzoy2qPL6F5L+cbM84DrtMdlJiXWFI=;
        b=g+v20FglBxCD/8IlhmSmPX+aLmZ7QQqvD6au3qoPAiyk4MgZs1LlZGIJp5woexPf0u
         QqWGTUwmp3VV8XmhEsEXAQGiFTGJ7HH0b177mNJHARyN+7XVEwP5Ar8K86eIerzW+NLz
         PEuNFfnz06bJhBnlbZg2nVKopxCGZDMlb9zN0fxdz8gzY3lqW7uCkzZi68PyaqCGBcl7
         VUwtIx3YECVvBCTMSNUcZKkmpKOoFX65YAio79tclkVhcUrLm/k0T69Tx6uPgdzYyRb0
         RrZwrQebljXblW/RvgJI6yK3ocNhHtU1oYHpo5VQPQMZFuUqvxxfx/X1P18n/JFo7Bgp
         dvnw==
X-Gm-Message-State: AFqh2kpGHJsIduzgD36j5xDuIhnpGfwvtpxXJ0MLSWXTHcvizDzBO3zY
        tghNuGvshO2rNf8Axi97rF2dJUDyObkLX2f2DW3tcXHa23gE2hjIXNbccbmYfqDhOkcfrugdOyy
        4eYAiek+JzIoxuFypqPBq1nha
X-Received: by 2002:a4a:840b:0:b0:4a3:7135:d6e6 with SMTP id l11-20020a4a840b000000b004a37135d6e6mr27292072oog.2.1673640873201;
        Fri, 13 Jan 2023 12:14:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9qurBkZ0NHbx4xl/ouYmunfvjOxLSlaDzU3BupNJH5CSmq96OKqhSoII4T2zcJaJLgYoaaA==
X-Received: by 2002:a4a:840b:0:b0:4a3:7135:d6e6 with SMTP id l11-20020a4a840b000000b004a37135d6e6mr27292066oog.2.1673640872939;
        Fri, 13 Jan 2023 12:14:32 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id y139-20020a4a4591000000b004c60069d1fbsm3018728ooa.11.2023.01.13.12.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:14:32 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:14:30 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Remove need for clk_ignore_unused on sc8280xp
Message-ID: <20230113201430.c4oa46ry2bx2axhd@halaney-x13s>
References: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041038.4188995-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:10:38PM -0800, Bjorn Andersson wrote:
> With the transition of disabling unused clocks at sync_state, rather
> than late_initcall() it's now possible to drop clk_ignore_unused and
> unused clock disabled once client drivers have probed. Do this on
> SC8280XP.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s

I've booted with this (and without clk_ignore_unused) a few times today
and have been working with on the machine without any apparent issues.

Thanks! It is nice to have to modify less of the kernel cli to boot.

> ---
>  drivers/clk/qcom/dispcc-sc8280xp.c | 1 +
>  drivers/clk/qcom/gcc-sc8280xp.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
> index 167470beb369..c84a6481b879 100644
> --- a/drivers/clk/qcom/dispcc-sc8280xp.c
> +++ b/drivers/clk/qcom/dispcc-sc8280xp.c
> @@ -3199,6 +3199,7 @@ static struct platform_driver disp_cc_sc8280xp_driver = {
>  	.driver = {
>  		.name = "disp_cc-sc8280xp",
>  		.of_match_table = disp_cc_sc8280xp_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index b3198784e1c3..f4fdc5b9663c 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -7441,6 +7441,7 @@ static struct platform_driver gcc_sc8280xp_driver = {
>  	.driver = {
>  		.name = "gcc-sc8280xp",
>  		.of_match_table = gcc_sc8280xp_match_table,
> +		.sync_state = clk_sync_state_disable_unused,
>  	},
>  };
>  
> -- 
> 2.37.3
> 

