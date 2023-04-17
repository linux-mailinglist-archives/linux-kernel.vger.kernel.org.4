Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A86E41F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDQIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDQIDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10821BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681718585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+xDztrP5K0atvexPe7AsFD1VGHJO8wE5vvIvghj6Aw=;
        b=Ezh6BP2m2PciQmIp36YmcZ3B1M2NYFTy+UHKk/QJ/SP4fgGJrAVIN5j3KR7xpOLWr82zn+
        5cYSLO260uWlv8oYotCke8Rqo/8n6pr16Bk7LZi6nVTaR1SSKp68rdpHLC6km/uzzIZz4R
        V85Hq9/YIcsh/Uvs+sPdNvaMTSZrMV8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-vIz1huk9NSCOdDykrZYPeA-1; Mon, 17 Apr 2023 04:03:03 -0400
X-MC-Unique: vIz1huk9NSCOdDykrZYPeA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2efbab2cbe8so319769f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718582; x=1684310582;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+xDztrP5K0atvexPe7AsFD1VGHJO8wE5vvIvghj6Aw=;
        b=dF4X2d8bDwVskfil6CfcjFfa10bdhtXzO+01JlXE4wgruS0R9i1lyra8j9qCsgA3Ju
         eRwkNFu9Ul0FjsYTi9Z3p//ixcl90XTRed7DMTssXg4JYppSj+VyL+qgqHrRlBmOsa4X
         FDFDcGZvbp9ldX0PB16/FpeDe4lNYuWF5D7F8qa92H0B0LztWfoK6a1FrPI/rLW4hzsF
         ly5NC1Ma8lyCTuJm4f5U/hZMWbSjy83IANGgJZAXqCFFNkB6zdkQwxpdTUtSb+IRZLsI
         p8UPwisrUYNNljPyi0xOck2358j0zWSn3Z3jRe6sNM5NLPi1/dLjxicLD1atVZxZyQYM
         /ubQ==
X-Gm-Message-State: AAQBX9ffevKcaT6+BQ/Ziipr63LS3I+DqFD1vqXXhLEUKKmb11WySwkk
        dri2LB7pffcwSEmkeyunDXS/vkIR1SSekkVOwJa4AloTpxdOro3oXehJYMpzf3NoofF0XMMU8oI
        ISWb6tSPy4RsZmm14L7gdJH6P
X-Received: by 2002:adf:fa4a:0:b0:2ce:fd37:938c with SMTP id y10-20020adffa4a000000b002cefd37938cmr4246118wrr.50.1681718582463;
        Mon, 17 Apr 2023 01:03:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350YE4uFxV+bAUN+xrFK6nXNSGjCTnPBk85Csxmz3uAjeiolmxCGm7Fm9/ZEZFEUhZZ8oXqyKvQ==
X-Received: by 2002:adf:fa4a:0:b0:2ce:fd37:938c with SMTP id y10-20020adffa4a000000b002cefd37938cmr4246100wrr.50.1681718582077;
        Mon, 17 Apr 2023 01:03:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d63c8000000b002f4c2ea66absm9877045wrw.85.2023.04.17.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:03:01 -0700 (PDT)
Message-ID: <d4c13cbe-cb47-9b6f-8a61-c9689f020114@redhat.com>
Date:   Mon, 17 Apr 2023 10:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, Stefan Roesch <shr@devkernel.io>
References: <202304131346489021903@zte.com.cn>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 0/6] ksm: support tracking KSM-placed zero-pages
In-Reply-To: <202304131346489021903@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.23 07:46, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> The core idea of this patch set is to enable users to perceive the number
> of any pages merged by KSM, regardless of whether use_zero_page switch has
> been turned on, so that users can know how much free memory increase is
> really due to their madvise(MERGEABLE) actions. But the problem is, when
> enabling use_zero_pages, all empty pages will be merged with kernel zero
> pages instead of with each other as use_zero_pages is disabled, and then
> these zero-pages are no longer monitored by KSM.
> 
> The motivations to do this is seen at:
> https://lore.kernel.org/lkml/202302100915227721315@zte.com.cn/
> 
> In one word, we hope to implement the support for KSM-placed zero pages
> tracking without affecting the feature of use_zero_pages, so that app
> developer can also benefit from knowing the actual KSM profit by getting
> KSM-placed zero pages to optimize applications eventually when
> /sys/kernel/mm/ksm/use_zero_pages is enabled.
> 

Thanks for the update!

> the patch uses pte_mkdirty (related with architecture) to mark KSM-placed
> zero pages. Some architecture(like sparc64) treat R/O dirty PTEs as
> writable, which will break KSM pages state (wrprotect) and affect

With [1] that should be resolved and we should be able to enable it 
unconditionally.

Further, ideally this should get based on [2], such that we can include 
the zeropages in the ksm and per-mm profit calculation.

Last but not least, I realized that we also have to handle the case when 
khugepaged replaces a shared zeropage by a THP. I think that should be 
easy by adjusting the counters in the the is_zero_pfn() handling in 
mm/khugepaged.c:__collapse_huge_page_copy().

> the KSM functionality. For safety, we restrict this feature only to the
> tested and known-working architechtures (ARM, ARM64, and X86) fow now.
> 
> Change log
> ----------
> v6->v7:
> This is an all-newed version which is different from v6 which relys on KSM's
> rmap_item. The patch series don't rely on rmap_item but pte_dirty, so the
> general handling of tracking KSM-placed zero-pages is simplified a lot.
> 
> For safety, we restrict this feature only to the tested and known-working
> architechtures (ARM, ARM64, and X86) fow now.

Yeah, with [1] this can be further simplified.


I'll be on vacation starting on Thursday for ~1.5 weeks, not sure if I 
get to review before that. But it's unlikely that we'll make the 
upcoming merge windows, so I guess we still have time (especially, for 
[1] and [2] to land)


[1] https://lkml.kernel.org/r/20230411142512.438404-4-david@redhat.com
[2] https://lkml.kernel.org/r/20230413233115.1878303-1-shr@devkernel.io

-- 
Thanks,

David / dhildenb

