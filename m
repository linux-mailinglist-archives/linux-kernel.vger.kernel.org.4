Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36749605504
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiJTBbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiJTBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:31:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721E107A97;
        Wed, 19 Oct 2022 18:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A3E4CE244F;
        Thu, 20 Oct 2022 01:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090E1C433C1;
        Thu, 20 Oct 2022 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666229300;
        bh=mD3inEdf2jiFkDkLAVywxo6JgEJGztOJHQE90Gbw1lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhETbkqeYgFejbwTc/We2YjRDwkBNWEKa8jg2zi9TWp8tK75/9dsvBVhehFusrBmp
         xSidrBLVSssEQn3URcmTO399Esr/m7GfwJVUTm+raWaTUVY+2hSO+piUlriMTzzS0m
         J8SNB3bUc4uqoujr4ED5MHSg9DKxE6EwC4jOH49oY6w1Mh5OoSDhzrCLwX2bdysyOG
         q8BuzAEwgURLLlncp//c4BiwhA+LQL6vRK3tn1OXoJhrQ07+/bVwMfpAz/SATfMD8L
         8v7UfBxXOw/GqqQpdq7lBH1MYotGgFUHIsWQh9XIfO6NGez+EfSmvJ+KH0/I3CAr1r
         VMqJ9lXGaZrcQ==
Date:   Wed, 19 Oct 2022 19:28:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dmitrii Tcvetkov <me@demsh.org>
Cc:     Keith Busch <kbusch@fb.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bisected] QEMU guest boot failure since 6.0 on x86_64 host
Message-ID: <Y1CkMS+xbwbvn8My@kbusch-mbp.dhcp.thefacebook.com>
References: <20221020031725.7d01051a@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020031725.7d01051a@xps.demsh.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:17:25AM +0300, Dmitrii Tcvetkov wrote:
> 
> Bisect led me to commit b1a000d3b8ec5  ("block: relax direct io memory
> alignment"). I was unable to resolve revert conflicts when
> tried to revert b1a000d3b8ec5  ("block: relax direct io memory
> alignment") as I lack necessary understanding of block subsystem.

Background info: when your virtual block device's logical block size is
smaller than the host's block device backing it, qemu needs to bounce
unaligned buffers when using direct-io.

Historically for direct-io, the logical block size happened to also be
the memory page offset alignment. QEMU did this the other way around: it
used the memory offset as the block size, and that was not intended:

  https://lore.kernel.org/lkml/32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com/

The kernel patch you bisected to detangled memory alignment from logical
block size, so now older qemu versions have the wrong idea of the
minimum vector size. That is fixed in the qemu repository here:

  https://git.qemu.org/?p=qemu.git;a=commitdiff;h=25474d90aa50bd32e0de395a33d8de42dd6f2aef
> 
> This fails to boot on 6.0+ host:
> # losetup -b 4096 -f image.raw
> # qemu-system-x86_64 -enable-kvm -drive
> file=/dev/loop0,format=raw,cache=none

In the above, your backing storage is 4k, and the default virtual device
block size is 512b, so qemu needs to bounce that, but older versions
might not do that as intended.

It should work if you include logical_block_size=4096 to the -drive
parameters.

> These boot fine on 6.0+ host:
> # losetup -b 4096 -f image.raw
> # qemu-system-x86_64 -enable-kvm -drive
> file=/dev/loop0,format=raw

The above is using cache, which doesn't have any alignment and size
constraints, so works with anything sizes.
 
> # losetup -f image.raw
> # qemu-system-x86_64 -enable-kvm -drive
> file=/dev/loop0,format=raw,cache=none

The above is using a 512b formated backing store to a 512b emulated
drive, so the matching means qemu never needs to bounce.
