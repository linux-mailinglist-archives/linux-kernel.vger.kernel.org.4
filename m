Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B968A248
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjBCSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBCSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78EA58E8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675450357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeW1akqqTvQD5RyZenW9QkipgaQxGjnSO+zPQwmfIxY=;
        b=PwbO+c+FF8EsQ3CByi+m9kf/Ow4UUzQ6NNLtFGv+ZRo5jAlXgLG8OmSo5pJn5d9j6Q3TBI
        tetj6N5mTy+Yu1iqtPwcQZGy8ToGoefyCXIO1CAk4TyiDui47pNSDPSaw4riFKscNFQtfu
        yTbJbTI+uW41hwxTKO8MRYTkoptqOgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-All7GBLkN0K_IQl1mE4KMg-1; Fri, 03 Feb 2023 13:52:34 -0500
X-MC-Unique: All7GBLkN0K_IQl1mE4KMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AA08100F90A;
        Fri,  3 Feb 2023 18:52:33 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9303112132D;
        Fri,  3 Feb 2023 18:52:32 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id A1719403C4285; Fri,  3 Feb 2023 15:52:14 -0300 (-03)
Date:   Fri, 3 Feb 2023 15:52:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <Y91X3hA5i7FQJwEo@tpad>
References: <20230201195013.881721887@redhat.com>
 <20230201195104.460373427@redhat.com>
 <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de>
 <Y9vcpO5Dh2G3Y6ib@tpad>
 <5615572-974e-74cc-6c34-1de618b777cf@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5615572-974e-74cc-6c34-1de618b777cf@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 10:34:22AM +0100, Christoph Lameter wrote:
> On Thu, 2 Feb 2023, Marcelo Tosatti wrote:
> 
> > > I thought you would only run this while the kernel is not active on the
> > > remote cpu? Then you dont need any cmpxchg and you can leave the function
> > > as is.
> >
> > The remote cpu can enter kernel mode while this function executes.
> 
> Isnt there some lock/serializtion to stall the kernel until you are done?

Not that i know of. Anyway, an additional datapoint is:

"Software defined PLC"
(https://www.redhat.com/en/blog/software-defined-programmable-logic-controller-introduction),
applications
can perform system calls in their time sensitive loop.

One example of an opensource software is OpenPLC.

One would like to avoid interruptions for those cases as well.

> > There is no mode which indicates userspace cannot enter the kernel.
> 
> There are lot of thinngs that happen upon entry to the kernel. I would
> hope that you can do something there. Scheduler?

The use-case in question is with isolation, where a CPU is dedicated
to a single task. So the scheduler should not be an issue.


