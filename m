Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A0633D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiKVNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiKVNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:12:45 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7F5F5A;
        Tue, 22 Nov 2022 05:12:44 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NGl2w0DgVzJnm9;
        Tue, 22 Nov 2022 21:09:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:12:43 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:12:42 +0800
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <djrscally@gmail.com>, <heikki.krogerus@linux.intel.com>,
        <sakari.ailus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <75602dce-0780-e51a-c8c9-d1820ddf3e2b@huawei.com>
Date:   Tue, 22 Nov 2022 21:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2022/11/22 20:54, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:
>> The 'parent' returned by fwnode_graph_get_port_parent()
>> with refcount incremented when 'prev' is not null, it
> NULL
>
>> needs be put when finish using it.
>>
>> Because the parent is const, introduce a new variable to
>> store the returned fwnode, then put it before returning
>> from fwnode_graph_get_next_endpoint().
> ...
>
>>   fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>>   			       struct fwnode_handle *prev)
>>   {
>> +	struct fwnode_handle *ep, *port_parent = NULL;
>>   	const struct fwnode_handle *parent;
>> -	struct fwnode_handle *ep;
>>   
>>   	/*
>>   	 * If this function is in a loop and the previous iteration returned
>>   	 * an endpoint from fwnode->secondary, then we need to use the secondary
>>   	 * as parent rather than @fwnode.
>>   	 */
>> -	if (prev)
>> -		parent = fwnode_graph_get_port_parent(prev);
>> -	else
>> +	if (prev) {
>> +		port_parent = fwnode_graph_get_port_parent(prev);
>> +		parent = port_parent;
>> +	} else {
>>   		parent = fwnode;
>> +	}
>>   	if (IS_ERR_OR_NULL(parent))
>>   		return NULL;
>>   
>>   	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>> -	if (ep)
>> +	if (ep) {
>> +		fwnode_handle_put(port_parent);
>>   		return ep;
>> +	}
>>   
>> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>> +	fwnode_handle_put(port_parent);
>> +	return ep;
> It seems too complicated for the simple fix.
>
> As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
> branch. This will allow you to drop if (prev) at the end.

fwnode is const, fwnode_handle_get doesn't accept this type.

>
