Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3FB6777CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjAWJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjAWJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:51:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D922006
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674467419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSYxORSo5fJ20pO0AdfHiuiQJWJRfHcLYdctAQzz20k=;
        b=Dz2nLKA8GY/EPzPmch6HsB6iraZlDcr6Zv5uPDbcIIWRNu6oOfXENh9xFyzpmVA2CKM106
        BNaJeVoZhgvJR7imU771teJf4vAz/6KCkFpIyi6qtidZDlXwKTK3iAcMFP9QW+VR9a5Dru
        qcBN7nh0Kf5aHudvwoOozfX/W+visV8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-194-tCeHUOQGO5u_ttxFTF_ZTQ-1; Mon, 23 Jan 2023 04:50:16 -0500
X-MC-Unique: tCeHUOQGO5u_ttxFTF_ZTQ-1
Received: by mail-wm1-f71.google.com with SMTP id o5-20020a05600c4fc500b003db0b3230efso9152545wmq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSYxORSo5fJ20pO0AdfHiuiQJWJRfHcLYdctAQzz20k=;
        b=nsFP/fmbM4Bys81AbcXomz3rY6+TPZ2nDo9mCUbm5E3JtMx6sPhneETLnOd8DjdYSh
         Z0I1tSFmjTdu7T1UOnXyDBBwviRIpPWiNMy6mSbqI/tHbo8b3WdLO8F0IlUJiHabLSuG
         AjP+E18XgwuPMQ++mcdQu4To5zEpcOTENEYqxZptFYdD9aGZWwN4veU2p6giWl1yPOoe
         DQZ5us1BLMi1FfP2rhfhuwuUHNfvjiS2CeM5zSHgPgyytPwOKxQ0VuyhEUxRJ679O4PL
         dWwBubHwlm00IAoxEz3XLSe2S3L2Pb0tkYAbEKMe4TWJOOODK/NNU3k0MPHxkRjvMC9M
         cLCA==
X-Gm-Message-State: AFqh2kp73+x6IC6gIEHmzF125++9SkN3+bqsfUom1WwGtQG0/WQCwmFQ
        V5fqWjwbU2tGiB+a+2V0PLMBekp6u3TiI56ZQKAXLui/43pwZLcyL9KT+2j/6x7+4FbA3NDvC/X
        8n/TY2Gtej2syEVaj9mGxNGU/
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr23576048wms.13.1674467415688;
        Mon, 23 Jan 2023 01:50:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9yQJkaBPo8s7D1+JPWykvhgcJBeDr0ywpOXES22KIpL3qQHqi+WIix769Us7mHmdo/CB66w==
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr23576006wms.13.1674467415336;
        Mon, 23 Jan 2023 01:50:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c7401000000b003b3307fb98fsm10069782wmc.24.2023.01.23.01.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:50:14 -0800 (PST)
Message-ID: <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
Date:   Mon, 23 Jan 2023 10:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-19-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
In-Reply-To: <20230119212317.8324-19-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.23 22:22, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Since shadow stack memory can be changed from userspace, is both
> VM_SHADOW_STACK and VM_WRITE. But it should not be made conventionally
> writable (i.e. pte_mkwrite()). So some code that calls pte_mkwrite() needs
> to be adjusted.
> 
> One such case is when memory is made writable without an actual write
> fault. This happens in some mprotect operations, and also prot_numa faults.
> In both cases code checks whether it should be made (conventionally)
> writable by calling vma_wants_manual_pte_write_upgrade().
> 
> One way to fix this would be have code actually check if memory is also
> VM_SHADOW_STACK and in that case call pte_mkwrite_shstk(). But since
> most memory won't be shadow stack, just have simpler logic and skip this
> optimization by changing vma_wants_manual_pte_write_upgrade() to not
> return true for VM_SHADOW_STACK_MEMORY. This will simply handle all
> cases of this type.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---

Instead of having these x86-shadow stack details all over the MM space, 
was the option explored to handle this more in arch specific code?

IIUC, one way to get it working would be

1) Have a SW "shadowstack" PTE flag.
2) Have an "SW-dirty" PTE flag, to store "dirty=1" when "write=0".

pte_mkwrite(), pte_write(), pte_dirty ... can then make decisions based 
on the "shadowstack" PTE flag and hide all these details from core-mm.

When mapping a shadowstack page (new page, migration, swapin, ...), 
which can be obtained by looking at the VMA flags, the first thing you'd 
do is set the "shadowstack" PTE flag.

-- 
Thanks,

David / dhildenb

