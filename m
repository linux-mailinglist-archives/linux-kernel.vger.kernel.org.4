Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC468B245
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBEWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBEWvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:51:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A612073
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:51:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso12140580pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 14:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vltg+qyRmAFaMaG1YchFrPG4SzAtjrxtGAl46s29iGE=;
        b=2lu9XXytkUFss4F8vVDKku/NHoYmaR8HEdh8+mFz/F1i0SlCO8/jEvT2PfTGyEuNVH
         PpTrkyhLM8bf4wyA56sqsq6tjcC1BdL/7mgr5oLDOYkpkBznDuWEX7oKG7UqzpDGD8NR
         +VXFMflxzlmj2NVstw8JiLzRFlT/8s6JhZv1ca2yFMsIpMYmsXWhk0JUS54BmmPTsFmp
         ozq8iTmCAWlqgUUpbiftPnPByzVUfOsAhmK7U323VHbZ7dlEAScJdRdUff+dcvQTGgoz
         vvSrSDiInmxKEMhfVkYvPlyS/ekO9xx6U5AEKf4b3PH4HR0qS+oszRNE59+eWzXwa+hh
         qhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vltg+qyRmAFaMaG1YchFrPG4SzAtjrxtGAl46s29iGE=;
        b=SdKDIfSv60t7nJrAmxDGj0tB9oTxGltQ33vM3sHDCE3YGoBjAOQnHM6+js67rw9N7s
         6znGJQXiKTb4Me2/opYy8pJW1mYtdXOg1XcjE3GsHzgs6y8C79i+HZAJrUgBWsjb7uJu
         IxYIBjditmZuX9EcTMI8WdEuRz9OwbsNR3GYR9yPzOuVDY0iO4VfkSyoS6ijme1vhUZZ
         7ylGN6FYsdWtjkWUyJhXetW4kzgDhkc93a/64Uan6vMdcioGuqAfHl5Dh8+3tHFQ3zbc
         Kg52aShUGr1V8PDbe5f/kEReMd7qXrb0HjWkdK7V+fsr/+rLBw/xZIK5c4K3Pdv84MZO
         ginw==
X-Gm-Message-State: AO0yUKWgtXREEZE5SMWCZBPKZPnQ2uMI3Ow6l4oOSd/t7fqMxYnReX5n
        aTliKnGx3A805WVnOYn0JQ0psQ==
X-Google-Smtp-Source: AK7set/qcpnluPAIWPikeSKh5pK6k7uQI1o6H6RJ6yA9QiyEMvQFcfELyfKM/3hzZoy1mb+66n6EEA==
X-Received: by 2002:a05:6a20:3952:b0:bc:d288:a67b with SMTP id r18-20020a056a20395200b000bcd288a67bmr23662478pzg.43.1675637482097;
        Sun, 05 Feb 2023 14:51:22 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id a33-20020a056a001d2100b005941ff79428sm5700363pfx.90.2023.02.05.14.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:51:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pOnqx-00Bp4s-1S; Mon, 06 Feb 2023 09:51:19 +1100
Date:   Mon, 6 Feb 2023 09:51:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xfs: Replace one-element arrays with
 flexible-array members
Message-ID: <20230205225119.GU360264@dread.disaster.area>
References: <Y9xiYmVLRIKdpJcC@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xiYmVLRIKdpJcC@work>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

That seems like a red flag to me - an off-by-one change in the
compiled code that calculates of the on-disk size of a structure as
a result of an in-memory structure change just smells like a bug.

How did you test this change?

> And the reason for this is because of the round_up() macro called in
> functions xfs_attr_leaf_entsize_remote() and xfs_attr_leaf_entsize_local(),
> which is compensanting for the one-byte reduction in size (due to the
> flex-array transformation) of structures xfs_attr_leaf_name_remote and
> xfs_attr_leaf_name_local. So, sizes remain the same before and after
> changes.

I'm not sure that is true. Before this change:

sizeof(xfs_attr_leaf_name_local_t) = 4
sizeof(xfs_attr_leaf_name_remote_t) = 12

After this change:

sizeof(xfs_attr_leaf_name_local_t) = 4
sizeof(xfs_attr_leaf_name_remote_t) = 12

i.e. no change because the structures aren't defined as packed
structures.  Hence the compiler pads them to out to 4 byte alignment
naturally regardless of the flex array definition. pahole on x86-64
also confirms that the (padded) size of the structure is not
changed.

However, the on-disk structure it is being used to decode is packed,
and we're only using pointer arithmetic to pull the location of the
name/value pairs out of the buffer to copy them - it's the structure
size calculations that actually define the size of the structures
for a given name length, not the sizeof() value or the flex array
definitions...

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

To be honest, the actual padding and alignment calculations are
kinda whacky because that's the way they were defined back in 1995.
And, well, once set in the on-disk format, it can't easily be
changed. FYI, here's the original definition from 1995:

#define XFS_ATTR_LEAF_ENTSIZE_REMOTE(nlen)	/* space for remote struct */ \
	(((sizeof(xfs_attr_leaf_name_remote_t)-1 + (nlen)) +3)&~0x3)

So apart using round_up and defines instead of magic numbers, the
current calculation is unchanged from the original definition.

AFAICT, the modification you are proposing above breaks this because the
sizeof(xfs_attr_leaf_name_remote) result has not changed with the
change of the structure definition.

e.g. if namelen = 17, before we had:

	size	= round_up(12 - 1 + 17, 4)
		= round_up(28, 4)
		= 28

Which is correct because the on-disk format is packed:

        0   4   89  12      20   26 28
	+---+---++--+-------+-----+-+-----....
                  |---------------| 17 bytes of name. 
		                  |-| 2 bytes of padding
				    |-----.... Next attr record.

We end up with 2 bytes of padded between the end of the name and the
start of the next attribute record in the block.

But after this patch, now we calculate the size as:

	size	= round_up(12 + 17, 4)
		= round_up(29, 4)
		= 32

Which is a different result, and would result in incorrect parsing
of the attribute records in the buffer. Hence I don't think it is
valid to be changing the entsize calculations like this if sizeof()
is not changing results.

Which comes back to my original question: how did you test this?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
