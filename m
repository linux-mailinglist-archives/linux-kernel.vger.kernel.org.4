Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E16DBFBE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjDIMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 08:00:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFD4210
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 05:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+BSOI2cfNk9lJcPb9YyKK9IUMJs9e4BYD9fZa1VjX+7STz/sCWlTDu/naRvMBsSS9TM/N2YRhQm2I/CLqbrzakMkH9rIwTmVSgIoPrERV+pq1UQtpKfq4gEcAuHTdpdoS+1nkN7OFlDXQ204f5u0GejcJboXnrNnIMUaH+v3FSRn9ZQezD1B/fkE+GK6AVTCQDH6yCaQkft7GKMXHZknTfrfG0gvJws6TdGyrwhWePDPp3xxyxb9BCLHyU8ZwgiZR8yEWkaV6jIAffOgOPDXfmeV0GVaZG9HLeqi8gbEDBr4SLjeKchzASh09TCnVecFNTuESGIb79rWZ00zl2vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c5FXjPvke+lFm/jx0dC4IoyX6MrbHFwlETdBw5NG9I=;
 b=kVuOALeWyInCRhz48xblraWWN2/iucb45nB86lzIJdp7gsEiv6EgPy4GHC0vABDJ5qRuqMAyC6skzAD7gegTtZZtR+to6GmvVh6MXRK8/tOpRMMrBC8t5dn8sDA+7jiayrgVg7p4/UZBgAWMvc0Qy3NOYf/tnR7Qn1++lcJ3Ub9od9UUC0htAGxttwiUuxflAFXVgfhjiZaac41JJvXgurclyDkXRpPPvdQMEgWXIap2t3NAN4gm2I2S1PzJEuR2xh3JvXXU+AbQhTihR98taNxu+oqyN0TCfzQupD/bjfq7wcEr25mbUHhavBF91NcP98zHrX9jrYDymXrNkxvtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c5FXjPvke+lFm/jx0dC4IoyX6MrbHFwlETdBw5NG9I=;
 b=b/uV1KwFcpfIgGl+yGWFMlFvXSokZQSl9pbL9ljK+9IKUq1Sk6c6ypWocZKoaPY5gP0DWD3+741mEwHJJKzfkzz8Kx9uGVIYzjgPWxtJH9odMNpnm7+TUe3RqtaUfrRKyF6F9tAnMc25pTloCODjognV1tr4tx3GBtc8t8UiKNm27zTXuj3+94IurOGHjEyIziWkFIxxVBtOFJ0tHICNYh5MvgXFxSOBWYK3FIsUpcn8PA0E63D2FpSZsfahrat/lLd21alzevfMC5RAOxbGVwRBj0GTqSoD+6+/x4RE71szl5+kwLC93RorzkoJRhhiqi5w9/oKmNGm17eRq++Gpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sun, 9 Apr
 2023 12:00:32 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a%5]) with mapi id 15.20.6277.034; Sun, 9 Apr 2023
 12:00:31 +0000
Message-ID: <76bc7b50-d47f-e5a7-6aa6-54a7b1492ea3@nvidia.com>
Date:   Sun, 9 Apr 2023 07:00:27 -0500
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
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <863559mne0.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: d004d3c2-0003-4c7c-5736-08db38f204a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gj2P5ZtMGIGJKxkgaiWmIRcdgwY9vSPyfH9IymKByQMk+s2udUrQ4zSq2J7VC47h4nXUDvFqOJjTmr0VeJs5w2EWIGh4QKuJk6zgExT91omweY7wBL/byLI+7asQHmjfYLCW4O980neqSa9xbxuAgcUYsa/0vAxY5ZPFnV/9UwAaTrHiMU0NREJ8mEc8bMLsuM8wEW1kEvNeuPcVZnT08Vor8Oq/4Zg52WTYIrlyivgE6KkkY5eT68arntCU/qfq9vEo8F7tMvf8fyVkjw1YouD1THWDoLa25lInYg6tBr5Aor0gIXt+pivn72rxw4YV3uf1tUOTsi2ckaW3b/fUhvMv8R/FTNcL3kxSyjdOadgiP/azIG/9q5h8LacRUL9BhFGDAImVz/b1XqfCUY7g5RVjzBlLEBSWUbrAZMtVhlKhFiX9+Cz9d5Pggy/weEohx1PwN1N8zI2xDz/5xcWiMgEV4HBE0lQaJjRIy6LK5plTbiehDuT4La6hx3xJwEnV6GUqdmxG4qZ6skHoQmLptVQqpW02KyXXBiYusXvXwLJX5jhYKBCq+29b58NiKf+TG2BnXnimuRX8Z2E4n0GHz15JJMEC2+6H7RtbsllynB+gPL+IRJ3/oL9kllcZ6b6Xp2ZCXWRHK1DtI8hCoM3uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(86362001)(31696002)(36756003)(316002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(6916009)(6486002)(54906003)(478600001)(5660300002)(2906002)(8936002)(38100700002)(186003)(6666004)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slc1N1IzUHU1Mi91SlNhRjg1ZlMzcVIzZ3UreHdTbHd3MEQ4OHI5dlJTM0ls?=
 =?utf-8?B?NWJyYkRsdG5KTVJ2bm5icDIzTDIwaEVuNy8vU0FENWdkaHRTWUpiS3AxUyt3?=
 =?utf-8?B?aThGdjg3ZVEwdFdCL2NoUFNQWk5ycHJEeTNWaXgrUlZGUUlvd3JNa2loc1pF?=
 =?utf-8?B?em5ReWp3NUJrakprcG16bWJ2SG5BaFd0NVZIMTE0WmpWYkZub0pNZnZNN1dK?=
 =?utf-8?B?QTF2Um9WYlBnWmQrV29zWThMeHdBancyRW9QUXNlMm5IT3UybnRVZTYxV1V4?=
 =?utf-8?B?MmFkSTY2aHB6VmZoWEkzZE5CREFyY3I4bUZRR0tsWmd2UytUY2FnbXdWM0N4?=
 =?utf-8?B?WWI2UExha01KaExna1Zpell2dzF0cXBDb05jcFVVcXNlTURuc1hPdGpzVzN1?=
 =?utf-8?B?Rndkak93bDN2OSs3M2s0TlVwcXF4MEFNKzFuUmRBcm9XdC9XQXpiZ2tvWlZq?=
 =?utf-8?B?N25rY1NiNXlQQlNPVWVYRUJ2YktGTzU4QlZSS1A1K2tCejBzZnVwTjZvTnpP?=
 =?utf-8?B?VU01ZHdmUDVvS2NTYzg1UTVudDFFS1RoYVRSZEFkN0J4WjM2cWkxQXErNXRW?=
 =?utf-8?B?Z1ZzbjRQY1RoaDdSSklubHo5VVZudy9tZUhiT0xFR1VBUU1CWXZRTzFNekJO?=
 =?utf-8?B?eEw1T1ZqOVdKN0FSSUY4VU5pcWQ2cTAzU05WZXV5U1lFY2lzbE5idU9Bcmlp?=
 =?utf-8?B?WHBmOXdEMElzTmJZem9pay9yT0ZsNDhQdkhTLzl2NDBpS253RGhtMzMrYnc4?=
 =?utf-8?B?dUhtVGFaOUNpNFpTb3cvNGpRTUxsdEs0ODNKOHB5UURWblhYU20zNVpBK1RC?=
 =?utf-8?B?R0tYelltVmluV3NXVXhGSDdMWDI3OW9abFhLa2pyMlBTcGxPNDV0dS9hMnZG?=
 =?utf-8?B?aDNsSTh6dG13eFhEVUF0Yk5HUmNPVjdYZkYzU3h0M1kwZ0pDWnBBbzAvemJN?=
 =?utf-8?B?WmIvZzlzNzEyUkpYYjJQa3JWTkRWbGhiWUt3bmx1Y0NDelBXMWVCbEgxMzBG?=
 =?utf-8?B?WTl1WUdOTGVBSUpvYkRFQUx1UWUvRmU1UUFvN1ZmTFE2Zy9qMFlYUENzWU0z?=
 =?utf-8?B?aEJKNGIwVTFmU1g0aUdzOWFUN1ltQjFVS0wvWS9SdWV2K1ZSRzZoaUppTE9p?=
 =?utf-8?B?WXQ3aXJDNVI1Y3oxYVNoZkJVYXlJZFYwN2xRYUhwandldnlKNHNCUEdHZk1M?=
 =?utf-8?B?VXZDT3hZK1E4YllSVUVGRVpsdVpnL1RtY25BUDBjdWJObjcvTDl3UXJxM2Fv?=
 =?utf-8?B?eFpESXc5cWo0NkRjcXZkTGxzeUY4dHEvRDAzY3VMTklJK3pzS3hLeXk2aWhR?=
 =?utf-8?B?bFkvR3FLd0htamVNbGNDQWt6eGVqUitaalNRTmNsOG11MEUvTVNQYnNVVjUz?=
 =?utf-8?B?Tm8zSnlVNlNxSndCR0VHc0ZUSFJPOFg2NmZNVlRSU1VGRnVWUEt4eEhnYVdp?=
 =?utf-8?B?V1VUblU2azczVEJJaE55V0t6dUNWeUFpSlEyai94aGJmUGszUzZFWHM5dXpt?=
 =?utf-8?B?VUhyMEQxd3hhcmsrb3loUlVoUlJSaDZraDJNMTNpclFlbUY0Um5hVEhpSG0y?=
 =?utf-8?B?Z3VrQmNJeVl0QWppWVptU2c0ZHh6bHdEMUdrRDFLY2huYmhFUzY2WkNDSE1J?=
 =?utf-8?B?ODNQUVNKK2w4bXVkcWNJcCtpVVdFR0IyZzdRRTJPcU9aMHdjZTNZejVnVE9B?=
 =?utf-8?B?L2hReDQ5OGRkaDhJN3Y0MCtHZ21VdmVOUUJNMHZGMU4vdXZ2dENWRmNuS251?=
 =?utf-8?B?ZzN2MTdQU0JPVUFCUWhkUndibU53WWJPUzdvSmVnWGIwUTdOU0c3Q3hINEp5?=
 =?utf-8?B?SzMvQzU5K2VFNEU1ZmV2WlVFbFFGTXU0bFBwVEFrcDluSlFCY2tJOFpyZWg3?=
 =?utf-8?B?NDU4RmpuR0h1cXhLcFZFVFFKS0hVdHhPWDBzNUE0NUwzcDdMQlFzZVA1bUpy?=
 =?utf-8?B?Rko0T2p4eWtOaTAyYUFRUktiK1JxOWJxTXRJTm5TaDg4TDl5YmwwYm1YRXFw?=
 =?utf-8?B?eGozQjZIT1dXRGtkWHhpN1czbEUydDNRc2o3VlVyajVvTU9wRkd6NWNRZnRM?=
 =?utf-8?B?MGUvcmZ6NStLdDkwK3ZkMzNiYVcrNC9Pb2lLNmJkcDRJMVk5ZnBwNm1STG9Z?=
 =?utf-8?Q?kIbbilPSv00wedmIIcjmVJd0k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d004d3c2-0003-4c7c-5736-08db38f204a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 12:00:31.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkbHmwfoFpsdZl9hVJ6MznRma0gcKkH6j8jTY3LCaHUVoQByoBUxCAHSfpg3IUbvr0iLDgS4ha69w0DO0ltMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 4/9/23 04:10, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, 08 Apr 2023 18:15:24 +0100,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> The current implementation utilizes a bitmap for managing IRQ resend
>> handlers, which is allocated based on the SPARSE_IRQ/NR_IRQS macros.
>> However, this method may not efficiently utilize memory during runtime,
>> particularly when IRQ_BITMAP_BITS is large.
>>
>> This proposed patch aims to address this issue by using hlist to manage
> 
> s/This proposed patch aims to//
> 
>> IRQ resend handlers instead of relying on static memory allocation.
>> Additionally, a new function, clear_irq_resend(), is introduced and
>> called from irq_shutdown to ensure a graceful teardown of IRQD.
> 
> s/IRQD/the interrupt/
> 
Ack

>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>   include/linux/irqdesc.h |  3 +++
>>   kernel/irq/chip.c       |  1 +
>>   kernel/irq/internals.h  |  1 +
>>   kernel/irq/irqdesc.c    |  6 ++++++
>>   kernel/irq/resend.c     | 41 ++++++++++++++++++++++++-----------------
>>   5 files changed, 35 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 844a8e30e6de..d9451d456a73 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -102,6 +102,9 @@ struct irq_desc {
>>        int                     parent_irq;
>>        struct module           *owner;
>>        const char              *name;
>> +#ifdef CONFIG_HARDIRQS_SW_RESEND
>> +     struct hlist_node       resend_node;
>> +#endif
>>   } ____cacheline_internodealigned_in_smp;
>>
>>   #ifdef CONFIG_SPARSE_IRQ
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 49e7bc871fec..2eac5532c3c8 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -306,6 +306,7 @@ static void __irq_disable(struct irq_desc *desc, bool mask);
>>   void irq_shutdown(struct irq_desc *desc)
>>   {
>>        if (irqd_is_started(&desc->irq_data)) {
>> +             clear_irq_resend(desc);
>>                desc->depth = 1;
>>                if (desc->irq_data.chip->irq_shutdown) {
>>                        desc->irq_data.chip->irq_shutdown(&desc->irq_data);
>> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
>> index 5fdc0b557579..2fd17057ed4b 100644
>> --- a/kernel/irq/internals.h
>> +++ b/kernel/irq/internals.h
>> @@ -113,6 +113,7 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
>>
>>   /* Resending of interrupts :*/
>>   int check_irq_resend(struct irq_desc *desc, bool inject);
>> +void clear_irq_resend(struct irq_desc *desc);
>>   bool irq_wait_for_poll(struct irq_desc *desc);
>>   void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
>>
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index 240e145e969f..47543b5a0edb 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -415,6 +415,9 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
>>        desc_set_defaults(irq, desc, node, affinity, owner);
>>        irqd_set(&desc->irq_data, flags);
>>        kobject_init(&desc->kobj, &irq_kobj_type);
>> +#ifdef CONFIG_HARDIRQS_SW_RESEND
>> +     INIT_HLIST_NODE(&desc->resend_node);
>> +#endif
> 
> Please add a helper that hides the #ifdefery from the core code, and
> use it in both spots.
> Sure, I will add a helper function irq_resend_init()

>>
>>        return desc;
>>
>> @@ -581,6 +584,9 @@ int __init early_irq_init(void)
>>                mutex_init(&desc[i].request_mutex);
>>                init_waitqueue_head(&desc[i].wait_for_threads);
>>                desc_set_defaults(i, &desc[i], node, NULL, NULL);
>> +#ifdef CONFIG_HARDIRQS_SW_RESEND
>> +             INIT_HLIST_NODE(&desc->resend_node);
>> +#endif
>>        }
>>        return arch_early_irq_init();
>>   }
>> diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
>> index 0c46e9fe3a89..d3db2628a720 100644
>> --- a/kernel/irq/resend.c
>> +++ b/kernel/irq/resend.c
>> @@ -21,8 +21,9 @@
>>
>>   #ifdef CONFIG_HARDIRQS_SW_RESEND
>>
>> -/* Bitmap to handle software resend of interrupts: */
>> -static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
>> +/* hlist_head to handle software resend of interrupts: */
>> +static HLIST_HEAD(irq_resend_list);
>> +static DEFINE_RAW_SPINLOCK(irq_resend_lock);
>>
>>   /*
>>    * Run software resends of IRQ's
>> @@ -30,18 +31,17 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
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
>> -             local_irq_disable();
>> +
>> +     raw_spin_lock_irq(&irq_resend_lock);
>> +     while (!hlist_empty(&irq_resend_list)) {
>> +             desc = hlist_entry(irq_resend_list.first, struct irq_desc,
>> +                                resend_node);
>> +             hlist_del_init(&desc->resend_node);
>> +             raw_spin_unlock(&irq_resend_lock);
>>                desc->handle_irq(desc);
>> -             local_irq_enable();
>> +             raw_spin_lock(&irq_resend_lock);
> 
> What makes it safe to drop the local_irq_*able()?
> 
> tasklet_action_common() explicitly enables interrupts when calling the
> callback, so unless there is some other interrupt disabling that I
> can't immediately spot, the handler may run in the wrong context.
> 

Unless I am overlooking something, interrupts are disabled within the while
loop unless desc->handle_irq() is enabling it. The existing code disables
and enables interrupts for each handler invocation, whereas the modified
code does it only once for all outstanding handlers.

Please let me know if the below code changes are acceptable. Similar to the
current interrupt disable/enable logic except the protection lock resend.

  static void resend_irqs(struct tasklet_struct *unused)
  {
         struct irq_desc *desc;
-       int irq;
-
-       while (!bitmap_empty(irqs_resend, nr_irqs)) {
-               irq = find_first_bit(irqs_resend, nr_irqs);
-               clear_bit(irq, irqs_resend);
-               desc = irq_to_desc(irq);
-               if (!desc)
-                       continue;
+
+       raw_spin_lock(&irq_resend_lock);
+       while (!hlist_empty(&irq_resend_list)) {
+               desc = hlist_entry(irq_resend_list.first, struct irq_desc,
+                                  resend_node);
+               hlist_del_init(&desc->resend_node);
+               raw_spin_unlock(&irq_resend_lock);
+
                 local_irq_disable();
                 desc->handle_irq(desc);
                 local_irq_enable();
+
+               raw_spin_lock(&irq_resend_lock);
         }
+       raw_spin_unlock(&irq_resend_lock);
  }

> If there is such interrupt disabling, then please point it out in the
> commit message so that idiots like me can refer to it.
> 
>          M.
> 
> --
> Without deviation from the norm, progress is not possible.
