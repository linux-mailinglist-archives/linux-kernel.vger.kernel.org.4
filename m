Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313F600C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJQKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJQKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC8B4D4FA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666001847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H56DjNjriKuYIkNZzrbuAEpiMWFGpc/bgBFeaG02L68=;
        b=QWbCYoNYtsD+DDXQ2AahpaCpSMOWxOw/Pcoum64xzbRMcdXprl4JIxr4Rx7NPcMq29FLOk
        uWjsG/MESyjuOz25QPuxhqWFIu9Gr7xG+9G7PDHwml66U+ut9o4HBqlaGsu1+X4UGPfY2b
        FBFIgA0s5GhKy9Qf2gao37zrXSUlzno=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-bE1Sof0vPjCE9Yspl8uFaQ-1; Mon, 17 Oct 2022 06:17:24 -0400
X-MC-Unique: bE1Sof0vPjCE9Yspl8uFaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8BA23C01DF9;
        Mon, 17 Oct 2022 10:17:02 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4C971121319;
        Mon, 17 Oct 2022 10:16:46 +0000 (UTC)
Date:   Mon, 17 Oct 2022 18:16:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Message-ID: <Y00riC6UxmLDhI5P@T590>
References: <20221016052006.11126-1-kch@nvidia.com>
 <Y00fkc1N+Cif/Kxt@T590>
 <0af3d1a4-8166-ea1e-8710-c51479c587a1@nvidia.com>
 <Y00lYIhUNv1CxqiK@T590>
 <52913ebc-5f01-bff4-9b2d-2ee9caf4719d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52913ebc-5f01-bff4-9b2d-2ee9caf4719d@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:04:26AM +0000, Chaitanya Kulkarni wrote:
> On 10/17/22 02:50, Ming Lei wrote:
> > On Mon, Oct 17, 2022 at 09:30:47AM +0000, Chaitanya Kulkarni wrote:
> >>
> >>>> +	/*
> >>>> +	 * Unblock any pending dispatch I/Os before we destroy the device.
> >>>> +	 * From null_destroy_dev()->del_gendisk() will set GD_DEAD flag
> >>>> +	 * causing any new I/O from __bio_queue_enter() to fail with -ENODEV.
> >>>> +	 */
> >>>> +	blk_mq_unquiesce_queue(nullb->q);
> >>>> +
> >>>> +	null_destroy_dev(nullb);
> >>>
> >>> destroying device is never good cleanup for handling timeout/abort, and it
> >>> should have been the last straw any time.
> >>>
> >>
> >> That is exactly why I've added the rq_abort_limit, so until the limit
> >> is not reached null_abort_work() will not get scheduled and device is
> >> not destroyed.
> > 
> > I meant destroying device should only be done iff the normal abort handler
> > can't recover the device, however, your patch simply destroys device
> > without running any abort handling.
> > 
> 
> I did not understand your comment, can you please elaborate on exactly
> where and which abort handlers needs to be called in this patch before
> null_destroy_nullb() ?

In case of request timeout, there may be something wrong which needs
to be recovered.

> 
> the objective of this patch it to simulate the teardown scenario
> from timeout handler so it can get tested on regular basis with
> null_blk ...

Why does teardown scenario have to be triggered for timeout? That
looks you think teardown & destroying device for timeout is one normal
and common way, but I think it is not, the device shouldn't be removed
if it still can work. I have got such kind of complaints of disk
disappeared just by request timeout, such as, nvme-pci.


thanks,
Ming

