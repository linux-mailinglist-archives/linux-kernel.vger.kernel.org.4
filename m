Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F396C4D30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCVOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjCVOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FCB6132C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679494310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UqrFGkvaC9MBw1HFItFLIU59aJ0toVTkq8wmsXh6i8=;
        b=XgPo+PdamKzkijJxKdSlQOUF5JxkvuKsAyjCcfIDJpRjIMNVdBE5qB7J1yU9kjPmDOsn/g
        hRagYDX/r4o4OJLQZE0gfDtJTuM9YDjUClHmbQ3hCA5D0nfxRS/J9GtPrv8WUbt+cm5i4K
        E1+cN6ZcSjYeGdIRgmhEHdNjp51cowg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-yZQ2wKfwMmewOlZ0qyGxgw-1; Wed, 22 Mar 2023 10:11:49 -0400
X-MC-Unique: yZQ2wKfwMmewOlZ0qyGxgw-1
Received: by mail-wr1-f69.google.com with SMTP id o5-20020adf8b85000000b002d58b4b7698so1146890wra.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494306;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3UqrFGkvaC9MBw1HFItFLIU59aJ0toVTkq8wmsXh6i8=;
        b=JBruaisiDJMiiO/vLbWfF4zVMYfef9lvPGcSlbh+wulF6G2s8MwoXp5qTb7YUctSxk
         FsiU9IA1izpo3b3jtw84eTGiNEhTW0q1PmW3sRYXoeZwl9Fo0Yrb6ttO9B3UJGhgHVn3
         U3PgBkYTh8GnUz4Yaedg0RaGFp2xk8rd7BbgjEBLNzdWDQhvTA6K2g3MF99NuehQjWDI
         I+B21gaDafPNjsdIVmOaitjeniSs39CNYx7gisY3cUe7b53FoosytjD9fRRZuQTNlKI8
         aW42GXGTBJWVJmASKQDzb7ZBdt1AtQtLgzMmcyGq64174ttS8iDbBJKMhTyWTuakPxq2
         OT1Q==
X-Gm-Message-State: AO0yUKWH485zd/dsJZTvDbYd6ls+a3zupo5IUjhLb4RgF3NLxr6rqIzS
        mW82jqzQ558bXH/PTzrCLFFO1SUsI7ZN4GLjomiWS3hCuCH5cjgbWusXHLnPUrk8X48hFjO2tMb
        9O1aYaPZxVIsvr4ViDl0/sc4V
X-Received: by 2002:a5d:68c8:0:b0:2d7:3cd3:85b2 with SMTP id p8-20020a5d68c8000000b002d73cd385b2mr5074907wrw.23.1679494306794;
        Wed, 22 Mar 2023 07:11:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YUojw3fi6msBU/V/hiqD91q9offxI9n0+R6x289RxK9QQFJLElvzx2/dRIQzjYjU1s+oB9g==
X-Received: by 2002:a5d:68c8:0:b0:2d7:3cd3:85b2 with SMTP id p8-20020a5d68c8000000b002d73cd385b2mr5074886wrw.23.1679494306521;
        Wed, 22 Mar 2023 07:11:46 -0700 (PDT)
Received: from ypodemsk.lan (IGLD-84-229-251-248.inter.net.il. [84.229.251.248])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm13889142wrz.34.2023.03.22.07.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:11:46 -0700 (PDT)
Message-ID: <a6ee41b39f3f516aab0f7fb327620cb2a43eeaca.camel@redhat.com>
Subject: Re: [PATCH] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only
 to MM CPUs
From:   ypodemsk@redhat.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        ppandit@redhat.com, alougovs@redhat.com,
        David Hildenbrand <david@redhat.com>
Date:   Wed, 22 Mar 2023 16:11:44 +0200
In-Reply-To: <20230320084902.GE2194297@hirez.programming.kicks-ass.net>
References: <20230312080945.14171-1-ypodemsk@redhat.com>
         <20230320084902.GE2194297@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 09:49 +0100, Peter Zijlstra wrote:
> On Sun, Mar 12, 2023 at 10:09:45AM +0200, Yair Podemsky wrote:
> > Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
> > indiscriminately, this causes unnecessary work and delays notable
> > in
> > real-time use-cases and isolated cpus, this patch will limit this
> > IPI to
> > only be sent to cpus referencing the effected mm and are currently
> > in
> > kernel space.
> 
> Did you validate that all architectures for which this is relevant
> actually set bits in mm_cpumask() ?
> 
Hi Peter,
Thank you for bringing this to my attention.
I reviewed the architectures using the MMU_GATHER_RCU_TABLE_FREE:
arm, powerpc, s390, sparc and x86 set the bit when switching process
in.
for arm64 removed set/clear bit in 38d96287504a ("arm64: mm: kill
mm_cpumask usage")
The reason given was that mm_cpumask was not used.
Given that we now have a use for it, I will add a patch to revert.
Thanks
Yair

