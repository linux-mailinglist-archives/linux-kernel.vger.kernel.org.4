Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7E6142F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKAB6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKAB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:58:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79BCD6;
        Mon, 31 Oct 2022 18:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzLyKARa8I4m/+KXqm1jUF2V8tD5mMFn9W4LRbqIFSrBaSD4dHKgXeTwKe4gMeWN9KRp0ul2KENOJdtk7JVyPld2wwj46NAqqrvg+i5y/uINdsE0Me55/FjyIYMkVSGez52aersHaYmv/Q2l04d7ZRCcBg5aeU+mzin8AaV2j/aVDB8OAMCEYr/iQ7RFOlNT5nelNgMBmtStaBtgG6hQzOSQGFrslPX88RprYloIVUi4y67v4S/5SG0Yk/ZVH6mAOG/CzSkvHBGhsUsAXb+Lqo8xXT3i43KbsvLN12nNtzTqy+1X/vOD3iptSiO7vJDnXtGpy13Q2FGD2KkfTaypxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS5BYMz6nYGNLLKT4plkApeySoXK3XmRUeGaozOFktA=;
 b=X/FEn5C8bR99p+VnEa0VVbECB2p+TFHoBzxXTfsv6TJTFCSzREpDTYCTtIXSOfOAV0/jomdfu3Z00/2V6f0fcACQdScAtCMO7CMVTFn0ueyzQf7rZLimKSk8LP3FWgJGwgLIDAivuCV1AXaaXRzw7gtPaDnGgyjPjvUDAwevMcxpFqh9erK+8fKOcoHNI5oinvTvoLLriYVQ3CQGqBPeG6fP+TxI23Ci9GIe//W5pYGFTTDSRymaxELOqgSEQ3q2gy+IKSg5hq47NOxxD+gFIGl0jOzQRM1MSgZ/k+Qpqa3Vd4AQzVSaZZs8QM9Cf2LHleYsyq6AGLzvIuY7j7IQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS5BYMz6nYGNLLKT4plkApeySoXK3XmRUeGaozOFktA=;
 b=Q6931j84R7Y/Q4WLrnGdeLY1R81b0m0Xg4OBDfsv47YzZPlDheDOshuCnpbKYkHLEJCNxY4G3jRwgfZlcfrFbGVX0sJotJmyQ5JU5ofKzE2OM120OR/sOQ903zQJv7ku30HM7uabhmKOE2yu7fNVUOp+oXA0Y+3c7ERLHsNNE1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 01:58:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Tue, 1 Nov 2022
 01:58:31 +0000
Message-ID: <cb5ab68e-5034-d937-e28e-e838e50172a8@amd.com>
Date:   Mon, 31 Oct 2022 20:58:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Content-Language: en-US
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
 <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
 <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijSASfbfWQNarjGqj2UxQDOSdwM-qj5YA5A9ur=DNJf-g@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAG-rBijSASfbfWQNarjGqj2UxQDOSdwM-qj5YA5A9ur=DNJf-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 941d4a2a-f9dc-4d61-3ea0-08dabbac937a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNepRADZ5p4biUUw/WQ9cZYpBGuQywC/h3DjYzZ5I74Hf0BjFDzISNk6QaaG+J11qziaxJaPrzRUW7eCMPGKnrQAnAGUD3p4b5u5pcTUtFYIZWP8SzuoaWUm+oobTb6EUlDjY/RB8aHAc9pDmhOyGbIhd46QYIZ83Pi3LAbiCgQH0VDQUj89kDDnY5pzmkiT0vG2yBg3s7ouEGiuCuUTWuE03E4yAuff2ywvPeWkXqCfLtjAi4B1o/AVVNUHycD37BCB4gQsdotglEZwsb4Phd3AJ1pOFR4/fURNk6gyR8L39/PgjQjWpnA/TSwErqODoRiz/dYjsqg4xtG9mQo8fDAE2FhBrdr23DqTJIAGIcDo5QVcHxPDYTsgcpRgGyya5W6JpDy/qTGBX7IYIGS7/PPPA6UsF4h4rAHyVn0Gtn1rYbHqibuI9ALKGDtVFB6QjOZ/nie6nAXDBM4e9B7cJuFZPclzY9WGDVZRSeV0Jyv+gy46WUML05cJv0oi3jrFzHykju86GhWSprcFxb9dGmRg+KgwS1V84h3Pk6o3os2VaUGll7D6P71wVDQlq3X+ZBTuVwZ5+F+C9AQyfjBFDq+eOI0phZpZcSWYZCilFomMZTRDGrhIAJ4Do2Ohbdhos6NksiJbKv38LChUHDCO3yxZKidPQtxzOU/rZ+kDvEfUcSm5Uhce8wbQc4Z9HexvKykfZzYpkOR1h8fjs7MCs9whJGTC6GpnTfNcaCYWrXxed6PX8yRtFVdzVwO+6emTxp9lC6U9Bg3blxPcZNMqSQvpaEnyvqbL3eU8Yw3hzzSPLSjBjm+woWvzXOS8xp9RIuVQwxWTiilAVUxLrVXBTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(6512007)(6666004)(53546011)(2616005)(6506007)(83380400001)(478600001)(186003)(44832011)(2906002)(6916009)(6486002)(54906003)(66946007)(8936002)(7416002)(66556008)(5660300002)(66476007)(4326008)(8676002)(41300700001)(316002)(66899015)(86362001)(31696002)(36756003)(38100700002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDg0TFRTL3RxOXJack4yb09oL2sxYjJPT3ZoOVIrNHVGdEpPK2p6SkVhQStt?=
 =?utf-8?B?YWdyTDV6a0txNU1XWk9XckxOZDEzWXpHblExNDZmZnhQOWRGK0FIN2ZMVUR2?=
 =?utf-8?B?NFF6cHhoRWc4dnM5Wnh4dm4xN0JobThPVXZ5ZnpqbmFwM3NLSzZIRE44VzRH?=
 =?utf-8?B?MmROdm9aWCtjcXZPemw5b1IvZUF5bGVZSFFoQ1dBbytwNytUOGJ6MXJ3Y3ZQ?=
 =?utf-8?B?TUEweTlSRUJxRmlUTVJUcWlGOFA4YmhLS1Z5ODR1M0lPQ3IweHNUNGZJUlRi?=
 =?utf-8?B?ZlYzbUtINE16NTl4TlhDRHZ2dGpJODUwaUE1bVZhTUlXOTJZRnBkNFVvSEJq?=
 =?utf-8?B?dmhrTWo4QXcvbkJvZlp2UTVZV3BidmdVaWFCQnVILys4SFZHQXpFVVUzVTRj?=
 =?utf-8?B?bUNRNVJCUWNBc1hGL3dQZXZqaDRqMWQ4SEErb29LRTc3UEp2YmwySVlSMUdl?=
 =?utf-8?B?TkhvaHhrcktIVVcrajdDZ2c0NTF5dVNiNThGT2I3U01HZmJVRkJLR2pmSWlT?=
 =?utf-8?B?Q3F6TG1GNHU1cDlUK0lFSXpaRzVLV3pOM2FTUkUybXBnemdQYmJ1WlluRnpI?=
 =?utf-8?B?azVzTnhvZzh6N2t5MmdWY3A2REZFS1JncGtqZUZzU0QwclVUMTF6dyszS2VT?=
 =?utf-8?B?ZDhhNW90cmxqTXZERm9TNFk5SE9KUEJRbkVxMDdIWGNsRVU0Qi8ybzlWUVlF?=
 =?utf-8?B?aXBtTFhpa3hyWVkzMDZHazlQZXNQV1ArMnFRUzlDSXoySklwT2F1aHF4OUNG?=
 =?utf-8?B?RnRtRnpTaTdrRndKRlFGR3BnWlJxSFJQeUVzaHg0UjlMUndRNlhNWWRlMWZq?=
 =?utf-8?B?NExJUTNIanlTVHFnSldUSWJwSmd1TnR5NDNzMFNQM3hUZGROaG9lL0h2blJ2?=
 =?utf-8?B?Ky9FQm9qZHpVb0VBT3VYR1B0d3pTbUcrY3RPYmxkeGxXSC9neFMvU2NsZ0FQ?=
 =?utf-8?B?d2NwcklPNCs0N2gxNXQxR0txamY4UVFVRm93WHR0UzlPaHJ0b2JETU90bkZ2?=
 =?utf-8?B?Q1g2akRjUEFXYTRPcmUwSDZJNFZZc0NLa2lSRlRhazhkdGR2Z2ZkK25IcHI5?=
 =?utf-8?B?VWl6azh1VTVoLzVwODFWMWJQL1VkaDNwemRiSzJiZlVMWjcvRG1TVWFZbnY0?=
 =?utf-8?B?cHB5M1d2WkQxRTJRNmhXRzlaUnR4NzZrTnBDTmduQXJvTUg3b2RMNXJsTGNE?=
 =?utf-8?B?cUliZk42dmxOekZFdGVvU3YwRytxQnJqbW9uM20zS2xCTm9Fd0E1SUFSVUtr?=
 =?utf-8?B?amFVSnMvMDNLVzBJZkZpcGJHQXNCUXlFQS84WmxtdmY1cEZ0a1FPRXJ0akUx?=
 =?utf-8?B?WXF5M2JoaGJ1Tld5bFp0MjQ2NWVSUWUyaHVlNjRlMUFiT2FJOFlTeVFQZm1V?=
 =?utf-8?B?ZWc4a1VWT1Rpb2c0T01XckcxYlkydW03VWZjV2MySi9nLzMxUGdxT2pzTDF3?=
 =?utf-8?B?VU5YWERzRjVESEZOVVRMMGZVT1RPaXhiMkkrWnNxSnIvbFhIbHl4bzN6WjZO?=
 =?utf-8?B?WnJvWnZhaDZQU281S1JOcjQ3M1ROK2YrUkczS0xGNytTZW9BazVPQ0ZiaUow?=
 =?utf-8?B?ZmcvRTB1MkVQVHlDVTZuRGVBd2FLQ1VONE5KNGVNeGRCamdYemM3a0dIZWZ1?=
 =?utf-8?B?MVNOeDZ6bTIzQ3Z5SWQyY2JhaEp5UVN4MDRVcDIrc2FtanRmVVlUQ3c4aWxI?=
 =?utf-8?B?ODhqMlZxMTlKLzFybHpsMjJiVVptazArNW9TL0o5STc1YkVnYlE3d1g0cThC?=
 =?utf-8?B?bENsY2dPZDdmKzBuaDN0VkFkL29KUXZPL3l2ekF2SEpxdDZCbmpKalFPZ1or?=
 =?utf-8?B?MGlhZ01xSHAxQXFkY1Yvdzk1NFVmNjdZNGpSNVVnNW1aRDRkdHh1YnhGdTBL?=
 =?utf-8?B?dHhiUGFSU2M3NTlGMnJaNGFvWnpEMmswYU1nUnM5djdNTkY5OXpRblNOT2Rh?=
 =?utf-8?B?VW5IQjdRekI5RzNaeFdNa29qaG0xRUhZSEVzMElVT3ZJeHo4MGRuM0ZsWFpN?=
 =?utf-8?B?MkVmTFRVaDh6N3pSaVB5dldmbG5ucGcwYjBIVFF1WkVEVEhyWU5WeWtOaTI2?=
 =?utf-8?B?c0o5RStGdlVCVWtNcXE5elZ2WWpFdUd5QXZKWUhBWDNYZGM2WUtjY3hmeUsv?=
 =?utf-8?B?TFZrU2F4M3g3M1dtcUlhQlVleXBDVGR4YUpBU1JzMy9EaEhWL0U5ZDFXa2hr?=
 =?utf-8?Q?OjmEOaCb8P2ACT3JIU1ycwv1Zj74c45g/bVEln6wWzZs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941d4a2a-f9dc-4d61-3ea0-08dabbac937a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 01:58:31.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QugXSU+Mn1BhdbH30+hMoCp56mCR5N4o9PlPB5dwak/igdnH9Ng4clFpMA0fya6mfTZy848ZuazDpwrslvjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 20:38, Sven van Ashbrook wrote:
> On Mon, Oct 31, 2022 at 3:39 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
>>
>> Just thinking about it a little bit more, it could be a lot nicer to have something like:
>>
>> /sys/power/suspend_stats/last_hw_deepest_state
> 
> While I agree that reporting through a framework is generally better
> than getting infrastructure to grep for specific strings, I believe
> that a simple sysfs file is probably too simplistic.
> 
> 1. We need more sophisticated reporting than just last_hw_deepest_state:
> 
> - sometimes the system enters the deep state we want, yet after a
> while moves back up and gets "stuck" in an intermediate state (below
> S0). Or, the system enters the deep state we want, but moves back to
> S0 after a time without apparent reason. These platform-dependent
> failures are not so easily describable in a generic framework.

I actually thought that by putting the duration of time put in 
last_hw_deepest_state you'll be able to catch this by comparing the 
duration of the suspend to the duration of last_hw_deepest_state.

If you're below some threshold of percent for suspends that are at least 
some other threshold long you can trigger the failure.

This then lets you tune your framework to find the right place for those
thresholds too without needing to change the kernel.

> 
> - ChromeOS in particular has multiple independent S0ix / S3 / s2idle
> failure report sources. We have the kernel warning above; also our
> Embedded Controller monitors suspend failure cases which the simple
> kernel warning cannot catch, reported through a separate WARN_ONCE().
>  > 2. A simple sysfs file will need to be polled by the infrastructure
> after every suspend; it would be preferable to have some signal or
> callback which the infrastructure could register itself with.

The interface to trigger a suspend is writing a value into 
/sys/power/state.  You'll get a return code from this, but this return 
code does not represent whether you got to the deepest state, just 
whether the suspend succeeded or not.

So what would an ideal interface that sends a signal that the last 
"successful" suspend didn't get to the deepest state look like to you?

> 
> The generic infrastructure to support this sounds like quite a bit of
> work, and for what gain? Compared to simply matching a log string and
> sending the whole dmesg if there's a match.

I would like to think it's cheaper to read the sysfs file, do a local 
comparison on HW deepest time to the suspend time and then only send the 
the dmesg up for further analysis.

> 
> Is the light worth the candle?

I wrote an RFC that I sent out for it with my ideas at least.

