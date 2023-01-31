Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E149683268
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjAaQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjAaQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:18:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7D458298
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKDcMIXLpGwR9Cqa+jsN6dr2C7ZBGJX4bCnREaCjCkd4LH8tqUR1tGBxacdBsSDaDQvmBG27WFyksu6X5BP9BniV5SJFRYeGWhcbxBGSERIDdCM1SrLRp827dT5ZaWyTiU2idR33jHoU3y7DJifgsWghrgLJr+YxDECmRKa4F/JcutUsW3oVajjQxKp3rbPjQJiZXD2DlOzSoj29vmukkekm6S7Q3zKjaKFjIWs3JP0iFj0ghuRxSg3z8NqEIDcRKkEePWhQQuJd1EMbij2YymfZcc4Rs34h0HrVFHyLPJbFLdVPzGW+2vPPggqjdXLbcyRqwUT4L8sEo+42W9tOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7lw3DA0Zx7sv4J35CUzdeIY43eJpjMOJQGfji2q8jY=;
 b=gUclzOZDhIHMBw4sjQis68A5mcH1617XnoG+jntfLrpkLj+jyjEkkrHQSlY9as7s8mvFKKYHZARP84HA/Piu3hmHsyrTKTMudltuyQeHk90+A0YRbSbhglwxXbM0xnFhetGDvA6EFCIFuKxCgxPf5Uq7a1N09FOca3uJg3tNiJ5poKaBR3eEN5XI8v9SlctgyMEzY9IGQlk6HHe6t4lcULx9byscOR1zFhKYiJ26k7OpQYpo/MOZ3TlFdqI9wfnvSbGlUaEyiLYi3exSXl2mKGfwpupvLbwierReLt9GMSq2cQkSZu+qwCgulp7QNV/X7AFA85DaKLkiKi8Pp/H16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7lw3DA0Zx7sv4J35CUzdeIY43eJpjMOJQGfji2q8jY=;
 b=gq75S41vI/QruKLDGTfRkQuf12G4AnkvwicZ4g8YXGZZzusod4WBxXtc46b5BkI3oCtWC0xtcQy2J3XdEIk0+ZqESIleMe3eWtoNLFW+RUK2QoIh4qPz2Z7r7hY2s7fkoJXltA6Tex9Otl6W1Z06MdilPndjX3lH0ZJ9ZcccIQ7Zn9+r9wi3i4NO4Mw4tQuBNMX8blSWQUEIB9XqX14iJw56S7qWqH2+Nlp9dWdClB9sMEUJv6NH6qBlBJCaCUAr+sCq3uB5S35+rwLXv1sSuYRi35mzgxqvk3TLpRwshG+RFAaSxrWkKJkISfOz19OrsdWC3P6f2TVYs1u3DIj20Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:17:24 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:17:24 +0000
Message-ID: <182e3214-0f60-8b65-5981-23d2a2ea54b9@nvidia.com>
Date:   Tue, 31 Jan 2023 10:17:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] genirq: Use hlist for managing resend handlers
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-2-sdonthineni@nvidia.com> <87pmav13ly.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87pmav13ly.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::16) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b7b32d-da65-4a36-a7ad-08db03a6a304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klU6vwjzeDcmkLtk4H2fmJIZj9fIdZpFwPstrjgZm7PFsFYZp2bsFXEAUWOVA7lP9sDeMgJrG8F15tsQxDuRTEXAwz/uNYzO6/LB43SPHEtWFJ7KaVZ3drFC9qohZz0cEMhNHsmI8KDW7hmaBpTJUcg6anMOc5sZWJl8r+dWW1+olFnbomwhYrwiydAUYxA9SegahTRZv3LgPVIzARIwW67usV+5+tAgUD+Ghd2kxeMj8BwpXewU8WAAlCe+COcakl2lvhvdeq2nBNcBKnpIY4uqzLfzg3JVa5P/bMH3/DLY03OlH06f98132uvpRcn9xFt2YcnvlmO9H2bOzNwpHdGcBPcFyML2wqw23W1kJM4bOkKY+7nY+XCG/FBubISIDF5fZf6FaGOErdmbbleIDQ1W0WQaN/ZSvKmHj1LW3mpDv/LTfivOumUfsAY44gdNiAlyhjgT7S4BQY5s6J1pJY9QfowYV1FZmx8q3yz9fGGLeELUlrTygz3CcO+EUk3quduOLPHopq1TBZ/w+iPVGS9myBRhkebHMJ1LeA1c6DvHCd0aMzrkGqwglBliTCJ14cuye3uFhmpJOeP7Dz/aMznVzMQN5Ii51EbtHBPUPv78Km3e0FtO4XYXATRXXHTrJhhuiNt/saXIkF496Lon96uRIxIzOeiRIV9xwERiMurEbK9QK4VRwc8lodH8PxuunZb7PQczxsd7E6tkaXuctaTGyyhwy6d7AQO5n9mcv2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(6512007)(53546011)(6506007)(186003)(26005)(2906002)(4326008)(66946007)(86362001)(31696002)(66556008)(38100700002)(54906003)(66476007)(41300700001)(5660300002)(8936002)(83380400001)(36756003)(2616005)(8676002)(110136005)(316002)(31686004)(478600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0plMFFjcWZjS255V0V1VTliQXJnVXI3TzdZQ1J0N1orckhoZ280S1lGdHZW?=
 =?utf-8?B?aDlFbjErK3lDVHBBcWlyM25oZncxdE5UNzMybUFPZnROc2ZuUUs1OEFoS2cr?=
 =?utf-8?B?WHRwNXo5SWc1ay9TbGs4b1JCQWpibmx5bHA0TjFGQm1acjlqeTFTVW42R2tr?=
 =?utf-8?B?RFFHSVU1SWN5dUdGNXVNdEdCdzRmU0ZVUlY4RHVKak5STEdRU1VIRWtUQXU1?=
 =?utf-8?B?a0t5QTRxVUdQbU5BU2c5U3ZGbTNhZ1hhMk16QVk5dmVteng0VUlwMzB2YjZW?=
 =?utf-8?B?b0k5K0l3S2UyYjdnOVV6UmhFZTZNNmlBZTRkVEZlaU1CbFFqVjhTRlloVGdk?=
 =?utf-8?B?SzZqbnhkdG1CdEJlcitqMyt4TkdyendJWXZtWndhZlQvbWRqNCtxUE5wZ1BK?=
 =?utf-8?B?RUx2cm5sYVlqMWNPbWVIRGN2N3FrcXNkeWpqMkJobnhvaTN3cWVqU0hHVEg1?=
 =?utf-8?B?dk50Umc2RUZReE1wd05hR3BObG5LeHB6L0NGM3hCYk9aMUptT0dWTGM4TGlS?=
 =?utf-8?B?NzJIR081S2xEQ09ZT1l0TTFIYllFNHRoWVNYMm5hNDlqODhjM1g2ekZpS3Mv?=
 =?utf-8?B?TU9nZFZ2MXVMTWZRT29oNUxHakNEcXYwVVlCY2RmZHRtTGRTVlNTSDRJSmNp?=
 =?utf-8?B?OFB3ZFpjUjc1elMwcmwyRWZiYnVKTkt6TlpSMnNkVzRKWVU2YjV0TldMekRG?=
 =?utf-8?B?S09ubGF3czM4WkwrQzVqelFVaVhES2FiSDNKMGZOYjgrNXZzZHlzb1FjeHZm?=
 =?utf-8?B?Z3ZuMXRlLzB0NzBKK1htTHd4SVA3TDEvRXkrWnZCeko4ekV5UFBmYUhZYnow?=
 =?utf-8?B?T1N3WUhBVjk0dmN6OWJnVzVkdWY1VTFXOFVSbWlSQlVQRmNndzhpWmRUSDAx?=
 =?utf-8?B?dndGa0w3OWFON2U5WjhHeENtVnhlQnlJRFV2aFlpdHRqZm5uSkdmanUzOEFs?=
 =?utf-8?B?ODZyWE8ycWg5eERoN2xWdkZaTStzakVaZDdjRmc5NkZNS3psZE9FaTJqUG9m?=
 =?utf-8?B?eVZOeFlDQnV1eXlkNUI1b3VwNVgxMUdLVWtETVpsUHlMTUYyYVdubFFHbVcw?=
 =?utf-8?B?cHQyZ3BVdVgrWTYrQmlUQXJWY1R1emV5QnZKNzh4Lzhtc042OTNxQ2o3c3k0?=
 =?utf-8?B?MzVEM3luemxtVkhWV0xaOWRTMVpKdzI0QlVjSVdFcDhjOEZiQmtDdVI5clB0?=
 =?utf-8?B?cVlkZEN5SEZxS29GWi9pRjZSS1pHQ05wSEtmdUMwNkd4emtZOWZ1MDJqWDh6?=
 =?utf-8?B?M3VTdDZRSkJwb0RaQXp0UkRCSUNuQjBLTXVtbXFEREdpanp6dnlhdVhkRytM?=
 =?utf-8?B?TDBSdEVkTTNtUzlRQVppV29wNS9YbjFOcUoxMkcxWE0zOUFKRHhrd3FiYlAy?=
 =?utf-8?B?Q2QyZ0gvYlgyU2txbTFUdXg2K0M4QXFFY0lLa0YyTjUwY2tqbnExQUZlTmQv?=
 =?utf-8?B?amlTWXlhZnhUTnJleXVSZW93WlY1MmNZV25KMkhJKzg1RkhCeEJLN0FoUndq?=
 =?utf-8?B?NWVrRUFqeWtSWVhhR29Tbi9hNzVFTitaWS9YUUFlSWRFcDgwSklCcUp4TU8v?=
 =?utf-8?B?b0tIVDhqaHhzckltK2NwNmxiSGl6akNQVWtOYy9PME9yclZWTjlwTnFDUzZN?=
 =?utf-8?B?TlM3bWJTb0xUbUZzbFlmQ3J5UEhYaENSTW5KZjNMRkR1NnhEcFZ4dGkxU3NH?=
 =?utf-8?B?Yk52UldNK0p2OTNielBWQVBtbUZSQTRpRnZDWmhTaWY2TEZCRXFkR1EzbnNJ?=
 =?utf-8?B?OUorUDZxU1IzL0IzbkhFUnRxU2RjcW9Tc2JYZThaSFNYalBaTjNNK3YwS25Y?=
 =?utf-8?B?NWo5cnZlTy9MQ2lIV1VoMGVHVFdZM3JoSkZqVnFUZm9rQ0ZscnRxSlFtaThz?=
 =?utf-8?B?S3hKa1Q1REFVTWtRemJ4eGZGREFub2FGL3VGQ244SGRhT09FVE9ST2g2N3h1?=
 =?utf-8?B?SDZmYVBBQ1A0bC9pTjlHUGQ1b0MrcWZGbkhIV3prN3hjMkN4bzZMODB4SFA2?=
 =?utf-8?B?K1JpdzB0NDcxcTE0QXQrSXB6K2xYT21Dd1BoU3RkSG5vU3QydHJGai9ySUxo?=
 =?utf-8?B?Lzc0TGdscm5aaUxwbkt5YXE4TmFsbXF5V3lZYWp2Uy91MyszMmdySXk1WUx2?=
 =?utf-8?B?YVJtNVZuNjhzVUhJYUNVNE8ySXBIUmVURXlpSWx4UEVnSkh1eEFpeWdMbHdy?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b7b32d-da65-4a36-a7ad-08db03a6a304
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:17:23.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fap+Z3xBrvB/jvCK1wS7Mx6Gi31bPp1IAcfEAngrKGX1U86BTTTBIoZPm3LUvsLFQP7QA32bXJ2odvJwjKpnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 02:59, Thomas Gleixner wrote:
> On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
>> +/* hlist_head to handle software resend of interrupts: */
>> +static HLIST_HEAD(irq_resend_list);
>> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>>
>>   /*
>>    * Run software resends of IRQ's
>> @@ -30,18 +31,16 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>>   static void resend_irqs(struct tasklet_struct *unused)
>>   {
>>        struct irq_desc *desc;
>> -     int irq;
>> -
>> -     while (!bitmap_empty(irqs_resend, nr_irqs)) {
>> -             irq = find_first_bit(irqs_resend, nr_irqs);
>> -             clear_bit(irq, irqs_resend);
>> -             desc = irq_to_desc(irq);
>> -             if (!desc)
>> -                     continue;
>> +     struct hlist_node *n;
>> +
>> +     raw_spin_lock_irq(&irq_resend_lock);
>> +     hlist_for_each_entry_safe(desc, n, &irq_resend_list, resend_node) {
>> +             hlist_del_init(&desc->resend_node);
>>                local_irq_disable();
>>                desc->handle_irq(desc);
>>                local_irq_enable();
>>        }
>> +     raw_spin_unlock_irq(&irq_resend_lock);
> The lock ordering is broken here. irq_sw_resend() is invoked with
> desc->lock held and takes irq_resend_lock.
> 
> Lockdep clearly would have told you...
> 
>          raw_spin_lock_irq(&irq_resend_lock);
>          while (!hlist_empty(...)) {
>                  desc = hlist_entry(irq_resend_list.first, ...);
>                  hlist_del_init(&desc->resend_node);
>                  raw_spin_unlock(&...);
>                  desc->handle_irq();
>                  raw_spin_lock(&...);
>          }

Thanks for catching mistakes, I'll change it to this, please correct me if
I'm doing another mistake.

static void resend_irqs(struct tasklet_struct *unused)
{
         struct irq_desc *desc;

         raw_spin_lock_irq(&irq_resend_lock);
         while (hlist_empty(&irq_resend_list)) {
                 desc = hlist_entry(irq_resend_list.first, struct irq_desc,
                                    resend_node);
                 hlist_del_init(&desc->resend_node);
                 raw_spin_unlock(&irq_resend_lock);
                 desc->handle_irq(desc);
                 raw_spin_lock(&irq_resend_lock);
         }
         raw_spin_unlock_irq(&irq_resend_lock);
}

Thanks,
Shanker
