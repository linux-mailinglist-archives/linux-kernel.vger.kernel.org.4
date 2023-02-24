Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC50C6A2340
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBXUqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBXUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:46:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EC567994;
        Fri, 24 Feb 2023 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CXWCcTWtQAtpZMwkWvr7mMFe5zhDDr+sLVb4ims5Yh0=; b=CylG0YEwbg2HdKH7WRiHhc2PBo
        nUcBZWh4rU5DPQ9TwdH1oAb9/Ki20Z6DOb6Ha5jHTHCvDkMlTfpaTXMwpuw0Bvgs2fdtbMG/HxmHT
        vIBBsmb3nuBB7M2BfMJXYIsxJprhU5uFI5uvnTCU2Oz1HT0JWktUV45xoGl5q88xfFYtAXrigMAhQ
        yOJfDntwgXWN5/ONFP/Y6G71jxIrYJLc7viTo8ZZZ2RfK7t2YEA1QoZR293oxziJBqPqymqZMJS+D
        0JsJPpN/gaMvOUAuWMzrGJBRDnQ8QT9WUERS6zRYpMLPdq7RDiwCW2wfjnjDcVjp08CukIx0wG+6+
        qXj78o9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVewi-00FYW5-RI; Fri, 24 Feb 2023 20:45:36 +0000
Date:   Fri, 24 Feb 2023 20:45:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
Message-ID: <Y/kh8P4oSjunIU7T@casper.infradead.org>
References: <Y/jhwuTCaOgOTLp2@casper.infradead.org>
 <2134430.1677240738@warthog.procyon.org.uk>
 <2009825.1677229488@warthog.procyon.org.uk>
 <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2213409.1677249075@warthog.procyon.org.uk>
 <2385089.1677258941@warthog.procyon.org.uk>
 <Y/kFnhUM5hjWM2Ae@casper.infradead.org>
 <2390711.1677269637@warthog.procyon.org.uk>
 <CAHk-=wgpjrdcs_aFvdHdH6TpOsOmN9S5rXDqCZTB8WqXsZH8Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpjrdcs_aFvdHdH6TpOsOmN9S5rXDqCZTB8WqXsZH8Qw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:16:49PM -0800, Linus Torvalds wrote:
> On Fri, Feb 24, 2023 at 12:14 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Then why do we have to wait for PG_writeback to complete?
> 
> At least for PG_writeback, it's about "the _previous_ dirty write is
> still under way, but - since PG_dirty is set again - the page has been
> dirtied since".
> 
> So we have to start _another_ writeback, because while the current
> writeback *might* have written the updated data, that is not at all
> certain or clear.

also, we only have a writeback bit, not a writeback count.  And when
the current writeback completes, it'll clear that bit.  We're also
being kind to our backing store and not writing to the same block twice
at the same time.

> I'm not sure what the fscache rules are.

My understanding is that the fscache bit is set under several
circumstances, but if the folio is dirty _and_ the fscache bit
is set, it means the folio is currently being written to the cache
device.  I don't see a conflict there; we can write to the backing
store and the cache device at the same time.
