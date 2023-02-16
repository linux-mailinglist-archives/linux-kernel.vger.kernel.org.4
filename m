Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BC699232
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBPKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBPKt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23395564B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676544448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFu+2mKQzL8+1+DVxbOoshzbfGAy/UjaNE3ZIcgB4Yg=;
        b=RoHvezGKQ9GtW1oMqYwYUTmR5BTujgf+awFo37tgae7hhYOFW7KtG1BwtxSzhtRe/iAigQ
        8/vNqb6nm4XtFyzIt6XqE3hZVf3OzCQdlRru4+q168k7O+RPFuyzdDgrWMxcBRZo3d95W9
        Zh9JZBj07Xkvh7+rPuC0v65IP9bK0EQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-kHohRbZIOU-zLK7XsqDTbg-1; Thu, 16 Feb 2023 05:47:26 -0500
X-MC-Unique: kHohRbZIOU-zLK7XsqDTbg-1
Received: by mail-wm1-f70.google.com with SMTP id k17-20020a05600c1c9100b003dd41ad974bso939511wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFu+2mKQzL8+1+DVxbOoshzbfGAy/UjaNE3ZIcgB4Yg=;
        b=MdjLCEv8fdhyP8/StnMeuZtQyNZopMPptb6fnIMriAquQZElHcG4QO6V3KaHvp/pOZ
         5ohPA/NkSHi7GVgk6GFD+R+ZKBNnAQkWaFcZ99qQktqQ0cItEvcsrVWNrLqfMBWHCpw3
         FBap5ALC7NRKK14gQQPONf9HE1725nmNAm2GGUPFWpf2RvNENL484lnIaYpuJ9d5K5p7
         QtmyGa3XVdBm6MvYF2uJX4Ln+SqbzHCpgQiDTsCY6rPyqaPI5n1OjigzAAsD/N9ePLCt
         5geMSo+BleDxbcABzB6Jw/ypc5RXD18LaVUPh2Eoi8Wp6Cdd3rs23CON7xayrqZP/gT1
         faBw==
X-Gm-Message-State: AO0yUKUnXl8+KJQhBVo+H9p+Fyt+rRXSq25dCtD+/gjK7obck8gUXK3L
        drH8W1V5AX2RT3mjBeEIhWKZPZZKx0nBU5McZTqTzfJU90/q130VOVyrvZ5DK0QS7/OCKH092I/
        V6huqdgsEJQ1EPboGKVbNMOuL
X-Received: by 2002:a05:600c:331c:b0:3dc:19d1:3c13 with SMTP id q28-20020a05600c331c00b003dc19d13c13mr4087158wmp.12.1676544445549;
        Thu, 16 Feb 2023 02:47:25 -0800 (PST)
X-Google-Smtp-Source: AK7set9xs6Lk1X2m6MayPCsYGet7DDOGN0gmnf1j/1HhZq3BV3F7VtjyDp7Yd46+Sou+zcpjOloL7A==
X-Received: by 2002:a05:600c:331c:b0:3dc:19d1:3c13 with SMTP id q28-20020a05600c331c00b003dc19d13c13mr4087148wmp.12.1676544445204;
        Thu, 16 Feb 2023 02:47:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id bh25-20020a05600c3d1900b003dc5b59ed7asm1390285wmb.11.2023.02.16.02.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:47:24 -0800 (PST)
Message-ID: <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
Date:   Thu, 16 Feb 2023 11:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20230215210257.224243-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <20230215210257.224243-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.23 22:02, Peter Xu wrote:
> This is a new feature that controls how uffd-wp handles zero pages (aka,
> empty ptes), majorly for anonymous pages only.
> 
> Note, here we used "zeropage" as a replacement of "empty pte" just to avoid
> introducing the pte idea into uapi, since "zero page" is more well known to
> an user app developer.
> 
> File memories handles none ptes consistently by allowing wr-protecting of
> none ptes because of the unawareness of page cache being exist or not.  For
> anonymous it was not as persistent because we used to assume that we don't
> need protections on none ptes or known zero pages.
> 
> But it's actually not true.
> 
> One use case was VM live snapshot, where if without wr-protecting empty
> ptes the snapshot can contain random rubbish in the holes of the anonymous
> memory, which can cause misbehave of the guest when the guest assumes the
> pages should (and were) all zeros.
> 
> QEMU worked it around by pre-populate the section with reads to fill in
> zero page entries before starting the whole snapshot process [1].
> 
> Recently there's another need that raised on using userfaultfd wr-protect
> for detecting dirty pages (to replace soft-dirty) [2].  In that case if
> without being able to wr-protect zero pages by default, the dirty info can
> get lost as long as a zero page is written, even after the tracking was
> started.
> 
> In general, we want to be able to wr-protect empty ptes too even for
> anonymous.
> 
> This patch implements UFFD_FEATURE_WP_ZEROPAGE so that it'll make uffd-wp
> handling on zeropage being consistent no matter what the memory type is
> underneath.  It doesn't have any impact on file memories so far because we
> already have pte markers taking care of that.  So it only affects
> anonymous.
> 
> One way to implement this is to also install pte markers for anonymous
> memories.  However here we can actually do better (than i.e. shmem) because
> we know there's no page that is backing the pte, so the better solution is
> to directly install a zeropage read-only pte, so that if there'll be a
> upcoming read it'll not trigger a fault at all.  It will also reduce the
> changeset to implement this feature too.
> 

There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, 
using PTE markers, would be more benficial:

1) It would be applicable to anon hugetlb
2) It would be applicable even when the zeropage is disallowed
    (mm_forbids_zeropage())
3) It would be possible to optimize even without the huge zeropage, by
    using a PMD marker.
4) It would be possible to optimize even on the PUD level using a PMD
    marker.

Especially when uffd-wp'ing large ranges that are possibly all 
unpopulated (thinking about the existing VM background snapshot use case 
either with untouched memory or with things like free page reporting), 
we might neither be reading or writing that memory any time soon.

-- 
Thanks,

David / dhildenb

