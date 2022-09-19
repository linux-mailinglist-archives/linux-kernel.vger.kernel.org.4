Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574585BCF00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiISOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:36:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F64B85A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:36:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44D1568BEB; Mon, 19 Sep 2022 16:35:56 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:35:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Liu Song <liusong@linux.alibaba.com>, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for
 nvme devices
Message-ID: <20220919143556.GA28122@lst.de>
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com> <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk> <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com> <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 08:10:31AM -0600, Jens Axboe wrote:
> I'm not disagreeing with any of that, my point is just that you're
> hacking around this in the nvme driver. This is problematic whenever
> core changes happen, because now we have to touch individual drivers.
> While the expectation is that there are no remote IPI completions for
> NVMe, queue starved devices do exist and those do see remote
> completions.
> 
> This optimization belongs in the blk-mq core, not in nvme. I do think it
> makes sense, you just need to solve it in blk-mq rather than in the nvme
> driver.

I'd also really see solid numbers to justify it.

And btw, having more than one core per queue is quite common in
nvme.  Even many enterprise SSDs only have 64 queues, and some of
the low-end consumers ones have very low number of queues that are
not enough for the number of cores in even mid-end desktop CPUs.
