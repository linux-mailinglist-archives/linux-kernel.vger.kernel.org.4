Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83DC6A935E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCCJGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCCJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93123659
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677834360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YS0CjwhYVbsUEzzioDGeRBPspcNXXioriZQMTd1XWIQ=;
        b=gOIn/CrUMxrg3g+RkC088rjIXObfEiu3mcPhNEvmGr7qLKqtkqzSIz4pO0Cb7Ua1JPL2ys
        eK9p5oFvMm4jppzJBd8+7ZCsceyEbYrpTy9X3v/KjmjDXiX+pyWb1YHQJDEdy+7efy6IwC
        UPD5rrRW/fL9zKxmCOn11V1ji+yUfKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494-PGe70pWmOxu44z8WjTnUVQ-1; Fri, 03 Mar 2023 04:05:53 -0500
X-MC-Unique: PGe70pWmOxu44z8WjTnUVQ-1
Received: by mail-wm1-f69.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so2534083wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS0CjwhYVbsUEzzioDGeRBPspcNXXioriZQMTd1XWIQ=;
        b=34K73oKT1awgNlTwIijHcHDWL4LoAiPTCiB76bRaN+ZdCTZjHPpC3acm//SVn6xF3X
         +3Hr3J4xRvusp7BwuZ8MTr3AKZimhqB2jt/crq6mzvmFXoqfKDDiPqcxF4CaT/sID7BC
         k0c3FGwdqGlLK76ZGoH6OBTOrKEBNOAtAdGpWUDEEZSgPi34M5Z+2EadpGyQ4aOzfHx7
         sjtrgbdCqbpZu6mj6bsPoM3GY58t6+4tr1DddUtR2bUmkFEZAKDH672e5h7jLBfk/WQK
         Gvkg6ZMiipbAEJBkDN4pm7BOXd91aER/XKGMkdhhtUAoRmX+hbiKbyCwHo1fEMadet7c
         Xcdw==
X-Gm-Message-State: AO0yUKXzcRN5WwHpNEE1j5GcqQwZkCNt+vJmaroEAfU13hy6lvXndywp
        2xrXqaQ9q4OG/qZKblW7n2s6GeXS8yBD4ObVbZ4ZySzJ90jF4pk3nPu4h1ylqNvOYOLWV+QrxV2
        u9s3bzA1rW30h9RhjrcauhoDx
X-Received: by 2002:a05:600c:46d1:b0:3e1:f8af:8772 with SMTP id q17-20020a05600c46d100b003e1f8af8772mr962685wmo.9.1677834352102;
        Fri, 03 Mar 2023 01:05:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8jagMcNMmXQyfHV0dH3kB3yk7ffQXREEni9HXk4xFVSy4fCDC0ZRzxCl37hRsdKx/W7igNWA==
X-Received: by 2002:a05:600c:46d1:b0:3e1:f8af:8772 with SMTP id q17-20020a05600c46d100b003e1f8af8772mr962632wmo.9.1677834351710;
        Fri, 03 Mar 2023 01:05:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6100:f5c9:50a5:3310:d8ac? (p200300cbc7026100f5c950a53310d8ac.dip0.t-ipconnect.de. [2003:cb:c702:6100:f5c9:50a5:3310:d8ac])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d408e000000b002bfd524255esm1593826wrp.43.2023.03.03.01.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:05:51 -0800 (PST)
Message-ID: <787e7d9a-fcf4-ad5f-97f1-c0e1c1553c2d@redhat.com>
Date:   Fri, 3 Mar 2023 10:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230301190457.1498985-1-surenb@google.com>
 <31a88065-063a-727e-52fd-9fbc7d17fb5c@redhat.com>
 <CAJuCfpGKK5SwxQr_BKrqnn0ZeaLVtX=n31MbKUwdnSSd4umB3A@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/1] mm/nommu: remove unnecessary VMA locking
In-Reply-To: <CAJuCfpGKK5SwxQr_BKrqnn0ZeaLVtX=n31MbKUwdnSSd4umB3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Just a general comment: usually, if review of the original series is
>> still going on, it makes a lot more sense to raise such things in the
>> original series so the author can fixup while things are still in
>> mm-unstable. Once the series is in mm-stable, it's a different story. In
>> that case, it is usually good to have the mail subjects be something
>> like  "[PATCH mm-stable 1/1] ...".
> 
> Ok... For my education, do you mean the title of this patch should
> somehow reflect that it should be folded into the original patch? Just
> trying to understand the actionable item here. How would you change
> this patch when posting for mm-unstable and for mm-stable?

For patches that fixup something in mm-stable (stable commit ID but not 
yet master -> we cannot squash anymore so we need separate commits), 
it's good to include "mm-stable". The main difference to patches that 
target master is that by indicating "mm-stable", everyone knows that 
this is not broken in some upstream/production kernel.


For patches that fixup something that is in mm-unstable (no stable 
commit ID -> still under review and fixup easily possible), IMHO we 
distinguish between two cases:

(1) You fixup your own patches: simply send the fixup as reply to the 
original patch. Andrew will pick it up and squash it before including it 
in mm-stable. Sometimes a complete resend of a series makes sense instead.

(2) You fixup patches from someone else: simply raise it as a review 
comment in reply to the original patch. It might make sense to send a 
patch, but usually you just raise the issue to the patch author as a 
review comment and the author will address that. Again, Andrew will pick 
it up and squash it before moving it to mm-stable.


That way, it's clearer when stumbling over patches on the mailing list 
if they fix a real issue in upstream, fix a issue in 
soon-to-be-upstream, or are simply part of a WIP series that is still 
under review.

-- 
Thanks,

David / dhildenb

