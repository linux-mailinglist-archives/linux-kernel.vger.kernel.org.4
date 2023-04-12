Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729226DEF66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDLIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjDLIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D756E9F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681289276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vf66+e5gJhi3TigOiUuSzTWwcCNcD0MYCDduT1r2oAQ=;
        b=NAzVdme5/Kse0hngFLK7SbOhGfds8I1BmMPooTzj0mSoGZatog4xQFUWKrGkE/SlB7y8Qd
        S2mW+q8Oi8jjHWT3OkLGaAganV+zaaDU4NgIuTZSTrmmySFmXfMm+8frE/itHiamZWlqfT
        uSb5NwmQFDTjQSQBlNhu4o3Yo2F5mqA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-156kI2LRP6qq3-uMSoWuwg-1; Wed, 12 Apr 2023 04:47:55 -0400
X-MC-Unique: 156kI2LRP6qq3-uMSoWuwg-1
Received: by mail-wm1-f70.google.com with SMTP id m7-20020a05600c3b0700b003ee112e6df1so2731501wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681289274; x=1683881274;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vf66+e5gJhi3TigOiUuSzTWwcCNcD0MYCDduT1r2oAQ=;
        b=5RbL10Hx6rPnIru7ZgcdccqyAEt5BXblrYDyCirp++7PXE7jjzxKRlMRuk34ZaDc8g
         cpU/iLpxm77yDfNRRoKzAzOf4Cz1qoWB7vt1FaqADSCzsX9JzQ0hxHFkWDF5oNvYDcWJ
         lhBsNGhlvSMaLJIyYrrOamk6JsaDXiyKAEZtjVIMAlLw3q3y/99VufpRYFAt7l2ADkp0
         djl5dUcgvBwrN6usT90JIiOTvhHnSlnQRouZcLwpVvne9vlTdZcP/kgutG1gGKqx1LLf
         xYWZiHMDlsJbpdX9Y4TqPu6uAFLTwh4nV6OlWTYqLrTLbqVul7XYo5MHFVe4qI0xyXJI
         9RVA==
X-Gm-Message-State: AAQBX9dKhXLHlYuurv4cutlaxkmXP0LGtO0jdiZhTLO0dc1ZGzG8RMeV
        udboKK88+pn/zcRr7BGyIFUQg8R1vHJvVY//Jwi7foVMvcuv5GPne+lTr7SuUBu9+7IJJLdKstx
        LAxtfWUJ+A+Z7G+dIAsannEVr
X-Received: by 2002:a05:600c:b42:b0:3f0:3ab2:a7e5 with SMTP id k2-20020a05600c0b4200b003f03ab2a7e5mr12902923wmr.34.1681289274079;
        Wed, 12 Apr 2023 01:47:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUl+Vw5v7Ecp/EWViYmShjAG3QBgdU357dVSo3CfFNYdPKvkHJ70zhEAtEZ3ohsqwWA7zBNA==
X-Received: by 2002:a05:600c:b42:b0:3f0:3ab2:a7e5 with SMTP id k2-20020a05600c0b4200b003f03ab2a7e5mr12902902wmr.34.1681289273748;
        Wed, 12 Apr 2023 01:47:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003f07ef4e3e0sm5879348wmo.0.2023.04.12.01.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:47:53 -0700 (PDT)
Message-ID: <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
Date:   Wed, 12 Apr 2023 10:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: RFC for new feature to move pages from one vma to another without
 split
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZC8BgFSFC3cDcAcS@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.23 19:29, Peter Xu wrote:
> Hi, Lokesh,
> 
> Sorry for a late reply.  Copy Blake Caldwell and Mike too.
> 
> On Thu, Feb 16, 2023 at 02:27:11PM -0800, Lokesh Gidra wrote:
>> I) SUMMARY:
>> Requesting comments on a new feature which remaps pages from one
>> private anonymous mapping to another, without altering the vmas
>> involved. Two alternatives exist but both have drawbacks:
>> 1. userfaultfd ioctls allocate new pages, copy data and free the old
>> ones even when updates could be done in-place;
>> 2. mremap results in vma splitting in most of the cases due to 'pgoff' mismatch.
> 
> Personally it was always a mistery to me on how vm_pgoff works with
> anonymous vmas and why it needs to be setup with vm_start >> PAGE_SHIFT.
> 
> Just now I tried to apply below oneliner change:
> 
> @@ -1369,7 +1369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>                          /*
>                           * Set pgoff according to addr for anon_vma.
>                           */
> -                       pgoff = addr >> PAGE_SHIFT;
> +                       pgoff = 0;
>                          break;
>                  default:
>                          return -EINVAL;
> 
> The kernel even boots without a major problem so far..

I think it's for RMAP purposes.

Take a look at linear_page_index() and how it's, for example, used in 
ksm_might_need_to_copy() alongside page->index.

-- 
Thanks,

David / dhildenb

