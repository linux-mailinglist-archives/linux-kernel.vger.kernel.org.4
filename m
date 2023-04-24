Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FC6E4EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjDQRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDQRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:11:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E446AE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:11:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u188-20020a2560c5000000b00b8f15f2111dso18776607ybb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681751500; x=1684343500;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9oIfsogCC6DJGGLgekKu8swPJCfEf/opXZNienZZcJ4=;
        b=E+8prp4mykK3lWStRIaAu02B7fUzZ0pmhLQcJiJJLx7z7sKxeKl2RODcBtrX8QxFdq
         tewdkiQxjkMk7bGkLJw8oT5AQAjRpuRW8sHAyDiz6bIFJYfMsoBES1RmbNN70yBgp1C2
         mwpfhvYm/0cmNrGPn4mCq2lGkIXHw6mpwvVlv/uuUVfKo9Zeisy1fWOdg0aHSOS5Onyg
         +nOT5V6S+uvsJTOT3UQJidsUwMikSZp4MwkDtLLgMAleKWy4w2ofytg1gefzJBm74Oiz
         XPf3EmaFRQR4Z0tLLIIT1UrazFZpG6ou4KMyewelCZpOoJpEOgbjJFF2S/t+jAkvZoFD
         VNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751500; x=1684343500;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oIfsogCC6DJGGLgekKu8swPJCfEf/opXZNienZZcJ4=;
        b=UvLG5mLgT7kTz/+uaNbSBTglmrintPxlZzhG1k4zWjZm4pSOzX/mc4CmIXwR9LIgEO
         kgzSeerHr5RdKSHobBhTnS9S4M9nfrmLsUNuRCcfS9KjBHY2FGmsJ8wE4h9yHxXv0/qb
         RYBLJ/0Q/V426ZlTs+hJv84IJgWyHqa8LzeeUy70dFIL/D73I0+HHiqqec1XSWS+jo8X
         4yqgnnpN4XlKeuyfD3HUhywdchhOBIYD9LeFJu+gqYBmqyWyW8npnPi5UBMb5Ute/YpI
         vLk7lcFPVBRY0JN1SfJfLgm/9hKwY1OyZxEqwpQffbADbWKcqGJ24WZZXT52AIYGsfD3
         l2lw==
X-Gm-Message-State: AAQBX9eXHXsNT6qp/6KtcrqOpLhL2dIKZzcUrHf7VS5rjkwNX9R5B8QJ
        6h22fwteGkiSVpf//8TyvAc0+RilV5xdz31CGw==
X-Google-Smtp-Source: AKy350ayfmWZPcer+jYErkO4wbdaMRlZILyDd+deqLONMjmxS+bj8PXKj38BqKUWYIFsa4gWgtwr0yi9tGHqweqf1A==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a81:9f06:0:b0:533:9185:fc2c with SMTP
 id s6-20020a819f06000000b005339185fc2cmr9952614ywn.7.1681751500680; Mon, 17
 Apr 2023 10:11:40 -0700 (PDT)
Date:   Mon, 17 Apr 2023 17:11:39 +0000
In-Reply-To: <ZD12htq6dWg0tg2e@google.com> (message from Sean Christopherson
 on Mon, 17 Apr 2023 09:40:38 -0700)
Mime-Version: 1.0
Message-ID: <diqzv8huxwl0.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     david@redhat.com, chao.p.peng@linux.intel.com, pbonzini@redhat.com,
        vkuznets@redhat.com, jmattson@google.com, joro@8bytes.org,
        mail@maciej.szmigiero.name, vbabka@suse.cz, vannapurve@google.com,
        yu.c.zhang@linux.intel.com, kirill.shutemov@linux.intel.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, wei.w.wang@intel.com, rppt@kernel.org,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Apr 17, 2023, David Hildenbrand wrote:
>> On 17.04.23 17:40, Sean Christopherson wrote:
>> > I want to start referring to the code/patches by its  
>> syscall/implementation name
>> > instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the  
>> broader effort
>> > and not just the non-KVM code, and (c) will likely be confusing for  
>> future reviewers
>> > since there's nothing in the code that mentions "UPM" in any way.
>> >
>> > But typing out restrictedmem is quite tedious, and git grep shows  
>> that "rmem" is
>> > already used to refer to "reserved memory".
>> >
>> > Renaming the syscall to "guardedmem"...

>> restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask  
>> me ...

> I'm definitely open to other suggestions, but I suspect it's going to be  
> difficult
> to be more precise than something like "guarded".

> E.g. we discussed "unmappable" at one point, but the memory can still be  
> mapped,
> just not via mmap().  And it's not just about mappings, e.g. read() and  
> its many
> variants are all disallowed too, despite the kernel direct map still  
> being live
> (modulo SNP requirements).

I'm for renaming the concept because restrictedmem is quite a
mouthful. :)

How about "concealedmem" or "obscuredmem" to highlight the idea of this
memory being hidden/unreadable/unmappable from userspace?

Guarded is better than restricted but doesn't really highlight how/in
what way it is being guarded.

