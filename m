Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F16DC3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDJHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDJHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:36:08 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD8C30F5;
        Mon, 10 Apr 2023 00:36:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2cab:0:640:424b:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id CA9C3604A2;
        Mon, 10 Apr 2023 10:35:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8007::1:d] (unknown [2a02:6b8:b081:8007::1:d])
        by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id uZO7Ys0OpmI0-caxomMtx;
        Mon, 10 Apr 2023 10:35:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1681112158; bh=3dCHwo5fU8s5rqgyut3lerRKOgYe9VyFayEL4QUWIXM=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=c8k0dQCxJCPAqpxII9N3JlDhR01TVsZNTXJ7V9XnYMmwO19aVv96pLMB0En6znRed
         loVI/53AH3f5OByf7Y1l3iYW3bGCdYNjtByQa15AP3+OuwGTiwAhWkaQHxveKDAW0K
         ESI9KyQu56VNU4s++hLEKx1mFKXFxmvDd92GnMLs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <98435c8c-8bdc-35be-4d81-3491f872f555@yandex-team.ru>
Date:   Mon, 10 Apr 2023 10:35:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: target: cxgbit: check skb dequeue result
To:     Bodo Stroesser <bostroesser@gmail.com>, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        varun@chelsio.com, nab@linux-iscsi.org, martin.petersen@oracle.com
References: <20230406150405.300909-1-den-plotnikov@yandex-team.ru>
 <2170fe67-2e65-630b-22dc-a8f6d3f7966f@gmail.com>
Content-Language: en-US
From:   Denis Plotnikov <den-plotnikov@yandex-team.ru>
In-Reply-To: <2170fe67-2e65-630b-22dc-a8f6d3f7966f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.04.2023 22:16, Bodo Stroesser wrote:
> On 06.04.23 17:04, Denis Plotnikov wrote:
>> On a couple of abort packet paths skb dequeuing may end up with
>> returning NULL, which, in turn, may end up with further null
>> pointer dereference.
>>
>> Fix it by checking the return value of skb dequeuing.
>>
>> Found by Linux Verification Center(linuxtesting.org) with SVACE.
>>
>> Fixes: 9730ffcb8957 (cxgbit: add files for cxgbit.ko)
>> Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
>> ---
>>   drivers/target/iscsi/cxgbit/cxgbit_cm.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c 
>> b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
>> index 518ded214e74..d43fd761c20a 100644
>> --- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
>> +++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
>> @@ -669,6 +669,9 @@ static int cxgbit_send_abort_req(struct 
>> cxgbit_sock *csk)
>>           cxgbit_send_tx_flowc_wr(csk);
>>         skb = __skb_dequeue(&csk->skbq);
>> +    if (!skb)
>> +        return 0;
>> +
>>       cxgb_mk_abort_req(skb, len, csk->tid, csk->txq_idx,
>>                 csk->com.cdev, cxgbit_abort_arp_failure);
>>   @@ -1769,9 +1772,10 @@ static void cxgbit_abort_req_rss(struct 
>> cxgbit_sock *csk, struct sk_buff *skb)
>>           cxgbit_send_tx_flowc_wr(csk);
>>         rpl_skb = __skb_dequeue(&csk->skbq);
>> -
>> -    cxgb_mk_abort_rpl(rpl_skb, len, csk->tid, csk->txq_idx);
>> -    cxgbit_ofld_send(csk->com.cdev, rpl_skb);
>> +    if (!rpl_skb) {
>
> Honestly I have no clue about cxgbit, but to avoid null pointer
> dereference, shouldn't it be "if (rpl_skb) {"?

Yes it should. Thanks for finding that. I'll resend the patch.

Frankly, I have no clue about cxgbit as well, so may be there is a 
better way to cope with the null pointer issue here.

Denis

>
> Bodo
>
>
>> +        cxgb_mk_abort_rpl(rpl_skb, len, csk->tid, csk->txq_idx);
>> +        cxgbit_ofld_send(csk->com.cdev, rpl_skb);
>> +    }
>>         if (wakeup_thread) {
>>           cxgbit_queue_rx_skb(csk, skb);
