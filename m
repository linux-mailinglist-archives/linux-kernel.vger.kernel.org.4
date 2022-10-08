Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4610C5F826E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJHCfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJHCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA545F132
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665196525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5IsnY8coRZJSVHdnCDXDDkPFYnnu8TF82UevKAb/afk=;
        b=YW3NA1yUTxuC/JVrzwa7sqjOF6G+0jbW1l5Lexz05sF9tKLeNETO1HVPkx1bmnYhkBYZqm
        i4dEyQz5PJ1AStnA0xH7EkKp867HCqHRH3Rqg/zvvCeSYeT5fkFAGapGKLDbkgoI99qDOA
        c7b4Wj7VTuIRvQq5i3Wq+2Xm4WluDsk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-AoMLW116PyS1BS81jRxTAg-1; Fri, 07 Oct 2022 22:35:20 -0400
X-MC-Unique: AoMLW116PyS1BS81jRxTAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3367B3C0E219;
        Sat,  8 Oct 2022 02:35:19 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 100679D474;
        Sat,  8 Oct 2022 02:35:18 +0000 (UTC)
Date:   Sat, 8 Oct 2022 10:35:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcqE1RVtPcuLlxN@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/22 at 07:40pm, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 12:11:26PM -0500, Eric DeVolder wrote:
> > There is of course a way to enumerate the memory regions in use on the
> > machine, that is not what this code needs. In order to compute the maximum
> > buffer size needed (this buffer size is computed once), the count of the
> > maximum number of memory regions possible (even if not currently in use) is
> > what is needed.
> 
> Isn't that max number documented somewhere in memory hotplug docs?

Memory hptlug is not limited by a certin or a max number of memory
regions, but limited by how large of the linear mapping range which
physical can be mapped into.

E.g on x86_64, with 4-level page tables, it has 64TB linear mapping
range by default. On principle, we can add 64TB of phisical memory
into system altogether from booting and memory hotplug. While with
KASLR enabled, it has 10TB of linear mapping range by default, see
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING. Means there's only 10TB
phisical memory being allowed to be added into system.

For the Kconfig CRASH_MAX_MEMORY_RANGES Eric added, it's meaningful to
me to set a fixed value which is enough in reality. For extreme testing
with special purpose, it could be broken easily, people need decide by
self whether the CONFIG_CRASH_MAX_MEMORY_RANGES is enlarged or not.
E.g on x86_64, we make a system with memory smaller than 64G, this will
cause the memory block size being probed as 256M. Then we hot added many
Tera Bytes of physical memory every second memory block after bootup with
a shell shell script. It could be easier to manipulate this with virtiomem.
Please see function probe_memory_block_size() on x86_64 about the memory
block size probing. However, I don't think on real system, this kind of
system could really exist, with a tiny memory booted up, a huge memory
hot added sparsely.

> 
> Because then you don't need that Kconfig item either. Imagine you're a
> distro kernel distributor and you want crash to work on all machines
> your kernel works.
> 
> So you go and set that number to max. And that would be the 99% of the
> kernel configs out there.
> 
> Which means, you can just set it to max without a Kconfig item.
> 
> > Oh, that would be an error of haste on my part. This should be:
> >   depends on CRASH_DUMP && MEMORY_HOTPLUG
> 
> You need a Kconfig item which enables all this gunk as MEMORY_HOTPLUG is
> not a omnipresent feature. And that Kconfig item should depend on the
> other Kconfig items of the technology you need.
> 
> > Baoquan pointed me to:
> > 
> > https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/
> 
> In that thread says:
> 
> "- arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures."
> 
> So yes, that's even better.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

