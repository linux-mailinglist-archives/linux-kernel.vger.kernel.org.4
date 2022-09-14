Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8815B81CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiINHJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37C5A8A7;
        Wed, 14 Sep 2022 00:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E655617C2;
        Wed, 14 Sep 2022 07:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F179FC433D6;
        Wed, 14 Sep 2022 07:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663139362;
        bh=4qaiOzRX06Dcp86Qw4AyJXoFbpAVDJ6myGvrqmUKEVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9WzKer3Fcmv9pO/0wa7orIhM29sqOtc5CKviBsgf8TZ6WMDjGK7YybhHooprjrDQ
         CKqyXLvhL2EqsEosAFSk9v1+9ohcxB6uC2ZhpCE8c8MiR8IhJnsWcYZtJR8ELn+oaG
         J8kNucIEkvZk+JGmZ8uRKbOx49w7gEyhvZX4SAiLmGXHJVyOq4DsJLJpRT80j8vtKy
         EUtAd1n/MNVtQUlpXlmdHwT3Th/if1G/cHRacpi+ekzzuXbfQFXms8FN2FajNCkxhq
         I/gTvEDFpTBalSIygYF6vzX03gbFGbZWIjujZNYFAeOlrNnDC6hglY4B0u21mWMGuw
         8NjTOcju0bz2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYMWQ-0003Go-2T; Wed, 14 Sep 2022 09:09:22 +0200
Date:   Wed, 14 Sep 2022 09:09:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, mka@chromium.org, johan+linaro@kernel.org,
        quic_kriskura@quicinc.com, dianders@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sc7280: Update the .pwrsts for usb
 gdsc
Message-ID: <YyF+IuoDjBZzEQxO@hovoldconsulting.com>
References: <20220901101756.28164-1-quic_rjendra@quicinc.com>
 <20220901101756.28164-3-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901101756.28164-3-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:47:56PM +0530, Rajendra Nayak wrote:
> USB on sc7280 cannot support wakeups from low power states
> if the GDSC is turned OFF. Update the .pwrsts for usb GDSC so it
> only transitions to RET in low power.

It seems this isn't just needed for wakeup to work. On both sc7280 and
sc8280xp the controller doesn't resume properly if the domain has been
powered off (i.e. regardless of whether wakeup is enabled or not).

Are you sure there's no state that needs to be retained regardless of
the wakeup setting?

> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-sc7280.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 7ff64d4d5920..de29a034e725 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -3126,7 +3126,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
>  	.pd = {
>  		.name = "gcc_usb30_prim_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  	.flags = VOTABLE,
>  };

And what about gcc_usb30_sec_gdsc?

Johan
