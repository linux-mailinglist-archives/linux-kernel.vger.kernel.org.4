Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9BB60C719
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJYJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJYJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234D132249
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666688431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffS7/S+akc8/x+RmIejdmt+s1na/0VWtBH57nlzZtYo=;
        b=aEX/upCJG0ildrIrJ2BUh/lEGvxPVqed9w+q/iH4Vw9XivGQuFZS+edWq6K9zX9bx/n9Wx
        M5p48Vpry2czIMXCwa1OK51lk4evzBY9ybJxipnoqfRNWBBNsEbizRz1mmty7nJaoLq7ED
        WhTLID4kkDUNjNcIxDymFkzHuViPie4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-zPAuTeCCMEOe_vRemxg8Vg-1; Tue, 25 Oct 2022 05:00:28 -0400
X-MC-Unique: zPAuTeCCMEOe_vRemxg8Vg-1
Received: by mail-vk1-f198.google.com with SMTP id d71-20020a1f1d4a000000b003aefb0388b4so3545387vkd.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffS7/S+akc8/x+RmIejdmt+s1na/0VWtBH57nlzZtYo=;
        b=gAo55FoncqxQuff0AjzG0ztR012/iurg/IsFFOgdRFbEsPiHTQFpAz9DdUBwwHHGfm
         f4N5R0gcPSnGe6pqbT/oVa7TWqBZT0lfYn6t1CtIJBVPRH9JEX6cczINXI2gUDqqUqx/
         IfQvwSsK1uMtmNdcch7gkb8rf8sZjkG8qHsVtgW06J7055Gy70T5J6BKvs6NQYs18tTM
         XAoDVUcAQgAT5awEvE/PeIMjnrD08FE2MKIDnGtRT/KJcDNeNuXxRVmmyWWbF8ObeFty
         BudOe//u8KomBA+qnb+qg0r2ezulmaVCctyHvQQc+Ij7C+0f3LEFcn0cN7VMT0y3+8x0
         xQ9Q==
X-Gm-Message-State: ACrzQf2pP9VQcHewcJnPImN+b48/f6M76ihFMV0qUL5uXWnyW4NfF9Q5
        RxJ4tL+6d8M3igfrTnSPADpFJh+w5sSFBVm69+xiaY2L8Bd8FnZz9tDFNhMphJxt/LzHt4j12o0
        wwMJLoqE655f4cgUHulTyc/8+/P6FS6C9FhcHiV2U
X-Received: by 2002:a67:f346:0:b0:3aa:2ae7:7b12 with SMTP id p6-20020a67f346000000b003aa2ae77b12mr3682668vsm.86.1666688427692;
        Tue, 25 Oct 2022 02:00:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ePHCAZe9sOFrpoaAtGPVrlunRpr3ktgdgGKee8ha6/UviSPYtHFMHdHDgsJrryhiJuUTZhd9bLqRtR+wbFOA=
X-Received: by 2002:a67:f346:0:b0:3aa:2ae7:7b12 with SMTP id
 p6-20020a67f346000000b003aa2ae77b12mr3682660vsm.86.1666688427280; Tue, 25 Oct
 2022 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590> <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590> <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
 <Y1cvJ4/uwUScAQq4@T590> <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
In-Reply-To: <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 25 Oct 2022 17:00:16 +0800
Message-ID: <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Properly init bios from blk_mq_alloc_request_hctx()
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 3:40 PM John Garry <john.garry@huawei.com> wrote:
>
> On 25/10/2022 01:34, Ming Lei wrote:
> >>>> but sometimes we just need to allocate for a specific HW
> >>>> queue...
> >>>>
> >>>> For my usecase of interest, it should not impact if the cpumask of the HW
> >>>> queue goes offline after selecting the cpu in blk_mq_alloc_request_hctx(),
> >>>> so any race is ok ... I think.
> >>>>
> >>>> However it should be still possible to make blk_mq_alloc_request_hctx() more
> >>>> robust. How about using something like work_on_cpu_safe() to allocate and
> >>>> execute the request with blk_mq_alloc_request() on a cpu associated with the
> >>>> HW queue, such that we know the cpu is online and stays online until we
> >>>> execute it? Or also extent to work_on_cpumask_safe() variant, so that we
> >>>> don't need to try all cpus in the mask (to see if online)?
> >>> But all cpus on this hctx->cpumask could become offline.
> >> If all hctx->cpumask are offline then we should not allocate a request and
> >> this is acceptable. Maybe I am missing your point.
> > As you saw, this API has the above problem too, but any one of CPUs
> > may become online later, maybe just during blk_mq_alloc_request_hctx(),
> > and it is easy to cause inconsistence.
> >
> > You didn't share your use case, but for nvme connection request, if it
> > is 1:1 mapping, if any one of CPU becomes offline, the controller
> > initialization could be failed, that isn't good from user viewpoint at
> > all.
>
> My use case is in SCSI EH domain. For my HBA controller of interest, to
> abort an erroneous IO we must send a controller proprietary abort
> command on same HW queue as original command. So we would need to
> allocate this abort request for a specific HW queue.

IMO, it is one bad hw/sw interface.

First such request has to be reserved, since all inflight IOs can be in error.

Second error handling needs to provide forward-progress, and it is supposed
to not require external dependency, otherwise easy to cause deadlock, but
here request from specific HW queue just depends on this queue's cpumask.

Also if it has to be reserved, it can be done as one device/driver private
command, so why bother blk-mq for this special use case?

>
> I mentioned before that if no hctx->cpumask is online then we don't need
> to allocate a request. That is because if no hctx->cpumask is online,
> this means that original erroneous IO must be completed due to nature of
> how blk-mq cpu hotplug handler works, i.e. drained, and then we don't
> actually need to abort it any longer, so ok to not get a request.

No, it is really not OK, if all cpus in hctx->cpumask are offline, you
can't allocate
request on the specified hw queue, then the erroneous IO can't be handled,
then cpu hotplug handler may hang for ever.

Thanks,
Ming

