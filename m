Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2074D7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjGJNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjGJNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:33:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B232BA;
        Mon, 10 Jul 2023 06:33:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F1AA67373; Mon, 10 Jul 2023 15:33:09 +0200 (CEST)
Date:   Mon, 10 Jul 2023 15:33:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 2/2] blk-flush: don't need to end rq twice for non
 post-flush requests
Message-ID: <20230710133308.GB23157@lst.de>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev> <20230710064705.1847287-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710064705.1847287-2-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:47:05PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now we unconditionally blk_rq_init_flush() to replace rq->end_io to
> make rq return twice back to the flush state machine for post-flush.
> 
> Obviously, non post-flush requests don't need it, they don't need to
> end request twice, so they don't need to replace rq->end_io callback.
> And the same for requests with the FUA bit on hardware with FUA support.
> 
> So we move blk_rq_init_flush() to REQ_FSEQ_DATA stage and only replace
> rq->end_io if it needs post-flush. Otherwise, it can end like normal
> request and doesn't need to return back to the flush state machine.

I really like the idea behind this optimization, but I kinda hate
adding more magic to the already way too magic flush sequence.

I wonder if a better idea would be to kill the flush sequence entirely,
and just split the flush_queue into a preflush and a postflush queue.
This would remove a field from struct request and lead to more readable
code as well.
