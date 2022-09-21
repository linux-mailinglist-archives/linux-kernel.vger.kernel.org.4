Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C85BF985
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiIUIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiIUIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:55 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F045A7754C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:40:45 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D635C000F;
        Wed, 21 Sep 2022 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663749644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+rS/AKkAYbBzzWbOJ5NVDxMpAQb84AdS+LGtfvMNDM=;
        b=DZjZVqe8vEXOSmL6KkF0P90xqGXYCLDnpC7PDHEwfCPFoX0wE7wzqjeISmBAeUyjXIzmQj
        UI5BLLWKxMDSlViDw/Mj7n5mg7mPIgdAkOzGu16Pzwbt6WeDs806Ssjl6gmeF3gvC5ikP3
        cZs0oyYDlcc4+YHKz+0ELfDQNRw/qlhLN+BFc36V3VzItuQG5/Nu4kZRpRTTggB4864QX5
        trO1E4dnG7WllY6Tlpf+yct+hBWHJ8dEKxUl6YWp/cVqtqZR7K2D77YMHRkgxzpsQJm4GO
        MLWAyP7CyBSP1Vf5l8XI13MJltPhtVoIRqlXbPvRzbnSV6/zwRHj+TnB+c3s/g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] mtdchar: add MEMREAD ioctl
Date:   Wed, 21 Sep 2022 10:40:38 +0200
Message-Id: <20220921084038.733213-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629125737.14418-5-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'095bb6e44eb17da2cf95dbde9c83b44664a493f5'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-29 at 12:57:37 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> User-space applications making use of MTD devices via /dev/mtd*
> character devices currently have limited capabilities for reading data:
> 
>   - only deprecated methods of accessing OOB layout information exist,
> 
>   - there is no way to explicitly specify MTD operation mode to use; it
>     is auto-selected based on the MTD file mode (MTD_FILE_MODE_*) set
>     for the character device; in particular, this prevents using
>     MTD_OPS_AUTO_OOB for reads,
> 
>   - all existing user-space interfaces which cause mtd_read() or
>     mtd_read_oob() to be called (via mtdchar_read() and
>     mtdchar_read_oob(), respectively) return success even when those
>     functions return -EUCLEAN or -EBADMSG; this renders user-space
>     applications using these interfaces unaware of any corrected
>     bitflips or uncorrectable ECC errors detected during reads.
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
> Acked-by: Richard Weinberger <richard@nod.at>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
