Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A86DC66C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDJLwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:52:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53B949ED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:52:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ6svqyAywIDyhz718UxCA0CGF73w8t6DlPRGPxjH6YbT0Jw4CQlzfHhIXS21exXFyu55zRaoQHKdtT392llHZfvslFnRkUSDhh4Q5RUjF4Ji9+bMWiVG3gpOv4cDGUKsAkG3UADgReIg06iNH37WDfQEPRrrrjFL0FQqt8m0srNO6a2KXEwcMttvNmiYb7n82Syt20V0gfxBGzfQVwhNGTPYyBfPdvbKHHLgMNcsASgx5p1v/RWK88FZiMuVBVR6vNSZno158k/9+6oEdoRcydhRDwYeMLDAXF7CBkJlcRg5AEy5jqg+79tToyvvSrMXpZ8GIgOYFZWieNwd8QB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ7+PphVwpBrhYG/B44eSKvK0d3xvhYa1tERBgTYTkE=;
 b=Zt9f730oomQ7wfZOnvQgtSieiuQxxoOjkblmx2aoNxHwjpZduQ4yVJYK+rw+StgX2VGHNE3bdHMn9L5gx6kF4j0GKqoXTCdIIWbc8kOGBqzqOn6TWu1gfEzxFJXE+EUa9Bmszz3EP3wxuLVAWosoFZIYEsKKyemdnrWLLshptG2rXNN1VruXWqIsNOEnmZ6YjGREPcizw+fyJS9Ng24tglS8sD3DZBQ/nkd5zbDFbQJtxDRtBl/bWHzVMOyhQxVgP4HZUaaHd8rXMteOPdBaH6Xj9SM+sumxxIEz2a6SO6Yfns8VTCS4/nRSlgXQrStJ/HKBc7pogbCggOnak570og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ7+PphVwpBrhYG/B44eSKvK0d3xvhYa1tERBgTYTkE=;
 b=focaSW9g5W3lJL6nYrn/FdlIh8+BHGAA6bNr1Ojforr0hhsz/9ulI4lGJFS9w8xbdtSF0Mx0NPRnM28J4yTrFxlDCjlvFylOqmwsNfSnScfLW8yETAPH1WmRhWS4uwy4JmWYblTPELYIxw+zPN66gEN0GcylSjLl1GZZrVuJcZqq7Kw1OCYeoC16GgN+49wpNAzN7hCb+oBcgzgYI3mqBxYCnkJoJF04teOT7O5a8vstbGQ5nWDHQH651Un9gfiyp5xE+/S/TE+I10HqMMQWZLyTHmQ9zrzPkJc40k1+3VMed4GCNa20h441Z/h2Fu/+bZXEk6ZUnPPUr2PDyy02Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 10 Apr
 2023 11:52:36 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a%5]) with mapi id 15.20.6277.034; Mon, 10 Apr 2023
 11:52:36 +0000
Message-ID: <1fd8b9cd-b525-315b-6b4a-23f5f8732676@nvidia.com>
Date:   Mon, 10 Apr 2023 06:52:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] genirq: Use hlist for managing resend handlers
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <20230408171526.3059039-1-sdonthineni@nvidia.com>
 <20230408171526.3059039-2-sdonthineni@nvidia.com>
 <863559mne0.wl-maz@kernel.org>
 <76bc7b50-d47f-e5a7-6aa6-54a7b1492ea3@nvidia.com>
 <87fs9859xr.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87fs9859xr.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::21) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab0d2ba-e0b8-44da-aaf2-08db39ba1354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2Zq3zyE12reRLtjogMlginSYuAkkU6yrnXKvtTcrBaZjvNhQXZrDTZyvFItALF+TjaUQF5fSCQMH+B2E2FQE3IbhONJobV1hke1q5pgG/qYdx4kdWjMhRdL0T4808zD5i0mjNcp7ORocv+N3bxS5oflNx4aATiDUyyMWShuFzhIR2FD3780mWz6gG0YHDQLMJZZuH82pdozT+h4pWuvq0kKGW+cOf5cyL9mSOvhsxBO46AGs/9mokk3MolRBfKxmxmpX/jmhOH6EluTChFLGH8jyyteEjLwqW7BoKFzriP2/Wf18fCKaCUapz9JWHhF7TaWz4gTEWAL2owHsuixDgKSV7S5PyOf/FowC1Ov09dxee6Hrh/42u5A3z13ffH3NbzqosylgvvjU01XFz2/fXMForEPKjAY+5qT0PrjB22RVBr/pw411QdVuSbooDtJtZQtT8OoOfiNZdvklAXZq/yhCwBDYbPn4os8SPQDJ0g67nkx/OizgKm0vkQteaYH2MrhsyhsC97EX9ODJHLilHrznDvDxwT2Y9xt5Lv11yAD8gyEpGlNuMJAe076siGYYRQ3CSaeZYZ0w9bjEatPankGMKI+ImrlZWjr/DRUEWAHRSfpwL03JJUjL2CcgrdNWFsbg3m/ak3+RH30BiWbjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(186003)(2906002)(26005)(8936002)(6512007)(5660300002)(6506007)(53546011)(2616005)(83380400001)(8676002)(54906003)(66946007)(6916009)(66476007)(66556008)(478600001)(6486002)(41300700001)(6666004)(36756003)(4326008)(316002)(31696002)(38100700002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9hdVAwZXJ4YmZNaHdsREtLcHA4OU1zbEE1R0lnWWk4SXJtTk9pTGtKSm02?=
 =?utf-8?B?ZWpNelB4a3FBbmsrUE9QZmpTVjExQllRcHFyVWlJUjNLUGNwbGNVaWMza0hK?=
 =?utf-8?B?VjhFTk1yME1HeFQ5aXpyUGcyRlVqakR1RVd4cThYYnB5UDlzYTM1TVN3OHVo?=
 =?utf-8?B?cmZhTlhXVkRHSmlNSFk2bk1vNFI5a0FBR2dmaEVvMHNTOGwvWWtraXpUVHNn?=
 =?utf-8?B?dDZick9DSU1EV1JQN3VNNFUxeG4raCt3WnBSYmVUZkxVN3daQlZUQlZkNjYw?=
 =?utf-8?B?NG1hQnlTc1VpellqNXFyT2Eyc1NkUVJwV3llbW9xWloxbk1jeWF1MnFQL0F3?=
 =?utf-8?B?U3dpekZlN1R2emM0Uzk0K0lvSFo3cTFVL0NGVlN4ejBQKzI0Z3oxOCtvbDNm?=
 =?utf-8?B?MVU2Z3VWZk9zbENpUWNlMVJHM1JCSUpQZG44ZCt5RE03dmhrUmFjTkg4N2RU?=
 =?utf-8?B?MUw2NWJVYk0yTSs0aXlQREVXbjJjOHRZakN5YkZFOGFUNzJyWXcyem14ZnVE?=
 =?utf-8?B?VTIraHRCczdJRUxMVUdPUStmS0o1bTdGOFRKS3ROeFVTOThqcDk1VzBpZVdh?=
 =?utf-8?B?a25NcDBHVGNFWTFZcDA3Q2dIZUVXaTUxa1dMclVnSlRpY1BIdlh5cGNhNU1s?=
 =?utf-8?B?WUt1K055Ynp0VGZPVmRlUHVZNm5LRFNBUWYzZUQ2WFJVSWlZRUVYMGlyRjRF?=
 =?utf-8?B?VEcxeVYzQUNCQVQyaEcvY1NvOFd4RnRCR2lLZHptQUV0dDFkR2FUcVlIOFJs?=
 =?utf-8?B?Z1N6bk51M2MzYTg5SHZLdmY0RHdFTXQwRUFuanNIQTRzQWNiZ0hzRTFzMlh3?=
 =?utf-8?B?Qmk0Q0lZUzB4eVc4dXJ4MVI5c1N0REFDQ0k5cUMyLzRybVd6L3Z0dVRLZ09h?=
 =?utf-8?B?YTY3TkVxckdndmdBb240VFlZTXNMMGZGUkhOaEY2WnlEWFI4N1g0Umo5SCsz?=
 =?utf-8?B?RnFyM0p0YlhYT21PaXA0cDJLYkRaeUlvWTFHR04vNFdxSlI5K3V5YXBXTkNN?=
 =?utf-8?B?UjZRNE9MUEJLd3YxdzVrN1ljZ3MwVG12QU9JY1RlQ1hGWUlVeS9XeWVlSDlz?=
 =?utf-8?B?WVh6eVMyVGFaVDJaSktOUzRkeGNGejZGMDZXUzc1WXJ1MTN5cHY0MDd5aEI1?=
 =?utf-8?B?WDBGZFRyZWh0WGxzTEdXM2hyS01TMEZ0TmpnOFhmaW5QSnNtVWpDZk9ORVZo?=
 =?utf-8?B?QjVHQ2U3bnFOUk05ajF3eXJudUcvUHBHNkkxZFBRWDMyTkdYaFhPaU5BN1o4?=
 =?utf-8?B?Tlo1UzFydGY2ZExPRzZKdXo1ZXQ3Wkt1bnhEeHhnNythRjBlLzdYM2tRQzQ4?=
 =?utf-8?B?WDhkaktwb21JVmZSeW9ReXVMMkc1YjNnN3JKaXg5MERlSndZVU45Tk5ISXFG?=
 =?utf-8?B?R0NMc1ZiMmJoUzlpczZCUlBVNG5acUZBS1FxakFUSUxyVW1JcWs3Vm1NN21y?=
 =?utf-8?B?YXN1dmdmazFVc09HNW04d2pTTjZkOGpiRHdjaWVYcGxRUDJ5NTN1TTZleTh0?=
 =?utf-8?B?ZW5VTE50QnI4V1p6YnNkaXBGYlVXd0M0RGFLc2RLTmJJSlliV2FPSUJtaU82?=
 =?utf-8?B?aHlONkNwOCsvcEVNQUFFTnFkanBFekdycUdEdXBOQkhvWko4cUhCYm5FOE5q?=
 =?utf-8?B?WjRuWUk1WEljL2NQbXBnMTBmUW9TUkxMdzZQT2RLcnByMDhDZE1rdzFCYWI3?=
 =?utf-8?B?bkVEUUJXdW53d002RWdncnc0N2VoYzVzREhvdWNWVzdRaDJhZlNpdlBld05N?=
 =?utf-8?B?UERaVkxUVng0UG8xM3MrQXlRc0RMbXhNTldZb3pxNGtuajJpbWdCMjdieWhp?=
 =?utf-8?B?RGtvdy9oTzMzblV6Q2xaREVJSDNvNkhUaXVveGxKN2VBUGYrUEs3alo5N0ZL?=
 =?utf-8?B?V1hGSk9IZFdTVzI0RUREQmQ3TzJ5RDBrT3IrSW5KK000UmVVZkpnWjZzbzU3?=
 =?utf-8?B?Y3dSOVExdlhHMGpEbDU2WUR0WW5leGQrVUVRRDhOWlF3eXBnWkpCdzdsNFp1?=
 =?utf-8?B?emtRMEpwb2Z4Y1M4Q01ROWVzSHBhNENRWG16b0pNVGpnWmYwQlI1bjcvUG16?=
 =?utf-8?B?MXZldkljbU9sNkE1VzVsZU5SMXJ5TlJqbnRYWkR0eU9rb0lqZjA3c3VrQ0RK?=
 =?utf-8?Q?OprXkXFiDBMZmUBm7TL4XigUC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab0d2ba-e0b8-44da-aaf2-08db39ba1354
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 11:52:35.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvR7TQnm8nBni1q5D4+et8OrduyZyi4mMSHsUYv1f63CXUit3GK/Ka4k3Q6zyliKhajm/nAKX+CNGFdFVVe5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/23 05:05, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 09 Apr 2023 13:00:27 +0100,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>>>> @@ -30,18 +31,17 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>>>>    static void resend_irqs(struct tasklet_struct *unused)
>>>>    {
>>>>         struct irq_desc *desc;
>>>> -     int irq;
>>>> -
>>>> -     while (!bitmap_empty(irqs_resend, nr_irqs)) {
>>>> -             irq = find_first_bit(irqs_resend, nr_irqs);
>>>> -             clear_bit(irq, irqs_resend);
>>>> -             desc = irq_to_desc(irq);
>>>> -             if (!desc)
>>>> -                     continue;
>>>> -             local_irq_disable();
>>>> +
>>>> +     raw_spin_lock_irq(&irq_resend_lock);
>>>> +     while (!hlist_empty(&irq_resend_list)) {
>>>> +             desc = hlist_entry(irq_resend_list.first, struct irq_desc,
>>>> +                                resend_node);
>>>> +             hlist_del_init(&desc->resend_node);
>>>> +             raw_spin_unlock(&irq_resend_lock);
>>>>                 desc->handle_irq(desc);
>>>> -             local_irq_enable();
>>>> +             raw_spin_lock(&irq_resend_lock);
>>>
>>> What makes it safe to drop the local_irq_*able()?
>>>
>>> tasklet_action_common() explicitly enables interrupts when calling the
>>> callback, so unless there is some other interrupt disabling that I
>>> can't immediately spot, the handler may run in the wrong context.
>>>
>>
>> Unless I am overlooking something, interrupts are disabled within the while
>> loop unless desc->handle_irq() is enabling it. The existing code disables
>> and enables interrupts for each handler invocation, whereas the modified
>> code does it only once for all outstanding handlers.
> 
> Ah, you use raw_spinlock_irq() outside of the loop. I somehow glanced
> over that, apologies for the noise. Unless we expect a really long
> list of interrupts to be resent, your current code should be OK.
> 

Thanks, I'll post v3 patches to address the other review comments.
