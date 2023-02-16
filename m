Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F096698FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBPJZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935A61C7C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676539494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbwN4ynIlaU5oA+cvdp2uCZwDHqo0yJ8G9tkzU+m17I=;
        b=TJs4NBTZQpvH2yAznbvG/xXpzZCGMQ+2mN2H1bQ7CymAnMLekQ9YfcQ+i+YmcC0Bkx/6GN
        9XFK/FuPGCSrFMzPFA3XksGALfXqHGLiIswln8j7yLud8TsO1sdWSnXGZ3tRSpD/Ul4ei0
        Op6lMJE/2osmHkW5u3TPAw0/2gos8P8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-sBApl0cMNEOoE5By5vSL1Q-1; Thu, 16 Feb 2023 04:24:53 -0500
X-MC-Unique: sBApl0cMNEOoE5By5vSL1Q-1
Received: by mail-wr1-f69.google.com with SMTP id p6-20020adf9d86000000b002c5400f5c76so137888wre.14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbwN4ynIlaU5oA+cvdp2uCZwDHqo0yJ8G9tkzU+m17I=;
        b=yBUVdWOnKsgNzBpWIPW3zH3CNns5P7sjQZysu9A5fUypsvIxmYTmDoHQUZennXUFov
         ygZwpymKDt7faqfQF6Tl5OzNpQdRmBjbb5UhJGNernE88ExEB1UC49/Qc6VVTbb2b+6n
         BxBaiKcBFRjFdFFRoRv4Tc8zWSUeTXqeAm0OZq0CxwfhBarR8fXS+3jd/moFvifhMYVh
         LOjEH8WOfO0k8qZ5RUi0JvU8hzQYVpaWs/Z1vkTEyuezP4aOFql/JcINn1TSfn+J3FaJ
         09yRPSweuHxxFpm+SKmIbynifsRHYoF389gcWpmZXFuWYVi/mFp3vZPmyc9zWYdL1Ac2
         4htA==
X-Gm-Message-State: AO0yUKUPIT6Z5JaIJUb5yirBnxbOGeLW/31AAtOqtyZJJdbgV71SRDZ4
        s4qdTgz3/+xYf0w1hmfoq9PRiVpZExo2CQ2qpTbqWMXbw5Zgdyi37sPuQBwQGi9tG0yt0r790Jp
        4rJnDFn+nKfHkFO7n0aewZF0G6+dQGw==
X-Received: by 2002:a05:600c:1f06:b0:3dc:3b29:7a4 with SMTP id bd6-20020a05600c1f0600b003dc3b2907a4mr1193238wmb.0.1676539492009;
        Thu, 16 Feb 2023 01:24:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8yIWuMdBa6tQpAWLlLFZv6cp6xxL4vEB8AtZu0NusGqHmYuOPN2Xjv4WPCISM9752rdICA0w==
X-Received: by 2002:a05:600c:1f06:b0:3dc:3b29:7a4 with SMTP id bd6-20020a05600c1f0600b003dc3b2907a4mr1193226wmb.0.1676539491674;
        Thu, 16 Feb 2023 01:24:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c211600b003e2058a7109sm3927920wml.14.2023.02.16.01.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:24:51 -0800 (PST)
Message-ID: <4d29a9ec-027d-06b9-8543-87d386e58c94@redhat.com>
Date:   Thu, 16 Feb 2023 10:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/2] mm/userfaultfd: add VM_WARN_ONCE()
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <20230216091656.2045471-2-usama.anjum@collabora.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230216091656.2045471-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 10:16, Muhammad Usama Anjum wrote:
> Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   mm/userfaultfd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 77c5839e591c..d89ed44d2668 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -717,6 +717,8 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
>   	struct mmu_gather tlb;
>   	long ret;
>   
> +	VM_WARN_ONCE(start < dst_vma->vm_start || start + len > dst_vma->vm_end,
> +		     "The address range exceeds VMA boundary.\n");

VM_WARN_ON_ONCE is sufficient (sorry for spelling out the wrong variant 
earlier).

These kinds of bugs are expected to be found early during testing, still 
it might make sense to implement a backup path

if (WARN_ON_ONCE(...))
	return -EINVAL;

But we can't use VM_WARN_ON_ONCE here, so we can't compile it out 
anymore ... so I guess a simple VM_WARN_ON_ONCE() is sufficient.

-- 
Thanks,

David / dhildenb

