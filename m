Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7260E3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiJZOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiJZOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B03DC0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666796075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jRuzj8aI2I9CbJusoP/+rcWnTpr8peB8CRFVJrzDj8=;
        b=e+rJYr5JnsAEdSHO+sqs7TgNNbkpckzOXkM/r3ynanMfLwFysJN/UV2p/y6vn1tB3JeZ87
        oizkrh8v4HAXIfWNSDqauc5Dq944YYXmhFQuiO2UWtvwBymRbld9kgR7viuLvQvmMIjWQJ
        E1DKfGLKs2ubvBmn1xi6Kb0E4J9aZJw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-W7owHCuTPYaOgE8hNyiLEg-1; Wed, 26 Oct 2022 10:54:34 -0400
X-MC-Unique: W7owHCuTPYaOgE8hNyiLEg-1
Received: by mail-wr1-f72.google.com with SMTP id s11-20020adfbc0b000000b0023659af24a8so5376546wrg.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jRuzj8aI2I9CbJusoP/+rcWnTpr8peB8CRFVJrzDj8=;
        b=IHds7sY1r+iwjhWT2yyiOGkXhY+eePsztagkQYVFvS8ZRdC2XOrkkKI4KX1It/IdLk
         mz7NACvkqFl7qVZJs6KCC+5ZkE+fnHyDdvriA0TBi9gRWY5h3lU7qH1y/g86dU7iOQfX
         FkbDmgjcvU5O0JklIaOmkbLNWzd53oa+XKysBokKTNwkLI87itvnUllawkSmhua+GSRZ
         ZWr/Oh1kgMNdSwSZ5GBntLwpGp8CerOELamWg9ttiZo7mhNG5wP2V9euJOrGqw0izpBE
         WT2JLuUmKjk3ly43MuryRqLHt6va+1/mT1K0wsOvxN00mFKCkwBW7c2Ut5ueyK2Hm6ES
         IpzQ==
X-Gm-Message-State: ACrzQf2gOGxJIvutFz765oikf2IySKqIUwkJW8UxB6bjM+NSjGhox0I1
        bs1KkCImB56TeDo9zhHZdXxEMzXIWgruFBu6E/pRmF2vmm3egDBdypMN18HJE3kUPoBEG7U7ZoE
        0ynGlc6qVThHz2JfVXoW2/NOP
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr18358554wrp.180.1666796073177;
        Wed, 26 Oct 2022 07:54:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM58Oi6r6VCYZDISEQe29opH4/96LoWRdQ0kTHG43cIiSkE59tlwcXeKwFPxUQIGviW/ZHEPNw==
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr18358523wrp.180.1666796072882;
        Wed, 26 Oct 2022 07:54:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5b00:c9f4:7535:9360:70d7? (p200300cbc7065b00c9f47535936070d7.dip0.t-ipconnect.de. [2003:cb:c706:5b00:c9f4:7535:9360:70d7])
        by smtp.gmail.com with ESMTPSA id j9-20020adfe509000000b0023647841c5bsm5663674wrm.60.2022.10.26.07.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:54:32 -0700 (PDT)
Message-ID: <d2ce1bed-a053-4840-2e84-643b678392c1@redhat.com>
Date:   Wed, 26 Oct 2022 16:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic> <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic> <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic> <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
In-Reply-To: <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.22 16:48, Baoquan He wrote:
> On 10/25/22 at 12:31pm, Borislav Petkov wrote:
>> On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
>>> The concern to range number mainly is on Virt guest systems.
>>
>> And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
>> real machine?

IIRC, ACPI only allows for 256 slots. PPC dlpar might provide more.

> 
> Well, currently, mem hotpug is an important feature on virt system to
> dynamically increase/shrink memory on the system. If only emulating real
> machine, it won't be different than bare metal system.
> 
> IIRC, the ballon driver or virtio-mem feature can add memory board, e.g
> 1G, block size is 128M, 8 blocks added. When shrinking this 1G memory
> later, it will take best effort way to hot remove memory. Means if any
> memory block is occupied, it will be kept there. Finally we could only
> remove every second blocks, 4 blocks altogether. Then the left
> un-removed blocks will produce 4 separate memory regions. Like this, a
> virt guest could have many memory regions in kernel after memory
> being added/removed.
> 
> If I am wrong, Please correct me, David.

Yes, virtio-mem (but also PPC dlpar) can result in many individual 
memory blocks with holes in between after hotunplug. Hotplug OTOH, 
usually tries to "plug" these holes and reduce the total number of 
memory blocks. It might be rare that our range will be heavily 
fragmented after unplug, but it's certainly possible.

[...]

> 
> Yes, now assume we have a HPE SGI system and it has memory hotplug
> capacity. The system itself has already got memory regions more than
> 1024. Then when we hot add extra memory board, we want to include the
> newly added memory regions into elfcorehdr so that it will be dumped out
> in kdump kernel.
> 
> That's why I earlier suggested 2048 for number of memory regions.

The more the better, unless "it hurts". Assuming a single memory block 
is 128 MiB, that would be 256 GiB.

Usually, on big systems, the memory block size is 2 GiB. So 4 TiB.

-- 
Thanks,

David / dhildenb

