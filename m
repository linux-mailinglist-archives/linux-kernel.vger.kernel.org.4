Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FB265E701
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjAEIpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjAEIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C164C71D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672908260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCck/51gXT4nv/4OrHFUzHugnf6njmYJQeakPI93ooE=;
        b=Jq7GO2hD/H9Y8RF5rbFriQvF65EkCOcVf6Qm3nwChOFK/9sQo8lzJnRL0NoqfO15iS7aWg
        Udia48gLuhwOxcdkqeU/uHXaiF1QDCzzD2rbb3bE7Rv48AOjZmlyJl4SQeDCjd/7QqyDpR
        UKbeU+Np+K9dN33xQNUxQWvUPnvZBmI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-Xl97Sky0Nc6oDp832RnL0g-1; Thu, 05 Jan 2023 03:44:19 -0500
X-MC-Unique: Xl97Sky0Nc6oDp832RnL0g-1
Received: by mail-wm1-f72.google.com with SMTP id l17-20020a05600c1d1100b003d9a145366cso9270249wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 00:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCck/51gXT4nv/4OrHFUzHugnf6njmYJQeakPI93ooE=;
        b=o+/ySHKe/QoYslHZzATdmldxF3Uu5T8AyLGEIVx7RGdTW02EIBZD7hAwLvc/yU1gqE
         h+U3tQrHD5oB9IQDelqSoh/YcefxnpAWgcYOOxr2tZrzqpwoly99Y++uDDr3EehuYmd5
         TH3OA5RnIhFMfgQu011CFW4ZeaCKIKzhZL8JKeWi44RKeHe3QfUGWUKRbCuJkddD82TB
         MTpmjifUuLBy8vFgzaUKVRkxy6VUC5SozVhVxGeT8GUDicEkvss/Yyj6O3Ajie0hTmhm
         s12+cvp+rtAmn6l1U/usJsCzrMta/gORGmdl2Rdq/9oDGUgyb7bSFus1MSnQqld0QGn9
         jBqw==
X-Gm-Message-State: AFqh2krxvwO3M/QZLk9pq7ZWKZtWUDt/98yof+OCZx3npQUGtx5IgI3g
        AY1+2Z+VwKN0wkGueTjulkLG4n2m/jDrxRXaAJA5QVaFYMB+vcO2N1u202kbKrfz9fXolHPlcD6
        BUYchsQtT7uFgf1mZ0cb6fQyM
X-Received: by 2002:a05:600c:3b8f:b0:3d0:480b:ac53 with SMTP id n15-20020a05600c3b8f00b003d0480bac53mr38466586wms.12.1672908257913;
        Thu, 05 Jan 2023 00:44:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsH8DkSvOp8oY63fOt5N9Zn4ivnATt038lgE4WQK+LssVnzXfJtw6H/sCfgOimxsOKyBN0XaQ==
X-Received: by 2002:a05:600c:3b8f:b0:3d0:480b:ac53 with SMTP id n15-20020a05600c3b8f00b003d0480bac53mr38466567wms.12.1672908257677;
        Thu, 05 Jan 2023 00:44:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b003d978f8f255sm2202586wmq.27.2023.01.05.00.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 00:44:17 -0800 (PST)
Message-ID: <aabd4bb8-560b-10b0-9837-b656e1a0a9e1@redhat.com>
Date:   Thu, 5 Jan 2023 09:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] mm/mprotect: Use long for page accountings and retval
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230104225207.1066932-3-peterx@redhat.com>
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

On 04.01.23 23:52, Peter Xu wrote:
> Switch to use type "long" for page accountings and retval across the whole
> procedure of change_protection().
> 
> The change should have shrinked the possible maximum page number to be half
> comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on any
> system either because the maximum possible pages touched by change
> protection should be ULONG_MAX / PAGE_SIZE.

Yeah, highly unlikely.

> 
> Two reasons to switch from "unsigned long" to "long":
> 
>    1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
>       a long type.
> 
>    2. It paves way for returning negative (error) values in the future.
> 
> Currently the only caller that consumes this retval is change_prot_numa(),
> where the unsigned long was converted to an int.  Since at it, touching up
> the numa code to also take a long, so it'll avoid any possible overflow too
> during the int-size convertion.

I'm wondering if we should just return the number of changed pages via a 
separate pointer and later using an int for returning errors -- when 
touching this interface already.

Only who's actually interested in the number of pages would pass a 
pointer to an unsigned long (NUMA).

And code that expects that there never ever are failures (mprotect, 
NUMA) could simply check for WARN_ON_ONCE(ret).

I assume you evaluated that option as well, what was your conclusion?

-- 
Thanks,

David / dhildenb

