Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC05E80B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiIWR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIWR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:28:49 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5A14F28B;
        Fri, 23 Sep 2022 10:28:48 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 050A41250;
        Fri, 23 Sep 2022 19:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663954126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHn7dUEakYs6EqU0H1lIKA8WzZRAHG8KE3zOYOsxZq8=;
        b=Ov+iQUNVotABs01Sc1gLX+z8jfuca90pkWpVb7jbIBKu8YCorG8EVj19b//AeaE0Dq5bEz
        /Kaz6B5fyMmwdDOL0Xsj+w2mpOEup4KmYkEbPBwgBg7H5UsBM6e6ihgwlUj7vF6ZcqWS3e
        MY2776cd5nKhhXQALckyeWMWS77QDonO6o1Ootf55Zll7rwfH2Ot+StdKHH/VbUnlR3VGa
        yS3KbCTIy7zP2BCweyeY1973HEe0XILvuyebFTG3DMEGkiF1VI6c75Qo97xQ5kp2HQwtRW
        1QXBRrBPWzmVjI0oGZVOErPfWbZ1HsAM0iTL6WpVVE2L9LoJzToH+xMJKKvzIg==
MIME-Version: 1.0
Date:   Fri, 23 Sep 2022 19:28:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
In-Reply-To: <20220923174759.299e504e@xps-13>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220923174759.299e504e@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0c0522a2c7e4b2401955acf5bcd4eb8e@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-09-23 17:47, schrieb Miquel Raynal:
> I have a few additional questions regarding the bindings.
> 
> michael@walle.cc wrote on Fri,  2 Sep 2022 00:18:37 +0200:
> 
>> This is now the third attempt to fetch the MAC addresses from the VPD
>> for the Kontron sl28 boards. Previous discussions can be found here:
>> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
>> 
>> 
>> NVMEM cells are typically added by board code or by the devicetree. 
>> But
>> as the cells get more complex, there is (valid) push back from the
>> devicetree maintainers to not put that handling in the devicetree.
>> 
>> Therefore, introduce NVMEM layouts. They operate on the NVMEM device 
>> and
>> can add cells during runtime. That way it is possible to add more 
>> complex
>> cells than it is possible right now with the offset/length/bits
>> description in the device tree. For example, you can have post 
>> processing
>> for individual cells (think of endian swapping, or ethernet offset
>> handling).
>> 
>> The imx-ocotp driver is the only user of the global post processing 
>> hook,
>> convert it to nvmem layouts and drop the global post pocessing hook. 
>> Please
>> note, that this change is only compile-time tested.
>> 
>> You can also have cells which have no static offset, like the
>> ones in an u-boot environment. The last patches will convert the 
>> current
>> u-boot environment driver to a NVMEM layout and lifting the 
>> restriction
>> that it only works with mtd devices. But as it will change the 
>> required
>> compatible strings, it is marked as RFC for now. It also needs to have
>> its device tree schema update which is left out here. These two 
>> patches
>> are not expected to be applied, but rather to show another example of
>> how to use the layouts.
>> 
>> For now, the layouts are selected by a specific compatible string in a
>> device tree. E.g. the VPD on the kontron sl28 do (within a SPI flash 
>> node):
>>   compatible = "kontron,sl28-vpd", "user-otp";
>> or if you'd use the u-boot environment (within an MTD patition):
>>   compatible = "u-boot,env", "nvmem";
>> 
>> The "user-otp" (or "nvmem") will lead to a NVMEM device, the
>> "kontron,sl28-vpd" (or "u-boot,env") will then apply the specific 
>> layout
>> on top of the NVMEM device.
> 
> So if I understand correctly, there should be:
> - one DT node defining the storage medium eeprom/mtd/whatever,
> - another DT node defining the nvmem device with two compatibles, the
>   "nvmem" (or "user-otp") and the layout.
> Is this correct? Actually I was a bit surprised because generally
> speaking, DT maintainers (rightfully) do not want to describe how we
> use devices, the nvmem abstraction looks like a Linux thing when on top
> of mtd devices for instance, so I just wanted to confirm this point.

What do you mean by two nodes? Two separate ones or one being a
subnode of the other?

There is only one (storage) node and nvmem cells as subnodes.
The two compatibles aren't strictly needed. But it will simplify
the drivers in linux greatly. Otherwise the storage driver would
need to know for which compatibles it needs to register a
nvmem device. E.g. MTD devices determine that by the "nvmem"
compatible. The OTP driver will probe by "{user,factory}-otp".
If you'd only have one compatible, the storage driver would need
a list of all the layouts so it can register a nvmem device.

But also from a device tree POV this makes sense IMHO because
the second compatible is a more specific one. With only
the more generic compatible you just get a nvmem device without
any cells - or only the cells described in the device tree.

Regarding "describe how the devices are used": then there shouldn't
be nvmem (cell) bindings at all, because you are actually describing
how you are using the nvmem provider. So IMHO having for example
the compatible "kontron,sl28-vpd" is actually fits more than having
a nvmem provider compatible with cells subnodes.

> Then, as we have an nvmem device described in the DT, why not just
> pointing at the nvmem device from the cell consumer, rather than still
> having the need to define all the cells that the nvmem device will
> produce in the DT?

See also
https://lore.kernel.org/linux-devicetree/4bf16e18-1591-8bc9-7c46-649391de3761@linaro.org/

> Maybe an example to show what I mean. Here is the current way:
> 
> nvmem_provider: nvmem-provider {
> 	properties;
> 
> 	mycell: my_cell {
> 		[properties;]
> 	};
> };
> 
> And we point to a cell with:
> 
> 	nvmem-cells = <&mycell>;
> 
> But, as for the tlv tables, there are many cells that will be produced,
> and the driver may anyway just ask for the cell name (eg. performing a
> lookup of the "mac-address" cell name), so why bothering to describe 
> all
> the cells in the DT, like:
> 
> 	nvmem-cells-providers = <&nvmem_provider>;
> 
> What do you think?

Ok, you even go one step further and even removing the argument
of the phandle and you are proposing to use the nvmem-cell-name,
right? That might work with simple cells created by a layout. But
what if there are two consumers with different names for the same
cell? Consumer bindings might already be present, e.g. the ethernet
bindings will use "mac-address". What if there is another binding
which want to use that cell but doesn't name it "mac-address"?
IMHO to reference a nvmem cell you shouldn't rely on the consumer.

Also keep in mind, that the number of arguments is fixed and given
by the "#.*-cells" property found on the target node. Therefore,
that won't work if you have cells where one has an argument and
another don't.

> Maybe for the mac addresses this is a bit limiting as, in practice, we
> often have base mac addresses available and using:
> 
> 	nvmem-cells = <&mycell INDEX>;
> 
> allows to dynamically create many different mac addresses, but I wonder
> if the approach would be interesting for other cell types. Just an open
> question.

So how would your idea work with that? Maybe we could support both?
But again, I'm not sure if it is a good idea to mix the consumer
with the provider.

-michael
