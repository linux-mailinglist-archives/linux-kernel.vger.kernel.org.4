Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7076A664FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjAJXhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAJXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:37:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4383FA18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9D2YNhHDkVVEE9exXgu2G8l0Gdzt+6c/8Zgvq7MbNk4=; b=Sjj1Q8i/5JCjKJwX2QoJ62PkLk
        /uXUFegZaMH110XdeXPDa7Nf8mstFvH8Lokf8KJD9YfMR6z9R0HY/m00W4RFnCo3NOR1x6f7+pNBD
        4v0Pq1DN85w7SSvxHxXKPj1PesvzdINMnk3e675/uMBzreG/Yc4J/83X+zmqWrX7fUW17vlpuvvL3
        276abmFJQPMlXWjc85PnkFb/3VjsRz+9qdzh+CiTvq8B4pngsCZh87OpOe6ig5vOW84dzW7lusnGz
        EaQ4VzBIkaIqeRmFxv7rzCQkaj5QNJpURnat7AbshrLDUOPBvvQcGRHIe29wwrmqNLU5hHcOBbHLh
        HL/4pbLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFOBJ-003cWt-Mg; Tue, 10 Jan 2023 23:37:25 +0000
Date:   Tue, 10 Jan 2023 23:37:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: Remove redundant VM_BUG_ON() in
 compact_zone()
Message-ID: <Y732taMH+r/QGcgD@casper.infradead.org>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
 <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
 <Y71qNeLNeiBB5a/+@casper.infradead.org>
 <20230110152532.8b2d34bf04d7b8e9a4e39130@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110152532.8b2d34bf04d7b8e9a4e39130@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 03:25:32PM -0800, Andrew Morton wrote:
> On Tue, 10 Jan 2023 13:37:57 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Jan 10, 2023 at 09:36:18PM +0800, Baolin Wang wrote:
> > > The compaction_suitable() will never return values other than COMPACT_SUCCESS,
> > > COMPACT_SKIPPED and COMPACT_CONTINUE, so after validation of COMPACT_SUCCESS
> > > and COMPACT_SKIPPED, we will never hit other unexpected case. Thus remove
> > > the redundant VM_BUG_ON() validation for the return values of compaction_suitable().
> > 
> > I don't understand why we'd remove this check.
> 
> Well, just from code inspection it serves no purpose.
> 
> Such an assertion might be useful during early code development, but I
> think we can consider compaction_suitable() to adequately debugged by
> now?

What if compaction_suitable() is modified to return another value?
This seems like a relatively innocuous check.
