Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5774FFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGLGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGLGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:46:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BD7DC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3866484b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689144338; x=1691736338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8WhpdF8/RW8zGFH/BZgsqEuwmUxTSnkz6bmGMUpKLg=;
        b=W/GvKFglSlPxZ7GDe3SBJk00S68EMh1nVTwsJAwhPkQ3MT365bsUjoqdqE+/sA7CSN
         NRbg4zl/wx1Ls0jXTms3+eFHtQJyUHaiDmc3++U9grS799Xvv+6VfZ7rUTRs7OMQTQAB
         FWp2o073tH2I2V2BGGYkcvq9X9akSwkleCwtv4Cgn9Gl0v/0cXvmNCmhRYQdPENheFEs
         xGjTHkxJaBaShbI/QBVm5k2nSoBimFca0JrTPTEOBCnwYyet961sXcDsDzRAZpzsM6Db
         MLVmvFZEDnKOJT+7M+5szD2mCWMufCAeW02SnLCg9kpv0jB3gHFFeTNQKSCl0J7aqjAE
         5n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144338; x=1691736338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8WhpdF8/RW8zGFH/BZgsqEuwmUxTSnkz6bmGMUpKLg=;
        b=A2k1wn0XfmRkW20ywXIYp1K7MlDa6/eoCt9XOrZTWsRlIVD7qXaTMfFFo8MgtQcMOI
         QEjvyz7JHGWPA/WRs2Ar50UuX1CpzwSwSKwu/0OnE4dQBTRKqMhUcKyWrIwvhZv1W3Bo
         oNyFPGfHwMLoxcRSmV3LKj5FXYV3GqJUexgYOuU674WBk1AHh9/50vwpxcYSlCvblw4O
         K3r24pmDUg9VCy7mfIhtMjO/TQwt8thWvVO5Mk/hAH+jYQXZVSRxjTSQ7ga+FgmoxS1f
         hA55iiz6mhW3sc3CVkbvNzvYnja2sY1bUrn8EjXmQqcTkkKRjqDErf9AJXCwKTpAVUh0
         BMsw==
X-Gm-Message-State: ABy/qLYLHIC+lMbo/mbuEnfK00GNLDc25Cfu+VgvMjHN22m8V0Fp8g5b
        QfcQYH/Myoa53TPhpfc7DQReRA==
X-Google-Smtp-Source: APBJJlF4k1pkoB3GqDRrCOhh7latAjS6/d0b535BaPunB3YtROa/Y2UxTSwoSRKXrxX78yz7cfx0Xg==
X-Received: by 2002:a05:6a20:7f94:b0:12f:dc60:2b9e with SMTP id d20-20020a056a207f9400b0012fdc602b9emr17247332pzj.48.1689144338323;
        Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902cb0b00b001aaf2e8b1eesm3085131ply.248.2023.07.11.23.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 23:45:36 -0700 (PDT)
Message-ID: <987f7855-8b1e-ad1a-29d3-8511ccaa00b2@bytedance.com>
Date:   Wed, 12 Jul 2023 14:45:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <20230711204537.04cb1124@kernel.org>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230711204537.04cb1124@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On 7/12/23 11:45 AM, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 20:41:43 +0800 Abel Wu wrote:
>> Now there are two indicators of socket memory pressure sit inside
>> struct mem_cgroup, socket_pressure and tcpmem_pressure.
>>
>> When in legacy mode aka. cgroupv1, the socket memory is charged
>> into a separate counter memcg->tcpmem rather than ->memory, so
>> the reclaim pressure of the memcg has nothing to do with socket's
>> pressure at all. While for default mode, the ->tcpmem is simply
>> not used.
>>
>> So {socket,tcpmem}_pressure are only used in default/legacy mode
>> respectively. This patch fixes the pieces of code that make mixed
>> use of both.
> 
> Eric Dumazet is currently AFK, can we wait for him to return
> (in about a week) before merging?

Sure, thanks for providing this information!

Best Regards,
	Abel
