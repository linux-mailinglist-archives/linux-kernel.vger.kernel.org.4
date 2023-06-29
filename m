Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B554A7424F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjF2L0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjF2L02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39D2703
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688037936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLZjhPSDs2jbUkWMScvhL09+fVbydjxBxx9PxiM4n5E=;
        b=FPl+msnxJ3maJydOo3fl/x6TC/MHbwYkSbj/WQYRGw+zqSF0QNdEr0h11EDNZ8djKGrXr2
        PzcUgBVMuEyt2T3zYhoc+2Cd8+IjOZ/ZPcrnHLFdF++T9a9dkNbxW4NzfWdWr4KH27fTha
        Ge4mXDuL6AT5X7Oxx12mlZJgHKEVxHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-c1sL2QNUP-mpzCH-Thbuvw-1; Thu, 29 Jun 2023 07:25:32 -0400
X-MC-Unique: c1sL2QNUP-mpzCH-Thbuvw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa8cd898e0so3205365e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688037931; x=1690629931;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLZjhPSDs2jbUkWMScvhL09+fVbydjxBxx9PxiM4n5E=;
        b=DroieXBzQhMc8tHzjADBrx+7YkJ7eBDVxm1sX+lGGMNsWsB7AI9zD9xrZs2j84LJ+O
         9pqeM+Pt3iQDiGpZ2qXDzxEvZbZZoHzbRCE1m8ljqA8HEK3AE5829WeUFwjhe9hoNT4Q
         +dBQOHmg00jKW07HsUEM8KhFFPZj6YnErgzNQz1MLfHlb5eGWX8/4u1Q7Ex2+uWXasgR
         c/Tja+IxgzX9+DFPj0Gi3NYJ05UtgBhpQQ1S+guunqiB5Bl99G7GtVw7cDO6jSYodtER
         wsjr21ODKz6cECn4TdqmQfopLI9yWSO8fBjrubEsmzK+NWh7gYYf0CQ2N439s60DFdb+
         AJTw==
X-Gm-Message-State: AC+VfDw19H+pHpNYY3O2OXBcXYSd2/vjh7IBlRL6fusRhk11edjlmtwz
        SzK6zirzrzsqD1v5pUHJVhRlNhOVslLTw1FcuRIwf9OoQkdf+PzxNwDnvuX6qxa5pQsExdGDXyJ
        BWKsVAzKSt507J9NOoYQEKp9T0AScIyuX
X-Received: by 2002:a7b:c459:0:b0:3fa:9538:963e with SMTP id l25-20020a7bc459000000b003fa9538963emr10234815wmi.36.1688037931810;
        Thu, 29 Jun 2023 04:25:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ628Q4gxMxKyLmVOvyUnZ4boNo/9yvt5+6bcsHZz9c7sCmO6cfmesV2vUoXvwer0wrC4vP+Ww==
X-Received: by 2002:a7b:c459:0:b0:3fa:9538:963e with SMTP id l25-20020a7bc459000000b003fa9538963emr10234783wmi.36.1688037931438;
        Thu, 29 Jun 2023 04:25:31 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c284a00b003fbac7b52dfsm5338520wmb.3.2023.06.29.04.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 04:25:30 -0700 (PDT)
Message-ID: <ca300ab2-7100-2162-4a2c-da4175c1d306@redhat.com>
Date:   Thu, 29 Jun 2023 13:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 05/22] x86/virt/tdx: Add SEAMCALL infrastructure
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Gao, Chao" <chao.gao@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shahar, Sagi" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <cover.1687784645.git.kai.huang@intel.com>
 <b2a875fd855145728744617ac4425a06d8b46c90.1687784645.git.kai.huang@intel.com>
 <ZJukd/bnkffgsQzT@chao-email>
 <7c4b54cbbb887a3b7e468819a2cf11f7434674cc.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7c4b54cbbb887a3b7e468819a2cf11f7434674cc.camel@intel.com>
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

>> then the code becomes self-explanatory. i.e., you can drop the comment.
> 
> If using this, I ended up with below:
> 
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -23,6 +23,8 @@
>   #define TDX_SEAMCALL_GP                        (TDX_SW_ERROR | X86_TRAP_GP)
>   #define TDX_SEAMCALL_UD                        (TDX_SW_ERROR | X86_TRAP_UD)
>   
> +#define TDX_SUCCESS           0
> +
> 
> Hi Kirill/Dave/David,
> 
> Are you happy with this?

Yes, all sounds good to me!

-- 
Cheers,

David / dhildenb

