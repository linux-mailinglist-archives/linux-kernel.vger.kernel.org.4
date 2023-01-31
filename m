Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B416832F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjAaQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAaQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:44:00 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14EDC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYYVU1erHhilKe3XQ1styn4N+tweXgnzouZSuxfsB/WEq0xf5bhO//oHlxRM5yUvjLRe+zvkk7zdxjlXoichm4sXWVWsKBOCtFSpsi48KoAE0X/rzOfhkew3MFwuthM/bRzk1COXnisIKTi3+4sB4U6LQb8dSTaMAOgiQEx7X4STapl/uHD6L3z7YzMVFr6ThllooV/PZ+fWfvfVJIh77oLEmbkF/2FG1GXh6EeOa1Mp7r9LQmaJlwMf4NOmyb5AARKLLidB94Ct0gmGIGJDbld+DQFiyETw/d70/PHspvFMjxTH4ZqOYmrqltMSTAXQrRkpzM6RZ3H/DVxiFLx4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUIxaOdzqFHGT62Y052PdH4lAzzWd0VSMkgA/mkk8wM=;
 b=b5LZRJcgG6L9OtVMzAIpmf8nYmzROyMqprwWYq6AeimVD73POkyEXSEzNYSXpld58Fjmgv+UYCTZTkke6B6VotI4QoztHdfwoCgqYgl/zPyNTX7BfD2NXsbMBvEfTvgp5of+mojiXJpv4sVom8sQtAU6TKklEKVx/hV4NH3tEaEvKSu0aSRJrFEXGcdl9HUPTOle4PgqsDeS7xs8t3YmaN4wrjWNsCIjAiUin+NMqwwNJd1gi5Ea2M28GjRh4hS7V+GEYwC0dl5tJoCrglDewVx/NDmDtgWldI0xWcWz/bqmFQZ4YkFqgNaZmA/iTmtIPL6d+p3SaAi3a/G21BTqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUIxaOdzqFHGT62Y052PdH4lAzzWd0VSMkgA/mkk8wM=;
 b=mJ8lgv5jSLu8ewZO2QkjVCaENnqIkyam4m61ktzjS738zlzQvngtw0is1Qkan3GeriME3ZqYmnwnueQZrboTet981XuH8UFzT8lROScWb95RbehQndKgJckjvQSvkD0kuP1TmHgTne+tNYirgYUskEvhXoasnFD6toDfo3NFuH7QrP+mwlUykTvF/d/Mb1R7rqc0/6ZY5vn9pvwA/qJwSuZBf1tjIBXHZwtsJe7RTjSiRP54cIBrt0ZC7wZauNpwdPrpQ+qTOJy+susNNeWArOL5mjY3IWgJq5VsnbW3BRY9yrvFiFoYSzBudc1Sd5+trDw+6hNw8FCDEJXdC25Z2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:43:57 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:43:57 +0000
Message-ID: <0ef7b7be-4132-669a-448d-ce7c9f198d57@nvidia.com>
Date:   Tue, 31 Jan 2023 10:43:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] genirq: Use the common function irq_expand_nr_irqs()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-5-sdonthineni@nvidia.com> <87h6w711yc.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87h6w711yc.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::6) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb79d9d-e434-4972-d84b-08db03aa58fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEpaAgS9gz7u+VbvvhrNeag/5H3yQxUYtdPIYMmuQIvP39st4rSGgzwVvq5LnKZ2QD9mDupU/iASGWnYykZOuJ+BLk1HQsyEBLQq5iEH97ExMjvUA0rbB8T+pNvVlGJhyEKUultBwV23YzifjDy0DoQ3i4m5Yd7nxu3QemaeP7EzgrCpP+OdVXY+Aa1siHZj0uZat7XhrBms4jMWAbYkZzehipW/OQi3l3+X0p4JlAaXoXT4juT7JDDxNfzN5q0ERXJfdwTE3nz3JuKVsnw14joBU5ikjP+03tKkWaq2Mw+rt17T6k7yYS//cQnmuoJX6+TtcaLiTre4duC+XodO5aedE9PlWSLZDV7eL8nJXI8RyLr42wuGTFysH2M4sDpu7rS71an9ikr6ei6rcjwO0yUfNIGKiF8UQOBnjcE+r91zDjne0//RHL3WMA/Jkes0X89c6xec8F8T9SkDo/yh0nHC1LVhk0YhRkg8oDo6tXOsrCUarzPkk7dGIkN5W2FIEdv7W1X9pyASDzmGU4okz3GmswvxkELdpfWoOatbdF9OLFmdWsOkZUwB08mNsdxWAehIzIpSmtq4C7cwHamTNqCq+dduFx0RwN37qnY0AqIgXXkRIDlm2TqJTegUVjnDyGWmgs34FPTgUonXV06sZgzLFaVvG9mL7+4wgrqhz/yXUeL69heUyFKyD+UzvkqTGgqoFE8+89kO0PISRTeE9x+IxCTyvIWPZaof/KH1/WY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(110136005)(54906003)(41300700001)(8936002)(6506007)(66946007)(66476007)(8676002)(4326008)(316002)(66556008)(26005)(186003)(478600001)(6512007)(53546011)(2616005)(6486002)(86362001)(31696002)(5660300002)(36756003)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHh3NnZYL3pPVHdPQm1XckZINUpIb1NUN3hMRDkyV3ZBZlZDeEpWMjRrYnQv?=
 =?utf-8?B?UHRjc0YySTJZRWxua0c1OXA0S3NDTWlOQXZBNGlVY0JrUVdHMXJyM3MwZzBJ?=
 =?utf-8?B?VUZWRjRQOHlkVm5LUlBDbmdzRUNIV2s2eGl1cXBvdHMyK3ZZUDhqOXVpbUUw?=
 =?utf-8?B?SHBPbzJyOFIrVzcrR0dIbGVZdWYyT3loL1hucGc1N3h4VktHd0tWNVlWdStj?=
 =?utf-8?B?ZlEydjdZZTVyemdKOC8vSzdVaUh1WHIyUWs2SmVCOXM5K1p5L2JzblpWWlZH?=
 =?utf-8?B?ZWRkZ2F4YUp2Y21sYlJMbWErWEJnV041dEN1bXo0ZGdYdkhGZVVYNjFzMi9K?=
 =?utf-8?B?cDRuWW4zaUNsaTcwRW1seVBrZ2pGeUlPcVVkWVNxcDg5Q0R2dmw5Tm0yU0V6?=
 =?utf-8?B?Ni93bW5ZUURWNzhsbko4bTZRTHlXQWdlcHAzVUt2TFJaOHp6a3F5dmVTZndF?=
 =?utf-8?B?N29OdkVvdDZQMzZ2azRlb2tBa3VWVnpIWjNmWWpiWUw4M3FYc2ZLd0JicW16?=
 =?utf-8?B?c1ZJdHBIWisrS3Z1MU83aE9pVFhIWTB1NGxDZktmd2p6QmxzNWgzaUVGSnVa?=
 =?utf-8?B?dkJHRWEzNVBVNjYxVnhoYVJEVVAwUnJaMmFGd0RmN3AyZU5jMkR6RFZ2ZlJt?=
 =?utf-8?B?QkhLQklTL28wVnpSb0w4K3AxaUZsdjhsT3RsQlBYOXRPNW9WQzBybnlVakNF?=
 =?utf-8?B?blRQaFZ1TGp6enovQ2VOSXdLa1BmZGhRUmhDUVRRRktZTVNtb0tRK0FCelFh?=
 =?utf-8?B?VGdaTnBodXdyNEJhUjJDM0FZRk82NjNPNHNSaXJNUkhyVlY5RDM2MjhtQUlu?=
 =?utf-8?B?VnY5SHRLQWdLZGNDakVyVG4ybUYybWRPTlRaUUwxcnpBbURTbFdJb2pJT3BH?=
 =?utf-8?B?YXVOYWYzbE12MVIvbXBJL3BIMkpHR3FCclR6R1pWaHJEZkdPL0ZPY0kySjhk?=
 =?utf-8?B?bTV1Zlo0cFZmNXp6NVhiVnJuR1VHaG9zaTlqMzRzc2lkNnVFa3Z0MTRWYlZP?=
 =?utf-8?B?ZXNEUkxxWUt3R3JuRXlxaDVybVVsVDh3eGxuaFhuQnAxNlBNWTFqWGVKOHRn?=
 =?utf-8?B?bFFkdmhaRlVzQVNTL3BjRUJrTkI1bmlOUHBSQWgrSUNPZjdoTzBxdGd5dlhm?=
 =?utf-8?B?YU5HRXFwSjZwaDh1NEtkOTkxRFRWUjFDSFd3ZlNUaU9zQTUwamEzak0wVDRJ?=
 =?utf-8?B?cCtmYUFuTU9ZeTRqUVFPdW9wUFc5R0lBdzZFMlNFazVMa2Zqb2pxTGJTR2tO?=
 =?utf-8?B?UE5jRGczWkl1R2haSjhrNjR2aGorcTZveGR4RU83ejR5VmRpVzN3bUkyM0dh?=
 =?utf-8?B?VXdQSC9IT1pxZHFmMER4U0l3VHBha3Z0aFpYNTZNSFZlNi9RbVJYRm9zbThG?=
 =?utf-8?B?a0FxNUh0MlRSYll3WHc1c3FhNS9ZS2NGM1R4YTNEeVhIWHdvOXpUNTc0STl0?=
 =?utf-8?B?YzU1ZjA1WEZkejV6WVNmSlJ2UHM4bDVHd2FVNHFHRXlQdVB6TFpKVWtRUlRJ?=
 =?utf-8?B?c1Vqd1NmczRkTkJVSUZhWStOYkhRcC9pYmhuWXlvYXFCZWlGR2hpek1aVEpz?=
 =?utf-8?B?TmNsY2M5SVdNN2xoZWFGZ2hPakVjUmJyNno1UHdwRjQwOTAwcGM2VzBzc1g0?=
 =?utf-8?B?alNxSlhQRmJrckRKbXhCOGxoY1pDL09BdWNGWUU2ZGJlWHdwNUxBaHBHWlkx?=
 =?utf-8?B?cWsxVTI3Q25MYU5iVnQ1U1VhZGo1NmVBSmFnZk5QT21JYmRMWlkxbDNiSkFp?=
 =?utf-8?B?Vk5mNEtYdnJzWWhtNDNLanRaY213SjFqeWNpeHRqQUl6WlNrWGpEb1N4Z0hE?=
 =?utf-8?B?aWd6MVhVRFM1YWM5WFhJdTBsSDEyWnBnZ1lVcUtrRm5Iai9xREM0UEhwblNW?=
 =?utf-8?B?UzFoR2c1TkZkWGVlSnQxQkVGaHNzVlErM1VYQ1JzNTIwMGNqMzRpUUZPN05u?=
 =?utf-8?B?QjJqdWJCcXJIMFhMaUNpY0w4VzhtajBVb1dPTERJa2tUeVVtTm93dUdRNlYr?=
 =?utf-8?B?S3ZQTWxRRlZRMVdJcTJXbytvanZTeldJM0RFd1h5U0hZU3dZc29PN2JBaklh?=
 =?utf-8?B?MDZ5TlZUWjZqM1M4cjEzUmQ4V2VnSlY1QjdsVGFUY2JlUTRTZ2dnUExBTU5V?=
 =?utf-8?B?Q25VbjEwM3FRU29ZQmJqNVNzNGZJWVBUWEFiL0ZXTUt1NlV0dHg1WlJmaEtW?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb79d9d-e434-4972-d84b-08db03aa58fd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:43:57.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/QvzuIBpTykLvAxRWeeuiI2ug+yg50kwkKf02j3s8VwPKSma0BYNFPNYuI12DdPVNmyWqwt0tpaz449xhT+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 03:35, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
> 
>> Subject: genirq: Use the common function ...
> 
>    genirq: Unify irq_expand_nr_irqs()
> 
>    irq_expand_nr_irqs() is implemented as a stub function for !SPARSEIRQ
>    builds. That's not necessary as the SPARSEIRQ version returns -ENOMEM
>    correctly even for the !SPARSEIRQ case as the ....
> 
> 
> But this common function is non-obvious for the !SPARSEIRQ case. It at
> least needs a comment
> 
>> +static int irq_expand_nr_irqs(unsigned int nr)
>> +{
>> +     if (nr > MAX_SPARSE_IRQS)
>> +             return -ENOMEM;
>> +     nr_irqs = nr;
>> +     return 0;
>> +}
> 
> or preferrably something like this:
> 
>          if (!IS_ENABLED(CONFIG_SPARSEIRQ) || nr > MAX_SPARSE_IRQS)
>                  return -ENOMEM;
> 
> which makes it entirely clear and also allows the compiler to optimize
> is down to a 'return -ENOMEM'.
> 

I'll drop this patch since you're suggesting to remove !SPARSEIRQ support.


