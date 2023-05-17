Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC3706710
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjEQLpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjEQLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:45:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7A421D;
        Wed, 17 May 2023 04:45:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pzEq4-0005Ph-I3; Wed, 17 May 2023 12:57:00 +0200
Message-ID: <53213ba8-be58-0f97-8a06-3c9380bdff53@leemhuis.info>
Date:   Wed, 17 May 2023 12:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
Content-Language: en-US, de-DE
To:     Francesco Dolcini <francesco@dolcini.it>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Alistair <alistair@alistair23.me>,
        Badhri Jagan Sridharan <badhri@google.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230407030741.3163220-1-badhri@google.com>
 <0cf8c588b701d7cf25ffe1a9217b81716e6a5c51.camel@alistair23.me>
 <1ac16f0a-3cca-40ca-c444-82719f85a24c@leemhuis.info>
 <ZGStr1oZvmJ0XzSu@francesco-nb.int.toradex.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZGStr1oZvmJ0XzSu@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684323915;0d7e538a;
X-HE-SMSGID: 1pzEq4-0005Ph-I3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 12:35, Francesco Dolcini wrote:
> On Wed, May 17, 2023 at 12:23:39PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing Francesco Dolcini; and the regression list too, as it should be
>> in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> On 16.05.23 14:53, Alistair wrote:
>>> On Fri, 2023-04-07 at 03:07 +0000, Badhri Jagan Sridharan wrote:
>>>> usb_udc_connect_control does not check to see if the udc has already
>>>> been started. This causes gadget->ops->pullup to be called through
>>>> usb_gadget_connect when invoked from usb_udc_vbus_handler even before
>>>> usb_gadget_udc_start is called. Guard this by checking for udc-
>>>>> started
>>>> in usb_udc_connect_control before invoking usb_gadget_connect.
>>> [...]
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
>>>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>>>
>>> This patch causes a kernel hang when trying to boot with the
>>> usb/chipidea/udc.c driver.
>>>
>>> The call stack below causes the hang:
>>>
>>>  - gadget_bind_driver(struct device *dev)
>>>     - mutex_lock(&udc->connect_lock);
>>>     - usb_gadget_udc_start_locked(struct usb_udc *udc)
>>>         - udc->gadget->ops->udc_start(udc->gadget, udc->driver)
>>>
>>> At which point we are calling ci_udc_start(..), but with the
>>> connect_lock mutex locked.
>>>
>>> ci_udc_start() then calls usb_udc_vbus_handler() which tries to lock
>>> the connect_lock while it's already locked. Resulting in a kernel hang.
>>>
>>> Reverting this patch fixes the hang.
>>
>> Not my area of expertise, but I guess it might be the same error as this
>> one:
>>
>> https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
>>
>> Francesco sent a revert on Friday, but no reaction from Badhri Jagan
>> Sridharan or Greg yet afaics.
>>
>> https://lore.kernel.org/all/20230512131435.205464-1-francesco@dolcini.it/
> 
> Revert patches were applied and are in linux-next. I expect those to
> land in Linus tree with the next pull request from Greg.

Ha, sorry, I missed that, as I only looked at lore. Should have looked
in my own regression tracking, there it's marked as "fix incoming", as
regzbot noticed the fix in next...

Ciao, Thorsten
