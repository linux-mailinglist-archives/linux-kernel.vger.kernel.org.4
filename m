Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CF71784A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjEaHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjEaHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8CE113
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685518270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xgdLJ8iH5oaqpzGT2VDUPLqR1HXU87CsPuv2JR9kJ1k=;
        b=VmjdWosse65P/mOn3a96FTLFTuPkLeUwB4hQGxZ9j+HLL+sJU745YbgUJzPHyRxd/roZ4p
        o21yauvIeyivaUUxn7yIvbCQOMf5icE23d0tEPrz6OL7i8eeU3T9EZtAHEm/TfGfzN0iRi
        PFKoPvYO+AgFXKY63jG1egFl55X23L4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-gbwutGR5OXqtxdF2C-E10A-1; Wed, 31 May 2023 03:31:07 -0400
X-MC-Unique: gbwutGR5OXqtxdF2C-E10A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6A101C068CF;
        Wed, 31 May 2023 07:31:06 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE373492B00;
        Wed, 31 May 2023 07:31:05 +0000 (UTC)
Date:   Wed, 31 May 2023 15:31:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] kexec: fix a memory leak in crash_shrink_memory()
Message-ID: <ZHb3tVHVV2l1BJBl@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-2-thunder.leizhen@huawei.com>
 <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
 <5232350c-7529-eece-c9cb-8a8bbc83a81a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5232350c-7529-eece-c9cb-8a8bbc83a81a@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/23 at 09:16am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/5/31 8:13, Baoquan He wrote:
> > On 05/27/23 at 08:34pm, Zhen Lei wrote:
> >> If the value of parameter 'new_size' is in the semi-open and semi-closed
> >> interval (crashk_res.end - KEXEC_CRASH_MEM_ALIGN + 1, crashk_res.end], the
> >> calculation result of ram_res is:
> >> 	ram_res->start = crashk_res.end + 1
> >> 	ram_res->end   = crashk_res.end
> > 
> > If the new_size is smaller than KEXEC_CRASH_MEM_ALIGN, does it make
> > any sense except of testing purpose? Do we need to fail this kind of
> > shrinking, or just shrink all the left crash memory?

OK, I misread your log. You are saying the new_size is close to
crashk_res.end but has a tiny difference in your example, I
thought the new_size is smaller than KEXEC_CRASH_MEM_ALIGN which is just
in the opposite direction.

Yea, it does have the possibility to waste a ram_res but does nothing
even though the chance is very small.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> We can't give a fixed value, that is, how much crash memory is reserved to
> ensure that the capture kernel runs. The size of KEXEC_CRASH_MEM_ALIGN is
> only one page on non-s390 platforms. So, it's better to keep the code simple,
> and let the user(administrator) shrink the crash memory reasonably.
> 
> include/linux/kexec.h
> #define KEXEC_CRASH_MEM_ALIGN	PAGE_SIZE

> 
> > 
> >> The operation of function insert_resource() fails, and ram_res is not
> >> added to iomem_resource. As a result, the memory of the control block
> >> ram_res is leaked.
> >>
> >> In fact, on all architectures, the start address and size of crashk_res
> >> are already aligned by KEXEC_CRASH_MEM_ALIGN. Therefore, we do not need to
> >> round up crashk_res.start again. Instead, we should round up 'new_size'
> >> in advance.
> >>
> >> Fixes: 6480e5a09237 ("kdump: add missing RAM resource in crash_shrink_memory()")
> >> Fixes: 06a7f711246b ("kexec: premit reduction of the reserved memory size")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/kexec_core.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index 3d578c6fefee385..22acee18195a591 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -1122,6 +1122,7 @@ int crash_shrink_memory(unsigned long new_size)
> >>  	start = crashk_res.start;
> >>  	end = crashk_res.end;
> >>  	old_size = (end == 0) ? 0 : end - start + 1;
> >> +	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
> >>  	if (new_size >= old_size) {
> >>  		ret = (new_size == old_size) ? 0 : -EINVAL;
> >>  		goto unlock;
> >> @@ -1133,9 +1134,7 @@ int crash_shrink_memory(unsigned long new_size)
> >>  		goto unlock;
> >>  	}
> >>  
> >> -	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
> >> -	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
> >> -
> >> +	end = start + new_size;
> >>  	crash_free_reserved_phys_range(end, crashk_res.end);
> >>  
> >>  	if ((start == end) && (crashk_res.parent != NULL))
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

