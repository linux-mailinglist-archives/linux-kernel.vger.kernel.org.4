Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F2F6BD6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCPRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCPRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87D9F20F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678986631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZTQMrsIX/IeLCwGq7gJekCkDfhbKmPVXG90DA14gRc=;
        b=EcxWqt2rRnFHfABIznzG7LgP2PHH95f2F6RyqM914aDZZ8l86BsLOqxnTZQMmN7ePz4j2L
        T8YalfjvBQVXdfGNLVdlfACqSSJmZVBzs5WmMsdbxXQXmH6iP+6R4g1Tq5MZzeIAFCmuu5
        C4+D8uTbqggA4H7Pz4lgParwTFqw2tE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-W17-GHYFOn6Z1bwy3_gL9A-1; Thu, 16 Mar 2023 13:10:30 -0400
X-MC-Unique: W17-GHYFOn6Z1bwy3_gL9A-1
Received: by mail-ed1-f71.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so3991108edb.21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678986629;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZTQMrsIX/IeLCwGq7gJekCkDfhbKmPVXG90DA14gRc=;
        b=v2xWH6u61X5KcnpdKbwnvipL61YYhgmheUyjSexaJs+MTf9rnpG5EbmrqlK+GgNeoi
         LpwwLlwDQ5+CvOhMDYK7qeBnTxKqgkMXmN+cT6mbNdySbOfvnc4ywxXIO4kiKVdl0R6d
         2WSi1U1huX2NNwn4b+nc0MATsTuyXS19jD85G3TbVbwtyjUoZu12p6Y2Dud/DrhTUgNd
         tgtY1wGDOfqNG5azClleLARWSmlkDDyVOtnRyX+JCu48KjeHuR2mOHOJBMr59lleH6dL
         e0hm/ZX5t53kr2qiGoPfu5nU3VHgKFEi/EkpugrbYPxnAZ62mXaMmTzXx221jGbqWPZ8
         inVg==
X-Gm-Message-State: AO0yUKUPgpVjtiezkduJxX1IAk/8pv8NPUxM1QIGPFV/3BFbxYXzhDz0
        zb+k4ti1fYQouim233vG/6fGMKKPXGhMOpMBwfJbK/KyUsLIhsPFwEOmYHnf2SHHLMX7pthTAPV
        b2//AJ2CYpqDuDSW9q643yQ6y
X-Received: by 2002:aa7:cb4f:0:b0:4fb:1b0d:9f84 with SMTP id w15-20020aa7cb4f000000b004fb1b0d9f84mr364341edt.6.1678986629042;
        Thu, 16 Mar 2023 10:10:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set+0JeqVaVx07XZo7EVzLMP/yLmcLIMvIyZESAzWeDEsUdXWf7gZiG66vhAKtrpgzbvpGyiyAQ==
X-Received: by 2002:aa7:cb4f:0:b0:4fb:1b0d:9f84 with SMTP id w15-20020aa7cb4f000000b004fb1b0d9f84mr364303edt.6.1678986628740;
        Thu, 16 Mar 2023 10:10:28 -0700 (PDT)
Received: from [192.168.42.100] (cgn-cgn10-212-237-176-220.static.kviknet.net. [212.237.176.220])
        by smtp.gmail.com with ESMTPSA id r3-20020a50d683000000b004c0239e41d8sm2930edi.81.2023.03.16.10.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:10:27 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <0377c85c-5d59-49e5-017f-212821849a18@redhat.com>
Date:   Thu, 16 Mar 2023 18:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Mykola Lysenko <mykolal@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Freysteinn Alfredsson <Freysteinn.Alfredsson@kau.se>
Subject: Re: [PATCH bpf-next v3 3/4] xdp: recycle Page Pool backed skbs built
 from XDP frames
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230313215553.1045175-1-aleksander.lobakin@intel.com>
 <20230313215553.1045175-4-aleksander.lobakin@intel.com>
 <11e480dd-7969-7b58-440e-3207b98d0ac5@redhat.com>
 <85d803a2-a315-809a-5eff-13892aff5401@intel.com>
In-Reply-To: <85d803a2-a315-809a-5eff-13892aff5401@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/03/2023 15.58, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Date: Wed, 15 Mar 2023 15:55:44 +0100
> 
>> On 13/03/2023 22.55, Alexander Lobakin wrote:
[...]
>>>
>>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>>> index 8c92fc553317..a2237cfca8e9 100644
>>> --- a/net/core/xdp.c
>>> +++ b/net/core/xdp.c
>>> @@ -658,8 +658,8 @@ struct sk_buff *__xdp_build_skb_from_frame(struct
>>> xdp_frame *xdpf,
>>>         * - RX ring dev queue index    (skb_record_rx_queue)
>>>         */
>>>    -    /* Until page_pool get SKB return path, release DMA here */
>>> -    xdp_release_frame(xdpf);
>>> +    if (xdpf->mem.type == MEM_TYPE_PAGE_POOL)
>>> +        skb_mark_for_recycle(skb);
>>
>> I hope this is safe ;-) ... Meaning hopefully drivers does the correct
>> thing when XDP_REDIRECT'ing page_pool pages.
> 
> Safe when it's done by the schoolbook. For now I'm observing only one
> syzbot issue with test_run due to that it assumes yet another bunch
> o'things I wouldn't rely on :D (separate subthread)
> 
>>
>> Looking for drivers doing weird refcnt tricks and XDP_REDIRECT'ing, I
>> noticed the driver aquantia/atlantic (in aq_get_rxpages_xdp), but I now
>> see this is not using page_pool, so it should be affected by this (but I
>> worry if atlantic driver have a potential race condition for its refcnt
>> scheme).
> 
> If we encounter some driver using Page Pool, but mangling refcounts on
> redirect, we'll fix it ;)
> 

Thanks for signing up for fixing these issues down-the-road :-)

For what is it worth, I've rebased to include this patchset on my
testlab.

For now, I've tested mlx5 with cpumap redirect and net stack processing,
everything seems to be working nicely. When disabling GRO/GRO, then the
cpumap get same and sometimes better TCP throughput performance,
even-though checksum have to be done in software. (Hopefully we can soon
close the missing HW checksum gap with XDP-hints).

--Jesper

