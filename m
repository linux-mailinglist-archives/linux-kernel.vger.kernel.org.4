Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E222266985D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjAMNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbjAMNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F7959D00
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673615320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTGp/g2Mj2pJKwIiYAJsofqpy3bUijk8D7H1gLakptw=;
        b=TzFFb9RdwzjYz+tUJPXhoLPooIvp/08XiWlQJUkZdX192ZUnivaTB9CqyP+ocphwi1UDjj
        e56kgwrtilhdGRKTNmLWgY7mHFWczCRSTVGvmcPR8MqylXTY77WuNzqbZAyn5UvDv0aIW9
        3SbuKwVEeGKfhFZn4Z9PPqpRokmAQCQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-5MI1HJVhMaODli8BBZ1yYA-1; Fri, 13 Jan 2023 08:08:39 -0500
X-MC-Unique: 5MI1HJVhMaODli8BBZ1yYA-1
Received: by mail-wm1-f69.google.com with SMTP id bi6-20020a05600c3d8600b003da1f6a7b20so791879wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTGp/g2Mj2pJKwIiYAJsofqpy3bUijk8D7H1gLakptw=;
        b=GPhQ/i1omDCsTTulUCf5nJ1ZC6Sdu6BdMzDve4dQvhMYcNiaucFw3+vYSxSMgESwv1
         p6aB+wlhGyUPTJKf8YshUMlh3Jyt7ImItZugp9r5RK9I4D3Ij3hmbO7p6C/eWJB9wICL
         SKH9EtJ361JDKBTN1F8ZMIraBMaIqegJ86MFZyd7uqcehYIObP5g38NLRHQ/ZbwqOKKd
         mjp+oXzg77gT+3ntuE7GBpRUabtaYzQuXUo6C6PSkRanPAQyfq5qJYzXXF9zlhIeowSi
         3TUHHEsKakDo1jzTZ+XosBB7oM6I8TESbaw8TbxjmBll7HkYVPgIa36UASZOKNqiO7L2
         qiaw==
X-Gm-Message-State: AFqh2koBlOmywPeoG4nqVb44f3D0/2w+qCC9XCCXviwJ3RaVw0mQyRSq
        fiNv7qRmNr3DwZyWFG6x1IOH2dNcaK6jEAnT1QZx2k4l0+LHNH2ywgNblJoUpKGw1Z0akKi+sY8
        ly4xfTCq1UY8H1wDKtu1fxBXN
X-Received: by 2002:adf:cd82:0:b0:2bd:bf44:2427 with SMTP id q2-20020adfcd82000000b002bdbf442427mr8484115wrj.42.1673615318295;
        Fri, 13 Jan 2023 05:08:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvPtDScdJl06i/LvqN9fQBg1j/z9NuB/ZbSPipm75MwKl4iLeEaz8CQ94/uHzhS2GM0wFfPXg==
X-Received: by 2002:adf:cd82:0:b0:2bd:bf44:2427 with SMTP id q2-20020adfcd82000000b002bdbf442427mr8484099wrj.42.1673615317966;
        Fri, 13 Jan 2023 05:08:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:ec00:869d:7200:eb03:db01? (p200300cbc704ec00869d7200eb03db01.dip0.t-ipconnect.de. [2003:cb:c704:ec00:869d:7200:eb03:db01])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm18873317wrx.96.2023.01.13.05.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 05:08:37 -0800 (PST)
Message-ID: <8bbc5629-b89a-83f3-41a4-0083ea2468c1@redhat.com>
Date:   Fri, 13 Jan 2023 14:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use
 folios
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-6-wangkefeng.wang@huawei.com>
 <CGME20230113130136eucas1p18a54a3812792e500a02079ee890e5ecb@eucas1p1.samsung.com>
 <32fefce6-e25d-106d-12ec-8fc612843cfb@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <32fefce6-e25d-106d-12ec-8fc612843cfb@samsung.com>
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

On 13.01.23 14:01, Marek Szyprowski wrote:
> Hi
> 
> On 12.01.2023 09:30, Kefeng Wang wrote:
>> The old_page/new_page are converted to old_folio/new_folio in
>> wp_page_copy(), then replaced related page functions to folio
>> functions.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> This patch, merged into today's linux-next as commit 9ebae00c8e30 ("mm:
> memory: convert wp_page_copy() to use folios"), causes serious stability
> issues on my ARM based test boards. Here is the example of such crash:

syzbot is also not happy:

https://lkml.kernel.org/r/000000000000807c7805f2205df1@google.com

-- 
Thanks,

David / dhildenb

