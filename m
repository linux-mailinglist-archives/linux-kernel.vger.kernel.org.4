Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54696ACA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCFR3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:29:12 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E8765450
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kNR1XWqWe/gwQrHDPGMn5kQRc4ac1WGeFOaw4SxysIU=; b=HJfqXNrGEDYume1qHMSAp1iUws
        BB/yQa+sSg2jbKuaVcZnLg2Jir0rJBUgSsIEt6NKByxXHkbpYOzUT6w5moGIAPUwj6Iz3ArjVtrH5
        65h/UWuIsqGId6Q+gETdCkfzUBLdMsQ3I69iQmyYfguUMcrmn7aB/Y39X8y+57IYRBQ/xmMQrIQW9
        jP9dvaspIhUJkScdhrwNvZYTVSfswh/Ux/6H56cFrlQkqm3vPqazalcaciKpDU7AOAq75LFVU5Y4L
        mGYnfBTlAd9N+g36XEXLOjBVVddtl4gJRo3LyOo5lKKElFy5Gh7HosMMTlBlbD3nAYdCPcPQ1uPw+
        XJRUN2DQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pZEcx-00ENYk-0F;
        Mon, 06 Mar 2023 17:27:59 +0000
Date:   Mon, 6 Mar 2023 17:27:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/sysv: Don't round down address for
 kunmap_flush_on_unmap()
Message-ID: <20230306172759.GB3390869@ZenIV>
References: <20230306125150.12166-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306125150.12166-1-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 01:51:50PM +0100, Fabio M. De Francesco wrote:
> The kernel virtual address passed to kunmap_flush_on_unmap() has no more
> any need to be rounded down.
> 
> Therefore, delete the rounding down of "page_addr" when passed to
> kunmap_local() in dir_put_page().
> 
> Don't backport without commit 88d7b12068b9 ("highmem: round down the
> address passed to kunmap_flush_on_unmap()").

Applied (#work.misc).  FWIW, I've rebased the ext2 series to -rc1 (and
realized what got Jan confused about ext2_rename() changes).

Re minixfs: it's actually very close to sysv, so much that at one point
I considered merging them - making minixfs one of sysvfs flavours.

Think of it as v7 filesystem with the simpler improvements copied from
FFS.  Cylinder groups and variable-sized directory entries - too
complex for Minix purposes.  Lifting the name length limit from 14 to
30 - sure, why not?  32bit block numbers - eventually made it,
so did 32bit inode numbers (in v3).  

The main advance compared to v7 is the use of bitmaps for block
and inode allocation.  Unlike FFS it's all in one lump, but at least
it's not the "free block list".

For directory contents handling it doesn't matter at all - there minixfs
is really just another sysvfs variant.  Directory is stored the same
way as a regular file would've been, the data in it is an array of
fixed-sized entries (16, 32 or 64 bytes, depending upon the filesystem
version), each consisting of inode number (2 or 4 bytes) + array of
characters representing the name; name shorter than the longest possible
are NUL-terminated.

Anyway, I've slapped together a counterpart of your sysv series,
see #work.minix
