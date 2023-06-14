Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D047224EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjFELwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjFELwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:52:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B685DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:52:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so1621207a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685965938; x=1688557938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyOkEllK607lv9MCxWlko/8/h878DjdboSx2KDG6rPU=;
        b=eabMDt3oXuyeHqL6H95VDxv5qnDlp7C/hXkIKi9mE5RBAoY3t66MibAVJ1OyJOW3RI
         LESpN9wTXsuJaXmyQk+hrcImYockzT2vENkn0uB59YWGFQT7hU0htS22r94rGoWZJ1YS
         eoMFe+spUeV1gW22xOKgrGgYhj/hXExeWe7dvKuanyNNdN57KqW3msbApkAjrVNHxOtH
         2EV24MAFpyA7wBZbT8EjHQGq6521MTjFuENHeMbCjF6EV2PW0DHne8ZVihA3/f7CW1fQ
         8Bv+F4Ee4r1/xl5PFWZJhZqmG6IGRtjbIuE4DZGEOct1kfALIIWaFsW2cZWi2tbimrFI
         H4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965938; x=1688557938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyOkEllK607lv9MCxWlko/8/h878DjdboSx2KDG6rPU=;
        b=ZRCzgToleWHFib70ACZ2SEmUxP05PynKh6TRv5vHaSCGZu7iAVXmwDr9Tstfv8jZvl
         fbZ5GIc/2KpfkXqwS9+bJcd/HvVJ+IANwpJpUGtXAgpeKfyyNiMnC8a9a1QUWAytNkRw
         EHhWMSBYfHXCvxeVT+vQOhmxW5ZEyTRdeqnMXJGGcAhK+bF1x8LfF2PdtKrbqYOZulhg
         of8dHq3kumMxO5iKgw6l9hQ4a3pEA7EP9zDrZ0dOqbHNINNAo1fj2MKYKODHWefLyWcv
         zOEtT1Q6Lne/KaJ+41ixYWffqV9otv4M8UAVe4pItT6iLqSwgxR5l9bNk3RKRQzkWAdf
         sOvA==
X-Gm-Message-State: AC+VfDzdTGbja7h9cpHzeQVocRqJvOopYx9YlUUpAP/zqQ+EfQoVGWMu
        HXkYZUVyIGvby45Oa2rT185UVw==
X-Google-Smtp-Source: ACHHUZ7Fn8Dm7pVHQjYxiahDIQS4qNAmj5o8qKZRySqarCR1X7QLuv0XMXLIlT9L0JsS4a61YdP0fA==
X-Received: by 2002:a17:90a:be10:b0:256:c324:7ae4 with SMTP id a16-20020a17090abe1000b00256c3247ae4mr2478790pjs.16.1685965937953;
        Mon, 05 Jun 2023 04:52:17 -0700 (PDT)
Received: from [10.254.80.225] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a284600b00247735d1463sm6089046pjf.39.2023.06.05.04.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:52:17 -0700 (PDT)
Message-ID: <2a45da69-b164-0a4f-eb45-fe57f301bc4b@bytedance.com>
Date:   Mon, 5 Jun 2023 19:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Re: [PATCH net-next v5 1/3] net-memcg: Fold dependency into memcg
 pressure cond
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
 <20230602081135.75424-2-wuyun.abel@bytedance.com>
 <20230602202549.7nvrv4bx4cu7qxdn@google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230602202549.7nvrv4bx4cu7qxdn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/23 4:25 AM, Shakeel Butt wrote:
> On Fri, Jun 02, 2023 at 04:11:33PM +0800, Abel Wu wrote:
>> The callers of mem_cgroup_under_socket_pressure() should always make
>> sure that (mem_cgroup_sockets_enabled && sk->sk_memcg) is true. So
>> instead of coding around all the callsites, put the dependencies into
>> mem_cgroup_under_socket_pressure() to avoid redundancy and possibly
>> bugs.
>>
>> This change might also introduce slight function call overhead *iff*
>> the function gets expanded in the future. But for now this change
>> doesn't make binaries different (checked by vimdiff) except the one
>> net/ipv4/tcp_input.o (by scripts/bloat-o-meter), which is probably
>> negligible to performance:
>>
>> add/remove: 0/0 grow/shrink: 1/2 up/down: 5/-5 (0)
>> Function                                     old     new   delta
>> tcp_grow_window                              573     578      +5
>> tcp_try_rmem_schedule                       1083    1081      -2
>> tcp_check_space                              324     321      -3
>> Total: Before=44647, After=44647, chg +0.00%
>>
>> So folding the dependencies into mem_cgroup_under_socket_pressure()
>> is generally a good thing and provides better readablility.
>>
> 
> I don't see how it is improving readability. If you have removed the use
> of mem_cgroup_sockets_enabled completely from the networking then I can
> understand but this change IMHO will actually decrease the readability
> because the later readers will have to reason why we are doing this
> check at some places but not other.

Yes, I agree. I am trying to let networking get rid of this macro
entirely, but get stuck on inet_csk_accept().. :(
