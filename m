Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBE699840
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBPPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBPPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF494
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676559744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pa9Fy5Ubq9jmjLtkh5hpgt9BGts1NKer0SZauUxszzs=;
        b=KjWz4/8ceDqor7/VyvyyJe8UpaMdbTqJJn2wTHJDZfD9NW+qRWGfXjd2vfSh8TddRa8k2L
        U50lx63lc+QpShGRq7owdEzU9CKIkkT2S4RAZfNAZSG4AvOrJeDbuyEFPLejCQ5EfnTEDh
        jjPncb1z9AA78ZS3pDh2uJrrTkzT5W8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-2YzRB7XnMcGoT6pRyxinQg-1; Thu, 16 Feb 2023 10:02:17 -0500
X-MC-Unique: 2YzRB7XnMcGoT6pRyxinQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43635857A88;
        Thu, 16 Feb 2023 15:02:14 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 746FD1121314;
        Thu, 16 Feb 2023 15:02:13 +0000 (UTC)
Date:   Thu, 16 Feb 2023 23:02:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, arnd@arndb.de,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+40p3oegc2Of9w2@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/23 at 01:50pm, Matthew Wilcox wrote:
> On Thu, Feb 16, 2023 at 08:34:15PM +0800, Baoquan He wrote:
> > Meanwhile, add macro ARCH_HAS_IOREMAP_WC since the added ioremap_wc()
> > will conflict with the one in include/asm-generic/iomap.h, then an
> > compiling error is seen:
> 

Thanks for reviewing.

> Huh?  ARCH_HAS_IOREMAP_WC comes up nowhere else in this patchset, and
> the current definition of ioremap_wc() is guarded by an ifndef ioremap_wc

Because another patch of powerpc has got ARCH_HAS_IOREMAP_WC in the
existed code.

> 
> > +#define ioremap_wc(addr, size)  \
> > +	ioremap_prot((addr), (size), _PAGE_IOREMAP)
> 
> This should be enough all by itself.

It's not if including asm-generic/iomap.h. The ARCH_HAS_IOREMAP_xx is to
avoid redefinition there.

include/asm-generic/iomap.h:
----
#ifndef ARCH_HAS_IOREMAP_WC
#define ioremap_wc ioremap
#endif

> 

