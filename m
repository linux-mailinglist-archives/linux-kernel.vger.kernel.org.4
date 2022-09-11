Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EEA5B51CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIKXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIKXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:12:56 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83F1B24097;
        Sun, 11 Sep 2022 16:12:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-149-49.pa.vic.optusnet.com.au [49.186.149.49])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6F34E110063D;
        Mon, 12 Sep 2022 09:12:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oXW8B-006d0R-W2; Mon, 12 Sep 2022 09:12:52 +1000
Date:   Mon, 12 Sep 2022 09:12:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, chandan.babu@oracle.com,
        zhangshida@kylinos.cn, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: remove the redundant check in xfs_bmap_first_unused
Message-ID: <20220911231251.GA3600936@dread.disaster.area>
References: <20220909030756.3916297-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909030756.3916297-1-zhangshida@kylinos.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=631e6b76
        a=XTRC1Ovx3SkpaCW1YxGVGA==:117 a=XTRC1Ovx3SkpaCW1YxGVGA==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=d4ToVRSH_LyJE6_9r9cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:07:56AM +0800, Stephen Zhang wrote:
> Given that
>         max >= lowest,
> hence if
>         got.br_startoff >= max + len,
> then, at the same time,
>         got.br_startoff >= lowest + len,
> 
> So the check here is redundant, remove it.

Check your types: what happens when *first_unused =
XFS_DIR2_LEAF_OFFSET?

> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index e56723dc9cd5..f8a984c41b01 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -1230,8 +1230,7 @@ xfs_bmap_first_unused(
>  		/*
>  		 * See if the hole before this extent will work.
>  		 */
> -		if (got.br_startoff >= lowest + len &&
> -		    got.br_startoff - max >= len)
> +		if (got.br_startoff - max >= len)
>  			break;
>  		lastaddr = got.br_startoff + got.br_blockcount;
>  		max = XFS_FILEOFF_MAX(lastaddr, lowest);

This loop does a linear scan of the extent list, so it starts at
extent index zero which will be got.br_startoff = 0 for the
first directory data block.

When we are called from xfs_da_grow_inode_int(), we're trying to add
blocks in the directory leaf btree segment here. Hence the lowest
file offset we want to search for a hole is XFS_DIR2_LEAF_OFFSET.

Given that all the types and comparisons involved are 64 bit
unsigned:

typedef uint64_t        xfs_fileoff_t;  /* block number in a file */ 

#define XFS_FILEOFF_MAX(a,b) max_t(xfs_fileoff_t, (a), (b))

	xfs_fileoff_t br_startoff;

        xfs_fileoff_t           lastaddr = 0;
	xfs_fileoff_t           lowest, max;

We end up with the following calculations (in FSBs, not bytes):

	lowest + len	= 0x800000ULL + 1 
			= 0x800001ULL

	got.br_startoff - max	= 0ULL - 0x800000
				= 0xffffffffff800000ULL

and so the existing check is:

	if (0 >= 0x800001ULL && 0xffffffffff800000 >= 1)

which evaluates as false because the extent that was found is not
beyond the initial offset (first_unused) that we need to start
searching at.

With your modification, this would now evaluate as:

	if (0xffffffffff800000 >= 1)

Because of the underflow, this would then evaluate as true  and we'd
return 0 as the first unused offset. This is incorrect as we do not
have a hole at offset 0, nor is it within the correct directory
offset segment, nor is it within the search bounds we have
specified.

If these were all signed types, then your proposed code might be
correct. But they are unsigned and hence we have to ensure that we
handle overflow/underflow appropriately.

Which leads me to ask: did you test this change before you send
it to the list?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
