Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6D6F1A88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjD1Ofh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjD1Ofe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:35:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE024690
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6eObBW43b80KcVg8sxFZxljf11doVRwPM2OOpwpCgAc=; b=KJyfmbLO9WkkYmIPJVhIYE4VkN
        M4c4GB8skCzOUGx/Bf4vnHIYkCls1e0jxorIRnhifv9ULQ5kx3HDXL54OVzpKJkpT4lM1+4pzYMx8
        KQcA8ST1JGaMJuzhJ+G12YMe8oKIidj5CCyx8e18+uCkVhsrkUNuAdC9SZODYyU6ZbmdVF9PU2bEu
        B5lKrhoek7Ap+BTrAC07On1Neqca6oFFm7lh+c1IOOYSNokquKiiOMnEOmL1cgafDK7iR+L/mX2s7
        Ac0EinKNLx2b0XiPS+DI+mLu3NsNNQrn4R5EofFSxmnr+p0IhaMGsJ4uXCIqZISoWMsTcS/N7pBp2
        8GtLo7nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psPBm-004g8u-5V; Fri, 28 Apr 2023 14:35:10 +0000
Date:   Fri, 28 Apr 2023 15:35:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: fix printk format within cma
Message-ID: <ZEvZnvIx5mbnIzsx@casper.infradead.org>
References: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZD4QsGd0DwHa83K1@casper.infradead.org>
 <20230418123338.3b85a013cf6ce1fcb3677ae2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418123338.3b85a013cf6ce1fcb3677ae2@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:33:38PM -0700, Andrew Morton wrote:
> On Tue, 18 Apr 2023 04:38:24 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Apr 18, 2023 at 11:33:09AM +0800, zhaoyang.huang wrote:
> > > cma and page pointer printed via %p are hash value which make debug to be hard.
> > > change them to %px.
> > 
> > Why does printing the page pointer make any sense at all?  Surely the
> > PFN makes much more sense.
> 
> I suppose one could correlate a particular hashed pointer with other
> debug output, see "ah, that's the same page".  In which case one
> doesn't really care whether or not the address is hashed - it's just a
> cookie.  This sounds thin.
> 
> I doubt if a lot of thought went into the printk.  If the page pointer
> isn't useful then how about we simply remove it from the message?

If something about it weren't useful, I don't think we'd be seeing a patch
to transform it from a hashed pointer to an unhashed pointer?  I'm pretty
sure the PFN is the real information that's wanted here, since you can
look at the hardware RAM layout to determine why that's not eligible.

