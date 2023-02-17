Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACB69AB13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBQMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBQMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:12:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924D6A04C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676635870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYiaBSjEl56ySuDVwZK8XF9Z2JRTm2SiNTi4k9/d4dY=;
        b=DnOebkU4ibZobaEOGCAept0qSx1mn058XAWEFZpxFhFCGVFAjtX33b4AYsDPKdnvVWzkRj
        ePz/xc80z4UxKZvP1xPhfDAKGWyzDv/hzncO1+B2+cPsxtrfWAbxqZxLZILLcFhjU4Q3+c
        Jb5IlTp7UFmlA+fD0ABKtnQ5fr5PINE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-5OWtxEMRM3qXVeLMOZTBhQ-1; Fri, 17 Feb 2023 07:11:07 -0500
X-MC-Unique: 5OWtxEMRM3qXVeLMOZTBhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 523733C0E46D;
        Fri, 17 Feb 2023 12:11:06 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95D432026D4B;
        Fri, 17 Feb 2023 12:11:04 +0000 (UTC)
Date:   Fri, 17 Feb 2023 20:11:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        David Laight <David.Laight@aculab.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y+9u1CP6yGnDwGlF@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
 <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
 <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
 <f93fdb4e-05e0-4301-95c9-3e1b1200d9b2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93fdb4e-05e0-4301-95c9-3e1b1200d9b2@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/23 at 03:51pm, Arnd Bergmann wrote:
> On Thu, Feb 16, 2023, at 15:47, Baoquan He wrote:
> > On 02/16/23 at 01:53pm, Arnd Bergmann wrote:
> >> On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> >> I see that there are only two callers of {devm_,}ioremap_uc() left in the
> >> tree, so maybe we can even take that final step and remove it from
> >> the interface. Maybe we can revisit [1] as part of this series.
> >
> > I see now. Christoph Hellwig ever mentioned in v2 reviewing, I
> > didn't get why. Thanks for the details. 
> > https://lore.kernel.org/all/YwHX98KBEnZw9t6e@infradead.org/T/#u
> >
> > I am not sure if it's OK to do the change in this patchset, maybe
> > another patch?
> 
> Yes, a separate patch would be ideal. If you do the same change in
> more than one architecture (other than ia64 and x86), you can combine
> those into one patch.

I am making a patch to achieve this. There's trouble in mips since it
hasn't had <asm-generic/io.h> in <asm/io.h>, and adding that will cuase
build error. I will post the patch for reviewing.

