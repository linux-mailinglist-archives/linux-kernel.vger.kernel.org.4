Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015C6A8355
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCBNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCBNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072B38B66
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677763017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HT42klSl4QJ/KZdsdNPkQZTqOKOm4eLpYdcPCrpQR8w=;
        b=hjR4wn6c0wKr4aud27pYzp8d/vRd34fQt3IVb18qEY9UqxLNiWjFZNPadRBUZB7JseWmd9
        j1THgVuHDd8BxTfhKccqfr/5H3KSXvoKwRbHM/4nL4rNXBf0030KjVXaFMG6IvFsg77vlw
        59y4McGhm3H4eXmrgUyGH1sdAzvR3Aw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-IyWV56PeO_uom7bKzYLEtQ-1; Thu, 02 Mar 2023 08:16:51 -0500
X-MC-Unique: IyWV56PeO_uom7bKzYLEtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62920185A78B;
        Thu,  2 Mar 2023 13:16:51 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F28B72166B26;
        Thu,  2 Mar 2023 13:16:44 +0000 (UTC)
Date:   Thu, 2 Mar 2023 21:16:38 +0800
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
Message-ID: <ZAChttVoCHsnXmvF@T590>
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590>
 <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
 <87h6v3l9up.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6v3l9up.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:07:15AM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Thu, Mar 2, 2023 at 5:02 PM Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> >> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> >> > >
> >>
> >> ...
> >>
> >> > >
> >> > > I agree about fetching more zones. However, it is no good to fetch up to
> >> > > a max, since the requested zone report may less than max. I was
> >> >
> >> > Short read should always be supported, so the interface may need to
> >> > return how many zones in single command, please refer to nvme_ns_report_zones().
> >>
> >> blk_zone is part of uapi, maybe the short read can be figured out by
> >> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
> >> reporting zones.
> >
> > oops, we have blk_zone_report data for reporting zones to userspace already,
> > see blkdev_report_zones_ioctl(), then this way can be re-used for getting zone
> > report from ublk server too, right?
> 
> Yes that would be nice. But I did the report_zone command like a read
> operation, so we are not currently copying any buffers to user space
> when issuing the command, we just rely on the iod.

What I meant is to reuse the format of blk_zone_report for returning
multiple 'blk_zone' info in single command.

The only change is that you need to allocate one bigger kernel buffer
to hold more 'blk_zone' in single report zone request.

> I think it would be
> better to use the start_sectors and nr_sectors of the iod instead. Then
> we don't have to copy the blk_zone_report. What do you think?

For IN parameter of report zone command, you still can reuse
blk_zone_report:

struct blk_zone_report {
        __u64           sector;
        __u32           nr_zones;
        __u32           flags;
};

Just by using the 1st two 64b words of iod for holding 'blk_zone_report', and
keep the iod->addr field not touched.


[1] https://lore.kernel.org/linux-block/20230301140611.163055-1-ming.lei@redhat.com/T/#md36358552d45a7d563940632d4c779a99f72916d

Thanks,
Ming

