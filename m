Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54263B11A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiK1SVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiK1SUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113152AC77
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669658768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ls7PhYALLia6Ca4uW+eal0IBzPITDzYb5wkwc+H7LdA=;
        b=Y3hFKrBU4ktzxr9Pz+PnUKyRy/TVZHTUyL7I5JVin/2TubAdLxSMb9NIkqkQXZrTKWyAoA
        AX8/7/+yebkYbBTtf9r4TZnMKI2R5SiAOGLflZqhY/zxsjk6y/SnOQ5IReeiZS0vxeeRnz
        +Wgtk8ggcNGb0ckGyE0GOo3KgtgO/78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-T0woF611NP-LJL6BiVjLVQ-1; Mon, 28 Nov 2022 13:06:05 -0500
X-MC-Unique: T0woF611NP-LJL6BiVjLVQ-1
Received: by mail-wm1-f69.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso6580856wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls7PhYALLia6Ca4uW+eal0IBzPITDzYb5wkwc+H7LdA=;
        b=1jLAxThcrJ18kVzRg7UGwg5lLhOidKqWSNYA/L6x4+5pWstcrXYXpVUYqwHOKvD347
         Mc05pe/pSvs2LomLfGo5yg74MLm4ozg4tvn+0z5SG4edH9U33omamkyYyawyxxQKF+tO
         Y/qGR7Uj8CrvvpubSjM/0vKnvSHxL76+La9rr1XCPC17TbqNoHPnDcNZmCaFZ5MWImoA
         6/N1mTdkAf2O78+ZOt7CvmvAdA3g+dfwZxbGG0TbfUFQDiNf4TK9URBK+mnqP4YGhA9s
         aQAQN65D3x/as6OCWaFkuvNmPq9S1aaPrH4sLU8jnQlJpGHwcLsRFkUdCiFlCXE/gltX
         A9eQ==
X-Gm-Message-State: ANoB5pmHSyRUWDSNGVT0mnAyVaY2d7JMlYTd+D9xmeIS+aEzEFeQF9LI
        R4tW6/ifDvwvU7Jh+rbVgiUISNn6XhaDvt4+OLmykAgWhkF82t2fBQ8xYxWB+z8db8AmVX38U4l
        jelKD0IM60hfBzSFCAjwKubeV
X-Received: by 2002:a7b:c454:0:b0:3b4:be28:d800 with SMTP id l20-20020a7bc454000000b003b4be28d800mr25382394wmi.170.1669658763826;
        Mon, 28 Nov 2022 10:06:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7z2AUHPt9xIYsZQcqpTl0DnSuSUoPVM0oCfQkyzSF5aefGZsV+BwNQxXir3xLNlMrX6J5c6w==
X-Received: by 2002:a7b:c454:0:b0:3b4:be28:d800 with SMTP id l20-20020a7bc454000000b003b4be28d800mr25382358wmi.170.1669658763546;
        Mon, 28 Nov 2022 10:06:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id u1-20020a5d5141000000b002365cd93d05sm11295450wrt.102.2022.11.28.10.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 10:06:02 -0800 (PST)
Message-ID: <54f43e4d-5124-b2c8-c6d4-ce0bf4547eaf@redhat.com>
Date:   Mon, 28 Nov 2022 19:06:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file
 collapse paths
Content-Language: en-US
To:     Jann Horn <jannh@google.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221125213714.4115729-1-jannh@google.com>
 <20221125213714.4115729-3-jannh@google.com>
 <66cfc9ba-868c-9620-fbfc-38931c76ff50@redhat.com>
 <CAG48ez23WvRRX6LKgCe+sJMYWBKVa+U1fg7G1o0nOobHCEQBGg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAG48ez23WvRRX6LKgCe+sJMYWBKVa+U1fg7G1o0nOobHCEQBGg@mail.gmail.com>
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

On 28.11.22 18:57, Jann Horn wrote:
> On Mon, Nov 28, 2022 at 6:37 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.11.22 22:37, Jann Horn wrote:
>>> Any codepath that zaps page table entries must invoke MMU notifiers to
>>> ensure that secondary MMUs (like KVM) don't keep accessing pages which
>>> aren't mapped anymore. Secondary MMUs don't hold their own references to
>>> pages that are mirrored over, so failing to notify them can lead to page
>>> use-after-free.
>>>
>>> I'm marking this as addressing an issue introduced in commit f3f0e1d2150b
>>> ("khugepaged: add support of collapse for tmpfs/shmem pages"), but most of
>>> the security impact of this only came in commit 27e1f8273113 ("khugepaged:
>>> enable collapse pmd for pte-mapped THP"), which actually omitted flushes
>>> for the removal of present PTEs, not just for the removal of empty page
>>> tables.
>>>
>>> Cc: stable@kernel.org
>>> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
>>
>> I'm curious, do you have a working reproducer for this?
> 
> You're on the CC list of my bug report to security@kernel.org
> with title "khugepaged races with rmap-based zap, races with GUP-fast,
> and fails to call MMU notifiers". That has an attached reproducer
> thp_ro_no_notify_kvm.c that is able to read PAGE_POISON out of freed
> file THP pages through KVM.
> 

Ah, the mail from early October, thanks (drowning in mail).

You're amazingly skilled at writing reproducers.

-- 
Thanks,

David / dhildenb

