Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CC600C21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJQKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJQKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:15:58 -0400
X-Greylist: delayed 2181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 03:15:55 PDT
Received: from 2.mo552.mail-out.ovh.net (2.mo552.mail-out.ovh.net [178.33.105.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C3DFE9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:15:55 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.48])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 8A3012723A;
        Mon, 17 Oct 2022 09:39:31 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Mon, 17 Oct
 2022 11:39:30 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-95G001e4a9f766-4f6d-4d46-83cb-9024a96d311a,
                    03067325AA2E056BEC2EB751A0783F460AB0E9BE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5141de99-33cc-7266-d56a-9f8112d1e588@kaod.org>
Date:   Mon, 17 Oct 2022 11:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] spi: aspeed: Fix window offset of CE1
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
CC:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
References: <20221016155722.3520802-1-clg@kaod.org>
 <CACPK8XfrF2h0zYNPcFwHmGfyohCOYQziqoUAJ6j60bEonFHu0A@mail.gmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8XfrF2h0zYNPcFwHmGfyohCOYQziqoUAJ6j60bEonFHu0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: ab2a3e5c-c840-4939-a121-c42b9414ee40
X-Ovh-Tracer-Id: 2509067946161834799
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekteejtdelkeejvdevffduhfetteelieefgeefffeugffhfeekheffueefledujeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdhorhhgpdhophgvnhgsmhgtsehlihhsthhsrdhoiihlrggsshdrohhrghdprghnughrvgifsegrjhdrihgurdgruhdplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvh
 hgvghrrdhkvghrnhgvlhdrohhrghdptghhihhnqdhtihhnghgpkhhuohesrghsphgvvgguthgvtghhrdgtohhmpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 00:43, Joel Stanley wrote:
> On Sun, 16 Oct 2022 at 15:57, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> The offset value of the mapping window in the kernel structure is
>> calculated using the value of the previous window offset. This doesn't
>> reflect how the HW is configured and can lead to erroneous setting of
>> the second flash device (CE1).
> 
> So .offset is expected to be the absolute address of the window, and
> this was okay for the 2400/2500 but was broken on the 2600?

the aspeed_spi_get_windows() routine collects in an array the window/decoding
range setting for each CS, and the offset for CS1 and above is computed from
the offset/size of the previous CS. But this makes an assumption on the fact
ranges are contiguous, which is not necessarily how the HW is configured.

C.

> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> 
>>
>> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/spi/spi-aspeed-smc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
>> index 33cefcf18392..b90571396a60 100644
>> --- a/drivers/spi/spi-aspeed-smc.c
>> +++ b/drivers/spi/spi-aspeed-smc.c
>> @@ -398,7 +398,7 @@ static void aspeed_spi_get_windows(struct aspeed_spi *aspi,
>>                  windows[cs].cs = cs;
>>                  windows[cs].size = data->segment_end(aspi, reg_val) -
>>                          data->segment_start(aspi, reg_val);
>> -               windows[cs].offset = cs ? windows[cs - 1].offset + windows[cs - 1].size : 0;
>> +               windows[cs].offset = data->segment_start(aspi, reg_val) - aspi->ahb_base_phy;
>>                  dev_vdbg(aspi->dev, "CE%d offset=0x%.8x size=0x%x\n", cs,
>>                           windows[cs].offset, windows[cs].size);
>>          }
>> --
>> 2.37.3
>>

