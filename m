Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09766548A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAKG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjAKG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:26:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248D10A3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A08F4B81B2B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857D2C433D2;
        Wed, 11 Jan 2023 06:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673418355;
        bh=bzVrjVDU74N7h6Xob+7BH0CWSxDE9OMpqjosSxxpP9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spNlNLqWRYOS5IrMrM80Dkv0npb6NuwxJZrwYYI57rYK3IEE3Q+CQ0avuXHWGiN38
         NuetdYxiQNHVla0HJ0jxWXRSc11uGZhmddsoYyxS6JoSydZnHIvAQGBDb5c0p3nNlQ
         qmvVAewB/s0/IbiNeE3AtKn5ZNo4cBctpdJiMSJE=
Date:   Wed, 11 Jan 2023 07:25:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <me@linux.beauty>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: allow to use regmap for print regs
Message-ID: <Y75Wbya+U9F9UPJO@kroah.com>
References: <20230111061541.3657154-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111061541.3657154-1-me@linux.beauty>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:15:41PM +0800, Li Chen wrote:
> Currently, debugfs_regset32 only contains void __iomem *base,
> and it is not friendly to regmap user.
> 
> Let's add regmap to debugfs_regset32, and add regmap
> support to debugfs_print_reg32.
> 
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
>  fs/debugfs/file.c       | 23 +++++++++++++++++++----
>  include/linux/debugfs.h | 10 +++++++---
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index b54f470e0d03..c4663cfc20b6 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1112,8 +1112,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
>   * @regs: an array if struct debugfs_reg32 structures
>   * @nregs: the length of the above array
>   * @base: the base address to be used in reading the registers
> + * @regmap: regmap to be used in reading the registers
>   * @prefix: a string to be prefixed to every output line
>   *
> + * user should pick one of two from base and regmap
>   * This function outputs a text block describing the current values of
>   * some 32-bit hardware registers. It is meant to be used within debugfs
>   * files based on seq_file that need to show registers, intermixed with other
> @@ -1122,15 +1124,27 @@ EXPORT_SYMBOL_GPL(debugfs_create_u32_array);
>   * for example configuration of dma channels
>   */
>  void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
> -			  int nregs, void __iomem *base, char *prefix)
> +			  int nregs, void __iomem *base, struct regmap *regmap,
> +			  char *prefix)

This is confusing, please just provide a new function for regmap instead
of trying to overload this function.  You can use the same function
inside the debugfs core like this, but never export such a complex set
of parameters to actual users, that's just painful.

thanks,

greg k-h
