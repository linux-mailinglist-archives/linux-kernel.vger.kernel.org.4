Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB756D7C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjDEMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbjDEMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE34203
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680696024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RSlHLlJfuqzoKBsSMqongiC+StHcDiIfT1vSmb6xVfw=;
        b=g7kiVUStmMqlVf6kKVkdAaBI6r+wCGh1ipMKnr0c8EMjpfYZ4c2BiN7Ny8x9g4vBp3WYAM
        0dfvO5luk2oRbpGJ2yGEIL0bJDqwiYRwBes6k87LtPnkdMElgeeJOKlVuRoSmmNaAeB9Vp
        mLOBSm9pljj1GFwaDca8gEHWvDFtCXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-cKd_yAZjPvqDJjqzg3TqRA-1; Wed, 05 Apr 2023 08:00:23 -0400
X-MC-Unique: cKd_yAZjPvqDJjqzg3TqRA-1
Received: by mail-wm1-f69.google.com with SMTP id o7-20020a05600c4fc700b003edf85f6bb1so19054835wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 05:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680696021;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSlHLlJfuqzoKBsSMqongiC+StHcDiIfT1vSmb6xVfw=;
        b=tMrW+ryfvLFA71fGQKPHGmGqA+3P94dtRNJBzMc7nzICyRl4lQ2d/HVpcabkRQ8lmB
         EybBji9nUpiRaPpiL7f8qaGwbunnWIIiTTr+M6kJG6uWH+jGrE7dmhpAXbdF2YBQ6gE3
         XimPoCuSwkWt1wkUgv7XaLVvC6p+xcOUpRRWyDEbSeLen60LDELkuC94WlU9I0h10SKE
         VB4bMkxF/gr2LpNmUiGTkj0oxQWyvbEhv39q9wssDrVUgjiyut3bKvvIzuwK3PPEl4H4
         GQh6luVR/GNNVpMLZOdFvaY9jvhJTKbP5qK8W3aEHoscIL32FevLAbxZ7v2wzz8TOq/e
         0cOQ==
X-Gm-Message-State: AAQBX9dz3DNmcDwbjWTGanl7UxaWTAgcvSFTHvwYfL/PsC9ig2sx7FjZ
        /j8fQWsmrwvUH2HZW6q3WN0y2TNlb1pURy9GvyNMSsYJkBvPZ2l7cb0Xx03pLZvDgR1ogEIz4ZV
        W8sYV+KydN9c6lshIk0K3N1Ek
X-Received: by 2002:adf:f851:0:b0:2c6:85ef:4086 with SMTP id d17-20020adff851000000b002c685ef4086mr4082478wrq.32.1680696020602;
        Wed, 05 Apr 2023 05:00:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1LUfUOKuj3jMotBlpC19SVSB9cyW7enGegvzefcAmYdi8D6SEfOrURf0tsGiN5OpOE9NhWQ==
X-Received: by 2002:adf:f851:0:b0:2c6:85ef:4086 with SMTP id d17-20020adff851000000b002c685ef4086mr4082439wrq.32.1680696020257;
        Wed, 05 Apr 2023 05:00:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id b13-20020adff24d000000b002c573778432sm14717731wrp.102.2023.04.05.05.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 05:00:19 -0700 (PDT)
Message-ID: <480e9492-2043-4788-eaff-4995e9e3b56e@redhat.com>
Date:   Wed, 5 Apr 2023 14:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com, alougovs@redhat.com
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com> <ZC1Q7uX4rNLg3vEg@lothringen>
 <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230405114148.GA351571@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.23 13:41, Peter Zijlstra wrote:
> On Wed, Apr 05, 2023 at 01:10:07PM +0200, Frederic Weisbecker wrote:
>> On Wed, Apr 05, 2023 at 12:44:04PM +0200, Frederic Weisbecker wrote:
>>> On Tue, Apr 04, 2023 at 04:42:24PM +0300, Yair Podemsky wrote:
>>>> +	int state = atomic_read(&ct->state);
>>>> +	/* will return true only for cpus in kernel space */
>>>> +	return state & CT_STATE_MASK == CONTEXT_KERNEL;
>>>> +}
>>>
>>> Also note that this doesn't stricly prevent userspace from being interrupted.
>>> You may well observe the CPU in kernel but it may receive the IPI later after
>>> switching to userspace.
>>>
>>> We could arrange for avoiding that with marking ct->state with a pending work bit
>>> to flush upon user entry/exit but that's a bit more overhead so I first need to
>>> know about your expectations here, ie: can you tolerate such an occasional
>>> interruption or not?
>>
>> Bah, actually what can we do to prevent from that racy IPI? Not much I fear...
> 
> Yeah, so I don't think that's actually a problem. The premise is that
> *IFF* NOHZ_FULL stays in userspace, then it will never observe the IPI.
> 
> If it violates this by doing syscalls or other kernel entries; it gets
> to keep the pieces.

Yair is currently on vacation, so I'm replying on his behalf.

Indeed, RT userspace is supposed to not call into the kernel, that's the 
premise.

-- 
Thanks,

David / dhildenb

