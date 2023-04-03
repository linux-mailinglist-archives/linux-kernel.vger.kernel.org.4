Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DBB6D5173
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjDCTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDCTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:40:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D726A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbdt7//rGDCrlmP0CT4mMLVxLCGnpESmPkqbbi/9FPoWLvKX+sYOuQpgY8weHVosySGzukMrhu2vYMy5u9JVvOM5nxV7ZTXnSNqNz5QL9i28KyYHUDoMqE1S3g9WJJ1ZDqA5+sQkOH/7pxuy1D7wS1MX26hodTEpgy9JgYw9fVRGPTePJBc3tie98Gh0eisohe+vMZwl1RhKqbILgaGGfiVXY+bAd10sFI5pB5paz1IwUzRySz7GExm1GZstF5x6mXWesEPNQrKIBmbqIyoCfvF5PpEEDmuu1zgEymt2l+3O401rN33MqX8WGjZfLPqj1KrVYnxldRdhNFtxElkNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6U/S65sxFXP+nb7it48Z5ziUKKBJ7fwjGoPjS58gWM=;
 b=fchJJ8lZkwlTCjjD4ldug1xJtfKhdxPu85s6hYdT5vNvnlDWuiAgUHKGKjLBIheuwtPO2FkCcgLGXj1iNMZ/Tfe7J3vplZoQN/3DgDjIHiWyqLIFAjWt6Uw1g5rY3NEnbOYCSnRxxqkuqCtXfG/sMhTMLuRLuwQwO7Uwl3yanVNrRqMupvw9HVc5Iu2QJdvIvXT+7ghrMVmpoOYwq1kqKqoPwYSBasyol/Pauh5yyMXnE4hvt1Z+IT+hYhS+uiVFoadgvuMBya2uIWgCzFj6yWcBmo6+F25U0Ic251PSErO12GAYSIiTXcfyiVgGUWToZNCctyNdNQO7YMgLlmLtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6U/S65sxFXP+nb7it48Z5ziUKKBJ7fwjGoPjS58gWM=;
 b=LhQOZndOcRbim1lxRbkpdrpfCpcikINrQE3sAK0ZfJ+C7hkWGATy8Js8wv2kFBzKgUHOjLV1lbtJJzjFU5My6S8GsUOiwpG1a+GRHHWXhMCNHhf22oCu6L50E9sZ2ys/AT3Rs+7sq+KHYVwPRzKq0sOy1UpYowc65Tj1VZT3yFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 19:40:40 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 19:40:40 +0000
Message-ID: <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
Date:   Mon, 3 Apr 2023 15:40:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:408:ea::8) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5445f326-e82b-4af5-97bb-08db347b4e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKG1Z3s4IdU2KFvCc4I4l/THF+9qSiP4tV8I5RuAqFx60RjKtM4o4XHzO77w1ospMzHjTE/1lJGra/EYiaRExVMgmu/EUiIX7Hb+b3HvZVZ1wWpdsliav2FLpULNjDdtIfD6eW4WZVewd8uZU3jYCvku6+dP1pmQivwViHWoymEvVFdiEPh/TTRSw7kD6vUyoLvL+6R9ssnrg7qlD+0GesX7H0ddB3XBCKq3jvPVCpmYHxHhdoL9sYpHwSgdi+bj5YZxxApP8RGwwy9XSJMpbK7lEAKhBONIvE8FeS813t/TETrg95BLrEMAIGHJWekILIr4gYH1Wm4RAeWXMfNcoT7WTgf1PxzwtKRAMGx1sdXToLUFgM6gVbSve5WDQbuqEmeMtTxualjjE8DFD9Wt91M6lXm77DgLPiNIBUvVga49Jfl05F4nSrmaEbY5w+3jzZGEd2A8y5VJZk4536/tlKXSfvwulZAVFtvlHoUqjG7Sep4DZDUHsm+Ow/GhyE6qRjQBKW6aVuHBK5JGYR5+VlQhBPEQ6Ss7RTvlyhshTdd8xJhO80lfGZwZIeqkDXmHiDrCYRdJj5PeYGkOb5TGmDU7z9uxvO3M05Edrk4+w4zh+MF1demDFijUlUsJhLPYDgQUHBoQKuRfllEj7LPc0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(8676002)(66476007)(6916009)(66556008)(478600001)(66946007)(5660300002)(41300700001)(316002)(44832011)(8936002)(31686004)(186003)(2906002)(6512007)(4744005)(6486002)(26005)(6506007)(4326008)(2616005)(53546011)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJHa0k1NHljSDdJQ1VUaEdWZ0NUcWZETUV6VkVkMVZHY0NXQzFDektKV3Mr?=
 =?utf-8?B?RG1vRVVtUjZ1bk1IVkRZTTBpTXY4eEJHWXFIa1F2OFdvQk15eUFMZE1kUWdG?=
 =?utf-8?B?aHM4ZU1GRXhsVWgxWEpQUms1OXc0WHdmVUw1OXlVeGpmZ3NGSTllL0hDdnJ4?=
 =?utf-8?B?dXByT2d2MDYyd0Y2Mm1tV1A0aHo1WmNtSlYyZTRwcUlPUUovQTI3VjRaZVVl?=
 =?utf-8?B?bXJpc1RJK0d3ZFFFVkhsdzlrL3VhTXhNalp0WXJPZE1sTW9OL3A2SE5pbk02?=
 =?utf-8?B?MkZueVFiSWVISVY1V2NyMDErOUVybzlOeTJkTDJ6eHpBbk4wcGdFQUxVMi9O?=
 =?utf-8?B?U1RiWTF3Ym9iSnM3SDMwWmthUUVKT3R0d0lpcTlLclJxOUp2U0hOV3I4blZI?=
 =?utf-8?B?SDZ4L0pUY1pEVDVCYnIwMmp1Nytta3FtcC9HcDNjeDZraGRuWnhMQ2F3OFBa?=
 =?utf-8?B?akxidjZGTHRSdE1FSzM4ZkViVS9MS0ljNitYZmVOOFdPME5vd2dZNTg4QU44?=
 =?utf-8?B?WWtxZ1Y1KzJ0M050NW9TRk9HSHdhdTNpUW0xWGw0ckN2a2QyTUV5dkZsbXQw?=
 =?utf-8?B?aXZINXdFbmNzMHpXYnZvQ01hdEpRUXF2d0FCaUEvRk5kMmRCNkdJVkR2Zm1C?=
 =?utf-8?B?d2pndVQ1Y1N3RHNnU3V2TWxkRW5iM2dhTm4rK3BDWk5nbzFGYU9KS0VOcHox?=
 =?utf-8?B?dEdGMGNscm9tK2J2Slgrd2ExOGJqdGFLVWU3djVXTU05aTJZSm5MSXVJbXN2?=
 =?utf-8?B?dDZ2SWF0cFo0SENPSU05Mzl1M1p6a3NJOHNHN2ljcVNPZkNJQlpoNmE3VEwx?=
 =?utf-8?B?UWpFZHJCc3N5SU1iMytjVjkxbitvblZIVEpFMmQxOHE3RC9mTXpLRXZqUDZU?=
 =?utf-8?B?UXp0ZVB5MExmRlZoTjFJL3hhMXMzd2JJeEV2QlFUai9PcVhvcmtRMXZUbFdt?=
 =?utf-8?B?NG54aVE2NHVYMkZORlIrVzdxZlRsN3V3ZWt4aFVZS0U3NmxvSDkvd3hNd1pD?=
 =?utf-8?B?TVpTeGpZWDFDbkRYQy93blJwblpLeUsya1h5TThzQWZPS3BlZjM5VlFTa1c3?=
 =?utf-8?B?cS9iOTJ0Nm9zaHBvYlloaUFsb2F2Q08zbmFLeTcwSzVZU0ZsZTdmUko4U3Jj?=
 =?utf-8?B?VlBhdFBBL25CNzZsRGZUNGY1ME1SNUVjbFMrY0FNRk5YUzRZWCtvWGV2TnJ4?=
 =?utf-8?B?c2wzZHVHOCtkNXVQUU9BbFkvTk1DUkdSc2NHYWM5eG4zaFVRaThSckRhSC9K?=
 =?utf-8?B?V2gwaFd4M05nSEpuNytZSFJDb24xWmpLV1lORUEvUzFUbVlZRmZCOGFaUGNx?=
 =?utf-8?B?VU83alNvNXpCVHBXcHNTTWYySmxIRGswSHM5a3NDN21MR29ZSS9rUm1CQ3NO?=
 =?utf-8?B?QmtzaXpZQmxJNHNYOGorSEhrOXJSekZZYTJjYUFmcUlreDRpQ2E3R2tFK0ts?=
 =?utf-8?B?a244OTV3YXNnSitCd1hObDJxakRtVXhrdHllSDMrYnNrYlRBVnExNUdhWk1C?=
 =?utf-8?B?bjBvQkR5R1RVSzR3dnN6OTZqMDRNYmp2NmZCQWhyam4wNHlzcnpaUUNLbDdZ?=
 =?utf-8?B?MjhXM3l5aW82ZkYyVm1MSmxHSFJBZTFWUnRibVFhcWxpOFE0dFVML1RmWFl3?=
 =?utf-8?B?anZncDI1cTRyMUNyU2JPc3dNUWtjRmthZ2EvYlUwc2FjNFF0SzVObW5DUFk0?=
 =?utf-8?B?MGlCSnJwRE94VDVQSTVuRGpwYTgyeVhqM013ZXNMaVdVVjlsWnQ4Tm9CSWxo?=
 =?utf-8?B?c0dHTlp2UERUQnVReWRQajhSVXlCdXcwdjFMQ0RNYitZdUJwdkJKRWtzVHRz?=
 =?utf-8?B?citzaklnNzF2UkFHMVV2Zi9Sa3Rabnk4b0NwSUFZckZLK0ZGWHAwWjFyaHJX?=
 =?utf-8?B?MFVJQmlXMU1lcWo2SjduUVVpWmEzdFhveVI3MFArc2lVK1NPWWhVeHgyRHpv?=
 =?utf-8?B?NEJldnVtV0pUOTVPK3NjN3FvU3Qyc1lseTFQem5ZOG02bmsrdTdsam5CaWdm?=
 =?utf-8?B?TEdkS0lTVHo5bTQvT2FoVnNOUmVUQUl2c1gyZFlmM1NxWGM3L1g5ZkF1Vnor?=
 =?utf-8?B?T2p6ZXRWMVArM25TSlJSM0dHQ3VKMlFNRlJsQ2lDS2JkQThUVkdZUm9IMVRK?=
 =?utf-8?Q?bQO3A7co1jvJ5JDduUkNl5yVR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5445f326-e82b-4af5-97bb-08db347b4e65
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:40:40.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSP9txJCTArTl9k3oG5b0PVmhwkMafZYKY38Vqwlq8XLbcmkl8iMGevIm0XdXgeBYP0PQElrzarPfukl2JYDfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 15:32, Borislav Petkov wrote:
> On Mon, Apr 03, 2023 at 04:42:44PM +0000, Yazen Ghannam wrote:
>>  int amd_smn_read(u16 node, u32 address, u32 *value)
>>  {
>> -	return __amd_smn_rw(node, address, value, false);
>> +	int err = __amd_smn_rw(node, address, value, false);
>> +
>> +	if (PCI_POSSIBLE_ERROR(*value)) {
>> +		err = -ENODEV;
>> +		*value = 0;
>> +	}
> 
> Why not put this check in __amd_smn_rw()?
> 

I don't think pci_write_config*() sets the PCI Error response like
pci_read_config(), AFAICT.

I think to solve the writes-ignored problem, we'd need to do another read and
compare it to what we intended to write. That could go into amd_smn_write(),
if needed. Unless the PCI kernel API has something like this.

Thanks,
Yazen
