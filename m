Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC17A6FE172
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbjEJPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjEJPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:20:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052511A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4xtQ4aqTV4CmtZhy+9D6j+TI4dQ31oBPuHojiT0ZxwL8pCcONXncXGw9tcu+S4OcqbjRZfLDFzLMuYTqBlUXu3MyJWqghcwcE8FzcowX/2dCNuxt3MnM26tB9FR0wWx60CUq/YOmK17U8qJNuNItzvk9hdXS0ABBrvVzehJE4oA/tV+nPH/c7Vnsgso/fXRynNcLyWhLEpkZHXAQzgZbKPDudE5DUgW0Qw1Y1UjyTRw5tnobn7bIMo6K9hDH+dTiRNWGs2D1y8X2VW3hBEwIqO5ELJtf58O5zXennvvNmbFq56jSSw9O3ndpuBEyh+eHA+aqy+eoAGkt5+jEvo1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqfnvXYKGhNctaqDAMV88WZKJN6XlCfJEq++F7LXPhk=;
 b=fE7zecdW4WZ/mp/evV/beaBmmU8AFETf+emm2DNEEXbS+AdpFWHxqr18SB5E+2L2mZBaSanmd2UupnsCmR9NKvVb71qrjenoMME3jyFV5Qqw7puglgcqwTiXy/Mvwa1ECv8f+sE2tG1HwrpioFMjjvwQcAJmPuL+Ssi6UN+YC2KGpY5j8c89IYZDhctc1dH7D71/BJZ5ZgVXLze1sNDiMT2Cp835gayq6gIGVRRgNTsjyxjT46sHSDs+PhO5nteB7ki2K7FLarHoI0l9Sh4UrJGI/ujfrrIABNxou8arAuek7Gr7rymvHzWjRnxBbE5j9cFFIn52Jv0g20FW943xkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqfnvXYKGhNctaqDAMV88WZKJN6XlCfJEq++F7LXPhk=;
 b=iO9qg6ngYBd6ZmY5Tv52YNuWIjSv1ZERpL/rDbXwommIL7Ghc6MhHHZezvAJEIic3JLL3v5opPpvht5PVjxwncz3FmCbqoNqZJ8EnueQWywCtn1tC1gZPHOHtv6M09si9CuqqbFRyRXGmmur+3LZmaOnXY6a/RqZ+AFqL+1wzR0n6sC2VFiV5WODwocIxerltIP50LXJV/Qv5dH2iJKYyLq7V3+LnRg/u0snWZGca2qhYHftBeBmAA2A9cil0o9Va9DfrVdr54oCcPZYHg6I/4M7a4MLmmMxjRVbsvJ3feSP0c83I9oy2ISwP/fAZ69YyteeohjKIkFKYxZjOdNMXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 15:20:01 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a%5]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 15:20:01 +0000
Message-ID: <e1c50a59-f85a-02bc-6b48-fceaa390b2ad@nvidia.com>
Date:   Wed, 10 May 2023 10:19:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
References: <202304251035.19367560-yujie.liu@intel.com> <87a5yuzvzd.ffs@tglx>
 <ZEsiYbi8dorXTI5t@yujie-X299> <877ctw5mdp.ffs@tglx>
 <ZFdbtipfTsIF0u6z@yujie-X299> <87mt2f2mhm.ffs@tglx>
 <ZFtGvfDFLyHeFVFH@yujie-X299> <87ttwkxn96.ffs@tglx> <87r0roxmvu.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87r0roxmvu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:806:125::23) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|MN2PR12MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: b6efb169-85e5-485f-125d-08db516a05d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoSag4NCAEvAnkXOn4+ebJqWL9axrKwhyl51sXqJend4eobgH+O0v2msDh1ioPcgHOObYetGtrQSA32VP8u+PovctocvrUBhHDaWCilc0kNYgBKpo1rw/mepGDua2N0YYjjuWk14rI+ulU0jIwKb5RiY/OnIOBjt3vUjmkqaPFgLEWOK7pp7TojQNs3VzEf6ZJT8vya1PCslEwnJw8aGdTbNQsrFuI6E5IK4NRvzMjZYD46Q5k91tcL1M2Zxm3KkdGGLqG79eh9T1f1zVeCl67rk5/gCsuOz+yn5l4qJ8lRKkSz7N58SdkdFXxhlEljToMcIxOH8SkZbjRZR8AGWw4sL7byfejZuqOAZpJ7kWyx1nY2kU9ue2TXHrcPLnwGgGPDndY0aHn1BIB5pzELMPfjYkGVce5CQcK2NjOiCTVDtgxWYpelsZwmkv1C0+5wa21xqiGgWbBIofCZNjYqW3ygIqqbExFvJdq08bpNOxffo+Ch7TDci+gwaDpe7KlMEINyHpTtwToczDPn4+7CQ4o4RIoLTkVpDX8j/64sesv5qWwvnirR1YBDl9huLw/Sz94ZFGik1In+xuJs3JR7yqOPfTvyHXFWnbdn/tR0Y+My796yovwaFMqRbKVfS2P4Dgx821uaMw8zyfIAsWsXae2qq8SCq/Wr0eLpDii+s9TIXkDSwelCfP23IDqc1hhvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(5660300002)(41300700001)(31686004)(316002)(66476007)(66556008)(4326008)(6916009)(66946007)(26005)(478600001)(8936002)(186003)(8676002)(6512007)(6506007)(6666004)(966005)(6486002)(54906003)(2906002)(107886003)(53546011)(36756003)(2616005)(83380400001)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU43SFB4am9IWUNIaXRtcVd6YklxQUI2L1dyQmVQUVJFdmFDc3FLOGNoMHRW?=
 =?utf-8?B?SDIxZUdKT2RoUUx3VWpCa2RYREhSdUp4T0RrQlMzUEVreXF5Y0dpc0lRanZU?=
 =?utf-8?B?dTU3cFNEUnN0NzJhUUU3VnJib2lHZUI4RzhEamN5SzUzNU5lMVN4aTV4Zllu?=
 =?utf-8?B?Um05emd4V0hvVEwrZ0x5R2JjZVM1V3A5dytpRGZDTyszWEFKWGJmU1RMaFBo?=
 =?utf-8?B?a3ZkdGN4NGVudXZHbmhUZlhhNUZ4TE1MTlJWVndWSERIUWd3a3JPd29qSkZ6?=
 =?utf-8?B?YmNuT01CWG1BN2pFV0hLbzRULzdwSlIweXYvcUlZZHNJK0ZWTzVFL1hXLzRl?=
 =?utf-8?B?b2lxVnIwQkNLSW9HWXNYVEhQaVVZUDlVRTdTaG4rRUFKVHhET3JyRjNYZ3RJ?=
 =?utf-8?B?V3VUcmgrSDAxRUdSS2VCMXVXZHNGdkhOK3k5alM4OXRVUDBsMHVwbGFDbmFE?=
 =?utf-8?B?OHByYVFNN1NDbU1Ha0RUL2x3NXJoOFdyQm13dGdQM2hJZXlWVENiZkFlMlp5?=
 =?utf-8?B?NjN3b0lpdVFweXcramdPM1djNTQyRUhVajExZDlnU1pFNTJ6SUpwUUtSakhv?=
 =?utf-8?B?aUhURk0rbXdSOHZiU014ejRXNGVOSlAyYjh5MTUyZGRJVjhWVEMzbGJmeW54?=
 =?utf-8?B?cW9FZGdNM1hJa3VyeCtlUDRmMzIwbG9XYW53Q3pGYWN6MWNKUGdqUDMrZnl0?=
 =?utf-8?B?QU9xcytKb0lFalF6bkZIdkdsd0UvY3JpOE9iMGYxUGlNT0xoSjJBRkVzMW81?=
 =?utf-8?B?M2lzcVZVdUtBeGR5bkFQRlZyVGJiYmhKN1kvc3JWcjJ1TWRpVXdkaUxheUE1?=
 =?utf-8?B?Wm5TallLNzMzK2szNmJrd3RkaURWdm5MOUFSc0Q5dGxCeXZ6ZTd4cSt5Q3c4?=
 =?utf-8?B?RnR1cEYvYTA3bWNDU08zcVlJTkY4akRtSW9jekFZZEVFRG95Snk5YmRFVTJk?=
 =?utf-8?B?VnYzYmJneFU3dnRYclFhbHVBaUJDUEREQmhjYkJyck4wQnlkR0ZCam5QMC9F?=
 =?utf-8?B?MFhKeGNLc1d6NC9icVE2cXJkYlpmTTFFVzVlUk13VFhQYlNrbjgyRXI2bVhS?=
 =?utf-8?B?cEZjcU9GeE5uR3hVWDRrTFJFcVFyTkN4aUx2eUlqZXhPbEtXSmYzd1pXUk5Q?=
 =?utf-8?B?UG1lSlh0bWc1Q0JQL1BYZHBqZEdvUm50bm5UcURDVHhvZWdYTy9taGU3eUpq?=
 =?utf-8?B?TnZzSEExendZL1U1dWJRRTlLWEhxZzhCd3RjSVV1L2tpNlpRYVVuQ2NzbGRO?=
 =?utf-8?B?MGdHckgrcHFETEZaMFJITTlHemNzU2MzVFZQVUJUVFh0bWJEKzI4dHNlaXRT?=
 =?utf-8?B?cHo4c0hSRUlHZFQrN3NjZ1ZVNkVLY2pOb0xKN1BhSnNhWkM1b1RxaXlvQ0Rx?=
 =?utf-8?B?MENKME0wTStnV1pieWlJak5VV2dTa2F3VUllcFJVOFpNS2VINXY5bm9QVktG?=
 =?utf-8?B?bGZyNlA4WEw4alJBcDNXaWFHUTYzSmUxN3FGaFZ0V0Uzc05BRDJNM3V6SG0z?=
 =?utf-8?B?MzA5SlNaZTVGRXdIc2wxekZWNE5WWVIyY25iVTIzSFpReVNFN3dHUElCQlRJ?=
 =?utf-8?B?azBnTTVkM3IxTmQvcmRydUM1ZnJlVUFVUFVsNFh0elhWZFlqR1BEOE5NdWls?=
 =?utf-8?B?UStQa2gySmdtTUFVV01iR29BVkRGd3l1ZmhycW9oVG5lOFhzT1dIdXRHeWlE?=
 =?utf-8?B?b2lIZ1ZRRFRyUzhpUGE5blVKN0MrOFZvMFM4MzZwWjUycDNxajNwNmFJM3I0?=
 =?utf-8?B?L01CWTI5OTF5OE5FaVB5TzlCWXRhVW5uYVlzZUF5Ym1JSnErOUlUSHNiclJ2?=
 =?utf-8?B?OWpFNzlUT3dITWFOYlFpNWF0TERCSDkzZUNCSWQ4anRML05pUXlYaENlWWR6?=
 =?utf-8?B?MFNkRzM4d0ZyUTI2UlArUThlS3VWMXo4TGpsdzB6UFpweHdEV3ptbEpkRFpI?=
 =?utf-8?B?UlBlVHByVG5yRG1aaUF3ZFhUNWRWeWFMSFYrRkN2SWJXOGJUaU9kUVhoQmc5?=
 =?utf-8?B?YVJmMEVOdDFza3NVRzNxckhiYkNhZU1vb0JRNURXZ2Y3bTE0VHp4RGZIT2hC?=
 =?utf-8?B?YkVrMlRyb2M2ZWMrWmUvWExUV0hBL216dDNjUkZXR2V3NENuQVlwbVVSWmtU?=
 =?utf-8?Q?sCPoAzjchskE5B0YA/CwiiV8j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6efb169-85e5-485f-125d-08db516a05d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 15:20:01.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXOUIuSqNvc9s/htxZv3K/KkAqh9+MAiudIkh6HE3YGC17zM4anOK9fWc0s2FgQfRkYmNv4ZNsImHdT05qrkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas & Marc,


Apologies for my lack of familiarity with the maple tree data structure and
not testing all functions. I received advice from the review comments below
regarding the iterator. I am looking for your guidance to address the issue
with the iterator if not possible can we increase NR_IRQS for ARM64 arch.


https://lore.kernel.org/linux-arm-kernel/875ydej9ur.ffs@tglx/

static unsigned int irq_find_next_irq(unsigned int offset)
{
         MA_STATE(mas, &sparse_irqs, offset, nr_irqs);
         struct irq_desc *desc = mas_next(&mas, nr_irqs);

         return desc ? irq_desc_get_irq(desc) : nr_irqs;
}

-Shanker

On 5/10/23 09:49, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> Shanker!
> 
> On Wed, May 10 2023 at 16:41, Thomas Gleixner wrote:
>> On Wed, May 10 2023 at 15:24, Yujie Liu wrote:
>> I decoded it by now and that maple_tree conversion is the culprit. It
>> broke irq_get_next_irq() which is used during hotplug. It misses every
>> other interrupt, so affinities are not fixed up.
> 
> I'm seriously grumpy. You throw that untested stuff over the fence,
> pester me about merging it and then ignore the fallout.
> 
> This breaks cpuhotplug, debugfs, /proc/stat, x86/IOAPIC and some more.
> 
> It's not asked too much that if you change an iterator implementation to
> validate that the outcome is still the same on the usage sites.
> 
> That change has never seen CPU hotplug testing. It reproduces
> instantaneously in a VM even without running blktest.
> 
> I grant you that the documentation of mt_next() is incorrect, but that's
> absolutely no excuse for not testing such a fundamental change at
> all. It's neither an excuse for ignoring the fallout and wasting other
> peoples time.
> 
> I'm dropping this from my to-merge list.
> 
> Yours grumpy
> 
>        Thomas
