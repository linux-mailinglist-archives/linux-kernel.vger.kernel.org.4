Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255CC6C13B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCTNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjCTNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:42:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B3CC15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4nvdeTrbCGVI17LJ6CL04s20971xhX1bwQsBRYlV8qE=; b=n82AssvJ7n/9KqIF/sa0wF812L
        9iiP4WXFSqISNg/zwvDmPWd8CNQCTSb8E1t+lQwmFM9nafJiSPJyKq6XGVUUp0qWZ4lryMGehnaVE
        vC50fFwTZcIJg4y/pKgzJEcxKVtFMtehC6YclcoeCNcPL87wNwWZQXK1y7DA/RR9XbJZXJKOzR07Q
        EIuz4NBLXDNKeR4s5k6DCqHjoEM8W5cWB0CjfzeYHspRie+huHaTLJQ09IRoUUIOGSSCjbmjWaT/z
        7rjEsy5r7eU3isCXXjahi+g8LwT7337U0vN44M9VeArzieqET283zDbvLZSE4EYE4d4EmFdGN1usa
        8qCB1wSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peFm4-009DTd-0d;
        Mon, 20 Mar 2023 13:42:08 +0000
Date:   Mon, 20 Mar 2023 06:42:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans Holmberg <hans.holmberg@wdc.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, damien.lemoal@wdc.com,
        aravind.ramesh@wdc.com, hans@owltronix.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZBhisCo7gTitmKeO@infradead.org>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220122004.26555-1-hans.holmberg@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 01:20:04PM +0100, Hans Holmberg wrote:
> A) Supporting proper direct writes for zoned block devices would
> be the best, but it is currently not supported (probably for
> a good but non-obvious reason). Would it be feasible to
> implement proper direct IO?

I don't think why not.  In many ways direct writes to zoned devices
should be easier than non-direct writes.

Any comments from the maintainers why the direct I/O writes to zoned
devices are disabled?  I could not find anything helpful in the comments
or commit logs.
