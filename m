Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D815B323C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIIItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiIIItj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:49:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3779326D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47D67B82426
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC58C433C1;
        Fri,  9 Sep 2022 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662713370;
        bh=7r6eFPc4ylLEiyUwT0RhkbsWwbritIOgdyq814MG0hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCNSO9GRA9dlr07oiSSVmZA8DXue/Rqhg2lR/hifxAYQMP0z7gXKtgFpMew0vqjcu
         4CmPkC7JgRK79hU1aL14SFpMfRPE4A792n7Atc2FngftJUTsSENHcdLwnLPS94lPbZ
         gYrJgHnopsop8ol2csyme80SfU8rrAiQnmkY0/Ko=
Date:   Fri, 9 Sep 2022 10:49:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] debugfs: Only clobber mode/uid/gid on remount if asked
Message-ID: <Yxr+GFUnLVaoiSCn@kroah.com>
References: <20220908171319.v2.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908171319.v2.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 05:13:22PM -0700, Brian Norris wrote:
> Users may have explicitly configured their debugfs permissions; we
> shouldn't overwrite those just because a second mount appeared.
> 
> Only clobber if the options were provided at mount time.
> 
> Existing behavior:
> 
>   ## Pre-existing status: debugfs is 0755.
>   # chmod 755 /sys/kernel/debug/
>   # stat -c '%A' /sys/kernel/debug/
>   drwxr-xr-x
> 
>   ## New mount sets kernel-default permissions:
>   # mount -t debugfs none /mnt/foo
>   # stat -c '%A' /mnt/foo
>   drwx------
> 
>   ## Unexpected: the original mount changed permissions:
>   # stat -c '%A' /sys/kernel/debug
>   drwx------
> 
> New behavior:
> 
>   ## Pre-existing status: debugfs is 0755.
>   # chmod 755 /sys/kernel/debug/
>   # stat -c '%A' /sys/kernel/debug/
>   drwxr-xr-x
> 
>   ## New mount inherits existing permissions:
>   # mount -t debugfs none /mnt/foo
>   # stat -c '%A' /mnt/foo
>   drwxr-xr-x
> 
>   ## Expected: old mount is unchanged:
>   # stat -c '%A' /sys/kernel/debug
>   drwxr-xr-x
> 
> Full test cases are being submitted to LTP.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Temporary LTP branch here:
> https://github.com/computersforpeace/ltp/commits/debugfs
> 
> I'll put in an LTP pull request once the kernel tree actually contains
> my patches.
> 
> Companion patch:
>   tracefs: Only clobber mode/uid/gid on remount if asked
>   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?h=trace-v6.0-rc4&id=47311db8e8f33011d90dee76b39c8886120cdda4
> 
> Changes in v2:
> * Update commit description
> * Include LTP patch in notes
> * Split from tracefs patch
> 
>  fs/debugfs/inode.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 3dcf0b8b4e93..1e36ce013631 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -82,6 +82,8 @@ struct debugfs_mount_opts {
>  	kuid_t uid;
>  	kgid_t gid;
>  	umode_t mode;
> +	/* Opt_* bitfield. */
> +	unsigned int opts;
>  };
>  
>  enum {
> @@ -111,6 +113,7 @@ static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
>  	kgid_t gid;
>  	char *p;
>  
> +	opts->opts = 0;
>  	opts->mode = DEBUGFS_DEFAULT_MODE;
>  
>  	while ((p = strsep(&data, ",")) != NULL) {
> @@ -145,22 +148,34 @@ static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
>  		 * but traditionally debugfs has ignored all mount options
>  		 */
>  		}
> +
> +		opts->opts |= BIT(token);
>  	}
>  
>  	return 0;
>  }
>  
> -static int debugfs_apply_options(struct super_block *sb)
> +static int debugfs_apply_options(struct super_block *sb, bool remount)

Functions with random boolean arguments are impossible to understand and
maintain over time.

Every time you run across a call to this function now, you have to go
back and look up what this specific argument means, which is a pain.

Make two functions:
	debugfs_apply_options()
	debugfs_apply_options_remount()
and then move this original function to be:
	_debugfs_apply_options()
or some such name.

Then when you call the function, you know exactly what is happening.

thanks,

greg k-h
