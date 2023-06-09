Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BA72A34C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFIToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2D53590
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686339791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hsFhpgfxWMykwSn5/1ALxRTTekNl16jpPv5u3IzbyUM=;
        b=WnfU2RbJZsIkCS/V1OIp4QtN/BG1SCWt0XKV3/YZY7xEnSSXIiQjTujaOfBMSiZKIvL5qZ
        J6/1CMvvnEgGtWicGN6WQO+GCF8+4SapJG89+KuleSZ8Tgdfp0tUm/nkLVXXu1uFkjpg7U
        wHdkjMrqa9T8BGYJD1s90eMFU9aXxaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-v63rzh51PMKQAlWrLVjzEg-1; Fri, 09 Jun 2023 15:43:06 -0400
X-MC-Unique: v63rzh51PMKQAlWrLVjzEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D05FD101A52C;
        Fri,  9 Jun 2023 19:43:05 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E7840C1438;
        Fri,  9 Jun 2023 19:43:05 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 42AE1401030E9; Fri,  9 Jun 2023 10:54:04 -0300 (-03)
Date:   Fri, 9 Jun 2023 10:54:04 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/idle: disable tick in idle=poll idle entry
Message-ID: <ZIMu/GzBZQ1EmiZ0@tpad>
References: <ZIEqlkIASx2F2DRF@tpad>
 <20230608083400.GH998233@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608083400.GH998233@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:34:00AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 07, 2023 at 10:10:46PM -0300, Marcelo Tosatti wrote:
> > 
> > Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> > ("tick/nohz: Conditionally restart tick on idle exit") allows
> > a nohz_full CPU to enter idle and return from it with the 
> > scheduler tick disabled (since the tick might be undesired noise).
> > 
> > The idle=poll case still unconditionally restarts the tick when entering
> > idle.
> > 
> > To reduce the noise for that case as well, stop the tick when entering
> > idle, for the idle=poll case.
> > 
> > tick_nohz_idle_exit (called if the NEED_RESCHED bit is set) 
> > is responsible for re-enabling the tick when necessary. 
> 
> Who cares and why?

Systems that use isolcpus/nohz_full, and use idle=poll to avoid sleeping.
For example:

https://github.com/intel/FlexRAN/blob/master/README.md

More specifically, the case which HLTs (via nanosleep usually) is:

https://www.isa.org/intech-home/2022/february-2022/departments/what-you-may-not-know-about-softplcs

Can add this to the next version of the patch (unless you have any other
comments).

Thanks.

