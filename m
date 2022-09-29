Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77455EFD79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiI2S4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiI2S4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBC3A49F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664477777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ii/zdDDzioDeAg4ijCoWLsXuT0PoJynFMmsjY+6iNyY=;
        b=HfVQRjVhlMcB9LU9zSbyZOJNh9OlxRE2kiqV3ApMCGYF76pKpEoMPPlqay8Z6ULdrLT9Fj
        waEq/vGSXP/RdnF63uy34pZsVb9v25pM1E2i8KZhZ4OEFajltZ33FgXkeu26mtL3MKfvxf
        C2IhEZNWaUcNIJqG8mIbi7/mEv0zWS0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-6laqsQL5Pk-L4u71UaKsDw-1; Thu, 29 Sep 2022 14:55:24 -0400
X-MC-Unique: 6laqsQL5Pk-L4u71UaKsDw-1
Received: by mail-ed1-f72.google.com with SMTP id y1-20020a056402358100b00451b144e23eso1867363edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ii/zdDDzioDeAg4ijCoWLsXuT0PoJynFMmsjY+6iNyY=;
        b=FQFBvDxphKrrestX800EZomx/0z1Z16oMvwTXk0J8DO8n9jWKzGas5hs6SRaDmhfXE
         OiZOQ2Qy/vM+TRTcPlWGhgpuQj0SXexQN6xebsa8XLySNoJ5+MiSbT7WjI7IEf1XOs+0
         6YBfikMwvMBkM9/22ByFLFCzWku1vCN43Uou5BUtN0kTRBjB+Ftw+22V727Negyq7hBR
         qiYKYAbajUg6to6U1nhP2+qqpix5RMUHPIJz5LkFY/j6Qe/AGdDIZmjdFndO4lG09hmX
         wC69ue3CABdCKkBs9IUBgusgMqMw0Gi1SHRgbUebaZ7wie6Ns9H0H29p2+YbQCndwDDR
         ZbHA==
X-Gm-Message-State: ACrzQf1SPXAvWh9Dqj3Lpx9/8HJamsmEEKLAa3A6jTgmD964MaXqtrXv
        aCn0OSrOD+DIh4GN8De6no0gpEUsJF83cT/GjgKkJVGrSjgQ5paxmYwysxVOyPNjnt3prLP62q4
        MESkskrDyLDj1NlMXwCJKI6M/
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id wu1-20020a170906eec100b00782638476bemr3829799ejb.756.1664477722947;
        Thu, 29 Sep 2022 11:55:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42IrmOoNBkxw7IFK/Fcf3fs7srHeyKhwzHkAPoxCYkxOO/VTiZbG6+F2H6PCnMvcmycfKlHA==
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id wu1-20020a170906eec100b00782638476bemr3829779ejb.756.1664477722669;
        Thu, 29 Sep 2022 11:55:22 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906581100b0073a644ef803sm4383184ejq.101.2022.09.29.11.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 11:55:22 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <afb652db-05fc-d3d6-6774-bfd9830414d9@redhat.com>
Date:   Thu, 29 Sep 2022 20:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     brouer@redhat.com, Joakim Zhang <qiangqing.zhang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH 1/1] net: fec: add initial XDP support
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <20220928152509.141490-1-shenwei.wang@nxp.com>
 <YzT2An2J5afN1w3L@lunn.ch>
 <PAXPR04MB9185141B58499FD00C43BB6889579@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <YzWcI+U1WYJuZIdk@lunn.ch>
 <PAXPR04MB918545B92E493CB57CDE612B89579@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ae658987-8763-c6de-7198-1a418e4728b4@redhat.com>
 <PAXPR04MB918584422BE4ECAF79C0295A89579@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB918584422BE4ECAF79C0295A89579@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2022 17.52, Shenwei Wang wrote:
> 
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>>
>> On 29/09/2022 15.26, Shenwei Wang wrote:
>>>
>>>> From: Andrew Lunn <andrew@lunn.ch>
>>>> Sent: Thursday, September 29, 2022 8:23 AM
>> [...]
>>>>
>>>>> I actually did some compare testing regarding the page pool for
>>>>> normal traffic.  So far I don't see significant improvement in the
>>>>> current implementation. The performance for large packets improves a
>>>>> little, and the performance for small packets get a little worse.
>>>>
>>>> What hardware was this for? imx51? imx6? imx7 Vybrid? These all use the FEC.
>>>
>>> I tested on imx8qxp platform. It is ARM64.
>>
>> On mvneta driver/platform we saw huge speedup replacing:
>>
>>     page_pool_release_page(rxq->page_pool, page); with
>>     skb_mark_for_recycle(skb);
>>
>> As I mentioned: Today page_pool have SKB recycle support (you might have
>> looked at drivers that didn't utilize this yet), thus you don't need to release the
>> page (page_pool_release_page) here.  Instead you could simply mark the SKB
>> for recycling, unless driver does some page refcnt tricks I didn't notice.
>>
>> On the mvneta driver/platform the DMA unmap (in page_pool_release_page)
>> was very expensive. This imx8qxp platform might have faster DMA unmap in
>> case is it cache-coherent.
>>
>> I would be very interested in knowing if skb_mark_for_recycle() helps on this
>> platform, for normal network stack performance.
>>
> 
> Did a quick compare testing for the following 3 scenarios:

Thanks for doing this! :-)

> 1. original implementation
> 
> shenwei@5810:~$ iperf -c 10.81.16.245 -w 2m -i 1
> ------------------------------------------------------------
> Client connecting to 10.81.16.245, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested 1.91 MByte)
> ------------------------------------------------------------
> [  1] local 10.81.17.20 port 49154 connected with 10.81.16.245 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-1.0000 sec   104 MBytes   868 Mbits/sec
> [  1] 1.0000-2.0000 sec   105 MBytes   878 Mbits/sec
> [  1] 2.0000-3.0000 sec   105 MBytes   881 Mbits/sec
> [  1] 3.0000-4.0000 sec   105 MBytes   879 Mbits/sec
> [  1] 4.0000-5.0000 sec   105 MBytes   878 Mbits/sec
> [  1] 5.0000-6.0000 sec   105 MBytes   878 Mbits/sec
> [  1] 6.0000-7.0000 sec   104 MBytes   875 Mbits/sec
> [  1] 7.0000-8.0000 sec   104 MBytes   875 Mbits/sec
> [  1] 8.0000-9.0000 sec   104 MBytes   873 Mbits/sec
> [  1] 9.0000-10.0000 sec   104 MBytes   875 Mbits/sec
> [  1] 0.0000-10.0073 sec  1.02 GBytes   875 Mbits/sec
> 
> 2. Page pool with page_pool_release_page
> 
> shenwei@5810:~$ iperf -c 10.81.16.245 -w 2m -i 1
> ------------------------------------------------------------
> Client connecting to 10.81.16.245, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested 1.91 MByte)
> ------------------------------------------------------------
> [  1] local 10.81.17.20 port 35924 connected with 10.81.16.245 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-1.0000 sec   101 MBytes   849 Mbits/sec
> [  1] 1.0000-2.0000 sec   102 MBytes   860 Mbits/sec
> [  1] 2.0000-3.0000 sec   102 MBytes   860 Mbits/sec
> [  1] 3.0000-4.0000 sec   102 MBytes   859 Mbits/sec
> [  1] 4.0000-5.0000 sec   103 MBytes   863 Mbits/sec
> [  1] 5.0000-6.0000 sec   103 MBytes   864 Mbits/sec
> [  1] 6.0000-7.0000 sec   103 MBytes   863 Mbits/sec
> [  1] 7.0000-8.0000 sec   103 MBytes   865 Mbits/sec
> [  1] 8.0000-9.0000 sec   103 MBytes   862 Mbits/sec
> [  1] 9.0000-10.0000 sec   102 MBytes   856 Mbits/sec
> [  1] 0.0000-10.0246 sec  1.00 GBytes   858 Mbits/sec
> 
> 
> 3. page pool with skb_mark_for_recycle
> 
> shenwei@5810:~$ iperf -c 10.81.16.245 -w 2m -i 1
> ------------------------------------------------------------
> Client connecting to 10.81.16.245, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested 1.91 MByte)
> ------------------------------------------------------------
> [  1] local 10.81.17.20 port 42724 connected with 10.81.16.245 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-1.0000 sec   111 MBytes   931 Mbits/sec
> [  1] 1.0000-2.0000 sec   112 MBytes   935 Mbits/sec
> [  1] 2.0000-3.0000 sec   111 MBytes   934 Mbits/sec
> [  1] 3.0000-4.0000 sec   111 MBytes   934 Mbits/sec
> [  1] 4.0000-5.0000 sec   111 MBytes   934 Mbits/sec
> [  1] 5.0000-6.0000 sec   112 MBytes   935 Mbits/sec
> [  1] 6.0000-7.0000 sec   111 MBytes   934 Mbits/sec
> [  1] 7.0000-8.0000 sec   111 MBytes   933 Mbits/sec
> [  1] 8.0000-9.0000 sec   112 MBytes   935 Mbits/sec
> [  1] 9.0000-10.0000 sec   111 MBytes   933 Mbits/sec
> [  1] 0.0000-10.0069 sec  1.09 GBytes   934 Mbits/sec

This is a very significant performance improvement (page pool with
skb_mark_for_recycle).  This is very close to the max goodput for a
1Gbit/s link.


> For small packet size (64 bytes), all three cases have almost the same result:
> 

To me this indicate, that the DMA map/unmap operations on this platform
are indeed more expensive on larger packets.  Given this is what
page_pool does, keeping the DMA mapping intact when recycling.

Driver still need DMA-sync, although I notice you set page_pool feature
flag PP_FLAG_DMA_SYNC_DEV, this is good as page_pool will try to reduce
sync size where possible. E.g. in this SKB case will reduce the DMA-sync
to the max_len=FEC_ENET_RX_FRSIZE which should also help on performance.


> shenwei@5810:~$ iperf -c 10.81.16.245 -w 2m -i 1 -l 64
> ------------------------------------------------------------
> Client connecting to 10.81.16.245, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested 1.91 MByte)
> ------------------------------------------------------------
> [  1] local 10.81.17.20 port 58204 connected with 10.81.16.245 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  1] 0.0000-1.0000 sec  36.9 MBytes   309 Mbits/sec
> [  1] 1.0000-2.0000 sec  36.6 MBytes   307 Mbits/sec
> [  1] 2.0000-3.0000 sec  36.6 MBytes   307 Mbits/sec
> [  1] 3.0000-4.0000 sec  36.5 MBytes   307 Mbits/sec
> [  1] 4.0000-5.0000 sec  37.1 MBytes   311 Mbits/sec
> [  1] 5.0000-6.0000 sec  37.2 MBytes   312 Mbits/sec
> [  1] 6.0000-7.0000 sec  37.1 MBytes   311 Mbits/sec
> [  1] 7.0000-8.0000 sec  37.1 MBytes   311 Mbits/sec
> [  1] 8.0000-9.0000 sec  37.1 MBytes   312 Mbits/sec
> [  1] 9.0000-10.0000 sec  37.2 MBytes   312 Mbits/sec
> [  1] 0.0000-10.0097 sec   369 MBytes   310 Mbits/sec
> 
> Regards,
> Shenwei
> 
> 
>>>> By small packets, do you mean those under the copybreak limit?
>>>>
>>>> Please provide some benchmark numbers with your next patchset.
>>>
>>> Yes, the packet size is 64 bytes and it is under the copybreak limit.
>>> As the impact is not significant, I would prefer to remove the
>>> copybreak  logic.
>>
>> +1 to removing this logic if possible, due to maintenance cost.
>>
>> --Jesper
> 

