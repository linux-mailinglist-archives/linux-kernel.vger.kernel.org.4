Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE1738B86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjFUQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjFUQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:37:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6E268B;
        Wed, 21 Jun 2023 09:36:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 993121FF3A;
        Wed, 21 Jun 2023 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/d4ziQZw6N7mHZLzmgH+OAesVEUu7JrV0F1FpHCOj/Y=;
        b=rU19K/Y2/QE9QgbbEIeMWU9TBzjpZek0f4a0CG5e7wLxJwECVBKoPN64Q/245PInLsROTe
        JHnVDP5mIRCFbt0N0rb39KBA125VrnyNgDvK/Apyq4ecbwZectVy6ipwXhawxQxRo5mp13
        vR3bSpRx4wz8NUydR8/0lnmD7umJ4hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/d4ziQZw6N7mHZLzmgH+OAesVEUu7JrV0F1FpHCOj/Y=;
        b=Jzpmvodf0LrZ4TExuIW84tMI1D8erJv2Pv/8wD1TwCXFtDmtUpgJzA/OGBUdOLRRz+Gg/P
        nrVl9xqEp7IP0IAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB5B133E6;
        Wed, 21 Jun 2023 16:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ud0TIhonk2T5QwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:36:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2BEEDA075D; Wed, 21 Jun 2023 18:36:42 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:36:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/79] usb: switch to new ctime accessors
Message-ID: <20230621163642.j6blmqfu7oqelzri@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-6-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-6-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:20, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/usb/core/devio.c           | 16 ++++++++--------
>  drivers/usb/gadget/function/f_fs.c |  6 +-----
>  drivers/usb/gadget/legacy/inode.c  |  3 +--
>  3 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 1a16a8bdea60..02f718e0deaf 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -2642,21 +2642,21 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  		snoop(&dev->dev, "%s: CONTROL\n", __func__);
>  		ret = proc_control(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_BULK:
>  		snoop(&dev->dev, "%s: BULK\n", __func__);
>  		ret = proc_bulk(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_RESETEP:
>  		snoop(&dev->dev, "%s: RESETEP\n", __func__);
>  		ret = proc_resetep(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_RESET:
> @@ -2668,7 +2668,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  		snoop(&dev->dev, "%s: CLEAR_HALT\n", __func__);
>  		ret = proc_clearhalt(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_GETDRIVER:
> @@ -2695,7 +2695,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  		snoop(&dev->dev, "%s: SUBMITURB\n", __func__);
>  		ret = proc_submiturb(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  #ifdef CONFIG_COMPAT
> @@ -2703,14 +2703,14 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  		snoop(&dev->dev, "%s: CONTROL32\n", __func__);
>  		ret = proc_control_compat(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_BULK32:
>  		snoop(&dev->dev, "%s: BULK32\n", __func__);
>  		ret = proc_bulk_compat(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_DISCSIGNAL32:
> @@ -2722,7 +2722,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
>  		snoop(&dev->dev, "%s: SUBMITURB32\n", __func__);
>  		ret = proc_submiturb_compat(ps, p);
>  		if (ret >= 0)
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>  		break;
>  
>  	case USBDEVFS_IOCTL32:
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index f41a385a5c42..756c78043a04 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1377,16 +1377,12 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
>  	inode = new_inode(sb);
>  
>  	if (inode) {
> -		struct timespec64 ts = current_time(inode);
> -
>  		inode->i_ino	 = get_next_ino();
>  		inode->i_mode    = perms->mode;
>  		inode->i_uid     = perms->uid;
>  		inode->i_gid     = perms->gid;
> -		inode->i_atime   = ts;
> -		inode->i_mtime   = ts;
> -		inode->i_ctime   = ts;
>  		inode->i_private = data;
> +		inode->i_atime   = inode->i_mtime = inode_ctime_set_current(inode);
>  		if (fops)
>  			inode->i_fop = fops;
>  		if (iops)
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index 28249d0bf062..b83a68feb316 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1969,8 +1969,7 @@ gadgetfs_make_inode (struct super_block *sb,
>  		inode->i_mode = mode;
>  		inode->i_uid = make_kuid(&init_user_ns, default_uid);
>  		inode->i_gid = make_kgid(&init_user_ns, default_gid);
> -		inode->i_atime = inode->i_mtime = inode->i_ctime
> -				= current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  		inode->i_private = data;
>  		inode->i_fop = fops;
>  	}
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
