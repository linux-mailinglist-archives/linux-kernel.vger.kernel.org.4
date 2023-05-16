Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F2E704685
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjEPHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjEPHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:36:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFBACE;
        Tue, 16 May 2023 00:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLlpqYBiT+PaqEV42c2gYhwkUYP/zTjLPCJQNYmca3vRUXlkqX/hauUNp5HFOE7N2zUtEWRfCDnRdmXMJDMSLcc1fOTD7BpT6fs0BvQJy5JcDtTqnRoigEOlsGnS9Hi6EA7E7wgjmw49oC/pFhqxg1RAdtN9nWrc4p70uiKKrRZcYwdHcPz2fmSaNmAoPgv4JvdKyCyEiRS+b68rh5+q173QPKIviZ95QjxVcMYzRPhdf6rVVr8md/81oCR3zJzSdC1XCyKghLJB5HJ5SS5lIDvuya7lb80/ZPLsCleoce0B+/OI/SE1UHxgBDJGbzSHHXdk/ZngJlLnCtocdxe3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wLIVglnSaNKEqRDsIKEAybaj1zY2HeICKLxxmz1Eos=;
 b=YfSEqkZJNPtgHWeBZcSdBk94CVcsABPjaIP6tqXoUhFBvHZkpOWvISY8GkuJP41ytMvoIvT8UJ/OExANCxXPD2oX+tiTfcRCR4k4e8Byov2MYmq3fJ0wLnGXbVS1Sjd5e/VDNJpgS9C24Q9s1Jgq/SBcB3x88sUlkm2D/JBSZKiR+lBokfW/PIaTqk2gy01DW+yFR4eNdCfit02ClRY4eV1reEWgDALA6qKW0hNsJOPJ2/yExLPYVvWCsWu0/wszLYa2TM/2JHn3FYZuOJUNlCNzZUYoPF3gLc/QqE+7Ck/MlZa2uVKcaBKij2T13Igw9mF2sEzZ4Cul9qKpL3cC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wLIVglnSaNKEqRDsIKEAybaj1zY2HeICKLxxmz1Eos=;
 b=FjG467uZHbecMs6YHNq+n95rcFWwesePuZJi9Hcy25pTxJX8BEx3tbOKXqryEXlD8SvFh19O0WCl83lCNJ5xuu0DcxqXtujEs69I4gCVIoE3IuNWF1i5NxjVIh3BGOcDrtQ3I0s8pO0yo9wvrLMT0IgKHG92PQuc8c01e+jL4nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 16 May
 2023 07:36:45 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 07:36:45 +0000
Message-ID: <168e9039-feb0-0f4c-8aee-96a3bae7faca@amd.com>
Date:   Tue, 16 May 2023 09:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC
 Controller
Content-Language: en-US
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "Larson, Bradley" <Bradley.Larson@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brendan.higgins@linux.dev" <brendan.higgins@linux.dev>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "hal.feng@starfivetech.com" <hal.feng@starfivetech.com>,
        "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>,
        "j.neuschaefer@gmx.net" <j.neuschaefer@gmx.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vaishnav.a@ti.com" <vaishnav.a@ti.com>,
        "walker.chen@starfivetech.com" <walker.chen@starfivetech.com>,
        "will@kernel.org" <will@kernel.org>,
        "zhuyinbo@loongson.cn" <zhuyinbo@loongson.cn>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
 <20230515181606.65953-9-blarson@amd.com>
 <BN7PR12MB2802CE1DBDB6ED8413AECD53DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <BN7PR12MB2802CE1DBDB6ED8413AECD53DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 1039c4e2-f127-475c-a505-08db55e04c60
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oJLh+YZjxwt/rGlxh7YmnWr3FuF1irCpUDvanVS3lMj3UAp4toZkV0PxbSCRmY/3AWKdMQ++DbJHHZzDpgsVJpU3IRLYuR7y6xrP8EfYWbDzXalSHXVNveeQiwVHtyn2Adc0LlaywBn3qNJDClmoH5Zvx1kvBu8ZJ+mLodxRxUSeTT882z0FUQJXHVQxana5Hv2A2d+yys2Qz4MXiea5CcSj3bSS5ltk2lVoSXjmfjkmNp3xCE6ijAdsNA1fyc5BJ0OWUCMTHGF4Fl2/C0TZSovJ4zRsuWVGEh8rUEJYp2R4r3bs3pAWBQMXBKk8FhvHUb2ymhXuKqeE0sU/W35JADWZbaEngJCvsrgKfovz74pVdiGtrcV+FBRBxpLGRMnoVVf78h9x5qRr8oEILGeaTqD3A99TpOvR2A4yMkhyNDu7k70Ih0NAUIDh33TjvtQWBtRXtoMNTAbsazvmRDIeWb2geYVnxS+oRxjXTahcZHqzQgnsndSAjkn0r2fnSlHAtfMYQ1afbhK026vrPD0a+ijbWdtMLpLbdTjL+2OigcqojIE6Ef2uSEdIM6p2NxKVsrjC0c8HtF09b8Iuqq8Be45IfLpBjER284zqfrHRpYsiXNVKR8MQNqafEbLfzgKB0YzDd5d8I3uQVZ6ay7vfgVwY9L1hsgosOtIMVAInF4OJaJZ49279hjs8WEfI9yW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(966005)(36756003)(6486002)(54906003)(110136005)(30864003)(6666004)(4326008)(41300700001)(8936002)(2906002)(7406005)(316002)(66476007)(66556008)(8676002)(7416002)(44832011)(66946007)(478600001)(2616005)(38100700002)(31696002)(186003)(86362001)(31686004)(83380400001)(26005)(6506007)(6512007)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tZVmllTDMra0dFbXJ3SVlvL3V2OEpZOEswREJTMDloVGNNcWVNUEtMRTZC?=
 =?utf-8?B?U2dQcnE1SFJiTFJDWUJpMURIZFFGd3lRWmppWkpNN0JZM21vc1hlbjJuSmQ2?=
 =?utf-8?B?UUlXZGJ4ajZpOVAxWlozV3ZkTVIwYWpJamJnZW1SeHoxdDdxQU5YYmlCZWpE?=
 =?utf-8?B?ZHBYdHgrSUVoaFdiVTFEdjM1bzgxYkl2Rnk0U3BjZFlJZGQ0RE9oRVhBY1lG?=
 =?utf-8?B?Q251aExzQ1JwdnNLK2RrYlRuRm5Oc21rMEljUEpYZ29qMTFSVXBsKzZlTGho?=
 =?utf-8?B?TWtpV1NoTDdHVTZLTkxGNEZHTzIvU1FjZkd4QktmQlF0a2cvUHRnS1RoeHN3?=
 =?utf-8?B?bTFPUzdHRnEyeERFMVM4UGFXZ0JuWHBrK3FhSWpoNlBiY0IySlA5MVRTWTNa?=
 =?utf-8?B?T05jbXdKbG5GQzZ0Q1BqZWE4WUJ3dEZxOUNBY2N5QllWSE1aUkV4SU5GNlBw?=
 =?utf-8?B?SERreVN6ZWZRQjlDWmdKb3ByR1dDS25NOWgyT2NWdzJIZTNlZ1Z6S25XeGl2?=
 =?utf-8?B?U0t1YWQzV2NIT3E0bGZNekdLSE8yako2a2ZGOFlucEExQjRoODJOejBXRzVw?=
 =?utf-8?B?MmtkeXhZSWRpa1FMTC8zempieFcxeDkyT2cwZENjSlNyVVk1VGZPTS9Zc3k4?=
 =?utf-8?B?UkRjcjJrNU4vaVpJZWN5SFVEVDRDeFZpQ3hMdHpVRmRUNHFCVENwQ1d2eG9q?=
 =?utf-8?B?bXJqclU5KzBNR1RjTzNTTEE3R1FudFV3M3dMSHRyM2l4S1JDRTJCQldERS9q?=
 =?utf-8?B?SlVDTzdZWmVJUVZCclBDYnNNQlY3dmwyc1dZTG5CaUF0TVUxNFNHTXp0U0RZ?=
 =?utf-8?B?M3BKNzl2MVlBYnBzd3RLSm9scmdNYTBJNEVXRHpTN1dvN0JqbUlCaU91cy9J?=
 =?utf-8?B?ZUh6T1N3YThLMlhVVkJrWkRXNmZiUGI1VDFyQUMxQUxPa2xTK3NOdkJyeks1?=
 =?utf-8?B?d2NpR0FVN0FkWEhQc3grT2JlK2xHdWxwSklmdk96QTZyTVlubi9oVWRwbVNK?=
 =?utf-8?B?WkZPQ3lvbDZTaWNRNzJIR2poQXpDZkZnTzJHdkFBUjN3aW1uYmFEdElOMk45?=
 =?utf-8?B?UGxZN0todVFuVVROMmkxKzNPNkhVWDdOOHZORmV1V1p3eGxaQjNDVHhtQVZN?=
 =?utf-8?B?SEliVWI5OXJPQXVpZVkvVnRvMlNZM21Nc1ZkM2NTaDR0bHZLT2ZXSGIvcm9E?=
 =?utf-8?B?NXcrSU1ybGZYc3dEV1ZhdGxURjk0a3JKYWxBSlNicGRJdEp1NWtHamp2ekly?=
 =?utf-8?B?SFhVdzljbS80d3h5ak1IZ1FXRXlyN251YXFjYVcvYmQ3dzdmai9QamVBRFBi?=
 =?utf-8?B?NkFidlRuMmhmSXRBME91MTc0OEhGY2xzc0doeU5qTHpBYVlyazFUNkpyUzVP?=
 =?utf-8?B?WnliQjBVdXNHWlprQWZvVHc4dUxnSXQ3ZHJyMnhvSEltdHdudDZyT3RGbkhZ?=
 =?utf-8?B?dCtvMWFRYW9oM2pCR0xSSVh6L0Q3blBkY2tScGZiT0JkTXRLUldEWGplRU14?=
 =?utf-8?B?RHkxR1FweGhVWDFCRjkwYnZFRm1GOUtaUHdDRCtYMzJVeDdQRGxSV1E0M2FL?=
 =?utf-8?B?eWNiSHpoVW1zZFh6Y0JZU2plcW0xTTB1aExYQVVCZFBTUitGQWM4TVVwUFRN?=
 =?utf-8?B?SkNNelpSY2pmSEZ6K3RkdDhsa1Q5bU11bkdHMkNTT2ZiaEpJY0hGSlM5cGVZ?=
 =?utf-8?B?QlJEakRyVURVZC9DMU9UMCsreUEvODR5RXViMXJzMEhZTnc4eEFZS0pRU085?=
 =?utf-8?B?akNCYVZ4RTZ6TFZzcEhGdHMwZ29rZFdTaXFoR1hDVDFHYVBNQkNtcVdiQnlQ?=
 =?utf-8?B?MFVhankxRkMrQUwrNStoaU0zMzh4ekxNb25Hd2hReDdvdGpLZnRtbXNyVE9l?=
 =?utf-8?B?am5COFFrTGVzTWpjSjg4RWRrYUdpYU13VnhSVlh0bGxobkRqYUVZMUpNOGs5?=
 =?utf-8?B?VnAxNmRheDVEbDRUbFJsRUVkaUpENFY2TUhOSjUwRDFHYU5CMWxhaTM0OW1r?=
 =?utf-8?B?UDBDSHZhL08rSlA4Q1NoekpaY1l5dlZEcFpCeXRsT1JLVVI0eDlZbzVaV0Q4?=
 =?utf-8?B?SlY1UmoxMEhOaTlwMjI3bHNxeTBzYVFibFVTcHFyd0pkV21sclZ3cUJrcTFW?=
 =?utf-8?Q?CM9jeV7XtZlaCtdGED4ClHIDO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1039c4e2-f127-475c-a505-08db55e04c60
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:36:44.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnOoYx7BrwEXEanLepMBGbdyBzWrJCUhXjHPIriyMMgn5ae5BseIp+lcAwBjMo5r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/23 07:19, Mahapatra, Amit Kumar wrote:
> 
> 
>> -----Original Message-----
>> From: Brad Larson <blarson@amd.com>
>> Sent: Monday, May 15, 2023 11:46 PM
>> To: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
>> spi@vger.kernel.org; adrian.hunter@intel.com; alcooperx@gmail.com;
>> andy.shevchenko@gmail.com; arnd@arndb.de; Larson, Bradley
>> <Bradley.Larson@amd.com>; brendan.higgins@linux.dev;
>> briannorris@chromium.org; catalin.marinas@arm.com;
>> conor+dt@kernel.org; davidgow@google.com; gsomlo@gmail.com;
>> gerg@linux-m68k.org; hal.feng@starfivetech.com; hasegawa-
>> hitomi@fujitsu.com; j.neuschaefer@gmx.net; joel@jms.id.au;
>> kernel@esmil.dk; krzk@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> lee@kernel.org; lee.jones@linaro.org; broonie@kernel.org;
>> p.zabel@pengutronix.de; rdunlap@infradead.org; robh+dt@kernel.org;
>> samuel@sholland.org; fancer.lancer@gmail.com;
>> skhan@linuxfoundation.org; Suthikulpanit, Suravee
>> <Suravee.Suthikulpanit@amd.com>; Lendacky, Thomas
>> <Thomas.Lendacky@amd.com>; tonyhuang.sunplus@gmail.com;
>> ulf.hansson@linaro.org; vaishnav.a@ti.com; walker.chen@starfivetech.com;
>> will@kernel.org; zhuyinbo@loongson.cn; devicetree@vger.kernel.org
>> Subject: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC
>> Controller
>>
>> The Pensando SoC controller is a SPI connected companion device that is
>> present in all Pensando SoC board designs.  The essential board management
>> registers are accessed on chip select 0 with board mgmt IO support accessed
>> using additional chip selects.
>>
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>>
>> v14 changes:
>> - Save 8 bytes of code size by swapping spi_device and reset_controller_dev
>>    in penctrl_device
>> - Code simplification and clarity from review inputs
>> - Set penctrl_spi_driver.driver.name to match compatible pensando-elba-ctrl
>> - Remove unused include in amd-pensando-ctrl.h
>> - Rebase to linux-next 6.4.0-rc1 class_create() API change
>>
>> v13 changes:
>> - Update include list in pensando-ctrl.c
>> - Change variable spi_dev to spi throughout
>> - Removed unneeded variable initialization, simplification of
>>    error checks, remove extra castings, and use dev_err_probe()
>> - Sort the includes in amd-pensando-ctrl.h
>> - Updates to cleanup if there is an error in penctrl_spi_probe()
>>
>> v12 changes:
>> - Fix gcc-12.1.0 warning:
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202303120925.SxLjwOd2-
>> lkp@intel.com/
>>
>> v11 changes:
>> - Fix the compatible to be specific 'amd,pensando-elba-ctrl'
>>
>> v10 changes:
>> - Different driver implementation specific to this Pensando controller device.
>> - Moved to soc/amd directory under new name based on guidance.  This
>> driver is
>>    of no use to any design other than all Pensando SoC based cards.
>> - Removed use of builtin_driver, can be built as a module.
>>
>> v9 changes:
>> - Previously patch 14/17
>> - After the change to the device tree node and squashing
>>    reset-cells into the parent simplified this to not use
>>    any MFD API and move it to drivers/spi/pensando-sr.c.
>> - Change the naming to remove elba since this driver is common
>>    for all Pensando SoC designs .
>> - Default yes SPI_PENSANDO_SR for ARCH_PENSANDO
>>
>> ---
>>   drivers/soc/Kconfig                    |   1 +
>>   drivers/soc/Makefile                   |   1 +
>>   drivers/soc/amd/Kconfig                |  16 ++
>>   drivers/soc/amd/Makefile               |   2 +
>>   drivers/soc/amd/pensando-ctrl.c        | 368 +++++++++++++++++++++++++
>>   include/uapi/linux/amd-pensando-ctrl.h |  29 ++
>>   6 files changed, 417 insertions(+)
>>   create mode 100644 drivers/soc/amd/Kconfig  create mode 100644
>> drivers/soc/amd/Makefile  create mode 100644 drivers/soc/amd/pensando-
>> ctrl.c  create mode 100644 include/uapi/linux/amd-pensando-ctrl.h
>>
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig index
>> 4e176280113a..9e023f74e47c 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -2,6 +2,7 @@
>>   menu "SOC (System On Chip) specific Drivers"
>>
>>   source "drivers/soc/actions/Kconfig"
>> +source "drivers/soc/amd/Kconfig"
>>   source "drivers/soc/amlogic/Kconfig"
>>   source "drivers/soc/apple/Kconfig"
>>   source "drivers/soc/aspeed/Kconfig"
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile index
>> 3b0f9fb3b5c8..8914530f2721 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -4,6 +4,7 @@
>>   #
>>
>>   obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
>> +obj-y				+= amd/
>>   obj-y				+= apple/
>>   obj-y				+= aspeed/
>>   obj-$(CONFIG_ARCH_AT91)		+= atmel/
>> diff --git a/drivers/soc/amd/Kconfig b/drivers/soc/amd/Kconfig new file
>> mode 100644 index 000000000000..011d5339d14e
>> --- /dev/null
>> +++ b/drivers/soc/amd/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0-only menu "AMD Pensando SoC drivers"
>> +
>> +config AMD_PENSANDO_CTRL
>> +	tristate "AMD Pensando SoC Controller"
>> +	depends on SPI_MASTER=y
>> +	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
>> +	default ARCH_PENSANDO
>> +	select REGMAP_SPI
>> +	select MFD_SYSCON
>> +	help
>> +	  Enables AMD Pensando SoC controller device support.  This is a SPI
>> +	  attached companion device in all Pensando SoC board designs which
>> +	  provides essential board control/status registers and management
>> IO
>> +	  support.
>> +endmenu
>> diff --git a/drivers/soc/amd/Makefile b/drivers/soc/amd/Makefile new file
>> mode 100644 index 000000000000..a2de0424f68d
>> --- /dev/null
>> +++ b/drivers/soc/amd/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_AMD_PENSANDO_CTRL)	+= pensando-ctrl.o
>> diff --git a/drivers/soc/amd/pensando-ctrl.c b/drivers/soc/amd/pensando-
>> ctrl.c new file mode 100644 index 000000000000..a7ddd181dfe8
>> --- /dev/null
>> +++ b/drivers/soc/amd/pensando-ctrl.c
>> @@ -0,0 +1,368 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Pensando SoC Controller
>> + *
>> + * Userspace interface and reset driver support for SPI connected
>> +Pensando SoC
>> + * controller device.  This device is present in all Pensando SoC
>> +designs and
>> + * contains board control/status registers and management IO support.
>> + *
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <linux/amd-pensando-ctrl.h>
>> +
>> +struct penctrl_device {
>> +	struct reset_controller_dev rcdev;
>> +	struct spi_device *spi;
>> +};
>> +
>> +static DEFINE_MUTEX(spi_lock);
>> +static dev_t penctrl_devt;
>> +static struct penctrl_device *penctrl;
>> +static struct class *penctrl_class;
>> +
>> +static long
>> +penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg) {
>> +	void __user *in_arg = (void __user *)arg;
>> +	struct penctrl_device *penctrl;
>> +	u8 tx_buf[PENCTRL_MAX_MSG_LEN];
>> +	u8 rx_buf[PENCTRL_MAX_MSG_LEN];
>> +	struct spi_transfer t[2] = {};
>> +	struct penctrl_spi_xfer *msg;
>> +	struct spi_device *spi;
>> +	unsigned int num_msgs;
>> +	struct spi_message m;
>> +	u32 size;
>> +	int ret;
>> +
>> +	/* Check for a valid command */
>> +	if (_IOC_TYPE(cmd) != PENCTRL_IOC_MAGIC)
>> +		return -ENOTTY;
>> +
>> +	if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
>> +		return -ENOTTY;
>> +
>> +	if (((_IOC_DIR(cmd) & _IOC_READ)) && !access_ok(in_arg,
>> _IOC_SIZE(cmd)))
>> +		return -EFAULT;
>> +
>> +	if (((_IOC_DIR(cmd) & _IOC_WRITE)) && !access_ok(in_arg,
>> _IOC_SIZE(cmd)))
>> +		return -EFAULT;
>> +
>> +	/* Get a reference to the SPI device */
>> +	penctrl = filp->private_data;
>> +	if (!penctrl)
>> +		return -ESHUTDOWN;
>> +
>> +	spi = spi_dev_get(penctrl->spi);
>> +	if (!spi)
>> +		return -ESHUTDOWN;
>> +
>> +	/* Verify and prepare SPI message */
>> +	size = _IOC_SIZE(cmd);
>> +	num_msgs = size / sizeof(struct penctrl_spi_xfer);
>> +	if (num_msgs > 2 || size == 0 || size % sizeof(struct
>> penctrl_spi_xfer)) {
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +	msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
>> +	if (IS_ERR(msg)) {
>> +		ret = PTR_ERR(msg);
>> +		goto out_unlock;
>> +	}
>> +	if (msg->len > PENCTRL_MAX_MSG_LEN) {
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	t[0].tx_buf = tx_buf;
>> +	t[0].len = msg->len;
>> +	if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len))
>> {
>> +		ret = -EFAULT;
>> +		goto out_unlock;
>> +	}
>> +	if (num_msgs > 1) {
>> +		msg++;
>> +		if (msg->len > PENCTRL_MAX_MSG_LEN) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +		t[1].rx_buf = rx_buf;
>> +		t[1].len = msg->len;
>> +	}
>> +	spi_message_init_with_transfers(&m, t, num_msgs);
>> +
>> +	/* Perform the transfer */
>> +	mutex_lock(&spi_lock);
>> +	ret = spi_sync(spi, &m);
>> +	mutex_unlock(&spi_lock);
>> +
>> +	if (ret || (num_msgs == 1))
>> +		goto out_unlock;
>> +
>> +	if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
>> +		ret = -EFAULT;
>> +
>> +out_unlock:
>> +	spi_dev_put(spi);
>> +	return ret;
>> +}
>> +
>> +static int penctrl_open(struct inode *inode, struct file *filp) {
>> +	struct spi_device *spi;
>> +	u8 current_cs;
>> +
>> +	filp->private_data = penctrl;
>> +	current_cs = iminor(inode);
>> +	spi = penctrl->spi;
>> +	spi->chip_select = current_cs;
> 
> New set/get APIs for accessing spi->chip_select were introduced by
> https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e60e8a3
> please use these APIs instead of accessing spi->chip_select dricetly.
> 
>> +	spi->cs_gpiod = spi->controller->cs_gpiods[current_cs];
>> +	spi_setup(spi);
>> +	return stream_open(inode, filp);
>> +}
>> +
>> +static int penctrl_release(struct inode *inode, struct file *filp) {
>> +	filp->private_data = NULL;
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations penctrl_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.unlocked_ioctl = penctrl_ioctl,
>> +	.open		= penctrl_open,
>> +	.release	= penctrl_release,
>> +	.llseek		= no_llseek,
>> +};
>> +
>> +static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg,
>> +u32 *val) {
>> +	struct spi_device *spi = penctrl->spi;
>> +	struct spi_transfer t[2] = {};
>> +	struct spi_message m;
>> +	u8 txbuf[3];
>> +	u8 rxbuf[1];
>> +	int ret;
>> +
>> +	txbuf[0] = PENCTRL_SPI_CMD_REGRD;
>> +	txbuf[1] = reg;
>> +	txbuf[2] = 0;
>> +	t[0].tx_buf = txbuf;
>> +	t[0].len = sizeof(txbuf);
>> +
>> +	rxbuf[0] = 0;
>> +	t[1].rx_buf = rxbuf;
>> +	t[1].len = sizeof(rxbuf);
>> +
>> +	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
>> +	ret = spi_sync(spi, &m);
>> +	if (ret == 0)
>> +		*val = rxbuf[0];
>> +
>> +	return ret;
>> +}
>> +
>> +static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg,
>> +u32 val) {
>> +	struct spi_device *spi = penctrl->spi;
>> +	struct spi_transfer t = {};
>> +	struct spi_message m;
>> +	u8 txbuf[4];
>> +
>> +	txbuf[0] = PENCTRL_SPI_CMD_REGWR;
>> +	txbuf[1] = reg;
>> +	txbuf[2] = val;
>> +	txbuf[3] = 0;
>> +
>> +	t.tx_buf = txbuf;
>> +	t.len = sizeof(txbuf);
>> +	spi_message_init_with_transfers(&m, &t, 1);
>> +	return spi_sync(spi, &m);
>> +}
>> +
>> +static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	struct penctrl_device *penctrl =
>> +		container_of(rcdev, struct penctrl_device, rcdev);
>> +	struct spi_device *spi = penctrl->spi;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	mutex_lock(&spi_lock);
>> +	spi->chip_select = 0;
> 
> Same here.
> 
>> +	spi->cs_gpiod = spi->controller->cs_gpiods[0];
>> +	spi_setup(spi);
>> +	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
>> +	if (ret) {
>> +		dev_err(&spi->dev, "error reading ctrl0 reg\n");
>> +		goto out_unlock;
>> +	}
>> +
>> +	val |= BIT(6);
>> +	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
>> +	if (ret)
>> +		dev_err(&spi->dev, "error writing ctrl0 reg\n");
>> +
>> +out_unlock:
>> +	mutex_unlock(&spi_lock);
>> +	return ret;
>> +}
>> +
>> +static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
>> +				  unsigned long id)
>> +{
>> +	struct penctrl_device *penctrl =
>> +		container_of(rcdev, struct penctrl_device, rcdev);
>> +	struct spi_device *spi = penctrl->spi;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	mutex_lock(&spi_lock);
>> +	spi->chip_select = 0;
> 
> Same here.
> 
> Regards,
> Amit
> 
>> +	spi->cs_gpiod = spi->controller->cs_gpiods[0];
>> +	spi_setup(spi);
>> +	ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
>> +	if (ret) {
>> +		dev_err(&spi->dev, "error reading ctrl0 reg\n");
>> +		goto out_unlock;
>> +	}
>> +
>> +	val &= ~BIT(6);
>> +	ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
>> +	if (ret)
>> +		dev_err(&spi->dev, "error writing ctrl0 reg\n");
>> +
>> +out_unlock:
>> +	mutex_unlock(&spi_lock);
>> +	return ret;
>> +}
>> +
>> +static const struct reset_control_ops penctrl_reset_ops = {
>> +	.assert = penctrl_reset_assert,
>> +	.deassert = penctrl_reset_deassert,
>> +};
>> +
>> +static int penctrl_spi_probe(struct spi_device *spi) {
>> +	struct device *dev;
>> +	struct cdev *cdev;
>> +	u32 num_cs;
>> +	int ret;
>> +	u32 cs;
>> +
>> +	ret = device_property_read_u32(spi->dev.parent, "num-cs",
>> &num_cs);
>> +	if (ret)
>> +		return dev_err_probe(&spi->dev, ret,
>> +				     "number of chip-selects not defined\n");
>> +
>> +	ret = alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
>> +	if (ret)
>> +		return dev_err_probe(&spi->dev, ret,
>> +				     "failed to alloc chrdev region\n");
>> +
>> +	penctrl_class = class_create("penctrl");
>> +	if (IS_ERR(penctrl_class)) {
>> +		ret = dev_err_probe(&spi->dev, PTR_ERR(penctrl_class),
>> +				    "failed to create class\n");
>> +		goto unregister_chrdev;
>> +	}
>> +
>> +	cdev = cdev_alloc();
>> +	if (!cdev) {
>> +		ret = dev_err_probe(&spi->dev, -ENOMEM,
>> +				    "allocation of cdev failed\n");
>> +		goto destroy_class;
>> +	}
>> +	cdev->owner = THIS_MODULE;
>> +	cdev_init(cdev, &penctrl_fops);
>> +
>> +	ret = cdev_add(cdev, penctrl_devt, num_cs);
>> +	if (ret) {
>> +		ret = dev_err_probe(&spi->dev, ret,
>> +				    "register of cdev failed\n");
>> +		goto free_cdev;
>> +	}
>> +
>> +	/* Allocate driver data */
>> +	penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
>> +	if (!penctrl) {
>> +		ret = -ENOMEM;
>> +		goto free_cdev;
>> +	}
>> +	penctrl->spi = spi;
>> +	mutex_init(&spi_lock);
>> +
>> +	/* Create a device for each chip select */
>> +	for (cs = 0; cs < num_cs; cs++) {
>> +		dev = device_create(penctrl_class,
>> +				    &spi->dev,
>> +				    MKDEV(MAJOR(penctrl_devt), cs),
>> +				    penctrl,
>> +				    "penctrl0.%d",
>> +				    cs);
>> +		if (IS_ERR(dev)) {
>> +			ret = dev_err_probe(&spi->dev, PTR_ERR(dev),
>> +					    "error creating device\n");
>> +			goto destroy_device;
>> +		}
>> +		dev_dbg(&spi->dev, "created device major %u, minor
>> %d\n",
>> +			MAJOR(penctrl_devt), cs);
>> +	}
>> +
>> +	/* Register reset controller */
>> +	penctrl->rcdev.dev = &spi->dev;
>> +	penctrl->rcdev.ops = &penctrl_reset_ops;
>> +	penctrl->rcdev.owner = THIS_MODULE;
>> +	penctrl->rcdev.of_node = spi->dev.of_node;
>> +	penctrl->rcdev.nr_resets = 1;
>> +
>> +	ret = reset_controller_register(&penctrl->rcdev);
>> +	if (ret)
>> +		return dev_err_probe(&spi->dev, ret,
>> +				     "failed to register reset controller\n");
>> +	return 0;
>> +
>> +destroy_device:
>> +	for (cs = 0; cs < num_cs; cs++)
>> +		device_destroy(penctrl_class,
>> MKDEV(MAJOR(penctrl_devt), cs));
>> +	kfree(penctrl);
>> +free_cdev:
>> +	cdev_del(cdev);
>> +destroy_class:
>> +	class_destroy(penctrl_class);
>> +unregister_chrdev:
>> +	unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id penctrl_dt_match[] = {
>> +	{ .compatible = "amd,pensando-elba-ctrl" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct spi_driver penctrl_spi_driver = {
>> +	.probe = penctrl_spi_probe,
>> +	.driver = {
>> +		.name = "pensando-elba-ctrl",
>> +		.of_match_table = penctrl_dt_match,
>> +	},
>> +};
>> +module_spi_driver(penctrl_spi_driver);
>> +
>> +MODULE_AUTHOR("Brad Larson <blarson@amd.com>");
>> MODULE_DESCRIPTION("AMD
>> +Pensando SoC Controller via SPI"); MODULE_LICENSE("GPL");
>> diff --git a/include/uapi/linux/amd-pensando-ctrl.h
>> b/include/uapi/linux/amd-pensando-ctrl.h
>> new file mode 100644
>> index 000000000000..e5f9f0dfe146
>> --- /dev/null
>> +++ b/include/uapi/linux/amd-pensando-ctrl.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Userspace interface for /dev/penctrl

You are missing AMD copyright here.
Also in DT patches I have seen that you didn't switch to 2023 year yet.

Thanks,
Michal
