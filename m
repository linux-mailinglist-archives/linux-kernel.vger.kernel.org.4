Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC8677A62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjAWLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjAWLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:52:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA176BB;
        Mon, 23 Jan 2023 03:52:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45FE660D41;
        Mon, 23 Jan 2023 11:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A8DC433EF;
        Mon, 23 Jan 2023 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674474768;
        bh=SEl4ANWe5oATt+uLZVRHPCdsSg++lvaBG5FZKtWEm4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Saf/zMbCH96islMlFClr4MW7iG9lGy5n1dNgfSfTFV586F7zBPh1k+Y6SkXjfKSVy
         hz+0oKDP4IJbB8teaVvhOAUahdufYubb5NNYCRv2O6jKNRlusSIsCgDeN7n3gQqstz
         VbCP5VscHJL9Yb2RvmiVmIVY0pnSvnMT4DXrwC9I=
Date:   Mon, 23 Jan 2023 12:52:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Li Chen <me@linux.beauty>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] debugfs: allow to use regmap for print regs
Message-ID: <Y851DWfj+hZIiR38@kroah.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-2-lchen@ambarella.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123073305.149940-2-lchen@ambarella.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:32:16PM +0800, Li Chen wrote:
> Currently, debugfs_regset32 only contains void __iomem *base,
> and it is not friendly to regmap user.
> 
> Let's add regmap to debugfs_regset32, and add regmap
> support to debugfs_print_reg32.
> 
> Signed-off-by: Li Chen <me@linux.beauty>
> Change-Id: I8ef015ed0906a4ad85b7592f771dcf64c23f7832

No change-id please.

> ---
>  Documentation/filesystems/debugfs.rst |  2 ++
>  fs/debugfs/file.c                     | 43 ++++++++++++++++++++++++++-
>  include/linux/debugfs.h               | 11 +++++++
>  3 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
> index dc35da8b8792..b2c76ac3a333 100644
> --- a/Documentation/filesystems/debugfs.rst
> +++ b/Documentation/filesystems/debugfs.rst
> @@ -178,6 +178,8 @@ file::
>  
>      void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
>  			 int nregs, void __iomem *base, char *prefix);
> +    void debugfs_print_regmap_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
> +			 int nregs, struct regmap *regmap*, char *prefix);

One too many "*" characters on that last line, right?

>  
>  The "base" argument may be 0, but you may want to build the reg32 array
>  using __stringify, and a number of register names (macros) are actually
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index b54f470e0d03..2fb792843b30 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1137,14 +1137,55 @@ void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
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
>  
> +	void __iomem *base = regset->base;
> +	struct regmap *regmap = regset->regmap;

Why the extra blank line?  Did you run checkpatch?

And it's generally not considered a good idea to dereference a pointer
_before_ it is checked.  It will not crash, but static checkers will
have a field day with it.


> +
> +	if ((regmap && base) || (!regmap && !base))
> +		return -EINVAL;
> +
>  	if (regset->dev)
>  		pm_runtime_get_sync(regset->dev);
>  
> -	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
> +	if (base)
> +		debugfs_print_regs32(s, regset->regs, regset->nregs, base, "");
> +	else
> +		debugfs_print_regmap_regs32(s, regset->regs, regset->nregs, regmap, "");
>  
>  	if (regset->dev)
>  		pm_runtime_put(regset->dev);
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index ea2d919fd9c7..87dfea6a25a0 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -17,6 +17,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/compiler.h>
> +#include <linux/regmap.h>

No need to include this here, just provide a prototype for "struct
regmap" and all will be fine.

thanks,

greg k-h
