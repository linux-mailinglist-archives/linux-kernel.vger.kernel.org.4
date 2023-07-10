Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE01C74D791
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjGJNad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjGJNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:30:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5435FB;
        Mon, 10 Jul 2023 06:30:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1008867373; Mon, 10 Jul 2023 15:30:25 +0200 (CEST)
Date:   Mon, 10 Jul 2023 15:30:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush
 requests
Message-ID: <20230710133024.GA23157@lst.de>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710064705.1847287-1-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:47:04PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
> data sequence and post-flush sequence need to be done for this request.
> 
> The rq->flush.seq should record what sequences have been done (or don't
> need to be done). So in this case, pre-flush doesn't need to be done,
> we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.
> 
> Of course, this doesn't cause any problem in fact, since pre-flush and
> post-flush sequence do the same thing for now.

I wonder if it really doesn't cause any problems, but the change for
sure looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

It should probably go before your other flush optimizations and maybe
grow a fixes tag.
