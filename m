Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2970097B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbjELNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjELNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:51:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882B132B4;
        Fri, 12 May 2023 06:51:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B0D568AA6; Fri, 12 May 2023 15:51:37 +0200 (CEST)
Date:   Fri, 12 May 2023 15:51:36 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/14] block: blk-merge: fix to add the number of
 integrity segments to the request twice
Message-ID: <20230512135136.GD32242@lst.de>
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1> <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p5> <20230510085208epcms2p52a6dec8da80152ec2101f11ce2ea5321@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510085208epcms2p52a6dec8da80152ec2101f11ce2ea5321@epcms2p5>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject looks a bit odd, I think you're trying to say:

"do not add the number of integrity segments to the request twice"

based on the actual patch, is this correct?

> blk_integrity_merge_bio() not only performs conditional tests, but also
> updates the integrity segment information of request.
> It can be called twice when merging the bio into an existing request.
> 
> bio_attempt_bio_merge() or blk_mq_sched_try_merge()
>   blk_rq_merge_ok()
>     blk_integrity_merge_bio()  -  1
>   bio_attemp_{back|front}_merge()
>     ll_{back|front}_merge_fn()
>       ll_new_hw_segments()
>         blk_integrity_merge_bio()  -  2
> 
> The part of checking the conditions and the code to update the
> information of the actual request were separated. At this time, the
> ll_back_merge_fn was called by passth-path, so the condition check was
> called by all the separated functions.
> 
> And after success in blk_integrity_merge_bio(), the information of the
> request may be wrong if it is impossible to merge due to other
> conditional tests. Thus, it was changed to be called immediately before
> merging the bio's segments.


> +static inline bool blk_integrity_bypass_check(struct request *req,
> +					      struct bio *bio)
> +{
> +	return blk_integrity_rq(req) == 0 && bio_integrity(bio) == NULL;
> +}

No need for the explicit comparisms, this could just be:

	return !blk_integrity_rq(req) && !bio_integrity(bio);

and given that it just has two callers I'm not sure the helper is
all that useful to start with.

> +static bool __blk_integrity_mergeable(struct request_queue *q,
> +				      struct request *req, struct bio *bio)
> +{
> +	if (blk_integrity_rq(req) == 0 || bio_integrity(bio) == NULL)
> +		return false;
> +
> +	if (bio_integrity(req->bio)->bip_flags != bio_integrity(bio)->bip_flags)
> +		return false;
> +
> +	return true;
> +}
> +
> +bool blk_integrity_mergeable(struct request_queue *q, struct request *req,
> +			     struct bio *bio)
> +{
> +	if (blk_integrity_bypass_check(req, bio))
> +		return true;
> +
> +	return __blk_integrity_mergeable(q, req, bio);
> +}

Similarly here, I'm not even sure we need all these helpers.  I supect
the code would become more readable by dropping these helpers and just
making the checks explicitlẏ
