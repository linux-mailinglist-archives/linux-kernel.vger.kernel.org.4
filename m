Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A439E5EF1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiI2JV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiI2JVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43612FF3A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664443310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ke0PkvjcwfbH75Zmmd3mgZq6jo8h9BqrU/07q+LRkYI=;
        b=M632oA+JPfYIghMlMGdhbLMhe77N/l3RDxfRlEBEbCIH1radAib40Y+CWmf4A9EjUKaIvp
        YuQP/5HlP4/u7SwW6uV9kcbR2Y3JC04NVvGGvonKphE4HR2GgxsjzgXQB7jokaw+Cz89w7
        VGDFTg+AoKKEyl3tAU+MM4zMoqgqJsM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-hQFISKnUPeuXNuaWaX2J2A-1; Thu, 29 Sep 2022 05:21:47 -0400
X-MC-Unique: hQFISKnUPeuXNuaWaX2J2A-1
Received: by mail-wm1-f69.google.com with SMTP id d5-20020a05600c34c500b003b4fb42ccdeso2689451wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Ke0PkvjcwfbH75Zmmd3mgZq6jo8h9BqrU/07q+LRkYI=;
        b=J8qxVQ2tbgESJ628qXJB3C8GTDUfo1rn31GQy4tbBa1qJlt/ybrBcwUW3ZoRylkj/1
         8DuQa0P2eAp7S/JgUgIKa7FGEfxlIrcyPDATKCoL3K36PqM4EdJaPKuppJ+FgzrEOQ93
         rzRbzHVuCziHfhMaJiLOecioLELlTfmkrWNoH7Dgcv2PrOjUC1uaMVvRY4bnTaNJY+xb
         7iD1Wy9xsTLLOSIeaRbD/mDqZopHqJeE3rcGtlAthwl+tqXTqitsxEeZIiSIAGRSptAH
         FvzQM8U1Wge6+9u1j6P6hg3BRFg5fVLNfE3j0KJabEcnkTwRqCQzjMuae9c8tu1GTG0m
         zxbg==
X-Gm-Message-State: ACrzQf3Zdq+cqbUAeaau6WFsXIynMpwpfjbfM1BuPUdALBSVqzc0nfAk
        1IZFnpQ178+wIxAXlgmFrCTWsSjoKAaXP76xVkbShUs8r57tGYF7lQYW5KgIEse++UUjn2LsCr7
        mxsg/99L4ZrI7JtMFvELGXbar
X-Received: by 2002:a5d:47a4:0:b0:226:e547:b602 with SMTP id 4-20020a5d47a4000000b00226e547b602mr1496488wrb.406.1664443305970;
        Thu, 29 Sep 2022 02:21:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4W8pTVLJPBhavUN+i/fs2ek3WbmQXvJhXnU8ufO/u7+71wdQ9GOSYUjyfC2+fmt79Yw1fqeg==
X-Received: by 2002:a5d:47a4:0:b0:226:e547:b602 with SMTP id 4-20020a5d47a4000000b00226e547b602mr1496478wrb.406.1664443305696;
        Thu, 29 Sep 2022 02:21:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id i1-20020a5d4381000000b002205cbc1c74sm6118043wrq.101.2022.09.29.02.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:21:45 -0700 (PDT)
Message-ID: <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
Date:   Thu, 29 Sep 2022 11:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     xu.xin.sc@gmail.com, akpm@linux-foundation.org,
        imbrenda@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
In-Reply-To: <20220929025206.280970-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 04:52, xu.xin.sc@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> after enabling use_zero_pages, all empty pages that are merged with
> kernel zero page are not counted in pages_sharing or pages_shared.
> That is because the rmap_items of these ksm zero pages are not
> appended to The Stable Tree of KSM.
> 
> We need to add the count of empty pages to let users know how many empty
> pages are merged with kernel zero page(s).
> 
> Please see the subsequent patches for details.

Just raising the topic here because it's related to the KSM usage of the 
shared zero-page:

MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare 
the shared zeropage as placed by KSM (which is against the 
MADV_UNMERGEABLE documentation at least). It will only unshare actual 
KSM pages. We might not want want to blindly unshare all shared 
zeropages in applicable VMAs ... using a dedicated shared zero (KSM) 
page -- instead of the generic zero page --  might be one way to handle 
this cleaner.

Would that also fix some of the issues you describe above?

-- 
Thanks,

David / dhildenb

