Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44485F2EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJCKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJCKZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:25:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463A1837B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:25:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d18so2850530lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sqHXQiWfZXTSdiOfVyb8flw+WgtrLHXyasFJmUbbWdg=;
        b=IHrkprNGhsdefIFEF+RAkq1RClACOlBsxRtNO5uKxv+2vSZWTFv/XanwprZ4IolXqC
         oOsqj3PvxuCHutk/YeOk8XGZCBqwVVkWmHfc4uxoKCiziw4HVMsqYNpTQltgMZ8LnzGD
         7EyMdSgCeJiswh75FzML6LEBSwyIDZU8cUXxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sqHXQiWfZXTSdiOfVyb8flw+WgtrLHXyasFJmUbbWdg=;
        b=1sPIT/4jKY6+SIy7gGbSD2HxSvM1zfNY0Jf8ZKFBcXKc5XhUGJ+zPLz25rOEpBlOay
         djV6x67uiDNuDLb0SKW1HaJfVni4mTxQdIEoqOiYG7kM40Ac2LNW3CXsUo+fAGSws2aJ
         lbYkAXAjf6GVIhLMPr/7ZY34taBQ+GON9jBtQ65VyKrflM9TgiLYFKaOdIcY3xGnmL52
         eStzQLyG0ijRZvGR+JEE8HvTD1Y5z0yWKnJtROXB352oCrnRUloNQggUEayKt7EEbjp1
         ozunN12Ntg2mPG0LAqjxXAwQrVWZa6JNFWTc8W9MP44oyMW1cGahMfIMPDD/W3b1tHtX
         aWiw==
X-Gm-Message-State: ACrzQf2/w0IXeMie3BH4DRTC/nnLSTdOGdmN1EG9wRek+ue9vKgLNQCa
        H1koPzQJ0t6edAQsQ/gcVuSgTA==
X-Google-Smtp-Source: AMsMyM5lhaTQiE8PPSJiZ2DvZvafXUHD31zG1LikXYjBoPJeBa1n9O+tYRHhbr6329EWbbPGs5oIsQ==
X-Received: by 2002:a19:4315:0:b0:497:7488:7a76 with SMTP id q21-20020a194315000000b0049774887a76mr6641072lfa.286.1664792728163;
        Mon, 03 Oct 2022 03:25:28 -0700 (PDT)
Received: from [172.21.2.224] ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b0026de3bfbbd6sm116305ljb.43.2022.10.03.03.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 03:25:27 -0700 (PDT)
Message-ID: <fefe11f3-2d1f-36e0-2c3d-7f35df71c4b6@rasmusvillemoes.dk>
Date:   Mon, 3 Oct 2022 12:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: slub: make slab_sysfs_init() a late_initcall
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
 <Yzqary4Fi1sTHVSQ@hyeyoo>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Yzqary4Fi1sTHVSQ@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 10.17, Hyeonggon Yoo wrote:
> On Fri, Sep 30, 2022 at 12:27:12PM +0200, Rasmus Villemoes wrote:
>> Currently, slab_sysfs_init() is an __initcall aka device_initcall. It
>> is rather time-consuming; on my board it takes around 11ms. That's
>> about 1% of the time budget I have from U-Boot letting go and until
>> linux must assume responsibility of keeping the external watchdog
>> happy.
>>
>> There's no particular reason this would need to run at device_initcall
>> time, so instead make it a late_initcall to allow vital functionality
>> to get started a bit sooner.
>>
>> This actually ends up winning more than just those 11ms, because the
>> slab caches that get created during other device_initcalls (and before
>> my watchdog device gets probed) now don't end up doing the somewhat
>> expensive sysfs_slab_add() themselves. Some example lines (with
>> initcall_debug set) before/after:
>>
>> initcall ext4_init_fs+0x0/0x1ac returned 0 after 1386 usecs
>> initcall journal_init+0x0/0x138 returned 0 after 517 usecs
>> initcall init_fat_fs+0x0/0x68 returned 0 after 294 usecs
>>
>> initcall ext4_init_fs+0x0/0x1ac returned 0 after 240 usecs
>> initcall journal_init+0x0/0x138 returned 0 after 32 usecs
>> initcall init_fat_fs+0x0/0x68 returned 0 after 18 usecs
>>
>> Altogether, this means I now get to petting the watchdog around 17ms
>> sooner. [Of course, the time the other initcalls save is instead spent
>> in slab_sysfs_init(), which goes from 11ms to 16ms, so there's no
>> overall change in boot time.]
> 
> This looks okay and just curious,
> can you explain what kind of benefit does enabling watchdog early provides?

The watchdog is _always_ enabled, from power-on onwards. There's nothing
one can do to disable it (short of using a soldering iron to modify the
board...), and usually nothing one can do to program its timeout [if it
is at all configurable, it's done during board design using appropriate
resistor/capacitor values].

All the custom boards I've met, across the very different industries
I've worked with, have always had such an external watchdog. Their
timing requirements may vary; currently I'm working on a board which has
a 1s margin, but I've also encountered something as low as (IIRC) 400ms.

While 10-20ms may not sound impressive, this is not the first nor the
last patch I'm trying to get upstream (see e7cb072eb988 for another
example, done in connection with another project) to gain as much margin
as possible - we want to be able to continue to upgrade our kernels for
the next 5, 10, 20 years, and undoubtedly the mainline kernel will grow
features and overhead in that timespan which won't be offset by better
compilers.

Rasmus
