Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CB6B0AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCHOQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCHOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:15:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7125957
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:15:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYvkaFo6cFtAk9AXSQmjQgb7B0AHL0jjjIjxY0Xvq/2BwCN1rm7O+Nw0OlRJ/vj7qho62KvhzXrPBAVjglmZsNW+jcbaLrCllIq84KbcIpt6L/DpUobmfCyMXm7gTyDInquKOS/P3GJeFjmqAvdDOFZcFTUPYSq/QodoJH/yLZjvdi9u5dXFYulcrrPKTGBpYG+GFhUmcOlfKE377ol51ijD04vLDY8eQQZZFxkjISn7NmaiPJDnoVSF943yGVwMg7yh6wKxwMkKOCnEjOxOcqUSmO4Mb4mugYfEfLzclVRzpXZbbDTT8CArHjPx2nyzQb95bWf1dSgT8DfGtbWnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSX9vkm48CGKq8vSuS+OLQY8yKe+J8RRGgUqZnSzmNo=;
 b=Mp4Z+uHyIvwa5phVYVLOxiwMYpEtsFXsP+SLRgbHzgkSMet3ZA8DZ1ELASeT3UWjPyoVJT1y4Gi8SGP1IFNQGP7NW/15yPcljmt1sNU6U4aknBCkH+U/lWkMPmHEI+14byw+9Ajzhx2LMuprTJeT03iFjJXVa8z8JWFY4UYKVhSlbvzoG1XP7qm03wWtDsVjABwHyyht1CAf+pe0KqMEGBrE8e+bf78hNgOmwWeap3mQfwv87SN7pSpiE0q3fcl+ilaKRgQb4yexCWKaKIzHrQIQSnnyhi09iduv7K3GpPWDTyild6awn0fX6LXmciI2Dv8jCSLX+RwG4w5r/Ur7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSX9vkm48CGKq8vSuS+OLQY8yKe+J8RRGgUqZnSzmNo=;
 b=zWaIdI0lfcwGBzbyku6kDdLBwtjY4+TtoYW50KsyllA448POSEDPh5S+CXzm4UT48yI3wQPkqZkDWEBt4Y6cVqd3Q6onsJtrATpem2O38Q36b0OdKAElASPh7lzqKm3CzEBrt7sorsPVroc+LEVjH4+yvBcxg2l3XWikj9iglkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Wed, 8 Mar
 2023 14:15:12 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 14:15:11 +0000
Message-ID: <2e629a29-093e-46e9-2329-0d5afc916ee4@amd.com>
Date:   Wed, 8 Mar 2023 19:49:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
 <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
 <d5a75826-d762-27fc-5820-6826debdecd9@amd.com>
 <9399110b-bbba-f96e-85ef-a317e8f4d518@linux.intel.com>
 <4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com>
 <85aba51e-1feb-5eb0-2e21-b714e217f9e4@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <85aba51e-1feb-5eb0-2e21-b714e217f9e4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da092eb-27d8-4fb7-1bd4-08db1fdf8736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYu6zcMlZwCqADvk1V42RLgHj8WdhxOmIi9essVQTRgU0dfsPnkTGy6XHFzisLs6rW9w51Ahvqx5kFZTeMhIT5RcYHn8nYz46bzERQB8bjJz1EYPyVugPKePjtZV5n7uZ7oKfn5mduOLEr6EuiZrd2llD6b3ZPoEFjZzlknGIGgP64sk6gtk3o3sdiBXWyRMI7QB8ndhl8Cc5s3Nna3+V6v/1FYRG1Py9vxQBUUPRQB5sdTJ+C7cB1e4o/yPi+13CGi93H9jyS0jm1/dNMDd/RrWHalbpMN8uTX/YUQSvpn+iMmIyvbDp9ewhjFzNmGju66ZIoNXC/8vnTr67dy+opm5/bKPT/JB60XVdq56RTRWgluyUKKUpEVC9w/iED7neADztsduNgTFNiGos+MUdHKo3xbLaGGqfL1thHpPHIRkFdApvyJyagtnTEgLrjpZKfdfEW5d27WFYIZPEDQueQN4cHyezLMtUCRu9aKhoFS0oFMH52yhjqLRKzP0qSVzisG6C5o1FdGJoRpqI/pJ0Gwa0jVSjsrrj8bjnH0J7fcSD2MuJzIslKBvmAQzo8u3ENPeVW5tbKcYUhbCXZzgz9298XOTmFBMrAhj6KPgekyAiNh82Vsk1we0my10UszfPjKpBZoQkY5EaMb5SSdXHefNdgxcKvllA5Zp/vG6QDEaCLN5bYJE6cMucUf24PpwvU+uHfMwbQinigRfkhlgKW+nMpO/47igvtSXhYdOd3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199018)(36756003)(83380400001)(6666004)(6506007)(6512007)(53546011)(26005)(186003)(2616005)(6486002)(966005)(8936002)(66476007)(66556008)(66946007)(31696002)(8676002)(86362001)(2906002)(4326008)(5660300002)(41300700001)(38100700002)(316002)(478600001)(54906003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXpUSTZzbkJ2VjVtQlpLaDQvMEw5Mms2ZS9jL3MzWlVpWGxVUUwrRmpzZloy?=
 =?utf-8?B?bmtZUHN2bmIrQmFvNHcvR2E5ZUtjbU1pdDR4NzErbCtBcThYUmU0dDFsRitB?=
 =?utf-8?B?RkFnam0wbGJ5bzFER09TTGQxbnJIZnNKVVhKRDcraGZEU3I1V25Xc3JZSU1Q?=
 =?utf-8?B?SmNYbWxXdXpDZlRMMkordW5ZYnJOOGpobUhaaGdEbG95alNrM3F6Q1FnaXBV?=
 =?utf-8?B?VCtpZTdqMmwxb202ZElhYXJQbkZXeExVbjRtVVVHZExNUU1JK1BPTG5WY0pZ?=
 =?utf-8?B?Vlg4dk56WHF3UXNvSUdqMFdkK0llbFRnNW9OZVVIcVB2Tk1yUzh0VkR0WTFP?=
 =?utf-8?B?bEZLQ1E1a25peXlxZTJWb005VWxoNnZjZGNDL3ZaSk1EN2duaHJHMHBYUzZI?=
 =?utf-8?B?cEFBdzlZcEZOU2tZQkJVVmVnbmR4TW9wN2FYTUZHOG5FalVjRTVrWjZLdjM2?=
 =?utf-8?B?ZElFbjV1UkE1aHFKc1N2QitGVWs0d2NxQXpobFFYZ1JURnR4QlQ2d0tkd2JQ?=
 =?utf-8?B?dmJ0TUZSZW5qREZFWkZPdGlWNWorWk0veDBublEyUHB3Q0phRnJnV2h0RHJk?=
 =?utf-8?B?YjNWckY0RkVrTlgzR1RPeVlrMml4SHVIcFFRd0xpWTM1VmpxMEJFeGJNRi94?=
 =?utf-8?B?WUZVcjUzK21rMVhLYkUzWE9tV2RXZGxPSHE4K2c0WkJMNlh2b1RnL3NpMUhK?=
 =?utf-8?B?OVZEL2xQbEZUVzVINC80VURWOExjVlhOUjhyLzlORjRvdkQ0dkhEYk00c05o?=
 =?utf-8?B?V0YwWllFTnppZjZWbDIvR044RGZBc3g2QjJXeGxTOGFLUUFwTWEwdGkyc0dH?=
 =?utf-8?B?RFFNazZGVEVOd2RreUEycXZraGF0Wnlma2lQSjNPL3JhUFJmT2NRNnpqN0ZI?=
 =?utf-8?B?UVRNa0ZZT05zVHJFSFZyemJqaDZGRitEdk41eVVJNjFnZHQvWEFXSFV0UjFl?=
 =?utf-8?B?QStmQ2cxTGlmMUU0dXh5WHQvTHB1R1ArQlRPNi8xVDBqK2paa3MxSmNtNFNO?=
 =?utf-8?B?QVNFVnIrMkNPbXVHSXRwV2dtcGFWbkc5NXJJZzVyQjRzOEFsa2MzV2V2RU5i?=
 =?utf-8?B?NlZPZERkQ0xWek5NNkszeWxoOUtjUTVyL3F0UG9QYnhXUGJuL0RVTDZNMXdS?=
 =?utf-8?B?cGFGdk1WSEFraFhxbnFqb1VvbURZQ1ViZlk0anpOSkNhZTZsTksxS1FkcXI5?=
 =?utf-8?B?WWlCRjhNVGVHSTNRdkNObTlrY2FVN0FXT0FhOE9KZko4anl4OXZuVjV4eFox?=
 =?utf-8?B?aEg1cW1FU3ZxWlZmOHRuTHJxa29GTTlsNDFib0Q5b2hDQ0tjcFBITzczZWp5?=
 =?utf-8?B?NERIUXJqZHJzb3lMU3VsTUd2V2wzTTdPVW1GUEVHVzVVVnJveTRjeG1EWTIy?=
 =?utf-8?B?Ym9UQVlHNW5odFpGMWsrVk95S1JiR05QVTJWb2FUeG5ibi9VSHhmai9hZWRS?=
 =?utf-8?B?anN6Y2t2SlNHSUo0RkFHOTBXd0VqTVJ0UlJQVlZLYjd1dXR0RTBWdk9DVzF6?=
 =?utf-8?B?dnhaUkY5NGxxQUMrZFRUaTRpdXJJWW5obmU3VzNaV0c2REtwNVJaS0xzL29Z?=
 =?utf-8?B?WFRpQzlVYUFVdnJJYmJNYnFqUE9rS2JydXQ3L0dJeStua2c2RHczQlZiZ3JY?=
 =?utf-8?B?Ym9aaTZCRno3ZGJmb0Q0TDJnZXdZaXdrVlJuV3ZrcFBQYjJwTmVRMGJWSHdx?=
 =?utf-8?B?UVJPNGNGeUpuZDJOamwrMU5qSHMvNlJTaWh0c2RvcEVOUk9WR0F4OFNjOGgz?=
 =?utf-8?B?OGZabTlkS0xXZ0FwcEZwUGpabTV4UUoveUpmakcrQlRpV2VlSEUzQkVoa09y?=
 =?utf-8?B?a1EyZ0J6OHlaVkdNWmZhemhKQWppV1BRQ09XWUdsYWo3OXk1UEFRajRBc3o0?=
 =?utf-8?B?Wk80KzRBUzJneWwrK1kzM0gvcVlocVdraGozYlZSTDBQNElaRTVHc2hFR2Vk?=
 =?utf-8?B?MTFJVk5XWWM4a1cxYnUvWG9CM283SXdoY01jT3h1MWR3eUdHbjRoMTdVazdE?=
 =?utf-8?B?Yk5qQUc3QmJoVXlROTBQYWsycDcxVG1lSmdOejVTR25FMFpzYkgvVUN1WnNV?=
 =?utf-8?B?SlNiNVZ2NlpkTXc2RmZDeG0xQ25HQzVCVit6Zk9tY0I5UVRERENPSVVSK1RQ?=
 =?utf-8?Q?JhW43ys2poi65o/VCL+HaKiUB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da092eb-27d8-4fb7-1bd4-08db1fdf8736
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:15:11.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7eAwKhiA6KUCr0798ePyz1g65nSKB+8OOfXYSFA+jUvNJdBEkXpk9RjmaZXBzhd2AqNnRYdM2wHMAQ7QNaECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/23 19:28, Pierre-Louis Bossart wrote:
>
> On 3/7/23 22:32, Mukunda,Vijendar wrote:
>> On 08/03/23 02:38, Pierre-Louis Bossart wrote:
>>> On 3/7/23 14:25, Mukunda,Vijendar wrote:
>>>> On 07/03/23 20:58, Pierre-Louis Bossart wrote:
>>>>>> +static int amd_resume_child_device(struct device *dev, void *data)
>>>>>> +{
>>>>>> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (!slave->probed) {
>>>>>> +		dev_dbg(dev, "skipping device, no probed driver\n");
>>>>>> +		return 0;
>>>>>> +	}
>>>>>> +	if (!slave->dev_num_sticky) {
>>>>>> +		dev_dbg(dev, "skipping device, never detected on bus\n");
>>>>>> +		return 0;
>>>>>> +	}
>>>>>> +	if (!pm_runtime_suspended(dev))
>>>>>> +		return 0;
>>>>>> +	ret = pm_request_resume(dev);
>>>>> I still don't get why the test above was needed. It's racy and brings
>>>>> limited benefits.
>>>> As explained below thread,
>>>>
>>>> https://lore.kernel.org/lkml/acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com
>>>>
>>>> Our scenario is multiple peripheral devices are connected
>>>> over the same link.
>>>>
>>>> In our implementation, device_for_each_child() function invokes
>>>> amd_resume_child_device callback for each child.
>>>> When any one of the child device is active, It will break the
>>>> iteration, which results in failure resuming all child devices.
>>> Can you clarify the 'it will break the iteration' statement?
>>>
>>> Are you saying pm_request_resume() will return a negative error code if
>>> the device is already active?
>>>
>>> We've used an unconditional pm_request_resume() in the Intel code for
>>> quite some time, including with multiple amplifiers per link, and have
>>> never observed the issue you report, so I'd like to get to the root
>>> cause pretty please. You took the Intel code and added a test for AMD
>>> platforms, and I'd really like to understand if the Intel code was wrong
>>> in the first place, or if the test is not needed. Something does not add
>>> up here.
>> AMP Codec (In aggregate mode) + Jack Codec connected over the same
>> link on our platform.
>> Consider below, scenario.
>> Active stream is running on AMP codec and Jack codec is already in runtime
>> suspend state.
>> If system level suspend is invoked, in prepare callback, we need to resume
>> both the codec devices.
>>
>> device_for_each_child() will invoke amd_resume_child_device() function callback
>> for each device which will try to resume the child device in this case.
>> By definition, device_for_each_child() Iterate over @parent's child devices,
>> and invokes the callback for each. We check the return of amd_resume_child_device()
>> each time.
>> If it returns anything other than 0, we break out and return that value.
>>
>> In current scenario, As AMP codec is not in runtime suspend state,
>> pm_request_resume() will return a value as 1. This will break the
>> sequence for resuming rest of the child devices(JACK codec in our case).
> Well, yes, now that makes sense, thanks for the details.
>
> I think the reason why we didn't see the problem with the Intel code is
> that both amplifiers are on the same dailink, so they are by
> construction either both suspended or both active. We never had
> different types of devices on the same link.
>
> I would however suggest this simpler alternative, where only negative
> return values are returned:
>
> ret = pm_request_resume(dev);
> if (ret < 0) {
> 	dev_err(dev, "pm_request_resume failed: %d\n", ret);
>         return ret;
> }
> return 0;
>
> this would work just fine, no?
> No, As explained, pm_request_resume() return value is 1 for active device.
>> As mentioned in an earlier thread, there are two possible solutions.
>> 1. check pm runtime suspend state and return 0 if it is not suspended
>> 2. simply always return 0 for amd_resume_child_device() function callback.
>>
>> We opted first one as solution.
> My suggestion looks like your option 2. It's cleaner IMHO.
To use option 2, we need to respin the patch series.
Is it okay if we fix it as supplement patch?
