Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709496DB58F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDGU73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDGU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AEA6A5A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D1EF6114E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE92C433EF;
        Fri,  7 Apr 2023 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680901165;
        bh=T9eB8QdjMGMVT/DK1Yt9pviXcxgW+FQv8ahMZ8rJJWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NT08vvwvuEn44vtimLvpex7KgTITAUypeP1kRh/nV+MPl2DY8iwEhVVlRAD9c6bLg
         Fr0JvThfh+vv8zLbAQ1QYfqVAd9sNXAm4EoJR40iox0D8lFL4ZWplQuWTIhNaCphDA
         +ARBw5eA4XQZEiHXy6CPWIxTJNjWprfwYC3aylbEv5a45rdjq/NXOU3iDyTcz4LDAF
         xHJb+zbwLcvejNthoA5UwBfE3dL6T1NmzHPQsEufr9N6T9y1N/aWymvWwvadIHl+tP
         GyX47hXgeltx7u2ecnIpXS//PHRHzamJhCeMmXsskEB/RJSQIGj/2GswKmJuIciZ0L
         xZhFibWav8wyg==
Date:   Fri, 7 Apr 2023 13:59:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to tag FIEMAP_EXTENT_DELALLOC in fiemap() for
 delay allocated extent
Message-ID: <ZDCEK2OPkhTmRZrq@google.com>
References: <20230405144359.930253-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405144359.930253-1-chao@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks generic/009?

On 04/05, Chao Yu wrote:
> xfstest generic/614 fails to run due below reason:
> 
> generic/614 1s ... [not run] test requires delayed allocation buffered writes
> 
> The root cause is f2fs tags wrong fiemap flag for delay allocated
> extent.
> 
> Quoted from fiemap.h:
> FIEMAP_EXTENT_UNKNOWN		0x00000002 /* Data location unknown. */
> FIEMAP_EXTENT_DELALLOC		0x00000004 /* Location still pending.
> 						    * Sets EXTENT_UNKNOWN. */
> FIEMAP_EXTENT_UNWRITTEN		0x00000800 /* Space allocated, but
> 						    * no data (i.e. zero). */
> 
> FIEMAP_EXTENT_UNWRITTEN means block address is preallocated, but w/o
> been written any data, which status f2fs is not supported now, for all
> NEW_ADDR block addresses, it means delay allocated blocks, so let's
> tag FIEMAP_EXTENT_DELALLOC instead.
> 
> Testcase:
> xfs_io -f -c 'pwrite 0 64k' /mnt/f2fs/file;
> filefrag -v /mnt/f2fs/file
> 
> Output:
> - Before
> Filesystem type is: f2f52010
> Fize of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..      15:          0..        15:     16:             last,unwritten,merged,eof
> /mnt/f2fs/file: 1 extent found
> 
> After:
> Filesystem type is: f2f52010
> File size of /mnt/f2fs/file is 65536 (16 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>    0:        0..      15:          0..         0:      0:             last,unknown_loc,delalloc,eof
> /mnt/f2fs/file: 1 extent found
> 
> Fixes: 7f63eb77af7b ("f2fs: report unwritten area in f2fs_fiemap")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 359de650772e..3afc9764743e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1995,7 +1995,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	}
>  
>  	if (size) {
> -		flags |= FIEMAP_EXTENT_MERGED;
> +		if (flags & FIEMAP_EXTENT_DELALLOC)
> +			phys = 0;
> +		else
> +			flags |= FIEMAP_EXTENT_MERGED;
>  		if (IS_ENCRYPTED(inode))
>  			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
>  
> @@ -2035,7 +2038,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  				size += blks_to_bytes(inode, 1);
>  			}
>  		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
> -			flags = FIEMAP_EXTENT_UNWRITTEN;
> +			flags = FIEMAP_EXTENT_DELALLOC;
>  		}
>  
>  		start_blk += bytes_to_blks(inode, size);
> -- 
> 2.36.1
