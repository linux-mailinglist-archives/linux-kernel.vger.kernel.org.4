Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B46C7B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjCXJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96F44B8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679650041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWhXTP1kYEnMLAa75VOBYDvRlIhdjbL3EM4hrj/3sgg=;
        b=QVRaXN0pjpHD854dNsHkL6D+784rX1l4q8HKsLiHdNk84zjelGkr0IfJR3M8C2I5yIcA9I
        +EU1FrbGS5dzjGU6jNvCd0XliEakKTOJeVWfTIs1QA7R/HQB8X0uXSPd3DVagFQCsP28HP
        V+Qm2wfMHlqWRfuAoDUxBmrridTQEa8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-wjrpyKatOmmPsA4TnGEtQQ-1; Fri, 24 Mar 2023 05:27:17 -0400
X-MC-Unique: wjrpyKatOmmPsA4TnGEtQQ-1
Received: by mail-wm1-f69.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so747803wmb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650036;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWhXTP1kYEnMLAa75VOBYDvRlIhdjbL3EM4hrj/3sgg=;
        b=XA3xTKBayGMKmVSi5QwNwnu8KfuVd2d7dZ5qSpTnc9j06inyuJQ9u7f3C7wJHv7Yi2
         XjGY7EKEoJT/NrDjitkxAHqWBPoa/ZGGH9tutcwk8u5KoqKjKotCWI1DiI1/hjoZDyN4
         YBD4vC7TgZupRiUncFfEezXD9rYTJjKSbGfQXzUu68Yy53jJWAQw/Vcy76Tn68IDkh09
         X4SJHO09FIQzHsfwE62Uk9iocLdcmZXRrwBEIZkktcc+gfnJDGm2C0qIDjUCn1g0BnDe
         g8Rf3fr7BPWN8JcKe+4dmXvi4yjzG2nXAmIoKj0tKiwZ0R3BuL+bQKBodtC9x3eoD6wy
         kmFg==
X-Gm-Message-State: AAQBX9fKSCYHPhz3teU3FTuXM+nbbHOtNwZ3Wby+ChSZldzq2f5ohgw/
        IU9Cp+S2RqqE6AtNhFq+R5FgR8vA7hIwtoQRlPiq9UjiSqVFzk0GEVBwpG9a6Xt5icpweV5Bspp
        5mU2v5e0nKlpnT0es3CvV1Zck
X-Received: by 2002:a5d:5392:0:b0:2db:9ccf:f9f5 with SMTP id d18-20020a5d5392000000b002db9ccff9f5mr1682375wrv.0.1679650036527;
        Fri, 24 Mar 2023 02:27:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350YTEBLA2pJyv5qJNa1J//kezB8wWdhXgbC095qkzO9M7Qq7+vT94McBR17Ctk+RTTaNNFGsyg==
X-Received: by 2002:a5d:5392:0:b0:2db:9ccf:f9f5 with SMTP id d18-20020a5d5392000000b002db9ccff9f5mr1682356wrv.0.1679650036197;
        Fri, 24 Mar 2023 02:27:16 -0700 (PDT)
Received: from [10.105.158.254] ([88.128.92.189])
        by smtp.gmail.com with ESMTPSA id fk6-20020a05600c0cc600b003ee7169d57dsm4286316wmb.40.2023.03.24.02.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:27:15 -0700 (PDT)
Message-ID: <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
Date:   Fri, 24 Mar 2023 10:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
Organization: Red Hat
In-Reply-To: <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
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

On 21.03.23 20:32, David Hildenbrand wrote:
> On 20.03.23 22:27, Luis Chamberlain wrote:
>> On Mon, Mar 20, 2023 at 02:23:36PM -0700, Luis Chamberlain wrote:
>>> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
>>>> Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
>>>
>>> Oh wow, so to clarify, it boots OK?
>>>
>>
>> Now that we know that tree works, I'm curious also now if you can
>> confirm just re-ordering the patches still works (it should)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts-adjust
>>
> 
> So far no vmap errors booting the debug/kasan kernel (2 tries).
> 
>> And although it's *probably* just noise, but I'm very curious how much,
>> if any difference there is if you just revert "module: use
>> list_add_tail_rcu() when adding module".
> 
> Dito, no vmap errors booting the debug/kasan kernel (2 tries).
> 
>>
>> The data on that commit log is pretty small as I have a low end system,
>> and I'm not yet done beating the hell out of a system with stress-ng,
>> but getting some data froma  pretty large system would be great.
>> Specially if this series seems to prove fixing boot on them.
> 
> 2x booting RHEL9.1 on a !debug kernel. Something went wrong with kdump in 2 runs (think I
> had to delete the kdump initrd to make space for another kernel), but we can just mostly
> ignore that. I wanted to rerun with kdump disabled completely, but I'm out of time for today.
> 
> 
> 1) v6.3-rc1:
> 
> #1
> 
> Startup finished in 25.354s (kernel) + 7.662s (initrd) + 1min 8.805s (userspace) = 1min 41.822s
> multi-user.target reached after 29.186s in userspace
> 
> 47.178s kdump.service
> 14.898s tuned.service
> 11.394s chrony-wait.service
>    7.486s systemd-udev-settle.service
>    7.334s NetworkManager-wait-online.service
>    2.908s initrd-switch-root.service
>    2.451s smartd.service
>    2.316s dracut-initqueue.service
>    2.057s polkit.service
>    1.290s NetworkManager.service
>    1.046s cups.service
>    ...
> 
> #2
> 
> Startup finished in 25.375s (kernel) + 7.497s (initrd) + 29.428s (userspace) = 1min 2.301s
> multi-user.target reached after 29.392s in userspace
> 
> 14.552s tuned.service
>    9.410s chrony-wait.service
>    8.126s systemd-udev-settle.service
>    7.502s NetworkManager-wait-online.service
>    2.871s initrd-switch-root.service
>    2.401s kdump.service
>    2.297s polkit.service
>    2.116s dracut-initqueue.service
>    2.027s smartd.service
>    1.262s NetworkManager.service
>    1.102s cups.service
>    1.011s sshd.service
>    ...
> 
> 
> 2) 20230319-module-alloc-opts-adjust + revert of list_add_tail_rcu():
> 
> #1
> 
> Startup finished in 25.441s (kernel) + 7.285s (initrd) + 1min 7.644s (userspace) = 1min 40.371s
> multi-user.target reached after 27.213s in userspace
> 
> 47.232s kdump.service
> 14.235s tuned.service
>    8.220s chrony-wait.service
>    7.444s NetworkManager-wait-online.service
>    5.986s systemd-udev-settle.service
>    2.881s initrd-switch-root.service
>    2.236s smartd.service
>    1.899s dracut-initqueue.service
>    1.812s polkit.service
>    1.554s NetworkManager.service
>    1.140s ModemManager.service
>    ...
> 
> #2
> 
> Startup finished in 25.377s (kernel) + 7.271s (initrd) + 28.247s (userspace) = 1min 897ms
> multi-user.target reached after 28.210s in userspace
> 
> 15.435s tuned.service
> 11.365s chrony-wait.service
>    7.512s NetworkManager-wait-online.service
>    5.962s systemd-udev-settle.service
>    2.889s initrd-switch-root.service
>    2.846s smartd.service
>    2.819s kdump.service
>    2.228s polkit.service
>    1.872s dracut-initqueue.service
>    1.312s NetworkManager.service
>    1.152s ModemManager.service
>    1.011s sshd.service
>    ...
> 
> 3) 20230319-module-alloc-opts-adjust:
> 
> 
> #1
> 
> Startup finished in 25.320s (kernel) + 7.192s (initrd) + 1min 6.511s (userspace) = 1min 39.024s
> multi-user.target reached after 28.205s in userspace
> 
> 46.307s kdump.service
> 14.199s tuned.service
> 13.358s chrony-wait.service
>    7.468s NetworkManager-wait-online.service
>    6.329s systemd-udev-settle.service
>    2.910s initrd-switch-root.service
>    2.752s smartd.service
>    2.142s polkit.service
>    1.909s dracut-initqueue.service
>    1.210s NetworkManager.service
>    1.041s ModemManager.service
>     925ms sshd.service
>    ...
> 
> #2
> 
> Startup finished in 25.368s (kernel) + 7.303s (initrd) + 1min 6.897s (userspace) = 1min 39.569s
> multi-user.target reached after 27.326s in userspace
> 
> 45.626s kdump.service
> 14.707s tuned.service
> 13.246s chrony-wait.service
>    7.428s NetworkManager-wait-online.service
>    6.507s systemd-udev-settle.service
>    3.038s initrd-switch-root.service
>    3.001s smartd.service
>    2.057s polkit.service
>    1.746s dracut-initqueue.service
>    1.221s NetworkManager.service
>    ...
> 
> 
> I think we primarily only care about systemd-udev-settle.service.
> 
> That is fastest without the rcu patch (~6s), compared to with the rcu
> patch (~6.5s) and with stock (~7.5s -- 8s).
> 
> Looks like dracut-initqueue also might be a bit faster with your changes, but
> maybe it's mostly noise (would have to do more runs).
> 
> So maybe drop that rcu patch? But of course, there could be other scenarios where it's
> helpful ...

Are there any other things you would like me to measure/test? I'll have 
to hand back that test machine soonish.

-- 
Thanks,

David / dhildenb

