Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC78749DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjGFNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjGFNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62262E3;
        Thu,  6 Jul 2023 06:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C365E61961;
        Thu,  6 Jul 2023 13:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27443C433C7;
        Thu,  6 Jul 2023 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688650680;
        bh=LC3t7eT1Kvk5CLFjOHmNaPdZRgDkQ/pwMLYX9fmEvyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9AJe3Fje3vk5hPEAky5FaD8Wfetl4SvFs7kTTo1uO0juzIHJJmOkiNWXhCuMPeZ3
         2P5W+ppmfj7/ExrSLUWV3WKPWuoFUUR+nLG+BcPm7TVfqAIdw8M9auZ5KNovm1dlLj
         cBFa07Hpq0l+xzfCMz+D1ZXdiYFab6Fck1fuxNzkDBOawUgMbwhG8ynqGwJ7yxLX9I
         ONpCJ4mMAqMzH76Yk7D2tGMCqxI9N+vnF6wB7gnyeblyvviAV90BstCrpAawHDTebI
         OS2JWzidvuHCf67XvQsdwDZRycM6Gs2yUpalKQV6PWdgL11CLECTeLvxnsh/aa/ZOL
         WgEBWGqOGysSA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHPBe-0002ed-37;
        Thu, 06 Jul 2023 15:38:23 +0200
Date:   Thu, 6 Jul 2023 15:38:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "clk: gcc-sc8280xp: keep PCIe power-domains
 always-on"
Message-ID: <ZKbDztmNp-KMXTDu@hovoldconsulting.com>
References: <20230706124700.12447-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706124700.12447-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:17:00PM +0530, Manivannan Sadhasivam wrote:
> This reverts commit 12d2a4769380f0dc9ba6f827839869db2b81ef00.

Please update the commit summary and remove or rephrase the above as
direct reverts are typically used for patches that were broken or causes
trouble (e.g rephrase as "allow pcie gdsdc to be disabled" or similar).

The patch in question was correct at the time even if it may no longer
be required, but see below.

> With the minimal system suspend support in place for the PCIe driver that
> keeps the interconnect path active, the ALWAYS_ON flags can now be dropped.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sc8280xp.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index 04a99dbaa57e..07eb6110442c 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -6774,10 +6774,6 @@ static struct gdsc pcie_1_tunnel_gdsc = {
>  	.flags = VOTABLE,
>  };
>  
> -/*
> - * The Qualcomm PCIe driver does not yet implement suspend so to keep the
> - * PCIe power domains always-on for now.
> - */
>  static struct gdsc pcie_2a_gdsc = {
>  	.gdscr = 0x9d004,
>  	.collapse_ctrl = 0x52128,
> @@ -6786,7 +6782,7 @@ static struct gdsc pcie_2a_gdsc = {
>  		.name = "pcie_2a_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE | ALWAYS_ON,
> +	.flags = VOTABLE,
>  };

Are you sure this is correct? Won't the controller state be lost if the
GDSC is powered off during suspend? Shouldn't this be PWRSTS_RET_ON at
least?

Johan
