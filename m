Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF806BCC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCPKUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCPKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:20:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7DC17165;
        Thu, 16 Mar 2023 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678962005; x=1710498005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTWfBk3x3x+gBfiWBEncDsQaVQ9wjMxpSgAt7XwU7gA=;
  b=SW7eO7H2lNK5t3vyxZC6TC268M28YXUOPpogx4E6lTt72o9dQpBSL/LK
   ccnfee+mVkNwUWddpOTpVjhRxG8T3TIlNKXdR/kg2zNVmuNZepX4rkLSi
   uqEv4YXCIUbw2a3RP+flRsvm44Uo05ldRlXDxh3cAm+QSLrk2DoFI0mDV
   K41x70Mf+Vd1Lc/AXP3YrAmLanPF/j4CTGnLIz2V1GRyJvFgBzc1E/lyl
   +8C/miHPIcm8iE1lNyI1nO14Wi+JWFsH8jc8566ac4VBYW2uJPmsOVEDP
   o2NWqMcjPr/8PDctCDf/aeTTVPFXoQTw1PCpwVRYTFuAH9+7yYzOgbKbb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="337966831"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="337966831"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 03:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="1009169621"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009169621"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 03:20:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9A06C1CC; Thu, 16 Mar 2023 12:20:48 +0200 (EET)
Date:   Thu, 16 Mar 2023 12:20:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] thunderbolt: rename shadowed variables bit to
 interrupt_bit and auto_clear_bit
Message-ID: <20230316102048.GR62143@black.fi.intel.com>
References: <20230315220450.1470815-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315220450.1470815-1-trix@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Mario

On Wed, Mar 15, 2023 at 06:04:50PM -0400, Tom Rix wrote:
> cppcheck reports
> drivers/thunderbolt/nhi.c:74:7: style: Local variable 'bit' shadows outer variable [shadowVariable]
>   int bit;
>       ^
> drivers/thunderbolt/nhi.c:66:6: note: Shadowed declaration
>  int bit = ring_interrupt_index(ring) & 31;
>      ^
> drivers/thunderbolt/nhi.c:74:7: note: Shadow variable
>   int bit;
>       ^
> For readablity rename the outer to interrupt_bit and the innner
> to auto_clear_bit.

Thanks for the patch! Yeah, this did not show up in any of the kbuild
tests perhaps they are missing cppcheck :(

I'm thinking that I'll just move the two commits from "fixes" to "next"
and add this one on top (and drop the stable tags) as the code that we
should be sending to stable should not need additional fixes IMHO. I
know Mario is on vacation so probably cannot answer here so let's deal
with this when he is back.

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/thunderbolt/nhi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 318d20bd5b69..d0d26d288be8 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -63,15 +63,15 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  {
>  	int reg = REG_RING_INTERRUPT_BASE +
>  		  ring_interrupt_index(ring) / 32 * 4;
> -	int bit = ring_interrupt_index(ring) & 31;
> -	int mask = 1 << bit;
> +	int interrupt_bit = ring_interrupt_index(ring) & 31;
> +	int mask = 1 << interrupt_bit;
>  	u32 old, new;
>  
>  	if (ring->irq > 0) {
>  		u32 step, shift, ivr, misc;
>  		void __iomem *ivr_base;
> +		int auto_clear_bit;
>  		int index;
> -		int bit;
>  
>  		if (ring->is_tx)
>  			index = ring->hop;
> @@ -91,11 +91,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  		 */
>  		misc = ioread32(ring->nhi->iobase + REG_DMA_MISC);
>  		if (ring->nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> -			bit = REG_DMA_MISC_INT_AUTO_CLEAR;
> +			auto_clear_bit = REG_DMA_MISC_INT_AUTO_CLEAR;
>  		else
> -			bit = REG_DMA_MISC_DISABLE_AUTO_CLEAR;
> -		if (!(misc & bit))
> -			iowrite32(misc | bit, ring->nhi->iobase + REG_DMA_MISC);
> +			auto_clear_bit = REG_DMA_MISC_DISABLE_AUTO_CLEAR;
> +		if (!(misc & auto_clear_bit))
> +			iowrite32(misc | auto_clear_bit, ring->nhi->iobase + REG_DMA_MISC);
>  
>  		ivr_base = ring->nhi->iobase + REG_INT_VEC_ALLOC_BASE;
>  		step = index / REG_INT_VEC_ALLOC_REGS * REG_INT_VEC_ALLOC_BITS;
> @@ -115,7 +115,7 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  
>  	dev_dbg(&ring->nhi->pdev->dev,
>  		"%s interrupt at register %#x bit %d (%#x -> %#x)\n",
> -		active ? "enabling" : "disabling", reg, bit, old, new);
> +		active ? "enabling" : "disabling", reg, interrupt_bit, old, new);
>  
>  	if (new == old)
>  		dev_WARN(&ring->nhi->pdev->dev,
> -- 
> 2.27.0
