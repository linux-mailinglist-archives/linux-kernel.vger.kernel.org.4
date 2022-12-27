Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38B2656B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiL0MiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiL0Mhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:37:46 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226C2A3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:37:45 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 74D8A15D5;
        Tue, 27 Dec 2022 13:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672144663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAAvJN77bvgX7oGEekHJcV4mBzu/DWg2fOxNjin+9Hc=;
        b=CSdxd9zIl65XUlXt2RIzmcidEvaoXvNPRocz5E8L4+rLCOEXYxE1mO4PqLEKpfydZ5uXlu
        ehVFfLL7hyuDxxKKpOsA/n7uv8JHG/Qa5qZcfNPMItpNKfgUuD0KzGrwPUI7ceO7b+Nuz1
        h6f3cMNZ0UcojcdDJfQTtS6LdiwUSbkS5Dq+rCLMdNTM04XbulwHLLIYOsgSGb6YFekJGI
        5axoPSly5aZe83WMuOlrPgNK3iZVDzhIQ4XUzY7vX2Yewmit7tQaFnRLSnqDRmFkxyHQ+I
        JvxuFN6mQGJCjuRboX+EQRlEH5Z+7q2Q8plMGrnK2feSX+SsMfvrwJCYv568Lw==
MIME-Version: 1.0
Date:   Tue, 27 Dec 2022 13:37:43 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] mtd: spi-nor: Add support for IS25LX256 operating
 in 1S-8S-8S octal read mode
In-Reply-To: <eafebda5-7342-dfa9-7745-543d5f7d6f3d@linaro.org>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-4-nathan.morrison@timesys.com>
 <9927a8c3-40cf-2c69-46c6-f660ff2422b1@linaro.org>
 <eafebda5-7342-dfa9-7745-543d5f7d6f3d@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <14b5fc24d0e9391807768c595a4277ee@walle.cc>
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

Am 2022-12-26 09:17, schrieb Tudor Ambarus:
> On 26.12.2022 10:04, Tudor Ambarus wrote:
>> Hi, Nathan,
>> 
>> The series is starting to look good, but I'll need another version,
>> please.
>> 
>> On 02.12.2022 15:55, Nathan Barrett-Morrison wrote:
>>> This adds the IS25LX256 chip into the ISSI flash_info parts table
>> 
>> Describe your changes in imperative mood, e.g. "Add support for
>> S25LX256" instead of "This adds ..."
>> 
>> It may worth to re-read
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>> once in a while.
>> 
>>> 
>>> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>>> ---
>>>   drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>> 
>>> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
>>> index 89a66a19d754..362bc3603d8f 100644
>>> --- a/drivers/mtd/spi-nor/issi.c
>>> +++ b/drivers/mtd/spi-nor/issi.c
>>> @@ -29,6 +29,35 @@ static const struct spi_nor_fixups 
>>> is25lp256_fixups = {
>>>       .post_bfpt = is25lp256_post_bfpt_fixups,
>>>   };
>>> +static int
>>> +is25lx256_post_bfpt_fixups(struct spi_nor *nor,
>>> +               const struct sfdp_parameter_header *bfpt_header,
>>> +               const struct sfdp_bfpt *bfpt)
>>> +{
>>> +    /*
>>> +     * IS25LX256 supports both 1S-1S-8S and 1S-8S-8S.
>>> +     * However, the BFPT does not contain any information denoting 
>>> this
>>> +     * functionality, so the proper fast read opcodes are never 
>>> setup.
>>> +     * We're correcting this issue via the fixup below.  Page 
>>> program
>>> +     * commands are detected and setup properly via the 4BAIT 
>>> lookup.
>>> +     */
> 
> Why don't you set the READ support when parsing the 4bait table?

That would deviate from the read handling of all the other modes.

> We need to see the SFDP dump to determine how we treat this. I'm not
> sure a post_bfpt hook is the right thing to do for this flash.

See:
https://lore.kernel.org/linux-mtd/e07105d41ec62a6ee47ca0295ca347dc@walle.cc/

But yes, I missed that you should include the sfdp dump and some other
commands in the comment section of the patch which adds support for that
flash (see Tudors reply).

Tudor, what is the status of your documentation patch? I'd really like
to refer to the kernel docs instead of having write the same over and
over again ;)

-michael
