Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D235BED60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiITTMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Sep 2022 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:12:01 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5352732EE6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:11:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2ACD563BBD4B;
        Tue, 20 Sep 2022 21:11:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Sucjpe0Cfkhy; Tue, 20 Sep 2022 21:11:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 664E763BBD41;
        Tue, 20 Sep 2022 21:11:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8wHuVCEmh8N2; Tue, 20 Sep 2022 21:11:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3BC2C63BBD38;
        Tue, 20 Sep 2022 21:11:54 +0200 (CEST)
Date:   Tue, 20 Sep 2022 21:11:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <955252833.244763.1663701114159.JavaMail.zimbra@nod.at>
In-Reply-To: <20220629125737.14418-5-kernel@kempniu.pl>
References: <20220629125737.14418-1-kernel@kempniu.pl> <20220629125737.14418-5-kernel@kempniu.pl>
Subject: Re: [PATCH v4 4/4] mtdchar: add MEMREAD ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdchar: add MEMREAD ioctl
Thread-Index: x3jbmUpbWewkvCtv3NAUFhw8zSthgg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Michał Kępień" <kernel@kempniu.pl>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> CC: "Boris Brezillon" <boris.brezillon@collabora.com>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 29. Juni 2022 14:57:37
> Betreff: [PATCH v4 4/4] mtdchar: add MEMREAD ioctl

> User-space applications making use of MTD devices via /dev/mtd*
> character devices currently have limited capabilities for reading data:
> 
>  - only deprecated methods of accessing OOB layout information exist,
> 
>  - there is no way to explicitly specify MTD operation mode to use; it
>    is auto-selected based on the MTD file mode (MTD_FILE_MODE_*) set
>    for the character device; in particular, this prevents using
>    MTD_OPS_AUTO_OOB for reads,
> 
>  - all existing user-space interfaces which cause mtd_read() or
>    mtd_read_oob() to be called (via mtdchar_read() and
>    mtdchar_read_oob(), respectively) return success even when those
>    functions return -EUCLEAN or -EBADMSG; this renders user-space
>    applications using these interfaces unaware of any corrected
>    bitflips or uncorrectable ECC errors detected during reads.
> 
> Note that the existing MEMWRITE ioctl allows the MTD operation mode to
> be explicitly set, allowing user-space applications to write page data
> and OOB data without requiring them to know anything about the OOB
> layout of the MTD device they are writing to (MTD_OPS_AUTO_OOB).  Also,
> the MEMWRITE ioctl does not mangle the return value of mtd_write_oob().
> 
> Add a new ioctl, MEMREAD, which addresses the above issues.  It is
> intended to be a read-side counterpart of the existing MEMWRITE ioctl.
> Similarly to the latter, the read operation is performed in a loop which
> processes at most mtd->erasesize bytes in each iteration.  This is done
> to prevent unbounded memory allocations caused by calling kmalloc() with
> the 'size' argument taken directly from the struct mtd_read_req provided
> by user space.  However, the new ioctl is implemented so that the values
> it returns match those that would have been returned if just a single
> mtd_read_oob() call was issued to handle the entire read operation in
> one go.
> 
> Note that while just returning -EUCLEAN or -EBADMSG to user space would
> already be a valid and useful indication of the ECC algorithm detecting
> errors during a read operation, that signal would not be granular enough
> to cover all use cases.  For example, knowing the maximum number of
> bitflips detected in a single ECC step during a read operation performed
> on a given page may be useful when dealing with an MTD partition whose
> ECC layout varies across pages (e.g. a partition consisting of a
> bootloader area using a "custom" ECC layout followed by data pages using
> a "standard" ECC layout).  To address that, include ECC statistics in
> the structure returned to user space by the new MEMREAD ioctl.
> 
> Link: https://www.infradead.org/pipermail/linux-mtd/2016-April/067085.html
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> ---
> drivers/mtd/mtdchar.c      | 139 +++++++++++++++++++++++++++++++++++++
> include/uapi/mtd/mtd-abi.h |  64 +++++++++++++++--
> 2 files changed, 198 insertions(+), 5 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
