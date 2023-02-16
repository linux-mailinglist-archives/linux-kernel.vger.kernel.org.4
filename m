Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7123C699590
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBPNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBPNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:19:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A82AD1B;
        Thu, 16 Feb 2023 05:19:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD55A21ACA;
        Thu, 16 Feb 2023 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676553574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JSQOK0REu8vNGDg2yRfylXo2+2rlKENAEHD70Ll0Vs=;
        b=xOuNgQapuHcWiL8S8zQuVgjruAkNeNEcHhp9TZU4S7MSOUMr28Hk97taKpo6sQvS+e7AHT
        W2wsKeXJgc5GKTx7BOXf9US6MWr0qTg784x2HdFLIU8aTVwKwDuSbGuxmhosXJRTeREHSh
        ASTt55OYiwxDbDQhIIFxWKWinwS1+OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676553574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JSQOK0REu8vNGDg2yRfylXo2+2rlKENAEHD70Ll0Vs=;
        b=BsUwxjtbRhedud23nb3Llz4wQgoYcSMlV6wtz/7jfHXVGFMMhqv8s4aqEk+1tae7VleRNL
        CQrX9HXhYeiew9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFECE13438;
        Thu, 16 Feb 2023 13:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zTa8MmYt7mPvWAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 13:19:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6D543A06E1; Thu, 16 Feb 2023 14:19:34 +0100 (CET)
Date:   Thu, 16 Feb 2023 14:19:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, jack@suse.cz, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next RFC 3/3] block: fix scan partition for exclusively
 open device again
Message-ID: <20230216131934.f6swfwyqqd6xzpm6@quack3>
References: <20230212092641.2394146-1-yukuai1@huaweicloud.com>
 <20230212092641.2394146-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212092641.2394146-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 12-02-23 17:26:41, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> As explained in commit 36369f46e917 ("block: Do not reread partition table
> on exclusively open device"), reread partition on the device that is
> exclusively opened by someone else is problematic.
> 
> This patch will make sure partition scan will only be proceed if current
> thread open the device exclusively, or the device is not opened
> exclusively, and in the later case, other scanners and exclusive openers
> will be blocked temporarily until partition scan is done.
> 
> Fixes: 10c70d95c0f2 ("block: remove the bd_openers checks in blk_drop_partitions")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Just one nit below.

> diff --git a/block/genhd.c b/block/genhd.c
> index c0d1220bd798..6ec10ffeb9cc 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -359,6 +359,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
>  int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  {
>  	struct block_device *bdev;
> +	int ret = 0;
>  
>  	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
>  		return -EINVAL;
> @@ -367,11 +368,29 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  	if (disk->open_partitions)
>  		return -EBUSY;
>  
> -	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
> -	if (IS_ERR(bdev))
> -		return PTR_ERR(bdev);
> +	/*
> +	 * If the device is opened exclusively by current thread already, it's
> +	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
> +	 * synchronize with other exclusivet openers and other partition
				  ^^^ typo here

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
