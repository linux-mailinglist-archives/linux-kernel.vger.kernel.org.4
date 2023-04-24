Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA26ECE48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjDXNbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjDXNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:30:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993B6EAC;
        Mon, 24 Apr 2023 06:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebnI5j+B4cV+zOldrvZHtvjnT9vw6ZxiZ19nisD77EHb/v9Q7ap1wnqlymzqzxShac6t0L6epVf+Bv0LLtuio7ndAxYR5SkvZbzMhiQzCpRKBmpmyKzviRq8cAPaGZ2ZP1MU6hom+0S8AT9wujkimYr6p6HWkd5xfMBhC2qWPx+y1SNmtKBpqMadh8srHJFerrEzhVC7TFbaKULbCp1+HaybmMUofACbNQ8O4yvoIIiDLbGh628VLjfzeCM4fCY1ARV9+Os5QVpmONSAvbGo8HP55ZwcY3FwaYUb0hcVg6wIuEsngKPLzP+7evwXAnkSWJdeMnD00D2WSrUDVlAuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaiUONY974Vt/7czJ9N7zUudaFBQkTaFlN3o3uI7/Qg=;
 b=btIVBCowza0QUz5ZcsfBY0VyvbZV60qS965yhKXgcP5YPOw6I8FJa5FLyaK1tI/gIhEz1195VnZNm1ylpxU50ntHPEmfmqPUD78eotITZLY7E5nRCUV9/r4Mo0qJygekv0AemWmtJS2q7UHD94h+Gj7tNjRuv5l4+SpG/+ITBv3vnhAp8jDi2W6uoPsqjdZHgJENJI3EGDU7a85wmeyX9UIDWLVjFWigLRFDGW4ASCcJDoJspaaxfzHakDx3xuH2XpwXNsxLiNL3vEbOrLC2qaC5GjO2kvVN5/l5/ENs85y/hrXZFDTg5uYcGKFPQv3GhnymZMIW8X64kMOxDGiKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaiUONY974Vt/7czJ9N7zUudaFBQkTaFlN3o3uI7/Qg=;
 b=SWTf6U5oFyA1ujC8SpYdSeM2tUcZQfW1CUjvF6my/sQoGeesaxWLTzqRpVMCLv87JnVLVrwC762hgSY6qohPcK+r1y11NwRs6Mk9rlXX7XsTteU5fIVIAZQ6f9wychZjAEUv8bHJMDOrOP2pp2d8yWeZUuhrd2WaQCN7csrKXHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:30:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 13:30:09 +0000
Message-ID: <9912a4ce-a819-9289-02be-71546161e95b@amd.com>
Date:   Mon, 24 Apr 2023 08:30:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] thunderbolt: Clear registers properly when auto clear
 isn't in use
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        S Sanath <Sanath.S@amd.com>, richard.gong@amd.com,
        Sanju.Mehta@amd.com, Takashi Iwai <tiwai@suse.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421140725.495-1-mario.limonciello@amd.com>
 <20230424055851.GR66750@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230424055851.GR66750@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c534ad-3746-49be-5678-08db44c80623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRq7qIo2LNj55HZG6vaNGeidWce3pjbE9XvbXa/3guJlwdsMAfI5V8z7EAuREG1klgPHt1wcOjvWHUndRhqst/tIqFeIvYGYerEXvamKSbcTZ3aFhBiwVNaiqxlqepCjUuuXIul8fiGrPXOsDg8Yyt44i0Fe2kRV9dMcz7Dt8Pxd3ki0lYCZCK8uowbS1/swt+EtGsQ7f9sXn7D+iZU1GVtrVYwqemVyA+giiuVW9mho3zpvauxUKfVbNEYxBOBFdio8rX3To3okMfz0VQ8FAHBirmglNwr4CdykGaR3ioYEJ4Doe66j0vWbeaVLf6PzMaxvJ0UdSVmKD7Xriyc/grZiDAceKgKasxG2nYusQGeAwUKAT7g2nd9XAOjJl30qQXgSOm5RLgpG/gTPfY366y3CXpdFJxqJ+qwaXrToqfKBp5mYwfMHucoEGesgOcwFfPII5Dch3WRJ0uChv+S3ZMVMg22aTerH/Y4hDU/Hxv5w++1PxMTfLzSRIIt4rdWKIRozx+11zFWGqacz3Ln89Om3mR469sQQEFhnLch69NjA7JOrDVnlzMLJLq4J/f6jPHHlYzL9whQiC/GTOGe5e711EsWrgssA6OxUPdueujQepE0U9+3CqxWsrzZAtgH66WKojNAxIa3ZsQu83xTWFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(6486002)(966005)(2616005)(6666004)(6512007)(6506007)(53546011)(186003)(66946007)(66556008)(66476007)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(44832011)(5660300002)(54906003)(38100700002)(36756003)(86362001)(31696002)(83380400001)(84970400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUIvejVtMDdpb1RScnRXR3NKU1lyeU1WWmNUemI5VWIrR0NWR1pzOEFuejhM?=
 =?utf-8?B?NTlhZ2JMcG1hOUwzRG91bzRYdmRzSGNhMHh2UFh4a3V6R3ZFaUd3UzVOem4w?=
 =?utf-8?B?YmlZc2xEM0V0RjltUXVWTENnQ1ZqS1pOTllyNkZ0a2grL0NVWU9TSmZmSGts?=
 =?utf-8?B?ejkzZldveU1BVUkwdjlQcEhHNFR0UzBtVkJpKytyWWxjdXpQOEFBbVFYeFc1?=
 =?utf-8?B?ZW5QTE05UTlrdEZ1VzlZeS9SR1I3cmJ6djcwanM1T3Z4RjBtaTRMYWpnb0FX?=
 =?utf-8?B?U08yUXhsdS9pV3hlbnlnNVhmVnNpRTJnSlhjVHVJUEdsSy9oeERJbGlCVlp3?=
 =?utf-8?B?RFBjbVZkSzJWQ1VYYk4wMHZMemdBQ2E5NFdHRW5TV3BOL3NXTkxnNk1kVXdz?=
 =?utf-8?B?MmIyeVRsWUgyKzQ0d2poai9tZm5HOWhmK0F6Yzd6TjJyT0xtS0JwYUNiZmp4?=
 =?utf-8?B?MTBhYVR1ZVd0TGJPVVZxWGxnUWVGeE1CNlVmdWhpc0pjUzRva2s4SEpjd2ZI?=
 =?utf-8?B?ZUxQNjNEbkFiMmZXRm9DWTZiajNWbk41KzJ6Y01TeEJiNUNsTk1PWXloSDlk?=
 =?utf-8?B?ODJ4SW02UGY1M3BmY1dvUCtPUVduTnh4SzZpM3d0UTlQYytKOGg0OEh1UGhQ?=
 =?utf-8?B?RlNhU1V1TWZBWlNMSHR6UWRKZUNQdGlXQWxjdmhrSStVUFV5MDM4dEdZNmI3?=
 =?utf-8?B?Q05jVTdaWG9Ya2pxeDNVYm03Y1ZXZ2JiUTN0a1VJNHFmRHBBRE9GcGJta3Bw?=
 =?utf-8?B?MGdqQXdEVk5QNjRQNXhQQThpbFFUSnN5bnMzNVlWVnBjdE5ndHE2c3BUMG9B?=
 =?utf-8?B?aEhhZEkvNVI5byt2TC9EZ0g3cFdMU3BBbHpGZWlMZTJqWFplNjRaVGEwQ0JX?=
 =?utf-8?B?ZXZmMGZEVko5VDdaOGZmc0xSSWJ4QXVsMzhaMFlRemVqaVFLUkNMNGVpUUFF?=
 =?utf-8?B?Y2dMY3IvNEhoWjNXaFB3RFBYSnF6SDJrelBhTzVSM3FHY2pjTTB2MjBnVENF?=
 =?utf-8?B?SUdURHJiYkZHZ1VnOGtlQWI0RkhsejJjNWJjZVRoYTZqc01LQk55bmR4c2Rq?=
 =?utf-8?B?bmtMTm9jS3VQWXVhV1RXK0hRakZGTXdGRUFoYXgxOWIvQ29CZTFVWEdRNEt4?=
 =?utf-8?B?Mk5LM1VtQ0dKQjRpNll6Yys4eDNJZU1sMzBaTVBBM2l4ZkN4ZG9QTEhMRG8z?=
 =?utf-8?B?dnM4VGJlbDBaYU15SUtPNUFFQ28zTW93M3JucW5iVVFSTTl3YjhHem53cDdZ?=
 =?utf-8?B?Y2JyUm5iTGpuM2NORUZGTXptRU9xN3J0cC9NekZwbGo4a3o5dnpEb01Xd1Qr?=
 =?utf-8?B?MmY4T1hJYXN5SXY5NXVCdExmelM5akZDNE0rcTh2UlMyek9pVU5hYkpWeGdN?=
 =?utf-8?B?OHdsUldrYlI5OWlJeGFQWkV0dDVZOHBXMGFMQ2NvdTkvVWNqaFlzT3FtTFI0?=
 =?utf-8?B?MHpudU5PT1dhQ2ZEdFpJMXA0YnFheVRXSjQ3Lzh5cjN4THdEakhvdTZxcENo?=
 =?utf-8?B?alFGTFZLNmRCZUpsM3RFbWtoZys4dld1NGE0cjdSaWY2aDhIK09aOVdEVk9N?=
 =?utf-8?B?YlNZV09CeFVqQlY4Qk1Kck5va2Z1MytwTmM2YTVRUERwSUZydi9zZVp4ZjRk?=
 =?utf-8?B?TGYyK3E5OVEyVEtDT2lPZ1RwU3RtSHZqZTF0OWNWUjZGMjlVeE9kMTFMR2xS?=
 =?utf-8?B?NFFqeDJYZ3Q0Y2pXaVN0MC81bVRqWVlWM0NkcDZyZnU3dXhFQ3RVYkFYYWFT?=
 =?utf-8?B?VmVLcWRYcndYWXBTYUk0bzdOVEY4dmp0WDFzcGk1S1Y1eG9hUnVLUm5GYSs5?=
 =?utf-8?B?TnFXSm1xRGkvK3kwUmpZS2s3QUVZR0FtdGM4Y2Rvc1JtVmZaM2EySDNBdklt?=
 =?utf-8?B?eWpROVc4dE1ENE5zWTUzVGhHUGNEdFVGQzRZUjRyRFdmWEtXd3dyR0hJcDZU?=
 =?utf-8?B?c0ZZRUVxMmJEMzl3TnU3SEx0RGhlT2dsSHNISTBZYm5QQjdHYWorU0RvbVZj?=
 =?utf-8?B?SGxtWFZwNjlpVndOb0kwTjRNQ3MrcVR3U3dvMWRHMFVETFN1M0hFTHR5dzZM?=
 =?utf-8?B?eFgwQThiNHVPTm5DOFlDdTYrSHN4ZmtMWkdweE0vaDBNc29jUzR5RG9qamYv?=
 =?utf-8?B?S1ZhalptRk9wYkZUWEM4ejdrSWR4WnA5ang2YWtKbXIzelN4RjJTdHNEOW5L?=
 =?utf-8?Q?LwaqWyjIRwUXdotu3d8XtnObWXJkAKWn/sD92x3M6v1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c534ad-3746-49be-5678-08db44c80623
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:30:09.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxCtu1V6VCDMhIm79w02coPHtGLCXR2TKqlLv8BfsPHf8E6FkNWFpsjH3gr4kWBKN8yYbaXab8OguduMdL873A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/23 00:58, Mika Westerberg wrote:
> Hi Mario,
>
> On Fri, Apr 21, 2023 at 09:07:24AM -0500, Mario Limonciello wrote:
>> When `QUIRK_AUTO_CLEAR_INT` isn't set, interrupt masking should be
>> cleared by writing to Interrupt Mask Clear (IMR) and interrupt
>> status should be cleared properly at shutdown/init.
>>
>> This fixes an error where interrupts are left enabled during resume
>> from hibernation with `CONFIG_USB4=y`.
>>
>> Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
>> Reported-by: Takashi Iwai <tiwai@suse.de>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217343
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Takashi Iwai <tiwai@suse.de>
>> ---
>> I tried to base this off thunderbolt.git/next (tag: thunderbolt-for-v6.4-rc1)
>> but the following 3 commits are missing from that branch but are in 6.3-rc7:
>>
>> 58cdfe6f58b3 thunderbolt: Rename shadowed variables bit to interrupt_bit and auto_clear_bit
>> 468c49f44759 thunderbolt: Disable interrupt auto clear for rings
>> 1716efdb0793 thunderbolt: Use const qualifier for `ring_interrupt_index`
>>
>> I cherry picked them first as this patch builds on them.
> Okay, so if I take this after v6.4-rc1 is released and send it forward
> to for -rc2 Greg it should apply just fine?
Yes; that's right.  I'll rework it for your below comments and that plan 
sounds good to me.
>> ---
>>   drivers/thunderbolt/nhi.c      | 28 +++++++++++++++++++++-------
>>   drivers/thunderbolt/nhi_regs.h |  1 +
>>   2 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>> index d76e923fbc6a..7c543a6a5711 100644
>> --- a/drivers/thunderbolt/nhi.c
>> +++ b/drivers/thunderbolt/nhi.c
>> @@ -61,8 +61,9 @@ static int ring_interrupt_index(const struct tb_ring *ring)
>>    */
>>   static void ring_interrupt_active(struct tb_ring *ring, bool active)
>>   {
>> -	int reg = REG_RING_INTERRUPT_BASE +
>> -		  ring_interrupt_index(ring) / 32 * 4;
>> +	int index = ring_interrupt_index(ring) / 32 * 4;
>> +	int reg = REG_RING_INTERRUPT_BASE + index;
>> +	int clear = REG_RING_INTERRUPT_MASK_CLEAR_BASE + index;
>>   	int interrupt_bit = ring_interrupt_index(ring) & 31;
>>   	int mask = 1 << interrupt_bit;
>>   	u32 old, new;
>> @@ -123,7 +124,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>>   					 "interrupt for %s %d is already %s\n",
>>   					 RING_TYPE(ring), ring->hop,
>>   					 active ? "enabled" : "disabled");
>> -	iowrite32(new, ring->nhi->iobase + reg);
>> +
>> +	if (active)
>> +		iowrite32(new, ring->nhi->iobase + reg);
>> +	else
>> +		iowrite32(mask, ring->nhi->iobase + clear);
> Since it is doing this for all hardware, even for Intel, I will need to
> run some testing to make sure this still works.
OK.
>>   }
>>   
>>   /*
>> @@ -135,12 +140,21 @@ static void nhi_disable_interrupts(struct tb_nhi *nhi)
>>   {
>>   	int i = 0;
>>   	/* disable interrupts */
>> -	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
>> -		iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
>> +	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++) {
>> +		if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
>> +			iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
>> +		else
>> +			iowrite32(0xffffffff,
> ~0
>
>> +				  nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + 4 * i);
> Btw, we have now quite many places with
>
> 	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> 		// Intel stuff
> 	else
> 		// non-Intel stuff
>
> I wonder if we could move these behind a wrapper and then here (and
> similar places) just call
>
> 	nhi_mask_interrupt(nhi, ...)

Sure, I'll experiment with this, it does sound like a generally good 
improvement for the code.

>
>> +	}
>>   
>>   	/* clear interrupt status bits */
>> -	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
>> -		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
>> +	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++) {
>> +		if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
>> +			ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
>> +		else
>> +			iowrite32(0xffffffff, nhi->iobase + REG_RING_INT_CLEAR + 4 * i);
> ~0
>
> 	nhi_clear_interrupt(nhi, ...)
>
>> +	}
>>   }
>>   
>>   /* ring helper methods */
>> diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
>> index faef165a919c..db95ad5d2814 100644
>> --- a/drivers/thunderbolt/nhi_regs.h
>> +++ b/drivers/thunderbolt/nhi_regs.h
>> @@ -92,6 +92,7 @@ struct ring_desc {
>>    */
>>   #define REG_RING_INTERRUPT_BASE	0x38200
>>   #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) / 32)
> Empty line here.
>
>> +#define REG_RING_INTERRUPT_MASK_CLEAR_BASE	0x38208
>>   
>>   #define REG_INT_THROTTLING_RATE	0x38c00
>>   
>> -- 
>> 2.34.1
