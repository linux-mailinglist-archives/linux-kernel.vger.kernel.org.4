Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5255EAC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiIZQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiIZQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:17:12 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BFD5FA9C2F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:06:20 -0700 (PDT)
Received: (qmail 410297 invoked by uid 1000); 26 Sep 2022 11:06:19 -0400
Date:   Mon, 26 Sep 2022 11:06:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] rapidio/tsi721: Replace flush_scheduled_work() with
 flush_work().
Message-ID: <YzG/664Z5XqLD/yM@rowland.harvard.edu>
References: <0e8a2023-7526-f03a-f520-efafbb0ef45c@I-love.SAKURA.ne.jp>
 <20220925102742.84ccc07ce1e8e591e4d5ce0f@linux-foundation.org>
 <d039cbbd-4aa7-58bf-b93d-be23443c52b6@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d039cbbd-4aa7-58bf-b93d-be23443c52b6@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 07:28:37PM +0900, Tetsuo Handa wrote:
> On 2022/09/26 2:27, Andrew Morton wrote:
> > On Sat, 24 Sep 2022 14:11:25 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > 
> >> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> >> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
> >> We are on the way for removing all flush_scheduled_work() callers from
> >> the kernel, and this patch is for removing flush_scheduled_work() call
> >>  from tsi721 driver.
> >>
> >> Since "struct tsi721_device" is per a device struct, I assume that
> >> tsi721_remove() needs to wait for only two works associated with that
> >> device. Therefore, wait for only these works using flush_work().
> >>
> >> --- a/drivers/rapidio/devices/tsi721.c
> >> +++ b/drivers/rapidio/devices/tsi721.c
> >> @@ -2941,7 +2941,8 @@ static void tsi721_remove(struct pci_dev *pdev)
> >>  
> >>  	tsi721_disable_ints(priv);
> >>  	tsi721_free_irq(priv);
> >> -	flush_scheduled_work();
> >> +	flush_work(&priv->idb_work);
> >> +	flush_work(&priv->pw_work);
> >>  	rio_unregister_mport(&priv->mport);
> > 
> > Why not use cancel_work[_sync](), as the flush_scheduled_work() comment
> > recommends?
> > 
> 
> Alan Stern suggested to use cancel_work_sync() in
> commit eef6a7d5c2f38ada ("workqueue: warn about flush_scheduled_work()")
> and Tejun Heo suggested to use flush_work() in
> https://lkml.kernel.org/r/YjivtdkpY+reW0Gt@slm.duckdns.org .
> 
> Is there some reason to prefer one over the other?
> I think that user-visible results between flush_work() and cancel_work_sync()
> are the same because both wait until work completes.

No, you haven't got it quite right.  flush_work() waits until the work 
completes, but cancel_work_sync() first tries to cancel the work item.  
It then waits until the work item is either cancelled or completed.

If the cancellation is successful (i.e., it happens before the work item 
starts to run) then the call will return at that time and the work item 
will never run -- hence it will never complete.

Alan Stern
