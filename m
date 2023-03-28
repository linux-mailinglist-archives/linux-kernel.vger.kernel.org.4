Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CA6CB50A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjC1Dpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjC1Dpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE4119
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679975084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGsWCWFcsRTCj27da+bOG6uBGGOSCaHoKd3MVYwOIVA=;
        b=LJ1zjSPQKplsg0FZpAJDTS+UdlCGYEUyUsOaDiebhfVkuQfGJO8uPLgchknQy3IactIfA3
        grEvRilK/0MvLF+OLmppBkRL2HBonU1t5UaZoPIJCLglXhofhsi313N5kGdmBQTEELJ2r4
        /MK63ECYW4Vkn/mRnvOgjzwRxbv34UE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-m4868xp3PRyqxDbrXH1D0Q-1; Mon, 27 Mar 2023 23:44:43 -0400
X-MC-Unique: m4868xp3PRyqxDbrXH1D0Q-1
Received: by mail-pj1-f72.google.com with SMTP id pm10-20020a17090b3c4a00b0023ff02aced2so294537pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975082;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGsWCWFcsRTCj27da+bOG6uBGGOSCaHoKd3MVYwOIVA=;
        b=a/yzk1pPbrdELybZE8s/5BtwoYZZw5JibhRTexxJvmn4pJxHZsDYurJKLf+bAJvkiF
         2z1p24mEKumD536kCsSAqfC1XLl2zbR/XmS8zFc3usyhOesF9DNkl1NoSNk9aEOTC6Qq
         +9jHVrqxGcq2Nd5M04eyOAPQ++yCeBKLDXDodErDtryMP3+ay5heuaT3+dnpUnAjXefb
         4AnCfk8NDaT3wgOnAarbAOQGmNQ0qH/Rt6AGheqzZZHKnK7d3AF49bIlHd9USvPR8vMY
         kxO1ZH9Y2CGa0QymCWsgY51eBN6e/KwNAMw27jfH0LZnPs/G2ZmVHj29JzVY30BrjBMh
         at1Q==
X-Gm-Message-State: AO0yUKWDyMGMG1wpWNYpzReRlc24QopxRZjp42eRAVGNnlr/bM17sq+y
        6f4DMh8RVM7+TUvVx6QG3HjAPGLW9bQu2ARJOYPKtkIB3ChbMkB60TcuRW5mTYHeeTI9SlQclZQ
        glO8gxho3Bby0krxKSORZBA4/
X-Received: by 2002:a05:6a00:1795:b0:594:1f1c:3d3b with SMTP id s21-20020a056a00179500b005941f1c3d3bmr24728542pfg.16.1679975081960;
        Mon, 27 Mar 2023 20:44:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set/tpTd585T701bQkjO69ohplMftC4Y2vpH8cUhDqou/9ybudJIPfebAcuXMgTiQZL7sKIklpA==
X-Received: by 2002:a05:6a00:1795:b0:594:1f1c:3d3b with SMTP id s21-20020a056a00179500b005941f1c3d3bmr24728516pfg.16.1679975081431;
        Mon, 27 Mar 2023 20:44:41 -0700 (PDT)
Received: from [192.168.35.160] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id d10-20020a634f0a000000b0050f56964426sm16783232pgb.54.2023.03.27.20.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 20:44:41 -0700 (PDT)
Message-ID: <e5c2183a-f62a-6ca9-eec6-a7fab7ce4c91@redhat.com>
Date:   Tue, 28 Mar 2023 05:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
References: <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.23 18:54, Luis Chamberlain wrote:
> On Fri, Mar 24, 2023 at 10:27:14AM +0100, David Hildenbrand wrote:
>> On 21.03.23 20:32, David Hildenbrand wrote:
>>> On 20.03.23 22:27, Luis Chamberlain wrote:
>>>> On Mon, Mar 20, 2023 at 02:23:36PM -0700, Luis Chamberlain wrote:
>>>>> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
>>>>>> Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
>>>>>
>>>>> Oh wow, so to clarify, it boots OK?
>>>>>
>>>>
>>>> Now that we know that tree works, I'm curious also now if you can
>>>> confirm just re-ordering the patches still works (it should)
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts-adjust
>>>>
>>>
>>> So far no vmap errors booting the debug/kasan kernel (2 tries).
> 
> <-- snip -->
> 
>>> I think we primarily only care about systemd-udev-settle.service.
>>>
>>> That is fastest without the rcu patch (~6s), compared to with the rcu
>>> patch (~6.5s) and with stock (~7.5s -- 8s).
>>>
>>> Looks like dracut-initqueue also might be a bit faster with your changes, but
>>> maybe it's mostly noise (would have to do more runs).
>>>
>>> So maybe drop that rcu patch? But of course, there could be other scenarios where it's
>>> helpful ...
> 
> Yes I confirm the RCU patch does not help at all now also using
> stress-ng.
> 
>> Are there any other things you would like me to measure/test? I'll have to
>> hand back that test machine soonish.
> 
> Yes please test the below. Perhaps its not the final form we want, but
> it *does* fix OOM'ing when thrashing with stress-ng now with the module
> option and even with 100 threads brings down max memory consumption by
> 259 MiB. The reason is that we also vmalloc during each finit_read_file()
> for each module as well way before we even do layout_and_allocate(), and
> so obviously if we fix the module path but not this path this will eventually
> catch up with us as. I'm not at all happy with the current approach given
> ideally we'd bump the counter when the user is done with the file, but we
> don't yet have any tracking of that for users, they just vfree the memory
> itself. And so this is just trying to catch heavy immediate abuse on the
> caller to fend off abuse of vmalloc uses in a lightway manner.

Understood. (I'm planning on review one I have time some spare cycles)

> 
> There's gotta be a better way to do this, but its just an idea I have so far.
> If we *want* to keep tabs until the user is done, we have to just modify
> most users of these APIs and intrudce our own free. I don't think we're
> in a rush to fix this so maybe that's the better approach.
> 
> And so I've managed to reproduce the issues you found now with my new stress-ng
> module stressor as well.

Nice!

> 
> https://github.com/ColinIanKing/stress-ng.git
> 
> Even though you have 400 CPUs with stress-ng we can likely reproduce it
> with (use a module not loaded on your system):
> 
> ./stress-ng --module 100 --module-name xfs

I'll give that a churn on that machine with the updated patch ...

> 
> Without the patch below using 400 threads still OOMs easily due to the
> kread issue. Max threads allowed are 8192.
> 

... do you have an updated patch/branch that includes the feedback from 
Linus so I can give it a churn tomorrow?

-- 
Thanks,

David / dhildenb

