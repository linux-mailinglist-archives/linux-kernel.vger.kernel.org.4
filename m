Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC1697087
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjBNWQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjBNWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:15:55 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6F303D5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUNwod7M1vOffs2Xlpry48kMUhcDlkwAW+bvrqDOkhjwqQjaJyTY9P6p0KQsI8jqwFaP88iybCAoFjTg15HKQ0jDfPdr0QG/3sdfIKbk9hBHtjEV6QK3vQOwM14AEVcIZQxwyFdBA3/gfdfcN+mVDcJu2b9of2s+o/NPg67lvF9II0ATCLk3GxLmpIizjmSmyNPNC3Ntw5EJD/UAW63AujchN34sckOqYeK63ojwlU04QIcEJt+U7BoK19m8i6kQmdvS3lWcAaApTi7iCOHSXLEkDoVj6wh4gtB0Vt2HkejD5jy+YUDqJOSsoNdj/BAzLMjwk4u42CgF8lv8pD1Fnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfdTFWD5HcsiQCmcsXb7PEvw/ETmV12xWAJK7N0Ch3M=;
 b=SCor/qbr4qFI7GP4KPgXIGe2PLm2QP9LOWmpWwYth+t48JeDIFA6KnIEQOdbsfnPGCzTPUh2gvfz/SIuA7/TVxFYxqRfhj+u4sJPopTtltM3kthRPlMWW2D2KvuKTt2x0T/XfXY4AuuDIW5Rgqi809Ean7TWbWo8MFelh5Ry8fSq3ng/BqnX0JJ6PICOFTGrixyNhBIjBywfPIFRl37JL0H8+xPdUpyKE8Mxc0HT5qjjPNbyCX3mjQ4vNdQ0qtNoPK69hwzrDY8l3wBCD05Oo6hMzZt71/VTSY3jPMO2Me2FssJz0Fncr+3X/tgCEokRzElVnTeCufXs79uJOAMTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfdTFWD5HcsiQCmcsXb7PEvw/ETmV12xWAJK7N0Ch3M=;
 b=ngI2+7EYcf/ZOIId5vlK3KyDv8yxrsjRbg/1TYaetS5poC4/k4OHOIHNrzZHb8HzJ/IlNIU+ikaVom1L/Yy/3sWWVsEjVTJKwA/TBUrKrcogXLTDe5i3mNugqqNve9p3cqwObEV5XIuaOf8T8OeiAhW4x6Y4uGlEKuaPNv2NnUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 22:15:35 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 22:15:35 +0000
Message-ID: <74042758-0c28-227b-1362-ed410c74d115@amd.com>
Date:   Wed, 15 Feb 2023 03:48:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 5/8] soundwire: amd: add soundwire manager interrupt
 handling
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-6-Vijendar.Mukunda@amd.com>
 <9505941e-73a1-249b-08c2-83b86e7ef5c6@linux.intel.com>
 <2fc1191d-e57d-4b76-1c9c-088e33f2ad45@amd.com>
 <f739053c-d19b-f773-cead-77abad53feec@amd.com>
 <b632ba86-767f-2813-ad2d-4a3424e6b02e@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <b632ba86-767f-2813-ad2d-4a3424e6b02e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BN9PR12MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7fb3de-e778-4633-fed5-08db0ed8feba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riUZsuDZMU7YVh/34uF/PbNwYaaxG1Dd/P/dMMvArymnwCXbnwcRLEnUtu0tWbuxxJwtqxAoARgOh8mpj58KT478HDEYqwe/p3dTOCpDmPccr81HeI65EB7BOsQv1Cp1n2xHEIXTtuT0dKG3qjksgS7YJ3+pnP2+tYcGT25UQRwmZ3/hi0Loc1Mzq0HjwnJfnQ8MV7hMeWiegC5DKu9Q313HE4T1Agw5Rhl9TofFMyLYKq3wOgMttO1CNRbW7Cem1QDLwBF1+a3vXxxxrfLCHtpBPqho9FDoSs0qFVhJCAa2OBrS2hwuxlRlW+zqdGNjiWMYTIxK12OzTWtzSj9Irw/UyyPxN14DhtVbvw/oR6DsEG/YjK6A5B0Kk7N0UfcZOLJEeeRYBAktWsff0rrXC/2VIlVhsLovLlIooACrciFzeBxXIu8MS5KLv17lHjb15GZks3lqOuJQWydXBVZFiWNRmi1ymAMBmm96bavaP3aDLm0LQU9MmEH6a9pRiWgPy76q+a5RYxgym4lM58ILTZYFTJEZPSI2TyTGSHHuiGrY9+IuRWpWafCAexZCFWVvhwBADdOdma0DDZ1JyopdorJgedHW1k3kIZFtFPjXUmsd9nfOGQDuQ/n+P/d/vwSHqfOZsu5zZyrbGC7cOXhd0ngR09L/c+60RuiCcZQvL0hWhyaZTtpbhMnDDl1paGs3Dxyt+ezX1lCQkZCNnyQFQ+P/mBkN4Xfr3rJ/a99bCZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(83380400001)(54906003)(316002)(66946007)(8936002)(66556008)(66476007)(8676002)(4326008)(6666004)(5660300002)(478600001)(2616005)(41300700001)(6506007)(6512007)(53546011)(26005)(186003)(6486002)(36756003)(86362001)(2906002)(38100700002)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBEeGRNM09xM3duZFlMSnl1UFIxVTFOVCtFZFFzdkMrTzk1YzJVbWs4QUdZ?=
 =?utf-8?B?ZjR1Q3UvdXNxcVNGSy9YSTJhN09VTnVDbFg2Y3FtaTF1UmtpNzNGby9jU2wy?=
 =?utf-8?B?NmtsQTVRaWhHWFU5ZGdZZitBVm1BYUpNUmloNW8rSUJUU0NxQkYxNitZN0h6?=
 =?utf-8?B?dGhNTjh2T2I2aUpXOEM0NWlBUU1MbFN0UytHQlQzQklHdStmbGZyWDd2VmJn?=
 =?utf-8?B?SjFRdGdjdDRWWEh4Vld1L0hIZWc5TW5sc09xTHBacThiWW9zenJRcDdUbVFm?=
 =?utf-8?B?WEQzVldjQ1llakFnZ2Jrd292MHp5M0NCaUVSNndQNmxrM0J6ZUw0WDgyYXE3?=
 =?utf-8?B?YVU0emJmUHFsUGxtQSt5WEdGK0VyTUN0aEFibk9kYkhXSkJhSlg2LzlVeFJ6?=
 =?utf-8?B?MGJCMkMrdnBTU2JiakxvTWFpYXJyWEVJNDdnV1V6cVk1bDU5NDRobHVDWUQv?=
 =?utf-8?B?ZEFwaXF3emFLaWdta2lwUE1hVEVpOWhyUm5oUzQ2SlFESGtBS3c0c0FkR2J4?=
 =?utf-8?B?OTBwWUNKVmNXeW9zMjBVa0tTdDNXa2V4ZEpleGVOVFFxT3JrcDFTK1VvbVh4?=
 =?utf-8?B?Z04xcDRnUEVqQS9WRGVhN3VsRndjS3JDREVmRHpSbXVDVCtja1hDL1NUY3Bh?=
 =?utf-8?B?WEIwNWxoZUoxTFI0U1p3R3hQZnpSTUkyNVI3SFVYU0tMLzhvRG41K3hOc3RO?=
 =?utf-8?B?bHNUN0syOHN6V1UvQkUvSmV1VzFnNCtlZlo5ejVuSkN1aCtaNWYyaG9WK3Ir?=
 =?utf-8?B?SGI5cjhGeHVEQVAvNHNtRnB5cjdTaHJKT3ZxcVQ1Y3dJZk5NRkZYT251bHZI?=
 =?utf-8?B?UXlNZWY2cEJiZThTQkdSYnBxc2lSWkVYc09WaWtPVjN5eTU2dVlEemRIb3lD?=
 =?utf-8?B?Um1YVXJOMHJieUMzVTdDN2p0R1hKQWFFUm5QVWkvbTVTSW5Vc1VxN1JVOXBL?=
 =?utf-8?B?UUxablpEQ3NiOFJ3VUxKTVhsUG1Wd0lHa2JnZjQ0WjFRb1diUDc1L2NUeW40?=
 =?utf-8?B?T3NQMUFMc2o2V1NxaElMT2F0YjM1Rmx0bExmZm0xalZBOWFaRlBpK0JLRlB5?=
 =?utf-8?B?VVBEZUJDMjR1QS91SGVPdW5nM2xnV1J0L3pyeWJLVmhHVUpMajFTT08raTNj?=
 =?utf-8?B?WGp1Y3l3MnEwOWlRS005Zy96NU9ERUs5RE80SlpDUzhwaTlsY25qZGkrODMr?=
 =?utf-8?B?aVdpbmVEYmUxVG5ZZ3d1Z2JZVERMeXJJR3Q0TUs2NUFkNnhKbWdjdE9yQ3NG?=
 =?utf-8?B?ZW1VdDRUR2xNZTNpci9LOFRPTlhHWW4yb1lON2hGVDNhNDJseVdRY0M4NXdM?=
 =?utf-8?B?d3JnM2ZTUGtRZGd2L205cjJiREh4dzVrYXA4RzVRdU1IYXA5aXFMRm9FWEtB?=
 =?utf-8?B?b1BQaVRCSGMwL2ljeSt2L2g2ajk1SGZaa3JoWlU0MVRrMjJGamY2YkZsUFdl?=
 =?utf-8?B?SWRDandhTll3VEplbGdWbFVuWXpKaGFZMStFRDRxTjgxNFJNdFMzeTRsMUd4?=
 =?utf-8?B?WnV0bVluQjBhbDBVaWtGNHhwbVpiN2ZiUTZad3hiYno2aEFJdFVUTGkvc3Ji?=
 =?utf-8?B?MXhwQ01uYXBMVFBqd0FFOGJ5amloR1l0Mysva0dubU5WeFBHdW9wdmRtT1I3?=
 =?utf-8?B?eFpXQ2k3dGN0YXJ0Vk9jZG1QQVoycE1qakh1UHdxSm9lNVlmVUdwTVBzSVVi?=
 =?utf-8?B?Rzl4dVFpK0czWVpIalhsOHFVMERxaFB3WXEvL0ZVYi9POEpEbjBvQjlJTFVi?=
 =?utf-8?B?SjRDdE1GVmdqVGh5dFZFYlc4Smx3eEkrRXYzOWxUVENtc05tRVpFL0Q1Ylhp?=
 =?utf-8?B?S0pDRCtURmFMWGIyRWNjdGZ3dXUyQk5NeE5hUm1tTzlVYUFmSWdpOTJkVkpl?=
 =?utf-8?B?MTB1WEhwMWo3TUw2S2xPdTJHUGZKbCttWmhZQmZrNlArZUdwaVl5dy9zR3VF?=
 =?utf-8?B?N1RYdzNiaEpnc1g4ZU8yU1FGQVBDQkprMUNYT2pmM3ZGdURsMGlHcncwczNv?=
 =?utf-8?B?MEYwSDZaQmx0aExNYlFYbVhoOGZjTWQ0cU82NEFMYkFYenBCcTU1T0Y4dTZz?=
 =?utf-8?B?MDZuUnQxcU5remVOSC9TSGNDUVZwRW1zdmhSOXN6TldTWm93RURocHEwemNQ?=
 =?utf-8?Q?bIlnu0iiMX/1A1AYLZhA/9qK2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7fb3de-e778-4633-fed5-08db0ed8feba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 22:15:35.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5FQeAcaApk+TwaUvBH6SisRtHn2F6azTvsCi7WGhqcL9418E7viTDMB38aWUYsrBO1yJER+KM5PvsO0rWqrGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/23 18:58, Pierre-Louis Bossart wrote:
>>>>> +update_status:
>>>>> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>>>>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>>>>> +		if (retry_count++ < SDW_MAX_DEVICES) {
>>>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>>>>> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>>>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>>>>> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>>>>> +			amd_sdw_read_and_process_ping_status(amd_manager);
>>>>> +			goto update_status;
>>>>> +		} else {
>>>>> +			dev_err_ratelimited(amd_manager->dev,
>>>>> +					    "Device0 detected after %d iterations\n",
>>>>> +					    retry_count);
>>>>> +		}
>>>>> +	}
>>>> this seems rather inspired by the Cadence code, but is there really a
>>>> case where you need to re-check for devices? In the Cadence case, this
>>>> was added because we have a logical OR and new devices would not be handled.
>>> As mentioned in V1 set, we have corner cases during enumeration sequence.
>>> We observed device alerts are missing during peripheral enumeration sequence
>>> when multiple peripheral devices are connected over the same link.
>>> This is not inspired by Intel code.
>>>
>>> As per V1 version review comment, we have included retry_count logic to address
>>> faulty case.
>>>
>>> We forgot to include comment. we will fix it.
>> Slight correction in the explanation.
>>
>> During the peripheral enumeration sequence, the soundwire peripheral interrupts
>> are masked.
>> If soundwire interrupts are not masked, it will cause side effects when multiple
>> peripheral devices connected over the same link.
>> As interrupts are masked, during device slot programming for each peripheral,
>> soundwire manager driver won't receive any interrupts.
>>
>> Once the device number programming is done for all peripherals, the soundwire
>> interrupts will be unmasked. Read the peripheral device status from ping command
>> and process the response, which will invoke the peripheral device initialization sequence.
>> This sequence will ensure all peripheral devices enumerated and initialized
>> properly.
> Humm, the explanation is difficult to follow, it's not clear on which
> side the interrupts are masked. Are you talking about the peripheral
> being prevented from generating interrupts, or about the manager not
> detecting peripheral state changes with an interrupt-based mechanism?
>
> I am not sure what 'side effects' can happen, during enumeration all
> devices show up as device0 and the SoundWire bus provides a mechanism to
> enumerate without conflicts.
I am talking about manager side detecting peripheral state changes
with interrupt-based mechanism.
We are referring to the scenario where multiple peripheral devices are
connected over the same link.
Till peripheral devices enumeration gets completed, we are masking
manager side interrupts, and later we are unmasking the manager side
interrupts.




