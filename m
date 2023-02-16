Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811536997CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBPOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBPOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:48:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454210D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676558855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFaX4cxZUJf+Ng89cRL/nlepV5PVhHHLPICLCsLRqZ4=;
        b=Y/dFQF/CNWJs8ymV15Suwx2meqtOXA8dfCyDS8cmegmHDY8DkRHO6R9rykdWjx1Uk8JOOC
        BxMQepm6RSgWWBhAtUGlVyvdFrakL7viwlNGXWs39EVzB8Z/X/zmRqBmYtYfct4DP9P7Qi
        MZazBEL5PSqgFnD6TbPVbtZjuXflM/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-_35hlDTcPQ-qNTe5ah1O_A-1; Thu, 16 Feb 2023 09:47:32 -0500
X-MC-Unique: _35hlDTcPQ-qNTe5ah1O_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3135085CBEA;
        Thu, 16 Feb 2023 14:47:31 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7534140EBF6;
        Thu, 16 Feb 2023 14:47:29 +0000 (UTC)
Date:   Thu, 16 Feb 2023 22:47:24 +0800
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
Message-ID: <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
 <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/23 at 01:53pm, Arnd Bergmann wrote:
> On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> > diff --git a/arch/hexagon/include/asm/io.h 
> > b/arch/hexagon/include/asm/io.h
> > index 46a099de85b7..dcd9cbbf5934 100644
> > --- a/arch/hexagon/include/asm/io.h
> > +++ b/arch/hexagon/include/asm/io.h
> > @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void 
> > __iomem *addr)
> >  #define writew_relaxed __raw_writew
> >  #define writel_relaxed __raw_writel
> > 
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> > -#define ioremap_uc(X, Y) ioremap((X), (Y))
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> > +		       (__HEXAGON_C_DEV << 6))
> > +

Thanks for reviewing.

> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
> 
> I think we probably want to kill off ioremap_uc() here, and use
> the generic version that just returns NULL.


-#define ioremap_uc(X, Y) ioremap((X), (Y))
+#define ioremap_uc(addr, size) ioremap((addr), (size))

Here, in fact the ioremap_uc() definition is not related. I just
improve the old definition passingly. And similar for other
ioremap_uc() adaptation.

> 
> I see that there are only two callers of {devm_,}ioremap_uc() left in the
> tree, so maybe we can even take that final step and remove it from
> the interface. Maybe we can revisit [1] as part of this series.

I see now. Christoph Hellwig ever mentioned in v2 reviewing, I
didn't get why. Thanks for the details. 
https://lore.kernel.org/all/YwHX98KBEnZw9t6e@infradead.org/T/#u

I am not sure if it's OK to do the change in this patchset, maybe
another patch?

Thanks
Baoquan

