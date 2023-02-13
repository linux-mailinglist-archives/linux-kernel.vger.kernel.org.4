Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AEF695133
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBMT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBMT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:59:06 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 11:59:04 PST
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10A2726;
        Mon, 13 Feb 2023 11:59:04 -0800 (PST)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 725011E131;
        Mon, 13 Feb 2023 14:40:10 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 57E09A83C9; Mon, 13 Feb 2023 14:40:09 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25578.37401.314298.238192@quad.stoffel.home>
Date:   Mon, 13 Feb 2023 14:40:09 -0500
From:   "John Stoffel" <john@stoffel.org>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     device-mapper development <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID4 with no striping mode request
In-Reply-To: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_PASS,T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kyle" == Kyle Sanderson <kyle.leet@gmail.com> writes:

> hi DM and Linux-RAID,
> There have been multiple proprietary solutions (some nearly 20 years
> old now) with a number of (userspace) bugs that are becoming untenable
> for me as an end user. Basically how they work is a closed MD module
> (typically administered through DM) that uses RAID4 for a dedicated
> parity disk across multiple other disks.

You need to explain what you want in *much* beter detail.  Give simple
concrete examples.  From the sound of it, you want RAID6 but with
RAID4 dedicated Parity so you can spin down some of the data disks in
the array?  But if need be, spin up idle disks to recover data if you
lose an active disk?  

Really hard to understand what exactly you're looking for here.


> As there is no striping, the maximum size of the protected data is the
> size of the parity disk (so a set of 4+8+12+16 disks can be protected
> by a single dedicated 16 disk).When a block is written on any disk,
> the parity bit is read from the parity disk again, and updated
> depending on the existing + new bit value (so writing disk + parity
> disk spun up). Additionally, if enough disks are already spun up, the
> parity information can be recalculated from all of the spinning disks,
> resulting in a single write to the parity disk (without a read on the
> parity, doubling throughput). Finally any of the data disks can be
> moved around within the array without impacting parity as the layout
> has not changed. I don't necessarily need all of these features, just
> the ability to remove a disk and still access the data that was on
> there by spinning up every other disk until the rebuild is complete is
> important.

> The benefit of this can be the data disks are all zoned, and you can
> have a fast parity disk and still maintain excellent performance in
> the array (limited only by the speed of the disk in question +
> parity). Additionally, should 2 disks fail, you've either lost the
> parity and data disk, or 2 data disks with the parity and other disks
> not lost.

> I was reading through the DM and MD code and it looks like everything
> may already be there to do this, just needs (significant) stubs to be
> added to support this mode (or new code). Snapraid is a friendly (and
> respectable) implementation of this. Unraid and Synology SHR compete
> in this space, as well as other NAS and enterprise SAN providers.

> Kyle.
