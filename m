Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAADF6731CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjASGeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjASGeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:34:08 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607E3C21;
        Wed, 18 Jan 2023 22:34:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmHMbCNlSF67hJE0oym4iBuD9LO0SD6lKNLoWWrtXcBaKPjH7LTdQwANgkMEwstUqGFf1ccPTUd7eONOqfGCxQpY+xoG+i4NxfQGgb+FJSZcLCCmvgtM7iMRSHCamLJOTpEQCQEFVtVO+y3qXX6CQeWwfPEIPPq2hDwsLeE3iBL1m0bCW5ZU1E3YnkckySuV4XeMVO0g2lfud35helCoRCC8Ad2hDDLr8tssvErPBL6H8Q6VHD/U6mtKt6rENsg3YZsTE44PiSV2eLgmUuVhlEVBwUm/2QT5TYaucwUO8Iz8+/pvkgS+ap/HfPUuyqYSx70SgRxg3mMShDLoFBuKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06i5vd0YqFiczbjWPSau/rCPSTpEbV6Nq+I43NBrKyc=;
 b=ZHFbvxwYfcnS57phDeBoj0NjIqvSV3/rnRkAc+RF597dg8aWXEQm7G7ytUj50VHyPgI6yhMS3TelGolgaTHd2b5pZhjHGTmVaK3oQ/fjjF430yt4MBxRjLMc9m6utpieVCY5xh4UaZc2KKEJiStfpMtjgrt5HJDNn+8iix5uHJ5FLCwZ66Ep2BhEvPpKEhYUbabxbgOlInzcHZ52IQAbjWGDmVYlETr7/TV6mQLMZQRbeQ0Ux3YExUIHXkujrrCos2tjcE6P1tWZN16uHvRMl2nSAiATaVFzis4gRNEptSTSKoVjugioOjCWPZ5SPI8VmFm4BD5QeX0t/MSE4xZruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06i5vd0YqFiczbjWPSau/rCPSTpEbV6Nq+I43NBrKyc=;
 b=sIAodlTybDm2ZfWHD39QPICbHlhCGPHU8BBbg5qUZrGYp1EtSJTDWp5oOqbz+18OYg+izymgGr2pNnL0ZEx21VSk8kmdicZ4cxiT/ojzJUyNFn9m2pEdLp+KNXKJz2+i5kYKZqC4uJ/bvgn7MhciSmqA4ot9Y4QcZVn0LVyJ36sbSDCPzz9YkAgUbqnQPbqItlXVpIT6LOuQEhL3v5yERqUG0569HN25/KAOx1lpKaV85TgJRY0TP6pBpVSWAw8s+FMJlwwFZKtq0O/SNgs4wAunOuz+qiycIRSHoJMUsvDPSIbwskK10LXca63/2RqI/H+TR/Y34rT9/yQo+o9iIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6302.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 06:34:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Thu, 19 Jan 2023
 06:34:04 +0000
Message-ID: <e69b28cb-4053-4c62-ace4-bf72062dd252@siemens.com>
Date:   Thu, 19 Jan 2023 07:34:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] arm64: dts: ti: iot2050: Add support for M.2 variant
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
 <fe57b923d3f290dceea4f54724459015a7bad899.1674059300.git.jan.kiszka@siemens.com>
 <cc820b4b-d3b7-9972-a07f-0c9f94f8d175@linaro.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <cc820b4b-d3b7-9972-a07f-0c9f94f8d175@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: a91d8f3a-7fe5-4f20-4191-08daf9e728b7
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2aTRGD/2BG8zZHCEUlgbSD6fRDJQIU29NFQr0XWS7/etW0zcj0LHZA1MywS5aUw89Oz7QNrXkBmv3m1T88sPVC2TuX22R8DaOu8Yfnyz3yjFOszwe6rYCtsPbve4ke7MpSJz4DbpqB/WMrMTjEGBAvtC/3BHTWoduNhbxXBILCm0/LFyyuAT+8gvMwYdK0UJfYySPGIpFrLdvwVf2hIzgN2x7j0ATnxJoVG7k5RfhD1yafw2beDZwcj6T37WOUTqUbrsZRg//79QmXR0nk+i3ogUbuqtWvOzDY6LpHbiwfX6mHYjNciCLQN5X9LSu9BzD3t046HqOIdROHhsTGNetwWQltmp/ipkVtz4IAGAJLzyTFE44l7eINJYXORiBjTF3HynYr0ZVDC+fkiu0Y1cCw73jMWgIbXXKs1iU34Kz0+9YNM/D7ScqY0EszfroYAwPSDJq7AZHCenn6vTn4CJKsUnghufaV5dnQxHFJlfJnyHKZ650akH8QyeX+V4NeyDdZsx2g3In1d63A0j0Dfw2oylQd8lOajx+OobAk0+GePtfpMEEPdoJNkDE6EoiQqtc/o1m1lyjAqtkjrHfA/6kBG8+grKgjS3xVt8Ha73BqZYt0I7jjC86KWEjIKCQERttpWZFX0Ut3TsW7TQqIxLcSCU45Mc8G6ZRnFqjCYQ58FKHpYqVHCj+DjM3xdjiGtkF5hsqqoQ05Gv38Z8DYlnSVdrhDlOs9MYVkS4JYx9cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(82960400001)(31696002)(478600001)(86362001)(6512007)(6506007)(6666004)(6486002)(26005)(53546011)(107886003)(36756003)(38100700002)(186003)(5660300002)(4326008)(8936002)(31686004)(8676002)(66556008)(66476007)(110136005)(2616005)(83380400001)(66946007)(54906003)(41300700001)(316002)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1JSFZiOWV2QlZwSG93R2taSlJCREE0aDRiUDFQREgvSktyNXgwb0xTVXlw?=
 =?utf-8?B?TytWa3Vjcm04cEk5Kys5SHo1YnpValNzZVJ4UkRSeXVneGtlV2NTcEVWL24w?=
 =?utf-8?B?aXlXTFRpckd6MlFCa2ZIZ2V6SlBFRFJJaHptZ3lFQ3RKcUR2Z0Y0YmNNNnBm?=
 =?utf-8?B?OGhRZ28rcVIwdTNPZ1hKQm5ha2FLWnVNeS9KbjVLSVZTQnZMRDJZbU1Zd2Qy?=
 =?utf-8?B?ZERYUEdxVjNQWXJ3MzZEbEoxVUJhMlJNSzBoZ2lDbjZTbzhHN2R5dzEyZGY0?=
 =?utf-8?B?VXVuYWtaTm9DQU5PWjRtZXBJV0tiKzFGNFhDMExzT002SzNCMTlXOGhOUzZq?=
 =?utf-8?B?eXNkMjhLTVdJdU9iajNaZkdYRE50ejlCRTl6TzJGOUFwQXBCb3pWYmFoVkcx?=
 =?utf-8?B?dW1NVE8rNFgzQ2dneDJoYXdzU2FOSC9VUXBieEtTN0VZVHF5WkNJY2M5Y3FM?=
 =?utf-8?B?Y291RERDWSs3bFVwNW80ZWgzU09DUnpyemtKaS90RlFodGgvWEdVSE9KTHRU?=
 =?utf-8?B?cjNWUkFrWi9ra2s3VUNmcFloS2FSb1hhb3hVck9jcldsZXZMSmhPSDJqMFNk?=
 =?utf-8?B?NlJiS2ExSDMxaEVnMDBXbEZMUnJESC9hZlpKc3JhZk5nTmJVdm8zL0lzQmZF?=
 =?utf-8?B?MjdCQmp6TzRId1VWTTYwUmViV00rNnIya1VZQ2JpMUFmVm1oaEF3WFFhSXds?=
 =?utf-8?B?SzhBMkI4aTltSmZhbkcwTy9SalBTdTFVUlRaSVFrSW1DcVdsdzZOQVhMVXJk?=
 =?utf-8?B?K3B5Y1hWN1pmdlNYa2JaYzhGcE1ZRkQ3a1pDb1lCSGRVNXFxNnFWakpIL2tY?=
 =?utf-8?B?U3RsK051c0NPenJZOXVKdkNyazM4R2E5SERyVEtVMnJEQSt4UGUvUHpkd2dJ?=
 =?utf-8?B?ZzBVS0Y1YUQ1L0JaODNDL25rQzQzSStTMzdueHlwQ2RhMUl5THZKd213OC96?=
 =?utf-8?B?ZGZCU0FlV1psaFc3SjhlcWtNUTB0RjFpMXpxTHk5MUI5bHlTU3ZuVlNpb2U3?=
 =?utf-8?B?U2xaL3g4b2NqKytYUTYyMGFjQmsvVWNVR3ltZjRXQzByTC9pVzNMcWNjYWtZ?=
 =?utf-8?B?RjR0SW9XTlhRUUs0ekJpRVFpOERWM2tGY29wclFJaGhySDBrWXVJbXdRdUlJ?=
 =?utf-8?B?NnpDOVNVc2Z4T0ZIMEZCNVdBUG1selZoV2dBSENqcFVTb04xdzBwSzk0TGRj?=
 =?utf-8?B?bWd3VlloUmhieWc2YnIvSjBPZGFxMjZwSUwwdVZiM1B5Q3p6eGpPaHdmM3No?=
 =?utf-8?B?a3dhQVZDTzF0WVRDRWlBVXJxbHJpSWN6b1R2SmpvRjNId3NPMnhGSzhWS05K?=
 =?utf-8?B?WTJaVk5IWVNoQkNjaHJqZWEwbGZhTDRxWkRHMzh3ZHAvbzhyai9xTDdVb0ZL?=
 =?utf-8?B?ZjA2TFV5ZDR3UXBjclVXc2lxdytQZkVHNC9zdk45bWRTbHJIc3laczBhbG0z?=
 =?utf-8?B?VmxydnhrSVVjVktNcG5CelVSeXFITFJsQ0ZvVG45NGFyZkJPZnNCRUxuK0JJ?=
 =?utf-8?B?ZERvVmFIaFlmYzZxVHpiOW9ST3loKzhBRWFoc2dWTDY3amJWUHhzL24wa1dS?=
 =?utf-8?B?WDAxYjUrblJLVE5DRXhsSjhZbDRock5Id1VIblloeUwwZldPeml3S0xIZ0xZ?=
 =?utf-8?B?STZWSVcxbUlMWnBsbzFrWkFadkRLY0EvejdyMjVpSTZZUFBESkF1RWR0YzV4?=
 =?utf-8?B?a1ZLTjNHY29aZmNxSkNKZjA1OW1DRy8rb1dJNHVQMkJGUVczc3Q0SGVKaERi?=
 =?utf-8?B?bmtCYjJwNVlkbkdvV2NFekRtQS9scFh1OWZkVXFRTHBYQStTLzdiS0lzaU5o?=
 =?utf-8?B?V0dMRDlQV3p4Uzg1a2c4bWVGV1pqRlQxTjNucWNWS0QwdEc2aXIrZjNYRkpB?=
 =?utf-8?B?c3MwOEhwTFB3SVRzcEYrVUc2WDZJY1J4aVl3YzRYYXZreXRPVFV6VWJwSDlW?=
 =?utf-8?B?dTFSQmZLSnhKQ2thaVplQ040ZHdQaDE4Ui91TUJVUXNabjZNSWkvdnJjZkJT?=
 =?utf-8?B?WG9wU2R3aFhhRGRBRlovQW4wS09VMHpzRDVwQVdsTFI5ZUEwWEVmbWllL1E1?=
 =?utf-8?B?ZmkzWWkzUzlTTzExOWpmdUVnOFIydmhMOEdSRDVNNUtrM0dkdWRROCtRcXlD?=
 =?utf-8?B?T21ZV1l5cjNZQ2RlTDhQLzl3RzdWQlEwL0V0a25jNjEvNVoxbkg1MTg4eHVs?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91d8f3a-7fe5-4f20-4191-08daf9e728b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 06:34:04.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSV4nv6W6R7E1Ujy+cIsnV9UfKiXC4vtOSV/AzWbjN55mYWr/tRQpkdK3JL5w+t/gAjuzHkeKi37Hs3qeSUumQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6302
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.23 18:07, Krzysztof Kozlowski wrote:
> On 18/01/2023 17:28, Jan Kiszka wrote:
>> From: chao zeng <chao.zeng@siemens.com>
>>
>> The M.2 variant comes with 2 slots, one B-keyed and another one E-keyed.
>> They are configured by the firmware during startup. Also the device tree
>> will be adjusted according to the detect or manually configured
>> interface mode by the firmware. The kernel only carries a single
>> configuration as base device tree. It has to be built with a symbols
>> node so that the firmware can apply overlays for the connector modes.
>>
>> Signed-off-by: chao zeng <chao.zeng@siemens.com>
>> [Jan: refactored to a single DT]
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |   3 +
>>  .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 122 ++++++++++++++++++
>>  2 files changed, 125 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index cf7c509538a4..13e79bf7e804 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -11,6 +11,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
> 
> This does not look like proper order.
> 

It's ordered according to their time of release, not simply
alphabetically. But if the latter is a must, I can reorder.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

