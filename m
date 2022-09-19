Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA35BD15A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiISPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiISPpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6649B868;
        Mon, 19 Sep 2022 08:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CFF61E19;
        Mon, 19 Sep 2022 15:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14B0C433D6;
        Mon, 19 Sep 2022 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663602309;
        bh=cxxsbz/kD42NUOGTrCrQ7/POmnTB4Lz8V/hj+LYf154=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDXWuBKL1qeJDKUTH5/vTdRc52mNC1AjYMFh8PAFDdjnX4bERc7i5orlr46m4tAHP
         MrVKsJaGanEBk+AAgcqYIAcqqkKvMUBm9n3vAqaNa3Ok51CEtDKnVXDoCJQQs66RdT
         i5ekxSf/s/8IT4wVtfvhHd4qrxKYBeDS0dln6kdtzVV6pExhQh7fbTXa4VtDMnEPlS
         1BqnGwASMdnaqXpn0UYy98FJcvZLvx3ClSeB3RvRbUfhOhdTaY9DguF2dh1AmAin2B
         owo3kjp9FqMsvzuJmnXG6/+vXmAYatSNZE9TvxwCKtWoz30RAFbJrLNNbTiWpOM3Cw
         T+nFCcoMnI/SQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaIxO-0005fh-B2; Mon, 19 Sep 2022 17:45:14 +0200
Date:   Mon, 19 Sep 2022 17:45:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        quic_kriskura@quicinc.com, dianders@chromium.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-sc7180: Update the .pwrsts for usb
 gdsc
Message-ID: <YyiOiudZuMDXOvGr@hovoldconsulting.com>
References: <20220916102417.24549-1-quic_rjendra@quicinc.com>
 <20220916102417.24549-2-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916102417.24549-2-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:54:16PM +0530, Rajendra Nayak wrote:
> The USB controller on sc7180 does not retain the state when
> the system goes into low power state and the GDSC is
> turned off. This results in the controller reinitializing and
> re-enumerating all the connected devices (resulting in additional
> delay while coming out of suspend)
> Fix this by updating the .pwrsts for the USB GDSC so it only
> transitions to retention state in low power.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
> Updated the changelog
> 
>  drivers/clk/qcom/gcc-sc7180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> index c2ea09945c47..2d3980251e78 100644
> --- a/drivers/clk/qcom/gcc-sc7180.c
> +++ b/drivers/clk/qcom/gcc-sc7180.c
> @@ -2224,7 +2224,7 @@ static struct gdsc usb30_prim_gdsc = {
>  	.pd = {
>  		.name = "usb30_prim_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  };
>  
>  static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {

It seems like the above will not work unless you also provide the
registers offsets that gdsc_force_mem_on() expects.

Specifically, unless you set cxc_count for the GDSC, the above call is a
no-op and the retention setting (i.e. the RETAIN_MEM and RETAIN_PERIPH
bits) will not be updated when registering the GDSC.

Johan
