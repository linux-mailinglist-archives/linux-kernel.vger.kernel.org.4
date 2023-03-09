Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956B6B2384
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCIL7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCIL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:58:57 -0500
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 03:58:55 PST
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDDC7F011
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:58:55 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.20.216])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id F347E2742D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:52:39 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-ml9bn (unknown [10.108.1.233])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 23E731FE55;
        Thu,  9 Mar 2023 11:52:38 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net ([151.80.29.18])
        by ghost-submission-6684bf9d7b-ml9bn with ESMTPSA
        id Tff4BobICWQMaB4AKXspMQ
        (envelope-from <rafal@milecki.pl>); Thu, 09 Mar 2023 11:52:38 +0000
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 12:52:37 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi?= =?UTF-8?Q?=C5=82ecki?= 
        <zajec5@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t
 callbacks to adjust buffer
In-Reply-To: <fb6d7c76-d3d3-b8a0-46f9-dc2eb76ae91a@linaro.org>
References: <20230222172245.6313-1-zajec5@gmail.com>
 <20230222172245.6313-3-zajec5@gmail.com>
 <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
 <20230309113211.6321ce3d@xps-13>
 <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
 <20230309122324.4b012a58@xps-13>
 <fb6d7c76-d3d3-b8a0-46f9-dc2eb76ae91a@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fde09080fc420cca64e810a3c2ad9677@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14449517931571489705
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduiedgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejvdelgfeutdfhfeelheegfedtleduleeuvdfgfeefvefhvedtheetjeetfeehgeenucfkphepuddvjedrtddrtddruddpudelgedrudekjedrjeegrddvfeefpdduhedurdektddrvdelrddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-09 12:44, Srinivas Kandagatla wrote:
> On 09/03/2023 11:23, Miquel Raynal wrote:
>> Hi Srinivas,
>> 
>> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:53:07 
>> +0000:
>> 
>>> On 09/03/2023 10:32, Miquel Raynal wrote:
>>>> Hi Srinivas,
>>>> 
>>>> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:12:24 
>>>> +0000:
>>>> 
>>>>> On 22/02/2023 17:22, Rafał Miłecki wrote:
>>>>>> @@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct 
>>>>>> nvmem_device *nvmem,
>>>>>>     	if (!nvmem)
>>>>>>     		return -EINVAL;
>>>>>>     > +	/* Cells with read_post_process hook may realloc buffer we 
>>>>>> can't allow here */
>>>>>> +	if (info->read_post_process)
>>>>>> +		return -EINVAL;
>>>>> This should probably go in 1/4 patch. Other than that series looks 
>>>>> good to me.
>>>> 
>>>> FYI patch 1/4 is also carried by the nvmem-layouts series, so it's
>>>> probably best to keep these 2 patches separated to simplify the 
>>>> merging.
>>> that is intermediate thing, but Ideally this change belongs to 1/4 
>>> patch, so once I apply these patches then we can always rebase layout 
>>> series on top of nvmem-next
>> 
>> Well, I still don't see the need for this patch because we have no use
>> for it *after* the introduction of layouts. Yes in some cases changing
>> the size of a cell might maybe be needed, but right now the use case 
>> is
>> to provide a MAC address, we know beforehand the size of the cell, so
>> there is no need, currently, for this hack.
>> 
> Am confused, should I ignore this series ?

I'm confused no less.

I think we have 3 different opinions and no agreement on how to proceed.


Rafał (me):
NVMEM cells should be registered as they are in the raw format. No size
adjustments should happen while registering them. If NVMEM cell requires
some read post-processing then its size should be adjusted *while*
reading.


Michael:
.read_post_process() should be realloc the buffer


Miquel:
While registering NVMEM cell its size should be already adjusted to
match what .read_post_process() is about to return.


I'm really sorry if I got anyone's view wrong.
