Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429936ADC42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCGKpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjCGKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:45:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD459E9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678185859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDXgYZBLxUfMsLcw1qS/eHbSsPTT2QidbprcFoL7C7U=;
        b=Pqhe3oKKsS6WmJevHfVMg4Blt/yKUv6GztwV5b1p9DwYqLlaPKs3BCO+gmr3faE78SFZo4
        PvuBpEmj+DkzEDf+Y7T6llD+4lgg8Cyn80B2LUt7mwMnhHArV9XICs9ZQIvHde9OaNIDBe
        YfPmhXHAdXENck0XsH937P8zYvH4rl0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-JreZs3DTNGKDOa-LHDQCgA-1; Tue, 07 Mar 2023 05:44:06 -0500
X-MC-Unique: JreZs3DTNGKDOa-LHDQCgA-1
Received: by mail-wm1-f69.google.com with SMTP id e22-20020a05600c219600b003e000facbb1so8071143wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678185846;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDXgYZBLxUfMsLcw1qS/eHbSsPTT2QidbprcFoL7C7U=;
        b=H3jm+ifdx9vVcYIQ3BiDFww4EPd5GuJLOPzeCQ8T4K+kZdwUXyVUZlJyNXieup0XS2
         4Mig28ky2gjQgLEaVkwF5wbpiQitbTAvuuadMnbcbIY5uPlafSbmTFOn+QjYB42Pkfql
         9DT6TyOuDceDIZBAhSs0jgh1TBIc9r6XfbmrlwxKHhjU6X04jDip1qezFAvjAhmDF43y
         973aXedGL/aPucWiHK5e63J/KD12snCwo4OOgE/qwJOw4mZwCa3gH41JOlYhqEOMJakq
         cyfdMBEwGZqGnLhRrpiq2jlPk5Lxwd9r5EJzWCxJ+/AhDBSUw/i58HHkEYPfN0TU8WA/
         v3Zg==
X-Gm-Message-State: AO0yUKUZr15uc6Dbhz/+mvg9nl4GRXhoX6PWw/BJLZKrnwii0Bv2qET3
        acYQkShj/aw1yWf0CjLOSefhzCti9abQFLYfKXVAeRO0PDu8C8JktfU3IuSnln9LasdFDNi2F2g
        ipS03rbcrnGmRiS49Pd/4uESp
X-Received: by 2002:a5d:624a:0:b0:2c8:42b5:8022 with SMTP id m10-20020a5d624a000000b002c842b58022mr6952087wrv.59.1678185845833;
        Tue, 07 Mar 2023 02:44:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8rPLXlJpSgekHE+458YNHtAM8ubtbpYEdRQYCtKzuI4JLsz2YQyUNjVRF4VCLQBPbLMtbcAg==
X-Received: by 2002:a5d:624a:0:b0:2c8:42b5:8022 with SMTP id m10-20020a5d624a000000b002c842b58022mr6952069wrv.59.1678185845517;
        Tue, 07 Mar 2023 02:44:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002c7163660a9sm12202423wru.105.2023.03.07.02.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:44:05 -0800 (PST)
Message-ID: <f31108e7-c862-ace7-23b2-82ae9376ad38@redhat.com>
Date:   Tue, 7 Mar 2023 11:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-22-rick.p.edgecombe@intel.com>
 <ZAWfZcJLXUfNt1Fs@zn.tnic>
 <f91bbe94b51c0855da921a770685aa17c06c8beb.camel@intel.com>
 <20230307103251.GAZAcS0zpon573Ox3N@fat_crate.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230307103251.GAZAcS0zpon573Ox3N@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.23 11:32, Borislav Petkov wrote:
> On Tue, Mar 07, 2023 at 01:29:50AM +0000, Edgecombe, Rick P wrote:
>> On Mon, 2023-03-06 at 09:08 +0100, Borislav Petkov wrote:
>>> Just typos:
>>
>> All seem reasonable to me. Thanks.
>>
>> For using the log verbiage for the comment, it is quite big. Does
>> something like this seem reasonable?
> 
> Yeah, it does. I wouldn't want to lose that explanation in a commit
> message.
> 
> However, this special aspect pertains to the shstk implementation in x86
> but the code is generic mm and such arch-specific comments are kinda
> unfitting there.
> 
> I wonder if it would be better if you could stick that explanation
> somewhere in arch/x86/ and only refer to it in a short comment above
> VM_SHADOW_STACK check in stack_guard_start_gap()...

+1

-- 
Thanks,

David / dhildenb

