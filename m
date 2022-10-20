Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E1605E28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJTKs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTKsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:48:25 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5A11DC821;
        Thu, 20 Oct 2022 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1666262900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETkbRpvmDPnr18kYQQ0G/Rg2H1mJOLWgSuqFKhzOm3E=;
        b=OS63sYgbwTHI9M9z/xNpLVHTrX2fEs16wlGEYH39W36mpTaNOzyAN9XAOT1sxTYt8JjebZ
        Lt0QvG5j2WDJpa0k8efxT+MuL5LlC/RFdz7KLu0zKeryjViP6+XE3nmXdxvLUCA6tmlOEE
        NY9wGYvSTS71L9P9VZYYP7LphO8PsWHtG/Wx0Ye9+XPGnbYWo+BwFFpl6hv4i5aEPXpFSD
        94B/PC8s3lVPZ94o3gQ95mWPDJc7rmNkPUyc65HOXkcxohpZjpSoHGgWg0xJr0zgCDUmMq
        fkG2q2krPx/LTZuw6dwjCGILepf54jGRh1CuRMJQy6QNBrubk1TA1SxnZ7N6Ow==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id 4bb7512b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Thu, 20 Oct 2022 10:48:20 +0000 (UTC)
Date:   Thu, 20 Oct 2022 13:48:18 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bisected] QEMU guest boot failure since 6.0 on x86_64 host
Message-ID: <20221020134818.30961090@xps.demsh.org>
In-Reply-To: <Y1CkMS+xbwbvn8My@kbusch-mbp.dhcp.thefacebook.com>
References: <20221020031725.7d01051a@xps.demsh.org>
        <Y1CkMS+xbwbvn8My@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 19:28:17 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Thu, Oct 20, 2022 at 03:17:25AM +0300, Dmitrii Tcvetkov wrote:
> > 
> > Bisect led me to commit b1a000d3b8ec5  ("block: relax direct io
> > memory alignment"). I was unable to resolve revert conflicts when
> > tried to revert b1a000d3b8ec5  ("block: relax direct io memory
> > alignment") as I lack necessary understanding of block subsystem.
> 
> Background info: when your virtual block device's logical block size
> is smaller than the host's block device backing it, qemu needs to
> bounce unaligned buffers when using direct-io.
> 
> Historically for direct-io, the logical block size happened to also be
> the memory page offset alignment. QEMU did this the other way around:
> it used the memory offset as the block size, and that was not
> intended:
> 
>   https://lore.kernel.org/lkml/32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com/
> 
> The kernel patch you bisected to detangled memory alignment from
> logical block size, so now older qemu versions have the wrong idea of
> the minimum vector size. That is fixed in the qemu repository here:
> 
>   https://git.qemu.org/?p=qemu.git;a=commitdiff;h=25474d90aa50bd32e0de395a33d8de42dd6f2aef
> > 
> > This fails to boot on 6.0+ host:
> > # losetup -b 4096 -f image.raw
> > # qemu-system-x86_64 -enable-kvm -drive
> > file=/dev/loop0,format=raw,cache=none
> 
> In the above, your backing storage is 4k, and the default virtual
> device block size is 512b, so qemu needs to bounce that, but older
> versions might not do that as intended.
> 
> It should work if you include logical_block_size=4096 to the -drive
> parameters.
> 
> > These boot fine on 6.0+ host:
> > # losetup -b 4096 -f image.raw
> > # qemu-system-x86_64 -enable-kvm -drive
> > file=/dev/loop0,format=raw
> 
> The above is using cache, which doesn't have any alignment and size
> constraints, so works with anything sizes.
>  
> > # losetup -f image.raw
> > # qemu-system-x86_64 -enable-kvm -drive
> > file=/dev/loop0,format=raw,cache=none
> 
> The above is using a 512b formated backing store to a 512b emulated
> drive, so the matching means qemu never needs to bounce.

Thanks! Specifying logical_block_size=4096 indeed helps, guest still
doesn't boot but because it has partition table with an assumption of 512
sectors. After reinstall with logical_block_size=4096 specified it
boots.
