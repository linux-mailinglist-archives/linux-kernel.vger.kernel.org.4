Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA25F9A47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiJJHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJJHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761164DA;
        Mon, 10 Oct 2022 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AUwsgJTxZk8MKdj+SCxkYVH878r8ylsMxJbYQCvp10o=; b=36JjWNXQMhRmkN9OEY1rDRHUdK
        d1oK6KGl/G7BhWmiM6SufkiJxHGg9TQcoalzygczfJMMqaXA7xf0Gb8+NaAySsBndO1tNghqgGQvW
        5GZQHIj6v/GaOOzK/H+lPNZXcPQWq940j1W/D044PI8hwrZSMKZtY2k3rbXMbK1eVON7yr/8SlN/D
        wjL7kmmve/QYCjP95EhwPAZ7g6cIVOepLkFzZ6JZjvzQpCxJZrn4XbI8bjUeGwE99AjOtaACBhP3w
        SgPJi9XnucU0vk+0UHqrDVwPWotluk2VyxkKDvtJH9KDpBzNZQa5bxJDDWIPbNAWO/0psy57oBFZi
        7wycACFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnO3-00HPFA-EF; Mon, 10 Oct 2022 07:39:43 +0000
Date:   Mon, 10 Oct 2022 00:39:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yuwei Guan <Yuwei.Guan@zeekrlife.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: initialize csd/fifo_time before use
Message-ID: <Y0PMPw3pMFWZ11id@infradead.org>
References: <20221010071916.1075-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010071916.1075-1-Yuwei.Guan@zeekrlife.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 03:19:16PM +0800, Yuwei Guan wrote:
> csd/fifo_time need to be initialized before use again,
> otherwise, it will keep the last tag value.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>  block/blk-mq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..f55d41f1d150 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -383,6 +383,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>         rq->end_io = NULL;
>         rq->end_io_data = NULL;
> 
> +       /* initialize csd/fifo_time before use */
> +       memset(&rq->csd, 0x0, sizeof(rq->csd));

This is a rather unusual spelling of 0.  But more importantly what
problem with reuse do you actually see here? The csd is always
initialized before use as it can't otherwise work.  fifo_time
also appears to, but the code is a bit convoluted.

