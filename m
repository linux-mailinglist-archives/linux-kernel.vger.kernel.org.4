Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA556CA61B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC0Nii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjC0Ni1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E77468A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679924261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8d9EBL9G+yB4k+cLBXL6iafPp7ZDhdpIRbLC9bXM/FM=;
        b=CTjAjcpk3leoE+SNxXoCKaY/H65hgfFoUhBbw+VDBHidERyyqkvCCmH7bif+891uH4bu1E
        EMeYyQIwcP4g2BJoSMPxAuNtLTB6CZ9bxR599S8RaewQM8WiYJol1RN5LtccmcL3v5Wa0P
        /+gRIWVPwkMvszFeksPD/gl+M89/iMU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-KcBeCJvsMWWafjfv-KwpXg-1; Mon, 27 Mar 2023 09:37:36 -0400
X-MC-Unique: KcBeCJvsMWWafjfv-KwpXg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B3BE3C14841;
        Mon, 27 Mar 2023 13:37:35 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35ED3492C3E;
        Mon, 27 Mar 2023 13:37:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 4DD3F403D16E8; Mon, 27 Mar 2023 07:24:54 -0300 (-03)
Date:   Mon, 27 Mar 2023 07:24:54 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <ZCFu9jFm/rskeNlM@tpad>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
 <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
 <ZB4lt3IaPWVmn41n@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZB4lt3IaPWVmn41n@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:35:35PM +0100, Frederic Weisbecker wrote:
> Le Sat, Mar 18, 2023 at 09:04:38AM +0100, Michal Hocko a écrit :
> > On Fri 17-03-23 15:35:05, Marcelo Tosatti wrote:
> > > On Fri, Mar 17, 2023 at 03:33:13PM -0300, Marcelo Tosatti wrote:
> > > > On Fri, Mar 17, 2023 at 02:44:47PM +0100, Michal Hocko wrote:
> > > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > > 
> > > > > Provide this new API to check if a CPU has been isolated either through
> > > > > isolcpus= or nohz_full= kernel parameter.
> > > > > 
> > > > > It aims at avoiding kernel load deemed to be safely spared on CPUs
> > > > > running sensitive workload that can't bear any disturbance, such as
> > > > > pcp cache draining.
> > > > 
> > > > Hi Michal,
> > > > 
> > > > This makes no sense to me.
> > > > 
> > > > HK_TYPE_DOMAIN is set when isolcpus=domain is configured.
> > > > HK_TYPE_TICK is set when nohz_full= is configured.
> > > > 
> > > > The use-cases i am aware of use either:
> > > > 
> > > > isolcpus=managed_irq,... nohz_full=
> > > > OR
> > > > isolcpus=domain,managed_irq,... nohz_full=
> > > > 
> > > > So what is the point of this function again?
> > > > 
> > > > Perhaps it made sense along with, but now does not make sense
> > > > anymore:
> > > > 
> > > > Subject: [PATCH 1/2] sched/isolation: Merge individual nohz_full features into a common housekeeping flag
> > > > 
> > > > The individual isolation features turned on by nohz_full were initially
> > > > split in order for each of them to be tunable through cpusets. However
> > > > plans have changed in favour of an interface (be it cpusets or sysctl)
> > > > grouping all these features to be turned on/off altogether. Then should
> > > > the need ever arise, the interface can still be expanded to handle the
> > > > individual isolation features.
> > > > 
> > > > But Michal can just use housekeeping_test_cpu(cpu, HK_TYPE_TICK) and
> > > > the convertion of nohz_full features into a common housekeeping flag
> > > > can convert that to something else later?
> > > 
> > > Actually introducing cpu_is_isolated() seems fine, but it can call
> > > housekeeping_test_cpu(cpu, HK_TYPE_TICK) AFAICS.
> >  
> > This is not really my area. Frederic, could you have a look please?
> 
> The point is to have a function that tells if either nohz_full= or
> isolcpus=[domain] has been passed for the given CPU.
> 
> Because I assumed that both would be interested in avoiding that flush
> noise, wouldn't it be the case?

Yes, that is the case. But as a note: for the two main types of
configuration performed (one uses isolcpus=[domain] and the other
cgroups, for isolating processes) nohz_full= is always set.

So just testing for nohz_full= would be sufficient (which perhaps would
make the code simpler).

