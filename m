Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0F6C3AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCUTfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCUTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC557D27
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679427185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlcJ/9nn8ownmv4J/wmbt9Hf0T3kk7qnfpp2BxFkXmI=;
        b=hXxxpxrWRmngOcADj1fhWeG7lYyW8C2WeBfOacjt2BUWUec74Y/fjpD2ZwAgwXRsZs5xcB
        VVngBAyAdold+IiEeKzOMVZUqyEGgBFnqtgx8ssYQAK79BtgCuyQDNgMyu+A7VPQzIThKT
        MCGfnmRiC6S2Q0KOIsLh8xjMhr+NMYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Hp68RoOhPIeR7Wrcztvznw-1; Tue, 21 Mar 2023 15:33:03 -0400
X-MC-Unique: Hp68RoOhPIeR7Wrcztvznw-1
Received: by mail-wm1-f70.google.com with SMTP id q21-20020a05600c46d500b003ee570749f7so65291wmo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427182;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlcJ/9nn8ownmv4J/wmbt9Hf0T3kk7qnfpp2BxFkXmI=;
        b=Te0NbfG+bDhLsnB0ye2lezRTqGqz9TyHhR2Yek/hqrcvNJbD+HLNphTgWGD0FJZ+69
         g+UAVsh8ifEkGlj5qUAw1W1lKPeqbJ2Sx/4YpDYrE8tEnH+dvO3aGZ34j5EuCpeHUkbd
         3ePmdw/q10P6jMoMxoHYINkIe1uKpedW61HjFkHREvFJIbkxd3aInRN0HAGMGbI1dR0z
         oBPpjt+6otAM3KNw7NAVUqCUVndALQxl+4cL7UQ3/AZQZ6CwrLgNDbqAICTqqABwUD+J
         39bdWiB7AO1WojW1xMapGHq3UMlqmalALourmVhUbaml8GPyDHHSxRT0mTEbIf0Q2hUp
         AQvg==
X-Gm-Message-State: AO0yUKWInWOo0QMkGCEqjdZgfsOCIi4UczVBLCk/UR85ccQqHT0HySee
        9USM3s9V0ZpmQquqwl4dQgicqFWFgBxr63ooIjaa+et32GJ7bQQ3pbeCFdO/LJ/f+AUMwmTcUz+
        OzT0BmVxqqHMYLHK9G03j9aEo
X-Received: by 2002:a5d:6342:0:b0:2ce:6f5a:c3b8 with SMTP id b2-20020a5d6342000000b002ce6f5ac3b8mr3174859wrw.31.1679427182334;
        Tue, 21 Mar 2023 12:33:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set8hqzWIYGDx/4XSP+DFg9wdkTY8zHze064b4aAkbIOEgoWyVs8q2VMLeElJD2tI+sMeG4GgaQ==
X-Received: by 2002:a5d:6342:0:b0:2ce:6f5a:c3b8 with SMTP id b2-20020a5d6342000000b002ce6f5ac3b8mr3174847wrw.31.1679427181955;
        Tue, 21 Mar 2023 12:33:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7f00:8245:d031:7f8b:e004? (p200300cbc7057f008245d0317f8be004.dip0.t-ipconnect.de. [2003:cb:c705:7f00:8245:d031:7f8b:e004])
        by smtp.gmail.com with ESMTPSA id u8-20020adfdb88000000b002cff06039d7sm12024045wri.39.2023.03.21.12.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:33:01 -0700 (PDT)
Message-ID: <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
Date:   Tue, 21 Mar 2023 20:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
In-Reply-To: <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 22:27, Luis Chamberlain wrote:
> On Mon, Mar 20, 2023 at 02:23:36PM -0700, Luis Chamberlain wrote:
>> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
>>> Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
>>
>> Oh wow, so to clarify, it boots OK?
>>
> 
> Now that we know that tree works, I'm curious also now if you can
> confirm just re-ordering the patches still works (it should)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts-adjust
> 

So far no vmap errors booting the debug/kasan kernel (2 tries).

> And although it's *probably* just noise, but I'm very curious how much,
> if any difference there is if you just revert "module: use
> list_add_tail_rcu() when adding module".

Dito, no vmap errors booting the debug/kasan kernel (2 tries).

> 
> The data on that commit log is pretty small as I have a low end system,
> and I'm not yet done beating the hell out of a system with stress-ng,
> but getting some data froma  pretty large system would be great.
> Specially if this series seems to prove fixing boot on them.

2x booting RHEL9.1 on a !debug kernel. Something went wrong with kdump in 2 runs (think I
had to delete the kdump initrd to make space for another kernel), but we can just mostly
ignore that. I wanted to rerun with kdump disabled completely, but I'm out of time for today.


1) v6.3-rc1:

#1

Startup finished in 25.354s (kernel) + 7.662s (initrd) + 1min 8.805s (userspace) = 1min 41.822s
multi-user.target reached after 29.186s in userspace

47.178s kdump.service
14.898s tuned.service
11.394s chrony-wait.service
  7.486s systemd-udev-settle.service
  7.334s NetworkManager-wait-online.service
  2.908s initrd-switch-root.service
  2.451s smartd.service
  2.316s dracut-initqueue.service
  2.057s polkit.service
  1.290s NetworkManager.service
  1.046s cups.service
  ...

#2

Startup finished in 25.375s (kernel) + 7.497s (initrd) + 29.428s (userspace) = 1min 2.301s
multi-user.target reached after 29.392s in userspace

14.552s tuned.service
  9.410s chrony-wait.service
  8.126s systemd-udev-settle.service
  7.502s NetworkManager-wait-online.service
  2.871s initrd-switch-root.service
  2.401s kdump.service
  2.297s polkit.service
  2.116s dracut-initqueue.service
  2.027s smartd.service
  1.262s NetworkManager.service
  1.102s cups.service
  1.011s sshd.service
  ...


2) 20230319-module-alloc-opts-adjust + revert of list_add_tail_rcu():

#1

Startup finished in 25.441s (kernel) + 7.285s (initrd) + 1min 7.644s (userspace) = 1min 40.371s
multi-user.target reached after 27.213s in userspace

47.232s kdump.service
14.235s tuned.service
  8.220s chrony-wait.service
  7.444s NetworkManager-wait-online.service
  5.986s systemd-udev-settle.service
  2.881s initrd-switch-root.service
  2.236s smartd.service
  1.899s dracut-initqueue.service
  1.812s polkit.service
  1.554s NetworkManager.service
  1.140s ModemManager.service
  ...

#2

Startup finished in 25.377s (kernel) + 7.271s (initrd) + 28.247s (userspace) = 1min 897ms
multi-user.target reached after 28.210s in userspace

15.435s tuned.service
11.365s chrony-wait.service
  7.512s NetworkManager-wait-online.service
  5.962s systemd-udev-settle.service
  2.889s initrd-switch-root.service
  2.846s smartd.service
  2.819s kdump.service
  2.228s polkit.service
  1.872s dracut-initqueue.service
  1.312s NetworkManager.service
  1.152s ModemManager.service
  1.011s sshd.service
  ...

3) 20230319-module-alloc-opts-adjust:


#1

Startup finished in 25.320s (kernel) + 7.192s (initrd) + 1min 6.511s (userspace) = 1min 39.024s
multi-user.target reached after 28.205s in userspace

46.307s kdump.service
14.199s tuned.service
13.358s chrony-wait.service
  7.468s NetworkManager-wait-online.service
  6.329s systemd-udev-settle.service
  2.910s initrd-switch-root.service
  2.752s smartd.service
  2.142s polkit.service
  1.909s dracut-initqueue.service
  1.210s NetworkManager.service
  1.041s ModemManager.service
   925ms sshd.service
  ...

#2

Startup finished in 25.368s (kernel) + 7.303s (initrd) + 1min 6.897s (userspace) = 1min 39.569s
multi-user.target reached after 27.326s in userspace

45.626s kdump.service
14.707s tuned.service
13.246s chrony-wait.service
  7.428s NetworkManager-wait-online.service
  6.507s systemd-udev-settle.service
  3.038s initrd-switch-root.service
  3.001s smartd.service
  2.057s polkit.service
  1.746s dracut-initqueue.service
  1.221s NetworkManager.service
  ...


I think we primarily only care about systemd-udev-settle.service.

That is fastest without the rcu patch (~6s), compared to with the rcu
patch (~6.5s) and with stock (~7.5s -- 8s).

Looks like dracut-initqueue also might be a bit faster with your changes, but
maybe it's mostly noise (would have to do more runs).

So maybe drop that rcu patch? But of course, there could be other scenarios where it's
helpful ...


-- 
Thanks,

David / dhildenb

