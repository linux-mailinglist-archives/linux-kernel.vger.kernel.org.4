Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B887424EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjF2LXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjF2LXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B762117
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688037733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdhcgbMrVqcwBO72p4YdB+Tlm3/fEdhj6DWO3Cu42oI=;
        b=YaM8pdjjJGI3A9vmYO9b067Q4wt/KlRQKt2Kgxr2VhJjAHT26u8+dcM1hF+WwjYJRWy6gQ
        XBTUwXiG1CGkbdkC8+fn2Z7JQ86ZApkMIatTgDkDCr0ZMdKlWCN4E7Nz6nkqtqwW8yUT6G
        OIr1+K1hCGqxy+Kk8u8e5nw6pijWKCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-6FdJNWKlOGeQv1Otou5tVQ-1; Thu, 29 Jun 2023 07:22:11 -0400
X-MC-Unique: 6FdJNWKlOGeQv1Otou5tVQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so8717925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688037730; x=1690629730;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdhcgbMrVqcwBO72p4YdB+Tlm3/fEdhj6DWO3Cu42oI=;
        b=dSHUf2ydOBz4bTTHdLBjZ3oGhacRTHvDSYhCP2r3duZgH5Br92GYG45MWtELjDkDmi
         f3b+bru6VULmSi7NxUOdO2/6AoMEIwH+i5vBDm3bBRj/YTltvMf734URun4sTJTcWuWD
         j3A0ulBw699HeGf3W89bHF8N50xZ+6Jz7k9ysURMbYsmdFZL5XNQOGaMHPKwBVb9mdu7
         0Fl95KXbIviSGEGgY4JrgPUI0IZ8+IhkiILaui20AzN/0UtHyTAnkvi8vGXhCZ2WtAxa
         JRSKurc+jOrgDWTSOhDY7m3JM8NjDm8CkjxnH019QVDUVjxce+SUQcVqGZ345wWDRoI4
         zCuw==
X-Gm-Message-State: AC+VfDxbqLVVUBzNmYF3xCY8eNbbAn2rT6poqym+En+ZdTzovzwvoEnN
        a3D+ZkRfKmJachIFYc7VT0L4dG62kAdY8+otWkIfOHmzrhUhxDTui4Um3bl5K6lH9aVfYbBJ1uD
        F4MZFmA7CcT0wSAxmfamk7xmS
X-Received: by 2002:a05:600c:2041:b0:3fb:9ef1:34ef with SMTP id p1-20020a05600c204100b003fb9ef134efmr9178933wmg.37.1688037730302;
        Thu, 29 Jun 2023 04:22:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wqwgjIqNoVKiMHXKOfrLuvRz9SMghs4Sk6YyXQuWFdCux2FfsbPa2XdfcbUoqSB1b1YT5rg==
X-Received: by 2002:a05:600c:2041:b0:3fb:9ef1:34ef with SMTP id p1-20020a05600c204100b003fb9ef134efmr9178909wmg.37.1688037729942;
        Thu, 29 Jun 2023 04:22:09 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c365300b003fa8dbb7b5dsm12475267wmq.25.2023.06.29.04.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 04:22:09 -0700 (PDT)
Message-ID: <cb4d6abb-4ced-adbf-2ca1-2038795ffc27@redhat.com>
Date:   Thu, 29 Jun 2023 13:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 04/22] x86/cpu: Detect TDX partial write machine check
 erratum
To:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, ying.huang@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com,
        bagasdotme@gmail.com, sagis@google.com, imammedo@redhat.com
References: <cover.1687784645.git.kai.huang@intel.com>
 <0f701502157029989617bcb3f5940ff48e19a2b2.1687784645.git.kai.huang@intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0f701502157029989617bcb3f5940ff48e19a2b2.1687784645.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.23 16:12, Kai Huang wrote:
> TDX memory has integrity and confidentiality protections.  Violations of
> this integrity protection are supposed to only affect TDX operations and
> are never supposed to affect the host kernel itself.  In other words,
> the host kernel should never, itself, see machine checks induced by the
> TDX integrity hardware.
> 
> Alas, the first few generations of TDX hardware have an erratum.  A
> partial write to a TDX private memory cacheline will silently "poison"
> the line.  Subsequent reads will consume the poison and generate a
> machine check.  According to the TDX hardware spec, neither of these
> things should have happened.
> 
> Virtually all kernel memory accesses operations happen in full
> cachelines.  In practice, writing a "byte" of memory usually reads a 64
> byte cacheline of memory, modifies it, then writes the whole line back.
> Those operations do not trigger this problem.
> 
> This problem is triggered by "partial" writes where a write transaction
> of less than cacheline lands at the memory controller.  The CPU does
> these via non-temporal write instructions (like MOVNTI), or through
> UC/WC memory mappings.  The issue can also be triggered away from the
> CPU by devices doing partial writes via DMA.
> 
> With this erratum, there are additional things need to be done.  Similar
> to other CPU bugs, use a CPU bug bit to indicate this erratum, and
> detect this erratum during early boot.  Note this bug reflects the
> hardware thus it is detected regardless of whether the kernel is built
> with TDX support or not.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

