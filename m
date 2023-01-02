Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75AA65B503
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjABQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjABQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94A8FCA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672676455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSm9E5rxDgi7DwJ0VMt6Hp3omj7CtMsgyOLZMGchtlU=;
        b=b1Gcu33XtI3tDS94YEKByEZNHKNrgiDbCvLiugvw7fleYmf17fmXeMmoHydGlgufLzV6SV
        jjUgYuMN7W2az8+lIiE82i8pnZ0fbCfSoKHRYhQ8r3XgUquxJlfGcDy3n1MdJCpV3ciU0/
        1pCkr6gI7kWUExVcogQQSi/uI5AN75c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-XcL8VZJfOCq3OjuiuJZCVw-1; Mon, 02 Jan 2023 11:20:52 -0500
X-MC-Unique: XcL8VZJfOCq3OjuiuJZCVw-1
Received: by mail-wm1-f71.google.com with SMTP id q21-20020a7bce95000000b003d236c91639so6476060wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSm9E5rxDgi7DwJ0VMt6Hp3omj7CtMsgyOLZMGchtlU=;
        b=b+6KnHWyuzZgS5L6iBC5kXm529cpM3S8qAA5djEWyLHb0jyIZn0+YByMW+7md+dC1I
         P6FUT3XoU8Qw9rcWDGCnvjq4PtxlhQMAy4Ru9LvgtxRf8QKX+KaeCUuGyu5YweCQanAF
         Hxhw63Bmvl422pWtch/ibd45JjLRUMiFXjVjIiNrsq7kXt6UCrsC83VfkVZH9JQLGl27
         oTx5765YLvzdgV8LFJrQoejBFOkkPXb6Jt1APcxrPUjwYZMzkFnyfn2kEVHNWz0mkz6R
         Yjo3mSfKJgkGU/KGyKDl1T1pJKD3emxeZ+9x0lSwbzInbjPzbBTmLd94WugNOFaJ2XfE
         lc0g==
X-Gm-Message-State: AFqh2krNls/23MmNUaeuPzMZxTe3NUu6arGLSEYWIymadYEmrcBcy6pc
        PfFPFovwRe6zTNkbrhPGsgosgwW0XZSVa2VCSaGUXfJzCk7Toc6qtfVCbG8nwN/I+BcwN2j5Dsz
        /cKlYySfnxBcl71GmN+DlCaxh
X-Received: by 2002:a05:600c:35d4:b0:3d2:2d2a:d581 with SMTP id r20-20020a05600c35d400b003d22d2ad581mr28436824wmq.30.1672676451104;
        Mon, 02 Jan 2023 08:20:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtzXRUkM+s5POwXYF4sAJXmfQyH3XWOyrl0suKMisN2guuCSOG41kkBU5NIvqoqUqfQ3jRVvg==
X-Received: by 2002:a05:600c:35d4:b0:3d2:2d2a:d581 with SMTP id r20-20020a05600c35d400b003d22d2ad581mr28436810wmq.30.1672676450906;
        Mon, 02 Jan 2023 08:20:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b002709e616fa2sm28859339wru.64.2023.01.02.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:20:50 -0800 (PST)
Message-ID: <b6b25373-ba6b-6610-1030-7f795f01987c@redhat.com>
Date:   Mon, 2 Jan 2023 17:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
 <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com> <Y7MBqfYv54rY48Wi@lucifer>
 <f29b6cb0-d46b-7d89-c8ad-12b9addf8ce8@redhat.com> <Y7MDVT4dO2pqxJwJ@lucifer>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7MDVT4dO2pqxJwJ@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.23 17:16, Lorenzo Stoakes wrote:
> On Mon, Jan 02, 2023 at 05:10:40PM +0100, David Hildenbrand wrote:
>> Maybe wait until tomorrow for feedback from others. Make sure to include my
>> acked-by.
> 
> Too late... I thought Andrew typically added these kind of things himself? As an
> Acked-by could be a reply to an unmodified patch for example. Though I guess
> it'd save you having to reply to the v4? Anyway sorry, already sent it!

Maintainers usually apply tags that are sent to the latest version, when 
picking up the patch. Maintainers usually refrain from going through 
multiple earlier patch versions to pick up tags -- especially, because 
some changes might require a submitter from dropping tags (e.g., bigger 
changes) and the tags might no longer be valid.

So better always include tags when resending, so they don't get lost.

> 
> It's sat in the mailing list so others can review further if required, this is a
> bank holiday in the UK, and as a part-time contributor (and otherwise distracted
> by book work) it is a rare moment to be able to respond to feedback so will tend
> to get squashed into evenings/weekends/public holidays :) If people have further
> comments I will, of course, respond as + when I can!
> 
> Cheers!

Happy holidays then :)

-- 
Thanks,

David / dhildenb

