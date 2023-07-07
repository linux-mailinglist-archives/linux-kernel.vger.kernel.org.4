Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA85374B093
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGGMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGGMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:19:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF031BC9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:19:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F49F1FD93;
        Fri,  7 Jul 2023 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688732388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOXr7QoWpZ3X2+T8tGBbRIhretiWSAYNHeNZqoiPNpk=;
        b=BRNi36lT7Q3aNxOPhHXQxg4RjJtIDxqLfxcfF+RMliSPCaJV0+EPPv4thI13XlfZ97KToL
        7UJRsjkr6gTJ0jgjpuzdyrUph6QMhcH4of496QQ/Ri2dwjGZ/s5MBWSFcg1SJWuGigIA2F
        bPCOaUi5RSB3Xc4HgzLVD9by3BxVxP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688732388;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOXr7QoWpZ3X2+T8tGBbRIhretiWSAYNHeNZqoiPNpk=;
        b=nD19oLnfglya0Z8LJqdXocAxqQQQp9LIitNCIQD5c+mbP20ilyRzQHV0WTT18pgAXNAoJl
        k8LgIX+3Ty+OkmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4079D139E0;
        Fri,  7 Jul 2023 12:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8nyvD+QCqGSDNAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 07 Jul 2023 12:19:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C9F62A0717; Fri,  7 Jul 2023 14:19:47 +0200 (CEST)
Date:   Fri, 7 Jul 2023 14:19:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] fs/udf: Change the type of blocksize from 'int' to
 'unsigned int' in udf_discard_prealloc
Message-ID: <20230707121947.sa2l3y3b5d2kwmdj@quack3>
References: <20230707110752.13436-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707110752.13436-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-07-23 19:07:52, Lu Hongfei wrote:
> The return value type of i_blocksize() is 'unsigned int', so the
> type of blocksize has been modified from 'int' to 'unsigned int'
> to ensure data type consistency.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Thanks for the patch but I'm sorry but how does this make a difference?
Blocksize is a small positive integer (512-64k). So it doesn't matter
whether you store it in int or unsigned it. I agree sometimes there are
nasty issues in C with signed comparisons, sign extension and other complex
logic and there it is beneficial to really be sure to match signedness etc.
to avoid subtle issues. But in this particular case I don't see the
point so I'd just keep the code as is... But please tell me if you see some
readability or other benefit in this change.

								Honza

> ---
>  fs/udf/truncate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index a686c10fd709..c80dfcc583f6 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -123,7 +123,7 @@ void udf_discard_prealloc(struct inode *inode)
>  	uint64_t lbcount = 0;
>  	int8_t etype = -1;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> -	int bsize = i_blocksize(inode);
> +	unsigned int bsize = i_blocksize(inode);
>  
>  	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
>  	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
