Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2869EF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBVHx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVHx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:53:27 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364802A6F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:53:25 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id x10so25989952edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRUJGTjkaCNDjUk3Aj5+9Sbhj8bvPT3tAp7C9bfAy0A=;
        b=ikNLlsHXuNpvhGq2irfhssj1t1pZ15I1zbXUXx5cHujjqjLRpx35ncI+ThYT2B6V/5
         Q5ahv0+OCRIswQ/z9ajJ3RwlqGLkDwLeQWSkaEH+zCeHQhwRiDkwyoaBKeIuY1OsnviH
         wDxbwZISPtiKN5z0syGQeuPyV4rW9GUESzVNA9GIl9GZZYqOwPSaJ2BIJS869mapv4VF
         1N/8vv4ccOoLdx1IRo5Fs2lM5yepxSsSd5riiMuXTvxiYGJtr30bgKPufmiuyL+f0j/Y
         sSW0M6tp8sajXIOOy1GVLd424zwM7HUysMBGjG9SHj/hixhGGcseH4xr77zf3zALgQnv
         FhUQ==
X-Gm-Message-State: AO0yUKXBbqWJiHpoOxggqU24RVZZKbzqF1SFYLbwgjwXQAaEPnmoJWwr
        55XQJKDLPvW8uP0gVrzlLcc=
X-Google-Smtp-Source: AK7set+Ebwe/bT5FgFMGGJg3bTLLBl44VRUiqX98eu2A/i4FkipZXIM4D0gY2T4vSnSZCO4bSuyY3w==
X-Received: by 2002:aa7:cfd7:0:b0:4a2:223d:4514 with SMTP id r23-20020aa7cfd7000000b004a2223d4514mr7824354edy.8.1677052403737;
        Tue, 21 Feb 2023 23:53:23 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id v20-20020a50d594000000b004ad7962d5bbsm3532805edi.42.2023.02.21.23.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:53:23 -0800 (PST)
Message-ID: <b9d36537-bc94-71e5-a967-cd4cec50baf2@kernel.org>
Date:   Wed, 22 Feb 2023 08:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Hyunwoo Kim <imv4bel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <20220919040701.GA302806@ubuntu>
 <63030af8-5849-34b3-10e6-b6ce32c3a5bf@kernel.org>
 <c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] char: pcmcia: cm4000_cs: Fix use-after-free in
 cm4000_fops
In-Reply-To: <c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 02. 23, 13:43, Arnd Bergmann wrote:
> On Tue, Feb 21, 2023, at 07:51, Jiri Slaby wrote:
>> Ping -- what's the status of these?
>>
>> Should we mark cm4000_cs, cm4040_cs, and scr24x_cs as BROKEN instead?
> 
> A few bug fixes ago, I think we had all agreed that the drivers can
> just be removed immediately, without a grace period or going through
> drivers/staging [1]. We just need someone to send the corresponding
> patches.
> 
> While looking for those, I see that Dominik also asked the
> broader question about PCMCIA drivers in general [2] (sorry
> I missed that thread at the time), and Linus just merged my
> boardfile removal patches that ended up dropping half of the
> (arm32) soc or board specific socket back end drivers.
> 
> Among the options that Dominik proposed in that email, I would
> prefer we go ahead with b) and remove most of the drivers that
> have no known users. I think we can be more aggressive though,
> as most of the drivers that are listed as 'some activity in
> 2020/21/22' seem to only be done to fix the same issues that
> were found in ISA or PCI drivers.

So let me start with removal of all (both + and -) listed[2] 
drivers/char/pcmcia/ drivers. That includes all three racy/buggy ones. 
And let's see what happens.

Personal not: this will also remove synclinc_cs \o/. Mostly only we, the 
tty people, were forced to touch the driver and I really hate it.

 > [2] 
https://lore.kernel.org/all/Y07d7rMvd5++85BJ@owl.dominikbrodowski.net/

thanks,
-- 
js
suse labs

