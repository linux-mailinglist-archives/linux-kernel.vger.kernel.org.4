Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63029749D51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjGFNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjGFNVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E51992
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688649655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7s8uyqG1vcIobDWxB0t9oElaquD+rOvumYmWRMufnY=;
        b=BR377fPuFniNZJGZ9iWhANlItoOwrujA0xDQlm6Lux3nl8Rctsx7gKW47bSYLkzSvxkvla
        mZPtRoZl+kh7zuzcOIKZePGZOf4iJkax194ni9Z+Si/ehe24U3T2dts/paRz2mex/65434
        9MZNAhREHM6MvAYXNUFT3dNYeYymTjU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-wpBVZ_QKPZidf9FlWKZthA-1; Thu, 06 Jul 2023 09:20:52 -0400
X-MC-Unique: wpBVZ_QKPZidf9FlWKZthA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbdd5d09b8so4814445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649651; x=1691241651;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7s8uyqG1vcIobDWxB0t9oElaquD+rOvumYmWRMufnY=;
        b=kjuDzlYlPqdFdYJUzxVByGwhCJGkNXldSOv/80Yp4gs9BDybOSI6Mj63rwHQI+3IR+
         PL6seGf8XqaSlPtGc3CsHhVh5b20mSX50RsEzfmvNTgzpFtx9CDjxIZ4BFet+d3uiTJl
         /AnvjKnC26C1I+yM2gTqIef85QizuIa2dxfAZ6eEuYgHbeZFsayyrLnhir54j78VTFl7
         stLMV0vqp5iCCvIz8DagcGz1UkmTnMfkmiRPaFygHFZsQ93r9BUFOJb2A8yzu4sbAiCa
         bk+qxdm8EaC5QUSYrq1CN6sr+dsnRYjvqSzCKKTLfVEh6ZEHMqXy6gFve+uw/hDnhLDv
         77uQ==
X-Gm-Message-State: ABy/qLY29RF65w5uRfn4w86HSBuGRiMiyW2i3rt9rcRg5SLgy1Di1+66
        64VQKBHPiqOX2CYMnX9XpH20616kdC8anGfVBlRCiX37tIyBeQu6wlaMTZTElKYgH2d58jVzHfy
        G9vmXuwOCzf8UPnsUHjpnWRtI
X-Received: by 2002:a05:600c:21d0:b0:3f9:b17a:cb61 with SMTP id x16-20020a05600c21d000b003f9b17acb61mr1486939wmj.13.1688649651710;
        Thu, 06 Jul 2023 06:20:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGbX6NQkWyT4nncJbuxCqnOti+5GQSVyVlEjHdp0tT3+AV5OP4NtqhX7yZgN6eZGfJ98yWHlg==
X-Received: by 2002:a05:600c:21d0:b0:3f9:b17a:cb61 with SMTP id x16-20020a05600c21d000b003f9b17acb61mr1486902wmj.13.1688649651231;
        Thu, 06 Jul 2023 06:20:51 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003f8fb02c413sm2138843wmf.8.2023.07.06.06.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 06:20:50 -0700 (PDT)
Message-ID: <cab1b506-1f77-0532-f606-4fd4165d307c@redhat.com>
Date:   Thu, 6 Jul 2023 15:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/2] fork: lock VMAs of the parent process when forking
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230706011400.2949242-1-surenb@google.com>
 <20230706011400.2949242-2-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230706011400.2949242-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.23 03:13, Suren Baghdasaryan wrote:
> When forking a child process, parent write-protects an anonymous page
> and COW-shares it with the child being forked using copy_present_pte().
> Parent's TLB is flushed right before we drop the parent's mmap_lock in
> dup_mmap(). If we get a write-fault before that TLB flush in the parent,
> and we end up replacing that anonymous page in the parent process in
> do_wp_page() (because, COW-shared with the child), this might lead to
> some stale writable TLB entries targeting the wrong (old) page.
> Similar issue happened in the past with userfaultfd (see flush_tlb_page()
> call inside do_wp_page()).
> Lock VMAs of the parent process when forking a child, which prevents
> concurrent page faults during fork operation and avoids this issue.
> This fix can potentially regress some fork-heavy workloads. Kernel build
> time did not show noticeable regression on a 56-core machine while a
> stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> shows ~7% regression. If such fork time regression is unacceptable,
> disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> optimizations are possible if this regression proves to be problematic.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org/
> Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@applied-asynchrony.com/
> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217624
> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling first")
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: David Hildenbrand <david@redhat.com>

Feel free to keep my ACK on minor changes.

-- 
Cheers,

David / dhildenb

