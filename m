Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7926643EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjAJPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjAJPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:01:22 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2130.outbound.protection.outlook.com [40.107.14.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268504F13E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:01:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7f+9n1427CsXk7kRlvV2bDWx0XXXzv3SAHZRPQ4WIEFdetxROTti2XAbXt36h9jeOJlOAriaHbdGNlTRmBMKbylvnHuhFiTfsYRFcfn2EAhlMRSWoxb9tzGyLrzD/Tu+0eiIS2nTlXfgIZ0VMgGCXC5oCTEL61U9X+N6rzy1wVpS2DNYTLH0pigIh9znJxch/nfhIMUMJKkZcPQkjmR754DdhNLaLf9LYMfQEDN5hsRLzpj5qauvlna9YacjqKqjJR0dwmUCz8lU86xo/O1mnodkL1AYooIIZTo3U3gbIbiVa+u9wS/Unch8D+/9+BsQZVh1aYUCZXWtWnXpan66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaIClaSp0wAJCUJ8YJoYsyIg/3d30P9tsfETWl0sjQQ=;
 b=coCmUWSyz8cXU/ynNtYEfsJxO1v9hZyMmFS7extQoE4uqSBfWEQMgUND0ZS5dlOCIORUMKNBFrjwRPhlikave6UP4tqd/rlHdQO63be1s01Ma46+Kbz0HhxmyEYndLI2Eo1y+DtnDO0wYCHbikw0CmWlshxER5kZ99E6vczfQYYbiWuw2kOctEQySMifl3YJ1UCZWUp3KBDcsZ7HcDGCQZqXGch1MWjOOZV+pmZQqnZlHthDa7jd4Y3BQobKTiBwg4dwVoVEq60La94pLhasYi1fyyHTN8nKVYy9+62ZeG91f5wSXcUf+qXvtfkblx9Q8pBSQbgnlH2fkQsnOzkrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaIClaSp0wAJCUJ8YJoYsyIg/3d30P9tsfETWl0sjQQ=;
 b=pQA1mg+qdQhRZN0YpjWzHqmzcH+Gzh/647pH6sh9+qIdkCugNVswn1iWw4a7ZrBuTUwVpFo2RKjjyOuRvb632J21N28HBNlyAi6qyq5cLjdiQk1FL+GZfq3zUF1d9SJIpvMNlTITbWkKyIvzL2Ab5osUzo1wWSiiBaveZBaSR2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DBAPR02MB5976.eurprd02.prod.outlook.com (2603:10a6:10:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:01:16 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:01:16 +0000
Message-ID: <0cfd0141-954a-d455-b3cc-5eda8c275e01@axentia.se>
Date:   Tue, 10 Jan 2023 16:01:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] extcon: usbc-tusb320: make sure the state is
 initialized on probe
Content-Language: en-US
To:     Chanwoo Choi <cwchoi00@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
References: <30cd9157-1850-b17f-bfd5-4c378990b81b@axentia.se>
 <3e95cc81-bd58-2a4e-7605-d827610ccbf1@gmail.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <3e95cc81-bd58-2a4e-7605-d827610ccbf1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::18) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DBAPR02MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 91840461-0bb9-4db4-e8f4-08daf31b85ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkkjYYdd9gG1AEDPpRdqnSzqhMOVd3Tvynuqv1L1unjJo22Ru5iycRqyySedesWvtANL2JWE3pZKOi0jIe3znmY0+NqoX8oEOrfQ10ciGmQpxeJ5zGHJoGVhLUiRfz+ijxIkeBHfvZo29abZglvXMF4nGwSfPRr4eVqp+mQo+SQUqopHiSzIDOUok6JqjIHjv5zwBoRsoHttwtiBpDOdUv+QSRl3LOv7JVCoA9oF/AWzBKZz8kroUiWRUbYByKmasOtDiEUeOXyvSZWiUnL0tvvg6pKZXQJW++tpiQ8lA40+pH2CyHy+NK/5I3jupmXVPTHSVhdDdW107ZPlnZdpjcxoBgBl7gawlrJNsJpaJkvxUVpm8E1hjIfFkBb2utxCKv6e45pW7p5Zsnca2rnEKJTGy6veSENAEVdS/+p+ZHamNGQp3DmxDlYOKY5lIm3kkai2X9raRPF95R/DJD6wZGSUIMec8Oue+3UsT9ETReDNnfZLpp39DamfQG7bd1DOFxzGq0Ar+2zpIKnXimzce5BszXOcR0KPfsY5sw7LS0iO0uxi3tWFe7NBt1hSlDl2L0qO6y71SZn4zVBeaAPfDiJAT4qVwf0kHey4yyaK8knxQXRZnMMAh29EZoTF3v+86KqvaM4QmnmCd10mbJDKVbv4XYuMGzu0eygG+Tuny530CNz1YJ6a8dSlBGYtuTY0xwGApG7vukbWT2PaEP0Y/lRjvB+37Ndpaf8rdvIwDPUk1wT28wsu7a1sRqJ7vxEU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39830400003)(136003)(396003)(366004)(451199015)(6506007)(38100700002)(31686004)(2906002)(478600001)(6486002)(966005)(2616005)(26005)(6512007)(186003)(5660300002)(316002)(83380400001)(8936002)(36756003)(86362001)(41300700001)(31696002)(8676002)(110136005)(54906003)(4326008)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eURheWpVSldCTFE5a1B3T05wRHQvZUpUak54TFJJdTVHWU5xTXZna1JBbXFi?=
 =?utf-8?B?SE9HMXhDQmVyaWVka3l1b3drVU9JYVhpby96cU5KMTBkWGxmNDVROS9NWkt4?=
 =?utf-8?B?VzBLSWo2emFydWZlNE5jU2lEV01qS2NCOHJPSmF1cGZPckYydUJGVGlmRHN5?=
 =?utf-8?B?VitxYldtaUFvWVJpejlsY3kwZWx4VGF0Um9iMndMekhLejU2WkgrT0U1UGVV?=
 =?utf-8?B?ckRldW5xenA0aUdQcFQxMDV1ZWdhUG1uS1NvM0RHZ1dlcnF1OEVSa0V5S1Mx?=
 =?utf-8?B?dzRrZFl3T081SmgyTzdTOTBWOUJJWkZkRDVWV29IaVdYS2JWNC9ZRkhjZnZW?=
 =?utf-8?B?TStmN0ZpbURtVTQxbHdNb2F0UW05OU44ajEvek5DOWh5cWRqaXc4ZGM1bU5t?=
 =?utf-8?B?Sml0NnV2ZE0zRWR6YTllYThmVUs0QlA4TEdwME90TUF5Szk2dDkrM0lCMGNk?=
 =?utf-8?B?NVNKM05vTXB3SlJtak11Tm9YdGYrV0FYTjQ1YlNCL3IxMnJieFVSNmJKRUdR?=
 =?utf-8?B?VDlTV2dYa0dZcW8zeDh0OU4xbmx2aytHVWFYaXZYaDRoN2N1WjNVcXZRdkIv?=
 =?utf-8?B?N2FyYTdtTmxnOVIyNzNGZi9Mb1NwUWk5SGtsa2VkZWgrS1NmQXUxb0YzU0U4?=
 =?utf-8?B?bmFMam9zTlpsM2hmUVVWK2VPdzRocEswZFVTWEVpSHduTUlZQVNNWXlXTE16?=
 =?utf-8?B?Q0ZTcHI5bHhUbnNaZTQvU1BodjkyWFBqZzlqQ0Z6dTVNVENHR2dCQkFzNktV?=
 =?utf-8?B?bVpJUDRJdkNiTXNsMERoQnFnNkdMTjJ6YmdQWEIvWStzZEZUdUsrTlJlRTla?=
 =?utf-8?B?OXRHRGNjV1g2L2ovYys4c0VJWW1HODRaeVJoQXV5RnE4U2VsVkR6OW15QllF?=
 =?utf-8?B?NjYwVlF5K1orLzRPeDhGalg4WUtPMlNqUkVKdjN2d0dOTlN3TUcwSmlOQkZZ?=
 =?utf-8?B?UFJuVXZwOVdudStrdHZLYmFsdlNEVlZkU3JJcTErbUxzbWNqK2I1NHlSVGFo?=
 =?utf-8?B?R2dIL2hjVndrMXdYMUg1SXJxRVp2a2F3azFkRjFtcWhPdlA3aENuVHI5aTkw?=
 =?utf-8?B?MHBYUVRRY2ZZd3NwNFdaNkc5ZGNvU21jbEdTQXB1Z1FjeENiVURiL09yVGM5?=
 =?utf-8?B?SjdlZHBvQ3d1dTdaU2RBK3pGRTluREZEUDgzMjZqcWNmMTcxY1FnNXNEY21N?=
 =?utf-8?B?L1FwU2JZdjBrSzlEaktmSWpMYlN3Z2x5b2hTQkJCZ2NQQnpqU0RFWlhmMmZP?=
 =?utf-8?B?aVVWTExOeVNhYldXWlc1S09YWU9Ed3E2RmdLMzNqTGxuc3QrbkhJOUt2UXlo?=
 =?utf-8?B?ZmxJK3JtVlQ5QzN4U1RScXZ0Wi9OMTRhUjZBQ1I5d2tINmd2cm03T2hWTSt1?=
 =?utf-8?B?QnpGdVRqVXlNWUNON2ZxNm16UlgvMmJQa2tYWkJKRTMxN3RJTVA0Nk5HNXRx?=
 =?utf-8?B?bTk3MlpqTHZVVmw3ZlFRbHd0SmFyZFRhTTJnT2ZxdFNCSHRhM1JuQ1k2K0pO?=
 =?utf-8?B?NE9xeFRhYzg2eDlpMTlSREVoS08rdEJLNmVOemtZR3VrMFVjcGRIVi9hNUQw?=
 =?utf-8?B?TUloV3VCNWVLTFYwOTBaaXJEVHBFTWptVGtJRkRVY1hlV1pPRTNKODllT1hZ?=
 =?utf-8?B?MmU5anZYUS9LcGE5bCtEZDBBNFBaVDh6cEpqMnh1MlE5cDNaaW9rV3krNHdz?=
 =?utf-8?B?YjlIclcyeDU3L3lCMnF5VVltRjk2Z1BYRXZqNXFrL1g5L2RHeXBkZ2w3ZWF2?=
 =?utf-8?B?cGdQa1dYR21RZlo4VXdVUVhkNUsvQ2xRQ2hBYzdaUjh1N3pSakpIeXlmaWFW?=
 =?utf-8?B?MTJSVERpREdIMEEvL1NHRnhhU3JBZ0xaZGdaZkxKdmhJdHZ6N0VFSnNXL0ZV?=
 =?utf-8?B?eVNaUHhPalVNZmc4bVRTdDJwT3R1KzU0U3ZMa3drc2pUTktvbncxc0ozdjJX?=
 =?utf-8?B?QlBsallPc3I1dWYzQzdFM2FmS2w3Zmo5YzRidkdqV3Vmd2pJdFF6d1gxSG1x?=
 =?utf-8?B?alJabUJudFVmTFB5S0ZhT1VzeU1lY3lmTG5UQ3hSaEVQMWprOEsyc3NISGpB?=
 =?utf-8?B?OU5JaEoyYUhQK0lUNVV6ajg5cFdmQUhkNHFLbWFaK1J1L1NJY0J3UVVQRkNJ?=
 =?utf-8?Q?f/iO46MfGiNVCivxMPMmFyfGT?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 91840461-0bb9-4db4-e8f4-08daf31b85ae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:01:16.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDyoaPvJdkduCPSGFWx4ycvKwRDhprDEw0qpV3U2f6YQKTBby/3LP6dQFzQe6FAS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB5976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-01-10 at 15:14, Chanwoo Choi wrote:
> Hi,
> 
> On 22. 12. 13. 07:36, Peter Rosin wrote:
>> When the port is connected at boot, there is not necessarily
>> an interrupt flagged in the interrupt status register, causing
>> the IRQ handler to bail out early without reading the state when
>> it is invoked directly from probe.
>>
>> Add a flag that overrides the interrupt status register and reads
>> the state regardless during probe.
>>
>> Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> Hi!
>>
>> This is basically a resend of v1, the patch has simply been adapted
>> to fit after the driver changes for type-c support.
>>
>> Version 1 of the patch, with its brief "discussion", is here:
>> https://lore.kernel.org/lkml/ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se/
>>
>> I cannot see how the patch can possibly affect detection of connector
>> changes *after* 'priv->initialized = true', so the comment from Chanwoo
>> Choi is still a mystery to me. The patch is about what happens *before*
>> 'priv->initialized = true', i.e. when the IRQ handler is called directly
>> during probe. There is no change in behavior after the statement
>> 'priv->initialized = true', and IRQs are handled exactly as before once
>> past that point.
>>
>> Please look at this patch again.
>>
>> Cheers,
>> Peter
>>
>> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
>> index 2a120d8d3c27..dc586e5e3c65 100644
>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>> @@ -78,6 +78,7 @@ struct tusb320_priv {
>>  	struct typec_capability	cap;
>>  	enum typec_port_type port_type;
>>  	enum typec_pwr_opmode pwr_opmode;
>> +	bool initialized;
>>  };
>>  
>>  static const char * const tusb_attached_states[] = {
>> @@ -323,7 +324,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>>  		return IRQ_NONE;
>>  	}
>>  
>> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
>> +	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
>>  		return IRQ_NONE;
>>  
>>  	tusb320_extcon_irq_handler(priv, reg);
>> @@ -479,6 +480,8 @@ static int tusb320_probe(struct i2c_client *client,
>>  		 */
>>  		tusb320_irq_handler(client->irq, priv);
>>  
>> +	priv->initialized = true;
>> +
>>  	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
>>  					tusb320_irq_handler,
>>  					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> 
> I think that if priv->initialized=true on probe step,
> tusb32_irq_handler return the always IRQ_NONE
> because priv->initialized is never changed to false.

The new behavior is to never return early when priv->initialized is
false. When priv->initialized is true, the old behavior is retained
through the right hand side of the && operator.

> Is it right to keep the 'priv->initialized=true' always?

Yes.

However, this patch is no longer needed. I have since noticed that
the problem was later solved by Marek Vasut with
581c848b610d ("extcon: usbc-tusb320: Update state on probe even if no IRQ pending")
which does pretty much the same thing as this patch, but with
force_update as a function argument (and inverted logic, so
"if (!forced_update && ...)" in the above if-test instead of
"if (priv->initialized && ...)".)

Cheers,
Peter
