Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2266086A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjAFUpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:45:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CDE9C;
        Fri,  6 Jan 2023 12:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xiUR5yo1Xf+kMhRxDbcyFgKeRt/FmPsE+7rBoN9l/64=; b=mB3DXq7p6xE0ZmjOtPLKf39Eac
        RlcwzW41zXRbvidWKT98jr/aUtzfKlHqHQAoVJCPd0u+2S+8BuiqcD//5cRF0vMnJu29ccM6pgMDy
        CMtKeT1WzPMayddbXJP8zY6NNB6ItbBYYgu7brL0mNSNxjJTFVjyZHcKmb7xfr8+FN7JD78w5lbs4
        jFVgMTSBT32CErD6eG6IS5m/hPGUu4sBaVwYrcob/Ut3TdeQxWhg4xD38N8Fj2W+gIAnICYFTr5tU
        QD0piuJjbQhObchkwzBOD2wv/vJD3UHdmqFVcumN3+6Rpnys805rtfmEggn9H/9lO/dDMgbQqtZtG
        8nQE8opw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDtaS-00ErfA-KQ; Fri, 06 Jan 2023 20:45:12 +0000
Date:   Fri, 6 Jan 2023 12:45:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Dan Carpenter <error27@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep()
 from blk_put_queue()
Message-ID: <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
References: <Y7g3L6fntnTtOm63@kili>
 <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
 <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 10:34:10AM -1000, Tejun Heo wrote:
> Dan reports the following smatch detected the following:
> 
>   block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
> 
> caused by blkcg_schedule_throttle() calling blk_put_queue() in an
> non-sleepable context.
> 
> blk_put_queue() acquired might_sleep() in 63f93fd6fa57 ("block: mark
> blk_put_queue as potentially blocking") which transferred the might_sleep()
> from blk_free_queue().
> 
> blk_free_queue() acquired might_sleep() in e8c7d14ac6c3 ("block: revert back
> to synchronous request_queue removal") while turning request_queue removal
> synchronous. However, this isn't necessary as nothing in the free path
> actually requires sleeping.
> 
> It's pretty unusual to require a sleeping context in a put operation and
> it's not needed in the first place. Let's drop it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lkml.kernel.org/r/Y7g3L6fntnTtOm63@kili
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Fixes: e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal") # v5.9+

*tons* has changed since e8c7d14ac6c3 and so the bots might think that
*if* this patch is applied upstream it is justified for older kernels
and I don't think that's yet been verified and doubt it.

And so I think adding a "Fixes" tag is not appropriate here.

First I'd like to hear from Christoph if he agrees with this patch
upstream. For stable, someone would have to do the homework.

  Luis
