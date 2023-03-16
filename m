Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29016BD84E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCPSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A8411E93
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C93620E3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 18:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4858C433D2;
        Thu, 16 Mar 2023 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678992242;
        bh=n0pBD+LVa6I/weZ5XEhYq/DeLZruwMfnM+k5setIJ0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ+7DdBJaO0K0G074cV0gSMSA3DmwykGjyrl4OLR+q9GoDVUN345AwJVdalGjPCgi
         hR37GgtFP0FTInADhqo3ugj+5SO3iusKEXnu15Xcir9wkuO24txaC8ROi4OTO88cG1
         o0bJfp4GYxetu7WbS8nafcCtME+T2IceVZ/A/ApbIdqUx28ywKnLFsWkToXzZr/Ho+
         zr7ZMu0H4vX1nH3zoKIxgzvF9fFhD+Z04zTcOiNYF4AdloJ19ETM2/PLZNBFAi2I0h
         /UiXR6nrQxPKEolqKs5GZBYkGkrKBz/YXJmtZLOOJUDudyEH6X+/KjYIBvNhfDHFRR
         /1E1z60EVX0tw==
Date:   Thu, 16 Mar 2023 18:44:00 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yeongjin Gil <youngjin.gil@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        totte@google.com, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] dm verity: fix error handling for check_at_most_once
Message-ID: <ZBNjcA1feNWUxvaW@gmail.com>
References: <CGME20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff@epcas1p1.samsung.com>
 <20230316031842.17295-1-youngjin.gil@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316031842.17295-1-youngjin.gil@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yeongjin,

On Thu, Mar 16, 2023 at 12:18:42PM +0900, Yeongjin Gil wrote:
> In verity_work(), the return value of verity_verify_io() is converted to
> blk_status and passed to verity_finish_io(). BTW, when a bit is set in
> v->validated_blocks, verity_verify_io() skips verification regardless of
> I/O error for the corresponding bio. In this case, the I/O error could
> not be returned properly, and as a result, there is a problem that
> abnormal data could be read for the corresponding block.
> 
> To fix this problem, when an I/O error occurs, do not skip verification
> even if the bit related is set in v->validated_blocks.
> 
> Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")
> 
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> ---
>  drivers/md/dm-verity-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index ade83ef3b439..9316399b920e 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -523,7 +523,7 @@ static int verity_verify_io(struct dm_verity_io *io)
>  		sector_t cur_block = io->block + b;
>  		struct ahash_request *req = verity_io_hash_req(v, io);
>  
> -		if (v->validated_blocks &&
> +		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
>  		    likely(test_bit(cur_block, v->validated_blocks))) {
>  			verity_bv_skip_block(v, io, iter);
>  			continue;

Thanks for sending this patch!  This looks like a correct fix, but I have some
comments:

* Using "check_at_most_once" is strongly discouraged, as it reduces security.
  If you are using check_at_most_once to improve performance at the cost of
  reduced security, please consider that very recently, dm-verity performance
  has significantly improved due to the removal of the WQ_UNBOUND workqueue flag
  which was causing significant I/O latency.  See commit c25da5b7baf1
  ("dm verity: stop using WQ_UNBOUND for verify_wq").

* I think your commit message does not explain a key aspect of the problem which
  is why is verity even attempted when the underlying I/O has failed?  This
  appears to be because of the Forward Error Correction (FEC) feature.  So, this
  issue is specific to the case where both FEC and check_at_most_once is used.
  Can you make your commit message explain this?

* This patch does not appear to have been received by the dm-devel mailing list,
  which is the list where dm-verity patches should be reviewed on.  It doesn't
  show up in the archive at https://lore.kernel.org/dm-devel.  Also, I'm
  subscribed to dm-devel and I didn't receive this patch in my inbox.  (I had to
  download it from https://lore.kernel.org/lkml instead.)  Did you receive a
  bounce message when you sent this patch?

* Please add 'Cc: stable@vger.kernel.org' to the commit message, just below the
  Fixes line, as per Documentation/process/stable-kernel-rules.rst.  This will
  ensure that the fix will be backported to the stable kernels.

* "Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>" does not have a
  corresponding Author or Co-developed-line, which is not allowed.  Did you mean
  to list Sungjong as the Author or as a co-author?

* No blank line between Fixes and the Signed-off-by line(s), please.

Thanks!

- Eric
