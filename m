Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2998967254B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjARRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjARRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7048604;
        Wed, 18 Jan 2023 09:42:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94DB467373; Wed, 18 Jan 2023 18:42:08 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:42:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 12/14] blk-mq: remove set of bd->last when get
 driver tag for next request fails
Message-ID: <20230118174208.GH12399@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-12-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-12-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:37:24PM +0800, Kemeng Shi wrote:
> Commit 113285b473824 ("blk-mq: ensure that bd->last is always set
> correctly") will set last if we failed to get driver tag for next
> request to avoid flush miss as we break the list walk and will not
> send the last request in the list which will be sent with last set
> normally.
> This code seems stale now becase the flush introduced is always
> redundant as:
> For case tag is really out, we will send a extra flush if we find
> list is not empty after list walk.
> For case some tag is freed before retry in blk_mq_prep_dispatch_rq for
> next, then we can get a tag for next request in retry and flush notified
> already is not necessary.

I think Ming will know this code better than me, but aren't we
losing the blk_mq_get_driver_tag call entirely here now.  Where
is getting the driver tag covered now?
