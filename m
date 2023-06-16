Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0856A73295B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFPH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF62948
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686902243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmWx/AJ3S4UDmLUBVcPWvaOILz2i/efbrRdbV4jSGuI=;
        b=C7yySTQQvurxrmcu7M1pc/XRYsXsQ04wOURCzb1e7ewVsWXbTTgCP9mUEWHDCCV7epEIuX
        5bSetCiTZh3gEmI+GIZ+XqjEMdq6VqRXNy41dop5M+b7hF4Ob1Ppybl3aAZvXynn0ny0ME
        j9Bkoi+xteiI3aKRTWyZaEjBfq51WZk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-8AMOv_enMIio1FntDXwINQ-1; Fri, 16 Jun 2023 03:57:22 -0400
X-MC-Unique: 8AMOv_enMIio1FntDXwINQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30fbb0ac191so730558f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902241; x=1689494241;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmWx/AJ3S4UDmLUBVcPWvaOILz2i/efbrRdbV4jSGuI=;
        b=hJTJjMqHhVQ4pMhJ2Dpq6qLU7eCK9+4rs8B4RjbvGdZK6bxRxSNn3/fEpCBy/bE4Xq
         9FL/yjrZRLYLFD163rFIWAsYhEHnafctbfZWui5n/OTzkqiCsIdHe0tpvGP9zh7ckz8I
         lRLL+FxNCJRoNVf77qeJA1KRYoj7OaN3xG678O6hWR5/ExpyElqNi6c2t83tlBFWx0kf
         dpW3T0aQNUCaIVPP8PShDKocq1k23y4ANMVzhNO2OnjkgtH6cdzTjVReIO9WVg9EM/cJ
         IDOggl0gF2RdcfF8BNASv1GYeo47lUzNZhCYs3xpD72BdZyDqF32U5kkr1ltjBnOPzaO
         V6RA==
X-Gm-Message-State: AC+VfDwO3WxDOgiE7wYibZxwrZ8k78AH7muyXeMJxtxqO1JjCZ5SOk+k
        zcLPbZS6JVYW3G6W/tAQtnmemBENLEjMTvI3FR+ySFS8vh0pXyKYl4DY785l7XMYyecnpd5Six/
        4J2AbAg9hoN62lhaiEo3i2+QJ
X-Received: by 2002:adf:f2cf:0:b0:30f:c4a7:8754 with SMTP id d15-20020adff2cf000000b0030fc4a78754mr5752997wrp.5.1686902240875;
        Fri, 16 Jun 2023 00:57:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6d2AQLhsWO/3+dulLJxjLTJZMzdzmShBDo16xLLUx8cfuwi9Vw0TzqPvzhjMH0eEQQ1PY1Pw==
X-Received: by 2002:adf:f2cf:0:b0:30f:c4a7:8754 with SMTP id d15-20020adff2cf000000b0030fc4a78754mr5752977wrp.5.1686902240460;
        Fri, 16 Jun 2023 00:57:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c230300b003f7ea771b5dsm1487358wmo.1.2023.06.16.00.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:57:20 -0700 (PDT)
Message-ID: <576b7ba6-4dcd-48c9-3917-4e2a25aaa823@redhat.com>
Date:   Fri, 16 Jun 2023 09:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
 <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
 <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
 <CAJD7tka4Uc1DhNzKbrj71vGyVVA12bJivPUQU7P0DOinunLgGg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJD7tka4Uc1DhNzKbrj71vGyVVA12bJivPUQU7P0DOinunLgGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 09:37, Yosry Ahmed wrote:
> On Thu, Jun 15, 2023 at 9:41 PM 贺中坤 <hezhongkun.hzk@bytedance.com> wrote:
>>
>>> Thanks Fabian for tagging me.
>>>
>>> I am not familiar with #1, so I will speak to #2. Zhongkun, There are
>>> a few parts that I do not understand -- hopefully you can help me out
>>> here:
>>>
>>> (1) If I understand correctly in this patch we set the active memcg
>>> trying to charge any pages allocated in a zspage to the current memcg,
>>> yet that zspage will contain multiple compressed object slots, not
>>> just the one used by this memcg. Aren't we overcharging the memcg?
>>> Basically the first memcg that happens to allocate the zspage will pay
>>> for all the objects in this zspage, even after it stops using the
>>> zspage completely?
>>
>> It will not overcharge.  As you said below, we are not using
>> __GFP_ACCOUNT and charging the compressed slots to the memcgs.
>>
>>>
>>> (2) Patch 3 seems to be charging the compressed slots to the memcgs,
>>> yet this patch is trying to charge the entire zspage. Aren't we double
>>> charging the zspage? I am guessing this isn't happening because (as
>>> Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
>>> this patch may be NOP, and the actual charging is coming from patch 3
>>> only.
>>
>> YES， the actual charging is coming from patch 3. This patch just
>> delivers the BIO page's  memcg to the current task which is not the
>> consumer.
>>
>>>
>>> (3) Zswap recently implemented per-memcg charging of compressed
>>> objects in a much simpler way. If your main interest is #2 (which is
>>> what I understand from the commit log), it seems like zswap might be
>>> providing this already? Why can't you use zswap? Is it the fact that
>>> zswap requires a backing swapfile?
>>
>> Thanks for your reply and review. Yes, the zswap requires a backing
>> swapfile. The I/O path is very complex, sometimes it will throttle the
>> whole system if some resources are short , so we hope to use zram.
> 
> Is the only problem with zswap for you the requirement of a backing swapfile?
> 
> If yes, I am in the early stages of developing a solution to make
> zswap work without a backing swapfile. This was discussed in LSF/MM
> [1]. Would this make zswap usable in for your use case?

Out of curiosity, are there any other known pros/cons when using 
zswap-without-swap instead of zram?

I know that zram requires sizing (size of the virtual block device) and 
consumes metadata, zswap doesn't.

-- 
Cheers,

David / dhildenb

