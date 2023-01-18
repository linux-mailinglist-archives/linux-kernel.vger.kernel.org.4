Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F402672519
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjARRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjARRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:37:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F53B0ED;
        Wed, 18 Jan 2023 09:37:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 75BFE67373; Wed, 18 Jan 2023 18:37:46 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:37:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
Message-ID: <20230118173745.GC12399@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-7-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-7-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:37:19PM +0800, Kemeng Shi wrote:
> +/*
> + * blk_mq_commit_rqs will notify driver using bd->last that there is no
> + * more requests. (See comment in struct blk_mq_ops for commit_rqs for
> + * details)
> + * Attention, we should explicitly call this in unusual cases:
> + *  1) did not queue everything initially scheduled to queue
> + *  2) the last attempt to queue a request failed
> + */
> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued,
> +			      bool from_schedule)

Isn't from_schedule always false here as well now?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
