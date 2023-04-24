Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB96EC5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDXGBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjDXGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:00:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF640C3;
        Sun, 23 Apr 2023 22:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682315991; x=1713851991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7fZxlv44jx7mpWlQVRHk0kqq7SqXLfuv7cMllKv067w=;
  b=kj/xMrNo57ATj7E0J6djSwhgAEehMHhXiGpTfTyxewtgHAnALd6QMIp8
   L6ByLn0jnra2b+GKOnW4Pgh+mhj9V5APUebYV6Q6Y854sEDyg+IYsAeiS
   VODtNwV4EmkadFEpujHEuLREsi9/YLZyRIN/2eI2gcF8Ebfsgoo9L2/75
   QaJys75gAsHLuTLVCnsLw150Ds/baRGH+23JNjVtWHbOMwqGQKXgg1JJW
   eMNNajA+HIjJcZKCuqr3jxP7zD+d5+lqDWxm15Q3AHgG6mx5pFUuksscO
   /mm/wc77WIqO+awQozqnVJE0R7kp1hTcCqDWKwHRY3BUjdw667CGo4xjH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="345126010"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="345126010"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="762292510"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="762292510"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2023 22:58:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DF02F11D; Mon, 24 Apr 2023 08:58:51 +0300 (EEST)
Date:   Mon, 24 Apr 2023 08:58:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        S Sanath <Sanath.S@amd.com>, richard.gong@amd.com,
        Sanju.Mehta@amd.com, Takashi Iwai <tiwai@suse.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Clear registers properly when auto clear
 isn't in use
Message-ID: <20230424055851.GR66750@black.fi.intel.com>
References: <20230421140725.495-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230421140725.495-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Fri, Apr 21, 2023 at 09:07:24AM -0500, Mario Limonciello wrote:
> When `QUIRK_AUTO_CLEAR_INT` isn't set, interrupt masking should be
> cleared by writing to Interrupt Mask Clear (IMR) and interrupt
> status should be cleared properly at shutdown/init.
> 
> This fixes an error where interrupts are left enabled during resume
> from hibernation with `CONFIG_USB4=y`.
> 
> Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217343
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> ---
> I tried to base this off thunderbolt.git/next (tag: thunderbolt-for-v6.4-rc1)
> but the following 3 commits are missing from that branch but are in 6.3-rc7:
> 
> 58cdfe6f58b3 thunderbolt: Rename shadowed variables bit to interrupt_bit and auto_clear_bit
> 468c49f44759 thunderbolt: Disable interrupt auto clear for rings
> 1716efdb0793 thunderbolt: Use const qualifier for `ring_interrupt_index`
> 
> I cherry picked them first as this patch builds on them.

Okay, so if I take this after v6.4-rc1 is released and send it forward
to for -rc2 Greg it should apply just fine?

> ---
>  drivers/thunderbolt/nhi.c      | 28 +++++++++++++++++++++-------
>  drivers/thunderbolt/nhi_regs.h |  1 +
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index d76e923fbc6a..7c543a6a5711 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -61,8 +61,9 @@ static int ring_interrupt_index(const struct tb_ring *ring)
>   */
>  static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  {
> -	int reg = REG_RING_INTERRUPT_BASE +
> -		  ring_interrupt_index(ring) / 32 * 4;
> +	int index = ring_interrupt_index(ring) / 32 * 4;
> +	int reg = REG_RING_INTERRUPT_BASE + index;
> +	int clear = REG_RING_INTERRUPT_MASK_CLEAR_BASE + index;
>  	int interrupt_bit = ring_interrupt_index(ring) & 31;
>  	int mask = 1 << interrupt_bit;
>  	u32 old, new;
> @@ -123,7 +124,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  					 "interrupt for %s %d is already %s\n",
>  					 RING_TYPE(ring), ring->hop,
>  					 active ? "enabled" : "disabled");
> -	iowrite32(new, ring->nhi->iobase + reg);
> +
> +	if (active)
> +		iowrite32(new, ring->nhi->iobase + reg);
> +	else
> +		iowrite32(mask, ring->nhi->iobase + clear);

Since it is doing this for all hardware, even for Intel, I will need to
run some testing to make sure this still works.

>  }
>  
>  /*
> @@ -135,12 +140,21 @@ static void nhi_disable_interrupts(struct tb_nhi *nhi)
>  {
>  	int i = 0;
>  	/* disable interrupts */
> -	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
> -		iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
> +	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++) {
> +		if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> +			iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
> +		else
> +			iowrite32(0xffffffff,

~0

> +				  nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + 4 * i);

Btw, we have now quite many places with

	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
		// Intel stuff
	else
		// non-Intel stuff

I wonder if we could move these behind a wrapper and then here (and
similar places) just call

	nhi_mask_interrupt(nhi, ...)


> +	}
>  
>  	/* clear interrupt status bits */
> -	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
> -		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
> +	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++) {
> +		if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> +			ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
> +		else
> +			iowrite32(0xffffffff, nhi->iobase + REG_RING_INT_CLEAR + 4 * i);

~0

	nhi_clear_interrupt(nhi, ...)

> +	}
>  }
>  
>  /* ring helper methods */
> diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
> index faef165a919c..db95ad5d2814 100644
> --- a/drivers/thunderbolt/nhi_regs.h
> +++ b/drivers/thunderbolt/nhi_regs.h
> @@ -92,6 +92,7 @@ struct ring_desc {
>   */
>  #define REG_RING_INTERRUPT_BASE	0x38200
>  #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) / 32)

Empty line here.

> +#define REG_RING_INTERRUPT_MASK_CLEAR_BASE	0x38208
>  
>  #define REG_INT_THROTTLING_RATE	0x38c00
>  
> -- 
> 2.34.1
