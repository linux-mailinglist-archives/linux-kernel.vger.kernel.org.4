Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA7722922
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjFEOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFEOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:46:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808E9C;
        Mon,  5 Jun 2023 07:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuvwR0vx/iwc5OShzZRIfE9DOQIvkrcb0brwqjp/7oUZJMTcKrTGwgDIdNTPPptl45TpfUwO0CxoNrpBO2qNi3LcKXzU9tHWwDbjJpWLldk4KQrKKDvelnw+5Gzlx5o7djVhOnBNT+lpGyKRMv9zpIB6LVzPeD1qGE4x0ju90xz2jRyKka9ylWeCsKU4pVAkHDEK3bQaVkxrNyD4Ia5ghc4GqFPIj3EH5BMOsO+8XlCJd64IO0it6f0CqRzjoPbqc9OlLk6YHpLUo+5LSgDucqfyz7JI3VtsU9GApi5+stTOO/l5qdj/cv0A07AD4bsIi8EDeuhX0o9lKM1lZgjWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dizmnCaZ5xgwzmAAPkwbpTO1h3wUBXi3MtQmW2f3MAc=;
 b=GP41KxRiD8zzdBkDNQsulaqZZiKGF9m6yc0g0xjPpvumTAF/QNbPdIkAgerhnjLQ1zA80b9sr7IP/v57adiBJxqCqiYQqtI1HWSjGb9qZA4XBswOZuGhOq5G9/6EXhAro+XowUQM3x/Hjzo6Cw5BGyWJfS3k5Kcg09GHRA/1dfaKX3uC3EHYnWwipv+vPW3PxevwbmLZkDhfBXv86jzuPSm2qc5wLe6OI+nhZiSkQRc6dkahspG4NP6dWDsrZfmTOSxoV0AEDsRgraEJinhf/8j2sXiKd6ijweOZXNcER8vIasQg5znEFvVIrBhqHrlMR3pz0Zp0QcqWVdZ1JgN+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dizmnCaZ5xgwzmAAPkwbpTO1h3wUBXi3MtQmW2f3MAc=;
 b=5aAfx5UvpeJG2wmsHlCOd1M3c35ZsXtyZoqYcpd+MrePwwh2JHSHuqwBHykEw1PqHhL1345MTiF0l+Y2cDaLWijKodgQkjSt4Zp5P0l51uYXl0hWlMPs/Oq1Rc4baXrvbduDKBhZt3UdJHqfPWgeXi9cCtNR3OS5wa5g2IyLmSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:46:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:46:33 +0000
Message-ID: <9d420293-f5af-7563-e7ec-1e42bd69bb8e@amd.com>
Date:   Mon, 5 Jun 2023 09:46:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] ACPI: resource: Remove "Zen" specific match and quirks
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, ofenfisch@googlemail.com,
        wse@tuxedocomputers.com, adam.niederer@gmail.com, adrian@freund.io,
        jirislaby@kernel.org, Renjith.Pananchikkal@amd.com,
        anson.tsao@amd.com, Richard.Gong@amd.com, evilsnoo@proton.me,
        ruinairas1992@gmail.com, nmschulte@gmail.com
References: <20230601221151.670-1-mario.limonciello@amd.com>
 <CAJsYDVKoB1AEL47Ud+8jbxMrbZedM0i9p44-PLQTFR9PKLfy6A@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJsYDVKoB1AEL47Ud+8jbxMrbZedM0i9p44-PLQTFR9PKLfy6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:802:20::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb979dd-1dfe-4192-4dbc-08db65d3a818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KM/gzkgB1Jypi8jt3jcZmDmvAMcZIT+2FIUY/qmlQsCnaZukTFmorPaGLjR2YAQGoGPGejXFwAYYzkmKz3bDSQbLTY8YgiiAJ00fx9/LK9GH0t4jvNYSeCqwSu82i+24SRyQFnQyChcETC4bqSk22V1tNeLNpC99/aUgTmkwbLEDdhKTt02BTCvPKHbR/NpML6Bx2REuPs/pLMy3Frr9stIPeaNWJt2us99KURwrX0AjBM9KI0FOt+w4/NQhtwnhwYQQ6AxbKs2tgd5QGro8ba/lsAwwRgSOPX2KQ7pLzsfdj7jZKYT9m17iYhb2rgupLnMWWDwQv3sQYAq6CkU3LIsODe4pRIcG5ooFXAeI25V5CzWjl2lm7ZEdGNd28UWeNE2lMk3qZnGwzO+9r0hTxcCmfATD8yUrY7wBXJ0YzEMipUaLX/9TzYcByeD269sPRAvkJlejh7zvNEXXmenhtr3lXkDW6QiTRMmOGRM0ozGlunTXET0AN3T1ZF8l9Cwljr3FI0RzF5/s1WLjh5VlhZnQrHzg+0MMZdmfGgtlnyuKCNzQ5eJGAi89cNFJ2it1vfTWablKgndJwCEkBW5kt/HYGSt2tVITo7mutk1CXdnk9fkE3Dt8rdqtjRBuikAdC1pUZQyh6xhWFlUlVVfzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(83380400001)(38100700002)(86362001)(31696002)(478600001)(6486002)(966005)(5660300002)(8676002)(8936002)(7416002)(66476007)(66556008)(66946007)(6916009)(4326008)(2906002)(316002)(41300700001)(31686004)(2616005)(26005)(6512007)(53546011)(6506007)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJ1RGVDYi9SY1N2Z2R3akNLYWtNSUtBS3RJcEc3a0NGK3lkUW9taXFWdGhr?=
 =?utf-8?B?MWFzRVp0dUxEaEUwR3Y1YUtaeFpYT1RrdEozNzZoTWFXUHVvbnphRW9CWkpY?=
 =?utf-8?B?TldialVEWDFldlFSc2s1c0t3SUJjdm9PUDFnSUtGMVlwUUhJcFZQa2gzZmVV?=
 =?utf-8?B?cDMxYmZTVy9EV1dLNmFGeWZ6UC9aK3NHaU16ZWtta2N6YWpwNzB0Q0QyTzNZ?=
 =?utf-8?B?U2NLUWIvYTFQb3FNQXZDWTVvYWZqV3RFck9JcG1pMTJGa3g0Y2pwbnBjUTFX?=
 =?utf-8?B?NFZzSXZPckhVTHVqK1VlSjBPckJGcnB4MXBJYi9xbjNqYUVCMzJMU1lybzl6?=
 =?utf-8?B?aUoxWktSRGRyZmVlcDdKQTBzMy9tbGJnNkkxVC9uKzRDck5ncGNSWHFiUnY1?=
 =?utf-8?B?UnBZVE9zamFvZmxUdFhFK0VhZzhHRWtjRkY0dzU1UWN0Q0dRdjEwTVNlUk9E?=
 =?utf-8?B?M3lhOFhCN0RXYTdEN05UVWovRnBmTGNkaE9kS1FNQ0VQUGZOSzZERkc4MUZp?=
 =?utf-8?B?by9zOGhSa0JURjBXSXViYWJ2eUJvZk5NSThjSTBCQnlqcUJZcGhnKzU2V1l6?=
 =?utf-8?B?Z0Ezcis1SEsyRm1HUkRRQjhhODNyOFhzSGZZMnZTVWNSVEk5dUJ0QThYTFhz?=
 =?utf-8?B?TitMSW5XTm1IbzlQcnFNaVVRR2JnQlk4aWtZRU5hV25NY2lvYk1BWlRCNnI2?=
 =?utf-8?B?TXdXZFV6ZWZqcmF5NUZzNkk4ZVhzUUhzUTFXRW1DSGI3TDJ3MUZWeVRJOHRO?=
 =?utf-8?B?T2Vpd3pKbXZnM0Fhd2JKVXk0STJuTVRuc2JRYTNZMVpnbnE4TUVkVUZkOUFj?=
 =?utf-8?B?KytiRGN2UVF0Q2lleW5hV0l5c2hhMlFyd0tJMEFFL1FzN1VhSjliWHRHVEcw?=
 =?utf-8?B?c2dIZUVhM01GMG9mUkUzSzMzWHRLZy9vNjd1NDBaSTJMY3BsaFl0T3BrRjZh?=
 =?utf-8?B?Z3JXSUdjRU5pdnRHRUppb2RLVTF6VVhpTHo4UE5VYkdUNldSV3F4MUcyQmtz?=
 =?utf-8?B?WTc3UXdCZ1dJWERzb0hOeTArUm14aEZhVDFmNE90YWMweTJsamlvMkdPWWpH?=
 =?utf-8?B?aSs2eDVvWFNpNnhkVE1LMVVMNkZRNVJYbHFUNURqdGlVQlQrb3V2QVU0ZGlG?=
 =?utf-8?B?dFErekRvdDhoeW5TVWhhR2Z6S2Jka2xybW1VUC9Ud2dncFM3QU5NR0k1elJQ?=
 =?utf-8?B?NzZRcXE2djBwU21tNWtQN0NzVGdtYkNYcC9XZjk2YW9vTWZTbnVaT0J4TFY1?=
 =?utf-8?B?UTdMU2RUNnRaekYvUnY3Yy9CVWo2d09nQWpIbGpLWG9yNyt6eWY1d09ZNDVQ?=
 =?utf-8?B?dkNjN2x5NDZ0aEZmakduZGxZdVBpUEdHQzVQc2pXRkxucklFMENiV2wvL1JR?=
 =?utf-8?B?Z2oyRWRJckMvWHBqdEkxcWdIdHNJVkVuY0VVZE0zemtjVFJjRFA4ak5ERjR2?=
 =?utf-8?B?WlBPYWZxMU9qOUxsOFdZbjFzc2RNOVhZQUIwbXpIenVRdTRmYkZQTzcyaUlP?=
 =?utf-8?B?cUZsNTJHNHRweTZRWXhVUFFkVmhnY2ZLYVJUZzdUS0ttZUxMaTBpd2NNS0Fn?=
 =?utf-8?B?dlpkdWJkY3NFR1ZjU2dmeVdnd1J1NGc2YWxhRlhkNmQ4b0ZYRGJDRlc4b3FO?=
 =?utf-8?B?MDQrZVNDNTExeWE1UkR4a1R4TVJmQnpWR1QyMWVFQ2RnUmR3a0cxeWVVMHo5?=
 =?utf-8?B?alhSb2E4TUd1bjNGOFpPVnFqVnNYcmNTb0VEMGxFOVhHM1J3ZFhyUnZyOHlH?=
 =?utf-8?B?a1c0L2Jsb2NLVFU2WTN0Yy9MYjBTUVFPUXRGRXFWM2VZdTU4SkE0SEd1SnN1?=
 =?utf-8?B?VG1zbzhWbE95NHhLd1NJSXIzR2NMRWJmYnUyOGpsVGYvUlYyeFNIMWhZdStN?=
 =?utf-8?B?UVhJa3pUVlluYUljWG42Z0p5Vks5SHNQSFFpQSsxL3Q4Mk95S3ljRStUalBa?=
 =?utf-8?B?NWloUW5SSmZVYjFWTWo3clZTQmZBNklKNHFSR0s2OW40MGw0OXNGVUp4OU9o?=
 =?utf-8?B?bEVGRUo5Q2h3Y1JEUjBkU2M0VjBDRUZSTVZGYWQxQ1ptNHBGdzVvOE94VDNT?=
 =?utf-8?B?MWVValVYdk9ESjJqdUp6RXhobE1CS2ZZZzd3QU1OR1lNUGF1b2luMnE0eGFn?=
 =?utf-8?Q?zqqCOaZSuBlMT2Tf/i6Y3Mya5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb979dd-1dfe-4192-4dbc-08db65d3a818
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:46:33.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEgKY5OMaVy7//LoUNMRmKOtqNNGM2DLTsyMsnZ5oatD3sKBQSo8Gy7cd3ccsv0eC1TyegMdG/nYlzrfofMy3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/2023 5:19 AM, Chuanhong Guo wrote:
> Hi!
>
> On Fri, Jun 2, 2023 at 6:12 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
>> AMD Zen platforms") attempted to overhaul the override logic so it
>> didn't apply on X86 AMD Zen systems.  This was intentional so that
>> systems would prefer DSDT values instead of default MADT value for
>> IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
>>
>> This turned out to be a bad assumption because several vendors
>> add Interrupt Source Override but don't fix the DSDT. A pile of
>> quirks was collecting that proved this wasn't sustaintable.
>>
>> Furthermore some vendors have used ActiveHigh for IRQ1.
>> To solve this problem revert the following commits:
>> * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
>> GMxRGxx")
>> * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
>> * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
>> * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
>> * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
>> platforms")
>>
>> Cc: ofenfisch@googlemail.com
>> Cc: wse@tuxedocomputers.com
>> Cc: adam.niederer@gmail.com
>> Cc: adrian@freund.io
>> Cc: jirislaby@kernel.org
>> Cc: Renjith.Pananchikkal@amd.com
>> Cc: anson.tsao@amd.com
>> Cc: Richard.Gong@amd.com
>> Cc: Chuanhong Guo <gch981213@gmail.com>
>> Reported-by: evilsnoo@proton.me
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
>> Reported-by: ruinairas1992@gmail.com
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
>> Reported-by: nmschulte@gmail.com
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217336
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>   * Adjust to drop heuristics entirely
>>   * Drop tested tags
>>   * Add more links and people to Cc
>>   * Drop Fixes tag as this got a lot more risky
>> v1->v2:
>>   * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
>>   * Pick up tag
>>
>> Rafael,
>> Please hold off on picking this up until the majority of those on CC
>> have tested it on hardware they have and reported results.
>>
>> Everyone else,
>> Please test. If you have problems with this applied, please share
>> an acpidump and dmesg either on a bug or to me privately.
> I was expecting this patch to break my keyboard again but
> that didn't happen. I'm on the latest UEFI from Lenovo.
> By dumping ACPI APIC I found that there's this:
>
> [0C4h 0196   1]                Subtable Type : 02 [Interrupt Source Override]
> [0C5h 0197   1]                       Length : 0A
> [0C6h 0198   1]                          Bus : 00
> [0C7h 0199   1]                       Source : 01
> [0C8h 0200   4]                    Interrupt : 00000001
> [0CCh 0204   2]        Flags (decoded below) : 0007
>                                      Polarity : 3
>                                  Trigger Mode : 1
>
> I don't have a dump of the ACPI table from older UEFIs anymore.
>
> Tested on Lenovo Thinkbook 14G4+ ARA with the latest
> UEFI (J6CN45WW).
>
> Tested-by: Chuanhong Guo <gch981213@gmail.com>
Thanks!  Yours is the one I was most worried about.
