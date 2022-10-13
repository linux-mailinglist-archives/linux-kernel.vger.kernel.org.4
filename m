Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B75FD759
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJMJvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525914E41C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665654702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnamMLehA6c/ZrC5mAWlH7KtTngXqnj6RvbTVflM5BA=;
        b=O5gBN/hnMmQqj/Ynjz+0TFBtCTEKfUzjyUFtrhUWEqp18Htt1F4Z150R1kZg+GWualaDUw
        TmWv0927R1Cn43gYcKs5vdc4R3tPrDyLxFbmyZbvpgAGxUZgHrdyTvsOABD+B4Qf56fCmn
        OFlGtH+Bda57/h7P9Q7Q3TTmucUmzxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-wzSYpi1QPaKmyhZ3WPMPtQ-1; Thu, 13 Oct 2022 05:51:39 -0400
X-MC-Unique: wzSYpi1QPaKmyhZ3WPMPtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD804185A794;
        Thu, 13 Oct 2022 09:51:38 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 136CB1121314;
        Thu, 13 Oct 2022 09:51:36 +0000 (UTC)
Date:   Thu, 13 Oct 2022 17:51:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@ACULAB.COM" <David.Laight@aculab.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v3 05/11] arc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y0ffpSdpAcvbXDGK@MiWiFi-R3L-srv>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-6-bhe@redhat.com>
 <bbfa1fd5-3dae-2d00-0421-5f1e627eb8f7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbfa1fd5-3dae-2d00-0421-5f1e627eb8f7@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 at 10:17am, Christophe Leroy wrote:
......
> > -/*
> > - * ioremap with access flags
> > - * Cache semantics wise it is same as ioremap - "forced" uncached.
> > - * However unlike vanilla ioremap which bypasses ARC MMU for addresses in
> > - * ARC hardware uncached region, this one still goes thru the MMU as caller
> > - * might need finer access control (R/W/X)
> > - */
> > -void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
> > -			   unsigned long flags)
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> >   {
> > -	unsigned int off;
> > -	unsigned long vaddr;
> > -	struct vm_struct *area;
> > -	phys_addr_t end;
> > -	pgprot_t prot = __pgprot(flags);
> > -
> > -	/* Don't allow wraparound, zero size */
> > -	end = paddr + size - 1;
> > -	if ((!size) || (end < paddr))
> > -		return NULL;
> > -
> >   	/* An early platform driver might end up here */
> >   	if (!slab_is_available())
> > -		return NULL;
> > +		return IOMEM_ERR_PTR(-EINVAL);
> 
> I think the slab_is_available() check should be done in the generic 
> functions. On all architectures SLAB must be available before you can 
> use get_vm_area_caller() and vunmap()

Tend to agree.

W/o slab initialized, the get_vm_area_caller() calling definitely will
fail. The arch's early ioremap code could call into this.

