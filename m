Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB02665335
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjAKFQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAKFPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:15:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BEF5AE;
        Tue, 10 Jan 2023 21:06:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67CD668BEB; Wed, 11 Jan 2023 06:06:12 +0100 (CET)
Date:   Wed, 11 Jan 2023 06:06:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v3 08/14] blk-mq: remove unncessary error count and
 commit in blk_mq_plug_issue_direct
Message-ID: <20230111050612.GB16286@lst.de>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com> <20230111130159.3741753-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111130159.3741753-9-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:01:53PM +0800, Kemeng Shi wrote:
> We need only to explicitly commit in two error cases:
>  -did not queue everything initially scheduled to queue
>  -the last attempt to queue a request failed
> (see comment of blk_mq_commit_rqs for more details).
> Both cases can be checked with ret of last request which breaks list walk.
> Remove unnecessary error count and unnecessary commit triggered by error
> which is not covered by cases described above.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  block/blk-mq.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 98f6003474f2..c6c84f44c7a6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2706,11 +2706,10 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
>  	struct blk_mq_hw_ctx *hctx = NULL;
>  	struct request *rq;
>  	int queued = 0;
> -	int errors = 0;
> +	blk_status_t ret;

I think we need to initialize this to BLK_STS_OK here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
