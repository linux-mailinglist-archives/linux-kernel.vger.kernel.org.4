Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191B60F9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiJ0Nwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiJ0Nwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C581D16655D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666878747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3Fq153B9PaKBw4UwH16xPw9HcajjAUr3ziTEO7//xc=;
        b=i0fZ9H/VN0NCfDQeh3kwUFgsVilXjUVXuWUP31Fb22fZ3ydpYMvGixM5gvgphRuwjWB5d0
        j+pNMJfx35H2ahK/3M8ShrQgGtOmsKdJj+ArRQurAE+876DperyLVUgm4zdsvgAYUKegyR
        XJTZ8Ot+KdcGCckNcY/J3T77CBqqC3o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-rzb8YtayMOebD4r3zSmchA-1; Thu, 27 Oct 2022 09:52:24 -0400
X-MC-Unique: rzb8YtayMOebD4r3zSmchA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 646E32A59558;
        Thu, 27 Oct 2022 13:52:22 +0000 (UTC)
Received: from localhost (ovpn-12-121.pek2.redhat.com [10.72.12.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8429F403162;
        Thu, 27 Oct 2022 13:52:08 +0000 (UTC)
Date:   Thu, 27 Oct 2022 21:52:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Eric DeVolder <eric.devolder@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1qNBDY99Ypan9Ok@MiWiFi-R3L-srv>
References: <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <d2ce1bed-a053-4840-2e84-643b678392c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ce1bed-a053-4840-2e84-643b678392c1@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 at 04:54pm, David Hildenbrand wrote:
> On 26.10.22 16:48, Baoquan He wrote:
> > On 10/25/22 at 12:31pm, Borislav Petkov wrote:
> > > On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
> > > > The concern to range number mainly is on Virt guest systems.
> > > 
> > > And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
> > > real machine?
> 
> IIRC, ACPI only allows for 256 slots. PPC dlpar might provide more.
> 
> > 
> > Well, currently, mem hotpug is an important feature on virt system to
> > dynamically increase/shrink memory on the system. If only emulating real
> > machine, it won't be different than bare metal system.
> > 
> > IIRC, the ballon driver or virtio-mem feature can add memory board, e.g
> > 1G, block size is 128M, 8 blocks added. When shrinking this 1G memory
> > later, it will take best effort way to hot remove memory. Means if any
> > memory block is occupied, it will be kept there. Finally we could only
> > remove every second blocks, 4 blocks altogether. Then the left
> > un-removed blocks will produce 4 separate memory regions. Like this, a
> > virt guest could have many memory regions in kernel after memory
> > being added/removed.
> > 
> > If I am wrong, Please correct me, David.
> 
> Yes, virtio-mem (but also PPC dlpar) can result in many individual memory
> blocks with holes in between after hotunplug. Hotplug OTOH, usually tries to
> "plug" these holes and reduce the total number of memory blocks. It might be
> rare that our range will be heavily fragmented after unplug, but it's
> certainly possible.
> 
> [...]
> 
> > 
> > Yes, now assume we have a HPE SGI system and it has memory hotplug
> > capacity. The system itself has already got memory regions more than
> > 1024. Then when we hot add extra memory board, we want to include the
> > newly added memory regions into elfcorehdr so that it will be dumped out
> > in kdump kernel.
> > 
> > That's why I earlier suggested 2048 for number of memory regions.
> 
> The more the better, unless "it hurts". Assuming a single memory block is
> 128 MiB, that would be 256 GiB.
> 
> Usually, on big systems, the memory block size is 2 GiB. So 4 TiB.

Thanks a lot for these valuable inputs, David.

Hi Boris, Eric

So what's your suggested value for the Kconfig option?

1) cpu number, 1024?
2) memory regions, 2048?

About below draft, any comment? We can decide a value based on our
knowledge, can adjust later if any real system has more than the number.

+config CRASH_ELF_CORE_PHDRS_NUM
+       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+       int
+       default 3072
+       help
+         For the kexec_file_load path, specify the default number of
+         phdr for the vmcore. E.g the memory regions represented by the
+         'System RAM' entries in /proc/iomem, the cpu notes of each
+         present cpu stored in /sys/devices/system/cpu/cpuX/crash_notes.

Thanks
Baoquan

