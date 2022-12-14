Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898464CF13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiLNSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiLNSDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:03:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D42A278
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JWfCee/Sqeyheu8+ic5pZTBVDz5x2Sw7vv1duxIKk90=; b=AwWn77qXLlBJuLR3KUyVc+7HlT
        ehUD8PFh1lprVAegIDhIRJYu44O3Nr6AbjR3i8TpysC9CRVHGSE93fkfbYed0xggYIo1noPt1ZY9G
        sQM6cs14MeyJgpSzKopW5Wp+iDguGos2Pm9Ruz/0E7hbJZoJO4Q8XtfyLittbBetnaCgZXxf6H3rS
        EaZu3h062isKc/1AgNLrfi/l5yF3eFPfYwExgkuPzooITWk52UTCeNmsluGJignTI+47okzYeReut
        Uc4AUg/MHJ4xRG60UbgknRqsXPwd3jI5qRNAhu4crOotMmjNdpBraAjMKUlk3NEhv8PRyUx3jL3cX
        pFIRwN0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5W5w-00DTdg-Su; Wed, 14 Dec 2022 18:03:04 +0000
Date:   Wed, 14 Dec 2022 18:03:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Make const-safe
Message-ID: <Y5oP2Psz++gHholO@casper.infradead.org>
References: <20221212144946.2657785-1-willy@infradead.org>
 <Y5mTJVi2PBix+Gy6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5mTJVi2PBix+Gy6@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:11:01AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 12, 2022 at 02:49:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > With a modified container_of() that preserves constness, the compiler
> > finds some pointers which should have been marked as const.  task_of()
> > also needs to become const-preserving for the !FAIR_GROUP_SCHED case so
> > that cfs_rq_of() can take a const argument.  No change to generated code.
> 
> More const more better I suppose.. Thanks!
> 
> Happen to have a sha for the container_of() commit handy?

There isn't one yet.  Obviously we can't make container_of()
const-preserving until we've fixed all the places which would warn.
The diff I have in my tree looks like this:

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 1d898f9158b4..9416e6cc8c88 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -20,7 +20,10 @@
        static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
                      __same_type(*(ptr), void),                        \
                      "pointer type mismatch in container_of()");       \
-       ((type *)(__mptr - offsetof(type, member))); })
+       __mptr -= offsetof(type, member);                               \
+       _Generic(ptr,                                                   \
+               const typeof(*(ptr)) *: (const type *)__mptr,           \
+               default: ((type *)__mptr)); })

 /**
  * container_of_const - cast a member of a structure out to the containing

I have all of fs/ and net/ compiling cleanly now.  There are a few
places which really need the const-removing properties, and I've made
those call a new macro called container_of_not_const(), but I don't
like that name.
