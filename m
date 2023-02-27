Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6871B6A3F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjB0K1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjB0K1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:27:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A652056F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:26:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73729219F3;
        Mon, 27 Feb 2023 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677493618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCe3/NUSI20pyKbeY5vCliFS4zMF2RtYUo+EbZzRxSI=;
        b=Sh2JBIxrmiUelCHj4X+gCdWLUKR9nG15uy2dinyQb9G03o8JdsfXVuZQbuSowTUM/wws21
        S9Sv6elIaQwGZZdMdtamuivSghlE+0QkiSXZsx4JEMjnKAeec49/cktN65n7JFBNACReMm
        gz1aMXFvMrr6ntQFmGeYWwzI2wogfqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677493618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GCe3/NUSI20pyKbeY5vCliFS4zMF2RtYUo+EbZzRxSI=;
        b=DSboxC02tqOQ7rvakxJpbvDTlt4dINdB/sVeYBvQoyORPeUVVBFHME4K3RBlT2TLDqJWTe
        aNwZTri6+zcJqDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66FA713A43;
        Mon, 27 Feb 2023 10:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AZEbGXKF/GPkdAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 10:26:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CD529A06F2; Mon, 27 Feb 2023 11:26:57 +0100 (CET)
Date:   Mon, 27 Feb 2023 11:26:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: make dquot_set_dqinfo return errors from
 ->write_info
Message-ID: <20230227102657.hppbkhhcfcq3gmud@quack3>
References: <20230220134652.6204-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220134652.6204-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-02-23 21:46:52, Yangtao Li wrote:
> dquot_set_dqinfo() ignores the return code from the ->write_info
> call, which means that quotacalls like Q_SETINFO never see the error.
> This doesn't seem right, so fix that.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks for the fix. It looks good but if you have a look into
implementations you'll notice that v2_write_file_info() returns 0 or -1,
not the error code. So before doing this, you also need to fixup
v2_write_file_info() to return proper error code. What v1_write_file_info()
does looks like a good inspiration.

								Honza

> ---
>  fs/quota/dquot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index f27faf5db554..be702905c74f 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2819,7 +2819,6 @@ EXPORT_SYMBOL(dquot_get_state);
>  int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii)
>  {
>  	struct mem_dqinfo *mi;
> -	int err = 0;
>  
>  	if ((ii->i_fieldmask & QC_WARNS_MASK) ||
>  	    (ii->i_fieldmask & QC_RT_SPC_TIMER))
> @@ -2846,8 +2845,7 @@ int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii)
>  	spin_unlock(&dq_data_lock);
>  	mark_info_dirty(sb, type);
>  	/* Force write to disk */
> -	sb->dq_op->write_info(sb, type);
> -	return err;
> +	return sb->dq_op->write_info(sb, type);
>  }
>  EXPORT_SYMBOL(dquot_set_dqinfo);
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
