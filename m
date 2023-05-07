Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB12C6F987B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEGMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 08:41:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790012491;
        Sun,  7 May 2023 05:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaoAFui6ydJcPCzIPxAk5xojMr6V8kAWgY13B3hk1jdawVjvzO44zaq2zwWKxpoVTTDz4xIUkWbTUkvT8NO0fX4wA1NdyI9nGi+xNQYcS36rx8DfKVdkvQvAtEcfbtWQkZehAu+oXxMdWApE41o7PQiwDBGW4VktRFUZlWLg8kSrHpW1vIK5GtA5pDdNCkvJd30DqxU52LglrIAitNJcGgM5OBuwbNt4a5s7ySCR2kz1YcjjF1zSCi9GbpBz6C8XeG8jRXGv15niGC95UFloZai72DBaF33MPKhgYbFpxRkyNqX+DGDmBmSr1IyBC1jAb0PuEI78z/pgHzbE/I2Faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7j5ChS8dfhn+HBk8OfgoqM8fviCvtp/JYWijsUuBvQ=;
 b=GPDUVWjwoAMRoKFmCfQX9kHmetGkpy59qz1ED6L8hL+wv1xCIREvIgISE4vDCjmiwzT3ejxl/qO3FxiKVClk/qyORLTy7bFP/ZHp1TRWm7Ei6+QWy3aN/QW6e/0/auTE8Gyj4YOFIdPsi0kyAQKaYBwJW2Dwc+oQX9YNjPguAEfvvj5+X5ccne/VoMUfdjro9MUY+XCil7jRz/g4PWdSGSL5L4jJbmznL8bGecyX8/I7Q9+GHXVZYbvk17Pq8BkeS+u/KMJjXQzKI4mLuQX8JtlhdRGPVN+rF/wqfQcT2gMuuLIcZCp651qmMJSNX4ZrFki1uinYvfGYJd96yMwAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7j5ChS8dfhn+HBk8OfgoqM8fviCvtp/JYWijsUuBvQ=;
 b=My0jeQvvPd/u2M+xz9WogvcKrh5hWGY+MSQBxYf7G3eRNHttRwUxe1R5akSyJyBtxsS7hTb6b0/oconR/d8xCJB+KRH6qxOZJISXL3SA4UuKk4qCzwY161AXGr/bXyJMW0kRt2ymQR+ty2ypKhlplvqSsvWqFTzZJT6FMC5WFEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.30; Sun, 7 May 2023 12:41:34 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6363.031; Sun, 7 May 2023
 12:41:34 +0000
Message-ID: <1b3e5df0-6190-e560-72c8-f600f715f89e@amd.com>
Date:   Sun, 7 May 2023 07:41:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217394 - IRQ override skipping breaks the Aya
 Neo Air Plus 6800U keyboard buttons
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>,
        "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-input@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info>
 <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
 <CAJsYDVKY0V4V5fCseGJ7SPW6+-4r7d04RTgkF82VgYcNLk5DtQ@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJsYDVKY0V4V5fCseGJ7SPW6+-4r7d04RTgkF82VgYcNLk5DtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:4:ad::17) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd78f58-ef6e-48e0-85a5-08db4ef8643e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hRUGz1injtMOQto8f89C2BWRoKXci8WHssybcepqmOIkvvIoXbeusQsmfj8fmO3fxjG4TtojAQKU+cGCQ2evrtpo4+MxwA0MEzRFGQn8A7csVJlyqjTXw32dVM2cb1Zf3+6pMZ+gxGMhQLI62LmjFOv3jN2KhcRq/RAPDHImsKhqKJbtU6pu23Mwg7lg/bIXZRVvG89R/j9msFSSXpjii2xZQ6CRZe5LNRTG4ZOyDudDe0XFxA6tPVIqe7a0koFoFASW4cVQ3WqgjWwfZEifaIuLmAhYwW4V9SmsqZykngNYRlxrCmCJTib1PahnvM1mPre+Q4Zmsckd5ufcXCF9atKMlW3+8ImhdsZuQgg+Yr2/qhzqbgoS3pgjr3BF4xqiTblBpZhR6NgFUFqYd6vAidmgckztdqpP0V52fP0lMYJUKWexxGX+4TnV9AoUiNiVafBCvMgKrQn6LexS0Y/AGXZcHWDxu/lm3SqGlwD6hhAdgUBBUn4UoiNYHj8o51YrOs+6C1IZATlp/uTac90v0huzGgYHU7oxo+XNW9WO4yYLFSYb0WBWPe24rqGloMR5g2irEASabYecN058L8+NZM2V3JFqmecJwVyhP25jdCeLUuObUlV9NDMfyp0fvfQpSUYuQAwEA0t3S8DjdMyd6XZz1SNG4j6a5dL19w6Qgzqw4gYnTfa0W6ONlq9kzDC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(31686004)(966005)(66946007)(66556008)(66476007)(6636002)(4326008)(478600001)(6486002)(316002)(54906003)(110136005)(31696002)(86362001)(36756003)(83380400001)(2616005)(53546011)(6506007)(6512007)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktCMExKc0NKNUp2SzR4MVl3RFRBYlR4REV2VVZUbzZITnJTS0labGQ5WC9K?=
 =?utf-8?B?Y0JsSWVVV2FzL3dHNFhwM0ZEbmkrMDFOS012dzJDMjhRd2xINmZ0ckFJWHFl?=
 =?utf-8?B?UGNnR0NUb2hhTFhXMEk3ZGZkczFOSWxDaXZ4WHg5cEl3aCt3Nk5mTE05dUFM?=
 =?utf-8?B?OVpUNWQ1ZmdLNXZEUy9vd0FwWVNOWGpNYVVUSWVsM3pHVkZrb01iWno5Qlhj?=
 =?utf-8?B?TmxLSHZDQW1OTDZPaDlyMkFpV3hXbGFZMUhkT1kraDNEa29SSktiUS8xc3I1?=
 =?utf-8?B?OTc3bGdyckxEUlFUQm5nbG1sekFFKzNEVzhLQTN0bkJ4MUFLRitaVGtXTTFT?=
 =?utf-8?B?bXBVMnd5SERhdnovbzlQakFrdG1YZjJKdDV2MDNYTkJKNWg0QXNwbmhGTHRO?=
 =?utf-8?B?anBkR3F5NlRkQ0lnTGxnYkNKb1RuSzlKamx6TWg3KzEvQVExaU0rOU4wMEdR?=
 =?utf-8?B?SVNkcWJMQ3pFTGdZR2Nqcy9CQ2VjTk14WEZmTUs4UkdjVkV5MFc4TG5JcHRj?=
 =?utf-8?B?QTA0RndhT0E4b0krdW1GMCtabEdGYWxhdG9JNkF4T1JnNXYyTWFVU0tDd1Zp?=
 =?utf-8?B?aEMxZU5ja3NmVytIdGw2bWxzMGM4ZnFHZDJvY1U1Tys2SXFoZjFFZmNsQWM5?=
 =?utf-8?B?ZXo2SjZseTFSWEsxazJWaFVtYkhjVFJxemsxMWhYMVZneHBKeTNBY2NjZi9t?=
 =?utf-8?B?M2s1ZUUrS1Y0OUxRbWh0UDVITXNybXZWZVZCeVRJSmc2Znc1eUZiYmdQbDky?=
 =?utf-8?B?b3E3ejBKb2FiUHJCVTR3VU5rcjBWWWVFdnBMTVZiRGNOdGpsVXRWWnZ2SklJ?=
 =?utf-8?B?bGJndTducVlEcG1MUDhPaFVWeSt4Qm5PU3dtdnlnZUN6U2RMa0syQ1Fvc3lU?=
 =?utf-8?B?TlduOHFESWRiUHo2dnNCSUpkOTZHMk0xR21QS1RrRkUvbSt0bU00eDhWdngz?=
 =?utf-8?B?cklFVkVwRURNMDJwVi9UMmdIenNRMTVnK3RoaEdycFltM0FaTGEzU2Y4amVK?=
 =?utf-8?B?N29YdVdLT3dwekd2Y0YvL0kwT3NUQ004K05KMDVFMW91dGp3ODBFdXpPK0xG?=
 =?utf-8?B?eGFIMHROTFVGS2dCSkR5SklDVEVIdDBtUzdhR0VCNStkZ0ZUc0d1cDR6TTRB?=
 =?utf-8?B?RGlPZGtRNW5keUtMRjV6MGpxZkFvY1B1cDBnUHpWMDhmVW5mWnMxc2Q3SERE?=
 =?utf-8?B?WmZzczlNdVdUb3UrdDgyRFhOSUo2ZTh2YWkxQ1Q4YVpralpnS1I0QjVzZ0gy?=
 =?utf-8?B?Y0RIeDcxVmo5M0dZNDZmWlZybDgzQWczMGEyZXZ5cFp1a012OWI1a2xaM2hR?=
 =?utf-8?B?NjlNa2FOTWcvaWJOeGhTbmZwbjk3TU81R0ErZjdEaHR1b3g4ZTFGSnlBeHpX?=
 =?utf-8?B?L0dqTWVGaTdFSHRJN1A4L3cxVElHaVE0U1IxalVjZ2drZUVxMi90VW5teVQy?=
 =?utf-8?B?YTFNMk5ncEt4RjYxaWRNb1lsY2FrUlhlUk5HZXFrODZBMWZDQ0xLanFGQ0Js?=
 =?utf-8?B?REVxY3Q5ZW85OFBuK3l5b1M1bWNBRGNxc3JQRjJYcjZVYnJtczh3RVNPaHRw?=
 =?utf-8?B?TXBYNTVhb3ZRSzgvTUFIN05uN24zdkRyd2cvMk9EeS94emRqMnVUTTVUVUtj?=
 =?utf-8?B?MzYzVXVodUorM3E3VDA3MUFXb0dxRkhIbnJBMDV3L1dzSUg0OWFqemQyUEpw?=
 =?utf-8?B?MFY2bkJERy91VWlUajk0Z0xORGpOTy8wQW5kTGNZNmgyaldjckxySUptRlFY?=
 =?utf-8?B?TXFYWGFaeUVPWitJN2JOMS9lVXBLaUo2OHg2MDl2ZHlEekFGM2JqdjkvZDJC?=
 =?utf-8?B?VHVxOU9FTk4zZEwwUlQyTmtiVC9BUmJkZm1pQzl1Z25oUXNlam9YOEVJME9N?=
 =?utf-8?B?NEpSUEgveEYrVEpiM1dGdGxPdG1kbWQ3aXM5Q1VZVm9XMCtXQWZYVUdpUkxl?=
 =?utf-8?B?MFVBOSt4OHdYN2ZGbW1sTlpPdU1BNDZkMU1UdE1VS2J0Zlg3VmpGZDl3V29Y?=
 =?utf-8?B?RXR6MjltM2hiYSsvRjlMdVVJcHNOTm1ab1A2MjlPMkdtSnc4ZS9OdXA2RDFR?=
 =?utf-8?B?eVQrTVpJenpjNCtCU0ZBb2V3R1FISmF2SjhBOS9vRmUzclUxRXlnSVNuaHpw?=
 =?utf-8?B?UkM3TnRjSkdIMUZGWnRlYllPTlUrZ29uZSs3N29sd0lXd09abUQ5d25CK1RR?=
 =?utf-8?Q?b1YhZj8ZXGWuDgITYLw4gpa1pvKqYVL/JPvu4Xgz84C4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd78f58-ef6e-48e0-85a5-08db4ef8643e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2023 12:41:34.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hGhrHqmTErkMqTSEzG57NddxVf6WEMKws2uujbJ9i6TGXBSSDIarCaXgXd+iSgY4BDVt0kb/QiMATXXdH1GAA==
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


On 5/6/23 03:25, Chuanhong Guo wrote:
> Hi Mario!
>
> On Thu, May 4, 2023 at 12:11 AM Limonciello, Mario <mlimonci@amd.com> wrote:
>> +linux-input
>>
>> On 5/3/2023 7:58 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>> kernel developers don't keep an eye on it, I decided to forward it by mail.
>>>
>>> Chuanhong Guo, apparently it's cause by a change of yours.
>>>
>>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
>>> not CCed them in mails like this.
>>>
>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217394 :
>>>
>>>>    Matthew 2023-05-03 02:28:33 UTC
>>>>
>>>> Reverting the changes found in this patch fixes the issue:
>>>>> https://lore.kernel.org/all/20220712020058.90374-1-gch981213@gmail.com/
>>>> With that patch the AT Translated Set 2 Keyboard doesn't show up with the evtest and is not usable.
>>>>
>>>> Hardware:
>>>>
>>>> Aya Neo Air Plus
>>>> AMD Ryzen 7 6800U
>>> See the ticket for more details.
>>>
>>> BTW: there apparently is another IRQ override needed for a different
>>> machine. See https://bugzilla.kernel.org/show_bug.cgi?id=216804#c8 for
>>> details (ignore the comments before that, the quirk entry for that
>>> machine was merged; comment 8 and all related to it really should have a
>>> separate bug; that's also why this partly fall through the cracks here
>>> :-/ ). The user is currently trying to create a patch.
>>>
>> Something I'm wondering about is if it's possible for i8042 to detect
>> the polarity is incorrect when it probes and
>> to try to correct it.
>>
>> If we could do that we can probably drop 9946e39fe8d0 ("ACPI: resource:
>> skip IRQ override on AMD Zen platforms")
>> to fix this issue along with all the other quirks that have collected
>> over time on i8042 polarity issues.
>>
> I don't really understand why there are more and more new laptops
> appearing with broken IRQ settings in ACPI, especially considering
> the fact that some of these laptops were released after the original
> problem was already identified almost a year ago.
> What exactly was the solution when AMD internally discovered this IRQ
> mismatch problem? Did you guys changed the emulated IRQ polarity
> without updating the ACPI table with the corresponding polarity
> description in your reference design?
>
In the reference design the tables are updated to be accurate and
reflect the appropriate polarity.  It seems that the vendors must be
changing this and it not breaking Windows for some reason.
