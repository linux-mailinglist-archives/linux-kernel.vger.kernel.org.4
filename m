Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8566860E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBAHqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjBAHq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:46:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB05356A;
        Tue, 31 Jan 2023 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ZX9vjIxwOHrfewyJfr8xGs3SYgx2A9oZbI6nWkz+6I=; b=JWMbAFRJy7LzBo/apgeIlCm+gl
        KhgodpB9T0dyedZZ2VhQE4eolmPlCwIzVItsT0dwI3nVtLah0U5U4CJiRP3EbJ/n1o6sDkZkVel9C
        lXZc3zmAZM/wYEHQ/jAl4tK7F8eLqlvQcyqCOMAfxJ2VHhSdCRRAkbObFuFm43owZA/tXC4omewnf
        qG9WyM32ibnqS0aXZRj3UAeYyEa3tC+z/bK9Ik/5wZ09ZIt/klT5LmdGGMUSon9csSJ6KD6jv9j82
        2xY1miqNQQ8huYuSy+CIE5io0N0eYsVeQQl6cl97ysMoAUbt4dNSHFx20zHc3frFUM2dTaU25OIAf
        1CQyVAVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pN7oZ-00Ag07-95; Wed, 01 Feb 2023 07:45:55 +0000
Date:   Tue, 31 Jan 2023 23:45:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9oYs+KycfdFYlu2@infradead.org>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
 <Y9gZAJGgdjFtsm9I@itl-email>
 <Y9jW73uAtE3HdCou@infradead.org>
 <Y9lBlKD3U/jMug9j@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9lBlKD3U/jMug9j@itl-email>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:27:59AM -0500, Demi Marie Obenour wrote:
> While it is easy to provide userspace with an FD to any struct file, it
> is *not* easy to obtain a struct file for a given struct block_device.
> I could have had device-mapper implement everything itself, but that
> would have duplicated a large amount of code already in the block layer.
> Instead, I decided to refactor the block layer to provide a function
> that does exactly what was needed.  The result was this patch.  In the
> future, I would like to add an ioctl for /dev/loop-control that creates
> a loop device and returns a file descriptor to the loop device.  I could
> also see iSCSI supporting this, with the socket file descriptor being
> passed in from userspace.

And it is somewhat intentional that you can't.  Block device inodes
have interesting life times and are never directly exposed to userspace
at all.  They are internal, and only f_mapping of a file system inode
delegates to them or I/O.  Your patch now magically exposes them to
userspace.  And it then bypasses all pathname and inode permission
based access checks and auditing.  So we can't just do it.

> blkdev_do_open() does not solve any problem for me at this time.
> Instead, it represents the code shared by blkdev_get_by_dev() and
> blkdev_get_file().  I decided to export it because it could be of
> independent use to others.  In particular, it could potentially
> simplify disk_scan_partitions() in block/genhd.c, pkt_new_dev() in
> pktcdvd, backing_dev_store() in zram, and f2fs_scan_devices() in f2fs.

All thse need to actually open the underlying device as they do I/O.
Doing I/O without opening the device is a no-go.
