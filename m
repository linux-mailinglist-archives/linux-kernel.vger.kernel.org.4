Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9D5B8E61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiINRyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiINRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:54:34 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E51E097;
        Wed, 14 Sep 2022 10:54:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z18so11779763qts.7;
        Wed, 14 Sep 2022 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=078ohqEl3SbvSuLUyK3z9/YOVVWoH6vsNvPCy6kXlrI=;
        b=KJeN8BAbeQhrvfhh8qJlMy+PCwI0ztOtPFYIGvj/n2ABIfXLdb93t6qjzN0kQM8+og
         eWmqaiwNRo7hnpwsuVFYx50Blm6etKPmPVX+wURHIU8xXv/HpBmbVMp28HYu5oMSUsGX
         +5EEDwSv5lIVQWgqp7TdRVAMdYl7ypTb2JnJm7oaXu08gcHZ1RFpv4YUkc63H8Pdw3RD
         D9fMiyebzoyOnhPUFxWGi4D3UGHh5Zsj1o53imZgzb+W5ArT9HtuzMRqlK1Qrp3HuvaU
         CjnoCGrYdIpmnafc2Tp/gi2czpGf2a79J1N08j6qoinJAsOfTLxH79I/JJq2e1CYp2/V
         tvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=078ohqEl3SbvSuLUyK3z9/YOVVWoH6vsNvPCy6kXlrI=;
        b=2NspH0sbtWEPg7vGaROzVNaPP+Z38Wggi5WngXftYPKBYUbQpL+wz+O+30RaDJ9WBC
         wKJ73iRdgK+1nEQnr1cVzfx6WwtTO24omgG3X4QVVRGUHt5pQS1JxybhS9pubCPYcLno
         ZKSPhnwlhekXTsXw6FCVCn3r3iXCzVa5E48E2WZrJwKAs2aHw+a5yga3Fzmr6TBi3ci4
         /QWXdQl83XHA33XfBKnPBu2FHOaTHdPA30zqeMsuGV25trkBXBDe+Dr8tzBYaZgag1Ya
         w9nzgyFitlwQ+p/YamFntPJXbRUqW3uxReU1rSXJGRp76YKUOBCacCBlCQOUtqOPbX1A
         xVdw==
X-Gm-Message-State: ACgBeo1HWfjeoVMICKYHGUKksiJFnZ4Lfth51MUWLB8tjDSzII1SNrWQ
        8euRHammi8X5kw5TVTar9fM=
X-Google-Smtp-Source: AA6agR6TNcOs9G/1GT36JKa+IitWjuNF26XpK7u3lTR4YMggceCehr58RazsJJgUrvEATr7qoTnO3A==
X-Received: by 2002:ac8:57c7:0:b0:344:55d9:dcd7 with SMTP id w7-20020ac857c7000000b0034455d9dcd7mr33921914qta.162.1663178071901;
        Wed, 14 Sep 2022 10:54:31 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006b59f02224asm2299077qko.60.2022.09.14.10.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:54:31 -0700 (PDT)
Message-ID: <43aabfed-bc03-3fc0-5b9a-4c5e6ebb8416@gmail.com>
Date:   Wed, 14 Sep 2022 10:54:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-4-opendmb@gmail.com>
 <YyETeBdbldnoRZ+x@casper.infradead.org>
 <33ff9543-3396-7609-3865-7eed20b853f5@gmail.com> <YyIKcNRP+Q0Vt3CT@monkey>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <YyIKcNRP+Q0Vt3CT@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2022 10:08 AM, Mike Kravetz wrote:
> On 09/13/22 18:07, Doug Berger wrote:
>> On 9/13/2022 4:34 PM, Matthew Wilcox wrote:
>>> On Tue, Sep 13, 2022 at 12:54:50PM -0700, Doug Berger wrote:
>>>> With gigantic pages it may not be true that struct page structures
>>>> are contiguous across the entire gigantic page. The mem_map_offset
>>>> function is used here in place of direct pointer arithmetic to
>>>> correct for this.
>>>
>>> We're just eliminating mem_map_offset().  Please use nth_page()
>>> instead.That's good to know. I will include that in v2.
> 
> Thanks Doug and Matthew.  I will take a closer look at this series soon.
> 
> It seems like this patch is a fix independent of the series.  If so, I
> would suggest sending separate to make it easy for backports to stable.
Yes, as I noted in [PATCH 00/21] the first three patches fit that 
description, but I included them here in case someone was brave enough 
to attempt to use this patch set. They were in my branch for my own testing.

Full disclosure: An earlier version of this patch set had more complete 
support for hugepage isolation that included migrating the isolation 
state when demoting a hugepage that touched lines in 
demote_free_huge_page() and depended on the subpage variable introduced 
here.

At this point I will submit a patch for this on its own and will likely 
remove the first three commits when submitting V2 of the set.

Thanks for your consideration.
-Doug
