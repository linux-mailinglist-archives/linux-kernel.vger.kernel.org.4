Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A516E60CBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiJYMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:33:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CC183E35;
        Tue, 25 Oct 2022 05:33:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E6C8A68B05; Tue, 25 Oct 2022 14:33:30 +0200 (CEST)
Date:   Tue, 25 Oct 2022 14:33:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@lst.de, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
Message-ID: <20221025123330.GB10715@lst.de>
References: <Y1aS3vIbuQTNGWJL@T590> <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com> <Y1cvJ4/uwUScAQq4@T590> <3513b14c-14e0-b865-628e-a83521090de9@huawei.com> <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com> <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com> <Y1epeuwonmjQhrXW@T590> <399a2c2d-0b56-e4e7-c309-a6b9537d8939@huawei.com> <Y1fGrfHqbha6l+hz@T590> <05ae5abd-9b96-3ffe-6bd9-e996d28a8897@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ae5abd-9b96-3ffe-6bd9-e996d28a8897@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:36:10PM +0100, John Garry wrote:
> The requirement is to send this abort command on same queue as erroneous 
> command to ensure that they do not race in HW submission, even though 
> chance of this is really tiny. Maybe we can make low-level driver wait 
> until erroneous command is really submitted to HW by checking HW register, 
> etc. before issuing abort on any HW queue (and so would not need 
> blk_mq_alloc_request_hctx() or similar).

I'm not sure this is a good idea.  I can think of all kinds of interfaces
that could have similar requirements that absolutely do make sense from
the hardware / firmware side.  So despite Ming not liking
blk_mq_alloc_request_hctx there is very little chance of it going away
and thus also very little need to avoid users as more will eventually
pop up if we want it or not.

> BTW, I would still like to fix blk_mq_alloc_request_hctx() to properly init 
> ->bio and other fields - ok?

Yes, it should behave the same blk_mq_alloc_request in that respect,
and we should just copy the assignments to bio, biotail, __sector
and __data_len from it as you did in your RFC patch.

>
> Thanks,
> John
---end quoted text---
