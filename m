Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10FD6A56D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjB1KfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjB1KfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:35:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631031ADE2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:35:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0D9C01FDC2;
        Tue, 28 Feb 2023 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677580516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z91UYhzCbg1Q+gpWADaG0uyiQsgpRTPRLreoidsadJY=;
        b=HSsSSGHdpDf/O3J8GoJir2KCz/nPSbPx6yFcDS1qxw7RBP2L9TBFBNZFgAkWxZRUThkPG1
        Ad0WWE1BAFS3VeND9VS2BhyN9neS9xHVb6zzJV/0rhlQD/18z9preAgMFYBAPtMAgh0mgL
        Ax42j8ykwCFJE5/jnngzFkmPIrDCc+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677580516;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z91UYhzCbg1Q+gpWADaG0uyiQsgpRTPRLreoidsadJY=;
        b=s+sbQ3tlPZTHozo4cA6oDIiYCedgdxrAyv/t6gAMeFBKYRAcvKCmd5F3+1+9rkkGZVldyO
        wgIzLrcau+cXCoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9DED1333C;
        Tue, 28 Feb 2023 10:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xDcNOePY/WMCVAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Feb 2023 10:35:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74F8AA06F2; Tue, 28 Feb 2023 11:35:15 +0100 (CET)
Date:   Tue, 28 Feb 2023 11:35:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] quota:  fixup *_write_file_info() to return proper
 error code
Message-ID: <20230228103515.sb6qpvnmbvenvq73@quack3>
References: <20230227120216.31306-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227120216.31306-1-frank.li@vivo.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-02-23 20:02:15, Yangtao Li wrote:
> For v1_write_file_info function, when quota_write() returns 0,
> it should be considered an EIO error. And for v2_write_file_info(),
> fix to proper error return code instead of raw number.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks! Both patches look good now. I'll queue them into my tree.

								Honza

> ---
>  fs/quota/quota_v1.c | 2 +-
>  fs/quota/quota_v2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
> index cd92e5fa0062..a0db3f195e95 100644
> --- a/fs/quota/quota_v1.c
> +++ b/fs/quota/quota_v1.c
> @@ -206,7 +206,7 @@ static int v1_write_file_info(struct super_block *sb, int type)
>  	      sizeof(struct v1_disk_dqblk), v1_dqoff(0));
>  	if (ret == sizeof(struct v1_disk_dqblk))
>  		ret = 0;
> -	else if (ret > 0)
> +	else if (ret >= 0)
>  		ret = -EIO;
>  out:
>  	up_write(&dqopt->dqio_sem);
> diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
> index b1467f3921c2..ae99e7b88205 100644
> --- a/fs/quota/quota_v2.c
> +++ b/fs/quota/quota_v2.c
> @@ -212,7 +212,7 @@ static int v2_write_file_info(struct super_block *sb, int type)
>  	up_write(&dqopt->dqio_sem);
>  	if (size != sizeof(struct v2_disk_dqinfo)) {
>  		quota_error(sb, "Can't write info structure");
> -		return -1;
> +		return size < 0 ? size : -EIO;
>  	}
>  	return 0;
>  }
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
