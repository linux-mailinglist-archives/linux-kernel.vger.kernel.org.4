Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315836635DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjAIXtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjAIXtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38FA20B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673308070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQ4O+Pza8mF8eNdykukSI5mqc0eTZz0ZSMoCpZTcRks=;
        b=cSYeGeo10AS032K/w37XrYQlj1mQzCoLvD80iZ2bxX6g81HqEX7lqQc1rWF77u8pNOu3is
        529my85/qpjyYcQifUu5kRpe6zGiQ846r0EeDpuYK56QnUh3YgkTq00WDuLN5Gy0EFtR8w
        +/xTepNvOAnGItfxEhfMe48luHvOZCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-0McbnAQPNYWv7LgkHKfDuw-1; Mon, 09 Jan 2023 18:47:49 -0500
X-MC-Unique: 0McbnAQPNYWv7LgkHKfDuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C4FC80234E;
        Mon,  9 Jan 2023 23:47:48 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 328642166B26;
        Mon,  9 Jan 2023 23:47:47 +0000 (UTC)
Date:   Tue, 10 Jan 2023 07:47:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v16 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y7ynnzmfy+Kxj8hQ@fedora>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
 <20230105151709.1845-8-eric.devolder@oracle.com>
 <Y7vD6bm9xy9uyvRD@fedora>
 <bc4ade74-dcbc-88f6-2d88-2bd4c2be38ba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4ade74-dcbc-88f6-2d88-2bd4c2be38ba@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 at 01:43pm, Eric DeVolder wrote:
> 
> 
> On 1/9/23 01:36, Baoquan He wrote:
> > On 01/05/23 at 10:17am, Eric DeVolder wrote:
> > ......
> > > @@ -394,10 +409,37 @@ int crash_load_segments(struct kimage *image)
> > >   	if (ret)
> > >   		return ret;
> > > -	image->elf_headers = kbuf.buffer;
> > > -	image->elf_headers_sz = kbuf.bufsz;
> > > +	image->elf_headers	= kbuf.buffer;
> > > +	image->elf_headers_sz	= kbuf.bufsz;
> > > +	kbuf.memsz		= kbuf.bufsz;
> > > +
> > > +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
> > > +		/*
> > > +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
> > > +		 * Start with VMCOREINFO and kernel_map.
> > > +		 */
> > > +		unsigned long pnum = 2;
> > > +
> > > +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > +			pnum += CONFIG_NR_CPUS_DEFAULT;
> > > +
> > > +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> > > +			pnum += CRASH_MAX_MEMORY_RANGES;
> > 
> > Logic of pnum calculating is a little confusing to me. If I only enable
> > one of CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG, is it OK? Say I
> > only enable CONFIG_HOTPLUG_CPU and CONFIG_SMP, on x86_64,
> > CONFIG_NR_CPUS_DEFAULT will be 64. pnum will be 64, is it OK. Am I miss
> > anything?
> 
> Ah, your understanding is correct, and the issue you point out I need to fix.
> Specifically is only one of HOTPLUG_CPU or MEMORY_HOTPLUG is set, then I need
> to allow a default for the other. Using the example you have above, there would
> not be room for a single memory region, so I need to allow for a default number
> of memory regions.

Hmm, for the above example, should we get real number of memory
regions? I am worried if the default number of memory regions 
need be big enough. Because on system w/o memory hotplug, it could have
very many memory regions. The cpu number is similar.

