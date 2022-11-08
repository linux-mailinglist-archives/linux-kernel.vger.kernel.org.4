Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AD620BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiKHJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiKHJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743DDE96
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667898874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jl974esNqwVUZQrdA0rwXdnfcsjrzYfR8j0D0GOI1RI=;
        b=cSmwj5roDXhCuWOEsw1bPNXwguqLSFwuHlpwvKEF7towsArvaryPIsZRWXyfSRyC5Af8+n
        anfjMDcJhtakBlrgFuegh0BFJB8QCOLw22PBj3UQOwTJcSgUaJyea3WD9llkfKKVTAsja/
        T906GPJvo+JKSaPsAQn2JveefNFBED4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-e9woTgahPpiqsG8pax1m-A-1; Tue, 08 Nov 2022 04:14:24 -0500
X-MC-Unique: e9woTgahPpiqsG8pax1m-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C745085A583;
        Tue,  8 Nov 2022 09:14:23 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D66B40C947B;
        Tue,  8 Nov 2022 09:14:22 +0000 (UTC)
Date:   Tue, 8 Nov 2022 17:14:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] Cleanup and optimization patches for percpu
Message-ID: <Y2od67nSCf7Ll7WJ@MiWiFi-R3L-srv>
References: <20221024081435.204970-1-bhe@redhat.com>
 <Y2n/rEu7HzRbXZXL@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2n/rEu7HzRbXZXL@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 at 11:05pm, Dennis Zhou wrote:
> Hello Baoquan,
> 
> On Mon, Oct 24, 2022 at 04:14:27PM +0800, Baoquan He wrote:
> > These were found out when reading percpu code, and queued in my local
> > branch for long time. Send them out for reviewing.
> > 
> > Baoquan He (8):
> >   mm/percpu: remove unused pcpu_map_extend_chunks
> >   mm/percpu: use list_first_entry_or_null in pcpu_reclaim_populated()
> >   mm/percpu: Update the code comment when creating new chunk
> >   mm/percpu: add comment to state the empty populated pages accounting
> >   mm/percpu: replace the goto with break
> >   mm/percpu.c: remove the lcm code since block size is fixed at page
> >     size
> >   mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS
> >   mm/slub, percpu: correct the calculation of early percpu allocation
> >     size
> > 
> >  include/linux/percpu.h |  7 +++----
> >  mm/percpu.c            | 44 +++++++++++++++++-------------------------
> >  mm/slub.c              |  3 ++-
> >  3 files changed, 23 insertions(+), 31 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 
> I've applied patches 1-7 to for-6.2.

Thanks a lot.

