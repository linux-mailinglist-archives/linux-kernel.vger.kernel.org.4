Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1E60D0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiJYPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiJYPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B48E7BF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666711908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ubJrAQo+otL1AZ9Abp0aYcF9mVXIW+a9k2CYvh8qVg=;
        b=GdjZ5+8DrNps+5w/7BlTWNtCZIimHRzNOeW0Qu+yfcJuJWS/IN8JtVb057fzFtsl5nr/wM
        kJrHszyvAlI5YUS3zvCtlTKNmurnLZs8N3fant2acir+XMx0MsIb006GNlkh0Ih7a2gNTy
        8GYThJlOnag32EGC3e7kHwmcSlFpxeo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256--0EKhtzMMjOn7TNqiNOQhQ-1; Tue, 25 Oct 2022 11:31:47 -0400
X-MC-Unique: -0EKhtzMMjOn7TNqiNOQhQ-1
Received: by mail-wr1-f72.google.com with SMTP id c18-20020adfa312000000b002364fabf2ceso4883343wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ubJrAQo+otL1AZ9Abp0aYcF9mVXIW+a9k2CYvh8qVg=;
        b=f20elhbA1gBmyefDVouHd6+UBeJw0kGk+9ryzhibQa0TTJ0qi6n1Eur5ItmlrI67z3
         5hxis3NElR86KFDwZX4Wjdm1P8rHeuKizLdaDufSGnj9UDLvg5rIOnKgMd888rQW30i8
         nX06YkO7qsSNN/eHoRUgN/3Kyv+HQYrMxNFT6rerv4ebfRaVa6rXXmUb7XJJAe97GeRS
         Ug5qamsW2j36fW1DOz4jGW/akW7g6i9xhu0ZK4pXDd42YNPVswf2SZAjY+gswvxe5aP3
         O71SioHMu/u2DYEhnyLtuoEIYX42ti8B8wZZbqcKNYeYou5b/2SjGw/Zh13v7pVpuhm5
         Wvmg==
X-Gm-Message-State: ACrzQf0wtxdhKqqtMS5+L8fEwq0POOh9alXeYC3GLbW0hH615uBh00QB
        hip2RMyA7U8/VP680Dhg5pYZtP6xS9p9S+YZnkXZ7XvWEewIgH7woyEwbQAowlYHNvOBCZkELlF
        5iIE8KyZ98M4MZW1aQ5Ed2k7O
X-Received: by 2002:a05:600c:34cc:b0:3c6:fb65:24cc with SMTP id d12-20020a05600c34cc00b003c6fb6524ccmr27060406wmq.1.1666711905944;
        Tue, 25 Oct 2022 08:31:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4iTnlvYMQ4F2npklHfv1Ot93I/zcEUEDxI5AjUuriPL7zR9mOccMdvYem7JpMzTWpxt3ybFQ==
X-Received: by 2002:a05:600c:34cc:b0:3c6:fb65:24cc with SMTP id d12-20020a05600c34cc00b003c6fb6524ccmr27060382wmq.1.1666711905674;
        Tue, 25 Oct 2022 08:31:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:d00:eae9:3af6:9999:7b63? (p200300cbc7190d00eae93af699997b63.dip0.t-ipconnect.de. [2003:cb:c719:d00:eae9:3af6:9999:7b63])
        by smtp.gmail.com with ESMTPSA id k11-20020a056000004b00b0023657e1b97esm2972074wrx.11.2022.10.25.08.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:31:45 -0700 (PDT)
Message-ID: <d0b8384b-6699-0485-1d39-afbf598a34e9@redhat.com>
Date:   Tue, 25 Oct 2022 17:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH RFC 2/2] mm: Use pte markers for swap errors
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221024204830.1342169-1-peterx@redhat.com>
 <20221024204830.1342169-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221024204830.1342169-3-peterx@redhat.com>
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

On 24.10.22 22:48, Peter Xu wrote:
> PTE markers are ideal mechanism for things like SWP_SWAPIN_ERROR.  Using a
> whole swap entry type for this purpose can be an overkill, especially if we
> already have PTE markers.  Define a new bit for swapin error and replace it
> with pte markers.  Then we can safely drop SWP_SWAPIN_ERROR and give one
> device slot back to swap.
> 
> We used to have SWP_SWAPIN_ERROR taking the page pfn as part of the swap
> entry, but it's never used.  Neither do I see how it can be useful because
> normally the swapin failure should not be caused by a bad page but bad swap
> device.  Drop it alongside.

[...]

>   
> -#define  PTE_MARKER_UFFD_WP  BIT(0)
> -#define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
> +#define  PTE_MARKER_UFFD_WP			BIT(0)
> +#define  PTE_MARKER_SWAP_ERROR			BIT(1)

I'd suggest to keep the term SWAPIN. An error happened during swapin, 
which is why the page is corrupted.

(I remember that we discussed naming details in the original series and 
SWAPIN was the conclusion)

-- 
Thanks,

David / dhildenb

