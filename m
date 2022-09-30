Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18D5F0395
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiI3EcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiI3EcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:32:09 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E81C5CB1;
        Thu, 29 Sep 2022 21:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8GvSYxjcOpys9IDPw9xBLNju8kDShTypW2H3SIjzz2RjOUtE75DrBYpjavpnwBcffUmzSzUIuKtD52pkPuMD8y6OuDIET6if5Hxjeb1+CIi8+CUah5ONJm0cuvRrY0PHigQpzsUI1QsTM5vs0J8sqyNBhSwvwC+oUu+Yl140b9IeI83v2wH12OTAgVN68JhgoI2KMaI7CzuhAXOFy9MufMxI30GFp9oMOTMsw8rXJ/YLor+OVrefhrwFPlnn2fqWcvUmzxMbQkb7P1bp3JwmW9EfckPs/Cy4Zq4j1Mmtx4Pc/Gs/xdKVzAUQSNBfyz9j1YyNrBjKvYOwjb7+MjRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boMlzncREZsQPY43yXh1DGiGvXtp8fgFEsnWO0hLrm0=;
 b=RBxdDpM2xQbE6/zw0TpYQDktUuvKAEkRyWza8yLgOoji0VZCthOe5eLIdBQXAwKuLuchhxltrjex/81MRtzf+752BI65lDXnvEhVV61+FiaejurWsNvlOJxM9k316oA0b5I2r9vT+oMzZ1WMXNLPWkuPSuuUbjI9OgL/oCaWdLThUvVDpU8qyqxuip2VTNF04bBQ/gDXITAu3aX3gZWZ125OfJ5kYdaKpdUTw710PdiLQA09yT/0oFxzJEfeNtaRFBIkZD78GKXjfRvbNe5SyrxuBzWw5IW8I2Wlsfsv6J6x8AurBihTitMToXmrkLc7QfKpI5C/DucnbDqt+N078A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boMlzncREZsQPY43yXh1DGiGvXtp8fgFEsnWO0hLrm0=;
 b=QhvYxvWDo3dQFXQ6mqKwxMyseu58wT/aPNVGaeKtsoaEvmZI7KfOntR6xc2eaIgGhOGCcRqvW53IWsQrmYK0bWfN/7KiT/jzu5gaLCslReGb2eBdiXdlpNC+HHLnoXUgJIox05pXnegTVafH071QP6taCw3IHQYBASaUSYQQ/lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 04:32:06 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::3c18:7a48:4291:c9b%8]) with mapi id 15.20.5654.025; Fri, 30 Sep 2022
 04:32:06 +0000
Message-ID: <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
Date:   Fri, 30 Sep 2022 10:01:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
 <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 359d9833-5984-42e0-2c4e-08daa29cbaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4cTckfJbVpN4irZrIaUy3mzuunSQb617znxkOkddJbNHFuegm8dCgRbjyNz+gbVUC5aep84Go61a1RJcXaKE7dVJkm2uXFlP18fAogVsgis5VB8PYwqldHjl8FfvoPzFOIQ+BXqe1Aso40dLXBNqqVxnnj1FbXmhtkhRhZjKnahwWAJdQSpnFc7M/LehSdtnAjvme4ZvQ26mVKZGTrMY1x3d4s+5pGwaHlEDkFFH3Nw4rCdsKVwbPp74IQakREhV9F2i1cmehFopKyvAkaFllbKTTi+kY3pIgI+cOEhXkaDmoxh0HtcRjbb5RpPm5RbkofFktzW4vzyYBr7L8nC7Cm+BOgstokjC2lkNAyMu3vVMwQiVh76Z7TQ0hJqZAVIKJTljQawYg67F8LeCVEl2chJ3bKE0nz23wxLVtMF0UunKDIiEDlHRyMtfTgAWTUFaCvW5ylrI/06YXuq9qYdw94g1dP4yxLYGapqlTVTPiU6UAYZT7PqWdRqu143cWHrQtLtL0xVg4yeH4YbBElvviWonalN9x1snbBhctefF1ExNNHO17F/SWsZSAMauXrA6ihThYHLVaZLL2s2TYm/JBYMXuwbgZZ4pgw45VembwIAxJundE8NWTV6Id1j5GWAFbgynOXgdgzfYd1Hhhh8aAUu0pnNLi4Jq8o85PcnoGEl/FoDl3xqUau8+7pXfPsY783AVRLBO1UWk1NkE6bzK15s2tEanQqfaS5nMxN5t3NZYrSUd3BFU9dBR+a673IXnBiDOPn5AdS/5diJ6l2xG3GxjYpWKtYDGGuEAQSUbbTfIJIOuhcnEl/q0b05sr1ryrniwU72JZcvu4XkiCYysfRmHO2KrhIfuBqKEjL6AxaQ/+IzMKqIGAhg4g4HPExD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(8936002)(186003)(2906002)(2616005)(31686004)(316002)(66476007)(66556008)(66946007)(41300700001)(6666004)(36756003)(6916009)(966005)(478600001)(6486002)(54906003)(8676002)(4326008)(44832011)(53546011)(31696002)(6512007)(26005)(86362001)(5660300002)(6506007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlMVStLbEhDVGpCcDNNWHRKMGdienZRdnE0cngvMjlFRlRuRlVLNE5NbjhT?=
 =?utf-8?B?TCtmRWhVdjkxMHYwWTFuTUU4NnBsYzZJQVM5bnUwbXM0T29XakU4WU50cXJ3?=
 =?utf-8?B?M3NqTllWb0VmcWdEb2NFNWZ5dTVDM3EyQzF0clVienl5THBMZTVRMk5qeHZJ?=
 =?utf-8?B?L2F5THBvU01aQWdQRyt1dXZudGpXTmlVcHFLMkRiNDZNNC94OHoyTnFBTEVY?=
 =?utf-8?B?R3hiNXlQMUFmVFEyU0VzM3pZN2xIZGFXQndXR0YwVWExN0FHeitnajQrNGhO?=
 =?utf-8?B?Tm81L3lzR2V3WGRtOUVIK0dsZ0xzSW5hU2NlbFRWNUVGSXhSa21yVmJKb0oy?=
 =?utf-8?B?bTh2RWtONmV2a0xzTDJJVTRJUGlUaStiZGRRU3RQdkFVYnNtb29qbFdTbE5U?=
 =?utf-8?B?WVBNemx4MDVYZTBzVE9teEJDVitOTXd3dXV6Z1hSTXU1dXduSW84WTd5dmgx?=
 =?utf-8?B?MnJZT1Fndm9OR2l1eDRKdXpzRFpTNFBxbWY5Y0c5NXBzVlNsZ1hmOWIrS3M3?=
 =?utf-8?B?MWdCOExqNGxsSjNkQWxrTmpkQ1Nkby9yZkdoMS9maDZ0dE9nRU9UR0dUS1dC?=
 =?utf-8?B?cFg1ZjJsdnZRcTNRSStCSGFibm94TWFIdnV4SVhBYjBmRkg3ZzZKNHNwVjZG?=
 =?utf-8?B?REUvYVBQS2Q5THFLaUh6a290dzVrNmR5VjB1Q1J5SFFBbXZITU5mOTdjc3li?=
 =?utf-8?B?VFpUMThSeFNaZEhySmhVaU51Vnpnb1dBa3lBL1NFb2djNnZwNWxxWFRaZVBV?=
 =?utf-8?B?UTNEUGhMa01rK1FHMzVkaWVaQ1lHSnd1UWkzREhjMTZqanorNHdqdkhjY014?=
 =?utf-8?B?d3VCY25nTU9Mdm80KzZtSE9BUk9OSnRFSGhSTjdOa3NQNFo5MGdWNmkyY2R4?=
 =?utf-8?B?V2tEY0o2UWpkcFBOR284ZTc3SEtqZFNJWUI1amlZZitNQWFLaUoyNWNSWEkr?=
 =?utf-8?B?VmRZaG16cm5aNWlMN3p6RXJZckxYZXlaNVF5Vi92eG56MlJpYmNiZllzRm9k?=
 =?utf-8?B?aE5uYVBiYjQ3dDV1ZEorZFZnYXNsOGRMdkRVVmpMY0szSHZNbUkzQ0ZaYXk1?=
 =?utf-8?B?R3A4UlVkYjliT2k2WDdlTGRMczZsVjZ2SDBsTG1PY3NZZjhCZ01LQmVUSmxo?=
 =?utf-8?B?ODhVdjY5eG5odzE4Tkhja1B4R0x6ZlJldVN2UjN6NTFMUWZFR25oMWtNVkR0?=
 =?utf-8?B?akVQOXpvU3ZiT3MwZHhzbm9UU3hLVzF1N1MzamNtSTVVREJycStSTlV4S2Jt?=
 =?utf-8?B?ZUFjUmxSQzdVaGJ0NUxNd2dESW5tbFNMbzBmN0VKbkZ4bHNXTEJIVVBNS3g3?=
 =?utf-8?B?OFp3MFJ2cWVldXpKU2NoaTBzT1lhZERMR3BXSkcwak13UG1tNVdBN3gwRWxE?=
 =?utf-8?B?ZUdmV2s2V2hZK2ZHeHdWN2pmWHVXbFdlZjluc1UzeUU1WnJudThmWVBLd3Bh?=
 =?utf-8?B?bGJPTzg3ODlzNUVLbHBiZFFhZTIrb1ZrTVpQeFo1TEhiYXFIbjNnR2Z1RnFv?=
 =?utf-8?B?Y2RIQWJlM1F4cE8rZWFycDJXMGp4VE4xOVd6MnRjbVAwUENpRkpBRkxmelpC?=
 =?utf-8?B?ZlFSVCtPQnpmVjliWWpqYy93TUN1RCtCWWZFMjd3RlN3Mk45MUc3WHp3Uzdl?=
 =?utf-8?B?RUw1QkdBand5aUtEWG14Q2RiRFgwcnNIVGk1UFpXdWlhTHZxczRUY25obW10?=
 =?utf-8?B?b0tudndTU2dBeUpYeFNWRTllek1hNVVPZHd0eE1Xb2VQV2dYOWxXL3VObnM0?=
 =?utf-8?B?bmJWV3VLRFJMNFNaN2cwUW90NG44YUFlL2MwNWJGRDRBaEdCVEl1VkFPZEhY?=
 =?utf-8?B?d0VjYjcyNHFIOWtOeDM5OGwvR004M3oxYUU3N1IxN3o3S3lGL2xGMlVXcEtq?=
 =?utf-8?B?TC9BRzhWMHgwQlk1VjVvVnp6N0Q0Q1ZzVEZ6dDdnV2dMSmIxUUNvdE1BdVdN?=
 =?utf-8?B?UjNqdktyNjdaazN5bE9oaWNIbms4blVXOVFtU3N4cWtrN3JGR0hsZ0EvMTVm?=
 =?utf-8?B?SXJ0eTN5N3E4a3EweDBoNTlkMWlscUFFWVhDVzBwRm11djlXUnUzdEZpdVpS?=
 =?utf-8?B?ZEhwZUl3ZHNOZmZsR3VlTVdsTlJaQU5OeURyY0pSWTd5UkNEOHBNSlpzRDRx?=
 =?utf-8?Q?gxaJIyxBrKiE+vBLBdyvxX1IX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359d9833-5984-42e0-2c4e-08daa29cbaba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 04:32:06.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7cPlk/by3jVJeDsA+lC+Xd8n91BDCuW5VIWod5cfW3gatxBb6VXgsmvCoex3QymqCIWiFXSYAx++UxMarANYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Sep-22 9:56 AM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Sep 29, 2022 at 8:49 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Sep 29, 2022 at 3:10 PM Slade Watkins <srw@sladewatkins.net> wrote:
>>>
>>> Hey Nick,
>>>
>>>> On Sep 29, 2022, at 5:54 PM, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>>>
>>>> I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
>>>> Is this a known issue, or am I holding it wrong?
>>>
>>> Hm… I also remember this. I have a Zen 2 based system that I can do testing on, so I will do so when I’m able.
>>>
>>> If I discover something of note, I’ll get back to you.
>>>
>>> Cheers,
>>> -srw
>>>
>>
>> LBR isn't yet supported for Zen but is coming:
>> https://lore.kernel.org/lkml/166155216401.401.5809694678609694438.tip-bot2@tip-bot2/
>> I'd recommend frame-pointers.
>>
>> +Ravi who may be able to say if there are any issues with the precise
>> sampling on AMD.
> 
> Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
> since it has no task context.  Ravi is working on it..

Right.
https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com

Thanks,
Ravi
