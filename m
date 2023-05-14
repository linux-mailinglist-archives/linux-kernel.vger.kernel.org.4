Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76B702098
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjENWxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjENWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFF61BB;
        Sun, 14 May 2023 15:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39C261267;
        Sun, 14 May 2023 22:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930BBC433D2;
        Sun, 14 May 2023 22:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684104802;
        bh=hhVyC/OAoNTAaTDUMLdOJPMwd8d8UWMVRdN3Lw1WEsw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pbm/Xmn7WNwWfLiZpv3qGVDQG9SFqLDVYorUZ/kWU0MzbOQjwwOdvuDSG7TUGcHZ1
         In9wg3WZ1wlrOJBQ18Ngg2hzQ+tGzlQ/oZZO9TaONmKP0WJK73RKTQDgykr7keO6OB
         6xtignbQz6DMk1OxB8+1UWzYXW1g2gIXJvU/5sLkJVqxXdIloKjxEChUzscpInTOge
         IUkleJVRLCrQ1LVGd5/JFFmbuA5KaTpFvmmjqxAOqy6WYAmcDs1bJS4oBspHTp6g2t
         N1K8p/4xTfqBT9d9iEEvdyF8QuoOWM/K0tZTCqC/IrMgFCaWesm3D4kvDtV3MRwzvA
         fQvmbYx04Ys/w==
Message-ID: <b26499be-e8e1-5812-a134-dbeb58118124@kernel.org>
Date:   Mon, 15 May 2023 07:53:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-core: Simplies if condition
Content-Language: en-US
To:     Yahu Gao <yahu.gao@outlook.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yahu Gao <gaoyh12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
References: <20230422121415.6276-1-yahu.gao@outlook.com>
 <OS3P286MB0632739A614E451725FF697D9E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
 <OS0P286MB06283D2E74F02D7C541E46D79E6B9@OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <OS0P286MB06283D2E74F02D7C541E46D79E6B9@OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 10:53, Yahu Gao wrote:
> ping ...
> 
> 在 2023/4/22 20:14, Yahu Gao 写道:
>> From: Yahu Gao <gaoyh12@lenovo.com>
>>
>> Replace conditions of avoid issuing [P]IDENTIFY to PMP.

Please be a little more descriptive. Something like:

Simplify the condition used in ata_dev_revalidate() to not issue identify
commands to port multiplier devices.

would be better.

>>
>> Reviewed-by: Jiwei Sun <sunjw10@lenovo.com>

Where does this review come from ? I have never seen an email for it. I cannot
accept this tag without seeing the email for it.

>> Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 14c17c3bda4e..53f65d751189 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>>   		return -ENODEV;
>>   
>>   	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
>> -	if (ata_class_enabled(new_class) &&

Please keep the above "ata_class_enabled(new_class) &&" condition:

	if (ata_class_enabled(new_class) && new_class == ATA_DEV_PMP) {

While keeping this condition is logically not necessary, having it makes the
code easier to understand.

>> -	    new_class != ATA_DEV_ATA &&
>> -	    new_class != ATA_DEV_ATAPI &&
>> -	    new_class != ATA_DEV_ZAC &&
>> -	    new_class != ATA_DEV_SEMB) {
>> +	if (new_class == ATA_DEV_PMP) {
>>   		ata_dev_info(dev, "class mismatch %u != %u\n",
>>   			     dev->class, new_class);
>>   		rc = -ENODEV;

