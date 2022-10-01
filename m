Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE215F1ADD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJAINv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 04:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJAINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 04:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE547195D4A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664612028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M08d8mMJzKqyE4XeCsUdHwS/W+NoO/HZQNW27SDN4Bo=;
        b=IR/tQhJYyd5VNd+9o0Fw19pll5MA2zN42Db+V28NYLOwEgKSUgJUmlftAGWtAchnoHcTMB
        l+i7OM/KMsDeMMxsnVbxTCU1P1b1P4N5wrS5KhAY2o+8RhiAJvmtQCaurjYqbfeak6X/Ut
        Im/8LdrG049tU7xbDL3Goasy+LiQZhc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-QV2OgjEuOoKdN6Ur7GbZVg-1; Sat, 01 Oct 2022 04:13:44 -0400
X-MC-Unique: QV2OgjEuOoKdN6Ur7GbZVg-1
Received: by mail-wm1-f71.google.com with SMTP id g8-20020a05600c4ec800b003b4bcbdb63cso3190264wmq.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 01:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=M08d8mMJzKqyE4XeCsUdHwS/W+NoO/HZQNW27SDN4Bo=;
        b=Iwxk1OpUc6YmgjV/n46XbK+gdvQ5UikN1OUBIs6mLzQUiIo3o6qlI+oRIYsCNvFJ0L
         wwDVA6z9NLIISVVxxxMeYj3h32b65Jn7w8hZKnAZ9QLm73N7A4EF0l26ND3+2qIaz9VK
         tRrKO5RYzhbVkfRQpdoz8yH0I2deBKlP9mThdrpea8/prWsoFBg29WV2O/onJncZaagk
         vsuRTFGKllW6h5B8TiwHMQN8MEtTxnHkcYwRbLYcZ2rtGhUFcY7L7Nu+t1Ft9/zgNVHM
         jGfTDYvRT3USDIlRchKZyqhn1KZqr7qH/tjG0aWnF1/cPWoaxs0Bw+iktRN+HziYSROx
         XaZw==
X-Gm-Message-State: ACrzQf0wyKfpvz4a1SIEDSuef4vKtycMoqL9qK+qopXzLm3kVeYP6WU0
        bM7sICpWYUmbZtoW5rJdHMdvxGolrMguH/ZQ8OcifuIE8iOxpvlTlK5VMrNC2QwMfObggVa8aTy
        p2mdjFAxuF/ro5vR/1FWITcdI
X-Received: by 2002:a5d:414c:0:b0:22c:de8a:d233 with SMTP id c12-20020a5d414c000000b0022cde8ad233mr5789664wrq.194.1664612023734;
        Sat, 01 Oct 2022 01:13:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM59J3GMiF+4a1a0pX2sMbyZVeGafvQfLvRP8m46tATdItS6jpn5p/0CVb+9uH6Ql4pCwB6UDw==
X-Received: by 2002:a5d:414c:0:b0:22c:de8a:d233 with SMTP id c12-20020a5d414c000000b0022cde8ad233mr5789640wrq.194.1664612023379;
        Sat, 01 Oct 2022 01:13:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:300:9aa5:eac5:37df:f14? (p200300cbc71e03009aa5eac537df0f14.dip0.t-ipconnect.de. [2003:cb:c71e:300:9aa5:eac5:37df:f14])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d5148000000b0022e04bfa661sm3010049wrt.59.2022.10.01.01.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 01:13:43 -0700 (PDT)
Message-ID: <e9d19ba0-2a92-02a1-3f1f-e21f65d2a3c5@redhat.com>
Date:   Sat, 1 Oct 2022 10:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp
 via FAULT_FLAG_UNSHARE
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-5-david@redhat.com>
 <20220930152742.55ee9c25b89ba483ec211be8@linux-foundation.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930152742.55ee9c25b89ba483ec211be8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.22 00:27, Andrew Morton wrote:
> On Fri, 30 Sep 2022 16:19:28 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's stop breaking COW via a fake write fault and let's use
>> FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
>> write fault, such as mapping the PTE writable and marking the pte
>> dirty/softdirty.
>>
>> Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
>> page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
>> will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
>> The warning in dmesg indicates this wrong handling:
> 
> We're at -rc7.  I'd prefer to avoid merging larger patchsets at this
> time.

Yes, this is 6.1 material.

> 
> Is there some minimal fix for 6.0 and -stable?  Or is the problem
> non-serious enough to only fix it in 6.1 and later?
> 

See the end of this lengthy patch description:

"This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
fault was always questionable. As this fix is not easy to backport and 
it's not very critical, let's not cc stable."

This can wait, thanks!

-- 
Thanks,

David / dhildenb

