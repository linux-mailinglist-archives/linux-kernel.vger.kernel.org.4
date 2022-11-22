Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2B633DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiKVNlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiKVNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:41:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397265ADF9;
        Tue, 22 Nov 2022 05:41:32 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGllK53fZzRpPc;
        Tue, 22 Nov 2022 21:41:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:41:30 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:41:29 +0800
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <djrscally@gmail.com>, <heikki.krogerus@linux.intel.com>,
        <sakari.ailus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
 <75602dce-0780-e51a-c8c9-d1820ddf3e2b@huawei.com>
 <Y3zLwj/G/E3kZsJE@smile.fi.intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <26c0d10a-5dd8-6cea-57b3-eea63099baa1@huawei.com>
Date:   Tue, 22 Nov 2022 21:41:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y3zLwj/G/E3kZsJE@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


On 2022/11/22 21:16, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 09:12:41PM +0800, Yang Yingliang wrote:
>> On 2022/11/22 20:54, Andy Shevchenko wrote:
>>> On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:
> ...
>
>>> It seems too complicated for the simple fix.
>>>
>>> As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
>>> branch. This will allow you to drop if (prev) at the end.
>> fwnode is const, fwnode_handle_get doesn't accept this type.
> I'm talking about parent.
You suggested this:

"Instead you might consider to replace

	parent = fwnode;

by

	parent = fwnode_handle_get(fwnode);"


It has compile warning:
drivers/base/property.c: In function ‘fwnode_graph_get_next_endpoint’:
drivers/base/property.c:1004:30: warning: passing argument 1 of ‘fwnode_handle_get’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
    parent = fwnode_handle_get(fwnode);
                               ^~~~~~
drivers/base/property.c:809:63: note: expected ‘struct fwnode_handle *’ but argument is of type ‘const struct fwnode_handle *’
  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)

~~~~~~~~~~~~~~~~~~~~~~^~~~~~

