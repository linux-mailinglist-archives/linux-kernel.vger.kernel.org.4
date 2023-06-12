Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3172BBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjFLJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjFLJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4E55A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686561165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NMvLsGaoAc+ApiQBDtCmSAApQPFNCHvp0vvUyzH0to=;
        b=LhwWz4DihErEGOVkW/bVdbmQHPsqLLSyvMpZ8twCtBvUeJeT3Y3vLwtonAvjynfgo6tNjD
        Dt9y2tHrdr+eSNI6by0W/fDbqGWtdwMxeySti217jRdofioSCxS1H/ebayo8LM6EWyJxKZ
        5PbarXvgt6Gj/7LjRfKzhBLUUBeiVqk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-e1BqWPDWNgOuE87BtCHfFg-1; Mon, 12 Jun 2023 05:12:41 -0400
X-MC-Unique: e1BqWPDWNgOuE87BtCHfFg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f6461620fcso2947092e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561159; x=1689153159;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NMvLsGaoAc+ApiQBDtCmSAApQPFNCHvp0vvUyzH0to=;
        b=Iz925agxGPK9vvfjE9hRIQa0oDB8++fx47kYgNb2i4+YsDIDURwTZw+Zgz0j8L+Niw
         hu3by5narWcPNy+nKvaDdNrRBbUd7ODwlYuCsS8p5HcTtNrbEppb33fK0eSH076MH3SX
         bX36yUK7jMOQthyJD+ipvrTWSE1uhiZH0VEAjaqpaenVCeuCme9ikRytXnikUr2xeEyf
         ZBAZT3rrAPWXGuANZ6Uju2TZCTqbUTxL2qp1e5W6xSaaP3xi9zdXxWw/WiTlX0tOwSMT
         H4UU3akt626bSzmv+oHFVYjX1vfqHqNVBjbRyodiHMrWmN8Ui1rM2Bke2uz6ielEL6h6
         Q++w==
X-Gm-Message-State: AC+VfDw3/7UoRpOR3T2sVnNPZmsPs2YxRJE+BpGhus6KLdbpIo8OeiuJ
        LZhLa3A5cSf2U+C67mgCnXvW/y0NkayXtntt98Ns3ibnfVPQYg0aLURuMToTTaHQNoTnzG5ZUgS
        B/7CDBoMLD3oCyEUFsLNWaKBW
X-Received: by 2002:a19:5059:0:b0:4e9:59cd:416c with SMTP id z25-20020a195059000000b004e959cd416cmr3429811lfj.0.1686561159758;
        Mon, 12 Jun 2023 02:12:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ObVeJndaNY6Sp9QSQya6Q8InTnThpLB6JyNIT69cgIZg/6pZhGlyZLEWmcgAPJaq7qpRaTQ==
X-Received: by 2002:a19:5059:0:b0:4e9:59cd:416c with SMTP id z25-20020a195059000000b004e959cd416cmr3429790lfj.0.1686561159386;
        Mon, 12 Jun 2023 02:12:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003f7febc8fb8sm10775635wmj.34.2023.06.12.02.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:12:38 -0700 (PDT)
Message-ID: <fd1c3a84-d3e6-906f-57b0-25eae0933b68@redhat.com>
Date:   Mon, 12 Jun 2023 11:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: hugetlb: Add Kconfig option to set default
 nr_overcommit_hugepages
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <88fc41edeb5667534cde344c9220fcdfc00047b1.1686359973.git.josh@joshtriplett.org>
 <71834e10-098c-7d15-b9d4-36d33a57499c@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <71834e10-098c-7d15-b9d4-36d33a57499c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.23 07:20, David Rientjes wrote:
> On Fri, 9 Jun 2023, Josh Triplett wrote:
> 
>> The default kernel configuration does not allow any huge page allocation
>> until after setting nr_hugepages or nr_overcommit_hugepages to a
>> non-zero value; without setting those, mmap attempts with MAP_HUGETLB
>> will always fail with -ENOMEM. nr_overcommit_hugepages allows userspace
>> to attempt to allocate huge pages at runtime, succeeding if the kernel
>> can find or assemble a free huge page.
>>
>> Provide a Kconfig option to make nr_overcommit_hugepages default to
>> unlimited, which permits userspace to always attempt huge page
>> allocation on a best-effort basis. This makes it easier and more
>> worthwhile for random applications and libraries to opportunistically
>> attempt MAP_HUGETLB allocations without special configuration.
>>
>> In particular, current versions of liburing with IORING_SETUP_NO_MMAP
>> attempt to allocate the rings in a huge page. This seems likely to lead
>> to more applications and libraries attempting to use huge pages.
>>
>> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> 
> Why not do this in an initscript?
> 
> Or, if absolutely necessary, a kernel command line parameter?
> 
> A Kconfig option to set a default value to be ULONG_MAX seems strange if
> you can just write the value to procfs.
> 

Agreed, not to mention that huge pages in some environment can cause 
trouble (some architectures -- or with gigantic huge pages --  don't 
support huge page migration and you can run into trouble with 
ZONE_MOVABLE or MIGRATE_CMA, because you'll end up "consuming" all 
memory for unmovable allocations in the system), and we shouldn't 
advocate the use of unlimited overcommit for huge pages ...

-- 
Cheers,

David / dhildenb

