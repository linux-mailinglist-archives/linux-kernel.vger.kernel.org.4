Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FAD6B25A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCINlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCINlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:41:21 -0500
Received: from 18.mo561.mail-out.ovh.net (18.mo561.mail-out.ovh.net [87.98.172.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17DEBFA4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:41:12 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.156.133])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 9421122B71
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:31:23 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-74llp (unknown [10.110.208.116])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8CDCA1FE67;
        Thu,  9 Mar 2023 13:31:21 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net ([151.80.29.18])
        by ghost-submission-6684bf9d7b-74llp with ESMTPSA
        id 3hbMIKnfCWTjaAUA/ww3gA
        (envelope-from <rafal@milecki.pl>); Thu, 09 Mar 2023 13:31:21 +0000
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 14:31:19 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Rafa?= =?UTF-8?Q?=C5=82_Mi=C5=82ecki?= 
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
In-Reply-To: <20230309141038.4399af1f@xps-13>
References: <20230222172245.6313-1-zajec5@gmail.com>
 <20230222172245.6313-3-zajec5@gmail.com>
 <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
 <20230309113211.6321ce3d@xps-13>
 <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
 <20230309122324.4b012a58@xps-13>
 <fb6d7c76-d3d3-b8a0-46f9-dc2eb76ae91a@linaro.org>
 <fde09080fc420cca64e810a3c2ad9677@milecki.pl>
 <20230309141038.4399af1f@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <649e1c9196cf78232816dcf29ece4c52@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16116975693792521129
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduiedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejvdelgfeutdfhfeelheegfedtleduleeuvdfgfeefvefhvedtheetjeetfeehgeenucfkphepuddvjedrtddrtddruddpudelgedrudekjedrjeegrddvfeefpdduhedurdektddrvdelrddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-09 14:10, Miquel Raynal wrote:
> Hello,
> 
> rafal@milecki.pl wrote on Thu, 09 Mar 2023 12:52:37 +0100:
> 
>> On 2023-03-09 12:44, Srinivas Kandagatla wrote:
>> > On 09/03/2023 11:23, Miquel Raynal wrote:
>> >> Hi Srinivas,
>> >> >> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:53:07 >> +0000:
>> >> >>> On 09/03/2023 10:32, Miquel Raynal wrote:
>> >>>> Hi Srinivas,
>> >>>> >>>> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:12:24 >>>> +0000:
>> >>>> >>>>> On 22/02/2023 17:22, Rafał Miłecki wrote:
>> >>>>>> @@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct >>>>>> nvmem_device *nvmem,
>> >>>>>>     	if (!nvmem)
>> >>>>>>     		return -EINVAL;
>> >>>>>>     > +	/* Cells with read_post_process hook may realloc buffer we >>>>>> can't allow here */
>> >>>>>> +	if (info->read_post_process)
>> >>>>>> +		return -EINVAL;
>> >>>>> This should probably go in 1/4 patch. Other than that series looks >>>>> good to me.
>> >>>> >>>> FYI patch 1/4 is also carried by the nvmem-layouts series, so it's
>> >>>> probably best to keep these 2 patches separated to simplify the >>>> merging.
>> >>> that is intermediate thing, but Ideally this change belongs to 1/4 >>> patch, so once I apply these patches then we can always rebase layout >>> series on top of nvmem-next
>> >> >> Well, I still don't see the need for this patch because we have no use
>> >> for it *after* the introduction of layouts. Yes in some cases changing
>> >> the size of a cell might maybe be needed, but right now the use case >> is
>> >> to provide a MAC address, we know beforehand the size of the cell, so
>> >> there is no need, currently, for this hack.
>> >> > Am confused, should I ignore this series ?
> 
> I think this series makes sense and addresses a need. But this issue
> can also be solved with the layouts. Rafał does not want (I still
> don't get the reason) to use that solution. Whatever. But if you apply
> this series, it requires to modify the layouts series, thus postponing
> it even more. I would prefer to merge that big series first and then
> merge an update of this patch (which changes in the two layout drivers
> the cell size argument type).

I'm going to argue those are two independent things.

I can add .read_post_process() without making this driver a layout.
I can make it layout without adding .read_post_process().

I said multiple time that I AM GOING to convert this driver into a 
layout.


>> I'm confused no less.
>> 
>> I think we have 3 different opinions and no agreement on how to 
>> proceed.
>> 
>> 
>> Rafał (me):
>> NVMEM cells should be registered as they are in the raw format. No 
>> size
>> adjustments should happen while registering them. If NVMEM cell 
>> requires
>> some read post-processing then its size should be adjusted *while*
>> reading.
> 
> This implementation only works if you reduce the size of the cell.

Which is enough for MAC. And I was asked to use simple solution.
I also was asked to support reallocationg which was the reason for
my rework.


> While writing this, I am realizing that we would actually expect
> a check on the nvmem side if the size was enlarged because this would
> be a bug.
> 
>> Michael:
>> .read_post_process() should be realloc the buffer
> 
> This would be more robust. But if we start with 1, we can improve it
> later, I don't mind as long as an error is returned in case of misuse.
> 
>> Miquel:
>> While registering NVMEM cell its size should be already adjusted to
>> match what .read_post_process() is about to return.
> 
> Sounds like the simplest solution to me and covers all the uses we
> have to day, but honestly, I won't fight for it.
> 
>> I'm really sorry if I got anyone's view wrong.
> 
> LGTM.
> 
>> > Whatever. If you want it, just merge it. But *please*, I would like
>> 
>> :-)
>> 
>> > to see these layouts in, so what's the plan?
>> 
>> Am on it, you sent v3 just 24hrs ago :-)
> 
> Yes, sorry for being pushy. I just wanted to highlight that the two
> series conflict together, but my answer was clumsy. Take the time you
> need, that's how it's supposed to work anyway.

AFAIR there is a minor conflict caused by the API change that allows
reallocations. I decided to rebase my patchwork because Michael claimed
it's going to take at least few more weeks to rework layouts patchset.

Now we have layouts patchset ready anyway and I'll have to rebase
again. Well, few more wasted hours, shouldn't make much difference.
