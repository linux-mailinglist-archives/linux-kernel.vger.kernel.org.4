Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960E6BEB92
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCQOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCQOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:43:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1721EBFC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YySStbViyk+xP5JUMyGfeUUPy7dpq9zIdoIUhTWmvcfguSoNYgP6swU59ZdUAXrk1JWir6OcjhMPg2qykI5+HQnQoXwoDZuyOw6rPSC6gqPAeiaEM13aOzB89ciYNIyask1zZ2nk25NJWR1zMvJ4MHMZ/2XRYVZZV1FYs2qXhRED0s6RTv6dBgMFGXdaAKGWBbBvfapU+3jYqGG92/YyVYDIl0ROWbDbZU/oV9H5vLYSdg9WTkXNnQrWL5nppjiBFTCPVm47TEjQGMC+M2XR6mQ4MU4BNk/DQ/SO6GCZNSuJsn2HZefk+NlyfaSCC5hN6Rohul/Nd6rGZR91B0+eYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PDCEJM6OU5dw05dW52orr09ewDMXzG5Z/fqn8rqjww=;
 b=mYbMPZWqrjgPuUSS2CAFZIvvHnn/UFyccQS/PwiivMp/nVVTHGu1AyMP8ny/yo+NeLeHmrVZNTvq4Wtov3rvQcNowDj4naTRlDa/Q2sfkcdduEGi7mcs+9zwTMXVdygELWn2pICI0xbFLpww9g/wrSeajHYUsdVSNPYAz1RuQXDLFbr/rtKIP0VtBx27LvbEjtbeySatPHOwQUERkEp2tFWFV++55m0m8nqMoxmpJ+iljUI3DuR+avY+wqc6G+GfiIIBCGB+ufVfPTXMGJ9bpsW2nGuFrVONJDnUpwgc89gnsiPgkhlcWnbewPCiMhHZez1DJ8IkO0UCdg8cC3RuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PDCEJM6OU5dw05dW52orr09ewDMXzG5Z/fqn8rqjww=;
 b=RBIbWJiwPFcOmTy5E2Tbl54t/4gBYV++fasA3RjkrAlstqWcsXuTNZ6q8AtM4pqIbrLBWzsbmJ2OM9BCkEQvzW3RslhiJ5QXs1jXBg4kDy9kK5eCn++VGEZHwcOc0VIuLOigelyZpuKnpb8zlCqUfN8TB2kCtOMZAlL1M5dBnBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 14:42:53 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%4]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 14:42:53 +0000
Message-ID: <de3ae97a-50de-8906-d370-e93122e2fb16@amd.com>
Date:   Fri, 17 Mar 2023 20:16:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V6 5/8] soundwire: amd: add SoundWire manager interrupt
 handling
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-6-Vijendar.Mukunda@amd.com> <ZBGYubOYyu7E8ueo@matsya>
 <3aa704b0-1142-8afe-b0f1-28bd2a254cc2@amd.com> <ZBRs5LAXRQ2S1Htc@matsya>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZBRs5LAXRQ2S1Htc@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 0968aaaf-2482-4261-8191-08db26f5e3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vFz38HCL/TiNMzo//zMXZjI5sEaSdmbhoEcuBwWLWpeS6Gi8dGRnW3v4GP53B7QRnIL/RP7GXA+22ksRBjVLvVPexFJuNbEynJiCaFGl8QsPWsEOjH2+tCfBfnW70X8SDCSes/hEVAz6Yb/fR8pP2WIosUDY9Ud/cKI2oEguyRSRT1s435t3zJOt0ZkWPI36kkM8SgtFX4ZoNP2SwiOpaHH4Gx47y0u2AmtueruGMimX0c2ajtgMPP9zz9or/lznSu0C5GwXmuDibvxl2Uw2fEFH3arwVibLUz69fKRLhek7MeAgL4k5OZTvO4KkAEi5tvuOlO4GrcTQiZREbr/5Xdd9lLMhakBIwJNYzFtaZWWo0U8zDk/WxsXxO9u6aA1AqhLA6o5vE+sUVE0bAw0XroTF+OmuvfXlmd2R5OI4CgRryADS9yt/yX43k5QxCcXopIkH2Jgsk1poyJs8uSsZI6F5N/fmav0wyFRtP0vthMGENJhzTStICKgU3GTX5UrhUmRupsaxQ5khJIX36yUGDsgGL9qwd8aNPnxN54rJXHVLW5sz4Ajoq4ouN9m5adTwlKGVp2hXSE7ybQ6+VE9ip8i/ID3mlMx+ajaHAeig7W4S78FJBr9zcdxseFE48rxy/ZZZiP2JoIWVa+0w+e7gYHUQ5+7yWdcf/NVxeW5gSMCnATLeNd/RHxWOi8rwFKCR6hRAjBtosCm5O/1NYZib4/KQca7oUOMcGQ75UZjeIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(2906002)(66476007)(4326008)(8676002)(66556008)(6916009)(66946007)(8936002)(5660300002)(41300700001)(316002)(83380400001)(31686004)(6486002)(86362001)(26005)(6506007)(31696002)(6666004)(186003)(53546011)(54906003)(2616005)(38100700002)(6512007)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJtZjNxLzQ2eFpDL2wrNkZJaitvanlwc3doRDhXZE5VOWdKQTZsOWhXREVs?=
 =?utf-8?B?Vkd0YTNnZjJWZEJIVFVRdzFITGhhUUpzQmlSbVpaMkxUM2NNZGJQdW4rSU45?=
 =?utf-8?B?a3ZYbjFFcEExc3pRQVJSQmEraWs2WE05WlJmbFlSdVJZR0E3eE9zazdmTFN5?=
 =?utf-8?B?TXlCQzA1YklrYzExaC80NGVTd28vOTRUZ0lOOGptL1l1VFkxQUg5aTRPOFZs?=
 =?utf-8?B?VWY3M0grMm9zVWhjMEdBTUpZVm56bDRUbko4MHg2RVE0SXNvY2Q4M2FZNHV3?=
 =?utf-8?B?ZWw5WHBUTjlyeE9DWnI3VjVzTUxRNi83VlNQSjhoSjRtT0FsNzVnQnBlYTZx?=
 =?utf-8?B?WCsyWXVia2dua2plNitwVnlBZzBIR0tzaW1zbGhUODluSm5xQ0svWE9LRHlV?=
 =?utf-8?B?ZEtCNmZtaVlMa0lHcDlheko3NnV6U2t5RjFpclYzWlIrQm1xU01hWGRqRUN2?=
 =?utf-8?B?MGZIM1JCTXJXdXhodXVQd2JIa3FKWTYxY0FGRTRRc3FqdXNCeXdpMkltLzlu?=
 =?utf-8?B?WHhhSWJienJqMzN4RkI3TEZwdndFN3RueStLRGxhNkZWV25vOTFkeWFweWw0?=
 =?utf-8?B?Rm5QVlp2Rk9YN0s2VDhXVDFybEg3ZjV5UFZyV2laWnNXMkJ6bWpxWHpvM21n?=
 =?utf-8?B?eC95Y0g4Vyt1NlY3a3R6cmE4ZmJQd1l6TEhyVDBONGhIbjFUdGcrVTQzZGFO?=
 =?utf-8?B?dWswQk5TY25hY01zd3haanlmaTNQVDRtbUdUaklWZGUxS1V1WFBvYUN6MzFq?=
 =?utf-8?B?M2l0YXp3Z08za0RqeFBPU2p6MjRpeFRXNnZaeGlmT3RUbW9FbGU0dXYya2RO?=
 =?utf-8?B?M2lSVklPUWZKcUM1RDNQamN6U1R0ay8vQzViSDM0K1MvSEdmMVBscXUrRGRW?=
 =?utf-8?B?aGVIZ1VMbWJ6MC9vUGxqNVZIMkxEMlZUTFl3YVN2aUNtd1hNWWh0MGtONm83?=
 =?utf-8?B?Wnl3SUU2Y0xnZjYvaTN0QXhpUEp6Q20vcHdBSURadXNCNlFpVnR2VXVSM1F0?=
 =?utf-8?B?UnZDOGYza2JXUy9HY3FpN1hDNUxPMnRycEJvamZsNWowSEFWUGl5NVJzdUx1?=
 =?utf-8?B?NHM2SEx4dGNDak5QR3RXZUE4aXllem1sZXk0d1RURDlzQ2ZWT2ZBclB5SEhC?=
 =?utf-8?B?QWRtWFg1cjZhNVphQTlwV0QvVlZiNmlEdldCam9YUnJSeDUvd1V5VEdEZm1L?=
 =?utf-8?B?Z254YkRhNXlTMWlOUzlTemM3MTlEOGRwaXoxT2g2YmNqT2JVZld5TjEyMFpR?=
 =?utf-8?B?eEU5c2R4bXZDZFhrY2VrL1RFTVpIT09vWXFtMHhrenBMaXJpWFppcStwbVIy?=
 =?utf-8?B?RUlZeExGRlVaV1grRG9sZE9WSDdNWjd4VE5mS0x2bHcxSWxFOGlrRGFqY3Bk?=
 =?utf-8?B?RldEY21sUkRQazZZY2VPS3Nic0pxc0lTUjQvUUdicGJka1RoNytqWG9HVG0z?=
 =?utf-8?B?MUtBbmNnK0ZyRnUxdWhGT2FnWWlFcnoyRytXSC9oc0pITDVLT2F5TFp3WEN2?=
 =?utf-8?B?WHRtblNybGFUeW1TQ2pueDlNVTVTRFllRXlIYks3ZmpjUkJXVnRTV2poMXpH?=
 =?utf-8?B?bXVYVGM5RkRlbXYzbmZsdlpEbCtWWCtNYmUvSmFrL2FxK05sM0hDVDlCczJn?=
 =?utf-8?B?ZlJEenFKOGs5aXBZR05LeHBTeWNISDQ1bUhlWmdIdVNvdlN3VTMzWFJ4MG9i?=
 =?utf-8?B?cHdxNHBVM2NCdmxWQnZVZE9ZempEMFFzWXE0ZXBrSHpBM0dOcU43V2krSCtC?=
 =?utf-8?B?V1dxelFZSVdjc0V6QjNLTC9DN2F0bXpqVnZoMkpheDR0SkVLVk9FWUVJZ3k2?=
 =?utf-8?B?ZGxyazR5UUMrZHVEQ0FCNExkRlVTZlFmQ3pHR0s5RCtNVUNOd29YeWU3ZHhm?=
 =?utf-8?B?WmdMd1BPajBLeG10Z3R0eHM2Y0ZlQVJyZmZqRnA5ekdOUFpiRG9wRnk3Nm5a?=
 =?utf-8?B?bmtsSjQzREZXTzlxMjQrd3JvMVN2ZzJ2b2Z5RTVuOUNIbHNKd2RFM1dzR1J5?=
 =?utf-8?B?dzRuNjZxT0tkM3hvYWtvRHpLb05jN2hURXdocjZOalFFZndIRVRGcnlLMUVN?=
 =?utf-8?B?T0VyTkxoai9sanpuUlFYdU1mZWgzVHJnNTFxTWtjSGd5NWJHQU9rS0w2LzdH?=
 =?utf-8?Q?lJbaD39ovEKuQ4hGxXnToG7Pa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0968aaaf-2482-4261-8191-08db26f5e3b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:42:53.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/ZhPtB69knauDw612I1ZX+KLzMXAfN/RQ6OQufZ5GZErcgOOTg71lwIx06aKEt4p0NfvEK6w4MC8TirZf+KOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/23 19:06, Vinod Koul wrote:
> On 16-03-23, 22:34, Mukunda,Vijendar wrote:
>> On 15/03/23 15:36, Vinod Koul wrote:
>>> On 07-03-23, 19:01, Vijendar Mukunda wrote:
>>>> +static void amd_sdw_update_slave_status_work(struct work_struct *work)
>>>> +{
>>>> +	struct amd_sdw_manager *amd_manager =
>>>> +		container_of(work, struct amd_sdw_manager, amd_sdw_work);
>>>> +	int retry_count = 0;
>>>> +
>>>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>>>> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>>>> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>>>> +	}
>>>> +
>>>> +update_status:
>>>> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>>>> +	/*
>>>> +	 * During the peripheral enumeration sequence, the SoundWire manager interrupts
>>>> +	 * are masked. Once the device number programming is done for all peripherals,
>>>> +	 * interrupts will be unmasked. Read the peripheral device status from ping command
>>>> +	 * and process the response. This sequence will ensure all peripheral devices enumerated
>>>> +	 * and initialized properly.
>>>> +	 */
>>>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>>>> +		if (retry_count++ < SDW_MAX_DEVICES) {
>>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>>>> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>>>> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>>>> +			amd_sdw_read_and_process_ping_status(amd_manager);
>>>> +			goto update_status;
>>> goto are mostly used for error handling, i dont thing case here deserves
>>> a goto, can you please change this...
>> I agree. goto statements will be used mostly for error handling.
>> But this is a different scenario. We have used goto statement to call sdw_handle_slave_status()
>> from if statement to make sure all peripheral devices are enumerated and initialized properly.
>> Please let us know if you are expecting code to be modified as mentioned below.
>>
>> sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>>
>> if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>> 	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>> 		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> 	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>> 		       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> 	amd_sdw_read_and_process_ping_status(amd_manager);
>> 	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>> }
>>
>> We have to check any race conditions occurs or not if we implement code as mentioned
>> above.
> what race are you talking about
Our intention is to convey that we need to verify the above logic and check
for faulty case handling where status[0] is keep on updated as "ATTACHED"
when multiple peripheral devices are connected over the link.


>
>> IMHO, it is still good to go with goto statement implementation.
> Since you keep checking, essentially this seems to be a loop?
In normal scenario , if condition gets executed once and exits the function.
In faulty case, if status[0] is still reported as ATTACHED, it runs in loop till retry_count
reaches SDW_MAX_DEVICES.
We want to keep checking the status until ping command reports
correct status on all other devices other than "ATTACHED" on device0 in a loop using goto
statement with max retry count.
>

