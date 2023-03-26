Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34346C98D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCZXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:39:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0855248
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GxavDADegA8D8D4cqFi6Pgh//L0JzHyL/uT8PMbCBW8=; b=PhrOnzbWxGpMu8JvonvDeAb52v
        tin7Vc7DTDlvxZUpODoB9x0UZ9kVpLNDJZxqHtC3NN6wwD1rKh4dFQ36avx7iutUeBPLxKIgvq0wJ
        gJSacNhBMZPzchGlsL0r+Gu82WTjhpyOQCNsCEtUlpYhYF+Lkh5cniUQVkc+3vCQN5QPQa79qyhYh
        9hUNuSrvMV5QbQo8hwffBbr/g8VnsOmFZYf+EfqU7wrRHEEw+ZHehpiMy+sJtS7zt9Cp/ru7n5IcS
        7hKwaP0szC6vDPVETvv79rQTj+UX0ldUHdsqxRsU0Wa2xxIngDzNihqjVTsV1Pa+EmqMGg3+fcDLC
        uIVSDg3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgZx8-009M33-1H;
        Sun, 26 Mar 2023 23:39:10 +0000
Date:   Sun, 26 Mar 2023 16:39:10 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZCDXnuV7oZwcYvRP@infradead.org>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org>
 <ZBzPYwcoLXkFngz8@google.com>
 <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
 <ZBzkzg+lr+TOXZcW@google.com>
 <8207efb81cd1e9322ad608d313eb4b4bd5740e80.camel@wdc.com>
 <ZBzy7RHlCqmApxUe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBzy7RHlCqmApxUe@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:46:37PM -0700, Jaegeuk Kim wrote:
> > Yes, and that was exactly my point: with LFS mode, O_DIRECT write
> > should never overwrite anything. So I do not see why direct writes
> > should be handled as buffered writes with zoned devices. Am I missing
> > something here ?
> 
> That's an easiest way to serialize block allocation and submit_bio when users
> are calling buffered writes and direct writes in parallel. :)
> I just felt that if we can manage both of them in direct write path along with
> buffered write path, we may be able to avoid memcpy.

Yes.  Note that right now f2fs doesn't really support proper O_DIRECT
for buffered I/O either, as non-overwrites require a feature similar
to unwritten extents, or a split of the allocation phase and the record
metdata phase.  If we'd go for the second choice for f2fs, which is the
more elegant thing to do, you'll get the zoned direct I/O write support
almost for free.

