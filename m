Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062A66BDBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCPWmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCPWmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:42:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12536E5038;
        Thu, 16 Mar 2023 15:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3F+bToz1a0WbIfYg/HrrvopLB+QkEXO0AxG8+rZT2yH59MA0+eZCbLlTdXm7snCV8S6/Ptv3gU874rcytxA4t2TaZoSWpu9y6w98qQ8djzLf1Hbokth5vdb1Shh8CDGzfQpfEW1loVncLvKPrKMTNU1WNauiUMgmEgmrsxTANIiJ4QVfzoiXi0GKIlYVK6GgLKih3hD9ugsfdfriQ/EVQcTTW8vFCp+fi1eq88V145Ic63Vnx3NmzfFMWPNgy/M3ESG4xojINZO8f4dcIzW3n2bOAOiXnGNhP/Z9Fhu9pb4QDhGrs1j9p6bHS/SLCaVUuVCCyHkUfNkhUvUbvDnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3Ha+1endqMI1wsh2uCVy4MBHVOTX+lUzhxnjMkj8hA=;
 b=ApC/Q3uV7gFyj8JCOueF94spKCm9ZBfxOPV7f1LDp0PYfKAwdIlVgEZ9wlRtcZxRCuEXcTRpfzp0Ney+Dz86I3bnXnXVchNX0JNFP7/1w5QRXAZnOCsUvFrC+CDkDpXonFmQAubHLfipeuNy90ImGFCelloCpG+0K+bVhwtjKIecInWYUVNftUi1aDUNXlCLlWe0av7vueKYJiYH8m8SZWHw5Xvs/ZJkGP0ZJKEmBkO3uk6RTuvYgD+4/7dSHRy7hSTM18McoryG4DOS02TTlDa0aK89NnGODe/hNq+R3D0wGXGuaudiU/h/Rx5a2gTHRmpA3gJhhVMOpAvC+XtBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3Ha+1endqMI1wsh2uCVy4MBHVOTX+lUzhxnjMkj8hA=;
 b=lkndnWKg5lR6Ltm1yOLmsj9UlsRph4hoQg0dfz/0lfNFuJyCuToJSG/Hf4c4A4I0SOFustGGIWoa8RP7kNgbalDhNIYt5DxFbLyUMEj2Nsw9ACpF+F43Y4wYQUJhFqetIlmbQfpQQ6ejjpMGHn8hx7MnBNiy4ExJDmBNr3gVGKLv44dwNA6klmXk8U4YVeF3jsXKxhPaB+looN+JvKDeqChSqW1DKX7SAnK0/lebiUFGfhVy4gGc+VmoZAl1tkT1Qzcmg6U5WaKghgn9JoGb2nKzTJ0hU03J/FyfqcFlDGuW6/8GFAkfiiYcPIFoGqIXxOnAjiDZwCXNub1RMlX3lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 22:42:03 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 22:42:03 +0000
Message-ID: <4b79a447-4c5b-804c-b4b9-9641e174330d@nvidia.com>
Date:   Thu, 16 Mar 2023 17:41:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230314135128.2930580-1-sdonthineni@nvidia.com>
 <871qlqif9v.wl-maz@kernel.org>
 <4dda3890-e910-625e-e7ed-6b6c0bbbd9d4@nvidia.com>
 <20230316151014.zaoxo4wmg4mzyoiq@bogus>
 <bf9f8763f0116c3f05c008923edfbedb@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <bf9f8763f0116c3f05c008923edfbedb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cc5577-9e9a-4582-ced5-08db266fa964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SrE0Ya5r1/3g1JqOh6DF2jvBFH8aW4YS0jAZPV0jTf1CLiZEbquAw+CJxDU3oyw04sZQOYc6N7tqH0ttOgHMe6Uy+KyHL3VADMIj7a3bJRsdJCepcmISTLu6vTiIxzgM04/jvrthO7J3psUQBEU4m1k2tF63Ng4OwLJxeZPIzic+rwlqbfqctAdeHZY62Exu4EskuWqxQqVAxOYQmPO3CRztrmjJGi04fhiicPAoSm54QFLbNlRg5K0iwB3Bmlx/nsfLQTNR10BYjbsk9m0i+W+qN+lL/vT8OwxKsgEavhJTNkXlYmHyXXWH8WdqRkdFk09BJy/PG6kzPX+ekfQ2YZ6bWC1tPqpXEqId9c0kpWzSZFzguw+erx3lZARnZTdCBWOuuZQYIhA7+ASwfvIlB30Q3duuomzhw3ed1YaCrfi6laUIH+O4JDH2M/8zudZns9ujESUpQ/4QOao9U1WH8X8yyQnI3Awz7eXHQzHe5TJJlm0G3CT6JxvPrhFKydeP3Hwthpidkje+KRsKA4GPGBHUyVkiQ/a15PpQTavaiQTRpYWenK3HaN9R8emKPUQPjJeu0iG1nRHbbNx77n3ABX4krAvJ/9B/rYRJZvhCGbQF6osNw5EO8XFLwo504eCvyLH83iSyVVORo2n9QM8rcHuj/QFYhiYMGvlE60qSANz5d+AuLT+hJVusj07Iu9mK+mk6EdNZD/hmfzCTXNsVOtr3+UIg35zyhzm0Z09XAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(31696002)(38100700002)(86362001)(36756003)(2906002)(4326008)(7416002)(41300700001)(5660300002)(8936002)(186003)(6512007)(26005)(53546011)(2616005)(83380400001)(110136005)(316002)(6506007)(54906003)(66556008)(8676002)(6486002)(107886003)(66946007)(6666004)(66476007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVEUGZIWUlPT25xODJsSTNRdGtXZy9NUXhqaWdIMHNQeEI2THdxQVJEUkZ5?=
 =?utf-8?B?R0tSRE1hRDZOVklMOEx1VWpRcE1wWWN2Q0ZKUDA0NkpOSkVWOWdsekVoZGtI?=
 =?utf-8?B?djFyYWNxQVhvVEFHQVY4azlMdGJpd1daOUVBeTNiVEJPOFhlTExWbnVtSFl6?=
 =?utf-8?B?Mi9mV0pNY1AzQWduRFI1OW9jc3I3QWlGTlJia1ZNeGEyUzI0MTlENGUwR05C?=
 =?utf-8?B?VmpUMHJjK3NzT1IvWW5JaFJUbHV1VDRMdGxyekdienREQ21ra3g5bjlpNWxI?=
 =?utf-8?B?RlRPcUdpaUNKSnR3MGx2N3YySjk4ZWlRTmhCdzRNT0FqMGdHVXJheGxJeVNM?=
 =?utf-8?B?czZiODVqY25zUjV3c2tueThPQm5zOVpTcktubXdqVjFuZ2J2akhFUmxwR3ho?=
 =?utf-8?B?eWF5RnpLNi9uSEg4aHpHZ2lUc29IMTBwcU1qSlZ3Qm1PNmMxU2cxYkRJSlRY?=
 =?utf-8?B?dU9OZm1jNGMxRGhKc0tKeHY2N3NQc3NoSzlydUtYa1FjTnpBNGJrRmd5ODky?=
 =?utf-8?B?TnlqYXYzWU5sbEVST1FNbkVNTlArenE4dW5GdC9tN2owTzd4WCtLT3JpWFVI?=
 =?utf-8?B?cGZYTUpNcXp6cjl1RTk5eWdzbUE3TVF4eGxLYWkwQ29DMlRrQ0tTTmZIbklF?=
 =?utf-8?B?SitVMTNjWnUzeFdhTURXWEFNZlYwUlJDR0FCK3hCU2pNaU1jMUJFcDJ3blBO?=
 =?utf-8?B?aWVBTnpIVzVQNEpPMTQ3WDRGblIzbzUzT0V1V3gvWFdnc0E1S2NscitMR2VQ?=
 =?utf-8?B?QnVxM2JHSnRHZytFc1lkVWtjSENKQ2pjbUxrSnkzdUZ1QVhDUVcweG9JVDR2?=
 =?utf-8?B?YzdTOC9iV2N0ODlhbzhhaUVRbFNzelYxdWhIRnZsOFBVek8rSUgzQTJYc2R1?=
 =?utf-8?B?RVJLQWlhTE5OVnFQYlV1ZHNuK2piU0FFVUJYbkFoOFNFOEdkOGhuQk13Ukxp?=
 =?utf-8?B?bUphMmxoQURCZW1GT2RmZVBFbnJXWlhJdWpzWlNJZkhBU0xTMHpvWHNOTnRy?=
 =?utf-8?B?NFlEQTlITk1LZlpROWNtQ1l0Q1JyQllPWnVEek9Mc2g3MjgzOTU2Q0Zyei9K?=
 =?utf-8?B?WUp0dlJ4M2Q4WUNaQkJRSUhTWVg5YjJpZnROa08wWEdsbkRkYmpXekFQRG04?=
 =?utf-8?B?UGNCcXRIUE80VXozak9tejh6SmhxeksvMkxmaGl0Z001RG9XVTI4SDM2V0Nk?=
 =?utf-8?B?Nnp2bzZlUGR3eHBIZytZNm1kMmVZbGhndjlDN0dUUVRwaDR5cHNzMGtuZGxT?=
 =?utf-8?B?ZkZBZmJDMUUremdJeVZQVjBtNHg5VGppbFFhVE02Qmo4L2M4VUdINi9yVkJs?=
 =?utf-8?B?WWREamxqNEVGMEd2bmxZbEZhMWZScUI3a243NXAzc3N0MXRpdjhCbGwvWmFS?=
 =?utf-8?B?TlpSTzFVOHBkSFJKK1BNL2JuVGVxRlZwQitFUm80VTdOMktvYmdTdUJtcG5B?=
 =?utf-8?B?VGxXckZha296ZHBIV1R2OFhENGpnUmxtVStZcXRJcytXUkZYcEorNnBPSTJN?=
 =?utf-8?B?WGZJWTFTSkRKMkgxbkxnbnByT0s4aGNDT0tiTCtOOWZTSmZuWkh2aGpydzZP?=
 =?utf-8?B?dXA0RlEvNS9EVHA0TzBGZDBIdG5sZDFHOHBvdXJzZGkzTnpEeDlacXRPdXpR?=
 =?utf-8?B?VDdodUYxUW5kQ1JaWmlRUm1wK2lJTXU0RU1CUmVYTm5NbEFscFdFdHRaV2I0?=
 =?utf-8?B?bkkvcGJJR3VtNW9sOEplVE9qV09oV1ZWbFRxaXlvQ2ErcjZGQkt2azh0bVdO?=
 =?utf-8?B?ZE1mbllFanFnRElGQzh2WEw5SVBGWkY2TFZXL3FWdHdPdDdoMUZPVTdMRFhB?=
 =?utf-8?B?aWdNYitTaHZsaTlkbHgrTFlEMllCbkd6bTVnR0pSY1lsSlBZV01CRWpBTVRG?=
 =?utf-8?B?eEZWMkIyVzVDRVQvNTBoMnRWUUxEV2M0Z1NDdzhQdDRKYnhjN1RwRTRYRU01?=
 =?utf-8?B?WEFteDA3dCtvYjVQeTBxZzdnek9OZG5ONkl2VEtCUGIrVkRtNFM2bjlMZ2Vn?=
 =?utf-8?B?a2lTWkJlNzNoZXFCWnorQm9IQ0FKeWM4NmNoVHdQVi9BR3g2RWZiLzIrK1dX?=
 =?utf-8?B?clQwVGlGTndJMGFGamJyYjV0Nk5DS1JqUG12SjdCcENmWTV4S1VzVGRmZStj?=
 =?utf-8?B?OHpLWnUwVFRJa1N2WUZrbjVwbHRGYjUxT01peVFrRllpK05OSDlrSm03VkhO?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cc5577-9e9a-4582-ced5-08db266fa964
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 22:42:03.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWalGM7W5xsbDrgeR+OFRL//8gVeNxM7ESf13mR25htRGQh9dW4RbYP/d8k2EwWYVUBmoHgzzINfW3twlH5t0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 11:00, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-03-16 15:10, Sudeep Holla wrote:
>> On Wed, Mar 15, 2023 at 07:27:14AM -0500, Shanker Donthineni wrote:
>>> Hi Marc,
>>>
>>> On 3/15/23 03:34, Marc Zyngier wrote:
>>> > Please don't duplicate existing code. There is already the required
>>> > infrastructure in drivers/firmware/smccc/soc_id.c. All you need to do
>>> > is:
>>> >
>>> > - disassociate the SMCCC probing from the device registration
>>> >
>>> > - probe the SOC_ID early
>>> >
>>> > - add accessors for the relevant data
>>> >
>>> > - select ARM_SMCCC_SOD_ID/ARM_SMCCC_DISCOVERY from the GICv3 Kconfig
>>>
>>>
>>> I have not modified soc_id.c as it expects to be loaded as a module
>>> with
>>> the use of module_init() and module_exit() functions. The exported
>>> symbols
>>> in soc_id driver cannot be accessed from the built-in code.
>>>
>>> Agree, the SOD-ID discovery code was duplicated.
>>>
>>> Please guide me if the below approach is okay?
>>>
>>> 1) Probe the SOC-ID in arm_smccc_version_init() and export two
>>> functions
>>> arm_smccc_get_soc_id_version() and arm_smccc_get_soc_id_revision().
>>>
>>> --- a/drivers/firmware/smccc/smccc.c
>>> +++ b/drivers/firmware/smccc/smccc.c
>>> @@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit =
>>> SMCCC_CONDUIT_NONE;
>>>
>>>  bool __ro_after_init smccc_trng_available = false;
>>>  u64 __ro_after_init smccc_has_sve_hint = false;
>>> +s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
>>> +s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
>>>
>>>  void __init arm_smccc_version_init(u32 version, enum
>>> arm_smccc_conduit conduit)
>>>  {
>>> +       struct arm_smccc_res res;
>>> +
>>>         smccc_version = version;
>>>         smccc_conduit = conduit;
>>>
>>> @@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version,
>>> enum arm_smccc_conduit conduit)
>>>         if (IS_ENABLED(CONFIG_ARM64_SVE) &&
>>>             smccc_version >= ARM_SMCCC_VERSION_1_3)
>>>                 smccc_has_sve_hint = true;
>>> +
>>> +       if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
>>> +           (smccc_conduit != SMCCC_CONDUIT_NONE)) {
>>> +               arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>>> +                                    ARM_SMCCC_ARCH_SOC_ID, &res);
>>> +               if ((s32)res.a0 >= 0) {
>>> +                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0,
>>> &res);
>>> +                       smccc_soc_id_version = (s32)res.a0;
>>> +                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1,
>>> &res);
>>> +                       smccc_soc_id_revision = (s32)res.a0;
>>> +               }
>>> +       }
>>>  }
>>>
>>>
>>> +s32 arm_smccc_get_soc_id_version(void)
>>> +{
>>> +       return smccc_soc_id_version;
>>> +}
>>> +EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_version);
>>> +
>>> +s32 arm_smccc_get_soc_id_revision(void)
>>> +{
>>> +       return smccc_soc_id_revision;
>>> +}
>>> +EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>>>
>>>
>>
>> Overall, it looks OK to me. However I see neither the gic nor the
>> soc_id
>> can be build as module atm. So do we really need the export symbols if
>> no
>> other modules are using it ?
> 
> It really shouldn't be exported. Having accessors should be enough.
> 

Thanks, I'll remove in v3 patch.


-Shanker
