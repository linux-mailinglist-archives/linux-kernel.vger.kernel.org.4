Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B600B5E9C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiIZIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiIZIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D99A3AE6C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664181170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZGYtOLY3FItcJklTsztDmIawuiBAYb+rnQ59of1z3Y=;
        b=NLNSCarC+/bPrBR9pFoylnsGsZv4XN49oEZbjR0+iVvbPiUqTTigQaGr6qq990VIpd3Y6N
        4/Ss5QECl8S+qpyIIe7Gf445Pz0rP7fNRpILgR0Q5GMFl+Z/MMJ+e8flQ1acSF16QcxY6j
        1kTmPN2wAGQB5hBQlUUuLOhNvJm127w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-bTN0ClZ-NXuaY6cmexAVyg-1; Mon, 26 Sep 2022 04:32:48 -0400
X-MC-Unique: bTN0ClZ-NXuaY6cmexAVyg-1
Received: by mail-wm1-f69.google.com with SMTP id fc12-20020a05600c524c00b003b5054c70d3so3831096wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=2ZGYtOLY3FItcJklTsztDmIawuiBAYb+rnQ59of1z3Y=;
        b=t/RdInqe2X+AJHluUMzpnIKlsZPNpp7MDMiK9q5Wd5WwjXRmDb29FLT0mdgl4/bLB3
         SMfULF3iH+AcPmstLXY4KcISqZbI7pqGvJmOo1rsigJ27FktklnWn2bmZ5zYmdm16iff
         I/6unvMof1F++id1QVnY99Z4Lk6FCefdPs6lVenpDEQPYiX01Qzsfn7dWd4Joh4rlmWc
         pV3KgRfzhGohP3aVPsvn8TX0sRCd3nXwqQBsn15M79Bo8N892he096QfDS+9bc/PAw0y
         JD4r/hVP20aPkquXmV8Oy19it29CqFw6HXmcFfRgHhbXvcPvu827SoPM1yoIzUl77lZe
         58mw==
X-Gm-Message-State: ACrzQf1w567x7fq5GMVnk56n/r8zacvagu6l0+EnCh3XAEyu/eLrqdSz
        p1LKVgaCbVy5mOoMHraVO+jkBvgvlb6NL16z49+Mnzl5DdStiqTpcJqYybxvU4VTgxTlXyYfN6Y
        I5s7AuS34izR6hhZe95FbABeK
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id q23-20020a7bce97000000b003b3413659femr14230793wmj.24.1664181167079;
        Mon, 26 Sep 2022 01:32:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5r+QgKNI1zWUxSeUKHpaNiNk/Wrai0XDoRmaIxA2kk5MN5p5JzGTH0lcnJ0escKeEkpByYlQ==
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id q23-20020a7bce97000000b003b3413659femr14230772wmj.24.1664181166762;
        Mon, 26 Sep 2022 01:32:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7? (p200300cbc7034b00e0907fa6b7d6d4a7.dip0.t-ipconnect.de. [2003:cb:c703:4b00:e090:7fa6:b7d6:d4a7])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm11212861wms.46.2022.09.26.01.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:32:46 -0700 (PDT)
Message-ID: <48590f80-fc58-bf67-5acf-082880a607b2@redhat.com>
Date:   Mon, 26 Sep 2022 10:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] mm: fix misuse of update_mmu_cache() in
 do_anonymous_page()
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn
References: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
 <3A09E40A-E2C5-4C6F-8550-DD0E17B7DAB9@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3A09E40A-E2C5-4C6F-8550-DD0E17B7DAB9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.22 03:43, Muchun Song wrote:
> 
> 
>> On Sep 24, 2022, at 13:32, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>> if PTE entry exists") said, we should update local TLB only on the
>> second thread. So fix the misuse of update_mmu_cache() by using
>> update_mmu_tlb() in the do_anonymous_page().
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The change looks good to me. However, I am not sure what is the user-visible
> effect to xtensa users. So Cc xtensa’s maintainer and the author of 7df676974359
> to double check this.

And if there is one, do we have a fixes tag?

-- 
Thanks,

David / dhildenb

