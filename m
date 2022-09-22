Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215765E5B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIVGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiIVGUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:20:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19573B56CB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:20:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6262168BEB; Thu, 22 Sep 2022 08:20:10 +0200 (CEST)
Date:   Thu, 22 Sep 2022 08:20:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: Re: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need
 to redirect the completion
Message-ID: <20220922062010.GA27946@lst.de>
References: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk> <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:32:03AM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> High-performance NVMe devices usually support a large hw queue, which

a larger number of?

>  	/*
> -	 * For a polled request, always complete locally, it's pointless
> -	 * to redirect the completion.
> +	 * For request which hctx has only one ctx mapping,
> +	 * or a polled request, always complete locally,
> +	 * it's pointless to redirect the completion.
>  	 */
> -	if (rq->cmd_flags & REQ_POLLED)
> +	if (rq->mq_hctx->nr_ctx == 1 ||
> +		rq->cmd_flags & REQ_POLLED)

Some very odd comment formatting and and indentation here.
