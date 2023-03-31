Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7246D29EF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCaVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:24:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D997690;
        Fri, 31 Mar 2023 14:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTQjrBkAbcU0ZflNqWqPiMw1Eq3V64hVkFyzm6dp156CjCFav1W6wI1s/MbZs35jbwCTbfHSsMC3FEzwxn4CNBkOHVSwCbIhjSVZVYkLSQJnOenQHlCG6LhO21TkVXYcycd0+e5GGhnfBXoF6nvnSW3jqNk40JEesK9uygXyqV2+R8ATNcBBjKGYPy2U4sKQOVB9diRBMHje7bAa4eqpxFxrbp3f57RulszGFI1c3HTr/9Y1Rw7YIBXncYEoCTT4cmfILTbM+S6knwhT3wxo/7UQRWyseXJGZTWDamBBapmN6mX5nZHe5Uhfs1v9nqWhod/JnJjkdixJzeMFSJGPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy53z8ZAUvxHNUTCID2hvKCNEIDcmqcSNbvTzl5DJ3E=;
 b=Pf9vs/TsXbcj2ZJT3ZOwih02tmAubG/CL6pmaGVzK/qZZDKQEQhJCAmsKIHkN3SbzqONtAmi1C5wxoCcvyHFf5dKhDjgbMleAdftk5lvZde9sV3+Gm6syOGlRKb9CV+fwZbVBGqLmtOxEVjAckQ6oSxvuqtzeA3fT8l02EhDmBn0ZX9GayL4/U447Ziksy4kTlyIzj9gTXALb672LBYWDgeJaif1WO04JKFc1WiaPrbYgnPfigqLf39kgeL2HBt83zHwssMvpioRffs0C0Vo9nXjqV45QWFLXeyzTN0LsoK//ipuxplY8lmom6L52KuJS7Q0IaqZvKn8FpU8unctjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy53z8ZAUvxHNUTCID2hvKCNEIDcmqcSNbvTzl5DJ3E=;
 b=bhxLemsj6qV+ZUSnco/Wx9Uwo4zWIyQSxiUClhAL3UIMZ2V/Qp55uhdgOzhaOSqVN3N8ud9SSwol3k2ruAl3o8SVm0YdqZ4XvYYRnqpk50g+lkH5L+b/fDGF/Kk7VGDmIgSpggzS/mSf8YdQkOr45lS75LMsLMqRJcu3zH5cCU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 SA1PR01MB8250.prod.exchangelabs.com (2603:10b6:806:38b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.12; Fri, 31 Mar 2023 21:24:18 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::4146:8d44:30cf:a3fc]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::4146:8d44:30cf:a3fc%7]) with mapi id 15.20.6254.020; Fri, 31 Mar 2023
 21:24:18 +0000
Message-ID: <a69dfdc6-31da-f813-858a-fdf246dea4fe@os.amperecomputing.com>
Date:   Fri, 31 Mar 2023 14:24:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V2 3/5] coresight: etm4x: Drop pid argument from
 etm4_probe()
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
 <20230327050537.30861-4-anshuman.khandual@arm.com>
 <d995fec6-1d3f-df37-724e-67d929e9e0db@arm.com>
From:   Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <d995fec6-1d3f-df37-724e-67d929e9e0db@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|SA1PR01MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e5f3df-68bb-4209-83d9-08db322e496f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVRlDEehiLgr0ekT4wuMq+fdfvHHUAK2vIChAGvHCmfMBU0SuYb6njRmOczlJGmyVL9uabgc8HqsJCJkhYXm1YPp4jOfob8oBi5ym1+dhJrJMbxZ/mrWnbjsS0n32gMWVcalM1/+EZh4TYrdEhnjf45HX8Sq9S2odaAq+DUWSnK7pcW4qwPVDNhJj5QWNqJ7DQtu99nH+pXJShRLTAfdSAjUF5sU/wsDbmmNmc0shuP8wmu4D2BXaxaezJwrIaeWjdkjkA3/x7hWO5rGqA6Az9ZdkAfiZ3IiUC0silATFWyqpAr9G8KjbP2xBuo4VNq883cywPaGUjvqF5FkoDYWPV8q7mdHd6elm/ahprPSb0xJNfDBufsjcNL5EEtuJvt3Rvb3dWEJheqBBm6NmliQXNjjap6wGK6bkcfAFKqmXybsmB7Y3KPuQrtTx8p94V/YdbUllYlm4hCNDPRS8zziQf9coURS4rzpRAp8UVKDWslmwAMHbX3mLBVp00x9kgFluw7CnSf9sO6QxZ/iH8KTpxX7Y8ZaQOFGDBm7qhLDgSE/6Dlqu/kyEh9loy5R+0Pw2E7ukaH1yECk11smUTrFYSQ8TeLO9+ROyDk+uKLigh+6MwnvWmyrILc3L4P5pLEjjfbRf1V4yWAn/8fUZrL4SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39850400004)(376002)(396003)(136003)(451199021)(31696002)(86362001)(31686004)(6512007)(6506007)(26005)(53546011)(6486002)(36916002)(6666004)(66476007)(2906002)(66556008)(66946007)(4326008)(186003)(3450700001)(110136005)(7416002)(41300700001)(8936002)(8676002)(316002)(478600001)(5660300002)(54906003)(66899021)(38100700002)(83380400001)(2616005)(32563001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVRTmVyTGlFNVZkb3RvRFVMMnN1SzVXZ3hFMFN4a1dQS1lVSEJjRy9LaVNP?=
 =?utf-8?B?cUpneGxGOHVzaDBuSndIRWNRdU5zUTliVG13bXRlM0RBWGRjczZXL04rZWxk?=
 =?utf-8?B?dHEraFBZWi85TW02VTJINzQ5OXAwNUtidkxRZzdWdjBLUVdpSjNHTFkwRW8r?=
 =?utf-8?B?eXQ1eU1LWWV6TGp1UFRyb3FsbUVmUkMreEkwNlI1N2dxOWZlbllhcndhN1VV?=
 =?utf-8?B?Y2ppb0hsallCSGlOemN2bmZ2cThMbGlKRVRVWmE2c2hEVXBSL1dOUjhpUmZo?=
 =?utf-8?B?bFM0amhhTVlJVkN1aWk5bTZJU1pQSGIzMndNelpYZGNlZWFYZnRIOWFSR1ZV?=
 =?utf-8?B?bzg3T1BTU0k1VExoSGk4clVsRVhYV2JOL3Ria1F5VHJNbENXcUhvVVJqN2I1?=
 =?utf-8?B?bk5YN2l2cUxaK2pVTm9CSW01SHduZnJ0UVU5TGpCazhEd24xRVhHaGpVQ2g3?=
 =?utf-8?B?RzQ5NHd1QU5mYUZtL2JjT1NYSkN0OGdxSW5jdVFTUTBVdFBHdzR5dngvYXJj?=
 =?utf-8?B?NjZydlNqT3FCeVd0VW81eEhaQW9XMit1WVpaTWIrQ2VhMWJRQ0VtRmdKdlpU?=
 =?utf-8?B?ZlVTbW5VL0JIdXRYRmx3a2JsSFRvdFcwcmlCYlh0WWsxVGhVVXlWUnRJaFhn?=
 =?utf-8?B?ZHREcDRMeVR2ZU9xczdsVE5aNHUvMVVMMnAybzNYRG5vMFptZnZtbERBb1F4?=
 =?utf-8?B?dGtkVWVMdHNPYzdNUEh1N1lkNzVVOFFycmhoUkxIa0JUdTVsV2pBYmlxYnlQ?=
 =?utf-8?B?V3ZUVXh4cWtOZ0ZTS2dzQnh5Q3krcU94SEd6aU1iSU4zSWE0dThnQm9rOU12?=
 =?utf-8?B?QU5Zd3F1c1YxZ1p2VlBsUk9qTzhOUDkySFNBZmV0Y3dGVkwzOWxLOEk1dmI4?=
 =?utf-8?B?R2FJSVY2aHpvamZEVEFnd2pEY2lPYkJxbkZ1dnU4NDR4dk1KSG9HR2gvbXNH?=
 =?utf-8?B?cHRsREFoYUZYKzl4QStFaGw2RFRSVjFSclo0cGdkWGhYYXRSeDRQL2JnNkdM?=
 =?utf-8?B?RmJ6dUdYTG1KSHFlcVo3blF2enpiZFg5dkFFaUFRN09jRHhRVnN6UTVTUzhY?=
 =?utf-8?B?REFzRmpGV1M0OE8rQzgrZGZOTDF2M2YrV2FVQmdualg4VDdrL2ltOCtieS9G?=
 =?utf-8?B?d3JvZG5PNE5NVXd0L0ZDeVlWcTliS2NxNi9oMFkyM0d2UHJwWGE3OTlKNUl1?=
 =?utf-8?B?a3ZMUkZQMm9WNURGQXNtZzl2Z09VUnQrMVRsU1JPQ3E0MXVDb0VabjdIVTNv?=
 =?utf-8?B?c2hlLy9pU0JNZzBXc1FmVkllcUlKQWd0R3M3TlZSaURxcFpRbEkvUFZwOWpn?=
 =?utf-8?B?VmZEQThwSExWeGV1eXJDbXZ0TlBMWkUzSHRSZ3I0YjdXYUtTUWtWWmNJbmwz?=
 =?utf-8?B?WHdIeTdHbFFYSjVhdms0VFhNWmFiRDFSNUZ0VE0zQjA0YUtIMzI1YlFEUlg4?=
 =?utf-8?B?YWNLTG5IWXZXdTI1YXZxeW5VMjRwMkdVNG1CYzhyT0dGL1lRK1kwVzdhRGg0?=
 =?utf-8?B?QWNiRkJUOUhtTjZSK1hkUnZuSUdkb3dvamkyclJMNG5TV2FOTmlGQzhJTHhm?=
 =?utf-8?B?amhyekJ1S1cxWmZuOWRBcGN1WVp1UUVrcForditnOS93RFZuSnZ3Wi90Q3pp?=
 =?utf-8?B?eWt6QkRJR29hREIwNURUV0k4NFVKNFl1YjNTWUY3bXV2MzI5dnN3YXJPMEtv?=
 =?utf-8?B?dDhaMDVFWjgwb2FMUFN4SXdTMlJ6QXRSV0pudFZWR2JtYnlmL3VHbW9VUlJs?=
 =?utf-8?B?YTFsTjkvOW5Yb2JKTUxncE0wWjJQanp5T2JyZm5EUWhRNXJna2VNVHp6MXZI?=
 =?utf-8?B?bFd6WXJnSWw4NEQ5TTZvai9OUVIxNmNHVmhnS1p5bWlOVTdhTTlUSktQT1g3?=
 =?utf-8?B?YXgvWjZYaVJwUXRKRmk5elZHU0o1Rm1ESC9zb3k5VE5mUWxvdU5GMXMwTmtv?=
 =?utf-8?B?RDErb1M0azR5a2RZSS9hK2RndDVyQXhBZUpwUGlrYVYvSzRKSXdLSXEvUEhO?=
 =?utf-8?B?NURLY3h5SEp0ZnZQYjNWTFpnNHQxWEZLYjRQcEVtV1FvRFYxMml0NXBBZ3ZJ?=
 =?utf-8?B?WG1laVkzTHNRQVZrbU94clFueE5YaUZ4YjlaSXZqQnZiaFp3TU5GaVZUWjBM?=
 =?utf-8?B?OFZ2WlNDSXp6amZHSFgyaGM0VVkyaFNRcWpySE5QamRrWk82YWNEbmY0RFlr?=
 =?utf-8?Q?/RzwzTMtjqlbDlG5lyWIVpA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e5f3df-68bb-4209-83d9-08db322e496f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 21:24:18.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XShx+qmFYbEyJpZLDOMIgTCqQT9N+gZOnneYcvREE1JwIci35Yw9IdpWcAbVIbuoLh6x3lsCBAoj6+3bdD8thIVLqHKYAcZEfEYfzLUzvWh850JYBtAQjhC8cphJmBIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8250
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 4:06 AM, Suzuki K Poulose wrote:
> On 27/03/2023 06:05, Anshuman Khandual wrote:
>> Coresight device pid can be retrieved from its iomem base address,
>> which is
>> stored in 'struct etm4x_drvdata'. This drops pid argument from
>> etm4_probe()
>> and 'struct etm4_init_arg'. Instead etm4_check_arch_features() derives
>> the
>> coresight device pid with a new helper coresight_get_pid(), right
>> before it
>> is consumed in etm4_hisi_match_pid().
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 21 +++++++------------
>>   include/linux/coresight.h                     | 12 +++++++++++
>>   2 files changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 5d77571a8df9..3521838ab4fb 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -66,7 +66,6 @@ static u64 etm4_get_access_type(struct etmv4_config
>> *config);
>>   static enum cpuhp_state hp_online;
>>     struct etm4_init_arg {
>> -    unsigned int        pid;
>>       struct device        *dev;
>>       struct csdev_access    *csa;
>>   };
>> @@ -370,8 +369,10 @@ static void etm4_disable_arch_specific(struct
>> etmv4_drvdata *drvdata)
>>   }
>>     static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>> -                      unsigned int id)
>> +                     struct csdev_access *csa)
>>   {
>> +    unsigned int id = coresight_get_pid(csa);
>> +
> 
> This throws up the following error on an ETE.
> 
> ete: trying to read unsupported register @fe0
> 
> So, I guess this must be performed only for iomem based
> devices. System instruction based device must be identified
> by MIDR_EL1/REVIDR_EL1 if needed for specific erratum.
> This is not required now. So, we could bail out early
> if we are system instruction based device.

Besides this, the PID is limited to (I think) 4 bits of ID. TRCIDRs
offer revision information, but nothing manufacturer specific save for
the designer. Register fields like MIDR_EL1 Variant + PartNum + Revision
and TRCPIDR3 REVAND offer help. It may be a combination of registers are
needed for a manufacturer to adequately ID a part to apply an erratum.
Perhaps you could at least cache MIDR_EL1 for possible future use?

> 
> 
>>       if (etm4_hisi_match_pid(id))
>>           set_bit(ETM4_IMPDEF_HISI_CORE_COMMIT, drvdata->arch_features);
>>   }
>> @@ -385,7 +386,7 @@ static void etm4_disable_arch_specific(struct
>> etmv4_drvdata *drvdata)
>>   }
>>     static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>> -                     unsigned int id)
>> +                     struct csdev_access *csa)
>>   {
>>   }
>>   #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
>> @@ -1165,7 +1166,7 @@ static void etm4_init_arch_data(void *info)
>>       etm4_os_unlock_csa(drvdata, csa);
>>       etm4_cs_unlock(drvdata, csa);
>>   -    etm4_check_arch_features(drvdata, init_arg->pid);
>> +    etm4_check_arch_features(drvdata, csa);
>>         /* find all capabilities of the tracing unit */
>>       etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
>> @@ -2048,7 +2049,7 @@ static int etm4_add_coresight_dev(struct
>> etm4_init_arg *init_arg)
>>       return 0;
>>   }
>>   -static int etm4_probe(struct device *dev, u32 etm_pid)
>> +static int etm4_probe(struct device *dev)
>>   {
>>       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
>>       struct csdev_access access = { 0 };
>> @@ -2077,7 +2078,6 @@ static int etm4_probe(struct device *dev, u32
>> etm_pid)
>>         init_arg.dev = dev;
>>       init_arg.csa = &access;
>> -    init_arg.pid = etm_pid;
>>         /*
>>        * Serialize against CPUHP callbacks to avoid race condition
>> @@ -2124,7 +2124,7 @@ static int etm4_probe_amba(struct amba_device
>> *adev, const struct amba_id *id)
>>         drvdata->base = base;
>>       dev_set_drvdata(dev, drvdata);
>> -    ret = etm4_probe(dev, id->id);
>> +    ret = etm4_probe(dev);
>>       if (!ret)
>>           pm_runtime_put(&adev->dev);
>>   @@ -2146,12 +2146,7 @@ static int etm4_probe_platform_dev(struct
>> platform_device *pdev)
>>       pm_runtime_set_active(&pdev->dev);
>>       pm_runtime_enable(&pdev->dev);
>>   -    /*
>> -     * System register based devices could match the
>> -     * HW by reading appropriate registers on the HW
>> -     * and thus we could skip the PID.
>> -     */
>> -    ret = etm4_probe(&pdev->dev, 0);
>> +    ret = etm4_probe(&pdev->dev);
>>         pm_runtime_put(&pdev->dev);
>>       return ret;
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index f19a47b9bb5a..f85b041ea475 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -370,6 +370,18 @@ static inline u32
>> csdev_access_relaxed_read32(struct csdev_access *csa,
>>       return csa->read(offset, true, false);
>>   }
>>   +#define CORESIGHT_PIDRn(i)    (0xFE0 + ((i) * 4))
>> +
>> +static inline u32 coresight_get_pid(struct csdev_access *csa)
>> +{
>> +    u32 i, pid = 0;
>> +
>> +    for (i = 0; i < 4; i++)
>> +        pid |= csdev_access_relaxed_read32(csa, CORESIGHT_PIDRn(i))
>> << (i * 8);
> 
> Given the above, we could make this iomem specific.
> 
> Suzuki
> 
> 
>> +
>> +    return pid;
>> +}
>> +
>>   static inline u64 csdev_access_relaxed_read_pair(struct csdev_access
>> *csa,
>>                            u32 lo_offset, u32 hi_offset)
>>   {
> 
