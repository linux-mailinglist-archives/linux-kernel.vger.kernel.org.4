Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96CC70143B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 05:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjEMDfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 23:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMDfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 23:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0346B0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683948865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5iuN8vfyC5tHnzEyX8BlDAD7L1Af+tn1GvUhlcPzN64=;
        b=EvgwzWD4YR+cWgBTCium9Bx7slgFAUQ1gptH2ooizYeup3nOmt2t3oIQZANP7+li07xsU6
        bVhuIdAql8N22nfjBZv/zQkM/B+5AhgDCNpfxoyF3H7ZpePuBQK9qm5VhoqdbWO6eD+CpN
        bqI70gfj/ddHFC2LRcOQM+LcG9Lgb1c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-q2GQn5eoOoysoi72gxDORQ-1; Fri, 12 May 2023 23:34:24 -0400
X-MC-Unique: q2GQn5eoOoysoi72gxDORQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61e209243f7so54244346d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 20:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683948863; x=1686540863;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iuN8vfyC5tHnzEyX8BlDAD7L1Af+tn1GvUhlcPzN64=;
        b=Tzchj8D5OE+hv0przOZF6akxI0vhcCKcXP9gaKBNVG6euJjlZVCMa5a5GKoWBMv7Rv
         9pO3M5krIlmpCRq8KKgg9+wkf48ssmbGYAOA2zJ75psIYrpzCoEwI24PmrJv6W1V6H75
         7gNHXXDF6p/QG07fO1hz0/JLb/Zz93htiPSPyH0jDdcKGT7HGRk4nqvIdfcyMAw0gkPZ
         vtBE6OWq0N69uu7xiqmNRiO3+I8Kd1+t/CpmYdVCh6AVXbisiA5ii7rj6o8ds/8hBoGc
         DtwmfTTjsq4ifxSPkitT2jL3SkmlAXgfVpSLG7E/U5eIXOrs8rGtdddkx/SoVIsm+zS3
         dHcw==
X-Gm-Message-State: AC+VfDzCCe2n934bHJIZZzlX4bXevK4XUt/mbngOBoqBSN0CZEIIYFVQ
        d84oL+6fsFwkEuPF5bWa5mFJ3mQFeE1xq/XOVRD4cv1ltNpIvQ0+EXkRvqYeu5i8CuPawwvCYSE
        RQLb/2DikIdhxXpRvyHK8AKDN
X-Received: by 2002:a05:6214:c8e:b0:621:5e3b:8eb1 with SMTP id r14-20020a0562140c8e00b006215e3b8eb1mr15765393qvr.21.1683948863658;
        Fri, 12 May 2023 20:34:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UkLU8K72jYx94erbkeqa4wc7P/xk0KqcPVxSx7Ix59QYYVZTGfmcAZGLxvCO/qrtHHN4mSw==
X-Received: by 2002:a05:6214:c8e:b0:621:5e3b:8eb1 with SMTP id r14-20020a0562140c8e00b006215e3b8eb1mr15765364qvr.21.1683948863330;
        Fri, 12 May 2023 20:34:23 -0700 (PDT)
Received: from ?IPV6:2603:7000:3d00:1816::1772? (2603-7000-3d00-1816-0000-0000-0000-1772.res6.spectrum.com. [2603:7000:3d00:1816::1772])
        by smtp.gmail.com with ESMTPSA id a11-20020a0ce34b000000b0061b62c1534fsm3391537qvm.23.2023.05.12.20.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 20:34:22 -0700 (PDT)
Message-ID: <2bf4062d-b3f1-671f-0aa4-7f3e98402160@redhat.com>
Date:   Sat, 13 May 2023 05:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] mm: Call arch_swap_restore() from arch_do_swap_page()
 and deprecate the latter
Content-Language: en-US
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-3-pcc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230512235755.1589034-3-pcc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.23 01:57, Peter Collingbourne wrote:
> The previous patch made it possible for MTE to restore tags before they
> are freed by hooking arch_do_swap_page().
> 
> However, the arch_do_swap_page() hook API is incompatible with swap
> restoration in circumstances where we do not have an mm or a vma,
> such as swapoff with swapped out shmem, and I expect that ADI will
> currently fail to restore tags in these circumstances. This implies that
> arch-specific metadata stores ought to be indexed by swap index, as MTE
> does, rather than by mm and vma, as ADI does, and we should discourage
> hooking arch_do_swap_page(), preferring to hook arch_swap_restore()
> instead, as MTE already does.
> 
> Therefore, instead of directly hooking arch_do_swap_page() for
> MTE, deprecate that hook, change its default implementation to call
> arch_swap_restore() and rely on the existing implementation of the latter
> for MTE.
> 
> Fixes: c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")

Can you enlighten me how this change fixes that commit? I'm afraid I am 
missing something important.

What is the user-visible impact of the problem, how was it caused by 
c145e0b47c77, and how does your change fix it?

-- 
Thanks,

David / dhildenb

