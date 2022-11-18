Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AC62FFA7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiKRWDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiKRWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:03:04 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9791C17;
        Fri, 18 Nov 2022 14:03:03 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 907731CF7;
        Fri, 18 Nov 2022 23:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668808981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4PQjmkDf85oiVj5jD2DRQqNjG18C4b4h2V2WeJ5MY4=;
        b=ODR2yWN5w5w5jwnkgMSsMGDtcc1jiRvlZU7nscNfu4vmyW372rvY2OjguxtPMwN+0AXwD9
        IgpZAq2d4HPPlrQj1crKVUFuDmdfvX49RLVOq0vIIXYTUBzraRb9xNf9+CZnOyHjbdc2QP
        FGk6AApmCy+2FKdn2dllv5KjMTuLTCXAIPtVBNVghhHhhBHOD0OputSfPEpZwySj6FkvSk
        JiwInVG9v6c9VMYE6edLifGKp8hhu3utaUVWqzeb/nYwjcOgv631461buoztEJ2cXzyeEh
        mYRrdKGzCYNUR/GoBN0NMvjtT9Jk8gV41sdicIOkLJGrsLcP5HxVLoo6vyhdGw==
MIME-Version: 1.0
Date:   Fri, 18 Nov 2022 23:03:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] of: property: special #nvmem-cell-cells handling
In-Reply-To: <CAL_JsqKnuycUSHfxxcZMcidELA-ttZUv5NhV5ApkpUQMsc-aQQ@mail.gmail.com>
References: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc>
 <20221118214036.1269005-1-michael@walle.cc>
 <CAL_JsqKnuycUSHfxxcZMcidELA-ttZUv5NhV5ApkpUQMsc-aQQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fc101fbe1d8c94587a22d24a96e4dfb7@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-18 22:52, schrieb Rob Herring:
> On Fri, Nov 18, 2022 at 3:40 PM Michael Walle <michael@walle.cc> wrote:
>> 
>> Since recently, there is a new #nvmem-cell-cells. To be backwards
>> compatible this is optional. Therefore, we need special handling and
>> cannot use DEFINE_SIMPLE_PROP() anymore.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> This patch will be part of the following series:
>> https://lore.kernel.org/linux-arm-kernel/20221118185118.1190044-1-michael@walle.cc/
>> 
>>  drivers/of/property.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 967f79b59016..93c0ea662336 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -1305,7 +1305,6 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", 
>> "#power-domain-cells")
>>  DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
>>  DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
>> -DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
>>  DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
>>  DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
>>  DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
>> @@ -1381,6 +1380,22 @@ static struct device_node 
>> *parse_interrupts(struct device_node *np,
>>         return of_irq_parse_one(np, index, &sup_args) ? NULL : 
>> sup_args.np;
>>  }
>> 
>> +static struct device_node *parse_nvmem_cells(struct device_node *np,
>> +                                            const char *prop_name, 
>> int index)
>> +{
>> +       struct of_phandle_args sup_args;
>> +
>> +       if (strcmp(prop_name, "nvmem-cells"))
>> +               return NULL;
>> +
>> +       if (of_parse_phandle_with_optional_args(np, prop_name,
>> +                                               "#nvmem-cell-cells", 
>> index,
>> +                                               &sup_args))
>> +               return NULL;
>> +
>> +       return sup_args.np;
>> +}
> 
> There's a couple of other cases like that (MSI IIRC), so can we
> generalize this to work in more than 1 case?

You mean addding a new DEFINE_SIMPLE_PROP_OPTIONAL_ARGS()?

-michael
