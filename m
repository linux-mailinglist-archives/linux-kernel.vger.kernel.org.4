Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE88D7070BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEQSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D6ED867
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684347818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqvbTDaQlB5Q2U1EnVBHO24QPkqAoM+X9DFpf2XubEo=;
        b=YqBQpP86UzQLZBT1KyIk8VzNcjKRVjKffUYg6r4mNFts6Y2lX+i2gDHll/KUsDExUWQP61
        IBj33yqt3dCRg9x7N6P0kZ+e1FAZh/Rol6yoH+adlzzz4BnaQQ3ZrRBSj20I1er19NMHB5
        snyK4T/8W8H9LPH2ztv9r50ZmB7uFCg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-XaNWTMGhOc-ZoU59GQcWPw-1; Wed, 17 May 2023 14:23:36 -0400
X-MC-Unique: XaNWTMGhOc-ZoU59GQcWPw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f4fa463282so7955465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347815; x=1686939815;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqvbTDaQlB5Q2U1EnVBHO24QPkqAoM+X9DFpf2XubEo=;
        b=FfLCosv/hsVQ4LEgxqa3gPOccpd8zInXATmk0v+6DiKC++io3UhqD8direQeLK0xhN
         dGmdiyM1hSQU08fci6uye/ZKqMX6P3gnXcdZME58Ey76yGhpA0PnB0Ufn686wr3nbUXY
         NfSSoF0WxFc7+MeN4m1tNpFNxTyYkApdL32ZhUk+gfvyM632MO5qX+pxF3+VkhWshWgd
         44AjjADaNJ9oQIz5ew0HqF7ac+VfIk/FCABPrWMmhXpd7bDWRVM3ZwS/EkYmHw3Jgo1c
         Ch7C3+GIs25+Dtfx69rljepkKIVFax4cKZz66hdKDkgUFaNnbMctnLXTXnqzFEaz6+X+
         zY1w==
X-Gm-Message-State: AC+VfDwuL3Sv8qZob1qrEbLlep/clQ9sx+vou2Zy5UnC6gI9AsxsRV+o
        5uU0l98/WaNK9kWpJs3C4UZpp1cU312BNwS0+b8B0VUEWT/4cDueWVqIjPjR6DyVaK4wPvjqers
        RsV6Kht3HeqegSNBZMjkigUjA
X-Received: by 2002:a7b:c047:0:b0:3f5:f04:4607 with SMTP id u7-20020a7bc047000000b003f50f044607mr7312216wmc.22.1684347815733;
        Wed, 17 May 2023 11:23:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aghbMPeDps3xUcJWgRTN4G72ejk+Q9UkoksMRs7xKUZqCHs8zsQJ6GCxmBST8kSnxNSrUtw==
X-Received: by 2002:a7b:c047:0:b0:3f5:f04:4607 with SMTP id u7-20020a7bc047000000b003f50f044607mr7312200wmc.22.1684347815381;
        Wed, 17 May 2023 11:23:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id q17-20020adfea11000000b0030639a86f9dsm3578463wrm.51.2023.05.17.11.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:23:34 -0700 (PDT)
Message-ID: <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
Date:   Wed, 17 May 2023 20:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 12:19, Sumit Garg wrote:
> On Wed, 17 May 2023 at 15:06, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Wed, May 17, 2023 at 02:56:13PM +0530, Sumit Garg wrote:
>>> Do you mean a pinned user-space page can be paged out automatically?
>>
>> No, pinned pages can't be paged out.
>>
>> But a short term pin implies it will be release after a short delay,
>> and it is feasible for wait for the pin to go away.
> 
> Okay, I see. I would be interested to know the ranges for that short
> delay. I guess it may depend on how much memory pressure there is...
> 

In general: if user space controls it -> possibly forever -> long-term. 
Even if in most cases it's a short delay: there is no trusting on user 
space.

For example, iouring fixed buffers keep pages pinned until user space 
decides to unregistered the buffers -> long-term.

Short-term is, for example, something like O_DIRECT where we pin -> DMA 
-> unpin in essentially one operation.

-- 
Thanks,

David / dhildenb

