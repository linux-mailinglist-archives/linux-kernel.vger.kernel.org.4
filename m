Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAF682DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjAaNZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjAaNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:25:09 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016104F369
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpuY9K4PNMWO0B4seZMq0d8lSfk0GwKX9FM4r3zNcAwDq9cI4H2QLvaCDHpUAwI1ow4gooHl7LJx7H/K2mJlT0tn91NgKeA5dwjBcycMF3HwjuDYrV8hA8a81Ku5qpzf55V8oG9tcz0L93tyiRn/jy+8zdQ9D2c/v0GOoebo7Fo+Y7p4xyfSk4wbOp1n3WYDIwIoaS0yF5/J0PJY44fHBHMgqz+MwiTkCmEH3D0A4oU9nv26//7cP6J1ZCR7pEI1/tiaFqh3bXOe4Ad0tYVgGOpz8BcYY214Ks2RZZL/ozhvBxXUeowwI3m2CZLE8imAbyyrAM6AIGcSD810RDB8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtUMHFf8mNJJ6S5cg+OuiFCIRJ5m11kmH4rvcmUajOs=;
 b=Aj98ERkfDw9XlvKpxwb7MVxX3CUVpgxdivBJ+UiDCvriQU2wsoXazWyEHhPWa4+yurQ1J50VGmIVRhMKsdGkdB3eQ8Jz3lwEdPngmhRLUe3x4Mo8R2hwq7YblOQPXghRtHHBBRrLdNItXIeU9pwI6IKHc6VE8SdsCutJ+gt9UXxsqy4lWPrUIZ/BUrumXFWiOA52lm/bcMebw9lVhI7OUj8WOOmhsPp4/flkszCfZ5lUybqxrb026Xahch8+JAm3SenWRdrlOdti2DViaGkRYvfPePXOOgwMBQ8ZjVa6qWck934y0rvwlyvajqoUXBL+2+3kLw64Xvhwk9JQw1vUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtUMHFf8mNJJ6S5cg+OuiFCIRJ5m11kmH4rvcmUajOs=;
 b=5HkCCsJhujSNe3nDjawNGDjzLTJ7ATVJQvWB2kHLaEbA2wXXkftj6KMx5VKYkvus4aaNGshMSGvOce8wcV5Skve5zAy4COD2f1GrCHwX5jWwAU6Lk1qEDqes6NTJBR//S5iRHCEiYW3xhW47Pn+qQhfIcL+pTh6k9sDdALPJ3xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:24:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 13:24:51 +0000
Message-ID: <7346e8ea-9347-61ea-717e-1f94cd4750d3@amd.com>
Date:   Tue, 31 Jan 2023 07:24:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mastan.Katragadda@amd.com, arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
 <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fce24b1-9da9-4b74-3a80-08db038e8880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDNtREyGGlpNr3XwZqrmhWof1NugPjUWxRECCix6PpqdkYQL4MJSqirOowBzXAObeG7BOJYLDgCMnAIKyz/jtIxxd+7hCf+6qr4agrJXdw6t7l26g5mSMQ0TghvK+BgTwYXzQreT4LhWDxStPUPhtKKUN5UZ7xusADVSmRfTL+VWfZy7NiQaltBOBbHvhK3YKmku4jZFqxp//63bi1FvF2n8zSEF6J4tXpyjSFjlvPz7s4nDRiMm3RpDaPVOpuRXrODMy3ovy3jtkwPArMs0lDZOLfDMYUh+KHsVh46CQIwFSwLh2eWxnorMo/fkLsk685z0boIiLvofr6bhh9MXCV99NcyYKsgiFlUFIlIr5kEpS/y2hZaQkG2kq7bNfUoZruMpX7opTbky5JQMchzIR2yYZqJ40BItpK6kk/+4s4SHaB+F/vgpzAOSqplOH6zf3yiFudDS3wA7gTPv0PeMZvqRUmv/+7taESEQTgIi3qysa+uAx8mpKm7T3IcdAL8qw+VzWTEJkidYHxojX/TQUqGQ1RNN2OTH7r3j3wAzc+WKsxVeOHQpAbbukskSzRlxppbKtMnww5vJyPCBky/G9pQWBZtpQBTZPB+m5H2Vscp3ZqpfVwu126a1AHX+WGZ7sSGV8HmnP7hRE1bO82joRworUovvzA/9+NpExPXeOMNV+vVCLyX135CR2ddPoSik0T1DKKl2w1dOPrHJPk4BtrbMsjgYhpefDyYQ3UvZPpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199018)(44832011)(2906002)(36756003)(2616005)(110136005)(316002)(54906003)(83380400001)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(66556008)(53546011)(4326008)(66946007)(8676002)(8936002)(5660300002)(7416002)(31696002)(41300700001)(66476007)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1aRDI1N2NlYjA3SkJhSERieGR5TDhlV2NLM1REMldqTnpKV2R0c3NWcjN6?=
 =?utf-8?B?ZEhPSll6UEdqY3phTjZFaXBITkEydmJqeEtDVXJFd21TeTdkK1RhclpXWk5R?=
 =?utf-8?B?V2VkWjN0emtLRmdFR1BtVkMrYk0yU3U3RjFwWW4vcCtDOUVYSUpHb0c5bm1z?=
 =?utf-8?B?d2hEYWFiZmJPNTFUeklwczRsTVRKSm1SR2J1Uk1sOXlONnNaWFR1NnhnUzVC?=
 =?utf-8?B?ZUVEZDNrZ1FMeVNxQlNQOHRpVlVYR09CdGhjN1p0WUxDcnQvbHJxUGlsYXJK?=
 =?utf-8?B?eUc5ejE4NlVvTWgwaEpZNTNPNml6bktjRU56R3BZa3VMd2QyUVlVWDlQWlNF?=
 =?utf-8?B?L0ZVb1RpbDRJODhoeWRDRmpxMDFaMnBRNmdxbTdqQVlkbHZVV05OdGlHSG1w?=
 =?utf-8?B?eDRKTDBLQjhIRE5YMURVVzFMSXVxazZwQW54aFlzVWpuRVlkbGNJY081T3hM?=
 =?utf-8?B?dXVMTGcxaFcweSsvemRVc3crRnZmR1haT2lPMzRLdWJ5SytaNFNrL3NQQzM4?=
 =?utf-8?B?VkpFZm5qcHlVN2xFREpMKzQ3K3dTdUVPY1RKbVpBeGdGR1hxT1FiWnhtVnRy?=
 =?utf-8?B?ZEt3TjhPRkR1R2tTbEZlamhkOWpKS3MxOWRPSHBxVTNhVm1Vc2hydVpwQXFv?=
 =?utf-8?B?OVdCUzhaSTJPVWJYUExsY0lTcU51bG5RdzVjc3FVMmlPS1RvS3JSQndoQjBM?=
 =?utf-8?B?TWpyVEZCU1pzeGJTZG9GcUdvUHEzdEQwR0ZnZUYrOTZ4emkvQ09VSzUxUEZS?=
 =?utf-8?B?Z2J4Ti9zbjF5RlloeVd5anNsbjlQMUU2Qjk5bUNCOHFLZzVUbXhpZ1ZwMkQ2?=
 =?utf-8?B?THBqMTRZdDQ5RVFYSFZTTlpJZWxTemgzZzRobDgwMWVRQUdXNGNiVzNSS0tO?=
 =?utf-8?B?M2drem1hMStrcnRmNE5aOXdMam1McmNVOGl0d2cxdC9hUlljMDNBTmpsOGIy?=
 =?utf-8?B?MVlNKzNTQ2hJa3FPWmpzVVVPUllhQVlxMnlIOXFFRy9QY0thcHMyQlVOQzQ4?=
 =?utf-8?B?M0dmcGNjNCt6dkhvaGNJSVlqaHQ3YlpMSEUxc2pRVjRaMWhMbk81R1IvdUlY?=
 =?utf-8?B?bkVJSSt1TmJ2TkQ0UjdFblVRclErTDUyVitid0lONUp1TVNBcm91ODNhbXFa?=
 =?utf-8?B?YW00eUpBdmZkWmtzT1VwejN3dm9yOU5GcVgvenBReFJPZDUrc1pxcTE0dE1L?=
 =?utf-8?B?QWxPcmxJVStYcVhVUTByakN2aUI5Uit6NFBORENiSnJlTmx6Yy9hV3hyNHVy?=
 =?utf-8?B?cFEwSlAyQWl3RVhlOWlXM3YwSEpGZG5aMTVaUjZQMnl5N3FNZ3Z6NnJBVFg5?=
 =?utf-8?B?Um5xSDRSajN1Z3c0eWVaTVFVNDN1amhvMXpFbmxjaVdicFVVVDQyY3hsaHFE?=
 =?utf-8?B?SXU5cDN0TS92UkRpWU1SQjdRWjJZWks0bUViWHdhNURsdERlYkQvQjZOYkt0?=
 =?utf-8?B?Z2xScjlnRDVxNmV2Y29DQTJNeG1wUDRiZm02NkRQQ0lVRzlPdHYzQTI1ajBH?=
 =?utf-8?B?ZllFeFhOOWt0R043N2E4aHE3dnNlS1VEbUE3OTZuREE5dnZaeXpwa1lzY1VY?=
 =?utf-8?B?blFiVS92TUlEdGtZMUhqKzRFMlkzZkNvdXJDamNSYXk4Y0JZUVNkTHZtV1pI?=
 =?utf-8?B?aXovZDB4SnNCbHYyeDB6L3FDMVRzQWNtbWY2SjgwSFhjanowZnE3aHJ4cnJz?=
 =?utf-8?B?R2RUalo0aXpMdVlFRndoZFpGbkVOSXhoVFZMaGxaVkJYNXp2RnUyb0tYMVhz?=
 =?utf-8?B?T0plczJnc210WlJYNHdwaW9YaEN2WGI2Zzc3MXpBMW1HZmhLZ3ZJQ2tSWmNa?=
 =?utf-8?B?UjZwSUJMWllFNUU5UVZ6OExsM0RnNVBDbi96VDdmTkhjS01MbnhoYUVCeWFZ?=
 =?utf-8?B?M3NsbERFdGtFWmJ6Wkh3VGZrakNManlyNmN5VVhrUU9hV2IranQyME41SER2?=
 =?utf-8?B?NFYwTnNGV3lyM2o5eWlrV1hlckR6QXhvUlZhSG8rS2VlR1F5NldKcDVPamMv?=
 =?utf-8?B?ZUxhQzJPOUExbG1mUnAzbXFZYWlYbTIrRHlHTytSTHZvU2JtUlgweDVaSzVJ?=
 =?utf-8?B?WjZWTk10a1lrWmx4ZXJlOUVlWU1lcjJySHVZUjNtdk9qNzRKeEJ1dk9oTWVB?=
 =?utf-8?B?c044T21RSzM2QlhnQ1BEVjlnMlM4Rlc1bVhjZk41VmJEVUZCZVNmY2ZSSUhO?=
 =?utf-8?Q?/TbYYeBPsyipkhTEdabXsB9r6BP2N0/epo6EQrKLQSou?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fce24b1-9da9-4b74-3a80-08db038e8880
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:24:51.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIo0FNurSLdvJQYIm6NNQCL98TcFhn/QvqjYWXsrTyxxAN29bGRIyHWcsxX3bBYMgcQ22L0agGtTUdjhta7e3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 07:09, Mukunda,Vijendar wrote:
> On 16/01/23 13:32, Mukunda,Vijendar wrote:
>> On 13/01/23 22:41, Pierre-Louis Bossart wrote:
>>>>>> +		if (is_dmic_dev && is_sdw_dev) {
>>>>>> +			switch (acp_data->sdw_master_count) {
>>>>>> +			case 1:
>>>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>>>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>>>>>> +				break;
>>>>>> +			case 2:
>>>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>>>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>>>>>> +				break;
>>>>> so the cover letter is indeed wrong and confuses two controllers for two
>>>>> managers.
>>>> ACP IP has two independent manager instances driven by separate controller
>>>> each which are connected in different power domains.
>>>>
>>>> we should create two separate ACPI companion devices for separate
>>>> manager instance.  Currently we have limitations with BIOS.
>>>> we are going with single ACPI companion device.
>>>> We will update the changes later.
>>> Humm, this is tricky. The BIOS interface isn't something that can be
>>> changed at will on the kernel side, you'd have to maintain two solutions
>>> with a means to detect which one to use.
>>>
>>> Or is this is a temporary issue on development devices, then that part
>>> should probably not be upstreamed.
>> It's a temporary issue on development devices.
>> We had discussion with Windows dev team and BIOS team.
>> They have agreed to modify ACPI companion device logic.
>> We will update the two companion devices logic for two manager
>> instances in V2 version.
> After experimenting, two ACPI companion devices approach,
> we got an update from Windows team, there is a limitation
> on windows stack. For current platform, we can't proceed
> with two ACPI companion devices.
> 
> Even on Linux side, if we create two ACPI companion devices
> followed by creating a single soundwire manager instance per
> Soundwire controller, we have observed an issue in a scenario,
> where similar codec parts(UID are also same) are connected on
> both soundwire manager instances.

If I'm not mistaken, the specific failure in the Linux stack is because 
of the duplicated sysfs files since the same UID is used on both manager 
instances, right?

At least with how the kernel handles it today I don't see how this 
should be handled.  You can't disambiguate between the two different 
ACPI devices when they would be identical unless you had another property.

> 
> As per MIPI Disco spec, for single link controllers Link ID should
> be set to zero.
> If we use Link ID as zero, for the soundwire manager which is on
> the second soundwire controller ACPI device scope, then soundwire
> framework is not allowing to create peripheral device node as its
> duplicate one.
> 
> If we want to support two ACPI companion device approach
> on our future platforms, how to proceed?

 From my understanding I would think this should be an exception for ps 
platform, but this should be discussed for a future spec revision.

Maybe in a future spec revision another property can be utilized in 
conjunction with ACPI device to disambiguate this case.

>>
>>
> 

