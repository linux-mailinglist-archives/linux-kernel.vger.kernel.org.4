Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5F16FDBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjEJKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjEJKaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:30:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2047.outbound.protection.outlook.com [40.92.53.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB466189;
        Wed, 10 May 2023 03:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEwFmhO7V+TXN5qif4i/neN1c/F2QOeFhAEsPAzu1sEK7rI1rE8xCh4JgGme9iUDP+klthKsbgrVoeXHk8e7zMmKzQQnFxgOYB96WsoQlQ6pBGWVlrjwU+HTvXzcIhXtIpPWmdY0/KXXRZ9oRQXY+6QNWYgLXWhQ0OhNMNs4Mja0GlPisjFGqtexXRyKapL84RKigoCXM2+u+gshtDi4EMenwAcDYS1oxN4kFNA/tNSRSA3R5lvhN1Z1J3moKToxRi9I3vnYMQwgua8BRBl+2wdT1bbOyKsCcGxfSF94jSWbxLrwbj/b6FhAKuhCH6oD/fcoNYJ8RfQv7qxclYrsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctE4AHIL0YV1wmkQ7NvhpYW8jaGNIiRvlAe38R1LTv0=;
 b=fIFtyGTq0krvcqBxjLEe/Vfwyy92CxeQW0tpQxdoDY8T43UpLCnZugpqsU6OG8oTwjn32U2PmGVLXzVculFw7xTkx1AqN9wkFZR2h4u0BnkD652NPekg06R0PDmkxH/tOQxvpuaYBFMq0LSt561WgrzZAz9X9DI8igktqpxt3RY+kropIEmisBu00r8BoV3Exl/TL8UilcvSVPicEOhvdD2aOcP3x0QiW7iDvRWkK60uQRNjFS6+XrTUmqV8Tr1d+QKruwutt4/YGBRVgTV+08YxLWVa7y4f+zN0zy6xJfYdnPrfQlj0xNaS+oFz66FHaxHXtQDoAe2o0qmxbLek2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctE4AHIL0YV1wmkQ7NvhpYW8jaGNIiRvlAe38R1LTv0=;
 b=NoT0Pso5ks1Pgi4J8kZ2AndysgxANXxJEugvoMPze/fsb4VQ6HOUMhJPgjBhGWeVdCBAUcIf6J6WQH62SWtse59xr79T6MtZj7aN8G4eW7xyRDmD9q0L6omjT5TaOd1xi93oi87Qxpx/nduqivnb+Z3UYde0+1iL1l9w5wNJ/J8VmNz7EoC3HlAOqtU1tBVmGqVHaZdFAyQ3wQDElzergQ2MSAQ7ZKmaRbRX0TxTA2oMQXzFbWlXLjze3WjnttRPkXX31V3vzv8/+oCKxLf0P/REYTlewWDO3FAI+HRs90whcZVYx8bELtsA16LRyoOdvCzntro4XevwdP6MrGMqqg==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by TYZPR01MB5302.apcprd01.prod.exchangelabs.com
 (2603:1096:400:336::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 10:30:11 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::93cb:1631:4c4c:1821]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::93cb:1631:4c4c:1821%4]) with mapi id 15.20.6387.018; Wed, 10 May 2023
 10:30:10 +0000
Message-ID: <KL1PR01MB54483E67F238214C1E087246E6779@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
Date:   Wed, 10 May 2023 18:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] net: mdiobus: Add a function to deassert reset
To:     Simon Horman <simon.horman@corigine.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
References: <KL1PR01MB5448A33A549CDAD7D68945B9E6779@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZFtwU1svXhZ/xrnJ@corigine.com>
From:   Yan Wang <rk.code@outlook.com>
In-Reply-To: <ZFtwU1svXhZ/xrnJ@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [W/OaQvPjEjb+WHmzLkYNhUDkLPuhAJCp3CvUkD5qzUk=]
X-ClientProxiedBy: TYCP286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::11) To KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <e9b9c247-2b35-1cbf-bd9c-0286d19ad801@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|TYZPR01MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a823530-546b-4aa8-e828-08db51418800
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToFDNPda+xJeo4T5nWaNNIqaqf16CdChNi6lfnhw/xmuPR5ZTx4D0OX14US2ilYYyawcC6CXI9x0p2P0I03Fj7/WgxOL1Qc9L/3MPQLj8O2v1kWQooXmgh6J6PWiWHd/UOAYp7PsQtkujnFLnV7vqaK3tWgoDsfuMq1tOjaGAk41ZJxz0FlnPUbIDFmOEOZYWgl8jBVnrRXMSoFdDvZL1eG5SYrTau25jdAf5capx/jwG1BOk2OA5UuDF/7mOMxkZ2+yLzKieM8ocC88oveJ8IQ520WySj3mOLmsoa9YD6OZfV4V8gUlw7XKzv7X3/eqMukeVVsnnKnyTBUAoh5H1/aJTHWkPtjP0+bfJciFuEfoeVLilVqjmjVFtpGEMJKdkQBBaNLNvAiFlFPIxRQ5eC/zP+FO6GqSBtxGeC6wi01MEwR/lGTXq8PVSsbwRErvl2tbAvkA50N0Yj/78tBSH5bJeigySuZp6rsp+CufyOv3UWE62jha1mnbwRllWLWTUyM43zQWtxpan8HVHSmVggmgMGTJf/JIKpVZmC/9wATggixjGqGRti9CyVnj7Sgx0pVoreDrdkXR1wz2jRjXCLRygc8/vS+ZIZ0hqSKdDTqw9ONuIYMrGcsnbjA0KXbec3QwwlBTzQAn8JZSxxlhyw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJBWWlpOVlzY2IxTFFsc2FlWkNqNUZjTG1kYlo4blZ6aTlPc3k4bTNyOFlv?=
 =?utf-8?B?TDY2UzNyMEdER1NmQWVkZlh3Tk1tcmVvRURXZ05ROTl3eVFoSVJCZ3FaR0VI?=
 =?utf-8?B?UXNaeElKQW9rVlJ5WHlRVkRiV0ZkenQyT05jY2d1aXR1RzYzb2ZkekwwdEtt?=
 =?utf-8?B?Z1J4WU5MdFMvR00vQXBFUmRtWHQxMGNIWWxnaGkrRk1KU0M0VmRDV1N6YzFx?=
 =?utf-8?B?bzU5cG93MHhjYkV1cWovUm41NHJ6Uk16SFpZdm45d3g4YXdFMHFRMkpTc01P?=
 =?utf-8?B?eGFnVkxUQjUyVDM1b0dWL0lOSGg0STZaZmFVZ0U5RWhNKzJlOGdpeUloeHFm?=
 =?utf-8?B?UU9wSW12Ti85T1h2RndubzZ3MXAxcS9yaHNLbCs4MnJoQURkN1p5UWYzWERn?=
 =?utf-8?B?U3ZvTmRNbzhJR0hlQm96bXVsNlo4QjlxY1pUMGZ0U0xkbi9PR0JtNnhNbElx?=
 =?utf-8?B?MElHUkppWE9jVFZodC9xWHZ5SFpFQTlBU0ZNeXZRTGRpM0loT1EwSWtsWXRN?=
 =?utf-8?B?d2tYSXRtRTJNN0dpNE9QTnM3UXFVbStjWXI4U3JqeWRoQnoySFdNTFpmRWRi?=
 =?utf-8?B?dkI5NmdiY0hGQTNEdUg4dXl3cEo0YVNYOE9STWsyMkxqUE83Zk9BOFoweVZq?=
 =?utf-8?B?cEhYaDdOM3lJdHJiR1NJUUJ5ZitQenExM05jNmF4MUJuME00aDB1UHludXVL?=
 =?utf-8?B?L2hrMDlJMDZqQVFIL2FMaUEzaVMzc3E0SVVaOTZ1TUllMUp2aGZTcHdGWnNj?=
 =?utf-8?B?TktENm85bndKbTBJK0ZYSDdMS2I0dDAvQU1QQ3NUUFFVVUIxbnFscmtNNnBp?=
 =?utf-8?B?ei83NHNxUXAwTlY4TW9WSUI3anlMM2NsRmYwaFcvandPUXkzTEtBdC9LbW9V?=
 =?utf-8?B?cjZ2MForcVoyRDNOZ2dub2dtOGM5WTFpRUlUUTZUak5HNExBYnNOYUV1NFl3?=
 =?utf-8?B?WERxWWNabHlneGk1TXVVTVFMTjYwWFNKaGlQWFpmeVNDaDFvTzJaUnNUOVMy?=
 =?utf-8?B?SXp6cm9xZ0JzR2VzanorVUJseEN3ZzFFWHhYc1RkL1FSKzhQREliZUU1cVVr?=
 =?utf-8?B?bXlLRTlsVHZrVGUyc2pTNmZNSGtYbGdNWmErSGkvTGUwMXkrTElqdXZpRGV4?=
 =?utf-8?B?L3VhTnZUMGlXejZpSVNrMDFUUytnTUExM3g3MFBnRDk5WmRCdE9xMWdmY2ps?=
 =?utf-8?B?RUlyY0dLMkxxZjFLWXd0aStjTVNmV2ZlZTI4VVMrT1pMWmJRTjhEQjIyU2M5?=
 =?utf-8?B?enlxS0NRakk5VDlpbDNjMlhTeUw3ckloK2twblJpZXpEWktYWTZIK2FJVlFK?=
 =?utf-8?B?VWE5ZG04Y0RoUFMxS01KR2ZGTldoa1dIdGwxNWpFZityT1c4cDZJREYzbW01?=
 =?utf-8?B?bTgxN0ZpY0RpSnN4TGlYMVFYTWFSSkxqVkVSTVh2WjhjTzR4VE1WWFBHU1RK?=
 =?utf-8?B?WTdzc3JjLy9jbXJYdDhPN2hMYVhCRExJQmRkd2RsR0ZYTGdKRjh3UFZEZkJ1?=
 =?utf-8?B?NFdtb0lDdEM3c3hVSGFoSkxUemRNQXdLdlI4Yk5lcE1pYjRqcVlDcWRsTk0r?=
 =?utf-8?B?Ylh3eDFjeC9walJhZUp0aTkxeFAvQUhOcS8yZU9CL2RoUXNwVU9tLzc3bEcw?=
 =?utf-8?B?eEtZb0N2cGNpNzI2WExIUFEwTldQd1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a823530-546b-4aa8-e828-08db51418800
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 10:30:10.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5302
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 6:22 PM, Simon Horman wrote:
> On Wed, May 10, 2023 at 04:15:22PM +0800, Yan Wang wrote:
>> It is possible to mount multiple sub-devices on the mido bus.
>> The hardware power-on does not necessarily reset these devices.
>> The device may be in an uncertain state, causing the device's ID
>> to not be scanned.
>>
>> So, before adding a reset to the scan, make sure the device is in
>> normal working mode.
>>
>> I found that the subsequent drive registers the reset pin into the
>> structure of the sub-device to prevent conflicts, so release the
>> reset pin.
>>
>> Signed-off-by: Yan Wang <rk.code@outlook.com>
>> ---
>> v3:
>>    - fixed commit message
>> v2: https://lore.kernel.org/all/KL1PR01MB54482416A8BE0D80EA27223CE6779@KL1PR01MB5448.apcprd01.prod.exchangelabs.com/
>>    - fixed commit message
>>    - Using gpiod_ replace gpio_
>> v1: https://lore.kernel.org/all/KL1PR01MB5448631F2D6F71021602117FE6769@KL1PR01MB5448.apcprd01.prod.exchangelabs.com/
>>    - Incorrect description of commit message.
>>    - The gpio-api too old
>> ---
>>   drivers/net/mdio/fwnode_mdio.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
>> index 1183ef5e203e..6695848b8ef2 100644
>> --- a/drivers/net/mdio/fwnode_mdio.c
>> +++ b/drivers/net/mdio/fwnode_mdio.c
>> @@ -57,6 +57,20 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>>   	return register_mii_timestamper(arg.np, arg.args[0]);
>>   }
>>   
>> +static void fwnode_mdiobus_pre_enable_phy(struct fwnode_handle *fwnode)
>> +{
>> +	struct gpio_desc *reset;
>> +
>> +	reset = fwnode_gpiod_get_index(fwnode, "reset", 0, GPIOD_OUT_HIGH, NULL);
> Hi Yan,
>
> As this calls fwnode_gpiod_get_index()
> do you need to include linux/gpio/consumer.h ?
Ok, I found and fixing
>> +	if (IS_ERR(reset) && PTR_ERR(reset) != -EPROBE_DEFER)
>> +		return;
>> +
>> +	usleep_range(100, 200);
>> +	gpiod_set_value_cansleep(reset, 0);
>> +	/*Release the reset pin,it needs to be registered with the PHY.*/
>> +	gpiod_put(reset);
>> +}
>> +
> ...

