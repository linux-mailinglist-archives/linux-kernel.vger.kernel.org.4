Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40906F5BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjECQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjECQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:11:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEABD6598;
        Wed,  3 May 2023 09:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6zycSL4koqD1fXH+iFYPbJUDhmPV8g8rUS8JdjHqkexuBhjdDUGycitQ2OhiXzD2k006wZAL0BkZaag1b+OacdD+8WrTGOarvAQ7vay3fcB0R0TPv8cnvVX9JZqv4EwcvC0D/Jx0I1GTuvS3sPhMLf5yDtaSGf0K73tHmnnGl6Rf593EtXR4lvFkZbkAYMYd3U9wKUVYUzXEm6qlcOZN+t6XVJ/0xx17bLzHqbhdvoUJ6aRMKgCKt9/qgduQdrql//+PmnjtkhlB2D4JMQW7fczG0Kicj6m4c/6Jz2QmcGQ+65wj75RYPkxnhvEZUSZeOlB9T1YlOJ9n85spaDlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFjv0Tiz6YFGRNmolvdoQGnymrZf40i+xbWPADBplxw=;
 b=JyA4GVLA0F/s2qkWYsep1nh5E6esZAPGtw8U3vYNnTYzqhv7eQ6WbSQUAnQkWGCR51btXeVMxuUVyiyIi8aslface3I91sI9iZ/QGlXJVr8tneC24hyM1Nr/RVFqAeLPHBpDyCAi4NtMi+DZBlvXXVQiSooKXzeVy5r+EvPNc01exw68sh8gEOhCVsaT2OM0mCkG5vZrSXxOJMWHhY/yWoGespuS9oNZziqpxJX5OSgL3kpommsSUYsmalpFSpknF0TtB9/PE52Jb7CNBuL9TJ7LqrXSSH0ZDRSG5z0xZrIIh5Lgcjetye2F6g6q3NYCfIcP2CDNYRMzfGovV4lsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFjv0Tiz6YFGRNmolvdoQGnymrZf40i+xbWPADBplxw=;
 b=T8EUhTMRk8pUnTp8HQLKOr8stZECgBMaYz4EsQ0TmxHiD6AD+3mCbyLqVh5N6LD108wq2jEm6GvWI0M7to+f17dY41E8+3BMhvkR3/YgBnpaHFF9uRWqvks/s04I8LqK/SNgrWmq+5CtTgznO5RnkmV09kQpgo2Tl2KWUSsKDIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 16:11:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 16:11:36 +0000
Message-ID: <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
Date:   Wed, 3 May 2023 11:11:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [regression] Bug 217394 - IRQ override skipping breaks the Aya
 Neo Air Plus 6800U keyboard buttons
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info>
From:   "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:c0::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cb7b51-2e39-4de5-8a1f-08db4bf11203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YN2EbaqnVMF7CtnW6Vzn3uzYN6k+LCzh0WiSOEPQwTNqHeZTtuPNESqYvDAiy3z5/UXNGZpfXQ5gTQHkD4HlSqF01SqIBCPLfzstxxS78bvcZOLr0rUx9SByGzms1ZWVGngCBW6bVqZdGlvvk2rjqJnxn0rlA28+m14K2IG+pXHU4ZuFmcm1It+rWEimve2ts4G1vLVRMqxiqBpgoNvmJR3PoKgyh2GPANENCzNvQxN/ylijpuWYirF/lqy0zh1PFBUVH676Ew5uj1kZIis8LlcGA2/lNPcYrC0Hzr9qIkHMFokJ3dII0re+z9c8kU6QJVu9+9j38w4TnMzFjFy9DTy3hrxpi4121UsndN1Jx9Mo9bU9PZ6QmeMIA8euvDbS+CjwtGAXmhdG9QVrdgKzHtcLjK31Pj1i4Q3+slJfBoiidYkVblGSHu1vS3r1sxE+a3ZW/2tDwZhmNs2ahm2sOMhWbTQZjNaXzEIo7ii3br/x92JJAOacENTa77G36MnsNCR4li7ceV6HJnb3K0i1diJqhtRB/bUsn2Gmj6GyD4/3YRHjuIMOolI3R8XVk10gob0z3nWr4TL6uQ/bLlGaWM5tHmxbQwoRkJuUa2hGrH0BkQXfktT/DpOgHJwtbZqcuRl3+oQhOkSPOqR7aOjAJ9D6/xj23CY2a0VU0AtBy7bnDID9dMnwKiMpE6LGSsX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(31686004)(2906002)(5660300002)(36756003)(8676002)(8936002)(41300700001)(66476007)(66556008)(66946007)(31696002)(966005)(6666004)(110136005)(54906003)(4326008)(478600001)(316002)(6486002)(38100700002)(186003)(53546011)(2616005)(83380400001)(26005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZiNUdMbytHRmVJUjgydlRqL2xJdWtSdUtxajRJK05mUm5MRWNvd1hEYlJh?=
 =?utf-8?B?d1kwQlpZTUlhd05GYnlMV0pNbjJCUG9jUy9leEZrelMzRHZ2Q1lxTCtlaHhk?=
 =?utf-8?B?Y0lpSGRkZFM0QVE2dVVOMVkzcHJyQkJlNWF3YWtIWkszOSs1RUhSUU85VklT?=
 =?utf-8?B?cHg1TThTSU04VlJBRUN5b3hQVEpOSUN4Z2dPTmFsdjVraFJQbXI4ZlNrS25z?=
 =?utf-8?B?b2dJa1d0Y2pWdFBqN2hEdFIyWHAxOGtWTktWK2h3QjZoeG9FYThQdEdaOVQr?=
 =?utf-8?B?eVpvREFpek1UbVY5QlJBRkRwZ1ZLSkdlNFIybm9MaUl5K0NLRWtlUVpRRkhE?=
 =?utf-8?B?UjBSTXZEMkxuR0MyT0tkOTNobG4rYXdXS0FYS3RFSDRHQ1hNekJEU3UrYW92?=
 =?utf-8?B?UmtXUlFSaG4xRFE1bG42aGtqTTFzMEx3R2d1MjJsdi85RjNIWnhlNnVkcEo5?=
 =?utf-8?B?SE9YMzRWZXZ3NlhyRUc0L3RkRklGSk1yZUo4VlBmTzBINVM1cEp2QkVDQzVH?=
 =?utf-8?B?NHU2RFVxSVZIUW0yVC8wUFhMa1J5aFVjQnlxdkRjRFhmbDlsTGdUeWg3U093?=
 =?utf-8?B?QmJyc1RWcm9UVitmaVRYd2Fla3FwbGRWY1Vkd3BhM1c0SWZNc2RwZmpLTXpa?=
 =?utf-8?B?aWxXRjdNNnFvSGZtRER5K1VnRnRYdW9MRmNDdTltd09RS2x4Ky9UWnZ0K0hk?=
 =?utf-8?B?bm1yY1dwUUJ0M01SMXVPcnJod01va2hsUmtUMHhiNU1xMUVSZXBQaUpjWkIx?=
 =?utf-8?B?TThHcXNzZUQ1U25XV0NaZTRTRzI1SzdiRU82NUZoTTRTdVM5Yi82WTBDaE1K?=
 =?utf-8?B?Z3NmVS8vUU9ZZVVjeVBwLytCcEd3akZTazlIYkpCN1dsckVGOXhrRFFUeS95?=
 =?utf-8?B?ZjcyYzVBYWF5NjNtUDV3VHV3QzdVdXBCaElNdkY4REI0QUJiK0NrUEduQWht?=
 =?utf-8?B?NXE2SUN4RUlRdk5sZlpVMDJKSk5QcFZHN1hnTW9acTNrcmpzNXY3U1UrelVh?=
 =?utf-8?B?OXVRaktNWE5ZaFkyQmJCSWlYaWhoOExwdytyaGRqSk44S2NLN21PcWNrTm9i?=
 =?utf-8?B?UC9PaG1EdWhpNERjNGI1UHE4OTg2QjBjWG9uWHNrR2pwVFJydU5HbFVSWXNS?=
 =?utf-8?B?Y09Jdnl4NXNLQ0duMVZWRXNaU2FGbVprTDF5Nmg5Y2lqMmJ1WUxwajlIbVRO?=
 =?utf-8?B?cWN4LzBhNFhQM0tWLzByZjNCRFF6NUxSUFdsUUltQ3hlZHRsN25CZFdFa2FE?=
 =?utf-8?B?UHltZGlLNVVaQzlDZjUyLzUzN0g0NnBPRFh1TGllNDlONHYvMFFsdVVDNzZn?=
 =?utf-8?B?Z1MzRVh1MmF1SElqUGcvT0RWV3JnWm5JWUs3cUJubDF4MjIwV0kweDdrZTQw?=
 =?utf-8?B?cjJTM3M1SjhYMFhHTXpueVdBZk5Ub0laQWRPOEwxejNkTVc2di92VWpyRDY5?=
 =?utf-8?B?YUI0N1lXMVlOYWFkUmVjUEN5K1oyZlNEWUFYZGdIbTVlQWhha01uREc4azEy?=
 =?utf-8?B?N1hUTGtLLzd6N0xPbUJhVm1uOEZMdW0yQmFYaTBxSlRHK3hpYVUxMDhydUFX?=
 =?utf-8?B?WTRJUklBMFkvSjJlbFhvVk14bEVtWFl1WjZkVjAyM3dIM09LMThHTEFSYmpZ?=
 =?utf-8?B?eitKbzJib2h6MGpWSjh6QmR4VklGZjFpcnMveG9aeGNLNEdYOXBaTEpFQm1Z?=
 =?utf-8?B?bmpPZXltcGZid05nVVprMGYyTGg1aGhKRkNyNHRBc2tyUWVNQWpXandWc2FH?=
 =?utf-8?B?UEdFQTVMbUtKS3lzaW9TTHNXMkpkNkROZ0kzMzFKbVdHNGc4UE5HaWtSaE40?=
 =?utf-8?B?T0tqVTB1aklLbmxNTXQ4S3VEZEl2TkxpV0JEaVI3MU14VktBQXg1SjlGSDlB?=
 =?utf-8?B?VytVVGdyNG5aM3dabitWWXZjWmVLVlJDRjhBUnVTY01IckVKbVh0eEZzdWlM?=
 =?utf-8?B?WmhKenVqNyttblZOTDZRcU94RlBPV1dMamRaamk5dGtDTEdBNjVNam1RQ1Fn?=
 =?utf-8?B?OWsxcXB1dDhIejl1VWw3K0VPQ1Z1WE5nVUZvbWJJNWZ6NUpRelpxYXdkUnlJ?=
 =?utf-8?B?cjFPZm1NaW5PeThRSW9oeUtXUXlEcnI3MFU0MVN1R3ZsOHFsMUFJOUFYc050?=
 =?utf-8?Q?roVD1BISO733dtrwVKNTNSbe+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cb7b51-2e39-4de5-8a1f-08db4bf11203
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 16:11:36.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+NCLkq1YfTsDPW9Iip7XbTGEVkdzw2IDTXfSYxDzUj86ktDA38NRrHwrfilopuRLX5oX0Hg4efMKTn5jF7kHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-input

On 5/3/2023 7:58 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developers don't keep an eye on it, I decided to forward it by mail.
>
> Chuanhong Guo, apparently it's cause by a change of yours.
>
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
>
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217394 :
>
>>   Matthew 2023-05-03 02:28:33 UTC
>>
>> Reverting the changes found in this patch fixes the issue:
>>> https://lore.kernel.org/all/20220712020058.90374-1-gch981213@gmail.com/
>> With that patch the AT Translated Set 2 Keyboard doesn't show up with the evtest and is not usable.
>>
>> Hardware:
>>
>> Aya Neo Air Plus
>> AMD Ryzen 7 6800U
> See the ticket for more details.
>
> BTW: there apparently is another IRQ override needed for a different
> machine. See https://bugzilla.kernel.org/show_bug.cgi?id=216804#c8 for
> details (ignore the comments before that, the quirk entry for that
> machine was merged; comment 8 and all related to it really should have a
> separate bug; that's also why this partly fall through the cracks here
> :-/ ). The user is currently trying to create a patch.
>
Something I'm wondering about is if it's possible for i8042 to detect 
the polarity is incorrect when it probes and
to try to correct it.

If we could do that we can probably drop 9946e39fe8d0 ("ACPI: resource: 
skip IRQ override on AMD Zen platforms")
to fix this issue along with all the other quirks that have collected 
over time on i8042 polarity issues.

