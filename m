Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0EA5F1045
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiI3QvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiI3QvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:51:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2E18B5EE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:51:04 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e70a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e70a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 521CF1EC04DA;
        Fri, 30 Sep 2022 18:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664556659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tP9Z9kALkJplQ//X4pAwQj/9u9C0dERnBu4DmkUwjxM=;
        b=c5NyopsCGhoBd1uFmWvBwlikJDwE9xijsQuDUsK2MmV90jGTOcm63idZOnV6Lj4D4e39P9
        v61pX3A4xPk6l3MtmFUWpfWQtk+mOYlIUb/P9iMve1okkWXLYa8XM4GmjXSHmiQ3q/Ddaa
        ZeUxI7kH5Q5VUgJQuc7SssTEQA+hucI=
Date:   Fri, 30 Sep 2022 18:50:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Yzceb/y3SSFMuALR@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
 <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:36:49AM -0500, Eric DeVolder wrote:
> > Your help text talks about System RAM entries in /proc/iomem which means
> > that those entries are present somewhere in the kernel and you can read
> > them out and do the proper calculations dynamically instead of doing the
> > static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.
> 
> The intent is to compute the max size buffer needed to contain a maximum
> populated elfcorehdr, which is primarily based on the number of CPUs and
> memory regions. Thus far I (and others involved) have not found a kernel
> method to determine the maximum number of memory regions possible (if you
> are aware of one, please let me know!). Thus CONFIG_CRASH_MAX_MEMORY_RANGES
> was born (rather borrowed from kexec-tools).

Let's ask some mm folks.

mm folks, is there a way to enumerate all the memory regions a machine
has?

It looks to me like register_memory_resource() in mm/memory_hotplug.c
does register the resource so there should be a way to count that list
of resources or at least maintain a count somewhere so that kexec/crash
code can know how big its elfcodehdr buffer should be instead of doing a
clumsy Kconfig item where people would need to guess...

Hmm.

> > +#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
> So I think the use of CONFIG_CRASH_MAX_MEMORY_RANGES is not correct; it
> still needs to be based on the cpu or memory hotplug options.

You're kidding, right?

+config CRASH_MAX_MEMORY_RANGES
+	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
	^^^^^^^^^^				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> > @@ -622,6 +622,15 @@ static int __init crash_save_vmcoreinfo_init(void)
> >   subsys_initcall(crash_save_vmcoreinfo_init);
> >   #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > +
> > +void __weak *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> > +{
> > +	return NULL;
> > +}
> > +
> > +void __weak arch_unmap_crash_pages(void **ptr) { }
> > +void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
> > +
> I was asked by Baoquan He to eliminate the use of __weak

Because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
