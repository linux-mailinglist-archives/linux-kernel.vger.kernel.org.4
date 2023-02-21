Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156569E0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjBUMx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBUMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925626CDC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676983957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cim37CPurlllaqqM13IPZavfyIJo0MFG0mwjskCxTms=;
        b=gb0VIzhfsiGk/m4877z188qaA3ca2RbuSYOvsFYyoo1g/3PjcbqM4WTjnW/KoWAni4yBAY
        CVGV9I5n1Lpl6EhU0L9Z8SKNAPtZt/OQBGL1Gg5K1hoRC1jG0AIaXR4L/3v4MWekKDTEVV
        YWVYCf6wuVRL1uT+ff8ofw51gtASV9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-SiXvUBB0N5SiMGhbDklnUA-1; Tue, 21 Feb 2023 07:52:32 -0500
X-MC-Unique: SiXvUBB0N5SiMGhbDklnUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5FE385A5A3;
        Tue, 21 Feb 2023 12:52:31 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F08472166B26;
        Tue, 21 Feb 2023 12:52:30 +0000 (UTC)
Date:   Tue, 21 Feb 2023 20:52:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, David.Laight@aculab.com,
        shorne@gmail.com, arnd@arndb.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 09/16] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y/S+i5Rodai25HNS@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-10-bhe@redhat.com>
 <9bb1154b07dc21e5d3dda8cc5238c5385f32c2e0.camel@linux.ibm.com>
 <Y/SvqcWQ+5sgozX/@MiWiFi-R3L-srv>
 <a0502208452b40b17572d18891ffee94e42484fa.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0502208452b40b17572d18891ffee94e42484fa.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/23 at 01:26pm, Niklas Schnelle wrote:
> On Tue, 2023-02-21 at 19:48 +0800, Baoquan He wrote:
> > On 02/16/23 at 05:21pm, Niklas Schnelle wrote:
> > > On Thu, 2023-02-16 at 20:34 +0800, Baoquan He wrote:
> > > > By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> > > > generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> > > > and iounmap() are all visible and available to arch. Arch needs to
> > > > provide wrapper functions to override the generic versions if there's
> > > > arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> > > > This change will simplify implementation by removing duplicated codes
> > > > with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> > > > functioality as before.
> > > > 
> > > > Here, add wrapper functions ioremap_prot() and iounmap() for s390's
> > > > special operation when ioremap() and iounmap().
> > > > 
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > > > Cc: Heiko Carstens <hca@linux.ibm.com>
> > > > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > > > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > > > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > > Cc: Sven Schnelle <svens@linux.ibm.com>
> > > > Cc: linux-s390@vger.kernel.org
> > > > ---
> > > >  arch/s390/Kconfig          |  1 +
> > > >  arch/s390/include/asm/io.h | 21 ++++++++------
> > > >  arch/s390/pci/pci.c        | 57 +++++++-------------------------------
> > > >  3 files changed, 23 insertions(+), 56 deletions(-)
> > > 
> > > Thanks for the patch. This is a very clear improvement for us! I tested
> > > this series with s390 systems with and without the PCI memory-I/O (MIO)
> > > support and everything works as expected.
> > > 
> > > One thing I did stumble upon but which is independent from this patch
> > > is that I think memremap(…, MEMREMAP_WB) on system RAM outside the
> > > direct map is broken for us. At least on systems without PCI memory-I/O
> > > support. I think with this series it would be much easier to fix
> > > though. Basically I think we would have to define arch_memremap_wb() to
> > > generic_ioremap_prot(…, PAGE_KERNEL) and then have iounmap() check
> > > is_ioremap_addr() to see if it is an actual mapping or an address
> > > cookie. But again this is independent of this patch which doesn't
> > > change the behavior in this area.
> > 
> > OK, I can check this after this patchset done.
> 
> Oh this wasn't meant as adding a task for you just a FYI. I'm already
> experimenting with this and plan to possibly send a patch that fixes
> the case of remapping system RAM once your series has landed. The thing
> is that memremap() is quite tricky for us whichever way you look at
> it. 
> 
> We don't have real MMIO on s390x and thus using memremap() for PCI MMIO
> spaces doesn't really work as the void* returned can still only be
> accessed using ioread()/iowrite() because only our special PCI access
> instructions work on the pseudo-MMIO addresses (with PCI MIO)
> respectively the address cookies. Obviously void* and memremap() really
> isn't the right tool if you need to use ioread()/iowrite() to access it
> and can't treat it as memory though.

Ah, I misunderstood it. Thanks for sharing and expect to see your post.

