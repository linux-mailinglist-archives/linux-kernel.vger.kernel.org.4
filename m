Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC668A4AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBCVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBCVcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:32:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89B9B704;
        Fri,  3 Feb 2023 13:32:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBB8F61FD7;
        Fri,  3 Feb 2023 21:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F531C433EF;
        Fri,  3 Feb 2023 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675459937;
        bh=+3/BTONRD3iwOv0A33zqtDpDWdHnR/8jcN4XSfuZenA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qV8BftRDYCk7cTCDfLXp6InMJJKPCMK8tHHD94rbCikCNNs2OqN+mbT78HAqgbnvU
         pM7TmxM4emEJvcU61hlgtOOsLNWMrX+Oe3uxWfBkdksTduvYMHnJy/Tfm5zls6K/75
         OI8g5hnnt2MCLwj17/UYnQiw9HOgtZ6wdHqJ9+kBV0UK7FBktoShkZPiEZGlDRhF8u
         IS40I25gQMoJeNuTZ4WgUAiiSfUH8zTPpVzc5Y0BZ44FHMFtvyczdOy8DxBZwv+Q6F
         xc45jaoDchSMW72ga+QYhrKad/4C8S2f1Ai9DDNvxly4LDEmNaKE4r7aVlKQUNdvP5
         JREffywxfG12Q==
Date:   Fri, 3 Feb 2023 13:32:16 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xfs: Replace one-element arrays with
 flexible-array members
Message-ID: <Y919YPKebVjQWwTM@magnolia>
References: <Y9xiYmVLRIKdpJcC@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xiYmVLRIKdpJcC@work>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 07:24:50PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in structures xfs_attr_leaf_name_local and
> xfs_attr_leaf_name_remote.
> 
> The only binary differences reported after the changes are all like
> these:
> 
> fs/xfs/libxfs/xfs_attr_leaf.o
> _@@ -435,7 +435,7 @@
>       3b8:      movzbl 0x2(%rbx),%eax
>       3bc:      rol    $0x8,%bp
>       3c0:      movzwl %bp,%ebp
> -     3c3:      lea    0x2(%rax,%rbp,1),%ebx
> +     3c3:      lea    0x3(%rax,%rbp,1),%ebx
>       3c7:      call   3cc <xfs_attr_leaf_entsize+0x8c>
>                         3c8: R_X86_64_PLT32     __tsan_func_exit-0x4
>       3cc:      or     $0x3,%ebx
> _@@ -454,7 +454,7 @@
>       3ea:      movzbl 0x8(%rbx),%ebx
>       3ee:      call   3f3 <xfs_attr_leaf_entsize+0xb3>
>                         3ef: R_X86_64_PLT32     __tsan_func_exit-0x4
> -     3f3:      add    $0xa,%ebx
> +     3f3:      add    $0xb,%ebx
>       3f6:      or     $0x3,%ebx
>       3f9:      add    $0x1,%ebx
>       3fc:      mov    %ebx,%eax
> 
> similar changes in fs/xfs/scrub/attr.o and fs/xfs/xfs.o object files.
> 
> And the reason for this is because of the round_up() macro called in
> functions xfs_attr_leaf_entsize_remote() and xfs_attr_leaf_entsize_local(),
> which is compensanting for the one-byte reduction in size (due to the
> flex-array transformation) of structures xfs_attr_leaf_name_remote and
> xfs_attr_leaf_name_local. So, sizes remain the same before and after
> changes.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/251
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_da_format.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
> index 25e2841084e1..e1e62ebb0c44 100644
> --- a/fs/xfs/libxfs/xfs_da_format.h
> +++ b/fs/xfs/libxfs/xfs_da_format.h
> @@ -620,14 +620,14 @@ typedef struct xfs_attr_leaf_entry {	/* sorted on key, not name */
>  typedef struct xfs_attr_leaf_name_local {
>  	__be16	valuelen;		/* number of bytes in value */
>  	__u8	namelen;		/* length of name bytes */
> -	__u8	nameval[1];		/* name/value bytes */
> +	__u8	nameval[];		/* name/value bytes */
>  } xfs_attr_leaf_name_local_t;
>  
>  typedef struct xfs_attr_leaf_name_remote {
>  	__be32	valueblk;		/* block number of value bytes */
>  	__be32	valuelen;		/* number of bytes in value */
>  	__u8	namelen;		/* length of name bytes */
> -	__u8	name[1];		/* name bytes */
> +	__u8	name[];			/* name bytes */

Does the large comment about m68k problems in xfs_ondisk.h need updating
here?

--D

>  } xfs_attr_leaf_name_remote_t;
>  
>  typedef struct xfs_attr_leafblock {
> @@ -747,13 +747,13 @@ xfs_attr3_leaf_name_local(xfs_attr_leafblock_t *leafp, int idx)
>   */
>  static inline int xfs_attr_leaf_entsize_remote(int nlen)
>  {
> -	return round_up(sizeof(struct xfs_attr_leaf_name_remote) - 1 +
> +	return round_up(sizeof(struct xfs_attr_leaf_name_remote) +
>  			nlen, XFS_ATTR_LEAF_NAME_ALIGN);
>  }
>  
>  static inline int xfs_attr_leaf_entsize_local(int nlen, int vlen)
>  {
> -	return round_up(sizeof(struct xfs_attr_leaf_name_local) - 1 +
> +	return round_up(sizeof(struct xfs_attr_leaf_name_local) +
>  			nlen + vlen, XFS_ATTR_LEAF_NAME_ALIGN);
>  }
>  
> -- 
> 2.34.1
> 
