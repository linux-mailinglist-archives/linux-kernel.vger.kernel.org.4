Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BE661FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjAIIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjAIIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D44FCDA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673251489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVp8yLY7DCe2qLwsvuHHLAbl1dGoybQYwVuHEDJuma4=;
        b=LvmhKigEhE6/zPnIieoK1raZGBmPvTAiPcGWfyRtk0yHxjfdKInAy/idXiDA25fg0+Mej+
        hoACyeUIdXVkecP0SxvrtLW10PpuK/dUXkaiiGov0cUxjTQ7VzjKY/RA3p5nuQSAgJN0Wc
        hNvIXiw17+mSouhgxGRrX6/G2zUfj/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-drveKNWJMZ2qd2wojFtcpw-1; Mon, 09 Jan 2023 03:04:47 -0500
X-MC-Unique: drveKNWJMZ2qd2wojFtcpw-1
Received: by mail-wm1-f70.google.com with SMTP id c66-20020a1c3545000000b003d355c13229so6876844wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVp8yLY7DCe2qLwsvuHHLAbl1dGoybQYwVuHEDJuma4=;
        b=rD69jNu2Q+7f+aGlHS5sHBMySaqC0ZAhmQ4l6ewQ0sNF7ouWRuDLefaENVTBrerjko
         DNHhMdePlnTg1aSvTmWWk5MFdvc5lu08Im3+JIXaqp1maXxjttgndKlloWMx2hGHZEkO
         P8YhEsru8Vy8amJizY8OT3XnX1Ttg+NNAGfL1k8HiHRmBOvIXbpJWKonB/XCovxt0+Xl
         wvpfR481Li73v9jSgLoiF3fOIB/rkxAtMDV6rVTgsaE9yT4O45G/gh1JaQrnBI5sgB4R
         brFi6k0PbhjojuubmFRit1VAn6xy5zWYOuN5IeOmAeYhZjmrq2pWXRKl1Un+LfUmR1h3
         fOJg==
X-Gm-Message-State: AFqh2kp7qjCuit9O7Xphy64GYv+GGcI4gZc6QYNY71FQG/N/QZeEtC6r
        8zX37e9VKSgpYXKwf9PvFAKtqqb5idJuKDlHUiNwZ9mq7OXzExg4tnCa3A8zTsWqGw9EbssClgr
        s+RhOOJ3Y5BFYLvLLsi/ZEjvi
X-Received: by 2002:a05:600c:3ac3:b0:3d1:cfcb:7d19 with SMTP id d3-20020a05600c3ac300b003d1cfcb7d19mr54883745wms.32.1673251486357;
        Mon, 09 Jan 2023 00:04:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuEIbEs0BiKh6OBaBy+pLrnxzSqTb2/JpYfXaQpIO4/gJWRJT1WYGNbmyhE0+56JxjRsJNzdg==
X-Received: by 2002:a05:600c:3ac3:b0:3d1:cfcb:7d19 with SMTP id d3-20020a05600c3ac300b003d1cfcb7d19mr54883732wms.32.1673251486123;
        Mon, 09 Jan 2023 00:04:46 -0800 (PST)
Received: from [192.168.3.108] (p5b0c66da.dip0.t-ipconnect.de. [91.12.102.218])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c4e5200b003d9876aa04asm12410490wmq.41.2023.01.09.00.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:04:45 -0800 (PST)
Message-ID: <d77ecdac-3712-8d4b-57d5-f8c9e4569e6f@redhat.com>
Date:   Mon, 9 Jan 2023 09:04:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] mm/mprotect: Use long for page accountings and retval
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-3-peterx@redhat.com>
 <aabd4bb8-560b-10b0-9837-b656e1a0a9e1@redhat.com> <Y7cjir3+MpT8XqJT@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7cjir3+MpT8XqJT@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 20:22, Peter Xu wrote:
> On Thu, Jan 05, 2023 at 09:44:16AM +0100, David Hildenbrand wrote:
>> I'm wondering if we should just return the number of changed pages via a
>> separate pointer and later using an int for returning errors -- when
>> touching this interface already.
>>
>> Only who's actually interested in the number of pages would pass a pointer
>> to an unsigned long (NUMA).
>>
>> And code that expects that there never ever are failures (mprotect, NUMA)
>> could simply check for WARN_ON_ONCE(ret).
>>
>> I assume you evaluated that option as well, what was your conclusion?
> 
> Since a single long can cover both things as retval, it's better to keep it
> simple?  Thanks,
> 

Fine with me.

-- 
Thanks,

David / dhildenb

