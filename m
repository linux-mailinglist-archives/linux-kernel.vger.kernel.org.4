Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E5642184
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiLECZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiLECZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5420DE0BF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670207068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIaB1bH370BEUQX73UCqoL58l3sUZhXEOj98H8aVE+Y=;
        b=KHF94X3AzibM7seeFV0U5qs1T+FjZbo/2xeeSQ13Sh17nYouWM0JK6qDRvWjuew+L3Pz+F
        70kSkCnWBMaCMeqtY2VYOoqGI5IFHfz6WRsumPqckYjVzO/hLakjRumzOGaGbOC3T03QkN
        iALpU/US9f3aQgxEZSnbEhHxbLuJb6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-xWZIlQsxOoGY0rCuJwFsRQ-1; Sun, 04 Dec 2022 21:24:25 -0500
X-MC-Unique: xWZIlQsxOoGY0rCuJwFsRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B56E85A59D;
        Mon,  5 Dec 2022 02:24:24 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B502A1759E;
        Mon,  5 Dec 2022 02:24:23 +0000 (UTC)
Date:   Mon, 5 Dec 2022 10:24:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
        tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/1] percpu: cleanup invalid assignment to err in
 pcpu_alloc
Message-ID: <Y41WVP5vgKBpdMe1@MiWiFi-R3L-srv>
References: <20221204031430.662169-1-mawupeng1@huawei.com>
 <Y4yOMmnrT772wFSL@MiWiFi-R3L-srv>
 <Y407wDMKq5ibE9sc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y407wDMKq5ibE9sc@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/22 at 04:30pm, Dennis Zhou wrote:
> Hi Baoquan and Wupeng,
> 
> On Sun, Dec 04, 2022 at 08:11:23PM +0800, Baoquan He wrote:
> > On 12/04/22 at 11:14am, Wupeng Ma wrote:
> > > From: Ma Wupeng <mawupeng1@huawei.com>
> > > 
> > > Assignment to err if is_atomic is true will never be used since warn
> > > message can only be shown if is_atomic is false after label fail. So drop
> > > it.
> > > 
> > > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > > ---
> > >  mm/percpu.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > index acd78da0493b..df86d79325b2 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -1817,10 +1817,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> > >  
> > >  	spin_unlock_irqrestore(&pcpu_lock, flags);
> > >  
> > > -	if (is_atomic) {
> > > -		err = "atomic alloc failed, no space left";
> > > +	if (is_atomic)
> > >  		goto fail;
> > > -	}
> > 
> > This is good catch. But I think Dennis may not like this way because he
> > added the message intentionally in commit 11df02bf9bc1 ("percpu: resolve
> > err may not be initialized in pcpu_alloc").
> > 
> 
> You're right Baoquan haha. I agree with Christoph as well we should
> surface atomic.
> 
> Though I don't think below is quite right either. We should likely have
> a separate warn_limit for atomic and I need to think about dump_stack()
> if there are any requirements there.

Yeah, sounds reasonable. I didn't think it over. 

> 
> 
> > Can we change the conditional checking in fail part as below?
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 27697b2429c2..0ac55500fad9 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1897,7 +1897,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  fail:
> >  	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
> >  
> > -	if (!is_atomic && do_warn && warn_limit) {
> > +	if (do_warn && warn_limit) {
> >  		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
> >  			size, align, is_atomic, err);
> >  		dump_stack();
> > 
> 

