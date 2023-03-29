Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C956CDCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjC2Ohl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjC2OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF607AA8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680100307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8U3rACF49U6AOCOedOjgERqK5/T1G/mMgCJwPeJvHA=;
        b=MOQVauwHGk1Z7b4/Zh2dMAUbOPo62JUnS5Lfk6hcU0Onkxhbbyv5SEIAvZ+iCu0+GYdMIg
        gE3hjaN5sE5fR3l6lPaoXgAsXFFbXjOaGbAsVtNz4p33XA91Nsjvg7X8VIeECRRqmJSNOq
        s/CrR65tf9w1ruqYPLSmlpL5YiYGB8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-tqUh_sqXPgCPuULRl0SPWg-1; Wed, 29 Mar 2023 10:31:43 -0400
X-MC-Unique: tqUh_sqXPgCPuULRl0SPWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B40C5185A791;
        Wed, 29 Mar 2023 14:31:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7024D404DC5C;
        Wed, 29 Mar 2023 14:31:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id A5DD04015571D; Wed, 29 Mar 2023 11:20:21 -0300 (-03)
Date:   Wed, 29 Mar 2023 11:20:21 -0300
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
Message-ID: <ZCRJJRz01vX8jPjb@tpad>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
 <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
 <ZB4lt3IaPWVmn41n@localhost.localdomain>
 <ZCFu9jFm/rskeNlM@tpad>
 <ZCLT8iH2ltmQ40my@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCLT8iH2ltmQ40my@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:48:02PM +0200, Michal Hocko wrote:
> On Mon 27-03-23 07:24:54, Marcelo Tosatti wrote:
> > On Fri, Mar 24, 2023 at 11:35:35PM +0100, Frederic Weisbecker wrote:
> > > Le Sat, Mar 18, 2023 at 09:04:38AM +0100, Michal Hocko a écrit :
> > > > On Fri 17-03-23 15:35:05, Marcelo Tosatti wrote:
> [...]
> > > > > Actually introducing cpu_is_isolated() seems fine, but it can call
> > > > > housekeeping_test_cpu(cpu, HK_TYPE_TICK) AFAICS.
> > > >  
> > > > This is not really my area. Frederic, could you have a look please?
> > > 
> > > The point is to have a function that tells if either nohz_full= or
> > > isolcpus=[domain] has been passed for the given CPU.
> > > 
> > > Because I assumed that both would be interested in avoiding that flush
> > > noise, wouldn't it be the case?
> > 
> > Yes, that is the case. But as a note: for the two main types of
> > configuration performed (one uses isolcpus=[domain] and the other
> > cgroups, for isolating processes) nohz_full= is always set.
> > 
> > So just testing for nohz_full= would be sufficient (which perhaps would
> > make the code simpler).
> 
> I do not see any mention about that assumption under Documentation/. 

Documentation/admin-guide/kernel-per-CPU-kthreads.rst

SCHED_SOFTIRQ
-------------

Do all of the following:

1.      Avoid sending scheduler IPIs to the CPU to be de-jittered,
        for example, ensure that at most one runnable kthread is present
        on that CPU.  If a thread that expects to run on the de-jittered
        CPU awakens, the scheduler will send an IPI that can result in
        a subsequent SCHED_SOFTIRQ.
2.      CONFIG_NO_HZ_FULL=y and ensure that the CPU to be de-jittered
        is marked as an adaptive-ticks CPU using the "nohz_full="
        boot parameter.  This reduces the number of scheduler-clock
        interrupts that the de-jittered CPU receives, minimizing its
        chances of being selected to do the load balancing work that
        runs in SCHED_SOFTIRQ context.

> Is this a best practice documented anywhere or it just happens to be
> the case with workloads you deal with?

Option 2. However Frederic seems interested in matching the exported
toggles with the known use-cases classes.

For example, for this guide:
http://www.comfilewiki.co.kr/en/doku.php?id=comfilepi:improving_real-time_performance:index

Using nohz_full= would be a benefit (and its not being currently set,
perhaps due to not knowing all the options?).

http://www.comfilewiki.co.kr/en/doku.php?id=comfilepi:improving_real-time_performance:index


AFAIU the workloads for which disabling nohz_full= is a benefit are those
where the switching between nohz full mode and sched tick enabled mode
and vice-versa (which involve programming the local timer) happens
often and is therefore avoidable? For example switching between 1
runnable task and more than 1 runnable task (and vice versa).

