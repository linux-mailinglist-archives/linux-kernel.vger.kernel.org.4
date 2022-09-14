Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F45B7E16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiINBHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:07:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB4386B3;
        Tue, 13 Sep 2022 18:07:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s9so7567855qkg.4;
        Tue, 13 Sep 2022 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=plxos9uquFOD+IvTyP/oZn7J1wpWUgAiZjzQhRQDPPQ=;
        b=b5Ib02DcxbD8iGr+e9uO3ofxDa5NOXUgiKqm4v2kO2kVzLFaIksphZ+L5Zdbvek1wM
         Wmqq1e6M0COkpEIS2jTy/PtUgCdajEtU48nkMBXp1pD9XDM6s+PucJjIlGaVewK6jpAB
         MixvjHa8iEwvkFwCTzd4+IiI1JDNHjbquWMgFtpWgjJj6qqEw5WAYPSMVDEgpLo3HNek
         36boSZgTaGRXICe0uFLtjuI38uivs5RzA7nLftvI8tOPpKmyKy3pz/VsvafUilaTeUvi
         fcpstGUbfcwFK2RzmK6KZVIK3Hl4+3OGNIQyl05fWMzuh3cx6pq0kx437GIDICGwdU2D
         iecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=plxos9uquFOD+IvTyP/oZn7J1wpWUgAiZjzQhRQDPPQ=;
        b=o2TZPYe7jrULkGFpNAlRCQDfJDI5Cd99r7HNA2r4A+g5bL1W3rI0TFu2WY5gSHh9jK
         k3Pjapy6gyiAqfkIh1nElMt3vxI7gut0fLL1f0fSuyZ/8szDlFP9iQaj/DVtHw+0RdW/
         VnBqa1Q5D/V72lpo62NjsexQLfnN8xHC2i3dHwufrT/4O+9KazSCF/HX9jP1VRVfCf72
         q1aRLRC1nl7N6kMNjp3MgC7bm1st1OseUbmCcfK50mNdUZyl9VmhEf5VuZdA02+xm4uh
         ECvxaZVGLjwbeDSSQdNQ4XKUiqgnXr4xgmh6RDz0o5VGL0Z/QUjJs8tt+xwVqhcwO3Yk
         XWng==
X-Gm-Message-State: ACgBeo2JpQ1YC5HtqqNpdUjgOhaaj5HPKpNiQKUMJXNTMCHvRz+3YyrQ
        VZYIqAiGr0Cp+a37Hzsf2QI=
X-Google-Smtp-Source: AA6agR6T8fHDs9UyqzsDp4Um9poKtPw3ia21pUGOlENIFjDdlRCXupm+CtiBRXcOgUDRfWYaL1iLtg==
X-Received: by 2002:a05:620a:4114:b0:6bb:33c2:45f9 with SMTP id j20-20020a05620a411400b006bb33c245f9mr24395201qko.374.1663117666899;
        Tue, 13 Sep 2022 18:07:46 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b58d8f6181sm707879qkb.72.2022.09.13.18.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:07:45 -0700 (PDT)
Message-ID: <33ff9543-3396-7609-3865-7eed20b853f5@gmail.com>
Date:   Tue, 13 Sep 2022 18:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-4-opendmb@gmail.com>
 <YyETeBdbldnoRZ+x@casper.infradead.org>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <YyETeBdbldnoRZ+x@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 4:34 PM, Matthew Wilcox wrote:
> On Tue, Sep 13, 2022 at 12:54:50PM -0700, Doug Berger wrote:
>> With gigantic pages it may not be true that struct page structures
>> are contiguous across the entire gigantic page. The mem_map_offset
>> function is used here in place of direct pointer arithmetic to
>> correct for this.
> 
> We're just eliminating mem_map_offset().  Please use nth_page()
> instead.That's good to know. I will include that in v2.

> 
>>   	for (i = 0; i < pages_per_huge_page(h);
>>   				i += pages_per_huge_page(target_hstate)) {
>> +		subpage = mem_map_offset(page, i);
>>   		if (hstate_is_gigantic(target_hstate))

