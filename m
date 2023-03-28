Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329266CB35F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjC1Bt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC1Bt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:49:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907310CC;
        Mon, 27 Mar 2023 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=drkQ92cPVg9tVgMwwt3QwYKwER+tkvuJkif72VmCj2c=; b=LZB2Hi2EmrzTVwEHj57Y7lNAT1
        hI/h3cOZ6/ShUNWqImkrN3UPZsuzSYXe/xLo15Up6wRtx6G6ksD176dIHjC1eGXzgrD8NSUIAkQaL
        DapaTBrlH7+sYkHRC1qtVVvQkTh/ShsQAkhMlCg2ZLkn71KzFUqAyZi4mcj4YWgdeKNbNFcZZtJex
        HHhVYlkrGV8T1e3SIwLEASTwsyC21Nj2d22RbRF6++gu+yTmRJKjF8BAEsaHKGH23xpdhXr7iL0Wr
        AXgJeJ7R+b/I0JMG+PHs8c2IRL2C+M6DDGzIbu+UhJKaqDutb1YuF6dwTjSV45YlonsMqEMbqT2P8
        FAb6SxiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgySg-00CpFT-1e;
        Tue, 28 Mar 2023 01:49:22 +0000
Date:   Mon, 27 Mar 2023 18:49:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ye Bin <yebin@huaweicloud.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <ZCJHotVOmvK+/P/k@infradead.org>
References: <20230327140218.4154709-1-yebin@huaweicloud.com>
 <20230327151524.GC16180@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327151524.GC16180@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:15:24AM -0700, Darrick J. Wong wrote:
> > There's issue as follows:
> > XFS: Assertion failed: (bmv->bmv_iflags & BMV_IF_DELALLOC) != 0, file: fs/xfs/xfs_bmap_util.c, line: 329
> 
> Why not get rid of the assertion?  It's not like it changes the course
> of the code flow -- userspace still gets told there's a delalloc extent.
> 
> Or, if the assert does serve some purpose, then do we need to take
> the mmaplock for cow fork reporting too?

Looking at the COW fork reporting I think it's actually even more
broken as it never tried to flush data to start with.  But COW
report is a DEBUG only feature, so maybe forcing or requiring
BMV_IF_DELALLOC there would make a whole lot of sense.
