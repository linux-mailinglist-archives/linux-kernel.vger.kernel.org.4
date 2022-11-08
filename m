Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE75621A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiKHRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiKHRXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:23:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E15EA6;
        Tue,  8 Nov 2022 09:23:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD3DC614FA;
        Tue,  8 Nov 2022 17:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B956C433D6;
        Tue,  8 Nov 2022 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667928215;
        bh=hQg7NoKja9TGe1uumJQDYjviyfCTnfLxmswlsfS/doA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSd+n7EE0MNX8tHp3LUL4qUnk/MPwMLUQgiWCVIl7kax2vTSV/3xCxAlRW5WHEC0x
         drPFNSZrYwOh7acWU1RUVu/qXRWXj4K9KBW5Gpl2ZOfmuZd4YCl9In1ysJNm99LCkc
         oeacoG/asj5IgNc8yKo5f5Bsa6JQ1oXUzq/3qyXApUv26+lD0D3qDGKgFaJA52Ub/J
         mHYT1nLia7/P3lq7RXvHJJVbPA66HFsULrud/EBTMd1GYrJhcfbLwHNfqCxnQOm5oO
         th7Hrptz99tmaYorsTtnWTlKcZq2xgZ0b8XhP46c+WMveHDJirW5AqfDfkqDMcl4/J
         kKcPWw5HxOhNA==
Date:   Tue, 8 Nov 2022 10:23:31 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <Y2qQk/LuiNNdmdRD@kbusch-mbp>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <20221108074846.GA22674@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108074846.GA22674@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:48:47AM +0100, Christoph Hellwig wrote:
> Below is the minimal fix.  I'll see if I sort out the mess that is
> probe/reset failure vs ->remove a bit better, though.

This looks good to go. I vote apply for 6.1, and we should consider
merging your larger refactor for 6.2 after more test/review.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f94b05c585cbc..577bacdcfee08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>  
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
> +	if (!ctrl->tagset)
> +		return;
>  	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>  		blk_mq_quiesce_tagset(ctrl->tagset);
>  	else
> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>  
>  void nvme_start_queues(struct nvme_ctrl *ctrl)
>  {
> +	if (!ctrl->tagset)
> +		return;
>  	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>  		blk_mq_unquiesce_tagset(ctrl->tagset);
>  }
> 
