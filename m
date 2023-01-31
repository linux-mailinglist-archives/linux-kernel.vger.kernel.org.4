Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0E683356
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjAaRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjAaRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:06:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08936C164
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR2u0GgNA1k2VkgsxWk0K1anLk4U9JH0iFMFW7OyB7hIGclTebukegAXMj81pF0dcrEKcCYX0PhfLm2pf4ykSFjsJctoc+CKYZ9wdDruqqW5OhzY98BSbPiKJyBTy1VFpKgyl4zR8+IXwXltC8vzhlQikBW7US05/7i5p+ackoKNVj27fwyUP18QFYj5zGMX+pfQyFoArwhr9fC2lg2bv9PVg1Q5dlPiBok8whzHyN1NZJObzXy42b6UdoEr9eFzUFM/ky8zb0dbmzvTki60LmMM1ErUgm/7awgRU3FnoM6I9RYgJFhIBWUw1kPhO0dhq1dnMGvLqBqVckFNu5BOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke9S6wd5/kqk/zsjwM/xRSZXPfzMP+mDZOndvyVSv7Q=;
 b=ZX5FI1K/1/fU4mmRnOns19QFcWdHUxadiqzRnwo49i19/dzjbZKuEFxMvgRm8PILuVaz4dEibOgA3wCNXjg9HsDxGhTmoZtkEKq9WGgdjBmuEVPzmTj/nCslKipWCwJWqXLShU3kIiz8Is/bvdmPziCUgqFjlurOKgjFB4rszrN5ZFmoCVH632gMCv0oVI3fxFhuHladcTt5QhB4no2EeiY1sPG9f2CVAq0wDO09dBPjpUXCb/JkRHVo0XNVNEBdnZoyLRL6jA71G+l5jRsLc7D47nbLtnDG7uumTk3L7ebDL8wJdwhrBwWGcLSMphKUpYuzmimhBGOBJ1T3JPHPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke9S6wd5/kqk/zsjwM/xRSZXPfzMP+mDZOndvyVSv7Q=;
 b=JKPOA+TITJ1v0h7knvuI7HgR/eCIDNdEjlXbSf+6boUaHecst/lWfXqS35RSLPmkJUFziq4535499c9nbtPTJUjVkZMPUcNRkfl6huW6zi5JcG5AOWQDf88kqSo97NGc5rliKYP3hrXhNt2St54gUgswnH/WEruonk/A0s5jvih/oxwU7K40U6QQVClHA4w5Hg7pqhDER9rHAy6R8kWqszfrE+BCKcKAG7m3wowFDS1lDJv6t7kuouINABJ1okMa+g0FzzTTvDkEcKW2iev4xU49OtMVnqkhOX/SGb0kID5z51dr68qyhwULFGJgojEQl4bNzaQ3MSMcCcnc8lN/9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:06:23 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:06:23 +0000
Message-ID: <0804e457-27ae-a046-a3f5-73497511c841@nvidia.com>
Date:   Tue, 31 Jan 2023 11:06:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] genirq: Use hlist for managing resend handlers
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-2-sdonthineni@nvidia.com> <87pmav13ly.ffs@tglx>
 <182e3214-0f60-8b65-5981-23d2a2ea54b9@nvidia.com>
In-Reply-To: <182e3214-0f60-8b65-5981-23d2a2ea54b9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fe95c1-fc3f-4736-d397-08db03ad7af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BL85Q+Ob9jVdINiW1jxf3e55wAa5ZVSl3j7Q8csT05q0/62Tvx8RKZzJKY7jQMwJVNzJUjYxEIrPWDc2RhCxkl2qCOlyHh3V80mF47nYaSHrb+TpAHGcH9Yh2WsOdNlEALdPFjCNYBF5NmJiWplGvZAyNUmehZZvygoql5XUzPMDAzv7bije3A6xr3N2ObfkoGcqmwLx/Jv/HmDeGtzZmdFW6LIt/Fo6RUwQIekA8DtvXEJ9PwqFjKLjWUU3ucFCo6mfkSRhmz4PxRo0DslpWmy6bwn+NQfH+P1/0J7MjN8sEsvwVbwt5Ynymi4KLTSVXJployV5i7j2XVwzeC/6MoIRULV0d+caYGpeF4zBxbzETmBHymJCEmQD3B/g8fHjMuorYguT7/d7V1gO+mVyPy5hnim+2dDk4J4BANTXb6ParMfm0MxtXM/Ftms+6YGw1FbKwwtspsdkcu+bKaA/4hcpMZw/PHNQQbP9I93MZZVjEggtJzUTIxVeaLaj1TlpCxFMFduQSEolt8IgA+o3KYZPZ1OpDM9zKUlazCCrpwux+OOmmeAUW+D+Z+xtw7EzyKbd1Lh0KzAM+EuXoZ7t+jPBxXVe7SaEJ05HTC/HxCt6z3NsKKe+ywkuKDfjXR07tfiYHykWQvh7CrRpaR01I+6qQzTl7wgdnWjjB/rzbSs4jthT5rxDFJZjDLiw70BN2JUnbCBzjBPYJqHd+G88Xif8CwhbGrKkORIho2L/CNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199018)(31696002)(83380400001)(38100700002)(2616005)(86362001)(2906002)(6486002)(478600001)(66556008)(8676002)(66476007)(66946007)(316002)(110136005)(54906003)(5660300002)(41300700001)(8936002)(4326008)(186003)(6506007)(36756003)(53546011)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVwK2h1dkJ4c0l3c1N3S0x4K3hUUnd1WEQwTUQxV1RuZ0x4cE5Bb0RSZnhu?=
 =?utf-8?B?SzMvYjFBbG5aaDBiSDhjb21PK05NM3JwaEVnNzFabDBrb3Ivb243ZWs5Kzdh?=
 =?utf-8?B?WXV3N2xmU1NxQlgrOWZSMnE1QVJITVh3aFp0SjgraS9TaDV5WnVabitwaWU3?=
 =?utf-8?B?Q3dNVEpNeU5vVEpsZy9BeXhCVVBPdEpycVFXZ2JiTHlQN2RCbk5adVFJL0Zo?=
 =?utf-8?B?Z2RUN2V5Y09pNEM2cDk3TjVlSmdoRzFZSUpUUVprWURqZDdFK3ArSFMwL2tt?=
 =?utf-8?B?VFE0Vi9xUm5BOEc2TklVOFhiUXU5dXZQNklSd2xUWGxpdjVtekdMY2xpRXpx?=
 =?utf-8?B?eVNvZW90TnJiTVlXV0U3NGNxY0JRN1k5OXpsMWVTWVdsVnlvMGYwdjlHbTdt?=
 =?utf-8?B?YS9kV0lxMWVJenEvS1BKNXlBYXBTdmlNYXdZVEwrVVZ3d3BsZTlLZTFLdWlw?=
 =?utf-8?B?cTBpRjY5RkFuRnZtRWhBM1FjbXhuY2VDVlVQSWF0cTlKZ3hwWkpNWGpaRWpL?=
 =?utf-8?B?RXZ3Nm1pYzlaNzQwTVE2TVFnRkkrYlYxY2dQTEFNVFVoTVZWUWpXNXVTQ052?=
 =?utf-8?B?QkJVODBHM2c4V00rUFV5dk11SWVvN21iaGIxS0JmU1Yrb24zZGVZakJIVG8y?=
 =?utf-8?B?N1ZOV3h5UDk1bG5TRHVsTHlWM0krVE54cDViTkdDY3g2Zk9yYS91aXdFbVow?=
 =?utf-8?B?U1pJZFdNcWxoRVlFQy83MEp5dWtHSHNObWkrMTBrM2pTdHNIT3RmT0xXWDhQ?=
 =?utf-8?B?UXhoT3IrZFVJUjFqR3hmdzNRbVYwTTRUZ3d1eCtKa08wYTN0WlhKOGJ3R2cy?=
 =?utf-8?B?YS9pTjh1aEVjbk5ONzRBTFlYaHk5cXExUGZtZ2lQMHZTUklSZ3NHYWt4b3J3?=
 =?utf-8?B?ejV1bCtXRThuOGV6c0NuTGZwYTIzK2V6cEVTeXkvenBXUHBCVVRmYVJrN0Qy?=
 =?utf-8?B?cEZzWEV0c0xDUW54VWZuL3IvUzhRdFJqK0xpOG5yU21CMUpzZEs1amFSd05i?=
 =?utf-8?B?b3U0R2ZJLzhNUGNKZU5KVDQ5TzBFMzdIbDUxanNPKy9GdjZ3Ny9CaEdGTEJw?=
 =?utf-8?B?eXY5dlArbjB2Ym9QNWF2SzRuYnNITy9xdTlaVUoxa29xa08ydnR5SXJSS2tY?=
 =?utf-8?B?VG53a1MwN1NsdFNjRm1VaE9pVlJpanM3N00xSkVwZDNFRHJXYTBicE1Dc1dt?=
 =?utf-8?B?WUdvdW1JNmd2WkdsV1kySXNYZjRxOWFmWVJjV1FwVHlNd05GVmdCeGdkOUg4?=
 =?utf-8?B?Q3hLZ0h1czJzckQ5MDg5Z3F0a0l4K0VmMmNKRi91ejZ2R0dzTWxnMWhqcDI2?=
 =?utf-8?B?dmNTYjREZS81YmpWWkNZdGNZT2poaExsS0xHazZ1OHZnV29GNG5DeEZLTUNQ?=
 =?utf-8?B?QzBoLy83anNjYld2bVNFNXRsNHhCZDhUUmY5TytxVm13NkhYZHIvamZOcGNK?=
 =?utf-8?B?STlVWm5ENDI0M0wxeSt2OTZ4SHRlcDRzUmRLeXJ1c0VQb3BRK20rMlNDOHl5?=
 =?utf-8?B?bGdoTlBjcUZLYkI3ajhPdUZ1NjZHc0Y1eG9LVmZUa0JXb3ZzeXI5R1RIcXcz?=
 =?utf-8?B?Q2pLcExNdENBYlg4MHA1NjhYeUNOZkhWYkg3akEwSzl6em11RHVpS05SOGxr?=
 =?utf-8?B?UjVsUFVMOTN1MFBKRTZWQURtaGFoWFZKU3duLzlSOFNBSXlvY05qVXM4Yysy?=
 =?utf-8?B?ejZRdFVwTVo2c1A0L0dTaVpBVXFqYkgzU2tiNHovUlF5eWcxYWJCcDFIUjh2?=
 =?utf-8?B?MEhNajNGOXJuYVBEUmNlQkE1TUNHUi8yTzdjb01XVStkcUJHbm00Q0Ewb3NH?=
 =?utf-8?B?TGJDNkhUZFhOaDR2ZjkzSHB0b1BUMktSa3cxdmx5dm0vMTc0YTJSVzBrR3BV?=
 =?utf-8?B?bFduNEJtWWhUdW1ObExlSnJUVjZzOVdWaHpsVDRFdjZvbDRzTVV1bmVCbENi?=
 =?utf-8?B?QzdLYU9tc015TmQreWdkeEVzekZiSUh0MFVseFdEaTNYWnFIcmxxYkZlRUFC?=
 =?utf-8?B?bE1ZVVo4dVVhNW8xMEMwa3AwMTNTZC9qWFV0MS83dWl5T0pVa292UHlNRkEr?=
 =?utf-8?B?Q3hRT3RLM09xaCtyTnROaUx3VEJRS3JiUURvRnJsTjFtOUdsS2czWmNOSUlO?=
 =?utf-8?B?NVgvMHZyM0NUQUpRNjhrVTl1Z1NIa2dVNjR4VWJFcGRJK20wYXE4MXYxMGhy?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe95c1-fc3f-4736-d397-08db03ad7af4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:06:23.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buO4+umy9KhHkTQdKaAXQlCm/9Bn22JvONhK/1uTYtESet6jf6HfPiYDKbdqalIYOa+ZGIbQwcxrAvEBabRRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 10:17, Shanker Donthineni wrote:
> 
> 
> On 1/31/23 02:59, Thomas Gleixner wrote:
>> On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
>>> +/* hlist_head to handle software resend of interrupts: */
>>> +static HLIST_HEAD(irq_resend_list);
>>> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>>>
>>>   /*
>>>    * Run software resends of IRQ's
>>> @@ -30,18 +31,16 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>>>   static void resend_irqs(struct tasklet_struct *unused)
>>>   {
>>>        struct irq_desc *desc;
>>> -     int irq;
>>> -
>>> -     while (!bitmap_empty(irqs_resend, nr_irqs)) {
>>> -             irq = find_first_bit(irqs_resend, nr_irqs);
>>> -             clear_bit(irq, irqs_resend);
>>> -             desc = irq_to_desc(irq);
>>> -             if (!desc)
>>> -                     continue;
>>> +     struct hlist_node *n;
>>> +
>>> +     raw_spin_lock_irq(&irq_resend_lock);
>>> +     hlist_for_each_entry_safe(desc, n, &irq_resend_list, resend_node) {
>>> +             hlist_del_init(&desc->resend_node);
>>>                local_irq_disable();
>>>                desc->handle_irq(desc);
>>>                local_irq_enable();
>>>        }
>>> +     raw_spin_unlock_irq(&irq_resend_lock);
>> The lock ordering is broken here. irq_sw_resend() is invoked with
>> desc->lock held and takes irq_resend_lock.
>>
>> Lockdep clearly would have told you...
>>
>>          raw_spin_lock_irq(&irq_resend_lock);
>>          while (!hlist_empty(...)) {
>>                  desc = hlist_entry(irq_resend_list.first, ...);
>>                  hlist_del_init(&desc->resend_node);
>>                  raw_spin_unlock(&...);
>>                  desc->handle_irq();
>>                  raw_spin_lock(&...);
>>          }
> 
> Thanks for catching mistakes, I'll change it to this, please correct me if
> I'm doing another mistake.
> 
> static void resend_irqs(struct tasklet_struct *unused)
> {
>          struct irq_desc *desc;
> 
>          raw_spin_lock_irq(&irq_resend_lock);
>          while (hlist_empty(&irq_resend_list)) {

Sorry typo "while (!hlist_empty(&irq_resend_list)) {"


>                  desc = hlist_entry(irq_resend_list.first, struct irq_desc,
>                                     resend_node);
>                  hlist_del_init(&desc->resend_node);
>                  raw_spin_unlock(&irq_resend_lock);
>                  desc->handle_irq(desc);
>                  raw_spin_lock(&irq_resend_lock);
>          }
>          raw_spin_unlock_irq(&irq_resend_lock);
> }
> 
> Thanks,
> Shanker
