Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A373BA43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjFWOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjFWOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:35:10 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 07:35:05 PDT
Received: from mail.alarsen.net (joe.alarsen.net [IPv6:2a01:4f8:191:10e8:1::fe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2E71987
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:35:05 -0700 (PDT)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:1d26:f9f2:f499:3633])
        by joe.alarsen.net (Postfix) with ESMTPS id 7BCB8180292;
        Fri, 23 Jun 2023 16:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1687530408; bh=cNJElIuh7IRKT/A94Y0wNfI+PwUt+V2OMs3r9laCu1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfENN8a4Amxx7D4M7cuYsfx7yrgo4IiSRelp1EDhFfYNcoHwaHSi6kLRJW875vpQq
         6JijsJhtVRfu+EYSKD0UbJVuUM9eYKxCSU5kMgVcZPO8vqIdWMNv6nSbhodQLkaGzq
         hNU5FpJkcdRRUETR+I8JgYn9fYwj9q6vTSmmYbUE=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 6F01527C092D;
        Fri, 23 Jun 2023 16:26:48 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 57/79] qnx4: switch to new ctime accessors
Date:   Fri, 23 Jun 2023 16:26:48 +0200
Message-ID: <5944926.lOV4Wx5bFT@alarsen.net>
In-Reply-To: <20230621144735.55953-56-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org> <20230621144735.55953-1-jlayton@kernel.org> <20230621144735.55953-56-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 2023-06-21 16:46 Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/qnx4/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 391ea402920d..3fde90b3f99b 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -305,8 +305,8 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
>  	inode->i_mtime.tv_nsec = 0;
>  	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
>  	inode->i_atime.tv_nsec = 0;
> -	inode->i_ctime.tv_sec   = le32_to_cpu(raw_inode->di_ctime);
> -	inode->i_ctime.tv_nsec = 0;
> +	inode_ctime_set_sec(inode, le32_to_cpu(raw_inode->di_ctime));
> +	inode_ctime_set_nsec(inode, 0);
>  	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
>  
>  	memcpy(qnx4_inode, raw_inode, QNX4_DIR_ENTRY_SIZE);

Acked-by: Anders Larsen <al@alarsen.net>



