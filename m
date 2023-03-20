Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123476C1096
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCTLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCTLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2DD6594
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679310874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0EOqQNOoDr9J5ZhYSbGmkTrdHGjzdKjU2v0LKERLeQ=;
        b=erQjEfCLxk/jszXWpzrl8FIU8WaQYA3phLTP7BojMOLKqZOVWtOvMi5+Bu6hqiz1RkHXg/
        FgBkJ3mPSnVNRdleVFddNtgTonm+EKjp6kq0xpi52rK6XVfA2lug3kHcmxkOEik66QDg0J
        GFe+vKS4kOLdWfAjBe2YialqPrDXDoo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ZlKecMADO3OUiKKSiV2N-g-1; Mon, 20 Mar 2023 07:14:33 -0400
X-MC-Unique: ZlKecMADO3OUiKKSiV2N-g-1
Received: by mail-wm1-f70.google.com with SMTP id i8-20020a05600c354800b003ed59bae33bso4271305wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679310872;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0EOqQNOoDr9J5ZhYSbGmkTrdHGjzdKjU2v0LKERLeQ=;
        b=QXB59Il9gds8WCE2O9AUoM5AjBJv4CVJsgLpeZlDm1nj8s8iW6IuZh3Zg8c1kCgf2+
         OCQRF1rLmqOchybggTXnW7igVLU0R7yBXmkvvjy16MHy4HiicY+Kh7wLi1r0fYHPs5oU
         MsvSoq7z/Lt4H3jXOLD7KLNtDeUUPCc/sfQxIX23ozew4uiQNK+pv5ruuhqv073nCLTM
         3cPXU60jLS/lD/0tsO+5IYrihbLtBHNYhOUy9tpjF8CtH54yKzZEtd9GoAeXkkH1rSj+
         s7umoJo0pieSGSkChzsy0TnKSUjDT7ch166csPSVNVrx1mpDch0UrJxeWOvEAx0JJpbe
         HFJA==
X-Gm-Message-State: AO0yUKVHpgcLgAwHJL92H3L/Na5bQtAeiGa/mwCRwStXhOprA1O9JODu
        596JsU481EnS06ZO8uXxuhVWdsmCWyH47Q0fau5cngbfWm5Bk8nW3d9GjXdbHiBQLRQXW43ViRS
        4C1zimsGdvzj22hBINCLSFbXf
X-Received: by 2002:a05:600c:444c:b0:3ea:d620:570a with SMTP id v12-20020a05600c444c00b003ead620570amr31908135wmn.38.1679310871944;
        Mon, 20 Mar 2023 04:14:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set+oDHc1SsjzfN93tiAdKSTwxgdoq4X5250NkurTWNXcaq4UNjbKf13f5qD5SXb1ugKzI+ONSg==
X-Received: by 2002:a05:600c:444c:b0:3ea:d620:570a with SMTP id v12-20020a05600c444c00b003ead620570amr31908117wmn.38.1679310871619;
        Mon, 20 Mar 2023 04:14:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id s11-20020a1cf20b000000b003db0bb81b6asm10467233wmc.1.2023.03.20.04.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 04:14:31 -0700 (PDT)
Message-ID: <8aa1db52-bc5b-a734-cf4f-ddee518ee9fb@redhat.com>
Date:   Mon, 20 Mar 2023 12:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/15] mm/cma: move init_cma_reserved_pages() to cma.c and
 make it static
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-3-rppt@kernel.org>
 <8a461e44-7d24-5b5d-db04-e7fa85beeaa7@redhat.com>
 <ZBg/SCbVBAqNCU+F@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBg/SCbVBAqNCU+F@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 12:11, Mike Rapoport wrote:
> On Mon, Mar 20, 2023 at 11:30:20AM +0100, David Hildenbrand wrote:
>> On 19.03.23 22:59, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> init_cma_reserved_pages() only used in cma.c, no point of having it in
>>> page_alloc.c.
>>>
>>> Move init_cma_reserved_pages() to cma.c and make it static.
>>
>> I guess the motivation is to avoid letting too many subsystems mess with
>> pageblock migratetypes, managed pages, PG_reserved ...
> 
> Judging by the git log it just ended up in page_alloc.c because
> set_pageblock_migratetype() was static back then ;)


Yeah, it leaked into page_isolation, which heavily relies on migratetype 
handling :)

-- 
Thanks,

David / dhildenb

