Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6465C6AC3C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCFOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCFOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:48:29 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20592387B;
        Mon,  6 Mar 2023 06:48:13 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 247E961;
        Mon,  6 Mar 2023 15:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678111890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wHdcLWIKf+KIrEfkjBenMVupSGvg6ESfhHT+MBQatc=;
        b=Tay57Rvob7ExqKGoQT/6hkNH2tHp9VfP70/iFxYw35ZBQesXKhZe34amb1XY3QE0vXfGax
        k5LKWDru1iVRlQ8WBgzBEajeB27EhUEVLEUwRpsymwFmoI50Tg2Pfd2UBHJtWjOSr8zDq8
        AIEpkOAQrvi73f8mHbNCgXUWZ5pNZ5EDltl3f+EirrbTnC58zq7pEZFnK5vCmqWEjkLXBj
        qXMUYN/2nK5b0qWDH+Xg2UMx8sRWUW2hX9XYloEuOvUPONLrJhyfCIRdfkT026plTukC9p
        bee2+zESiXM+b53E+Xdeg/BsfyUxsLdnd2zjyWDeSVyBQD9u0Es8MMdjjNKvqA==
MIME-Version: 1.0
Date:   Mon, 06 Mar 2023 15:11:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
In-Reply-To: <75856a2c7099bad906e6b0c5475a3b7e@milecki.pl>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
 <ee7923a8b5fa8358e6805d20df7d8049@walle.cc> <20230306143528.7407fda5@xps-13>
 <73a04afaf658292c05ef27117c60b21d@milecki.pl>
 <d46241e139b7a1e96705402a42f9bf31@walle.cc>
 <75856a2c7099bad906e6b0c5475a3b7e@milecki.pl>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bdb9e524ac03656683a1f2678d05d88c@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-06 15:06, schrieb Rafał Miłecki:
> On 2023-03-06 15:03, Michael Walle wrote:
>> Am 2023-03-06 14:57, schrieb Rafał Miłecki:
>>> On 2023-03-06 14:35, Miquel Raynal wrote:
>>>> Hi Michael,
>>>> 
>>>> michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
>>>> 
>>>>> > Miquel Raynal (8):
>>>>> >   of: Fix modalias string generation
>>>>> >   of: Change of_device_get_modalias() main argument
>>>>> >   of: Create an of_device_request_module() receiving an OF node
>>>>> >   nvmem: core: Fix error path ordering
>>>>> >   nvmem: core: Handle the absence of expected layouts
>>>>> >   nvmem: core: Request layout modules loading
>>>>> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
>>>>> >   nvmem: layouts: onie-tlv: Convert layout driver into a module
>>>>> 
>>>>> With the fixes series [1] applied:
>>>> 
>>>> Thanks for the series! Looks good to me. I believe both series can 
>>>> live
>>>> in separate tress, any reason why we would like to avoid this? I am 
>>>> keen
>>>> to apply [1] into the mtd tree rather soon.
>>> 
>>> Given past events with nvmem patches I'm against that.
>>> 
>>> Let's wait for Srinivas to collect pending patches, let them spend a
>>> moment in linux-next maybe, ask Srinivas to send them to Greg early 
>>> if
>>> he can. That way maybe you can merge Greg's branch (assuming he 
>>> doesn't
>>> rebase).
>> 
>> Mh? None of these fixes have anything to do with nvmem (except maybe 
>> patch
>> 4/4). The bugs were just discovered while I was testing this series. 
>> But
>> OTOH they are kind of a prerequisite for this series. So what are you
>> suggesting here?
> 
> I'm sorry, I didn't realize you are commenting on linked mtd series.
> I thought you want to take nvmem patches series over mtd tree ;) My
> bad.

So was Miquel I think ;). But maybe it will make sense to provide a 
stable
tag/branch to srinivas so if someone is using the nvmem-next branch it 
will
work. Although I doubt there are many users of the spi-nor otp stuff.

-michael
