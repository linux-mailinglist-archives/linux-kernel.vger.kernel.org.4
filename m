Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913196D4F30
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDCRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjDCRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2ABA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCE062300
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E77DC433EF;
        Mon,  3 Apr 2023 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680543616;
        bh=RvPcLNdIyDQoHWqd1WZ9/rdoukI6sI7zASjdr3Ihk2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMAQTOerjuermXfBrC/PRjC1o/eT1qVBAuL3IBclx1JGM3/UeVgAexT6utNkuYsVE
         13MkAIeM6BoZc1G1wfwLrNg91L1MjVtPX+1HkRIme5yrQCconFwAdcHx5FLIPhJs3t
         j+HYQVS5pjFQ2JAMIAlbudvrDcUAjyCP7IhANPgbx9RbmQksnNYBTR4bV/BgbjhYVN
         G5f5yMxwxB+jCpNgfhHzmRWEVnDu+uEXlqaAL9t9lx5rzj24GWHnWapprQGQBA5oms
         YCRxsDrsls6qiCFqnIn2Skb/j6CGmNfL7Ivw2MZf2UBozsypWJ6U/BcxWerKUDKSF/
         0fanFX82y4xtw==
Date:   Mon, 3 Apr 2023 10:40:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: support to show noage_extent_cache mount option
Message-ID: <ZCsPfukvFHhiI6vN@google.com>
References: <20230330173127.46900-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330173127.46900-1-frank.li@vivo.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31, Yangtao Li wrote:
> This patch support noage_extent_cache mount option.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/filesystems/f2fs.rst | 2 ++
>  fs/f2fs/super.c                    | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index a81c896464ff..75505ab88de8 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -352,6 +352,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
>  			 data block update frequency of the extent per inode, in
>  			 order to provide better temperature hints for data block
>  			 allocation.
> +noage_extent_cache		 Disable an age extent cache based on rb-tree, see
> +			 the above age_extent_cache mount option.

Hmm, why do we need?

>  ======================== ============================================================
>  
>  Debugfs Entries
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b5828a67f7c1..8bd9953ea7e3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -165,6 +165,7 @@ enum {
>  	Opt_discard_unit,
>  	Opt_memory_mode,
>  	Opt_age_extent_cache,
> +	Opt_noage_extent_cache,
>  	Opt_err,
>  };
>  
> @@ -244,6 +245,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_discard_unit, "discard_unit=%s"},
>  	{Opt_memory_mode, "memory=%s"},
>  	{Opt_age_extent_cache, "age_extent_cache"},
> +	{Opt_noage_extent_cache, "noage_extent_cache"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -1269,6 +1271,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_age_extent_cache:
>  			set_opt(sbi, AGE_EXTENT_CACHE);
>  			break;
> +		case Opt_noage_extent_cache:
> +			clear_opt(sbi, AGE_EXTENT_CACHE);
> +			break;
>  		default:
>  			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>  				 p);
> @@ -1974,6 +1979,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",noextent_cache");
>  	if (test_opt(sbi, AGE_EXTENT_CACHE))
>  		seq_puts(seq, ",age_extent_cache");
> +	else
> +		seq_puts(seq, ",noage_extent_cache");
>  	if (test_opt(sbi, DATA_FLUSH))
>  		seq_puts(seq, ",data_flush");
>  
> -- 
> 2.35.1
