Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0368A005
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjBCRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBCRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C423841
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuz2DP65dYjCETbFIUxKt87h6CPUB+xFoYwiml2g5oc=;
        b=KurPo1DtAqKWGR1v/aYN1AGiay8crA39TAMkXm86kHfoNejdvw5TgwbAkzg4CqcfbWAsXA
        JU+6IIzAAE32EuPWupAK6B+PGgLnGYYIWrdK0QCFrmqOaQAzEzz15D1B0eEkZHggFbD0g3
        gGkwYy9xod/nIY28VULn+jcHHP6UbtY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-85XkE2zYPVGImCy71e_OXQ-1; Fri, 03 Feb 2023 12:10:30 -0500
X-MC-Unique: 85XkE2zYPVGImCy71e_OXQ-1
Received: by mail-wm1-f70.google.com with SMTP id e38-20020a05600c4ba600b003dc434dabbdso4940146wmp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuz2DP65dYjCETbFIUxKt87h6CPUB+xFoYwiml2g5oc=;
        b=MpMhzmfFlYMaDsbx248ls6aIYxEHGPrm7btX6myUR9L5KNXojw9xhuXwOyND1+kXTq
         ldKawb3plbxWcs5fPrOTxU7XdrG5ZjCi+B/iVitgYWm52mUp7M7j97AYo1hhxugKIUET
         +Pwks6TmuXXomgcCaZxQMQ9x3kdSVvYo2vvhq3uOlCpHkhpmiy64qep3TLMewBtn2qkM
         NKakHOD4vIXAz25kDwmrkwqvwj1vjkPZfRUdDHhX9WhRJJZsCGmPUQSquVaPGW5LoaCA
         IrRdigwRYbEyNkLdclkJL+orWc7eYYFEQj50EjieARKA6dbHanhY4YvyH5/JQCvzVZYu
         dVGg==
X-Gm-Message-State: AO0yUKUnpNCXGiNWeHwjvFK9IGvCKCpj5RLWhdK1sMvoEhlU5DfIFxC7
        Z6eb1n5ZAfv65mkbqmXQehKMCUD7vJqJMsuTLQYLHa7qsAoKZPZYvC04kPDdgekZskMNYAkR4sD
        /3Lq96xOamscqhBoaMdEM9P2v
X-Received: by 2002:a05:600c:cc3:b0:3dc:42d2:aeee with SMTP id fk3-20020a05600c0cc300b003dc42d2aeeemr10612942wmb.25.1675444225753;
        Fri, 03 Feb 2023 09:10:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+osovxAJGMG4BsZiC+9C1hGGUPMXH5t/s8vQX3PlweyD59D+sjA0Vy8iOz2yBZXul7+pSmuA==
X-Received: by 2002:a05:600c:cc3:b0:3dc:42d2:aeee with SMTP id fk3-20020a05600c0cc300b003dc42d2aeeemr10612925wmb.25.1675444225507;
        Fri, 03 Feb 2023 09:10:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:7900:b84d:7f2e:b638:3092? (p200300cbc7067900b84d7f2eb6383092.dip0.t-ipconnect.de. [2003:cb:c706:7900:b84d:7f2e:b638:3092])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003dd8feea827sm8055409wmc.4.2023.02.03.09.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 09:10:24 -0800 (PST)
Message-ID: <0b193743-b3ad-6e05-f6bb-ae5653fd5ef0@redhat.com>
Date:   Fri, 3 Feb 2023 18:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/4] Add overflow checks for several syscalls
To:     Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230128063229.989058-1-mawupeng1@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230128063229.989058-1-mawupeng1@huawei.com>
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

On 28.01.23 07:32, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
> The return value of mlock is zero. But nothing will be locked since the
> len in do_mlock overflows to zero due to the following code in mlock:
> 
>    len = PAGE_ALIGN(len + (offset_in_page(start)));
> 
> The same problem happens in munlock.
> 
> Add new check and return -EINVAL to fix this overflowing scenarios since
> they are absolutely wrong.
> 
> Similar logic is used to fix problems with multiple syscalls.
> 
> Changelog since v2[2]:
> - modified the way of checking overflows based on Andrew's comments
> 
> Changelog since v1[1]:
> - only check overflow rather than access_ok to keep backward-compatibility

Do you have some test cases and could we add them to LTP, for example?

-- 
Thanks,

David / dhildenb

