Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F597062F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjEQIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjEQIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC4526A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCs/dUVErnBMZp0vS+8RY4FN1qN1vupcxjp7vnWl9AY=;
        b=QmrmO1VSBEEHkB+x8d8E2JOrmT/jf3u37fwy5iUN52Y5TrUCuWup7f0TmnmC7qjMJ6Rujb
        HLm0az9R4Ik4Clzohlr7Jtl29Xxi7/GvuxgK5inXNkY0+ioqxhyqHuFmpfHQWaOtgxUcdw
        30qnTle4XWldeYhpSp3lGatsrX2zsFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-aPj-ReVyNVWWVLCCqqYdKw-1; Wed, 17 May 2023 04:30:23 -0400
X-MC-Unique: aPj-ReVyNVWWVLCCqqYdKw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f433a2308bso39900975e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312222; x=1686904222;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCs/dUVErnBMZp0vS+8RY4FN1qN1vupcxjp7vnWl9AY=;
        b=PTWTkTHio/5ehe9KdyXvNprVwgnQBBtD4vg7RENsftGwX9vDGSL2fDXZk0Nj1AfZAR
         IQJeyqIFiKOnXwBB5utMAg+lURWbypekpobeJFB7MjYwk5mFshh1H6tP/X/gJj051qM4
         dVJwn3T92Cfn/m3+NiCM364SpQw4KaNP6Z23irNraaIwNHXDMY7UUf21QzO9gjomfVl4
         PbLB6YfLwHTqfdDTsCj2hU5FSf/5gnDeNJp2usn8j2Iw2+H4HHvVuIL4WaDm5dWGUtZU
         rq+6ZvCQdxn+FIQNwTCHjnDg1Lix6YjgOylHy+ebPK8lHCEoF/wlb7zSVAreAVngHlFn
         Bs6w==
X-Gm-Message-State: AC+VfDxSbpqyPZtcmHNi8vDZjbLKXP16lz3YoG+ra5GoydK+fjIpVU1H
        FaNn2OVGzPgI/+p1o7Yi4sxJfM4l8gearRmYJiucKzUYdXbNTPhlQ13T0uWFmhiYbzYuW/sNqv+
        +4xhxBalEnZ0J/lzopu5v78GN
X-Received: by 2002:a05:600c:2216:b0:3f4:2a69:409 with SMTP id z22-20020a05600c221600b003f42a690409mr1004165wml.11.1684312222181;
        Wed, 17 May 2023 01:30:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60ueDQkDZtQuGOk/I42qgBFTunk166hxYz0WpLHJyNYPGp1WKcavGoULbbUgQf9jhOxrPOmA==
X-Received: by 2002:a05:600c:2216:b0:3f4:2a69:409 with SMTP id z22-20020a05600c221600b003f42a690409mr1004132wml.11.1684312221771;
        Wed, 17 May 2023 01:30:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b003f506e6ff83sm1421875wme.22.2023.05.17.01.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:30:21 -0700 (PDT)
Message-ID: <c9f1fc7c-62a2-4768-7992-52e34ec36d0f@redhat.com>
Date:   Wed, 17 May 2023 10:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Content-Language: en-US
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
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
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGJtJobLrBg3PtHm@arm.com>
 <ZGLC0T32sgVkG5kX@google.com>
 <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
 <CAMn1gO79e+v3ceNY0YfwrYTvU1monKWmTedXsYjtucmM7s=MVA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMn1gO79e+v3ceNY0YfwrYTvU1monKWmTedXsYjtucmM7s=MVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would the idea be to fail swap_readpage() on the one that comes last,
>> simply retrying to lookup the page?
> 
> The idea would be that T2's arch_swap_readpage() could potentially not
> find tags if it ran after swap_free(), so T2 would produce a page
> without restored tags. But that wouldn't matter, because T1 reaching
> swap_free() means that T2 will follow the goto at [1] after waiting
> for T1 to unlock at [2], and T2's page will be discarded.

Ah, right.

> 
>> This might be a naive question, but how does MTE play along with shared
>> anonymous pages?
> 
> It should work fine. shmem_writepage() calls swap_writepage() which
> calls arch_prepare_to_swap() to write the tags. And
> shmem_swapin_folio() has a call to arch_swap_restore() to restore
> them.

Sorry, I meant actual anonymous memory pages, not shmem. Like, anonymous 
pages that are COW-shared due to fork() or KSM.

How does MTE, in general, interact with that? Assume one process ends up 
modifying the tags ... and the page is COW-shared with a different 
process that should not observe these tag modifications.

-- 
Thanks,

David / dhildenb

