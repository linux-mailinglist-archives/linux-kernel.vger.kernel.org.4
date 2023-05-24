Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6670F147
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbjEXInd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjEXInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147510CC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684917738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B+1hoJpqT+pbTGuUlwiPo2e5yfvTv5Rs4wh2wPtP6U=;
        b=PjTMrgrWTEOWuq33d7XL5r16zDByKB50hjCxnjI+0Xb70QbZ9w0QD6nQth1oBKvKUFqBu7
        Aha09N6RW2E+3VX2kfI26AvJBLuBNa9LA9DoTnBxxtXtQmcy0x+szSgp94nLhgKSWgJDpo
        96yDAaN88r0mwJW4+dFRgJQfTpPJ08A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-eBdzCPhIOnikGLt6ZUfgEw-1; Wed, 24 May 2023 04:42:16 -0400
X-MC-Unique: eBdzCPhIOnikGLt6ZUfgEw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so2586205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917736; x=1687509736;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/B+1hoJpqT+pbTGuUlwiPo2e5yfvTv5Rs4wh2wPtP6U=;
        b=gQiJY62MyvUH5YWFe9YY4w8LmnLGhGLx7k0HXblFCzT/A9msvWcgGy7YR1RGOktraW
         lU27LsLk7IeWn+58YIf0oq9ciye0F/XxK1svdpVYpY/GUyf1NDMeg5XrBOugClarTyhm
         QhSCB5oGJIIIK7a6E69v58O8IJEpW8jRWWpgcd8tEl1f2C9Xa0X06L0hgyiXAwPZlLXd
         dYlxshTJGvReHhx7b6JbXnihMMl/Jz+F+VzBprq00nKjtDTPKozwiU54lpVAq3/k+3uD
         m5pYhONWuEwiMJ8V1tmn+qrsMRkAb5YTVgRW/n9S4fom1VkUsYRL2TlpnRRTLEcAJ4VC
         8ePQ==
X-Gm-Message-State: AC+VfDxxm1Q5g9Uen7t6JO+4lz1TYzqVkMyxlQdiPoej6U8nIy1sim6o
        AEYU5G8xFV2tth+474fg5DRuaG4cYXa8m0KRYmqTuY6TjJposznfrLdzdKxZX7ylN+ic4MzmV/t
        u9dT/HoJXbRMgM9AfkMWOcxzp
X-Received: by 2002:a05:600c:208:b0:3f6:389:73b1 with SMTP id 8-20020a05600c020800b003f6038973b1mr7300686wmi.6.1684917735801;
        Wed, 24 May 2023 01:42:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wRuRoddKnb48gieFESVgQ9nnsytpWldTKKrvDqsMaChqEKT8zOQrEn+6SYuIMZvLELDufjw==
X-Received: by 2002:a05:600c:208:b0:3f6:389:73b1 with SMTP id 8-20020a05600c020800b003f6038973b1mr7300664wmi.6.1684917735448;
        Wed, 24 May 2023 01:42:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:f700:24cd:855:1c60:1ff4? (p200300cbc70df70024cd08551c601ff4.dip0.t-ipconnect.de. [2003:cb:c70d:f700:24cd:855:1c60:1ff4])
        by smtp.gmail.com with ESMTPSA id l22-20020a1c7916000000b003f607875e5csm1551866wme.24.2023.05.24.01.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:42:14 -0700 (PDT)
Message-ID: <a74dc41a-d00f-e207-000f-90efa8ee82c9@redhat.com>
Date:   Wed, 24 May 2023 10:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
 <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com>
 <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
 <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
 <b2bf7ae9-983d-6c20-0781-7f37a4454bfd@google.com>
 <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wi6L6yZnGCYVEmLgQY+KEHNsAW2V69mfdUCMk4qS=GnKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.23 03:47, Linus Torvalds wrote:
> On Mon, May 22, 2023 at 5:52 PM David Rientjes <rientjes@google.com> wrote:
>>
>> Right now kernel.panic_on_warn can either be 0 or 1.  We can keep the
>> lowest bit to be "panic on all warnings" and then bit-1 as "panic on debug
>> VM warnings."  When CONFIG_DEBUG_VM is enabled, set the new bit by
>> default so there's no behavior change.
> 
> So right now CONFIG_DEBUG_VM being off means that there's nothing at
> all - not just no output, but also no code generation.
> 
> I don't think CONFIG_DEBUG_VM in itself should enable that bit-1 behavior.
> 
> That may be what *you* as a VM person wants, but VM people are not
> exactly the common case.
> 
> So I think we've got several cases:
> 
>   (a) the "don't even build it" case (CONFIG_DEBUG_VM being off)
> 
>   (b) the "build it, and it is a WARN_ON_ONCE()" case
> 
>   (c) the *normal* "panic_on_warn=1" case, which by default would panic
> on all warnings, including any warnings from CONFIG_DEBUG_VM
> 
>   (d) the "VM person" case, which might not panic on normal warnings,
> but would panic on the VM warnings.
> 
> and I think the use-cases are for different classes of kernel use:
> 
>   (a) is for people who disable debugging code until they feel it is
> needed (which I think covers a lot of kernel developers - I certainly
> personally tend to not build with debug support unless I'm chasing
> some issue down)
> 
>   (b) would probably be most distros - enable the warning so that the
> distro can report it, but try not to kill the machine of random people
> 
>   (c) would be most cloud use cases, presumably together with reboot-on-panic
> 
>   (d) would be people who are actual VM developers, and basically want
> the *current* behavior of VM_BUG_ON() with a machine that stops
> 
> and I think (d) is the smallest set of cases of all, but is the one
> you're personally interested in.

Just as a side note, I stumbled yesterday over [1], which apparently 
disables CONFIG_DEBUG_VM on !debug Fedora builds.

The commit description does not contain a rational ( it's empty :) ), 
and I don't know if this is just a temporary change.

I'll CC Justin, maybe Fedora also would like to keep building with 
CONFIG_DEBUG_VM, but default to WARN_ON_ONCE() instead.


[1] 
https://gitlab.com/cki-project/kernel-ark/-/commit/ade780e10ae1fdcb575ab100bf02d61eb12dd406

-- 
Thanks,

David / dhildenb

