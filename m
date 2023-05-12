Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABA700825
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjELMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbjELMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:34:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659BDC5D;
        Fri, 12 May 2023 05:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCoimwzjfctEjhBx980GEAm0yCMWx3UqLsghtAWLsmEQaQKG+XdgF298ervlC7vxz+GxCZKtIfRAel+1fig4U7O0SbYRXhd/4CInbjU/Llnis5ipLJY4eV8TJnqriphLybFSscETiG5wdDZdsmRr9C7+J1QSMk9xACNul5eA56ZDP/d21g4sfOWF0TewAcf/7nc2Y+7Nm/JcPT/Gf/fgzqlJdBweC976L9xpCD4MDl3vriPlAQ90cRpjMsL4v3hEB90mCI+wV8418YLHZ1aB+QNWf/FcAtv/nP12fRJMyYrXOlOGJ4fhuOu3BrDgBJFrNjQaR4GT06s3DAj74HI0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxNcIf58JYx9JHfMH00fbfgo1saldDfgyrM+uALKSYU=;
 b=ExWeAnH8FDGemXJ2KZNBkhOoVsvfcFJ0a+wcZCJflnR8qlmZmaqaOLCesPVvFzDYde2SYlfuLzAlFxenUJtbN1Ry+2+LNGbtnDKC5ozMYf6UCHmgZQagp3pRjcv7dPWWNqxnd1t1pXXu6rFC/VcKJHi9Xh+mYfDA1W3Ov4lejhXWrjrcFYkfFAe2zt6w6R9ErnsxhTrYAey+e3FykdGBpSsOHY6JBv7yLMoOVGBkPALvKDrF0it9JVaBV0GAxQ7xiRARHbiTdkgvZR5M8UI8mLPhTQf1cwSuClAgUijr4SET1lDH4gFdbgZM/ahHF8xEgZiIvXamD/vqZv28Mmes3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxNcIf58JYx9JHfMH00fbfgo1saldDfgyrM+uALKSYU=;
 b=j5b4S7/MoEB1s1n25Ykf+GmsNLc4AH9zOItAl6F4EzEQyS74oz0zMveVLSPn6uwhSFYBi0dj2LiPIj143+t8UwzWoLmmK+HGTzFd+scTzXxPkyKuL6xRjB+MeJrJ6zJk/7jyGe4RahkFqvKk7hDG2LDpWbJrcQmLw+YJ+ae5pJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 12:32:40 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 12:32:40 +0000
Message-ID: <03faa36d-d444-593f-c814-40eb865e9f83@amd.com>
Date:   Fri, 12 May 2023 14:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVeY3jVNfAkW1G9@e120937-lin> <20230512083805.GA3424996@EPUAKYIW0A6A>
 <ZF3/Ge4b+49ni+e6@e120937-lin> <20230512123059.GA3497038@EPUAKYIW0A6A>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230512123059.GA3497038@EPUAKYIW0A6A>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 034925d8-f9ed-46e1-4ffb-08db52e4f9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBlxGCNAiaf3OlBljC/8cwaL2h8sD1RlX3AlHtEtFQRdRnTMEAHh0USVIia2waWkfzndiMRaHE62yOmfhpWFRV0YKddWS8LQ/VO8bgY5oRRGj2ON9E5fxhJiNV3diHZDIhdf+AAs5r0H4dDF7nNnmwNbFI2GDoijrOnicFvqNX/yI5lbDRte356UHD+bs8tx96RwqpUpiYUJ23ccJ9Mx3fJe3CkLzIZbtRptov7UAa2IEKGAoK3RpiIQl4C85O5gvpqAl0TzyLaJmJRRbZCpwsraq2RWdAX7+erONF/JAAHhZvdrL6UDotIRNY0QbYce7gtnSbqnR7hGxwKTf6pNu7xtqqP7m9z3CIxat72zgUGK0kiP/+5vEL+CfCjuhB5tlfsO/XZ1tPVG26H0EHWTTTFM727pnHU0n9gqGgQpYoc748JJuTl/RTRtyLKeHmP+o0ZfMWZipN7Tln4PfFHqaq6yDB+9kh8u/WCChu1FJHXeqwJhMoPB5Egbo8G/MSnOnajkX4u7pGhnlTCE4OxcoqsLpmc268FW8PNY9W2jvUF3j2ZbInYDXvj2PJ2uP4MHdU3YWsS4AY1a2HsEhj7DYg5oePb9q0G7ISukcAvryqRUox53UtxQTcOnYKb/jNfRjSpwEeY2X1Q3n03etwawlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(2906002)(86362001)(31696002)(6486002)(6512007)(26005)(6506007)(186003)(478600001)(53546011)(36756003)(5660300002)(6666004)(44832011)(83380400001)(38100700002)(66946007)(31686004)(66556008)(66476007)(4326008)(2616005)(316002)(41300700001)(54906003)(110136005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRGaDFRM2Z3S2t6QzhsZ2tLZlJLelF5MndEVVorVHQxZ1RZUGVkN0pLSE1J?=
 =?utf-8?B?ejNDdW9zM2tNVmUySVIxS2ovd1lLTHkyOU1laEVzUktNbkdOT2dIVEY0OTEr?=
 =?utf-8?B?ekZOcmlNazZHcHpVdUlzdkxSVnpUZVVXbmVGall0Q3R6R3NwOXBHRUxXQ3g2?=
 =?utf-8?B?MjBxWEVDSkNlVTBEYmZwYjY5bFdoZmtyLzhQNHhqTUl3a284MmdUUUl3V2tD?=
 =?utf-8?B?OE5sUkplV2YyZ0hJZnMzd3JoblB3YWdjS2Zzc1NBMjVYNHZwazEyNDJaNnVH?=
 =?utf-8?B?T2s3cDdCUGl6QlVwenZUcjRVMzNHVG5KbWlRUEhVTFdMcWpqcXF2ODFMUnZZ?=
 =?utf-8?B?emoybDQzTEFra0QzM3diSnpMNUdxL04rendCcmh0Sm5UWDFyWUdNRWdVTXpM?=
 =?utf-8?B?RGp1b2VXbllDWm5rUzFsRmgrVEVWYm9OM1dTU1JRczh4WXZFSG8rUHowSzFk?=
 =?utf-8?B?V2NLc1dEeHR1TnRSS1ZseEorQWJ2M05OS2tMM2l3Nit2aVBQZDFRQ2hqMDFZ?=
 =?utf-8?B?TnFWaEw0d1NNVElBMHlRS0tEamRKSlM2cW9uZHN4aG1qSDE1VHVZdjhXdXdk?=
 =?utf-8?B?QWo2Y1UvZHBjbElsQ01JN2FUNVBOc0s5STJmbHVaM1FqcmlWRXl5UWJEaUhK?=
 =?utf-8?B?TjVKSXQxRUFlaUd3b2V0WVhXMkg0dXpxWDRTTVFBanpmbnI4OFVzb2g5eFZF?=
 =?utf-8?B?MVF1bi93K1dqTDZ1aHpHa2hDZyt6ejR0MWxTVkEyVTVidEQrZDB4TEN2Rk5r?=
 =?utf-8?B?Q2NrdUMyckhoZ0tCZ0xkSktQSkM3dWM4MUVRNmpubW5FS21SdkFaTGgvdGNC?=
 =?utf-8?B?Q0I1dUl4bnkxMnRacklwT1BuU2QyK2t6UTRWRVdzNjJ1U00rYlNRazBiZ1BC?=
 =?utf-8?B?Qi9CSG0wSS92Z09QOVVyR2F0OW1jdnl0QVNTNnVFQm1CMllGLzFtcjB0S2Iw?=
 =?utf-8?B?UE1KMnBsaXdDTkZ3VUxhYWJYc3RVTE5WdEZSbkVEbTNzQmZ0U1ZYTk9zcGtH?=
 =?utf-8?B?bzEzQ1p4UEpmR2JDbktFVTZxSWpWbnRnazBIQlpYcmwyVEgyZW1BUi9UQ09w?=
 =?utf-8?B?R0tVbEI2aXI0dlg5RnhFZVhUcytrSVJQNmI5K21Cc2pjSmlic2t5S1FlYnU4?=
 =?utf-8?B?Y0g5OXFuZkFHaEU4RmJsYzV6UHdtc3V3c2FwT1BzNWpCd1dWU0NNZTJ6Q05p?=
 =?utf-8?B?TkFadXZWbFlWdWluS0ZkOS92MzJlUnB6UXFiUWxsaDdOWnV0dTJIWnRFOXBm?=
 =?utf-8?B?OUZ1QlkwZmVnazNrdmlMTmxraUZ4eUpVdzJ0aWZ0QlVZL2JSaUhtSzQrakdU?=
 =?utf-8?B?d2xHSzdsRmlvaDFXeVdZU0VNY0FjOTlHZWQrMHpUMEFYdDl4Y0xLN3E2VVhJ?=
 =?utf-8?B?RGpHcDl1M2xRWmhNekRsNVVVSGdsd3JobW9VRUphTWViNzY2bXNENXZTM2lr?=
 =?utf-8?B?YUpFaXZONGhpcW10RlExZXJMc0FlYlBxMjJRZi81ck1CWkdlb2ZZVTlNRm1k?=
 =?utf-8?B?cFBwcm92a2hLTllmQ1FGSXF3RFlrM0JmeWQ5UDB5QkZSdm11MDBJNnVTcXZI?=
 =?utf-8?B?VHFsU3BmUU1YZXA4UzU3WDNlb1hVN0ZIVHVwWVlHMWdjS1dCdjN2YWlaV3Y3?=
 =?utf-8?B?QmlORktmcFlQVWM1V3IxNmhEMnMyR0NsMGxXMm5wWUU1dGJML2lSeXVCVHdp?=
 =?utf-8?B?Z216ZzlBeHlBYWd2SjNLaUZFWm1UV0FjRGNPL1ZHV1RKcWlLSEp3ZWI3NjJI?=
 =?utf-8?B?ZlZMTHRHQXVzeld1VytIMlNiWmNQdDZReTVuTnEvdjZnMU5rL2VxS3VaQ1do?=
 =?utf-8?B?K0h2WEwvb0JFMnpRYnlzTERUajlROFIwMDVEL3Z5MUdlTnRIaG54S0pXQlpT?=
 =?utf-8?B?OVNlam1McEZmRnhwR3VaQm9MSkJqWGpsNnRWdEovM3Nlc1ljMTRzUVhsMlVU?=
 =?utf-8?B?cVdMTGs1VnozcHp3RXEwT3ZIUzFZUVRTNi9PNlQxZDMvTlBpc1IvMGQwbnZP?=
 =?utf-8?B?SS9SMEZVWEREcmV2Q3JEc2hNNUxOblhYNUQxek1hK2JSQWRXMGZjMmFPYmtZ?=
 =?utf-8?B?L0twQWhCdWpzRWpPSG5SY05YUWwxNndoby9vT3UxQ3ZwOXJSTy9mdGI3UlB4?=
 =?utf-8?Q?RI9csmgX95Z09GQtsc6Q2QMcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034925d8-f9ed-46e1-4ffb-08db52e4f9b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 12:32:40.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDQZd+qVfd/DuIdshRDKtylZXL05S0rQ1Us8FqCbeR8lX01mhHVlhvXAjLv5z0UI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/23 14:31, Oleksii Moisieiev wrote:
> On Fri, May 12, 2023 at 09:55:53AM +0100, Cristian Marussi wrote:
>> On Fri, May 12, 2023 at 08:38:06AM +0000, Oleksii Moisieiev wrote:
>>> On Fri, May 05, 2023 at 08:52:03PM +0100, Cristian Marussi wrote:
>>>> On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote:
>>>>> scmi: Introduce pinctrl SCMI protocol driver
>>>>>
>>>>> Add basic implementation of the SCMI v3.2 pincontrol protocol
>>>>> excluding GPIO support. All pinctrl related callbacks and operations
>>>>> are exposed in the include/linux/scmi_protocol.h
>>>>>
>>>>
>>>> Hi Oleksii,
>>>>
>>>> Thanks for this.
>>>>
>>>> I tried out this in an emulated setup and found just a minor issue from
>>>> the spec/functional point of view...then I reworked the extended names
>>>> support using a modified hops->extended_name_get helper (as said the core
>>>> SCMI support needed a small modification to support PINCTRL): I'll reply
>>>> to this mail thread with such core SCMI modification patch, so you can
>>>> include this patch of mine in your next V3 and use it in your series.
>>>>
>>>> Moreover, given that I wanted to test such rework of mine and a bunch
>>>> of other cleanups I did (as detailed down below), and it seemed silly
>>>> to throw all away just to then having to detail all to you, I'll also
>>>> include in another distinct reply the raw diff of what I changed in
>>>> your series to use the new extended_name support and a few other cleanups,
>>>> so that, if you want, you can just quickly merge that into your V3 patch
>>>> (of course if you like it and tests fine also for you...)...these are
>>>> small changes, if you take it, no need to bother with authorship and
>>>> attribution from my point of view.
>>>>
>>>
>>> Hi Cristian,
>>>
>>
>> Hi,
>>
>>> Thank you for the patches. I've applied them and tested with powerpc,
>>> mx68 and clang environments (as test-robot complained about).
>>>
>>
>> Yes, sure, they were just tentative fixes, needed cleanup.
>> I forgot to add the RFC tag on my proposed fixes to avoid triggering the bots.
>>
>>>>> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>>>>> ---
>>>>>   MAINTAINERS                           |   6 +
>>>
>>> [snip]
>>>
>>>>>   SYSTEM RESET/SHUTDOWN DRIVERS
>>>>>   M:	Sebastian Reichel <sre@kernel.org>
>>>>>   L:	linux-pm@vger.kernel.org
>>>>> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
>>>>> index b31d78fa66cc..071ac65f22b9 100644
>>>>> --- a/drivers/firmware/arm_scmi/Makefile
>>>>> +++ b/drivers/firmware/arm_scmi/Makefile
>>>>> @@ -3,6 +3,7 @@ scmi-bus-y = bus.o
>>>>>   scmi-core-objs := $(scmi-bus-y)
>>>>>   
>>>>>   scmi-driver-y = driver.o notify.o
>>>>> +
>>>>
>>>> Do not add spurios lines.
>>>>
>>>
>>> Thanks, removed
>>>
>>>>>   scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
>>>>>   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>>>>>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
>>>>> @@ -10,7 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
>>>>>   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>>>>>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>>>>>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>>>>> -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
>>>>> +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
>>>>>   scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>>>>>   
>>>
>>> I've applied patches you provided and made a small fixes. I'm going to
>>> make patch:
>>> "firmware: arm_scmi: Add optional flags to extended names helper"
>>> as a separate and squach "Misc Fixes and refactor" to my changes in V3 if you
>>> don't mind.
>>
>> Sure, that's what I meant: include my general extended fixes at the
>> start of your series and just squash the misc_fixes (additionally fixed
>> by you :D) in your series.
>>
>> A small nitpick I noticed later in scmi_protocol_ops Dox comment
>>
>> + * struct scmi_pinctrl_protocol_ops - represents the various operations provided
>>
>> should be
>>    * struct scmi_pinctrl_proto_ops
>>
>> Thanks,
>> Cristian
>>
> 
> Hi Cristian,
> 
> Thank you very much for your help and your patches. I'm in the finishing
> line with V3. I'll send to you the unit tests (when I fix them to work with the
> latest changes) I'm using to test my changes and driver for ATF.
> Hope it will help you to test your environment.

Is that ATF driver available somewhere?

Thanks,
Michal


