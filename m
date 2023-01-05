Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC265E945
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjAEKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjAEKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8E4FD69
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672915645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UEbDwXIUB2tT4FTtzGYCDFhGThKelFO7bSLAhtp8Ky4=;
        b=APqgzo131CTTXKHAX1DkmxWpJ60W4AfQM4DkpjY36jY0cUvFTndjJzDmKMhbyO3D/9Q1l2
        xi9KGUd4TuCnT2Sx08mPASZ1XHErGHUf2ff1/3qCpxa7ThQy3wsNo32PuaMmdIvDp0AEdO
        nSQWRwkaTsPq7g7I3minfmQYF6pQS78=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-_4uSYXhDNNW3ffGLiWlbbg-1; Thu, 05 Jan 2023 05:47:23 -0500
X-MC-Unique: _4uSYXhDNNW3ffGLiWlbbg-1
Received: by mail-wr1-f69.google.com with SMTP id o5-20020adfba05000000b0029064ccbe46so2300713wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEbDwXIUB2tT4FTtzGYCDFhGThKelFO7bSLAhtp8Ky4=;
        b=lO0fab28isyGY90ujouh7mK2SNSMHa3IHXsyTOfYaPasC8zgwP3rbJGAmTDZvt5ePy
         W7cIznOFFUPRjJl8mDD01iRbS3E1jzs3yMsng8eLu1UZXm7QVsEFp95TvPCWHBUdADDw
         D2TOjPBQltU1eNPDgfapfQ6Uv6P7ipNcmIKYxIp1/d1XvHqVO+JQCs9AqSGbTaQFUPw4
         LCWyPPDxBLSodJulLvg+WVrhLrGBeq0avHprkFuMXtxgNUEF7kfvKmL1AKExaVKH1Q7y
         WcURyK81ubGWYTka126X09NutlQpQzcjGHaemthLTymq9UvX7mbkfYx6Bm7flJuOux11
         f6zw==
X-Gm-Message-State: AFqh2ko6lvzP/dwIEpAJbYc/Zfsontwt/kEpDyjbgu9SKrdwaKN11acO
        /GHq4BwxBT0pp5tBSW/8H83nWYZkxw0L5TYRXSQM4uUqsL5yHlqNLbKcacc369tR5SV6+PcRAoz
        JE3lno+GGQgrQAczaANExPDDq
X-Received: by 2002:a05:600c:1d16:b0:3d1:fe93:f1d3 with SMTP id l22-20020a05600c1d1600b003d1fe93f1d3mr37269266wms.36.1672915642121;
        Thu, 05 Jan 2023 02:47:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsU2MGUZIy8dexSPWz2offZfmPZMIC0nghsnlwgXQoP1gSAxKdkUVmLWFuL3F34KmxnbI9rAQ==
X-Received: by 2002:a05:600c:1d16:b0:3d1:fe93:f1d3 with SMTP id l22-20020a05600c1d1600b003d1fe93f1d3mr37269237wms.36.1672915641823;
        Thu, 05 Jan 2023 02:47:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d35acb0fd7sm2093683wmo.34.2023.01.05.02.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 02:47:21 -0800 (PST)
Message-ID: <60f06008-dea5-a08e-edec-fc4aec76dfb5@redhat.com>
Date:   Thu, 5 Jan 2023 11:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 00/46] Based on latest mm-unstable (85b44c25cd1e).
Content-Language: en-US
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230105101844.1893104-1-jthoughton@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 11:17, James Houghton wrote:
> This series introduces the concept of HugeTLB high-granularity mapping
> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> high-granularity, similar to how THPs can be PTE-mapped.
> 
> Support for HGM in this series is for MAP_SHARED VMAs on x86 only. Other
> architectures and (some) support for MAP_PRIVATE will come later.

Why even care about the complexity of COW-sharable anon pages? TBH, I'd 
just limit this to MAP_SHARED and call it a day. Sure, we can come up 
with use cases for everything (snapshotting VMs using fork while also 
support optimized postcopy), but I think this would need some real 
justification for the added complexity and possible (likely!) issues.

-- 
Thanks,

David / dhildenb

