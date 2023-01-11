Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1E665547
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAKHm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjAKHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:42:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDD101DC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:42:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79156B81B2B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D36EC433D2;
        Wed, 11 Jan 2023 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673422967;
        bh=6vwfS/HieVm6Bs5Q5FJVtSkA7HywwcPrCm8vCLfi4Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4/FsZOctS+CYey6D0HLJzOOOa2Nv+ZoGPBRVxZT1z5ZuqfVazLEN/RY5yuL+TsZm
         0I/RMtTmO6RHMN+g1rPJ4CL1QmdEUQiOrpB28Qqx418UcXz7SLwYW+ucb8Dg0MLQLW
         owQz3MSpqjGUI4MOjLfxU7swCGpO/ILTldHVQlv0=
Date:   Wed, 11 Jan 2023 08:42:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <me@linux.beauty>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Li Chen <lchen@ambarella.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: allow to use regmap for print regs
Message-ID: <Y75odDyZXMzigoaL@kroah.com>
References: <20230111072130.3885460-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111072130.3885460-1-me@linux.beauty>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 03:21:29PM +0800, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> Currently, debugfs_regset32 only contains void __iomem *base,
> and it is not friendly to regmap user.
> 
> Let's add regmap to debugfs_regset32, and add debugfs_print_regmap_reg32
> to allow debugfs_regset32_show handle regmap.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>

Do you have an actual in-kernel user for this new function?  We can't
accept new apis without users for obvious reasaons.

And can you provide more documentation in the changelog text as to what
the new function is and how it should be used?

> ---
> Changelog:
> 
> v1 -> v2:
> 
> Suggested by Greg, provide a new function for regmap instead of trying to overload old function.
> ---
>  fs/debugfs/file.c       | 46 ++++++++++++++++++++++++++++++++++++++++-
>  include/linux/debugfs.h | 10 +++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index b54f470e0d03..f204b27f757f 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1137,14 +1137,58 @@ void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
>  }
>  EXPORT_SYMBOL_GPL(debugfs_print_regs32);
>  
> +/**
> + * debugfs_print_regmap_regs32 - use seq_print to describe a set of registers
> + * @s: the seq_file structure being used to generate output
> + * @regs: an array if struct debugfs_reg32 structures
> + * @nregs: the length of the above array
> + * @regmap: regmap to be used in reading the registers
> + * @prefix: a string to be prefixed to every output line
> + *
> + * This function outputs a text block describing the current values of
> + * some 32-bit hardware registers. It is meant to be used within debugfs
> + * files based on seq_file that need to show registers, intermixed with other
> + * information. The prefix argument may be used to specify a leading string,
> + * because some peripherals have several blocks of identical registers,
> + * for example configuration of dma channels
> + */
> +void debugfs_print_regmap_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
> +			  int nregs, struct regmap *regmap, char *prefix)
> +{
> +	int i;
> +	u32 val;
> +
> +	for (i = 0; i < nregs; i++, regs++) {
> +		if (prefix)
> +			seq_printf(s, "%s", prefix);
> +		regmap_read(regmap, regs->offset, &val);
> +		seq_printf(s, "%s = 0x%08x\n", regs->name, val);
> +		if (seq_has_overflowed(s))
> +			break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(debugfs_print_regmap_regs32);
> +
>  static int debugfs_regset32_show(struct seq_file *s, void *data)
>  {
>  	struct debugfs_regset32 *regset = s->private;
> +	void __iomem *base = regset->base;
> +	struct regmap *regmap = regset->regmap;
> +
> +	if ((regmap && base) || (!regmap && !base)) {
> +		seq_puts(
> +			s,
> +			"You should provide one and only one between base and regmap!\n");

So you report the error in the debugfs file itself?  While interesting,
that's not a normal way of reporting problems.

Also your formatting here is really not normal, please fix that.

> +		return -EINVAL;
> +	}
>  
>  	if (regset->dev)
>  		pm_runtime_get_sync(regset->dev);
>  
> -	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
> +	if (base)
> +		debugfs_print_regs32(s, regset->regs, regset->nregs, base, "");
> +	if (regmap)

Can't this just be an "else"?

thanks,

greg k-h
