Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA71655B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 23:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLXWGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 17:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLXWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 17:06:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A765C3;
        Sat, 24 Dec 2022 14:06:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96D3BB80184;
        Sat, 24 Dec 2022 22:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE9CC433D2;
        Sat, 24 Dec 2022 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671919602;
        bh=FDRW/65+iOIG+xRl7DZC4z2D8oXawEPLvY0Logj1h7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azEswh39v0IPU+yFWhK/l7jZnBdIuQyRXDASQsXm26TOOIzxu45HD40/Jn/oOhOxB
         l8kSRtNTPKTH4KrhYFqQD8IwI59cyqoCffkqxPjuPgu6GZu2fP7ihtHA/8EfiUCPdm
         igs7kG3lysEgaOhZICnOxgh12LqqdfXwzz1RE/+HUO4/xEW7UY9PjwGB+BR8JCvbrQ
         wpne5B4xhd0oFoRhz/ea7mYjO8NAKeh8CBQMgP0PRr9cscfG1cfmom0YJ+S8eXIZcx
         KQ4RoXlKeKdjA6ifcFhSS5mJIcfUZAczlIElcgldw4z4ZTmIjjs0tI+5HTtvgddYpV
         jj/HBtGAatVFQ==
Date:   Sat, 24 Dec 2022 15:06:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
Message-ID: <Y6d37vGSCKvfJhzD@kbusch-mbp.dhcp.thefacebook.com>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:24:56PM -0800, Hugh Dickins wrote:
> Hi Christoph,
> 
> There's something wrong with the nvme-pci heading for 6.2-rc1:
> no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
> but under load...
> 
> nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: I/O 0 QID 2 timeout, reset controller
> 
> ...and more, until I just have to poweroff and reboot.
> 
> Bisection points to your
> 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> And that does revert cleanly, giving a kernel which shows no problem.
> 
> I've spent a while comparing old nvme_pci_alloc_tag_set() and new
> nvme_alloc_io_tag_set(), I do not know my way around there at all
> and may be talking nonsense, but it did look as if there might now
> be a difference in the queue_depth, sqsize, q_depth conversions.
> 
> I'm running load successfully with the patch below, but I strongly
> suspect that the right patch will be somewhere else: over to you!
> 
> Hugh
> 
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ct
>  
>  	memset(set, 0, sizeof(*set));
>  	set->ops = ops;
> -	set->queue_depth = ctrl->sqsize + 1;
> +	set->queue_depth = ctrl->sqsize;

Your observation is a queue-wrap condition that makes it impossible for
the controller know there are new commands.

Your patch does look like the correct thing to do. The "zero means one"
thing is a confusing distraction, I think. It makes more sense if you
consider sqsize as the maximum number of tags we can have outstanding at
one time and it looks like all the drivers set it that way. We're
supposed to leave one slot empty for a full NVMe queue, so adding one
here to report the total number slots isn't right since that would allow
us to fill all slots.

Fabrics drivers have been using this method for a while, though, so
interesting they haven't had a simiar problem.
