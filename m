Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1F74ED69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGKL4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGKL4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76F11D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689076552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9QndkvGX+ralMYrK4vSVmQjm+CR9QG8JZocEr1mbjrI=;
        b=d/f4DSnVyPPUijWL5k+LweWOk505S9B9v/SzltEfAaILXdw5R44b/mNmi7YVoOv4qb6uzK
        QgufYT4vBOCDTTk+r05FQgIY40yNWU8NhAWbA4QoyYPkN+NKStSrbycT7ZLuRrbdt/R1aR
        JiWTBLd+VLmJBhv75gVXUKLHiA3vPDA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-ElwcVVxyOSGilPdSdC8jsA-1; Tue, 11 Jul 2023 07:55:51 -0400
X-MC-Unique: ElwcVVxyOSGilPdSdC8jsA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbdd5d09b8so37860865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076550; x=1691668550;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QndkvGX+ralMYrK4vSVmQjm+CR9QG8JZocEr1mbjrI=;
        b=Jd99P2baQ7qNYvPk4Kv5jJXERQPYkbWSC1nAYMT1Xo3as8ysW9ClzNLIcmP2UbG1Xw
         7Mt+38wSi0rfYcFUekXjiTwA3WOjAkl0Hu9iiN4QeqUNPjVb9jFh27NgFaoX/7yfn/DS
         YA4IXjf7CyD2aEHBoxMfQzFpt8G80LvwLAv/sFru3hyqr+q1TD6R0BcwNcUtSOIxr8p0
         p8lQo93mSpwKkPpCcpbx0mygRaU/xXgBHT89PWgGIPipFF9Q6Irdbzme59sEHJds9w0D
         gXdymWtLdfKjbxpfem1L/DoFhE9/t+CXoMjNgPvv/rPTi+kxKrBTzReOB77COw47e02l
         4z/w==
X-Gm-Message-State: ABy/qLYDmBbzJswRgi+3lfyhVUbl+ZLK7ySNUETl3WO9zM8R9f99EIYB
        t2VMVJzB71u5KMhzqKXQEIpNqrrkjSjYgaaG3wvrvnxrd0q2hnglmZbGrOOsbo3c6Q3EhuWxYmL
        9APt10L3nqRdmIFTXAZYDcUD8
X-Received: by 2002:a5d:4d0b:0:b0:313:e20c:b8e0 with SMTP id z11-20020a5d4d0b000000b00313e20cb8e0mr15606183wrt.23.1689076550481;
        Tue, 11 Jul 2023 04:55:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFURy1zSr3Q0gRDkNXbN9SbMZxA7dXq7h/P+2X/BOQ2s5vHiGIIPZobjuUfNduFocMFb0gDpA==
X-Received: by 2002:a5d:4d0b:0:b0:313:e20c:b8e0 with SMTP id z11-20020a5d4d0b000000b00313e20cb8e0mr15606169wrt.23.1689076550073;
        Tue, 11 Jul 2023 04:55:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d? (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de. [2003:cb:c745:4000:13ad:ed64:37e6:115d])
        by smtp.gmail.com with ESMTPSA id y11-20020a05600c364b00b003f90b9b2c31sm12817954wmq.28.2023.07.11.04.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:55:49 -0700 (PDT)
Message-ID: <3abfb722-a0c1-dcad-55f9-dfff7167c501@redhat.com>
Date:   Tue, 11 Jul 2023 13:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 12/22] x86/virt/tdx: Allocate and set up PAMTs for
 TDMRs
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Shahar, Sagi" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Gao, Chao" <chao.gao@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <cover.1687784645.git.kai.huang@intel.com>
 <85ea233226ec7a05e8c5627a499e97ea4cbd6950.1687784645.git.kai.huang@intel.com>
 <68a8cba5-55b6-4c8a-f4e6-d528fc839285@redhat.com>
 <4fe54e141ec5040300d0e2552ea31b83aa947ec2.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4fe54e141ec5040300d0e2552ea31b83aa947ec2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 13:49, Huang, Kai wrote:
> On Tue, 2023-07-11 at 13:42 +0200, David Hildenbrand wrote:
>>> -		ret = add_tdx_memblock(tmb_list, start_pfn, end_pfn);
>>> +		ret = add_tdx_memblock(tmb_list, start_pfn, end_pfn, nid);
>>>     		if (ret)
>>>     			goto err;
>>
>> Why did you decide to defer remembering the nid as well? I'd just move
>> that part to the patch that adds add_tdx_memblock().
> 
> Thanks for the review.
> 
> The @nid is used to try to allocate the PAMT from local node.  It only gets used
> in this patch.  Originally (in v7) I had it in patch 09 but Dave suggested to
> move to this patch (see the first comment in below link):
> 
> https://lore.kernel.org/lkml/8e6803f5-bec6-843d-f3c4-75006ffd0d2f@intel.com/

Okay, thanks.

-- 
Cheers,

David / dhildenb

