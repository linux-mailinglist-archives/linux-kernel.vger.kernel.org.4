Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91A74B6A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGGSz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183DAC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688756078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGOB9cU43U5U0NEIYKDtQCVASK0lWRPDWnnUNNhV+lk=;
        b=bFltIEEKjMHBdALiWh4grtTbTKuTTROAW0+y7pdG7v9ms4XSed03mhtaNa27lYYVf04k11
        gDdAK96XZ41kFLY6Nagvtgsif24tuu/wPN7GrIAjzfOG8hNOSU97LBcI3ee3T5cELD8jWx
        Plf2/ThI7eRo7FBdr86amhOuQ8QiIdI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-wY0qLS52OhKqrkIP54YXBg-1; Fri, 07 Jul 2023 14:54:36 -0400
X-MC-Unique: wY0qLS52OhKqrkIP54YXBg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so14932105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 11:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688756075; x=1691348075;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGOB9cU43U5U0NEIYKDtQCVASK0lWRPDWnnUNNhV+lk=;
        b=gcEbG+zVDnhvWnzxEEY+SIb9oqcXrnzMhHpIMYSD4wgHkZV37nqZPq5BXXYJkDErCV
         ClJL0q0J1/Nm2KavtVlveq1ZDEACE6kdc5LdksZkp9frHKmuzwVFdgXzKB4Z+h/Jvi4i
         O4A7Mrva52AyGrQVr8Jt8TtAp9J2WMtZr94ZO/HtY5AxRcHzbbJnxDvNq940uzZLM662
         ggJ+MoVLV9VB11QNYdGee3xyi7h+TUZ3gcb1fuSeJ7RPLMpyuq+xfXGF6u0ZCzN39fmV
         7zi3U2vJwN1k11dzjR1BWIlhhr6HSYM36Q4mptRSTY10oiEu5PebXEGvdyaQHy7NBJBu
         c84g==
X-Gm-Message-State: ABy/qLYQXm04BdEIMFYAXtGecGRrp5N9wqyEzwJnDkSjxY3g2QQQoNdr
        P5WWwQmJQ+w4rt7iuK8jIJt0OVJbp0UI2ChtqtBPKbeB/O6O08Z5cuHkV1rfFilD36BBHvf5VYe
        IZVv7Y+HZBjVySdBut2TMSygh
X-Received: by 2002:a5d:4203:0:b0:314:22ea:4ee7 with SMTP id n3-20020a5d4203000000b0031422ea4ee7mr5932862wrq.33.1688756075444;
        Fri, 07 Jul 2023 11:54:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjiq+gIwd+f32qNK87VkS1fbq4nE+ck66mEyTwrSEMX4G7bNpQhLTysPX7gScSDPG8UVR8cA==
X-Received: by 2002:a5d:4203:0:b0:314:22ea:4ee7 with SMTP id n3-20020a5d4203000000b0031422ea4ee7mr5932844wrq.33.1688756075093;
        Fri, 07 Jul 2023 11:54:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id e18-20020adff352000000b003143add4396sm5155612wrp.22.2023.07.07.11.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 11:54:34 -0700 (PDT)
Message-ID: <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
Date:   Fri, 7 Jul 2023 20:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
In-Reply-To: <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 07.07.23 19:26, Matthew Wilcox wrote:
> On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
>> This series identified the large folio for mlock to two types:
>>    - The large folio is in VM_LOCKED VMA range
>>    - The large folio cross VM_LOCKED VMA boundary
> 
> This is somewhere that I think our fixation on MUST USE PMD ENTRIES
> has led us astray.  Today when the arguments to mlock() cross a folio
> boundary, we split the PMD entry but leave the folio intact.  That means
> that we continue to manage the folio as a single entry on the LRU list.
> But userspace may have no idea that we're doing this.  It may have made
> several calls to mmap() 256kB at once, they've all been coalesced into
> a single VMA and khugepaged has come along behind its back and created
> a 2MB THP.  Now userspace calls mlock() and instead of treating that as
> a hint that oops, maybe we shouldn't've done that, we do our utmost to
> preserve the 2MB folio.
> 
> I think this whole approach needs rethinking.  IMO, anonymous folios
> should not cross VMA boundaries.  Tell me why I'm wrong.

I think we touched upon that a couple of times already, and the main 
issue is that while it sounds nice in theory, it's impossible in practice.

THP are supposed to be transparent, that is, we should not let arbitrary 
operations fail.

But nothing stops user space from

(a) mmap'ing a 2 MiB region
(b) GUP-pinning the whole range
(c) GUP-pinning the first half
(d) unpinning the whole range from (a)
(e) munmap'ing the second half


And that's just one out of many examples I can think of, not even 
considering temporary/speculative references that can prevent a split at 
random points in time -- especially when splitting a VMA.

Sure, any time we PTE-map a THP we might just say "let's put that on the 
deferred split queue" and cross fingers that we can eventually split it 
later. (I was recently thinking about that in the context of the 
mapcount ...)

It's all a big mess ...

-- 
Cheers,

David / dhildenb

