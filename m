Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA026D6AA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjDDRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjDDRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:32:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D565B86;
        Tue,  4 Apr 2023 10:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx0kT7lB5Ag9CydDFXgztsuL7f7A7FyfjGEif3bL+bVCcSpul/8V+/sqyKE0f79YmFCyuoLfCAJfkyzPunifMLTGrIpdCSGrEJOHuavlNN3ZULvE5NyU1gb15ds09MKRGyi6deAtXvmA5MAzHSIOyTk85FpBNWOcJASr1hfbw6OFBcf9JbyaeoSB8X4xQpUtxfL+BoAPBloem7h5F75yJ1nYup6Dq7s0OaihOhhtpBQ47P0fL0Bc9q+uG0kfAT8zpUSaXBx9Dno+UvwkCHFXVhlpI5bDxnO3WFDc4WOZ5X55MP9EbR6sQxjgtW2uq9Plw4BMF1Rhzxiffi6HAJXVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vn1Gv+MPsZse8YDIbac/WddAJh1/5fEZ8LboCnVufF8=;
 b=AGZqADq+jilexd3tIu3sZxjSiHyyXjFjJqNrM9hwBdFD8qssUVXHxd3A5SkXWXMbact/UqcpuTxhegaQ5gvhddbptGHzFTCqKsN0Zl1d7FNCTTYh2+48OKlhuQhOV9X7DfSa7RNjLxJoOKsBnifm5fZVczZr8exLlNZiK1sAahy2LVtb9igR00TnH7hlsxdtBNJtVPIcgRel8/16aIrkf3aMzP4B/Zfzd++V0S9F7FNoqEl1VIjguo1fpBpZQvaPbtSzf7j8PF7d/dUqowd15l93B038fXOSPgsrifWYkGv924m1oPaGztEcSTzZGydXdxZm1cGKhV0OVkQhDE6CVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn1Gv+MPsZse8YDIbac/WddAJh1/5fEZ8LboCnVufF8=;
 b=Fn1792NXj6WFAgW9MpPI98T0s0rjjtN00MpxDA+apDcsHQCtu/SZDCIOxxKj3ICrKSVUkBavg4LDf+lmn7QNawtkhydFEE1/9CB1c5XZx8uvDs+mmHGVmhAKdd5awwkGJn6ufbNPOVIF31yTNhmlYGMRK2IlYTLypAedLEXU15O9m2xesSYburITFEAiFKtckSqnhLqkMrU6rx9PgQ56/sVl5QVa4JDAXxiDKQolEuUvYIbi/hZwciapKXRMUaRZp1OmiLxZLXWllmZYSN3/XeQobm4lf6PIHucYWLnsctfjG1kkKBCa38+9eHiqUn+jAOAm/z7XCfVFnMCfv5+Ktw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 17:31:00 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 17:30:59 +0000
Message-ID: <6acd75ce-2902-01cf-5b53-f852ed70de15@nvidia.com>
Date:   Tue, 4 Apr 2023 10:30:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <20230324171329.GA2062332-robh@kernel.org>
 <7f2dc5cf-78b5-81c6-0012-26b1adce1c86@nvidia.com>
 <19b71fef-614a-d678-2e73-95db8f226e61@linaro.org>
 <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com> <ZCv74dMMucY24L9m@orome>
From:   Dipen Patel <dipenp@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <ZCv74dMMucY24L9m@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 057df557-2640-476f-f3d4-08db35325b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNbTQTY4kIBy9MmMl3wufAx4EIMXO67d7kYkjiLurSIyKFGkZr72rzEnTo4xssWb/d+wJBw+kmKdsbNN1du95/9l7PhkZoBpMhrXdqLwXuSQCNnPFyVDaR39g4/TM3h9hLAnmixsl/uBmkZMRxx3EH27WQ2nTODQSi3oneTmObBpXAMdsMd9xGaR5jHfOTmnA03BWIxJ6sfXAg72P3Tr07dONT0NAnVrYdAlSHMaf7PzqaSNnqAUyGzVGZFqpD8zeWta5ni7SNV3uVkv+zkpBR6ap+tPwjzBd+ZuWXcXJu66nVGSbMOXAyO2t3CV1E2VC4ChNzFLX3eV3asLM/Ra6oXGcb2brFMAYt3fNNqbnvSPM/2uxSbWHLe0LCGYEkruiQGGg55sSJQ+//2yfbctChRc38qNGDBj5SFkGZEB4admssdtAjwR2HfAdYifgVjD53EDwgq2gp1wRDZP4mqcOlO/B6UjQib873Y9tyIjiCjVdXkylM5DDJS3aF7f+BtjHquR/seliIVIm6EAdWD5TchMnyQkzrfurXZD0tjuejO4Iq7xKq3xP68Szy02yAGA9RAenx2Akk55PAZyClXQ7g9VM7mlOHM6zDZ1mwgsyTdQ54fxkCuvyNaEdg2gmQBKrO7a5N64gWEZuYYa5pOvRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(6916009)(66476007)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(8936002)(54906003)(7416002)(38100700002)(41300700001)(5660300002)(53546011)(6486002)(186003)(2616005)(6666004)(6506007)(6512007)(26005)(31696002)(86362001)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJMU29BaFR6YitQUHo4eGxBV1ROSVg4b253SkwwaXFSVVFQOEVaeXQyR1I0?=
 =?utf-8?B?NndOdGhCcU56aENQZ1FHT3dmQnhvY2Zjb3VrSE9zOVVKZ3lncE9UOUtlR2k2?=
 =?utf-8?B?WjV2cTRwY1NCL3l0bVRZbUNtUWV4T2NJY1JjM2FrOURzZFhGZGM2NjhZS3Np?=
 =?utf-8?B?ejFJOFdOazBaaDMwa0p6UVAxNU9SVFNtbzJaa05idHE2MUsvZDVicTZWQzg3?=
 =?utf-8?B?T1cvdDl6SU8yNldzVWRIWnpoOHVSdVorVVhTeWtyMElUeTVzbXVzWFVSRWlB?=
 =?utf-8?B?MG1ETzRudEx2K0NISE80Y1o2bFl3NTBqQllmTHplb0NRR3VONExUN1ZxTGNX?=
 =?utf-8?B?NCtxSkczQzZ5WkswR3Q1akwyUkpRd0NBYUE2bzM3Nks5ZllYN2VySzJRdWRH?=
 =?utf-8?B?SytjdFo0Z0JCL3VKZlpGVlp1cmZyakZqLzUxSFkzVXQ3U0ZsUzd5YU5leGtB?=
 =?utf-8?B?QkF6TDBKbzVhNWdyaUwrZGJYdW0rY285Rm9zMUo1L3Yyc3NIdmRLdmIwLzMv?=
 =?utf-8?B?QkRPb2dqVU9sMWVrcE94WUVRajNxNUt6aXRNdGliUmRQZERrS3RHd0NhUDlQ?=
 =?utf-8?B?WHJEU0w2Um5vT3NOMkY1dnE1S1NFVmhYa01mRGNZRWtLak1FdHVoSVdla0RU?=
 =?utf-8?B?SE5PUFZGWUVNNFNxNVZvajFQYTI1TzhnSy9lVWZvb2lZTEVpL0pReHZVazVj?=
 =?utf-8?B?U0dDWmtieTlPUDZFRlJuYWxXSkNHZEhiSkFndkYwK1E4QjVWTXNGaCtsRFRr?=
 =?utf-8?B?TnZuejk5SXdUemFoWEpXRGJzOWNsNXRFVC9IVHR0WFhpN1loNEozMEYxT1hF?=
 =?utf-8?B?ZTJzNjEvVzUwcjNZc05Ud3dSOS9pMDA5a1JxK3dONnVYZ1RBdmVsREMvMUEw?=
 =?utf-8?B?WnIvVkRDRXR4MGU2WUR2MHMySWdWanduVEliUHRYcjdKNENwTWVkUkR0eGNu?=
 =?utf-8?B?MmMzbXlqR2hLczhiL2gybWtqcDN0R3pCVURGYm9mdzlTY3Z6dmY1UHRyQTlO?=
 =?utf-8?B?MlRxWSt1dVNQdzFvRHdvcjM2NlAvOENnakFHdmRvQ1VpQjhvN1kwd3Qra0Ur?=
 =?utf-8?B?eWFZYVJRVGhPWnF6U1o4SExOaWQrNDVXblNNdXAvTnNhSE5ocW1qekhWaFBD?=
 =?utf-8?B?cDZIRGpMYThsZEVybm5tUDFLZzByVWVXSWFDaFVFOVRoMHN1b1V2UWhjS05V?=
 =?utf-8?B?QkppdHpxWFdVaGx0bkpVRVhPRjBsM0V0aG5SazU1TjhaUmFpemwybXN2aUlF?=
 =?utf-8?B?VGx5eG1SQjQ2dHRBNHRyNEFOTWhvNDJROHoxUTV5U3lYM0RLeVFmSldlVzl3?=
 =?utf-8?B?ZlVmNnVpNGt4cm5qYUcrTHlVakVRWlBqZVd0eWxnem0xQkJKU2J2aVNaQy9N?=
 =?utf-8?B?akRLM0dYMnlsTDZpQmx1bVEwZkFYeTRXSzQzQlRkc1JtSStna0JNYzJNYk96?=
 =?utf-8?B?T1ZZMjV5aWp5UDJCWGZId2hlV3lvRU9RL3BBVm9LVUNvVk1Vd0xmdGwxNGRZ?=
 =?utf-8?B?SDZCRFBvSVo0TEYwQVlHVjF1bFptWlVrQTJLVGZMNXpaYkdmRVVjRHlmTlB3?=
 =?utf-8?B?RXNJaXQ1SE5aQW5CQUJ3RTRXYTdSSmdRNFEyNE1jM1FBOTdNTURtYkJzZGk0?=
 =?utf-8?B?ZHVQL0w4OG1mRDBpU0Y3dlZINHg3bm1wZ1B4NXVrMjJsUG9ZZVVYUVhVVjkx?=
 =?utf-8?B?UEhyTml6SEQxaXNpQWpFYmtlVzVzTHV2ejN6LytBYmxXb1VCMVFCeEVDZUE3?=
 =?utf-8?B?c1k5RHB5K2tjZk5rclVQWEVha2srTUxvcXJVc2JPclRpWjJWdzZ4VWJXbGNh?=
 =?utf-8?B?S08zblBER1ZMZlVFZElCTHdFc3doOGgvT2lWNmdLZkZvRjQ3Y3pyZzBndWc4?=
 =?utf-8?B?dnZ4cFNENXBlSEVlVmNNMWxBZzM3SENST0dNT2FwQjVjV2tIU3FsMkIxa3gx?=
 =?utf-8?B?aWd0a0NRZVBHdzlVMU5qOG1xcFFOdWt3RXdQb0tRVlY5NGlsOXRWazFRZEx3?=
 =?utf-8?B?VnFxL0RMMkprT2RZTThIUWJ2K3VjTnJHRitlUXhSYnJ6bFVXdDc5NWhNTVNk?=
 =?utf-8?B?NGZPWHNFYlJDV29IbHBoaHVya1FESkpRbUN1K1I0T3Y5M0ZKenpOQnR2TU9P?=
 =?utf-8?Q?dZOMRsTUtxVycJlTuu1zreEz8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057df557-2640-476f-f3d4-08db35325b24
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:30:59.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aV6POlZNDXjT9m1W6EGlBeOGaH1SNm1D5We1M9ecdxCq+xtAkhkvXWpUL3ADD7NXa4zANBi5zRQEAGlXkfnLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 3:28 AM, Thierry Reding wrote:
> On Mon, Apr 03, 2023 at 09:24:17PM -0700, Dipen Patel wrote:
>> On 3/25/23 4:09 AM, Krzysztof Kozlowski wrote:
>>> On 24/03/2023 19:51, Dipen Patel wrote:
>>>> On 3/24/23 10:13 AM, Rob Herring wrote:
>>>>> On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
>>>>>> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
>>>>>> This is done to help below case.
>>>>>>
>>>>>> Without this property code would look like:
>>>>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>>>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>>>>> 				   tegra_get_gpiochip_from_name);
>>>>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>>>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>>>>> 				   tegra_get_gpiochip_from_name);
>>>>>> else
>>>>>> 	return -ENODEV;
>>>>>
>>>>> Or you just put the name in match data.
>>>>
>>>> Not sure I have understood this comment, but "name" the first argument is
>>>> already there to supply to callback to match data. Also, this if else is
>>>> needed to know which "name" to provide.
>>>
>>> The point is that of_device_is_compatible() do not really scale and make
>>> code more difficult to read. Your variant-customization should in
>>> general entirely come from match/driver data.
>>
>> Perhaps I should not have mentioned driver related details here about how
>> this property will help, that detail will go in driver patch. In the next
>> patch series I will remove this commit and just focus on what this property
>> is.
> 
> I think the point that Rob and Krzysztof are trying to make that rather
> than adding a new property for this, we can add a const char *gpio field
> to struct tegra_hte_data and then set that to the compatible string of
> the GPIO controller that we need this for.

This means it will have to track the label of the gpio controller and for each
new provider, we have to touch the driver to set the char *field. Also, I think
having gpio controller property in the DT presents/describes the tegra HTE provider
perfectly as it does have hard dependency on the tegra gpio controller.

> 
> To be honest, I slightly prefer the explicit phandle reference, but it
> also complicates things a bit and looking up by compatible string isn't
> all that bad.
> 
> Thierry

