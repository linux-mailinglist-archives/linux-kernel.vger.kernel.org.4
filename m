Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83D6A8F85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCCDAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCCDAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8E168A0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677812360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml1Mi4USLtb96dzjtzwKcD2jz6nSxexHok5ovftQxq8=;
        b=Xq2zSqfy8OlP46KP+RyPVDuajMZTOVfUvRY4ghkwk3tmnwwBctsp9EqnO4GBPT1mjQbVlK
        m47eKTQZmG1gQ2IlD8ErtPbWcAHBueTC+yJDhF1NZ03QhW7XGgkDh76lUZ/S8i5yV8lA1V
        7k3RsbmPX00aC86BwEH24NcaPduLTck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-aL_l_Ez1OIy6a5h4oBYbWg-1; Thu, 02 Mar 2023 21:59:17 -0500
X-MC-Unique: aL_l_Ez1OIy6a5h4oBYbWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB817800B23;
        Fri,  3 Mar 2023 02:59:16 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9932026D4B;
        Fri,  3 Mar 2023 02:59:10 +0000 (UTC)
Date:   Fri, 3 Mar 2023 10:59:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Message-ID: <ZAFieW9PZ2LNQYHa@T590>
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590>
 <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
 <87h6v3l9up.fsf@metaspace.dk>
 <ZAChttVoCHsnXmvF@T590>
 <875ybjl1r0.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875ybjl1r0.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 02:28:33PM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Thu, Mar 02, 2023 at 11:07:15AM +0100, Andreas Hindborg wrote:
> >> 
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> 
> >> > On Thu, Mar 2, 2023 at 5:02 PM Ming Lei <ming.lei@redhat.com> wrote:
> >> >>
> >> >> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> >> >> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> >> >> > >
> >> >>
> >> >> ...
> >> >>
> >> >> > >
> >> >> > > I agree about fetching more zones. However, it is no good to fetch up to
> >> >> > > a max, since the requested zone report may less than max. I was
> >> >> >
> >> >> > Short read should always be supported, so the interface may need to
> >> >> > return how many zones in single command, please refer to nvme_ns_report_zones().
> >> >>
> >> >> blk_zone is part of uapi, maybe the short read can be figured out by
> >> >> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
> >> >> reporting zones.
> >> >
> >> > oops, we have blk_zone_report data for reporting zones to userspace already,
> >> > see blkdev_report_zones_ioctl(), then this way can be re-used for getting zone
> >> > report from ublk server too, right?
> >> 
> >> Yes that would be nice. But I did the report_zone command like a read
> >> operation, so we are not currently copying any buffers to user space
> >> when issuing the command, we just rely on the iod.
> >
> > What I meant is to reuse the format of blk_zone_report for returning
> > multiple 'blk_zone' info in single command.
> >
> > The only change is that you need to allocate one bigger kernel buffer
> > to hold more 'blk_zone' in single report zone request.
> >
> >> I think it would be
> >> better to use the start_sectors and nr_sectors of the iod instead. Then
> >> we don't have to copy the blk_zone_report. What do you think?
> >
> > For IN parameter of report zone command, you still can reuse
> > blk_zone_report:
> >
> > struct blk_zone_report {
> >         __u64           sector;
> >         __u32           nr_zones;
> >         __u32           flags;
> > };
> >
> > Just by using the 1st two 64b words of iod for holding 'blk_zone_report', and
> > keep the iod->addr field not touched.
> 
> I see. Would you make the first part of `struct ublksrv_io_desc` a union
> for this, or would you just cast it at the use site?

oops, you still need iod->op_flags for recognizing the io op, so just
start_sector and nr_sectors can be used.

However, this way isn't good too, cause UBLK_IO_OP_DRV_IN is just mapped
to 'report zone' command in your implementation, what if new pt request
is required in future?

We need to think about how to support ublk pt request in generic way.

Thanks,
Ming

