Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2196A96AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCCLso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCCLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52264C31
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677844077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKSjKJl1pXB3VlI79sKpQ8uqGGzbCBbmcPQmQEYw5z8=;
        b=fEdrebuHfFEHpHdxR9D5zwyDTDQV2co7O4/kNqZ2tT7XvwvWkc9MYQTdgr9Gn9bbQ8nHFt
        SMTQXoSKT2X0h3OFN6PkWp2VlsnG4Q8px4B4j8xZLyrN3OkxHnhDlkoMKecQcvXkJtFXnI
        amsT9XfTZlqwuH6YDoE3Hq4avOG064o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-8Q0shVz8OlS3ZCThyl6NJw-1; Fri, 03 Mar 2023 06:47:51 -0500
X-MC-Unique: 8Q0shVz8OlS3ZCThyl6NJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 438391C05157;
        Fri,  3 Mar 2023 11:47:51 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF80E4010E86;
        Fri,  3 Mar 2023 11:47:45 +0000 (UTC)
Date:   Fri, 3 Mar 2023 19:47:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Message-ID: <ZAHeWieKXtgYUbvz@ovpn-8-18.pek2.redhat.com>
References: <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590>
 <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
 <87h6v3l9up.fsf@metaspace.dk>
 <ZAChttVoCHsnXmvF@T590>
 <875ybjl1r0.fsf@metaspace.dk>
 <ZAFieW9PZ2LNQYHa@T590>
 <87wn3yfd36.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wn3yfd36.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:27:58AM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Thu, Mar 02, 2023 at 02:28:33PM +0100, Andreas Hindborg wrote:
> >> 
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> 
> >> > On Thu, Mar 02, 2023 at 11:07:15AM +0100, Andreas Hindborg wrote:
> >> >> 
> >> >> Ming Lei <ming.lei@redhat.com> writes:
> >> >> 
> >> >> > On Thu, Mar 2, 2023 at 5:02 PM Ming Lei <ming.lei@redhat.com> wrote:
> >> >> >>
> >> >> >> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> >> >> >> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> >> >> >> > >
> >> >> >>
> >> >> >> ...
> >> >> >>
> >> >> >> > >
> >> >> >> > > I agree about fetching more zones. However, it is no good to fetch up to
> >> >> >> > > a max, since the requested zone report may less than max. I was
> >> >> >> >
> >> >> >> > Short read should always be supported, so the interface may need to
> >> >> >> > return how many zones in single command, please refer to nvme_ns_report_zones().
> >> >> >>
> >> >> >> blk_zone is part of uapi, maybe the short read can be figured out by
> >> >> >> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
> >> >> >> reporting zones.
> >> >> >
> >> >> > oops, we have blk_zone_report data for reporting zones to userspace already,
> >> >> > see blkdev_report_zones_ioctl(), then this way can be re-used for getting zone
> >> >> > report from ublk server too, right?
> >> >> 
> >> >> Yes that would be nice. But I did the report_zone command like a read
> >> >> operation, so we are not currently copying any buffers to user space
> >> >> when issuing the command, we just rely on the iod.
> >> >
> >> > What I meant is to reuse the format of blk_zone_report for returning
> >> > multiple 'blk_zone' info in single command.
> >> >
> >> > The only change is that you need to allocate one bigger kernel buffer
> >> > to hold more 'blk_zone' in single report zone request.
> >> >
> >> >> I think it would be
> >> >> better to use the start_sectors and nr_sectors of the iod instead. Then
> >> >> we don't have to copy the blk_zone_report. What do you think?
> >> >
> >> > For IN parameter of report zone command, you still can reuse
> >> > blk_zone_report:
> >> >
> >> > struct blk_zone_report {
> >> >         __u64           sector;
> >> >         __u32           nr_zones;
> >> >         __u32           flags;
> >> > };
> >> >
> >> > Just by using the 1st two 64b words of iod for holding 'blk_zone_report', and
> >> > keep the iod->addr field not touched.
> >> 
> >> I see. Would you make the first part of `struct ublksrv_io_desc` a union
> >> for this, or would you just cast it at the use site?
> >
> > oops, you still need iod->op_flags for recognizing the io op, so just
> > start_sector and nr_sectors can be used.
> 
> We do not actually need to pass the flags to user space, or back from
> user space to kernel for ublk zone report. They are currently used to
> tell user space if the zone report contains capacity field. We could
> exclude them from the ublk kabi since the zone report will always
> contain capacity? But it might be good to have a flags field or future
> things.
> 
> > However, this way isn't good too, cause UBLK_IO_OP_DRV_IN is just mapped
> > to 'report zone' command in your implementation, what if new pt request
> > is required in future?
> 
> We are currently mapping REQ_OP_* 1:1 to  UBLK_OP_OP_*. If we relax
> this, we can have a UBLK_IO_OP_REPORT_ZONES.

The op takes 8 bits, and enough to cover all normal block layer OPs and
driver specific OPs, so I'd suggest this way, and ublk device
specific OP can be started from 32, prefixed with

	UBLK_IO_OP_DRV_IN				//[32, 96)
or
	UBLK_IO_OP_DRV_OUT				//[96, 160)

such as, report zones can be defined as

	enum {
		__UBLK_IO_OP_DRV_IN_START = 32,
		UBLK_IO_OP_DRV_IN_REPORT_ZONES = __UBLK_IO_OP_DRV_IN_START,
		__UBLK_IO_OP_DRV_IN_END = 96,

		__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
		__UBLK_IO_OP_DRV_OUT_END = 160,
	};

For any DRV OPs, iod header(not include ->addr) and buffer format can be re-defined
as uapi structure.

What do you think of this way?

> 
> >
> > We need to think about how to support ublk pt request in generic way.
> 
> Another option is to allow REQ_OP_DRV_IN to pass a buffer to user space.
> Instead of being similar to a read operation, it could be a combination of
> a read and a write operation.

That might be more flexible, but could add driver & userspace's
complexity, so I'd suggest to try to avoid bidirectional buffer asap,
but we still reserve support for it via UBLK_IO_OP_DRV_IN_OUT*.

Thanks,
Ming

