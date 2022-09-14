Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D468D5B7F27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiINDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiINDAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:00:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5515FACB;
        Tue, 13 Sep 2022 19:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9yakpVmH0o26RnSpZQfK7RaNMvDAGFmiCx/9slb8Lheav0oqCzMbxO1YWyUdTbkdIZu8N5mlsKbxiVTGXJWhIElRtO/q9mIfJuy5bDaEqXiGTk/CWQlBFwzHX9NilMO9Y2rKYXVFdcd+Ai4M7nNWltsx6fE75yfi1bbO8EcRMLiKVAdo1NwMmhWaGooorShgDqlGLesTpIjRPz1O1NKGWhL1a/olx2g9uOW2bYThIlqwwYN7o04SEeoc8vJbbejIszCRwA40YMOqVKoU/x8GJKrTfz163tVLe6la9QtWTDBHUXRuJjLBFEYhBXlftt4dl/Pen3C48Xt55S9ysFR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2UJIM9a1QZ58RWkHm029OD7UjYp8ZjsNQ1jnCk/d4k=;
 b=MDwSy+ul2R5U9shGu5P4FQr+1KuoyhybnLGl81GrGyHuDuzdzIQqC+dUdGumRimpSQTFC86ATQ83nF9WrDanTUNTU5RJX3pZuhkBqnIMgJBbM03Hro7Ys/fnSV0bmoLjcu3en8kO4J1fuJnfQsqOa9vjPu9nHCyICkGIdjwvUmgn2pwghNZRZM0XPfC0NDJ5HqqaSJwcRgWDtufrULx9fUyjME28N4rjza3odVnZpor5mbhHCBjQ+k7EMUFFDnQaeMLhQFiLWUhEeqekrE8aXYnRhFi6GvcIgE3yO/DOJDLg9tczT32CZ7PTMGflQlTuQUHohIRekeDwGxJrhA+w7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2UJIM9a1QZ58RWkHm029OD7UjYp8ZjsNQ1jnCk/d4k=;
 b=tX2b1/jksXZkodeTEA+UDstQNABEOTRI5s3NeZzniyNB1rJHnj1YFZUkngL5EFv9IaFYfvmFt0V20sx5iGdpWLpcq5LEmCDA4T0R+lbKH7tyhD+pDTcO8fMbRqzZZOi5VRXkLiJZ+Lbf1zR4+56/n3qjdQauqcvnV8PLl68ReTMkznndauldgJ2AM1e29X/bXuZWaX4eWyboAH/8dcM8da/gZ7G17k/4cKv/Tmuv8oiM63wMbnWff2nS04XEYcMwYZWfk5jZJjqACZMpHWxbCwGujP3qePF4UN/1+G6I90mavv6JK1icTm1hKNvPjixHcHXlzEUXsEkjNyvbYiOUMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 02:59:56 +0000
Received: from CH0PR12MB5188.namprd12.prod.outlook.com
 ([fe80::4de6:2119:9e85:e101]) by CH0PR12MB5188.namprd12.prod.outlook.com
 ([fe80::4de6:2119:9e85:e101%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 02:59:56 +0000
Message-ID: <42ae1deb-bbdd-2a16-c671-0bc17d3e2647@nvidia.com>
Date:   Wed, 14 Sep 2022 10:59:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        bhsieh@nvidia.com, linux-phy@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20220816082353.13390-1-jilin@nvidia.com>
 <20220816082353.13390-2-jilin@nvidia.com> <YxS6FBeyS1Cs7xhI@matsya>
 <8d33abb0-51ab-67c4-50b3-ae95a5d9fb55@nvidia.com> <YyCVBVRQo+qPo5vH@matsya>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Organization: NVIDIA
In-Reply-To: <YyCVBVRQo+qPo5vH@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0030.apcprd04.prod.outlook.com
 (2603:1096:820:e::17) To CH0PR12MB5188.namprd12.prod.outlook.com
 (2603:10b6:610:bb::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5188:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d0a3f3-3f3e-4847-0fa6-08da95fd3452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Zj0hrojgGuyFUSrozI+UvMfXzzLGFctOGBVWvSZhOjGxc6X3Sbk/39b4ix0OUXzyWcajsJerqDWM6BpDDnZTZn01SELxJKEU7G1PX4fTi+4ZVfoi9bc0709hX0FQWZSiKB2IcqhfYK0Ymjv2jT74TD6uPJu5Fq2dy5ngdyXVRRKzC2efUm/qzJMvYccMqHhCvqvjPNCfdAY5rMwMm20CxKQhLXSneC7lPMWZWUlOw5WXOlqzrH1r3KssMZgQF1Mp34llHw6nSjJcTR/IcmTOJV2VllnIVrVLSF/uAb5/T6l5McNUAeCaolDDpAyllBXs53b7iLtqTDlYEvD+S+cZ3bbwhffSZhvhvo+04rn9GBCR7JW39UPedddQA6wMdDDqj5itEHDqFcDOCc3MZ1pQOP31w+0zASAzZMtFrrz/YWbY6WYbByCnE9lw+VnYUmNFeIGvtwp+0B3HPXQkXI5fRA7+6iK+8JiPuNqlwr+PUTjO904wylYfLJ6DVhobFz0vpMmkSdsNenbF4NfEs2HQWD12LvKs0ELpiz3TZAjfiUyyIC/fx1hXV9wqdkrYWo1wDaypiZ98ZxJ7B8+CH7zkREAoU5/sDgtr2MRzb/8Q86UwfTvdS06qSJaZBBm69e3bZ3gJmqqnRlmCDZXmOInCOVa5OIeaWHWsIIMtKRMSDfUIJNCVhOx3vAFIfn2ZRCEhqGvb/H7EpcC4z542VAokGzX4j9NxtZo3G5D2TvQ7U+6PWMD3poJPa1n/lrjL24v4oW6xQTDQJgJIR6mFPoSqhF40l0Sz1CbFYNUusHyiJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(31696002)(86362001)(8936002)(31686004)(2906002)(5660300002)(4326008)(8676002)(66946007)(66476007)(66556008)(186003)(36916002)(26005)(36756003)(41300700001)(53546011)(2616005)(6512007)(6506007)(316002)(38100700002)(6666004)(6916009)(83380400001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujc2di96bGkya095RnJMa3NYY3gwQUErQlJ3Q3JqK2Z5RmlQL1czMDFGSHpP?=
 =?utf-8?B?NG1YRTZEbDVPa2VodHM5ei9KTGF2NDRLRGs3OFFka3ZUYm5tVFJVdE1nUldk?=
 =?utf-8?B?cHBLbElmanlEaHNYa1ptVGVvUE0zN2JXQ3B5WklkZTgrMVgvUm5wOWl4VVRN?=
 =?utf-8?B?MVFhbXo2Ui9pTk9HL0V6QXlPbnBWOXBUZlVhNmpobDBHUS9KR3BqMThDV25B?=
 =?utf-8?B?NUY0bURoMzdWYlRWZmNqR3ZGb3daS0NXWjRVZU9FU0tkOUtHWlZJaGIzczdO?=
 =?utf-8?B?S1JWb2t0ZVg1OG1EKzZuakJqdVNiRGZCUGtvMnhOQ2Y1Smo1UG1oUEVkMjBi?=
 =?utf-8?B?YXdCWmRFYzhkTXE5NjNZOVdGb3ZSS05kOUo4WUorMkNCUk1rbysvYkc5cXNC?=
 =?utf-8?B?NVQ2aEJudnNhUnI0WUxnUWlma0lZODZrcVNlcHBaVDUxdVV0ZWZkdmNUbGZ1?=
 =?utf-8?B?elRacTgvdDVQOEdVSllUR1Z4d2NndjlDYWFReElkcDhwbFN5Z0R0RUZaeXVR?=
 =?utf-8?B?L0twZHd1YWhyMi9NWEhwQ0J6RTNzMmlhQnI0aVlDOWZRWTIrNkdqVUJ3eWxz?=
 =?utf-8?B?OUhmSlRRSW50aXM3TktOSHVFU2lFVHJtMktDYlp3ZlVjWWFiMUdhVUVoTlFj?=
 =?utf-8?B?a3g1YnVIOVVKVnh3WmVrM0RMZFRrM0lSOHdHcmc1MVdXVWI1MEhFYkpBR3ov?=
 =?utf-8?B?d0lxSlhkYTBvUjBnSGJsWXZJcnVqTVlraWl4ZVhuYUIyWGtPdmR5elc2OG1X?=
 =?utf-8?B?UDZLdmYxRkZrQ0w3TmwremZDK1pvU2dvVzdGclM2TUxzOVh4Mk1RcU9QTy9F?=
 =?utf-8?B?OVhaUGdpdkhJdTFGL2UyaThkSFFBUUhjR1Jha0w5aEk1aGpHcWZ6WUlaYmpm?=
 =?utf-8?B?bWVZTFQvU3FVcHRaQ3YraFh4WmJLK1NSZEV1VDNWREFaNUlmem5IQ2FzTTV5?=
 =?utf-8?B?RHptblZOb1JleHBveWx4ZkZqMFlMeUVhdVhrVGxUNExjdk0zVHZuQmlBTm9S?=
 =?utf-8?B?M2NWMkJYODd5ZXhJaXcvbUVybnFZSit1TGZxTGF1MkF4cXR5Mk1ZZjRaQU5l?=
 =?utf-8?B?SjFnVldRckQ5ejAvZGhaWkhaRE5zQThzQXJLVzBQL0JXa25OT3BJcWRyNlQ1?=
 =?utf-8?B?R3BKZEVrQ3VqV1ZZbE53MjQ0Vmc2ZmkwdE54WDBqSEFkaHpWaTJnM2NOSWRv?=
 =?utf-8?B?NHEyd1FSMU9uV05pQ0xwMStRVC93UUd4anMyNTlndDVwNWgvVlZBczIrMnFL?=
 =?utf-8?B?SEVMZW5QMGlHUW9XL0xiT1lVWTlFbzV4OUNONG1FK2p4bEVpRXVEVlM0bkpP?=
 =?utf-8?B?bkVxQm1ROTgrc3FrcXBBaGxXOGk2dmJXSTRKWlpySzBjNGx2VHd1Y01ESzZw?=
 =?utf-8?B?ZnQ4NlZKL205cVR1UDhkVkJnT2R1OXNoT3NtQlVFbGMvd251RThoRDFZelZI?=
 =?utf-8?B?eVFIa1hGdHNhSnV2SXlHa2pUekVuUzJIbXZDSzdiTUh0a3Buc3hhSkI4aWZv?=
 =?utf-8?B?SlJYR20yV2hHVWRENUh3UnNmdktuQnoxUmppemptdHkrNnBjaE9TWHc1QXZv?=
 =?utf-8?B?UFprR2d0aElxajRLTmJvdHRJV21NZkdhTy9CdnBVdEJCTEhVUStMNE1XZG91?=
 =?utf-8?B?WjBWVjVBdnZWVDIzMzluV081UkdJdGdyZFRKU3JHSDN1Q3dpYzl6c2NBbEto?=
 =?utf-8?B?WEZwM2wzclQ2d1pkUzlMSVhtZUlyY2o1ODd2alBzSXFJanlQYld4VEZVOVhq?=
 =?utf-8?B?cHJpVUk0WTQ2cTJRcXBwV2EyRU5KdkRxdVVDekt2azRFMkcxbFhHTTBqRTJm?=
 =?utf-8?B?bEdQZUorQXlKWUZHRWRIUFkrSGlkbi80NVFtSWxJODN1dE03ek9nSnFwYnFU?=
 =?utf-8?B?d21KaFFuZWVqMHc3T3BOVHhuQzFvSmFNUlZudEt0NzVWWlExU1ZqR0JyRGFh?=
 =?utf-8?B?Qm1oRXJZZ2Z6UVhXd3J5NWkzOHFDZU4rTEdHeXZXblRnT0Rpc0RXS2wzRTRG?=
 =?utf-8?B?a2JwWlhOaFRSVDJGak1PbXhoRWJmQWxMU29SU092cU5UNDBWSGFDSFdLbW1U?=
 =?utf-8?B?LzRETktrdGx4SVdGc3lMZ3F3TTBTbkxXUFZFOU1OZEdoMjFVc0hUUjRTL1J3?=
 =?utf-8?Q?szZj8T98//jINhXwHe5szgwet?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d0a3f3-3f3e-4847-0fa6-08da95fd3452
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 02:59:56.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7j7f6uTxezq6J+icRWuTKtwxL0n5MeC13HexCgLa/GIkdVdxKcsOHcpFG1rR3gU0RAcJweq5v8UY1h1rJ3uLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 22:34, Vinod Koul wrote:
> On 06-09-22, 10:43, JC Kuo wrote:
>> Hi Vinod,
> 
> Please _do_ _not_ _top_ _post_
> 
>> Before the device or host is being attached, we can keep most of the
>> transceivers powered down (PD=1/PD_DR=1) to minimize power consumption. At this
>> stage, in .phy_power_on(), we enable only the single-ended receiver (PD_ZI=0)
>> for detecting connection. Upon detecting device's or host's connection, host or
>> controller driver will invoke tegra_phy_xusb_utmi_pad_power_on() to power on all
>> of the transceivers (PD=0/PD_DR=0) to equip full link functionality.
> 
> Thanks for this explanation... It helps!
> 
> Just a suggestion, can this be moved into phy_init() you have detected
> connection in phy_power_on(), the transceiver can be enabled in
> phy_int... Would that work?
> That would work, too. However, because Tegra USB has separate phys for USB3 SS
and USB2, I'd like to keep the USB2 phy operations as they are now, so that USB
host and device controller drivers do not have to distinguish the phy type and
invoke different phy stubs. Furthermore, PD_ZI=0 does really power on the USB2
phy, partially.

For example:
1. in .probe(),
    for_each_usb_phy {
         phy_init(phy);
    }

    for_each_usb3_phy {
         phy_power_on(phy);
    };

2. upon detecting connection,

    phy_power_on(the_target_usb2_phy);

Thanks,
JC
