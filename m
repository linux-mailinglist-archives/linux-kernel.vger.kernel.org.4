Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873B673893A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjFUPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjFUPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:32:47 -0400
X-Greylist: delayed 201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 08:32:29 PDT
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9004211F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:32:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B4E219C35A;
        Wed, 21 Jun 2023 11:29:04 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ekd0h2QIE5s1PkBoGtfX2O0/PUn/m1cFnjgcDW
        ipEtM=; b=V+dQqG6z4vV9hekY3M130d2Tu+D8CyOmXRdwxSUNzV9g3QUm8iMtis
        P0yafbrJrjw/CwasDULuHdVqBb5oMtUIeJszNEJqpaXpg6Yo9bxPnSsPHp+p+Sbc
        4CoSn+aH/9LBQ0r+7XvekigjWK633YsmXnPsU7HzSdctO4gINzdM8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 912F019C359;
        Wed, 21 Jun 2023 11:29:04 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=ekd0h2QIE5s1PkBoGtfX2O0/PUn/m1cFnjgcDWipEtM=; b=BxBpnN/OZz+abP2EtPKcwMvg7RFZ+ed5i41HEVosEgZbtKJTpkCxsT9inBGgWc/DP/nNcFe7CNv3GHDJsmOzpwNm1v/HfrI+Sq8z08NxlljnpKbCVGF+nEsW4hJi3EeXjFT9G64YdKf2GUBw1Mr5A+wdoBElvQHa+uNwsBrdXks=
Received: from yoda.home (unknown [184.162.17.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C796819C356;
        Wed, 21 Jun 2023 11:29:03 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [10.0.0.101])
        by yoda.home (Postfix) with ESMTPSA id 80C188165C2;
        Wed, 21 Jun 2023 11:29:02 -0400 (EDT)
Date:   Wed, 21 Jun 2023 11:29:02 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jeff Layton <jlayton@kernel.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/79] cramfs: switch to new ctime accessors
In-Reply-To: <20230621144735.55953-19-jlayton@kernel.org>
Message-ID: <5r02p455-26oq-9r61-ss01-679977osr722@syhkavp.arg>
References: <20230621144507.55591-1-jlayton@kernel.org> <20230621144735.55953-1-jlayton@kernel.org> <20230621144735.55953-19-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 5A92D108-1048-11EE-BADD-C65BE52EC81B-78420484!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Jeff Layton wrote:

> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net

Yet all that's needed here is to simply set time entries to 0 as cramfs 
doesn't time stamp its files. It could as well be done with memset().

> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 27c6597aa1be..039ce0f8858b 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -133,7 +133,7 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
>  	}
>  
>  	/* Struct copy intentional */
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
> +	inode->i_mtime = inode->i_atime = inode_ctime_set(inode, zerotime);
>  	/* inode->i_nlink is left 1 - arguably wrong for directories,
>  	   but it's the best we can do without reading the directory
>  	   contents.  1 yields the right result in GNU find, even
> -- 
> 2.41.0
> 
> 
