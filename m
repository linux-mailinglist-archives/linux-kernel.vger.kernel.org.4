Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F65C0541
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIUR1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIUR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF504A0304
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663781255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=;
        b=dOAXBHm6ddPeJmmAGoAmJ6cH4NTdicxZAT3JO/SQEgfGd6niR1fd1J+j9bszT3RSxkFFuk
        SXArexmOllQEd24zhicY2L+pnxARRlyk/Ca+qmEdOPG2xmGOnZ2htXNYkw8UBcQNW7BEzM
        0YumOWod5qxrCYUAMeGQyTYWQV1bw5c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-ivRmQbrvMrKIcG-URoJzVQ-1; Wed, 21 Sep 2022 13:27:34 -0400
X-MC-Unique: ivRmQbrvMrKIcG-URoJzVQ-1
Received: by mail-qk1-f198.google.com with SMTP id az15-20020a05620a170f00b006cece4cd0beso4741808qkb.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jf1FYXrDVaqqC4NbZ8fFAHL8bcgUOrwJH0z7ee3/534=;
        b=OD7blOc7WTevUjVlYCEThQAyTVP4lXX/FuYRDaRB6jIkmE3VK8zdMx+1DhtC0RP3C/
         43z5c4jaDaWxyGAoRRLUR5wd2+4CvnhFYXUr2zuhnKxaWWcHLuX0RAsb6HdbijA9Ique
         BO+w8JNG0yz78Z4IFVj2udQ4IlVZPMXB5gkZKyg0LxBRdkLH8mcAeFDR0IDc8gRH1Jt1
         qhNb0ZCyXmX82FeExYCsKuM2MTKpGEh9d4TUAHFmn2kYhIsUP0RYgSESZDHGtEDy8B0e
         sXRWM2kZhgOrq/1rdAwGnTo2Jo4SUo5W3xGqP20UzY1ST38IzXj+j4qz40c2lks+YsgX
         BZ0w==
X-Gm-Message-State: ACrzQf06XvZOfMmrmXRD2kGAlrx1rGjg1hUS+HiOIqFb8JOFWIhMcCCz
        0tVo51QUrDUDv9CkkeWI8jb/bBd1zAW+l6q4qdK4yuy9ZVFztObOQPZCR1bl2oa0OsCliAnFnfe
        99LbS3MNfnUMZwi/CSGHg1o4=
X-Received: by 2002:a05:622a:414:b0:35c:f297:ebfc with SMTP id n20-20020a05622a041400b0035cf297ebfcmr10981944qtx.420.1663781254261;
        Wed, 21 Sep 2022 10:27:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6z1zbB3AmadTPASo43OhmHFT6jpU/kArRwI7nXi7rFyLGyH8LCRodE1M4MYgySQ0l8v7sRqg==
X-Received: by 2002:a05:622a:414:b0:35c:f297:ebfc with SMTP id n20-20020a05622a041400b0035cf297ebfcmr10981905qtx.420.1663781253957;
        Wed, 21 Sep 2022 10:27:33 -0700 (PDT)
Received: from localhost ([217.138.198.196])
        by smtp.gmail.com with ESMTPSA id w23-20020a05620a0e9700b006cbdc9f178esm2196842qkm.25.2022.09.21.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:27:33 -0700 (PDT)
Date:   Wed, 21 Sep 2022 13:27:32 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     damien.lemoal@opensource.wdc.com,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
        bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
        matias.bjorling@wdc.com
Subject: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with  non-power-of-2 zone
 sizes]
Message-ID: <YytJhEywBhqcr7MX@redhat.com>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20 2022 at  5:11P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> - Background and Motivation:
> 
> The zone storage implementation in Linux, introduced since v4.10, first
> targetted SMR drives which have a power of 2 (po2) zone size alignment
> requirement. The po2 zone size was further imposed implicitly by the
> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
> across chunks beyond the specified size, since v3.16 through commit
> 762380ad9322 ("block: add notion of a chunk size for request merging").
> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
> to be non-power-of-2").
> 
> NAND, which is the media used in newer zoned storage devices, does not
> naturally align to po2. In these devices, zone capacity(cap) is not the
> same as the po2 zone size. When the zone cap != zone size, then unmapped
> LBAs are introduced to cover the space between the zone cap and zone size.
> po2 requirement does not make sense for these type of zone storage devices.
> This patch series aims to remove these unmapped LBAs for zoned devices when
> zone cap is npo2. This is done by relaxing the po2 zone size constraint
> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
> == zone size.
> 
> Removing the po2 requirement from zone storage should be possible
> now provided that no userspace regression and no performance regressions are
> introduced. Stop-gap patches have been already merged into f2fs-tools to
> proactively not allow npo2 zone sizes until proper support is added [1].
> 
> There were two efforts previously to add support to npo2 devices: 1) via
> device level emulation [2] but that was rejected with a final conclusion
> to add support for non po2 zoned device in the complete stack[3] 2)
> adding support to the complete stack by removing the constraint in the
> block layer and NVMe layer with support to btrfs, zonefs, etc which was
> rejected with a conclusion to add a dm target for FS support [0]
> to reduce the regression impact.
> 
> This series adds support to npo2 zoned devices in the block and nvme
> layer and a new **dm target** is added: dm-po2zoned-target. This new
> target will be initially used for filesystems such as btrfs and
> f2fs until native npo2 zone support is added.

As this patchset nears the point of being "ready for merge" and DM's
"zoned" oriented targets are multiplying, I need to understand: where
are we collectively going?  How long are we expecting to support the
"stop-gap zoned storage" layers we've constructed?

I know https://zonedstorage.io/docs/introduction exists... but it
_seems_ stale given the emergence of ZNS and new permutations of zoned
hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
still left wanting (e.g. "bring it all home for me!")...

Damien, as the most "zoned storage" oriented engineer I know, can you
please kick things off by shedding light on where Linux is now, and
where it's going, for "zoned storage"?

To give some additional context to help me when you answer: I'm left
wondering what, if any, role dm-zoned has to play moving forward given
ZNS is "the future" (and yeah "the future" is now but...)?  E.g.: Does
it make sense to stack dm-zoned ontop of dm-po2zoned!?

Yet more context: When I'm asked to add full-blown support for
dm-zoned to RHEL my gut is "please no, why!?".  And if we really
should add dm-zoned is dm-po2zoned now also a requirement (to support
non-power-of-2 ZNS devices in our never-ending engineering of "zoned
storage" compatibility stop-gaps)?

In addition, it was my understanding that WDC had yet another zoned DM
target called "dm-zap" that is for ZNS based devices... It's all a bit
messy in my head (that's on me for not keeping up, but I think we need
a recap!)

So please help me, and others, become more informed as quickly as
possible! ;)

Thanks,
Mike

ps. I'm asking all this in the open on various Linux mailing lists
because it doesn't seem right to request a concall to inform only
me... I think others may need similar "zoned storage" help.

