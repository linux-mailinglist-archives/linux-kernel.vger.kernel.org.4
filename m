Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4126F987F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEGMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEGMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 08:45:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC682189;
        Sun,  7 May 2023 05:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuTcfUkOPCPLcA7fGdGIYrxRt7Q8cBT2DbO8mH7IbxHaxEtViMImoIhGmo9xGFWhsg+JzOfImVX2J4WhFaMwo/Tu3Wo0i4scboJeXOu8jAYQrVZpZOb/kp/Ms50PLBx6Wh8Ck5W9bb7B+A4UKHG6cqQ/V6GSgARaYKrPa0Ubboz2m7nAwLwg2rXU+pVt1LtUXW5nkSRJt9rYgU/FHxyqox0GWkfLUAfw//4ybIFGAVG3yQsrIdoYfLNIP4jtvx/+6a1wdR/nvewkg1pVDn1yGQoL2VMTHqx5oiCZQ7J7HexpqAH/ic0JfuGesPhrYPFFD4cS9Xl8ABPXl2Q6v1vzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oNvnFdFinpHF0ZtRkCtY4QdP15FwzHDDKkxP2UifhI=;
 b=a6z4yZGKjh8A0IjNMuf8x3tQxkAeAQzahcZydgK8PH0xarCnEkgYEL57lbYSwxt/Z9OYrgQ4J4qmCeLnDPc9JbZc5zZR9hvktdk08zkh9N1toEeHvyGv6tUBBK0zsyasdn4C6IIV9IWVcB8ON3EshkC3zptqeEavTFFW7MNmNlEttDepUDDXi4PF6oaJS1ScOOZ7sIt0wj7beWLhG+OLxTeywn/F7Pkl1cHjyj9IS/24a+OcpSWgn6gJOR8+afDmSdnnFspgxaJuaNYaCh2RWswyeHvL4Y8i0h191xndRtduu+Z3IDnlJo0GIpE+U3ANgiyDldG1K2c81T4GOEi9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oNvnFdFinpHF0ZtRkCtY4QdP15FwzHDDKkxP2UifhI=;
 b=FcFSJGXJeLkRxbzzcQFbZBrDhU3cF6yRpVEAnpZl2IMALe1RLbfl4havwIjYUIH0vE57iMm0ccEoOjSBjFgYWUh5YlqZXk/CIxFQAgFxRljJL3Zm/pAclLgTokkMF9twGW8BhRTlaJCQ8wYvlzBSPDIIvn1GsjFk9E5xnmmOHnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.30; Sun, 7 May 2023 12:44:58 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 12:44:58 +0000
Message-ID: <f60edac7-8ba9-216e-568b-2fb2aeb72cfb@amd.com>
Date:   Sun, 7 May 2023 07:45:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217394 - IRQ override skipping breaks the Aya
 Neo Air Plus 6800U keyboard buttons
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-input@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info>
 <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com> <ZFKvVKMesT+3NthN@google.com>
 <5df240d4-03f1-31cd-03e1-a6cfddd5cc1d@leemhuis.info>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5df240d4-03f1-31cd-03e1-a6cfddd5cc1d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:5:60::33) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: be6413dc-0cd8-47d0-be27-08db4ef8de02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 996/wR0MUZ6vpXSDfj/x6fBBkzDzByk7t0JtUOWLpLtyQ8Rt8hPy5Rrj2vPgOxImxaanOX1osWd4J5kEBPtgasaG/L8JJaq71YwdhofO4OLCVH3fXJrXM5WthnDQWH42RQ7OGlGil7hCGqtdxy00ioSzhV6HWUK4z8tcnokITZafEC/2qv64QosuD5F+CDoV4s5IcevYyds0hpu4fKltGItnC6kMRG8RlabU3aNSCzs18l1t+ASCuE3K1t0H8vgXuRcpQA0MiKEtvN0f+HQQb+XTjw1hWqqA1980pbsJ5GXsPRENyM3TRiKQD91nzbOfdpR8LQv92O+5RWTbHxFJTklM/pdK540iQtrrthPFxZxoGSmbSHTdbrK+0EPJ5HNGs6yK1knaHniyAQAsts0Ni7zaJhTBBLLe31HlLIJY2eYFJDeln2wCrFC8bxAivf4rL7xgudADdCT/8HOYNICEr5jfEuxr5/gye6Q/awwD0MI0kyOx9BMZobf9Nsjxn0eSeHFxOT/jX6g/o488pzPV9QDuCtuO8UfNnG1dBuSN0+LJsYF+QEoxPkZlee3U7kTnVc1RCkuCiPghiMSb0UhI4xf5arpPi22rrEq2EHzS+1Z7EvptF/u6KSaJKUkcvKrpcyJz2Vo1uoTRMzdlvXILstmLqwqVWT+PMSzOlMJDq4oeKUGQm2G1oOjdGIN7X5+W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(31686004)(966005)(6666004)(66946007)(66556008)(66476007)(6636002)(4326008)(478600001)(6486002)(316002)(54906003)(110136005)(31696002)(86362001)(36756003)(83380400001)(2616005)(53546011)(6506007)(6512007)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0U3aW5MSnBFSHNXdUpMUnNjZG8zbmkwbWhWRXU0RGxEN1lwS29OU0h4Z01W?=
 =?utf-8?B?Q3NyaHBnSEFHVGtONWlCY3NwbEdQVU9MdjhCMEEra0JDc29NWkE5aGI0RWRH?=
 =?utf-8?B?eTVLdzQycWJ2WDREeDhIYlZSdWlJTUZHbjVkQnYxZzlLZ2JmMWZNelN4NnZj?=
 =?utf-8?B?NkNqK0pKdkpiNEx2VTJnV2xxclkvbUw1TE9zN0dUTUhKdzlsYXRCcUtsUCtW?=
 =?utf-8?B?NlhoekhneTBTNmxtRnlGK1BWcUJQUitDelFMamRuWHE0VGYweWppRCtLcVI4?=
 =?utf-8?B?czgyWjR3OVhVRHRXWVZaQk9sQWJiUlc3ajdRS0RCclVOU1JYOGhtTnBNcTBR?=
 =?utf-8?B?d1pVL2UrcVlzMEovTDAvTUxkQ0QrMS83UnJpWkgzeFl6ZHlYRWJuMUhVNWJB?=
 =?utf-8?B?NFg2SXhmeHJmbHlsSVFSVUVGNGxJMFVwRUpVd2xOdHpGRnA5R0xPYmdDLy8w?=
 =?utf-8?B?enRZSU9FaGowNlJDVjVzMXU3a1JZTTBZUysvOGZqc1k0bkI2T3lISHByK2hm?=
 =?utf-8?B?QzFQVGpmUkFnYmlyNXRaQVF1U3VpRXg2SUhlQzQ0UEZzVEpkcXJ2VkEzL0ZN?=
 =?utf-8?B?UXlHS3d4eGZmUjlyem9GV1FrbW9PZFdXU1ZjLzJjMjZreTFDdEJHYTl2c0Z3?=
 =?utf-8?B?aWNOWEs3N1NOU2R5RjhPSkl3QWw1dzRabEZaVzlVczhra2p5TDFCTjNwMmVE?=
 =?utf-8?B?d3JEQmdCNE5jNFpRN3JYZHR3WCswdVNiK2hTRlhqdVdqc05iOC9PdVFRNEpQ?=
 =?utf-8?B?WjNQbG5ZemZYM1NSbWxZaXNRMzhOanNKL0JDZ2lWeHRqSkcvTnZuc2pHcXQz?=
 =?utf-8?B?TWpzcE0wY085WlY5YTFURXVYc2hPQ2xaTnA2My9yYXpKbHRwMzZFR0dNbmhu?=
 =?utf-8?B?d3hQMXNFWWRUYTUzbEk0bjFIL1RVTW5RNzlOcC9YckVTd2tUcHVMTFBxU3Rn?=
 =?utf-8?B?M0tzWWpncnVDc2p6WDMxd2QrWDZGdHFjQXZYMGFKU0pCb1p0NFUzR05WanVs?=
 =?utf-8?B?SmZqM0ttcGJDcHkraFV0eWNENWxVc2N6eTB5TjI5ZzQrNzRLQjI2VTM2UDV4?=
 =?utf-8?B?RG5YL2dLNytWbWRjMWJLMHZ6SWVMcE5wNkNYWHFxd0FuRkljWExRdHhzMWkz?=
 =?utf-8?B?RWVRTklvL0oyaERYMUprQlFqMjZVSE1CcjhnL1gxSmlHa2Nwd3lXZk1tK2xa?=
 =?utf-8?B?TlVtdHZkOTFJMnkwSXljN0ZNTmNUUlgzTkVuZWNwVmJyMU9JWGc1bXhDRFZk?=
 =?utf-8?B?bE16MFpCUjEzcDlvWGE2VGpxbmVTdUFodHFqek0zTlAyc2ZZbEJ0eUtYTUNO?=
 =?utf-8?B?OC9OWDN3Mi9ZWE5GOG9aWXB3L2UrMXpld0J1TXBHUkhBRVFyTTEzN2E2b21X?=
 =?utf-8?B?MlRTc1ZXeUpUalhyaTRVRzk4K3RiQWFURStqMWdtcGpLM0NVYitkUEtST1Fl?=
 =?utf-8?B?elB0Sm9iMEZCby9SRXUybzBKM0tjWmhzZVJreURWUTVNT1hFeURjV1ZFZzNh?=
 =?utf-8?B?eitEbU1SbmNuL0ZSNm9ia2I5VTlJWEtCUStIZkRkRHBvdTJxTWdOdkFWUGNq?=
 =?utf-8?B?RmU3YjBhdVNpa2NqNWhLdFkwNTlQcERjenV5ZnExWS9ML2p2OXhiTjNURVBP?=
 =?utf-8?B?QkFNUGNReDlVYzBhYlh3cExWQ0dLZVJaR3hJRkhkeUZZNDdLZndDdGdjVzJE?=
 =?utf-8?B?TjRYR1VLZHlSdUl5eWpweHYyRVdrQmFUTFdoaDFxMzFDRFBxQ0Q0ZERiV1N1?=
 =?utf-8?B?YWM5S0VJRSttRWpHMnlWYzZNbmdrQjdaSUNuZ1VWK0pwSHdSNE12Ym11TkZV?=
 =?utf-8?B?REY4Q3E1dCtzeEZTZDZMWjRWSnR0cHp4YzBnUElSUkZzNFFLZXF6MElZTTNx?=
 =?utf-8?B?NlJEa1JYWEhxMkh1ZGI4eStQOWlUMGNSckhYVnJXM29QaUVHSlovWHdFK2Va?=
 =?utf-8?B?bWNUVExOUHV6Qk1XK3FEcWRkNzVybCsrcXVKWkVTVGRaK0h6eXNXZ044cUdC?=
 =?utf-8?B?WmZ3VzRrUk4weDE3NS8yRk55SUNvVFdxK2UwelY2aVRKU0dzWFQvWlRmNlo0?=
 =?utf-8?B?NzJaOGkrN3lmTGlXYnFBYXA0RSs3UDRpUTl2aFhGR29SNWlvbTA3QnBOeG84?=
 =?utf-8?B?L2NNWi9uYzFIUys5YXU2TytXeGpHdXgrMGdwSG5GM3hJUlVib25aN3JKaVV2?=
 =?utf-8?Q?77nO+/hP5ffFb6QGGeJ7PJ1PRVEVplqBTw2pJrCaPrWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6413dc-0cd8-47d0-be27-08db4ef8de02
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 12:44:58.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vDQ+6jiLwTgbAnm7wbL/D6TKOLCQ5E5Tu3RDTRQbX47vvkzy+rmLhBC4Iql5MabPjXFYcQWsVaaL/q/8jaCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/6/23 01:47, Thorsten Leemhuis wrote:
> On 03.05.23 21:00, Dmitry Torokhov wrote:
>> On Wed, May 03, 2023 at 11:11:33AM -0500, Limonciello, Mario wrote:
>>> On 5/3/2023 7:58 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>>>
>>>> Chuanhong Guo, apparently it's cause by a change of yours.
> BTW, there is another report caused by the change:
> https://bugzilla.kernel.org/show_bug.cgi?id=217406
>
> ```
> I have an HP Pavilion Aero 13 laptop that comes with an AMD Ryzen 7735U
> CPU and an up-to-date BIOS. Using any kernel version that is strictly
> greater than 5.19.9 on it is causing the typing with the integrated
> keyboard to be extremely slow. "Slow" is subjective but let's say [...]"
> ```
>
> /me wonders how many machines out there show problems we never hear about
>
> Anyway:
>
>>>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
>>>> not CCed them in mails like this.
>>>>
>>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217394 :
>>>>
>>>>>    Matthew 2023-05-03 02:28:33 UTC
>>>>>
>>>>> Reverting the changes found in this patch fixes the issue:
>>>>>> https://lore.kernel.org/all/20220712020058.90374-1-gch981213@gmail.com/
>>>>> With that patch the AT Translated Set 2 Keyboard doesn't show up with the evtest and is not usable.
>>>>>
>>>>> Hardware:
>>>>>
>>>>> Aya Neo Air Plus
>>>>> AMD Ryzen 7 6800U
>>>> See the ticket for more details.
>>>>
>>>> BTW: there apparently is another IRQ override needed for a different
>>>> machine. See https://bugzilla.kernel.org/show_bug.cgi?id=216804#c8 for
>>>> details (ignore the comments before that, the quirk entry for that
>>>> machine was merged; comment 8 and all related to it really should have a
>>>> separate bug; that's also why this partly fall through the cracks here
>>>> :-/ ). The user is currently trying to create a patch.
>>>>
>>> Something I'm wondering about is if it's possible for i8042 to detect the
>>> polarity is incorrect when it probes and
>>> to try to correct it.
>>>
>>> If we could do that we can probably drop 9946e39fe8d0 ("ACPI: resource: skip
>>> IRQ override on AMD Zen platforms")
>>> to fix this issue along with all the other quirks that have collected over
>>> time on i8042 polarity issues.
>> 8042 is shared between multiple platforms and is quite fragile as it is.
>> If there are issues in AMD firmware and you know the polarity that is
>> needed for 8042 on these platforms you should add a proper fixup for
>> override. Maybe you should only skip override for IRQ 1?
> Stupid question from the peanut gallery: does anyone know what Windows
> is doing on those machines? I wonder if this is one of those situation
> where we just must follow suite to make things work reliably long term
> for users, even if that might mean 8042 needs to be modified.
>
> Or is the problem likely to go away with new hardware?
>
> Ciao, Thorsten
>
> P.S.: BTW:
>
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
I've got the same question.  This issue doesn't happen in AMD's
reference platform; it's not in AMD's firmware.
It seems to be happening in some OEM platforms only.

Dmitry,

Can you think about what a polarity detection scheme would look
like for i8042?  If it's put in the error path (device not responding to 
probe)
I would think it should be relatively low risk to otherwise working 
hardware.

