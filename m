Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0960936E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJWNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJWNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA80792E5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666530781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElBoOb/aaEQguEnJtsaOEHzPiqut+It2HNHz/IrkdQs=;
        b=ZPE0yUuTWQInL/cs1+yP1Wn0kszL9Ia/+NWClfQCQFbah2PlaA008RKrDNICP5nh+m9gKh
        BQgCagaT7REtC4bqNNnUvnKdBULJ/SGzVoNmTuhvYWX6ENZlGQKTV6UYvDJVpJ32MXfTED
        iyQSBeU6pqNPbWftuvOBnreBjZD3v14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-3zwIAvp5OTSJZF2inzbzNA-1; Sun, 23 Oct 2022 09:12:56 -0400
X-MC-Unique: 3zwIAvp5OTSJZF2inzbzNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2E4686E91C;
        Sun, 23 Oct 2022 13:12:55 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73E834A9255;
        Sun, 23 Oct 2022 13:12:50 +0000 (UTC)
Date:   Sun, 23 Oct 2022 21:12:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
Message-ID: <Y1U9zNZtZjRHQBww@T590>
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 12:07:26AM +0800, John Garry wrote:
> Function blk_mq_alloc_request_hctx() is missing zeroing/init of rq->bio,
> biotail, __sector, and __data_len members, which blk_mq_alloc_request()
> has.
> 
> Move init'ing of those members to common blk_mq_rq_ctx_init().
> 
> Fixes: 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx")
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..260adeb2e455 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -402,6 +402,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  		}
>  	}
>  
> +	rq->__data_len = 0;
> +	rq->__sector = (sector_t) -1;
> +	rq->bio = rq->biotail = NULL;
> +
>  	return rq;
>  }
>  
> @@ -591,9 +595,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>  		if (!rq)
>  			goto out_queue_exit;
>  	}
> -	rq->__data_len = 0;
> -	rq->__sector = (sector_t) -1;
> -	rq->bio = rq->biotail = NULL;

This patch looks not good, why do you switch to initialize the three fields
twice in fast path?

BTW, we know blk_mq_alloc_request_hctx() has big trouble, so please
avoid to extend it to other use cases.

Thanks,
Ming

