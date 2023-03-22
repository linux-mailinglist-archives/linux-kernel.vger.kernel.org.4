Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA406C45FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCVJQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCVJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:15:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90E2196D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:15:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A096520BC8;
        Wed, 22 Mar 2023 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679476555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSwW1Xo4NB8UgygX86U3Xlb/V7fSDefct5xNdIgZccg=;
        b=c2CQdvUDKX28KT7eBRzRZoAVuo1EkjyrF7KYxeQQelPVnr+tspPad6b0pIUJQa5nf0SdZM
        mYVrRZZquwR7BiE1Qa9LfI5AgmQ0Qe+Gd35CNXC58WjBFaIdVGti8KCx1OjlDp6envok8A
        Akl1hGzE4sLrGXtDsiEXyFLzzPen+RQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679476555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sSwW1Xo4NB8UgygX86U3Xlb/V7fSDefct5xNdIgZccg=;
        b=lYSRVv2lP5Q+hhQwDzQquZVTgjn2jTm4PvR2E2XnWrsH8ZztOh76yTdjv81/g3tPa1Z2M0
        lTlFHEj8q77BMtBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9213113416;
        Wed, 22 Mar 2023 09:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sZShI0vHGmQ3XgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 22 Mar 2023 09:15:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 22F22A071C; Wed, 22 Mar 2023 10:15:55 +0100 (CET)
Date:   Wed, 22 Mar 2023 10:15:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: check for register_sysctl() failure when has
 CONFIG_SYSCTL
Message-ID: <20230322091555.ncruzminxyxcphxr@quack3>
References: <20230320174058.72773-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320174058.72773-1-frank.li@vivo.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-03-23 01:40:58, Yangtao Li wrote:
> Print a message that sysctl registration failed if CONFIG_SYSCTL
> is enabled, and wrap the fs_dqstats_table array with CONFIG_SYSCTL.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 90cb70c82012..a16ddda02612 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2879,6 +2879,7 @@ static int do_proc_dqstats(struct ctl_table *table, int write,
>  	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
> +#ifdef CONFIG_SYSCTL
>  static struct ctl_table fs_dqstats_table[] = {
>  	{
>  		.procname	= "lookups",
> @@ -2947,6 +2948,7 @@ static struct ctl_table fs_dqstats_table[] = {
>  #endif
>  	{ },
>  };
> +#endif
>  
>  static int __init dquot_init(void)
>  {
> @@ -2955,7 +2957,10 @@ static int __init dquot_init(void)
>  
>  	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
>  
> -	register_sysctl("fs/quota", fs_dqstats_table);
> +#ifdef CONFIG_SYSCTL
> +	if (!register_sysctl("fs/quota", fs_dqstats_table))
> +		pr_notice("quota sysctl registration failed!\n");
> +#endif
>  
>  	dquot_cachep = kmem_cache_create("dquot",
>  			sizeof(struct dquot), sizeof(unsigned long) * 4,
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
