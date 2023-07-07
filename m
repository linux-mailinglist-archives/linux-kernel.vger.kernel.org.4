Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3674AE83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjGGKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGGKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FF2107
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688724409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSvxmo86chuNdo4OZEtSWD076Vkrebseittknh73kpQ=;
        b=T5UYkQlbFICooyKOPVzLDRMafeoMn/g4z7wsW6SqVeD54uv1lxUQjJPUh4oxKOafq8bx+F
        tRQlCOxgX68P5lgTI7ZyiHJ9dqcJxE0l/lKuCANP3hKsBzLdSDqFbF9lJ59eizHmwvLhcO
        rnuLodQJJbQyUz8VFeF1/FcWuFno4jo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Rg4ImdXwM9ei7Tx08fjlXg-1; Fri, 07 Jul 2023 06:06:41 -0400
X-MC-Unique: Rg4ImdXwM9ei7Tx08fjlXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3C5D185A791;
        Fri,  7 Jul 2023 10:06:40 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED40200BA8B;
        Fri,  7 Jul 2023 10:06:35 +0000 (UTC)
Date:   Fri, 7 Jul 2023 18:06:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v3 4/4] blk-flush: reuse rq queuelist in flush state
 machine
Message-ID: <ZKfjpkBmbM8OZIuI@ovpn-8-34.pek2.redhat.com>
References: <20230707093722.1338589-1-chengming.zhou@linux.dev>
 <20230707093722.1338589-5-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707093722.1338589-5-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 05:37:22PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since we don't need to maintain inflight flush_data requests list
> anymore, we can reuse rq->queuelist for flush pending list.
> 
> Note in mq_flush_data_end_io(), we need to re-initialize rq->queuelist
> before reusing it in the state machine when end, since the rq->rq_next
> also reuse it, may have corrupted rq->queuelist by the driver.
> 
> This patch decrease the size of struct request by 16 bytes.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v3:
>  - fix a bug report of blktests nvme/012, we need to re-initialize
>    rq->queuelist before reusing it in the state machine when end.
>    Because rq->rq_next reuse may have corrupted it. Thanks Ming Lei.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

