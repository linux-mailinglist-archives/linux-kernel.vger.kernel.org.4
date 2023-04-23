Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADE6EBC4A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDWBek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWBei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3862F1FE3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682213634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09Pqr7rDFYYz3FncrOkQc8pLBhiqcgYn36BtmrtOB5A=;
        b=RhLuodqJxNfaTAe+b8kflTIseP/rftgKnoDIcwis7LXCnBQ6Q0IL7hy6lzGz10ocnqbesl
        Q48FEUdijBaHkbOTKkqmmoqTscmaPbNUgma2ktEVYgTRY0oBDN7/+Tna+wivFuSumS8wUR
        Hh/21aNrCwhvDH6h3jiQPtFAzrJArtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-2Xeptx0oPzu-RVqHESuNgw-1; Sat, 22 Apr 2023 21:33:50 -0400
X-MC-Unique: 2Xeptx0oPzu-RVqHESuNgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDCFF85A5B1;
        Sun, 23 Apr 2023 01:33:49 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FB9F4400C;
        Sun, 23 Apr 2023 01:33:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id CCFF2400DC5BC; Sat, 22 Apr 2023 22:25:01 -0300 (-03)
Date:   Sat, 22 Apr 2023 22:25:01 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Theurer <atheurer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZESI7U13pOTJ1Y3W@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/NbAU8gHILW/6w@tpad>
 <98E08059-6607-43FF-84E3-BFF3FF193D09@redhat.com>
 <ZEDv/O30XLZfw/GX@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEDv/O30XLZfw/GX@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 09:55:40AM +0200, Michal Hocko wrote:
> On Wed 19-04-23 08:44:23, Andrew Theurer wrote:
> > > On Apr 19, 2023, at 6:15 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >> Andrew Theurer, can you please explain what problem is the vmstat_work
> > >> interruption causing in your testing?
> > > 
> > > +CC Andrew.
> > 
> > Nearly every telco we work with for 5G RAN is demanding <20 usec CPU
> > latency as measured by cyclictest & oslat.  We cannot achieve under 20
> > usec with the vmstats interruption.
> 
> Are you able to get those latency requirements with PREEMPT_RT?

What do you mean, exactly?

PREEMPT_RT allows for the preemption of tasks in kernel context
(so that higher priority tasks can interrupt lower priority tasks).
It also enables IRQ handling to happen in thread context 
(so that a given thread might be given higher priority than executing
a particular IRQ handler).

If the question is: "Are you able to achieve <20 usec latency while
allowing switching between different tasks ?" The answer with current
processor and memory speeds is probably: no.
But with more performant processors, you might.

However, with a fully isolated processor which does not require
switching between tasks, yes you can achieve < 20 usec latency.


