Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECF3702CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbjEOMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbjEOMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F1A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E995F623AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DC4C433D2;
        Mon, 15 May 2023 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684154644;
        bh=6Vjkl3qo29U5E9mKvpbP59A5xR2uHZ1AIh8jRWW9Y2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEMrSUnY+U9/fuzSF3i2vuhlc2eXS79heNK/CJaksS0FkDK6mj8V6yYfh8bdFyN79
         aUMrB+Rm5jShbiAMtYaHdIydV8fQvHXcHtkoJIGXIRRORh6FPzqLP+feL07kY5OPqz
         wtPujsaqceYag0SoM9NhQ3rntZkm8tNOi5b5WOk5bpqTbw4v3JXjzveWx2Rdpre8Af
         JCEJ1csegP2cS681isl3V6rTCx/BvZcuDBajtoscdjJU3X6DuDDriMmaK0FuVqVVK4
         oKl0URCUBSwcrrH9vi+mYy8/Q/H1FtYvngDuuvPExOh+1NydrjnAv1Yho3LW8dobcK
         yEHrURPYwgUQQ==
Date:   Mon, 15 May 2023 13:43:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     p.paillet@st.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: stpmic1: fixup main control register and bits
 naming
Message-ID: <20230515124359.GE10825@google.com>
References: <20230428112847.2146348-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230428112847.2146348-1-sean@geanix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023, Sean Nyekjaer wrote:

> Fixup main control register and bits naming so the match the naming from
> the datasheet.
 
I'm in two minds about this.

On one hand using the names from the datasheet in the right thing to
do, however, on the other hand, the current nomenclature appears clearer.

> https://www.st.com/resource/en/datasheet/stpmic1.pdf
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/mfd/stpmic1.c       |  4 ++--
>  include/linux/mfd/stpmic1.h | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> index 8db1530d9bac..4c9b18d9dec8 100644
> --- a/drivers/mfd/stpmic1.c
> +++ b/drivers/mfd/stpmic1.c
> @@ -19,7 +19,7 @@
>  
>  static const struct regmap_range stpmic1_readable_ranges[] = {
>  	regmap_reg_range(TURN_ON_SR, VERSION_SR),
> -	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
> +	regmap_reg_range(MAIN_CR, LDO6_STDBY_CR),
>  	regmap_reg_range(BST_SW_CR, BST_SW_CR),
>  	regmap_reg_range(INT_PENDING_R1, INT_PENDING_R4),
>  	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
> @@ -30,7 +30,7 @@ static const struct regmap_range stpmic1_readable_ranges[] = {
>  };
>  
>  static const struct regmap_range stpmic1_writeable_ranges[] = {
> -	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
> +	regmap_reg_range(MAIN_CR, LDO6_STDBY_CR),
>  	regmap_reg_range(BST_SW_CR, BST_SW_CR),
>  	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
>  	regmap_reg_range(INT_SET_MASK_R1, INT_SET_MASK_R4),
> diff --git a/include/linux/mfd/stpmic1.h b/include/linux/mfd/stpmic1.h
> index fa3f99f7e9a1..dc00bac24f5a 100644
> --- a/include/linux/mfd/stpmic1.h
> +++ b/include/linux/mfd/stpmic1.h
> @@ -15,7 +15,7 @@
>  #define RREQ_STATE_SR		0x5
>  #define VERSION_SR		0x6
>  
> -#define SWOFF_PWRCTRL_CR	0x10
> +#define MAIN_CR			0x10
>  #define PADS_PULL_CR		0x11
>  #define BUCKS_PD_CR		0x12
>  #define LDO14_PD_CR		0x13
> @@ -148,14 +148,14 @@
>  #define LDO_BYPASS_MASK			BIT(7)
>  
>  /* Main PMIC Control Register
> - * SWOFF_PWRCTRL_CR
> + * MAIN_CR
>   * Address : 0x10
>   */
> -#define ICC_EVENT_ENABLED		BIT(4)
> +#define OCP_OFF_DBG			BIT(4)
>  #define PWRCTRL_POLARITY_HIGH		BIT(3)
> -#define PWRCTRL_PIN_VALID		BIT(2)
> -#define RESTART_REQUEST_ENABLED		BIT(1)
> -#define SOFTWARE_SWITCH_OFF_ENABLED	BIT(0)
> +#define PWRCTRL_ENABLE			BIT(2)
> +#define RESTART_REQUEST_ENABLE		BIT(1)
> +#define SOFTWARE_SWITCH_OFF		BIT(0)
>  
>  /* Main PMIC PADS Control Register
>   * PADS_PULL_CR
> -- 
> 2.40.0
> 

-- 
Lee Jones [李琼斯]
