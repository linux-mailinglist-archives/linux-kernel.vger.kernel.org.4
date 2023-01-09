Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4C66293A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjAIPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjAIPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FAB1CB05
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673276509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5BnqkcP/B7SGlD7ivTZ2uRzTlawgLKPgKJY+C2gEHLI=;
        b=MWvz+HemCM5g6UKVZE1qwiTHm3SMHT8/uqLjFG0FmumVp9KMDHjqW2dxxUH5f6BskYhcNK
        LVRQYid7BcI1/sG3TYnOM7FuANKmu1wSGmA3pQpR6pyHmq88VcY6iB7InR/2KNuVX5FGNX
        mC0kjcgJZ6zghTOvJ3zi17exczYI8Vc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-ROZwN1ZqMN6KeFkjEKTT7g-1; Mon, 09 Jan 2023 10:01:47 -0500
X-MC-Unique: ROZwN1ZqMN6KeFkjEKTT7g-1
Received: by mail-qt1-f199.google.com with SMTP id hf20-20020a05622a609400b003abcad051d2so3952752qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BnqkcP/B7SGlD7ivTZ2uRzTlawgLKPgKJY+C2gEHLI=;
        b=j3kEAZvBs61EQ5gU0qP1LxLmwGuK908FDkv3Ui1TxgDbYNgd1jk3fMVTLFLvSu2q1E
         s8Yxp2C6Edgxq2ShpsLXQA7lcq7lrBIACVPCk4VVpNzNKmep8jVW+9U22cLpXTtYemnF
         ykwOqSBrfgqaU9QAqtbgPIQhu+YQ7PrbQhXqbICDVkgXNQr1BkYFcR0K21I6JmaO62rq
         cmJuAvxewRoZANScASYVe9HWcGLs8HRpJbmLyhrpOaoXwh7fWUdDhHUlhLxSJea+5jcz
         FXgyBrc1R+nDPL3hDcxUuhkjhzGq7bC+8bX+dcgz1UcDImAhJaSnARso1rSArZTqI+R9
         5eNA==
X-Gm-Message-State: AFqh2kocN/YFt4cRO3cWIYLCPQsyLxxO+N1zOZSO6YYsASvI9GYBuYta
        d37C0VWfufPLEIcc+QoVmzUNRtgWCs/fP9V9pFraFVd+TdywrOb34GlCXyGfe41Sc+QVX4XSuR8
        o0ayMbc8wnTn0KpAfbP7HFgS8
X-Received: by 2002:ac8:6b4c:0:b0:39c:da20:d47c with SMTP id x12-20020ac86b4c000000b0039cda20d47cmr84648927qts.17.1673276506393;
        Mon, 09 Jan 2023 07:01:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvzZP+QWbMTML85dKaCimKI1eGsnIuLcS2Bp/8ib3jUiLno1dRkiK90vxVouiizF3DOW2wqRA==
X-Received: by 2002:ac8:6b4c:0:b0:39c:da20:d47c with SMTP id x12-20020ac86b4c000000b0039cda20d47cmr84648900qts.17.1673276506083;
        Mon, 09 Jan 2023 07:01:46 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b006fb0e638f12sm5457812qkb.4.2023.01.09.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:01:45 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:02:46 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 6/7] ext4: Add mount option for provisioning blocks
 during allocations
Message-ID: <Y7wsluqX+eFqV1XB@bfoster>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-7-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229081252.452240-7-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:12:51AM -0800, Sarthak Kukreti wrote:
> Add a mount option that sets the default provisioning mode for
> all files within the filesystem.
> 

There's not much description here to explain what a user should expect
from this mode. Should the user expect -ENOSPC from the lower layers
once out of space? What about files that are provisioned by the fs and
then freed? Should the user/admin know to run fstrim or also enable an
online discard mechanism to ensure freed filesystem blocks are returned
to the free pool in the block/dm layer in order to avoid premature fs
-ENOSPC conditions?

Also, what about dealing with block level snapshots? There is some
discussion on previous patches wrt to expectations on how provision
might handle unsharing of cow'd blocks. If the fs only provisions on
initial allocation, then a subsequent snapshot means we run into the
same sort of ENOSPC problem on overwrites of already allocated blocks.
That also doesn't consider things like an internal log, which may have
been physically allocated (provisioned?) at mkfs time and yet is subject
to the same general problem.

So what is the higher level goal with this sort of mode? Is
provision-on-alloc sufficient to provide a practical benefit to users,
or should this perhaps consider other scenarios where a provision might
be warranted before submitting writes to a thinly provisioned device?

FWIW, it seems reasonable to me to introduce this without snapshot
support and work toward it later, but it should be made clear what is
being advertised in the meantime. Unless there's some nice way to
explicitly limit the scope of use, such as preventing snapshots or
something, the fs might want to consider this sort of feature
experimental until it is more fully functional.

Brian

> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  fs/ext4/ext4.h    | 1 +
>  fs/ext4/extents.c | 7 +++++++
>  fs/ext4/super.c   | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 49832e90b62f..29cab2e2ea20 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1269,6 +1269,7 @@ struct ext4_inode_info {
>  #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
>  						    * scanning in mballoc
>  						    */
> +#define EXT4_MOUNT2_PROVISION		0x00000100 /* Provision while allocating file blocks */
>  
>  #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
>  						~EXT4_MOUNT_##opt
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2e64a9211792..a73f44264fe2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4441,6 +4441,13 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  	unsigned int credits;
>  	loff_t epos;
>  
> +	/*
> +	 * Attempt to provision file blocks if the mount is mounted with
> +	 * provision.
> +	 */
> +	if (test_opt2(inode->i_sb, PROVISION))
> +		flags |= EXT4_GET_BLOCKS_PROVISION;
> +
>  	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
>  	map.m_lblk = offset;
>  	map.m_len = len;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 260c1b3e3ef2..5bc376f6a6f0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1591,6 +1591,7 @@ enum {
>  	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
>  	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
>  	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
> +	Opt_provision, Opt_noprovision,
>  #ifdef CONFIG_EXT4_DEBUG
>  	Opt_fc_debug_max_replay, Opt_fc_debug_force
>  #endif
> @@ -1737,6 +1738,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
>  	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
>  	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
> +	fsparam_flag	("provision",		Opt_provision),
> +	fsparam_flag	("noprovision",		Opt_noprovision),
>  	{}
>  };
>  
> @@ -1826,6 +1829,8 @@ static const struct mount_opts {
>  	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
>  	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
>  	 MOPT_SET},
> +	{Opt_provision, EXT4_MOUNT2_PROVISION, MOPT_SET | MOPT_2},
> +	{Opt_noprovision, EXT4_MOUNT2_PROVISION, MOPT_CLEAR | MOPT_2},
>  #ifdef CONFIG_EXT4_DEBUG
>  	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
>  	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
> @@ -2977,6 +2982,8 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PUTS("dax=never");
>  	} else if (test_opt2(sb, DAX_INODE)) {
>  		SEQ_OPTS_PUTS("dax=inode");
> +	} else if (test_opt2(sb, PROVISION)) {
> +		SEQ_OPTS_PUTS("provision");
>  	}
>  
>  	if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
> -- 
> 2.37.3
> 

