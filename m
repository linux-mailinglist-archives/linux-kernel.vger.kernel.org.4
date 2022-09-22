Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502F5E6BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiIVThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiIVThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3802610B21B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663875425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rERQeRLk6iWsos2UmkmvbVMjyj1EWySRrEtJrBO4h4Y=;
        b=W1dVw74iaSfLoYmdvnWZQPSr0hJ5HkIOHRrTdA6t1Es2VUa8xGw0PUSOEYzbG3cVtDUx/0
        cGoaJKoKsgesFyPx3CSNuPSdghF0JZsVp0KSqAs9gP2m+d5f6jJZqHNd/5p8dwRKBncU3x
        OQfPQvBdEiHXIfW9mHE1U4SWKX3BoB4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-reG2QWgbPwG9oRG7ndPHMg-1; Thu, 22 Sep 2022 15:37:04 -0400
X-MC-Unique: reG2QWgbPwG9oRG7ndPHMg-1
Received: by mail-qv1-f71.google.com with SMTP id m7-20020a0ce6e7000000b004ad69308f01so4941401qvn.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rERQeRLk6iWsos2UmkmvbVMjyj1EWySRrEtJrBO4h4Y=;
        b=5kEXmaManTRrGqDnKwPQ1FbD/O0GtMO7AZT1jT8NdYP/cIdO2T7vCEiNNdbmcuB6FL
         OyzQlkhkgODJ2hyRnI4YMYt1c6elGfcUcQjNgFb1rdQBe3GptPNMa/ZJOeMqRBV9NxDO
         UFdtOcAcDlrnZYFh9s4Ds6qYCAQoTyAaalHz9GBjm2PTy8a8D5Fb3mkgm/NE4e1h2PwZ
         sxyh/B+xeag9aK9tApJQDzV9RYBxW0OBhI3xnC64aCz8JbOrxkR4fVrbjJ2saq+GN5kH
         ASSfnSQVgOrCI9cqnxjfwf5Dk5hvV8+GyBN5QYzuhYAN0pJ6e/fPdXD09DCE6VNuOG2G
         vZ5w==
X-Gm-Message-State: ACrzQf1WTqtjhcWHaPzqDahrY4eQmI1Eo8yIlwdT9+F+lyX5R2olKJwg
        ZTt/K1gsJHBcHRD7ZWIRL85tR7b315wO15XH7IbjffkmGL1vdk5Ggh43+e0JGWwLF9Llu204e/m
        Vbicz4T52eRve5500AvU2SyM=
X-Received: by 2002:a05:620a:15f2:b0:6ce:dea8:1d6d with SMTP id p18-20020a05620a15f200b006cedea81d6dmr3356161qkm.324.1663875423428;
        Thu, 22 Sep 2022 12:37:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Gh6yqO6EUXrtfv7UsM7htLnKxemapjlfZVl58O6Xzz8jniK66rHh4oKk3Qsil7SKcL3dprA==
X-Received: by 2002:a05:620a:15f2:b0:6ce:dea8:1d6d with SMTP id p18-20020a05620a15f200b006cedea81d6dmr3356136qkm.324.1663875423127;
        Thu, 22 Sep 2022 12:37:03 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a415000b006cbe3be300esm4768662qko.12.2022.09.22.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:37:02 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:37:01 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
        bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
        matias.bjorling@wdc.com
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone
 sizes]
Message-ID: <Yyy5XUUWGkU8B3IP@redhat.com>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com>
 <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21 2022 at  7:55P -0400,
Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:

> On 9/22/22 02:27, Mike Snitzer wrote:
> > On Tue, Sep 20 2022 at  5:11P -0400,
> > Pankaj Raghav <p.raghav@samsung.com> wrote:
> > 
> >> - Background and Motivation:
> >>
> >> The zone storage implementation in Linux, introduced since v4.10, first
> >> targetted SMR drives which have a power of 2 (po2) zone size alignment
> >> requirement. The po2 zone size was further imposed implicitly by the
> >> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
> >> across chunks beyond the specified size, since v3.16 through commit
> >> 762380ad9322 ("block: add notion of a chunk size for request merging").
> >> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
> >> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
> >> to be non-power-of-2").
> >>
> >> NAND, which is the media used in newer zoned storage devices, does not
> >> naturally align to po2. In these devices, zone capacity(cap) is not the
> >> same as the po2 zone size. When the zone cap != zone size, then unmapped
> >> LBAs are introduced to cover the space between the zone cap and zone size.
> >> po2 requirement does not make sense for these type of zone storage devices.
> >> This patch series aims to remove these unmapped LBAs for zoned devices when
> >> zone cap is npo2. This is done by relaxing the po2 zone size constraint
> >> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
> >> == zone size.
> >>
> >> Removing the po2 requirement from zone storage should be possible
> >> now provided that no userspace regression and no performance regressions are
> >> introduced. Stop-gap patches have been already merged into f2fs-tools to
> >> proactively not allow npo2 zone sizes until proper support is added [1].
> >>
> >> There were two efforts previously to add support to npo2 devices: 1) via
> >> device level emulation [2] but that was rejected with a final conclusion
> >> to add support for non po2 zoned device in the complete stack[3] 2)
> >> adding support to the complete stack by removing the constraint in the
> >> block layer and NVMe layer with support to btrfs, zonefs, etc which was
> >> rejected with a conclusion to add a dm target for FS support [0]
> >> to reduce the regression impact.
> >>
> >> This series adds support to npo2 zoned devices in the block and nvme
> >> layer and a new **dm target** is added: dm-po2zoned-target. This new
> >> target will be initially used for filesystems such as btrfs and
> >> f2fs until native npo2 zone support is added.
> > 
> > As this patchset nears the point of being "ready for merge" and DM's
> > "zoned" oriented targets are multiplying, I need to understand: where
> > are we collectively going?  How long are we expecting to support the
> > "stop-gap zoned storage" layers we've constructed?
> > 
> > I know https://zonedstorage.io/docs/introduction exists... but it
> > _seems_ stale given the emergence of ZNS and new permutations of zoned
> > hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
> > still left wanting (e.g. "bring it all home for me!")...
> > 
> > Damien, as the most "zoned storage" oriented engineer I know, can you
> > please kick things off by shedding light on where Linux is now, and
> > where it's going, for "zoned storage"?
> 
> Let me first start with what we have seen so far with deployments in the
> field.

<snip>

Thanks for all your insights on zoned storage, very appreciated!

> > In addition, it was my understanding that WDC had yet another zoned DM
> > target called "dm-zap" that is for ZNS based devices... It's all a bit
> > messy in my head (that's on me for not keeping up, but I think we need
> > a recap!)
> 
> Since the ZNS specification does not define conventional zones, dm-zoned
> cannot be used as a standalone DM target (read: single block device) with
> NVMe zoned block devices. Furthermore, due to its block mapping scheme,
> dm-zoned does not support devices with zones that have a capacity lower
> than the zone size. So ZNS is really a big *no* for dm-zoned. dm-zap is a
> prototype and in a nutshell is the equivalent of dm-zoned for ZNS. dm-zap
> can deal with the smaller zone capacity and does not require conventional
> zones. We are not trying to push for dm-zap to be merged for now as we are
> still evaluating its potential use cases. We also have a different but
> functionally equivalent approach implemented as a block device driver that
> we are evaluating internally.
> 
> Given the above mentioned usage pattern we have seen so far for zoned
> storage, it is not yet clear if something like dm-zap for ZNS is needed
> beside some niche use cases.

OK, good to know.  I do think dm-zoned should be trained to _not_
allow use with ZNS NVMe devices (maybe that is in place and I just
missed it?).  Because there is some confusion with at least one
customer that is asserting dm-zoned is somehow enabling them to use
ZNS NVMe devices!

Maybe they somehow don't _need_ conventional zones (writes are handled
by some other layer? and dm-zoned access is confined to read only)!?
And might they also be using ZNS NVMe devices to do _not_ have a
zone capacity lower than the zone size?

Or maybe they are mistaken and we should ask more specific questions
of them?

> > So please help me, and others, become more informed as quickly as
> > possible! ;)
> 
> I hope the above helps. If you want me to develop further any of the
> points above, feel free to let me know.

You've been extremely helpful, thanks!

