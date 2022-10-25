Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0960C4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJYHFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiJYHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3B4A806
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666681539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fe1WZpWI0+WNHlpXUbrxZSAOPfSw/3F9thWPXoPIAVs=;
        b=AtGwgNSDpIm6obnesW0L75VfF3/OFXAOFVlnGfOlzJwPclzWBj9C642Ii5LsyTmP4n4Dru
        fLFmO7yAMl5rRXEYbCD7ehSCq5t8ixS+yi5LqHMWt29BWsjji6YpigbatbPur4npfOzw3S
        qP+yE7iQTftUUtIiMVeXfNG1od7uz9c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-B6uGGz2ANlqrM-3qyV8Hmw-1; Tue, 25 Oct 2022 03:05:37 -0400
X-MC-Unique: B6uGGz2ANlqrM-3qyV8Hmw-1
Received: by mail-wr1-f71.google.com with SMTP id h18-20020adfa4d2000000b00236584fc8c7so3642456wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe1WZpWI0+WNHlpXUbrxZSAOPfSw/3F9thWPXoPIAVs=;
        b=ff5gPjp0KxwuIIV0V2jnflhwqIeU7gMuqBcEQ7yXoku9azP6mtMAlFbkcnAu1uuHcs
         yrOhMcVmphj309/5ZRFKfE88htJdbQ9nOooBtM9lDnjv9otKZWoXACXmZqKZULbhg7l4
         DvzG/mYNz2zUspciRZhGuq/ZTn+OCSi9Wlqnjbvtdp0oJe65oJ3+1U81uHiyXaCazNWY
         RnGGED6UyzqKhVAX3WRVjMIcGumV13JVk2Wp+yfI6/nowIt/mbMlfHZ4thZtyU5uoS3C
         NWewwQgYeHl7/2y1zrg6XwM6dp3GVl6qvK8J1HDhmNWAi5aB6Y7L6dlAdX8k3GYdd6Q4
         fOkA==
X-Gm-Message-State: ACrzQf06ZuWnwub5007Ye7Y8DU8tlAE3iUh0SgbDRP52fbVezytpLecr
        dMCfCPV04AvIKzoB/tU0LWhq/N1bjRrA23bojGI9RkuHXcczHtYMX8JtxtNsY8xfMHsqj9n/MgP
        wcO5hO5t6GlnuReHS3OgvQXGQ
X-Received: by 2002:a5d:6d8a:0:b0:236:6123:a8a5 with SMTP id l10-20020a5d6d8a000000b002366123a8a5mr9839557wrs.229.1666681536432;
        Tue, 25 Oct 2022 00:05:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6vGN8RwMdOloicelrC6hCDmVpDUnXTSURyJhiGcLjlRN3taSS7ZSJOzY1mCKKolD0ZTIX/qA==
X-Received: by 2002:a5d:6d8a:0:b0:236:6123:a8a5 with SMTP id l10-20020a5d6d8a000000b002366123a8a5mr9839535wrs.229.1666681536103;
        Tue, 25 Oct 2022 00:05:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:4e00:3efc:1c60:bc60:f557? (p200300cbc70b4e003efc1c60bc60f557.dip0.t-ipconnect.de. [2003:cb:c70b:4e00:3efc:1c60:bc60:f557])
        by smtp.gmail.com with ESMTPSA id h20-20020a1ccc14000000b003b492753826sm1686070wmb.43.2022.10.25.00.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 00:05:35 -0700 (PDT)
Message-ID: <b9e88ddf-e0ac-ce81-d6b4-caf70772c455@redhat.com>
Date:   Tue, 25 Oct 2022 09:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 1/7] selftests/vm: anon_cow: test COW handling of
 anonymous memory
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
 <20220927110120.106906-2-david@redhat.com> <Y1bD+8CMzlqkbPwU@macondo>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y1bD+8CMzlqkbPwU@macondo>
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

>> +	/* See if we still read the old values via the pipe. */
>> +	for (total = 0; total < transferred; total += cur) {
>> +		cur = read(fds[0], new + total, transferred - total);
>> +		if (cur < 0)
> 
> Hi David,
> I was looking at some coccinelle reports for linux-next and
> saw the following warning for this comparison:
> 
>    WARNING: Unsigned expression compared with zero: cur < 0
> 
> I think 'cur' needs to be of type 'ssize_t' for this comparison to work.
> 
> The same warning is reported for the variable 'transferred' above, and
> also for do_test_iouring() and do_test_vmsplice_in_parent() in
> "selftests/vm: anon_cow: add liburing test cases".
> 

Thanks for reporting! Indeed, we need a signed value.

-- 
Thanks,

David / dhildenb

