Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825F609D87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJXJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJXJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A917AAC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666602613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTEDRcmXXQS08afZGdLf2piCdEuBNuck5VCmgs8GBz4=;
        b=HgDX15gLPZDHiJNnj33D+eYh87UMJlS+9Lls+I4b6ixZQl+JL7j99sT810j2memkb1swYN
        Lg6iwOBNruevV1S67sCNNmpvxDNt3g6Hpf2OKlPOu9nsYXDCr2FXmjJ2X75KAusvGvVa2N
        7ImqQOvW6MSXAMdjWr/xwp1yt2340iY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-baUEGjhoO-Cqkt_GTX5PwQ-1; Mon, 24 Oct 2022 05:10:06 -0400
X-MC-Unique: baUEGjhoO-Cqkt_GTX5PwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D876D3810D2B;
        Mon, 24 Oct 2022 09:10:05 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A463E39DB3;
        Mon, 24 Oct 2022 09:10:04 +0000 (UTC)
Date:   Mon, 24 Oct 2022 17:10:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y1ZWaSeGk53QqZHX@MiWiFi-R3L-srv>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
 <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, Sourabh,

On 10/07/22 at 02:14pm, Eric DeVolder wrote:
> 
> 
> On 10/3/22 12:51, Sourabh Jain wrote:
> > Hello Eric,
> > 
> > On 10/09/22 02:35, Eric DeVolder wrote:
......
> > > +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> > > +{
> > > +    /* Obtain lock while changing crash information */
> > > +    mutex_lock(&kexec_mutex);
> > > +
> > > +    /* Check kdump is loaded */
> > > +    if (kexec_crash_image) {
> > > +        struct kimage *image = kexec_crash_image;
> > > +
> > > +        if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> > > +            hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> > > +            pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
> > > +        else
> > > +            pr_debug("crash hp: hp_action %u\n", hp_action);
> > > +
> > > +        /*
> > > +         * When the struct kimage is allocated, it is wiped to zero, so
> > > +         * the elfcorehdr_index_valid defaults to false. Find the
> > > +         * segment containing the elfcorehdr, if not already found.
> > > +         * This works for both the kexec_load and kexec_file_load paths.
> > > +         */
> > > +        if (!image->elfcorehdr_index_valid) {
> > > +            unsigned char *ptr;
> > > +            unsigned long mem, memsz;
> > > +            unsigned int n;
> > > +
> > > +            for (n = 0; n < image->nr_segments; n++) {
> > > +                mem = image->segment[n].mem;
> > > +                memsz = image->segment[n].memsz;
> > > +                ptr = arch_map_crash_pages(mem, memsz);
> > > +                if (ptr) {
> > > +                    /* The segment containing elfcorehdr */
> > > +                    if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> > > +                        image->elfcorehdr_index = (int)n;
> > > +                        image->elfcorehdr_index_valid = true;
> > > +                    }
> > > +                }
> > > +                arch_unmap_crash_pages((void **)&ptr);
> > > +            }
> > > +        }
> > > +
> > > +        if (!image->elfcorehdr_index_valid) {
> > > +            pr_err("crash hp: unable to locate elfcorehdr segment");
> > > +            goto out;
> > > +        }
> > > +
> > > +        /* Needed in order for the segments to be updated */
> > > +        arch_kexec_unprotect_crashkres();
> > > +
> > > +        /* Flag to differentiate between normal load and hotplug */
> > > +        image->hotplug_event = true;
> > > +
> > > +        /* Now invoke arch-specific update handler */
> > > +        arch_crash_handle_hotplug_event(image, hp_action);
> > > +
> > > +        /* No longer handling a hotplug event */
> > > +        image->hotplug_event = false;
> > > +
> > > +        /* Change back to read-only */
> > > +        arch_kexec_protect_crashkres();
> > > +    }
> > > +
> > > +out:
> > > +    /* Release lock now that update complete */
> > > +    mutex_unlock(&kexec_mutex);
> > > +}
> > > +
> > > +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> > > +{
> > > +    switch (val) {
> > > +    case MEM_ONLINE:
> > > +        handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
> > > +        break;
> > > +
> > > +    case MEM_OFFLINE:
> > > +        handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
> > > +        break;
> > > +    }
> > > +    return NOTIFY_OK;
> > 
> > Can we pass v (memory_notify) argument to arch_crash_handle_hotplug_event function
> > via handle_hotplug_event?
> > 
> > Because the way memory hotplug is handled on PowerPC, it is hard to update the elfcorehdr
> > without memory_notify args.
> > 
> > On PowePC memblock data structure is used to prepare elfcorehdr for kdump. Since the notifier
> > used for memory hotplug crash handler get initiated before the memblock data structure update
> > happens (as depicted below), the newly prepared elfcorehdr still holds the old memory regions.
> > So if the system crash with obsolete elfcorehdr, makedumpfile failed to collect vmcore.
> > 
> > Sequence of actions done on PowerPC to server the memory hotplug:
> > 
> >   Initiate memory hot remove
> >            |
> >            v
> >   offline pages
> >            |
> >            v
> >   initiate memory notify call chain
> >   for MEM_OFFLINE event.
> >   (same is used for crash update)
> >            |
> >            v
> >   prepare new elfcorehdr for kdump using
> >   memblock data structure
> >            |
> >            v
> >   update memblock data structure
> > 
> > How passing memory_notify to arch crash hotplug handler will help?
> > 
> > memory_notify holds the start PFN and page count, with that we can get
> > the base address and size of hot unplugged memory and can use the same
> > to avoid hot unplugged memeory region to get added in the elfcorehdr..
> > 
> > Thanks,
> > Sourabh Jain
> > 
> 
> Sourabh, let's see what Baoquan thinks.
> 
> Baoquan, are you OK with this request? I once had these parameters to the
> crash hotplug handler and since they were unused at the time, you asked
> that I remove them, which I did.

Sorry to miss this mail. I thought both of you were talking about
somthing, and didn't notice this question to me.

I think there are two ways to solve the issue Sourabh raised:
1) make handle_hotplug_event() get and pass down the memory_notify as
Sourabh said, or the hp_action, mem_start|size as Eric suggested. I
have to admit I haven't carefully checked which one is better.

2) let the current code as is since it's aiming at x86 only. Later
Sourabh can modify code according to his need on ppc. This can give
satisfying why on code change each time.

I personally like the 2nd way, while also like seeing 1st one if the
code change and log is convincing to any reviewer.

> 
> To accommodate this, how about this:
> 
> static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>      unsigned long mem_start, unsigned long mem_size)
> 
> For CPU events, I would just pass zeros for mem_start/size. For memory events,
> I would pass KEXEC_CRASH_HP_INVALID_CPU.
> 
> Thanks,
> eric

