Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D49681AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjA3Ty0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbjA3TyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:54:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16625E09
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675108403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S7NbY3xyyAOulwRi5WVYPym1JmT5SXp4nTm5xbjtnWM=;
        b=CESgUe2Unkuoao5WKlJlLVVFKowlmpES5dDcD7H3XraWpHyTs4AiyDpWgBJjzGejwwP3ZI
        uFyzYV5Mr3MLGKPNDk5ISfG3XX3b17oUu4EgUTQOPnrESMz5d3dINNQbVlPITMd9NkWOCT
        TFLRQ8kTz9Jod7wmcqGMR2g+ZVn+zJk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-199-RfBJ8cqSOyuxuMxqSkuQsw-1; Mon, 30 Jan 2023 14:53:19 -0500
X-MC-Unique: RfBJ8cqSOyuxuMxqSkuQsw-1
Received: by mail-qk1-f200.google.com with SMTP id bm30-20020a05620a199e00b007090f3c5ec0so7751610qkb.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7NbY3xyyAOulwRi5WVYPym1JmT5SXp4nTm5xbjtnWM=;
        b=3BWEt31b5STiTcl/LoKM/E85577NkXfEjl3S/pIZfRrlvEl+5gs1BDCpv8LIIqaOWm
         jiJn7lrz0ZGVLShOWS4HnNNmy46Nz8SDiIEv4dQZIDEJ23RXCw1XOtbOYENoTFO8usoa
         md4nBHgrEUq/+uofbELNd+dYuQLg2tnqLKkFaSGPycXMRdTzr8p17PyblO0ick8locXg
         V7ODuYQTk2JBoh4itNOrHtLLjDsVk2XPaNUqxV4CEh7CyXNWrVPAzvajs1+ovI70thMV
         X/qvj4SyUi2UMltqMbYTwMz50wJVPEuyIOUbvmq4lh1/b6oVz9lSwTTVVBNDJi66f1it
         sNiA==
X-Gm-Message-State: AFqh2kpUW/16n52oqjoDIR3ZxANNO+plYaUJQFbnG1KoKMv2KV6n8VSI
        GXMn2c1nWJkMG2TPms3Lz9x7HYe7qgw+fsxyrtjUjP4mX7MlZTgtxQdQRKeMKXOFQdHxg9YzNhu
        L2/lf8p7WchcTzdalQRm2wA4=
X-Received: by 2002:ac8:692:0:b0:3a7:ef31:a07b with SMTP id f18-20020ac80692000000b003a7ef31a07bmr62338330qth.11.1675108398610;
        Mon, 30 Jan 2023 11:53:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVb4ZUbZzSFK5b9AouGdgOVTLQ3lTs2XxhN17i1kks7idYU03AzNTdy1vXAFzMSW8FLBdybg==
X-Received: by 2002:ac8:692:0:b0:3a7:ef31:a07b with SMTP id f18-20020ac80692000000b003a7ef31a07bmr62338316qth.11.1675108398341;
        Mon, 30 Jan 2023 11:53:18 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a27c600b007049f19c736sm8632208qkp.7.2023.01.30.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:53:17 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:53:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the device-mapper tree
Message-ID: <Y9ggLAqnncDMDX+q@redhat.com>
References: <20230130124143.210b5149@canb.auug.org.au>
 <310efbe3-fa98-6726-4010-e7137b761647@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <310efbe3-fa98-6726-4010-e7137b761647@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29 2023 at  8:56P -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 1/29/23 6:41 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commits are also in the block tree as different commits
> > (but the same patches):
> > 
> >   08a39c820686 ("blk-iocost: avoid 64-bit division in ioc_timer_fn")
> >   11fd02522aae ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
> >   204a9e1eeb4b ("blk-iocost: don't allow to configure bio based device")
> >   2192a93eb4ac ("ps3vram: remove bio splitting")
> >   3187f22498f6 ("drbd: remove unnecessary assignment in vli_encode_bits")
> >   346122e09011 ("block, bfq: retrieve independent access ranges from request queue")
> >   38d6577f1e01 ("drbd: fix DRBD_VOLUME_MAX 65535 -> 65534")
> >   3b1c494c4317 ("block: add a new helper bdev_{is_zone_start, offset_from_zone_start}")
> >   3bf6e7ac9a43 ("drbd: remove macros using require_context")
> >   419363fec82a ("block: add a BUILD_BUG_ON() for adding more bio flags than we have space")
> >   4e952a32301a ("blk-iocost: fix divide by 0 error in calc_lcoefs()")
> >   51ec2387623a ("block, bfq: split sync bfq_queues on a per-actuator basis")
> >   55ee20573bd6 ("drbd: make limits unsigned")
> >   56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
> >   5d5ce3a05940 ("block: ublk: fix doc build warning")
> >   612307b9e29b ("block: make BLK_DEF_MAX_SECTORS unsigned")
> >   615b51f2a7ec ("block, bfq: forbid stable merging of queues associated with dif
> > ferent actuators")
> >   620183fd3cda ("ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT")
> >   6b5bcbd01de8 ("drbd: split off drbd_config into separate file")
> >   6e45a73ca9d6 ("drbd: adjust drbd_limits license header")
> >   6faa01c8bf3b ("ublk_drv: don't probe partitions if the ubq daemon isn't truste
> > d")
> >   707107e3c830 ("drbd: drbd_insert_interval(): Clarify comment")
> >   7a5841d1701d ("block, bfq: balance I/O injection among underutilized actuators
> > ")
> >   7a69a19ae640 ("block, bfq: inject I/O to underutilized actuators")
> >   7b6a2c89052b ("blk-iocost: check return value of match_u64()")
> >   7b810b50390b ("blk-iocost: read params inside lock in sysfs apis")
> >   7f0e2433880b ("block: save user max_sectors limit")
> >   803e2ec47623 ("block: introduce bdev_zone_no helper")
> >   8564135fe5b0 ("block: don't allow multiple bios for IOCB_NOWAIT issue")
> >   934f178446b1 ("block: extend bio-cache for non-polled requests")
> >   93cfbaba481c ("drbd: split off drbd_buildtag into separate file")
> >   961ccca54ad5 ("ublk_drv: add module parameter of ublks_max for limiting max al
> > lowed ublk dev")
> >   988136a30715 ("nvme: set REQ_ALLOC_CACHE for uring-passthru request")
> >   9d1d75e23110 ("drbd: drop API_VERSION define")
> >   a2aea8f56f9e ("s390/dcssblk:: don't call bio_split_to_limits")
> >   a5d140c503b6 ("ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
> > ")
> >   aa70bcb25683 ("drbd: interval tree: make removing an "empty" interval a no-op"
> > )
> >   abc42d89596a ("MAINTAINERS: add drbd headers")
> >   ad5572498be1 ("blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_refre
> > sh_params()")
> >   ba0b61d03ce3 ("block: treat poll queue enter similarly to timeouts")
> >   d5ff0182856b ("block, bfq: move io_cq-persistent bfqq data into a dedicated st
> > ruct")
> >   d66a012deb65 ("ublk_drv: remove nr_aborted_queues from ublk_device")
> >   ef0e0afd782e ("block: remove superfluous check for request queue in bdev_is_zo
> > ned()")
> >   fd44c9c683bc ("block, bfq: split also async bfq_queues on a per-actuator basis
> > ")
> > 
> > It looks like the block tree was rebased ...
> 
> It was, to avoid a conflict and second patch issue. Mike, let me know if
> rebasing the dm tree is a concern, then we roll back and deal with the
> pain instead...

No problem, I rebased DM.

