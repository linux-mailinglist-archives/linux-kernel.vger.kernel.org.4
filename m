Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4259A717877
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjEaHmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjEaHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD2C5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685518889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c/LgYdINnVSghmwNsV+kSfBQhPeozhgR1xVSC5icCD8=;
        b=iQun/tKlDAdKRrf20RQH/KsrpWbpIkA2AS8xuglaTm+dXHdNKi3q3QeQiSPARko0bD6gyV
        t2de6+rxNabGkE2yuO+Y17k4PlIBtgPEEjYetyq5LWiw0SyJU+B2trUE4mnBJ4MRzUeS9x
        xM9buD6xtc0rkxHxVbKgJ9xoVtPe3Ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-iC-EiwSvNPyI4SF233teJw-1; Wed, 31 May 2023 03:41:25 -0400
X-MC-Unique: iC-EiwSvNPyI4SF233teJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5CF811E85;
        Wed, 31 May 2023 07:41:25 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6231F40C6EC4;
        Wed, 31 May 2023 07:41:22 +0000 (UTC)
Date:   Wed, 31 May 2023 15:41:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] kexec: delete a useless check in
 crash_shrink_memory()
Message-ID: <ZHb6IFhwRMkAkNjt@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-3-thunder.leizhen@huawei.com>
 <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
 <5beb1883-5391-1b75-d8cd-2152478b9e72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5beb1883-5391-1b75-d8cd-2152478b9e72@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/23 at 10:19am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/5/31 8:17, Baoquan He wrote:
> > On 05/27/23 at 08:34pm, Zhen Lei wrote:
> >> The check '(crashk_res.parent != NULL)' is added by
> >> commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
> >> stale now. Because if 'crashk_res' is not reserved, it will be zero in
> >> size and will be intercepted by the above 'if (new_size >= old_size)'.
> >>
> >> Ago:
> >> 	if (new_size >= end - start + 1)
> >>
> >> Now:
> >> 	old_size = (end == 0) ? 0 : end - start + 1;
> >> 	if (new_size >= old_size)
> > 
> > Hmm, I would strongly suggest we keep that check. Even though the
> > current code like above can do the acutal checking, but its actual usage
> > is not obvious for checking of crashk_res existence. In the future,
> > someone may change above calculation and don't notice the hidden
> > functionality at all behind the calculation. The cost of the check is
> > almost zero, right?
> 
> The cost of the check is negligible. The only downside is that it's hard to
> understand why it's added, and I only found out why by looking at the history
> log. In my opinion, the above 'Now:' is the right fix.

It checks if the resource exists before releasing, just a normal
checking?
> 
> > 
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/kexec_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index 22acee18195a591..d1ab139dd49035e 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
> >>  	end = start + new_size;
> >>  	crash_free_reserved_phys_range(end, crashk_res.end);
> >>  
> >> -	if ((start == end) && (crashk_res.parent != NULL))
> >> +	if (start == end)
> >>  		release_resource(&crashk_res);
> >>  
> >>  	ram_res->start = end;
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

