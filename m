Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD65B342C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiIIJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIIJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:39:58 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361A48C92;
        Fri,  9 Sep 2022 02:39:55 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id BD96250F;
        Fri,  9 Sep 2022 11:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662716393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqFN//VBocQgx8w36Vgv1hz8sEP4vR/KyV4y2WX9JXI=;
        b=EgOGzGExA/SfqzDbSRML5C4thBISliNXbbDwwFf0EXuGTp4Glgq2aV+xrsmZ+Nv15BXzAX
        creOFiX4ThmrFiBfehobUSN75plXpV7TV8gN7SCcm4pkHlmIHI37YNTFN9SxGAS3moL42e
        ytba57y776C5zhreU+0fnA0jscnY5tSYEsrK7xEWQ8MMG4soO8XUDkr7cV0bmTkl+JLC2y
        mQeRISmWTB+PQxHZJPt0b1GpcP2xnmv7RnrM3Kj/kV4cDsLc/ZutGcV5A25XmYx1i27+Gl
        fLGNExbUki7cqdlPKypd4LXZf3Lvxu6GhN4TE9F+GDax3ROTyNIpV36kcuooSw==
MIME-Version: 1.0
Date:   Fri, 09 Sep 2022 11:39:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 13/20] nvmem: core: drop priv pointer in post process
 callback
In-Reply-To: <ccb50ec6-a0e9-e700-bd1e-220909fcc788@linaro.org>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-14-michael@walle.cc>
 <373b10aa-f5c8-28b3-88b0-f87a1a40b000@linaro.org>
 <42bc3f6796cc75baafc15c6d2c71ec92@walle.cc>
 <ccb50ec6-a0e9-e700-bd1e-220909fcc788@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d349e020cc68af7197bbb679bfa69eb2@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-09 11:08, schrieb Srinivas Kandagatla:
> On 09/09/2022 09:58, Michael Walle wrote:
>> Am 2022-09-09 10:52, schrieb Srinivas Kandagatla:
>>> On 01/09/2022 23:18, Michael Walle wrote:
>>>> It doesn't make any more sense to have a opaque pointer set up by 
>>>> the
>>>> nvmem device. Usually, the layout isn't associated with a particular
>>>> nvmem device.
>>>> 
>>> This is really not a good idea to remove the context pointer, as this
>>> is the only way for callback to get context which it can make use of.
>> 
>> In which case? As I mentioned it's the priv to the nvmem driver and 
>> all
>> the "normal" callbacks can do very little with it. If there will be a
>> future need, then there should be a proper opaque pointer associated
>> with the layout and not the nvmem driver.
> 
> Yes, the opaque object here is the layout priv which I agree with, but
> removing the context totally from the callback is not a good idea.
> 
> We should have some context to callbacks to be able to allow them to
> deal with some private info.

I agree, but my thinking was this: as the old priv pointer doesn't
make any sense and no one is using it at the moment for now, we can
remove it it. If it's needed again it can easily added together with
a user.

That being said, I could leave the pointer argument and just pass NULL,
so if someone (re)adds that, we don't have to modify all the callbacks.
Because we don't have any user for now, I could only speculate who 
should
or could set that pointer.

-michael
