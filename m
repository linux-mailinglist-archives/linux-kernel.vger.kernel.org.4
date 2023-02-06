Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD0D68C679
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBFTLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E63C2A9AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675710666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gzFi5JB/wsVMdtsyVlJ8PrVrHAH1wodhHHtJ2DK0as=;
        b=QATC6CuL1rOHZYqDwPnCmQoa1/MaGeyyKZyJBwyDCicj13u6oRJQ1KHlaxyURWUDVNnVuU
        eFfxM4F5o7rSIx5MzZju7qJriOYv6oOrrpcYEGpDzCPeBcL01Yur2X36iXuhpnIdgJ5F3f
        5ILXprWBya1r9NFkCCLL+cn1DDltJB0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-EynxCIuhMZS3meSWiy84WQ-1; Mon, 06 Feb 2023 14:11:00 -0500
X-MC-Unique: EynxCIuhMZS3meSWiy84WQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65BED3806620;
        Mon,  6 Feb 2023 19:11:00 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32742492B21;
        Mon,  6 Feb 2023 19:11:00 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 134EF403FCA00; Mon,  6 Feb 2023 16:10:33 -0300 (-03)
Date:   Mon, 6 Feb 2023 16:10:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <Y+FQqT/I/uf01+MS@tpad>
References: <20230201195013.881721887@redhat.com>
 <20230201195104.460373427@redhat.com>
 <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de>
 <Y9vcpO5Dh2G3Y6ib@tpad>
 <5615572-974e-74cc-6c34-1de618b777cf@gentwo.de>
 <Y91X3hA5i7FQJwEo@tpad>
 <47a289f0-ae96-e0e6-c579-70ec61fff384@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a289f0-ae96-e0e6-c579-70ec61fff384@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:42:46AM +0100, Christoph Lameter wrote:
> On Fri, 3 Feb 2023, Marcelo Tosatti wrote:
> 
> > > Isnt there some lock/serializtion to stall the kernel until you are done?
> >
> > Not that i know of. Anyway, an additional datapoint is:
> >
> > "Software defined PLC"
> > (https://www.redhat.com/en/blog/software-defined-programmable-logic-controller-introduction),
> > applications
> > can perform system calls in their time sensitive loop.
> >
> > One example of an opensource software is OpenPLC.
> >
> > One would like to avoid interruptions for those cases as well.
> 
> Well allowing sytem calls during "time sensitiveness" implies
> it is not that sensitive to vmstat updates
> which have a smaller impact than system calls.

Not necessarily. Certain system calls won't touch per-CPU vmstats: nanosleep,
for example. Perhaps i misunderstood your suggestion:

So the patchset in discussion uses (or should use, in v2), in both
vmstat_shepherd and vmstat counter modification, LOCK CMPXCHG.

There is the potential that LOCK CMPXCHG, from vmstat counter modification, 
incurs a performance degradation.

Note however, that cachelocking should hopefully "hide" the costs. 

Do you have any concerns about this patchset other than the performance
degradation due to addition of LOCK in CMPXCHG? 

The other possible concern is that the preempt-disabled functions,
namely:
__inc_node_page_state, __dec_node_page_state, __mod_node_page_state,
__inc_zone_page_state, __dec_zone_page_state, __mod_zone_page_state
have been switched to cmpxchg loop. Is that a problem?

Would expect that measuring LOCK CMPXCHG does not incur significant
performance degradation as compared to CMPXCHG (from the 
page allocation benchmark) would address your concerns?

Thanks

