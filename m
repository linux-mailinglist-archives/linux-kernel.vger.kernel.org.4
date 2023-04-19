Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75EC6E7877
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjDSLUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjDSLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16415445
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681903132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4Ui46Ta0P2TP7Rwzqo3VE9KCOz5jOSMpJOW/7SNy88=;
        b=i2t8YS6+0TK0+y7y7kqLlmO37JvPTI5x/QLEUEVMXYTJ8LEEVBJPTZ6irOyfki1BBahmIo
        tsYPyxLD/UsP06in4x9cEk2fbWwYJd37xceNhi/F8hCXosi/DcBSl5keYBh+wUIpr9AEWm
        PpkbmXmu8kt16qgfceYXIiu88NgeM/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-FiNbAEzrNVuVLWm7VGa_LA-1; Wed, 19 Apr 2023 07:18:49 -0400
X-MC-Unique: FiNbAEzrNVuVLWm7VGa_LA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 981FD811E7D;
        Wed, 19 Apr 2023 11:18:48 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61EC340BC799;
        Wed, 19 Apr 2023 11:18:48 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 04C00401CA8CB; Wed, 19 Apr 2023 08:15:56 -0300 (-03)
Date:   Wed, 19 Apr 2023 08:15:56 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrew Theurer <atheurer@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZD/NbAU8gHILW/6w@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD/NAaa5TVcL7Mxm@tpad>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
> On Tue, Apr 18, 2023 at 03:02:00PM -0700, Andrew Morton wrote:
> > On Mon, 20 Mar 2023 15:03:32 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > 
> > > This patch series addresses the following two problems:
> > > 
> > > 1. A customer provided evidence indicating that a process
> > >    was stalled in direct reclaim:
> > > 
> > > ...
> > >
> > >  2. With a task that busy loops on a given CPU,
> > >     the kworker interruption to execute vmstat_update
> > >     is undesired and may exceed latency thresholds
> > >     for certain applications.
> > > 
> > 
> > I don't think I'll be sending this upstream in the next merge window. 
> > Because it isn't clear that the added complexity in vmstat handling is
> > justified.
> 
> From my POV this is an incorrect statement (that the complexity in
> vmstat handling is not justified).
> 
> Andrew, this is the 3rd attempt to fix this problem:
> 
> First try:  https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
> 
> Second try: https://patchew.org/linux/20230105125218.031928326@redhat.com/
> 
> Third try: syncing vmstats remotely from vmstat_shepherd (this
> patchset).
> 
> And also, can you please explain: what is so complicated about the
> vmstat handling? cmpxchg has been around and is used all over the
> kernel, and nobody considers "excessively complicated".
> 
> > - Michal's request for more clarity on the end-user requirements
> >   seems reasonable.
> 
> And i explained to Michal in great detail where the end-user 
> requirements come from. For virtualized workloads, there are two
> types of use-cases:
> 
> 1) For example, for the MAC scheduler processing must occur every 1ms,
> and a certain amount of computation takes place (and must finish before
> the next 1ms timeframe). A > 50us latency spike as observed by cyclictest
> is considered a "failure".
> 
> I showed him a 7us trace caused by, and explained that will extend to >
> 50us in the case of virtualized vCPU.
> 
> 2) PLCs. These workloads will also suffer > 50us latency spikes
> which is undesirable.
> 
> Can you please explain what additional clarity is required?
> 
> RH's performance team, for example, has been performing packet
> latency tests and waiting for this issue to be fixed for about 2
> years now.
> 
> Andrew Theurer, can you please explain what problem is the vmstat_work
> interruption causing in your testing?

+CC Andrew.

