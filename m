Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200572FA14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbjFNKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbjFNKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:06:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5D18C;
        Wed, 14 Jun 2023 03:06:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35EA63fU127468;
        Wed, 14 Jun 2023 05:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686737163;
        bh=iFsvYPvQkajYLTBSl+GGXtHGsI9rPc41gAMCUtzgEHM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nTQcRXDu5YPj1KsBQnn2WQb2YHsKHQLRXwKOYwVpECkVYYVrzWEoIDKZoeKf71ztK
         h31c9iUTerCplmwMWnUWKR7FxYPLXlU3Dpp1QPOgXgkg1P6ONfGiePo0nWB7bi8R7T
         KVYM7xTVHv+GOGie5XqKqbmWRXlgI1BLFI02P6RY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35EA62tu067285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 05:06:03 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Jun 2023 05:06:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Jun 2023 05:06:02 -0500
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35EA5xFf015594;
        Wed, 14 Jun 2023 05:06:00 -0500
Message-ID: <527454c6-7516-c226-dae6-636eea698353@ti.com>
Date:   Wed, 14 Jun 2023 15:35:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net: hsr: Disable promiscuous mode in offload mode
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <bigeasy@linutronix.de>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@kernel.org>
References: <20230612093933.13267-1-r-gunasekaran@ti.com>
 <dffbf0474b1352f1eac63125a973c8f8cd7b3e8d.camel@redhat.com>
 <f50ad11eb5ca3cb777e7150ad6a8347e575f1667.camel@redhat.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <f50ad11eb5ca3cb777e7150ad6a8347e575f1667.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/23 3:14 PM, Paolo Abeni wrote:
> On Wed, 2023-06-14 at 11:42 +0200, Paolo Abeni wrote:
>> On Mon, 2023-06-12 at 15:09 +0530, Ravi Gunasekaran wrote:
>>> When port-to-port forwarding for interfaces in HSR node is enabled,
>>> disable promiscuous mode since L2 frame forward happens at the
>>> offloaded hardware.
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---
>>>  net/hsr/hsr_device.c |  5 +++++
>>>  net/hsr/hsr_main.h   |  1 +
>>>  net/hsr/hsr_slave.c  | 15 +++++++++++----
>>>  3 files changed, 17 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>>> index 5a236aae2366..306f942c3b28 100644
>>> --- a/net/hsr/hsr_device.c
>>> +++ b/net/hsr/hsr_device.c
>>> @@ -531,6 +531,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>>>  	if (res)
>>>  		goto err_add_master;
>>>  
>>> +	/* HSR forwarding offload supported in lower device? */
>>> +	if ((slave[0]->features & NETIF_F_HW_HSR_FWD) &&
>>> +	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
>>> +		hsr->fwd_offloaded = true;
>>> +
>>>  	res = register_netdevice(hsr_dev);
>>>  	if (res)
>>>  		goto err_unregister;
>>> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
>>> index 5584c80a5c79..0225fabbe6d1 100644
>>> --- a/net/hsr/hsr_main.h
>>> +++ b/net/hsr/hsr_main.h
>>> @@ -195,6 +195,7 @@ struct hsr_priv {
>>>  	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
>>>  	struct timer_list	announce_timer;	/* Supervision frame dispatch */
>>>  	struct timer_list	prune_timer;
>>> +	unsigned int            fwd_offloaded : 1; /* Forwarding offloaded to HW */
>>
>> Please use plain 'bool' instead.
>>
>> Also there is an hole in 'struct hsr_priv' just after 'net_id', you
>> could consider moving this new field there.
> 
> Oops, I almost forgot! Please include the target tree (net-next in this
> case) in the subj prefix on your next submission.
> 

I will take care of this from next submission onwards.

> Thanks,
> 
> Paolo
> 

-- 
Regards,
Ravi
