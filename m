Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5A6A550A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjB1JD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjB1JDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:03:55 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C8E392;
        Tue, 28 Feb 2023 01:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwPJ90W9+0d2WJyX1EnQeNce5g3Qd1HRXNOYROTr2ZkHmW5VWVFtQkJvDqx4KsTezuWksfpORLjz7/CW3dhngh0rUFxxuYJkbH1lIg4+AQBqKFAJJNks3DOh2Be81Jq+13B5B/k6e9OqIALbKX242xg8GSg1+wKVNELKRHXP7GrrCLU0rchxo87s7gFQLR3Ynj4jyjKEO4j2oR02Gs6z+2mnQ5eF51zO10C/31NdlMztP5Dgt8ZKs77AEFjdNNsmRViVjFRjItUpGXd/PRHULcfYOO9gPZ2NhUkjpgqPe+xaUy2XQhm3vUVTWRRWoa9AVsIDkOCoN5MHh/rP2jHE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iq+lNSstlgqM9eb7NWeprxwFMbke7ns+/NYUa2zXg8=;
 b=QLzLaPh4LTAd/JGGOwXnJ+ef0RQkiM5y7qNFWoSz+o9c3swG3fDqfWaDjcmYK8Z40oGpVFl4kJrXddI1HCMe83DCyilUpyr4UM86NtfjpYCLiXeWBuDjb7X5yWEsy3hpBsdbc4sO5kU5hQ1CyzTWYW1zImPcOw/UM2pYgR5Pek9JoBbIBOBbMAVf1kZOspoUkTsG33JbzoQTj/EOapTn5S1tbdg6N0ATbRqm14ppPBE7mVdfd793rfvCPaD1yOh8lfo4UABl9kVT7ngY5oRqxItgnjS4trcl6BjdGV+csiUvX04GqkupA+0L6iRwu0ghdWgkRwpR04GaPXdwMas7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iq+lNSstlgqM9eb7NWeprxwFMbke7ns+/NYUa2zXg8=;
 b=E6gQEgEA9x16Ei4CZq8q0hTrqY79igGEil8pBS+lanENK/RrEnW9CofqQqxvaHbgz1Wpg5ZgHU3PH18SBv4GVm48iVIMor/D+f1Z25ZaS//rmypOuI4zDHhIIZDTtyp+Mnl7Y5UjQS8sy5um9MVOXIxQyp7A7lB4Ei3Y7HX/c5IKzbvAtjHqx3SUu7FZc4x2SCBZzUAbboCfNgJCh9KB+EJPGbJLCfa83/yXqjk9mjq44mQQ/9tdBuykDEqdabLV5y1xmf5KF5bGCyURWQ69jK45GBRw33+oAKGDb5npC5x2HmZS+KKRcssTQYJqH9/ZT/khBIdNoxS2GkDQQcux3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB8512.eurprd04.prod.outlook.com (2603:10a6:102:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 09:03:25 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6134.029; Tue, 28 Feb 2023 09:03:25 +0000
Message-ID: <f2142d88-259f-302d-da61-e0fc39d1f041@suse.com>
Date:   Tue, 28 Feb 2023 10:03:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Wu <michael@allwinnertech.com>
Cc:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com> <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
 <MN0PR12MB6101B1BF9748F0602684FED5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <MN0PR12MB6101B1BF9748F0602684FED5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c638ed5-f18b-47c1-6bd5-08db196aa612
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLtFSatGfNipWt5Sn4U3QaJShL+XrrImP/d34Y6+QamHG2WmfDK94CYtWpnlurMNS0LF5jfo3SFG/CQhSFi8USmEyQoYgygcHmCmuHZix3hgmkCbmPcEDWboZpEu2LC/8n8mtuX3pvbUQPLqqGAivSDZFG90egUcZkF489qbSDEhvWHkfS8d2EspnZ7y7mSidxDCwh1JP1puQtGzcUd+36SZS5UZQG5XkXDz+QfteOX9NLWLFuXLkiN5hAlJZt73aGGXBmFloI91mGHuxXEXByitA6yI7DGUL8aBa6u4uns2/sODnXlw/1Qv3JmFujKxEBKZ3mk5TBANcdg4LiChyeOQBVbyi3ySpJnUuw+zLzzhN9mDj/0cFaaTFjfowvJqtRLYzxU7bN86HHZ2nYNP/P++SiSs8lF+3jLoRrxt8rKBCQl1iSbEYzLn3qJGUb0ZUXFtpqogEbawuDlo9rLLk2BsvxNNLAicUOc8ia1LuEAbfOPMQC/q9iUfC1r01BFz/nVTE+uWpbbeFpbXYosUZOQlJ2zbrJPiLEZ7tNfuUUX/QSmcT6M35zh0ykCcH6L4AGNKo/6OuBFMLlBktgvVrtAgPvZu2unNDqRg1G1MHIy1bgV7Zgk/xHA0t06oTRe9GmOZp7fD80dIwwhtE/kEUOv1/8f5ZMzNhARqR4Tr8mjkl8QkC5R9P1XYPKN5309SHuFFDuI71XPf6CjXh7Z8aVrVVlTovAjNHpKT9EBjHaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(38100700002)(31696002)(86362001)(36756003)(2906002)(41300700001)(5660300002)(4326008)(8676002)(66946007)(66476007)(66556008)(8936002)(2616005)(6506007)(53546011)(6512007)(186003)(83380400001)(110136005)(478600001)(316002)(54906003)(6666004)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk84cGFFazZCdlBBQWliRm95M3FuVWxDcEswcURFQVdMRlhUN2orTDVPeC9O?=
 =?utf-8?B?RkNuZktueTBlcURjWkt6cWJTVDZid09NYkNxNmJsNFdjaXlZazBGcnpTM2c4?=
 =?utf-8?B?c2lLRHQ3WGprUm5UNWZqbXhrWTJTR24zYXdwUWd1QWdCb0lGZ2k2N2ZzVkRE?=
 =?utf-8?B?WUJabU03WEJJQnllOTZLZDZsWlV6LzV3bWs2SmU4WkZPa1lhNVo5bndObXlU?=
 =?utf-8?B?QUUyblRWYXNlSit6cHl3WkpTbDBZcVF4bHprL3FkOUpXYmpUSkw1amx2ak1L?=
 =?utf-8?B?UVNoZTlxQUZlUUlxeXFmZDZsK1Bmc3ZNYno0RllqWWpkMGhMN0JNU3pMcG9j?=
 =?utf-8?B?UjNYTFpZNTA3aUFnL29XQXYxWkc5bnl6N0hOUkxWWjFUSjJCMFM3T1FRaTVn?=
 =?utf-8?B?Y3pwbFEyTnE0dnBraU5JMWxlRlIxYnk3UlM1MHE4ZGhJaW5FTEtlU0ZvUllM?=
 =?utf-8?B?ZkFuNlBqcC9ieTNtSGtZbWlEZnJGYU9xLzNVYmlSU2dDZ0poSWJNblk1cC91?=
 =?utf-8?B?eGRpNFdFeDNtclEyd0xrektoZkx3Sy8xUGQwNzJYMEFkdlBqZldXa3JzK2tl?=
 =?utf-8?B?U2piY0c5NzNnK1p4S0RDRzJxVmkvbEpDV1pjcU5QZ3RjRzZNdzN5cGlMQy9a?=
 =?utf-8?B?UmVUSTd1YW9XT2NEYWZuVkMya0FsNTVwcW4yMU9hYjRPaXNQcTNsMUJPQlh6?=
 =?utf-8?B?WVlaWXhuR0RsMUFiKzBNazJ3aDNIZjBFSWVYUWI1TWhLTDU0NnZyNVR2RFNj?=
 =?utf-8?B?eHRrVjZYNFIwQTVBQnZsRWZNZzc2YWlib2puc1ZFcDd2bXNDVmJCR212dU1U?=
 =?utf-8?B?MXF5Mjg0cnNMclh4UzVmOE1PTDFuR2M3MUtxZ3F3VG9kSWZLbDlEQ3grUWRx?=
 =?utf-8?B?S1VDT2FlRVc5RFlRaGVnRUVxdW5jT0VRNlRnbUhqY3NaZURaUkVBV0RWUlk2?=
 =?utf-8?B?WTFhWVl2SGpWczZmSTRkRFlNNGliNFVhUzJ6V0diVzZ3cEhnbTN4dWdNUnRj?=
 =?utf-8?B?M045K2hRWGNLVXA4UWVvK1YrZlUrTlhZdDdrbC9reXFkR0Fvb1IyQ25kb3dB?=
 =?utf-8?B?L1Zod0N0SUp6UWVMMysvQ2RzSGsvVXp5anZMemVNMktHMDdEMkRBY2JWQmpa?=
 =?utf-8?B?blhlRW9mQ05EQ0QxeG1rTkxubFNBSko2ZVkzSTdSenRpczZrVXBwS0RYQ0hn?=
 =?utf-8?B?MkZqbFl4MnZkOGVpVkRXVC9KWjVnOXFvN1hMQjVQS3pmUit3eHVsR0liWTRC?=
 =?utf-8?B?ZFIrM0xKcmxMSk9DVUlmZTd6QUp6V1NmTlZURkdOQnVENUFzSVN2V2xjbkFE?=
 =?utf-8?B?SzVIcXhKM0Z3UGw5bC9RU29GdDFRcS9zUytDQk4xNnUxRWthR28vK2Yzc0hS?=
 =?utf-8?B?dWxtQThOTVNybzRxbDkyWlhQV2txbVBGMU9kUndocm0ydFdnVGZMU1YyUDJh?=
 =?utf-8?B?WWxoOWFWZkR0RndKM1Q1anRTUlJBeWd5bUY4ZVhsVXI4aUNxV1JBTEp5UzlL?=
 =?utf-8?B?b1FzYjF5ZDBteW1pdEo5UVlrd2xPbFlNcjBRVE5yellOQTRCMWsyVnE3M1Qz?=
 =?utf-8?B?QXZjZDYxK2lIM054VzJTb1ZNL3VtaGttOXQydWR5SWxPcmYrb1lQN1FlcGhL?=
 =?utf-8?B?cDI0emZoa1pVN1FSUGdha0VGMjRZMVU4TFVIMk5sak1BN3JaVnJmVzVmSE9D?=
 =?utf-8?B?c2psdHN4UWg3R2tiYjYwQ2Q4cVM0Y3VCN05CbVNlMHZDTGdMbTBHTUJnTWJ4?=
 =?utf-8?B?VEVxd1BEMENGU3dMOEpQamgxeDAvejBhYnhQYXpmNkVQcjVycVYzcnlhbTdT?=
 =?utf-8?B?Y0FmZlpYL0p2aU44dGhEMnVxaGhPdmdCaWttVHQzVU54RmtwYTdUcUFHRjJo?=
 =?utf-8?B?Q0xEcVFJTDBCTU1pQWF0UWtqSGREU1lIKzlBV1B4K0FlYmZER1U0YW1UTUNN?=
 =?utf-8?B?aTcyaitlbjhCeDc4UTdocElDV2RiWlJBYlVudURqMlUwM2xvN3NPMzg2azhW?=
 =?utf-8?B?cXB5NkZpMG9lMjdhL2hEdFI1cExIbHdJRzBGR0YxYzFkeTFqejhJSlFjblFL?=
 =?utf-8?B?ZjkwRkZlMHdrc0dtSDVzU2lFRFdXTTdwTGZtL3VZTjVHN0xZUDlrM0RTVUpi?=
 =?utf-8?B?RHczckFxU00ycXExMUlFbkhlRFgvbVZ5U3E3VDJzQUNRSUtDbVFROHlUR1Ix?=
 =?utf-8?Q?16yLKoL9wdRabBstAh+G7xV1iP0N9ww/MKAxuL5QymRE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c638ed5-f18b-47c1-6bd5-08db196aa612
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:03:25.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8okfKpvL/IDphzU3ZvLMwNCXMcbk4kNYfm/C9fPx/D6sYnjm1JUgWAtg63ZRIUHjbIufWl9bmu8BfsyPyuXamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8512
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.23 20:41, Limonciello, Mario wrote:

Hi,

>> As a system wakeup source a mouse that generates events when
>> it is moved, however, would make the system unsuspendable, whenever
>> even
>> a bit of vibration is acting on the system.
>> And as S4 is used in many setups to prevent an uncontrolled shutdown
>> at low power, this must work.
> 
> At least in my version of the series, this is part of the reason that it was
> only intended to be used with s2idle.

Yes, that is sensible. If these patches are to be taken at all, that will
be a necessary condition to meet. But it is not sufficient.
  
> The kernel driver is well aware of what power state you're in the suspend
> callback (pm_suspend_target_state).
> 
> What about if we agreed to treat this one special by examining that?
> 
> If the sysfs is set to "enabled"

If user space needs to manipulate sysfs at all, we can have user space
tell kernel space exactly what to do. Hence I see no point in
conditional interpretations values in sysfs at that point.

We are discussing the kernel's default here.

> * During suspend if your target is s2idle -> program it
> * During suspend if your target is mem -> disable it
> * During suspend if your target is hibernate -> disable it

To my mind these defaults make sense.
However, do they make much more sense than what we are doing now?

> With that type of policy on how to handle the suspend call in place
> perhaps we could set it to enabled by default?

It pains me to say, but I am afraid in that regard the only
decision that will not cause ugly surprises is to follow Windows.
Yet, what is wrong about the current defaults?
  
> Turning on "autosuspend" for USB mice makes them behave pretty
> similarly to how they work when they're marked for remote wakeup.

Because it is exactly the same mechanism.
  
> On some mice the lasers turn off, and they only wakeup when you
> press a button or roll a wheel.

Yes. And _some_ is the exact problem. If we could tell, _how_ mice
react, this discussion were unnecessary.

	Regards
		Oliver
