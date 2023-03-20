Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07256C107F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCTLPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCTLPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD67EFA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679310745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJ15X8eEBoReGB3C7dgMotTyQB0TWQzRlQNvijJlTog=;
        b=A12RTTwUSmNAOSyBGLFvl5q3ZCRJsH0iXlZlADgPJF3S+ISBtXIC2pyTyac7g38YCXmXss
        GtkV5+PlC1zaS53vJAl5HOREzVNzHdYMmfNBwOmNurZmd7VEXK5SPdKAi0UPiCHDXCJDZC
        B1cjjxi5gBxnaZFkKnIsTpEft6ydv54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-2cTALwfDO76vVMYVv8DI1A-1; Mon, 20 Mar 2023 07:12:24 -0400
X-MC-Unique: 2cTALwfDO76vVMYVv8DI1A-1
Received: by mail-wm1-f71.google.com with SMTP id k18-20020a05600c1c9200b003ed2a3f101fso8267310wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679310742;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJ15X8eEBoReGB3C7dgMotTyQB0TWQzRlQNvijJlTog=;
        b=2AqrYlyjcjAUtwBJrOLTb+iZpyJyxe6t8nkN1bcGtXJsq3nccrfveJhEPf7SyGbtOR
         PccfiByxsmPf55MJDrQ3KwHUr7sO1nPUIwKJ7T1sSKhmh2lT5DJcWJ3LV1MHA9QOVg65
         MDxXKgLy78lD2BAvz/Twn8kofPtiuwS8S19r0N2tyGP/qha06+CDl5I14ARrGMjuSNFV
         WjMUjycjjQr7Vhj/zIMNx0eXkgji277FKwFasMT/xtEKfQVyfwPaO4tFnjLSoMp8OZ1l
         pnVV+E9YKl6q83uGr1/pRTj/VjtsU06qefB0Nl2fqB1GofO7WkVTV2yXBu9CtjgYtoGz
         /H5w==
X-Gm-Message-State: AO0yUKWLiE4joF/WWkMlbZHlx44OCXJi085nFgvgrMqELBy/F+Hrhlwo
        W/hSIqjXS+jfv+fIzoaVek4BL+/sUzEGozUnHmBEYzfk0jWG2nrrfsIFyDrt/tHYeHtBedYXg5z
        ez8Dy16TgKGljRjXzhW3sA/4X
X-Received: by 2002:a5d:5259:0:b0:2cf:eed0:f6fb with SMTP id k25-20020a5d5259000000b002cfeed0f6fbmr14079813wrc.32.1679310742727;
        Mon, 20 Mar 2023 04:12:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set/QgW3xbA+eM9GpmqPmpL+xxrC+Ghr2e5Lw+gQQJPunHxEQKtVdh0x1jsB99FFjG5tziq1xFg==
X-Received: by 2002:a5d:5259:0:b0:2cf:eed0:f6fb with SMTP id k25-20020a5d5259000000b002cfeed0f6fbmr14079797wrc.32.1679310742435;
        Mon, 20 Mar 2023 04:12:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d4dcb000000b002cfe3f842c8sm8575853wru.56.2023.03.20.04.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 04:12:21 -0700 (PDT)
Message-ID: <655ca9fd-ddc3-0bfa-b442-fc60cda02baa@redhat.com>
Date:   Mon, 20 Mar 2023 12:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: THP backed thread stacks
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230306235730.GA31451@monkey>
 <ZBSo+mLUOsKvy3rC@casper.infradead.org> <20230317184632.GA69459@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230317184632.GA69459@monkey>
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

On 17.03.23 19:46, Mike Kravetz wrote:
> On 03/17/23 17:52, Matthew Wilcox wrote:
>> On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
>>> One of our product teams recently experienced 'memory bloat' in their
>>> environment.  The application in this environment is the JVM which
>>> creates hundreds of threads.  Threads are ultimately created via
>>> pthread_create which also creates the thread stacks.  pthread attributes
>>> are modified so that stacks are 2MB in size.  It just so happens that
>>> due to allocation patterns, all their stacks are at 2MB boundaries.  The
>>> system has THP always set, so a huge page is allocated at the first
>>> (write) fault when libpthread initializes the stack.
>>
>> Do you happen to have an strace (or similar) so we can understand what
>> the application is doing?
>>
>> My understanding is that for a normal app (like, say, 'cat'), we'll
>> allow up to an 8MB stack, but we only create a VMA that is 4kB in size
>> and set the VM_GROWSDOWN flag on it (to allow it to magically grow).
>> Therefore we won't create a 2MB page because the VMA is too small.
>>
>> It sounds like the pthread library is maybe creating a 2MB stack as
>> a 2MB VMA, and that's why we're seeing this behaviour?
> 
> Yes, pthread stacks create a VMA equal to stack size which is different
> than 'main thread' stack.  The 2MB size for pthread stacks created by
> JVM is actually them explicitly requesting the size (8MB default).
> 
> We have a good understanding of what is happening.  Behavior actually
> changed a bit with glibc versions in OL7 vs OL8.  Do note that THP usage
> is somewhat out of the control of an application IF they rely on
> glibc/pthread to allocate stacks.  Only way for application to make sure
> pthread stacks do not use THP would be for them to allocate themselves.
> Then, they would need to set up the guard page themselves.  They would
> also need to monitor the status of all threads to determine when stacks
> could be deleted.  A bunch of extra code that glibc/pthread already does
> for free.
> 
> Oracle glibc team is also involved, and it 'looks' like they may have
> upstream buy in to add a flag to explicitly enable or disable hugepages
> on pthread stacks.
> 
> It seems like concensus from mm community is that we should not
> treat stacks any differently than any other mappings WRT THP.  That is
> OK, just wanted to throw it out there.

I wonder if this might we one of the cases where we don't want to 
allocate a THP on first access to fill holes we don't know if they are 
all going to get used. But we might want to let khugepaged place a THP 
if all PTEs are already populated. Hm.

-- 
Thanks,

David / dhildenb

