Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0771467C62A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjAZIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAZIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B387512F20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674722784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UJoQG8XqIV2gdZ5V2M7MUTXNJ4+fqx8kSeoZEHtCyE=;
        b=UWeGjmL6q0Sj4pkM0pHuVYZ8wDN2nuIObNTZUVp+gosFV0gHeo8IkPya9vtrqt4SqHTk0k
        fOdQjiaLdMAOhlOsW+M0n/VZqL/mGiApf7lLqabvGuC3fNPiWK2J3vfiAN5oVxxBIGWd2s
        EUn31rvMU3kiL13cwbMHLVqHYin+3DE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-3ML_jl_KNIaCeZucSFtsOA-1; Thu, 26 Jan 2023 03:46:23 -0500
X-MC-Unique: 3ML_jl_KNIaCeZucSFtsOA-1
Received: by mail-wm1-f70.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso709062wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UJoQG8XqIV2gdZ5V2M7MUTXNJ4+fqx8kSeoZEHtCyE=;
        b=qpGXHH4dyECE9hmA0c2oQRV+I7qo7dx5Kla0emgUAK/aV1Yl6pKVLRBhmj1vgwyP6T
         K0s2KovdrfGXCOcUoTPB3TiFgrb1QaYd5tvQyDZz23gR+O9owz1XPRve/3WbnP/Ot2Qr
         GOxuSp+hZ8/aIODzsYhhVAkeTeD9Af+bmuSZuyXTWUfvGRD+uNGi7wpYtibUq3n59jKN
         iHhqVxOyjgwCRFi1ZaNVZy/nbuvzGX6zXDxit0X+G3mXffaWLU0R595MMR/qS+JrKpUW
         HsbdzzUvQizEfrhxiB7R51PeQZPUoNZJfrZm83FrEjYhY7fbGlUJbUh2eBKfma2sIvPw
         VsJQ==
X-Gm-Message-State: AFqh2kq294pVTmielrthE4fnzdaj+jouTx1YrU/hgJisRxbSUGADCNCr
        0EYz8PDFRdaVQwKbC1XRByjJXkFyDsI+M3L5Ln2rgIdHMvEGm212S2WQdqllh7FDDahh6iUWUDu
        dTBVXn+l7ud56c1dA0JrtYLWy
X-Received: by 2002:a05:600c:714:b0:3d9:ed30:79d with SMTP id i20-20020a05600c071400b003d9ed30079dmr34687566wmn.18.1674722781975;
        Thu, 26 Jan 2023 00:46:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtafnDCs+MxdtjVDkOlNHLIvv1Gu+xFfV8rFc8O/8mrsHf9iNdy6mNIXFzLYO+oSkffev3lmA==
X-Received: by 2002:a05:600c:714:b0:3d9:ed30:79d with SMTP id i20-20020a05600c071400b003d9ed30079dmr34687520wmn.18.1674722781631;
        Thu, 26 Jan 2023 00:46:21 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c2e9400b003d9862ec435sm824806wmn.20.2023.01.26.00.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:46:21 -0800 (PST)
Message-ID: <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
Date:   Thu, 26 Jan 2023 09:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-19-rick.p.edgecombe@intel.com>
 <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
 <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
 <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
 <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
 <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
 <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
 <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
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

On 26.01.23 01:59, Edgecombe, Rick P wrote:
> On Wed, 2023-01-25 at 10:43 -0800, Rick Edgecombe wrote:
>> Thanks for your comments and ideas here, I'll give the:
>> pte_t pte_mkwrite(struct vm_area_struct *vma, pte_t pte)
>> ...solution a try.
> 
> Well, it turns out there are some pte_mkwrite() callers in other arch's
> that operate on kernel memory and don't have a VMA. So it needed a new

Why not pass in NULL as VMA then and document the semantics? The less 
similarly named but slightly different functions, the better :)

-- 
Thanks,

David / dhildenb

