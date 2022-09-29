Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7468A5EF8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiI2PaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiI2P3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10739167F4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664465387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWdtBthhznDnqjUu3vrXZ37rQDG7v0SPEu95AzFm5Vw=;
        b=SCJujOjGq48CXccp1H4a0gKEiSf7WRbMSXpcvpbx4XshzwqMJKgCpykBOcVnLbBO+u6ZbO
        j/rYcB8maqfbHsY0+DaMp/S5muZdhhImwj48YjnQ7gBp3uB0KgglaZ/JKsFzdo779UxH4N
        cp1pLDSHt3EuUcw9pHoat9GvjmojMh0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-x_lhRH70PuWtsnCZtez2fQ-1; Thu, 29 Sep 2022 11:28:48 -0400
X-MC-Unique: x_lhRH70PuWtsnCZtez2fQ-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so1525600eda.19
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BWdtBthhznDnqjUu3vrXZ37rQDG7v0SPEu95AzFm5Vw=;
        b=maAA7oR/VnBmJTKRy1s8a9zBhZR6WOdw1FiI/UttddeCd6Hd9Id0A6F3t3yIs1mkUr
         Of8emhW32SBmXDyt/b8JlAfP7gpPgPHxW83cjJTmrKH1/YDpt/TqYsWTtpGM4jujelrX
         obZFL9qEb4rkbiQ7/I+q8epeAa9UE0zENv1BtfMIqQJ3CZ+SggUyZTNK5PWG8PgCCgf3
         rLkF8pEgqMKxbnAY1cYDV8Li+zOruDoK0znHtKK4eUpp1GPM4iCTx01+ZSeOtHYfTlwO
         3vn7NILxvXVqwFqT6qqnIDBmuuLlfpxgPzac2dxOvrIB4D7zK1auijhMu8NOcYXMgxzd
         VK7g==
X-Gm-Message-State: ACrzQf2AjvCQRL9WVrmb2OO6NRsgYTn9FL/Le5tHxY/EWFUaw8Kb3mim
        40eqfNlCFxLDQJ8ZCUgc0F6YqZqZ+v4com+wJV5d0j7NNRFOo537df+P6fmvA2kVVdwYSxVXsi7
        qKVMBMNI50ODeFBQTeyOSY7uq
X-Received: by 2002:a17:906:974f:b0:780:4a3c:d179 with SMTP id o15-20020a170906974f00b007804a3cd179mr3306990ejy.289.1664465326157;
        Thu, 29 Sep 2022 08:28:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM74/4NIsoCqtX6lSUOGXbmSxQA8hkyoxpaGVA5PqFDA+efJZxNcgUXt81Okw0Aqu121kZMQmQ==
X-Received: by 2002:a17:906:974f:b0:780:4a3c:d179 with SMTP id o15-20020a170906974f00b007804a3cd179mr3306957ejy.289.1664465325887;
        Thu, 29 Sep 2022 08:28:45 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709061f4400b00783c545544fsm4150990ejk.215.2022.09.29.08.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:28:45 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ae658987-8763-c6de-7198-1a418e4728b4@redhat.com>
Date:   Thu, 29 Sep 2022 17:28:43 +0200
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
To:     Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>
References: <20220928152509.141490-1-shenwei.wang@nxp.com>
 <YzT2An2J5afN1w3L@lunn.ch>
 <PAXPR04MB9185141B58499FD00C43BB6889579@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <YzWcI+U1WYJuZIdk@lunn.ch>
 <PAXPR04MB918545B92E493CB57CDE612B89579@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <PAXPR04MB918545B92E493CB57CDE612B89579@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2022 15.26, Shenwei Wang wrote:
> 
>> From: Andrew Lunn <andrew@lunn.ch>
>> Sent: Thursday, September 29, 2022 8:23 AM
[...]
>>
>>> I actually did some compare testing regarding the page pool for normal
>>> traffic.  So far I don't see significant improvement in the current
>>> implementation. The performance for large packets improves a little,
>>> and the performance for small packets get a little worse.
>>
>> What hardware was this for? imx51? imx6? imx7 Vybrid? These all use the FEC.
> 
> I tested on imx8qxp platform. It is ARM64.

On mvneta driver/platform we saw huge speedup replacing:

   page_pool_release_page(rxq->page_pool, page);
with
   skb_mark_for_recycle(skb);

As I mentioned: Today page_pool have SKB recycle support (you might have 
looked at drivers that didn't utilize this yet), thus you don't need to 
release the page (page_pool_release_page) here.  Instead you could 
simply mark the SKB for recycling, unless driver does some page refcnt 
tricks I didn't notice.

On the mvneta driver/platform the DMA unmap (in page_pool_release_page) 
was very expensive. This imx8qxp platform might have faster DMA unmap in 
case is it cache-coherent.

I would be very interested in knowing if skb_mark_for_recycle() helps on 
this platform, for normal network stack performance.

>> By small packets, do you mean those under the copybreak limit?
>>
>> Please provide some benchmark numbers with your next patchset.
> 
> Yes, the packet size is 64 bytes and it is under the copybreak limit.
> As the impact is not significant, I would prefer to remove the
> copybreak  logic.

+1 to removing this logic if possible, due to maintenance cost.

--Jesper

