Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E46A9376
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCCJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCCJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8455E16333
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677834758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diiZnVMr8b/A9vIWJcFfLTaFlBZL4exAauuE5szboe0=;
        b=g4e71eheaaOA5FeN7zdnLUR9RgR3dW9LHHFZRH/6cMhEX3Urzkxw5d7Powb9XxbRyZaNyt
        I0OwWO8Q0hZkq4IbVOwi35vd+cj0JU8C20NhRgDnvh/+hmnXbtYGtU7m9tAhg/bFI9LGqp
        fOXJQ0oxC5OwDJNmSQUuCAmH7b1tEbU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-iMRyIz8aPkSBdkUz_SNQOw-1; Fri, 03 Mar 2023 04:12:29 -0500
X-MC-Unique: iMRyIz8aPkSBdkUz_SNQOw-1
Received: by mail-wr1-f72.google.com with SMTP id n4-20020a5d5984000000b002c3b562d76cso276913wri.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diiZnVMr8b/A9vIWJcFfLTaFlBZL4exAauuE5szboe0=;
        b=p6nyyvm7PfMEijvVMnW5zGFUmWBwFKNWi93StHg92j0bRS/E/4mpwdwYaF+txhBYwc
         D+9o1QeVj7Ufh0qa0VcLTXFlgem9FQeOP6fnPeUNGOtoYycxrVMahUA9cuksRbw/dxfO
         sYSQhkc5rn37W98B2h5Odro3MRG3A6dm95kaj0Tl3oMGJh8a6hivtVeXVsr24J+FnKXZ
         hnJM5wqXZwwpWqrppHpOLxirkHZvJ3wcSNNVzLXovaBYGHPF4/DYude4SU9duXI/NMIZ
         oH1G6CSRpm79mFTGnGhEU42b5/RPaLJLUXbKCzhTylZsi/XdGE1RO1DK3F02hm5QmiE5
         eEUA==
X-Gm-Message-State: AO0yUKXrpdfNqQXrbBlIoVAqsHcxg+tmqFu/YyvVSglvPmBs7vA5Anv6
        P9Y0WTXndcBa1geXTruCvAma7yFfPHlkdTGgdbWfWNrupJig1n8IdD5hXAKOgbf5BX/jE/NbW3A
        l9k6BPYXMaXBE354ZPERyIHIh
X-Received: by 2002:a05:600c:3d8b:b0:3eb:578d:ded3 with SMTP id bi11-20020a05600c3d8b00b003eb578dded3mr988688wmb.35.1677834748714;
        Fri, 03 Mar 2023 01:12:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/2X/IvD4wWUBDZ1RCOWDV+faB/i50fS3oD5MftAKmVpoWiUXRDlLoLhlVQ5XjwZM3nGeHGyw==
X-Received: by 2002:a05:600c:3d8b:b0:3eb:578d:ded3 with SMTP id bi11-20020a05600c3d8b00b003eb578dded3mr988674wmb.35.1677834748407;
        Fri, 03 Mar 2023 01:12:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6100:f5c9:50a5:3310:d8ac? (p200300cbc7026100f5c950a53310d8ac.dip0.t-ipconnect.de. [2003:cb:c702:6100:f5c9:50a5:3310:d8ac])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c091d00b003dc521f336esm1824544wmp.14.2023.03.03.01.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:12:27 -0800 (PST)
Message-ID: <95b0a3dd-b6f9-0305-759c-b715359b0cab@redhat.com>
Date:   Fri, 3 Mar 2023 10:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] mm/userfaultfd: propagate uffd-wp bit when PTE-mapping
 the huge zeropage
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
References: <20230302175423.589164-1-david@redhat.com> <ZAEjXqNH+U8p9fOG@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZAEjXqNH+U8p9fOG@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 23:29, Peter Xu wrote:
> On Thu, Mar 02, 2023 at 06:54:23PM +0100, David Hildenbrand wrote:
>> Currently, we'd lose the userfaultfd-wp marker when PTE-mapping a huge
>> zeropage, resulting in the next write faults in the PMD range
>> not triggering uffd-wp events.
>>
>> Various actions (partial MADV_DONTNEED, partial mremap, partial munmap,
>> partial mprotect) could trigger this. However, most importantly,
>> un-protecting a single sub-page from the userfaultfd-wp handler when
>> processing a uffd-wp event will PTE-map the shared huge zeropage and
>> lose the uffd-wp bit for the remainder of the PMD.
>>
>> Let's properly propagate the uffd-wp bit to the PMDs.
> 
> Ouch.. I thought this was reported once, probably it fell through the
> cracks.

Yes, I reported it a while ago, but our understanding back then was that 
primarily MADV_DONTNEED would trigger it (which my reproducer back then 
did), and e.g., QEMU would make sure to not have concurrent 
MADV_DONTNEED while doing background snapshots.

I realized only yesterday when retesting my patch that that a simple 
unprotect is already sufficient to mess it up.

> 
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

