Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB66D0E27
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjC3Sys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3Syn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C05DBD1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680202435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yILtE8G0wRpMYBAf60dk5xAKt3MM/0au1zweuUxeqC8=;
        b=QIJ71ERfbwrnXMzQG+p0Hq8rcMnghIdkBvJ6J30GYzIIRZQbsBZ2arjmrWmhjMRwL7LsaH
        W9jP4laVXGDdW5SuSayn/+KQRSrdlW4gEJNoUjrSdxiTBFoauhuRg8P0m5JMxH4v4GGPH6
        FiVYMWj6BLkCXBOBrrwnPcwYS4eM9Xk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-wFNaXMt2O9-prAhtlP8RLw-1; Thu, 30 Mar 2023 14:53:51 -0400
X-MC-Unique: wFNaXMt2O9-prAhtlP8RLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F39B6811E7C;
        Thu, 30 Mar 2023 18:53:49 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4DE04020C82;
        Thu, 30 Mar 2023 18:53:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 3C6FB4038C70D; Thu, 30 Mar 2023 12:21:22 -0300 (-03)
Date:   Thu, 30 Mar 2023 12:21:22 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <ZCWo8n88qWL0GmQ8@tpad>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
 <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
 <ZB4lt3IaPWVmn41n@localhost.localdomain>
 <ZCFu9jFm/rskeNlM@tpad>
 <ZCLT8iH2ltmQ40my@dhcp22.suse.cz>
 <ZCRJJRz01vX8jPjb@tpad>
 <ZCWOlHmyO1YREEGt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCWOlHmyO1YREEGt@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:28:52PM +0200, Michal Hocko wrote:
> > > Is this a best practice documented anywhere or it just happens to be
> > > the case with workloads you deal with?
> > 
> > Option 2. However Frederic seems interested in matching the exported
> > toggles with the known use-cases classes.
> > 
> > For example, for this guide:
> > http://www.comfilewiki.co.kr/en/doku.php?id=comfilepi:improving_real-time_performance:index
> > 
> > Using nohz_full= would be a benefit (and its not being currently set,
> > perhaps due to not knowing all the options?).
> > 
> > http://www.comfilewiki.co.kr/en/doku.php?id=comfilepi:improving_real-time_performance:index
> > 
> > 
> > AFAIU the workloads for which disabling nohz_full= is a benefit are those
> > where the switching between nohz full mode and sched tick enabled mode
> > and vice-versa (which involve programming the local timer) happens
> > often and is therefore avoidable? For example switching between 1
> > runnable task and more than 1 runnable task (and vice versa).
> 
> The patch from Frederic is testing for both. You seem to be arguing to
> reduce the test and I still do not understand why. Sure some workloads
> (following the above) will likely use nohz_full= as well but does it
> make sense to build that expectation into the higher level logic? What
> is an actual benefit?

Just thinking of simpler code. Feel free to maintain the patch as-is if
you see fit.

