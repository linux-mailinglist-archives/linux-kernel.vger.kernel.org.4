Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C11E6386C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKYJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKYJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:51:22 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699F03FB8B;
        Fri, 25 Nov 2022 01:49:14 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJVMt6mZfzbngb;
        Fri, 25 Nov 2022 17:45:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 17:49:12 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 17:49:11 +0800
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
To:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <yangyingliang@huawei.com>
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
 <Y34gz4UXN7il3b49@smile.fi.intel.com>
 <d2c7979e-3891-283e-d20b-97b75a27730e@gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5061895a-bbd3-6a9f-c938-f101123ac308@huawei.com>
Date:   Fri, 25 Nov 2022 17:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d2c7979e-3891-283e-d20b-97b75a27730e@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/25 17:32, Daniel Scally wrote:
> Hello
>
> On 23/11/2022 13:31, Andy Shevchenko wrote:
>> On Wed, Nov 23, 2022 at 10:25:42AM +0800, Yang Yingliang wrote:
>>> The 'parent' returned by fwnode_graph_get_port_parent()
>>> with refcount incremented when 'prev' is not NULL, it
>>> needs be put when finish using it.
>>>
>>> Because the parent is const, introduce a new variable to
>>> store the returned fwnode, then put it before returning
>>> from fwnode_graph_get_next_endpoint().
>> To me this looks good enough. Not sure if Dan has a chance (time) to look at
>> this, though. And maybe even test...
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Apologies; didn't notice this earlier. I will look at and test this today

Thanks,

I tested it, without this patch, I got this message:
OF: ERROR: memory leak, expected refcount 1 instead of 4, 
of_node_get()/of_node_put() unbalanced - destroy cset entry: attach 
overlay node /i2c/pmic@34/tcpc/connector
after this patch,  the message is gone.
>
>>> Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>> v2 -> v3:
>>>    Add a out label.
>>>
>>> v1 -> v2:
>>>    Introduce a new variable to store the returned fwnode.
>>> ---
>>>   drivers/base/property.c | 18 ++++++++++++------
>>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>>> index 2a5a37fcd998..7f338cb4fb7b 100644
>>> --- a/drivers/base/property.c
>>> +++ b/drivers/base/property.c
>>> @@ -989,26 +989,32 @@ struct fwnode_handle *
>>>   fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>>>   			       struct fwnode_handle *prev)
>>>   {
>>> +	struct fwnode_handle *ep, *port_parent = NULL;
>>>   	const struct fwnode_handle *parent;
>>> -	struct fwnode_handle *ep;
>>>   
>>>   	/*
>>>   	 * If this function is in a loop and the previous iteration returned
>>>   	 * an endpoint from fwnode->secondary, then we need to use the secondary
>>>   	 * as parent rather than @fwnode.
>>>   	 */
>>> -	if (prev)
>>> -		parent = fwnode_graph_get_port_parent(prev);
>>> -	else
>>> +	if (prev) {
>>> +		port_parent = fwnode_graph_get_port_parent(prev);
>>> +		parent = port_parent;
>>> +	} else {
>>>   		parent = fwnode;
>>> +	}
>>>   	if (IS_ERR_OR_NULL(parent))
>>>   		return NULL;
>>>   
>>>   	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>>>   	if (ep)
>>> -		return ep;
>>> +		goto out_put_port_parent;
>>> +
>>> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>>>   
>>> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>>> +out_put_port_parent:
>>> +	fwnode_handle_put(port_parent);
>>> +	return ep;
>>>   }
>>>   EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>>>   
>>> -- 
>>> 2.25.1
>>>
> .
