Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617C7222BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjFEJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFEJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:57:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B1B0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 02:57:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b038064d97so42825515ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685959038; x=1688551038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyuCPt1vQNlaWH7tCffqZV2k/RtNlXHoU62GbJy8Xjk=;
        b=KKGiHDA+xwC+Nm4KS7WEjinOuCG1iVjs4z+FmI8SpBouzvSfV4RqeQidTBGyVkA19I
         Oh0TRdzdP3GJkcP6FekYo8ImlboVTxzu/vCtrxiT+dkG2TBAvOliU6hwgC3b5yQCwkZV
         ue8mOe5XCOP2vcouiSDq+wVpvmWTG/JDCIfoUa4Pyh87YXdvAXY7EDkQVKzI/nyoPaWV
         gWrnFcvLgMQqHdqUnwpFVXl7QK+x1EbdnB8dsjpgLIjIozZlTX8BW9drTjYqqlP7v9oY
         Igs9eoVOUVnNsUfVZM7CU8zm4TwVsb3znjj/lBNSD/l+EYn15Btp40XCSuplRIWpCx/E
         4jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685959038; x=1688551038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyuCPt1vQNlaWH7tCffqZV2k/RtNlXHoU62GbJy8Xjk=;
        b=XOnDs/kNynBVPJwIHj8My8Uvz6aK4L6XWkEV7IjmQhm1ArXQkS9IeWbkl7FFUKCJ0D
         2joG9H2KVPw+sXAcR1kLpUtxK0rVNwU8HWSw0LgAbZTpiok79tViZ2r8sTDEDSpHtsDM
         MQu4oKdoMhG/HSvXt//m6AoUtHm+IT4OG1MYGoMVuqEF/0xePllwbIFMOGlUx2dQ9GZO
         Ju5UL/ewkthvvNhdmTVIT0ia8XQPFDSxTd++/CVEvo4cwCkQb/ptmf8lI0KDNfYVpz0g
         4RboTODT0hiYP8ef+LXxTt72DGIx7zY4E2u8Is8cO8Za03OrE+YEOlx81sR9MbXrtQ1F
         g2Cw==
X-Gm-Message-State: AC+VfDxd4O5vp7iXSJa8+/bz03T9dY0CHea0Cq1Nm+We31XvUiBgGos8
        Qh+bQ6COsu42QbmZYPBr/9ghgg==
X-Google-Smtp-Source: ACHHUZ7UU+7VhOoZ+LaCsaa8oefNZLkAgK8CdKo9gcU9SGPUfv5AJPuReZuksUmH0QYq0D1i0CWW5Q==
X-Received: by 2002:a17:903:2305:b0:1b0:4c6c:716 with SMTP id d5-20020a170903230500b001b04c6c0716mr9054747plh.4.1685959038094;
        Mon, 05 Jun 2023 02:57:18 -0700 (PDT)
Received: from [10.254.80.225] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b001ae469ca0c0sm6152081plc.245.2023.06.05.02.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 02:57:17 -0700 (PDT)
Message-ID: <806149cf-cc07-ad5a-267e-94a6bc3b4106@bytedance.com>
Date:   Mon, 5 Jun 2023 17:57:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Re: Re: [PATCH net-next v5 2/3] sock: Always take memcg pressure
 into consideration
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
 <20230602081135.75424-3-wuyun.abel@bytedance.com>
 <20230602204159.vo7fmuvh3y2pdfi5@google.com>
 <CAF=yD-LFQRreWq1RMkvLw9Nj3NQpJwbDSCfECUhh-aVchR-jsg@mail.gmail.com>
 <6f67c3ca-5e73-d7ac-f32a-42a21d3ea576@bytedance.com>
 <727b1fb64d04deb8b2a9ae1fec4b51dafa1ff2b5.camel@redhat.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <727b1fb64d04deb8b2a9ae1fec4b51dafa1ff2b5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 4:27 PM, Paolo Abeni wrote:
> On Mon, 2023-06-05 at 11:44 +0800, Abel Wu wrote:
>> On 6/4/23 6:36 PM, Willem de Bruijn wrote:
>>> On Fri, Jun 2, 2023 at 10:42 PM Shakeel Butt <shakeelb@google.com> wrote:
>>>>
>>>> On Fri, Jun 02, 2023 at 04:11:34PM +0800, Abel Wu wrote:
>>>>> The sk_under_memory_pressure() is called to check whether there is
>>>>> memory pressure related to this socket. But now it ignores the net-
>>>>> memcg's pressure if the proto of the socket doesn't care about the
>>>>> global pressure, which may put burden on its memcg compaction or
>>>>> reclaim path (also remember that socket memory is un-reclaimable).
>>>>>
>>>>> So always check the memcg's vm status to alleviate memstalls when
>>>>> it's in pressure.
>>>>>
>>>>
>>>> This is interesting. UDP is the only protocol which supports memory
>>>> accounting (i.e. udp_memory_allocated) but it does not define
>>>> memory_pressure. In addition, it does have sysctl_udp_mem. So
>>>> effectively UDP supports a hard limit and ignores memcg pressure at the
>>>> moment. This patch will change its behavior to consider memcg pressure
>>>> as well. I don't have any objection but let's get opinion of UDP
>>>> maintainer.
> 
> Thanks for the head-up, I did not notice the side effect on UDP.
> 
>>
>>> So this commit only affects the only other protocol-independent
>>> caller, __sk_mem_reduce_allocated, to possibly call
>>> sk_leave_memory_pressure if now under the global limit.
>>>
>>> What is the expected behavioral change in practice of this commit?
>>
>> Be more conservative on sockmem alloc if under memcg pressure, to
>> avoid worse memstall/latency.
> 
> I guess the above is for TCP sockets only, right? Or at least not for
> UDP sockets?

Yes, I started off with TCP but wondering if it is applicable to the
others too as the 'problem' sounds really generic to me.

> 
> If so, I think we should avoid change of behaviour for UDP - e.g.
> keeping the initial 'if (!sk->sk_prot->memory_pressure)' in
> sk_under_memory_pressure(), with some comments about the rationale for
> future memory. That should preserve the whole patchset effect for other
> protocols, right?

Keeping the if statement as it is would imply the prot pressure as a
master 'switch' to all kinds of pressure. IMHO this might hurt other
protocols with pressure enabled if they are all used in one memcg which
happens to be under vmpressure, IOW UDP allocations are given higher
priority than others.

> 
> If instead you are also interested into UDP sockets under pressure, how
> that is going to work? UDP sockets can reclaim memory only at send and
> close time. A memcg under pressure could starve some sockets forever if
> the the ones keeping the memory busy are left untouched.

Yes.. And it starts to get me confused that why&when should the memcg
pressure be used given that we don't want to put harsh constrains on
sockmem even under memcg pressure.

Thanks!
	Abel
