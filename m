Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A75574EDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGKMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGKMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:09:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC5010E5;
        Tue, 11 Jul 2023 05:09:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54F1667373; Tue, 11 Jul 2023 14:09:06 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:09:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush
 requests
Message-ID: <20230711120906.GA27827@lst.de>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev> <20230710133024.GA23157@lst.de> <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev> <20230711113126.GA26978@lst.de> <6825f687-9573-51eb-bb89-17eadb60f71b@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6825f687-9573-51eb-bb89-17eadb60f71b@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:52:11PM +0800, Chengming Zhou wrote:
> On 2023/7/11 19:31, Christoph Hellwig wrote:
> > On Tue, Jul 11, 2023 at 07:06:20PM +0800, Chengming Zhou wrote:
> >> Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.
> > 
> > Btw, it's probably not worth resending patch 2 until we've figured out
> > and dealt with the SATA flush regression that Chuck reported.
> 
> Ok, I will not resend patch 2. As for the patch 1, should I resend it as a separate patch
> or just put it in that series [1] before other flush optimizations ?

I'd wait a bit for debugging the regression.  For the worst case we'll have
to revert the patch, which currently can be done cleanly, but can't be
with that patch.
