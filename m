Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3D6150DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiKARhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKARhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:37:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8609B0A;
        Tue,  1 Nov 2022 10:37:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 73B6368B05; Tue,  1 Nov 2022 18:37:28 +0100 (CET)
Date:   Tue, 1 Nov 2022 18:37:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] blk-mq: improve readability of
 blk_mq_alloc_request()
Message-ID: <20221101173727.GC20690@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn> <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:11:37PM +0800, Jinlong Chen wrote:
> Add a helper blk_mq_alloc_request_nocache() to alloc request without
> cache. This makes blk_mq_alloc_request() more readable.
> 
> Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
> ---
>  block/blk-mq.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 87a6348a0d0a..2fae111a42c8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -572,36 +572,47 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
>  	return rq;
>  }
>  
> +static struct request *blk_mq_alloc_request_nocache(struct request_queue *q,
> +		blk_opf_t opf, blk_mq_req_flags_t flags)

The name is a bit odd, but I can't think off a better one.

> +	struct blk_mq_alloc_data data = {
>  			.q		= q,
>  			.flags		= flags,
>  			.cmd_flags	= opf,
>  			.nr_tags	= 1,
>  		};

And this now has superflous indenation.  Overall, while the separate
helper looks marginally nicer, I'm not really sure it is worth the
churn.
