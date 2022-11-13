Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A036270F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiKMQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiKMQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:44:55 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05611A0E;
        Sun, 13 Nov 2022 08:44:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6mRW3xP6ObF0pfz/lkVtlM8ADubTJl/1iDo0JL8vsA78DlbL8YrI8ufvN9c/WYiDmCmxwWf8HtEqVth1kayKYkIGE7A5bRqe4N7zLNRGYQMj6j4rUCOd58wovTJdPrccjATlxscEVxi+Dqb0s0zn/CDyTghqSmFOvt4RFnzj3Tj7vF3QerayKLWbxkWZRrj7k41DN65N8G5MXH5VL2x1ovPoNi2JoqAWr72HchtHw86xmXPC9LJxYUgfc4fqdEOHqF5UoAa+58ArnQVBajKqup2NBjIdPP4O9p9jVPlJqnURrTvEjSQuzoeNX5+Rkk4zhxtZ/oxHApx6zQ57dOYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t6A+V1SaCRYzHuHsseJxwS/drt7NzD/d5jtjVFwCnI=;
 b=BrlPGVhCs1Oa3HaC4lD+l2A11rB9p8NITEIXSBJAF8m4CrUbbuZOtwgI48J+Y7/SktQDttvej6Ki1tiVxY75Qj66gwCuBXwQ0d2MSlcnNokQkK+HbUOcW0JFOu8zGvkzxttHSkP0ZpMVU0Gjn2oTCqANj51HUDlZOWeUwMUWDCBj9tN5HP6jbC9v9wo2kMX9IciiDj9t3ZqVTLLlByMX/DjeVDG03GFbYBBQubaFRJri4xx187F0fTWLb0MFcZkzu/ubgQg+5TZN/RTc5BendiqwksfWckXGglutPJWxAddKep2C8IcVx/oxRU8oUqGZdBmaNRGsAN/xTxBIN+pnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t6A+V1SaCRYzHuHsseJxwS/drt7NzD/d5jtjVFwCnI=;
 b=CKCoXk/dW+VXM6ty3raoywkY1AX9kPaa/aeKP9OXqZYrsStBdGDCm52jxy2m3lXAUPz+wolnuxpqwGF4ymSsSBbiE2sbfbg9xniM3jZGvX1fwkyz3pftvvb/y9phLnheKunbjWUD7IuDwJNi7e+mTdUrT1lcixZUGyFV6zZP0Uy0RjZxHDyq6QpL6xLdQclwZ+LNtZ1C1xGjPTMaUoTZHOKf2cafLQNo0YhsxAknZoR/y8mhvATpV+0VN0Uz8fJJeQUdt6d5ebv5+YuaddOEnqN3CgOHGxdN/HW9TF20MPM1hG9uaNrtZppEKjF2s8T8I4uRbGAXF/MBwrJVjGVgpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS8PR04MB7750.eurprd04.prod.outlook.com
 (2603:10a6:20b:2aa::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 16:44:49 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5813.016; Sun, 13 Nov 2022
 16:44:49 +0000
Message-ID: <cb1946c8-1c06-37dc-a869-831722b7b1a6@suse.com>
Date:   Sun, 13 Nov 2022 17:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Prarit Bhargava <prarit@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
 <1b747e11-d358-52aa-0dfc-e795a8949106@suse.com>
 <3ca5f15d-7d14-2ab0-db1f-1c4384894e0d@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <3ca5f15d-7d14-2ab0-db1f-1c4384894e0d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3a476a-5fa8-477f-9b17-08dac5966150
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcpNou/6eDKuZcf3kh2T43rqRP5Nc/eSWPQiXfMY+z8a0gVCBYzDmNQ+Sybu5AsXZYSTfllI8T6PkItK2Ry+fdOzRZJNvvqh5jMbZoMib06M08vBuWgU4pVrps6CVCQjS2vXuwGbNZ6Hdk8+zFw1zVHUPoB+CTiUZayB7B8OI53UyAMHS9MLg5wRGGuiVia6sW1xOkE2AZUD6AZfoONgeqNryLRFCRFJr1tQysi2bHQEUZnMFH3wBOkg+ZMa7n50Owbu8FaXdD/EI5augf9wcf9rM4XVK3daY8vBvgLAciaRlBDjHS2sWoIDigvM0k3KnYtiyG+YcmT6TgT2/xLqPdMxs1oeWqV7CRsORIhqlnYp3gMZhAOegFSQDMh22gsBuHBVKaCODGsiZNrOnemM7KHhL6mXc1CnBC0W2Um0mxf//XgdjB3la0yZWrOxYI38y0L3zB9RuKAOrvFPn4qq8h1b69wWT5q/jQapnHW9gqRIxxXSJcuOJKsXaK1XnAq3r8n8NufbVqGzNMcOfWcKVmlGS+F8h4aMhb4GWVpd1SN/g+8DEXDoKGRcmyoF8a2ptJzqrqq3ewF70v64SN/HBPW071B9pI9b3vWaAS53PSRaPERBEkM+XQDMCYHPZ3eUpBkKY6fQ08GChcOGyxPftaiDVP3FQIPoClZsOku/zLfStq/dWIa1ZMD9SU0JLh/bv4Gv6BJRNGZKXxY//BKSu/Ast3XCqUcfjmfpF1MGKEdowOTD5IHF2yA0EHNrlkcNsdkOO49LZajIpTVAizTN4mEWvP6M8a1xdLR7VY3Uzew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39850400004)(346002)(136003)(451199015)(2906002)(31686004)(4326008)(66476007)(66946007)(8676002)(5660300002)(30864003)(53546011)(44832011)(55236004)(86362001)(41300700001)(31696002)(36756003)(8936002)(478600001)(316002)(26005)(38100700002)(110136005)(6486002)(66556008)(83380400001)(6506007)(2616005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpqMkZuREU2QUU3ZGlwT1IyQmxodHNSQktCOWFjSDEvVm9FYTNWclVpdk1E?=
 =?utf-8?B?NFg0UGE0dDdYTzVDemV4Znc1Z1ZlRHZTckMyQ3hGWHRrVEE5WmluL1o5Vml0?=
 =?utf-8?B?bFhCSS8zMmZQQ0xEZk9Qd2Z5VHFTZkgrdXkrclVwRW12YkRJS0RNSEpmTEVK?=
 =?utf-8?B?UWhuR0J0aFM1VEVFRnFoZXZpSWNrb2o0L2JyR2VnN0dpN05sMS9pcGd0RkFT?=
 =?utf-8?B?aVdEVVhmWVdpSlRBM1Z3OVYybEN5MGRIVHNLVzV1NFRpVmdpNi85S2NjMGYw?=
 =?utf-8?B?RGp4cUFkZ3VUblVOb3lzODFEQmgzM3hkdVBwSzFpQTdIVXo5cG1YbFJGSjVn?=
 =?utf-8?B?ZmlweDZac0ozcWtIakgxZ29qVzFXRkFFejlrL1JHLzlnYkhJY0U1K1Z5STBs?=
 =?utf-8?B?QzJXbzFEUVZZVUVDVEVObnVIQ0hvYlFCVUFrbEY0TjU5R3N3eW1iMEpQTnZU?=
 =?utf-8?B?Z2s5QTQydjU2dGgxQTU2YmtmSThnTUgvQ1JSQUFZbGxCZGhpL2RiYnRTSzlJ?=
 =?utf-8?B?VGtzYU4xdnQvaWIxdXEwYWlLcXZQelRWN29UYmZHWk9uUnNjSHdoNHJiNG94?=
 =?utf-8?B?SnRkT0R6Q1I2eEEra0VQaTJKVE9WWGtWcEVvc0l1UCtUby9xYWZ0TTBaZkJm?=
 =?utf-8?B?dlArWjdzeG1HZDlQQW5KeE16amU4amVaOXBzZXNRMDlKaFB2UTdZMXpHMkdz?=
 =?utf-8?B?WWY2SHZWMmNhTGtyNjBUYXF2TThVam5ncFFyZzUzUFQxTy91RXlLVXkwSUJz?=
 =?utf-8?B?eHhKRm5oRHBqeUl3cVIzOUw0TEJwdG1GTXdGYjFiYjJ2eGJVTnZXSVp2SEpK?=
 =?utf-8?B?OW1iQkRmcDg3NXhEaWYranhmekpnTHp4cTF2eWk2dXArc0M0VjRkU0c1eTU1?=
 =?utf-8?B?UFdndXZpb1cwcU1RVzZoVnVLMlIwR25mNUtibDdxb3JzVFByM0dSdm1FNXRY?=
 =?utf-8?B?ZjFDaStEa0ZVSk1Ld1RJelBZcXl1SnpsNU5Qamx4L08xcFkrSTEyRnV2amRT?=
 =?utf-8?B?cVpqcDJ2MncvS0ZuSk9MVjVQMCt1TEI4VXBxMHVCUFJ5N2RJcUdCVVBRVEQ0?=
 =?utf-8?B?dnE0eDNRemN4UUxlejJjNFJHRDM3dExtc2FnalFRRTBIZ1B0L1pnTFR4WGNh?=
 =?utf-8?B?T1A1ODZqN3p3SVRaNWt6VHg4WDM4TEhKVHovOGJJOE1YY2ZxdVV2UDViOHQ5?=
 =?utf-8?B?WHU3S1BGaEIxMjdZdUJzb25zdEdpQWFheDArU3dFdjU5dGxIZ2tveFVRT1Rl?=
 =?utf-8?B?WEZnTzUzQlBlZExYK2lPaVJkc1d4WmNxVkZrbzUzZ3ZIWHNaZ0pBMWpHd08x?=
 =?utf-8?B?bFNKQmYvUDgwQzRCZFR0cmVXb1gwUll6bzFsU2dWVzlqd2I3VFZpcVJJUThY?=
 =?utf-8?B?aEluQ1BPK0NQSTRxVkdqYVJUMitwVzZuU3VlcFBBRW5NRk1FYkczelZMWVBt?=
 =?utf-8?B?d1dFSDFEVVg2WC9NQVNSZlF1cUdiUndoVWQvaWpmem01V00rS3lJSkFMNThL?=
 =?utf-8?B?NHQ2dUk3OE1HOWZGM3h1aUJBdjhCem9xQkhpVFh0L003TGwyRFEyN0pyR1U0?=
 =?utf-8?B?WFJmRy9XTFNJKzBpRExQQjE2TGxLNWNCMjlZQkRraDIyaTZKb1gza1E0Umlv?=
 =?utf-8?B?ckNjaU9mdVY1UDFVTVVxNlB6dEtnZUhtQmVNanJqcXFzYzhyaDc3SXFRUFhi?=
 =?utf-8?B?ZFZlZGxHK2FZUkNjQ09zRWJsQVl3N3FITDZsNzRnVnNuZlB3clo5YTQ3Q1FM?=
 =?utf-8?B?TWt0aThSM2dmWUF0SFRaY2pvcGNiamxzOVRVdWZJRExwbDdOOEJSV0p3cXJs?=
 =?utf-8?B?a25zR0t6d2dkelVGZ1NnTzNXdTVJWkQrSHIyTGpJallTM1dOM2VRMmcyRVNt?=
 =?utf-8?B?eG12YmNJdUM1dkh4SVl4QzBPRmxweFVaaUVjQXRMNGpEQ05EOUJxWktQL1Mr?=
 =?utf-8?B?ZFpVZUIwM1pqcHd1ckZoZmRZSFFDdXBGdVBsYWFyaDUyc1BCVlFEanNZaytl?=
 =?utf-8?B?WjdOMjlzRGVCWnA1MUEydDJoVEdVdnl3TW9jN3lZbGhlbWM1SWpTVkhuTWdn?=
 =?utf-8?B?NGV1WHpWN1lVSFhPbkNGaGJwemtKeWtpNzloR21VZTUwZ2lVc0svUTBma1JR?=
 =?utf-8?Q?z8xGb8+Zn6ULEUfKzWiuYip6D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3a476a-5fa8-477f-9b17-08dac5966150
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 16:44:49.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2SaOk1O+xT9j9VZgBV62xcACUyal5r1camJMneSA7orl4SP/ASGigMMBnnHDt/kslP+mwORQ2HTQ80FSLpUeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 16:00, Prarit Bhargava wrote:
> On 10/24/22 08:37, Petr Pavlu wrote:
>> On 10/18/22 21:53, Prarit Bhargava wrote:
>>> Quoting from the original thread,
>>>
>>>>
>>>> Motivation for this patch is to fix an issue observed on larger machines with
>>>> many CPUs where it can take a significant amount of time during boot to run
>>>> systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
>>>> active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
>>>> attempt to load these modules too. The operation will eventually fail in the
>>>> init function of a respective module where it gets recognized that another
>>>> cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
>>>> is triggered for each CPU and so multiple loads of these modules will be
>>>> present. The current code then processes all such loads individually and
>>>> serializes them with the barrier in add_unformed_module().
>>>>
>>>
>>> The way to solve this is not in the module loading code, but in the udev
>>> code by adding a new event or in the userspace which handles the loading
>>> events.
>>>
>>> Option 1)
>>>
>>> Write/modify a udev rule to to use a flock userspace file lock to
>>> prevent repeated loading.  The problem with this is that it is still
>>> racy and still consumes CPU time repeated load the ELF header and,
>>> depending on the system (ie a large number of cpus) would still cause a
>>> boot delay.  This would be better than what we have and is worth looking
>>> at as a simple solution.  I'd like to see boot times with this change,
>>> and I'll try to come up with a measurement on a large CPU system.
>>
>> It is not immediately clear to me how this can be done as a udev rule. You
>> mention that you'll try to test this on a large CPU system. Does it mean that
>> you have a prototype implemented already? If yes, could you please share it?
>>
> 
> Hi Petr,
> 
> Sorry, I haven't had a chance to actually test this out but I see this 
> problem with the acpi_cpufreq and other multiple-cpu drivers which load 
> once per logical cpu.  I was thinking of adding a udev rule like:
> 
> ACTION!="add", GOTO="acpi_cpufreq_end"
> 
> # I may have to add CPU modaliases here to get this to work correctly
> ENV{MODALIAS}=="acpi:ACPI0007:", GOTO="acpi_cpufreq_start"
> 
> GOTO="acpi_cpufreq_start"
> GOTO="acpi_cpufreq_end"
> 
> LABEL="acpi_cpufreq_start"
> 
> ENV{DELAY_MODALIAS}="$env{MODALIAS}"
> ENV{MODALIAS}=""
> PROGRAM="/bin/sh -c flock -n /tmp/delay_acpi_cpufreq sleep 2'", 
> RESULT=="", RUN{builtin}+="kmod load $env{DELAY_MODALIAS}"
> 
> LABEL="acpi_cpufreq_end"

Thanks, that is an interesting idea. I think though the artificial delay that
it introduces would not be good (if I'm reading the snippet correctly).

>>> Option 2)
>>>
>>> Create a new udev action, "add_once" to indicate to userspace that the
>>> module only needs to be loaded one time, and to ignore further load
>>> requests.  This is a bit tricky as both kernel space and userspace would
>>> have be modified.  The udev rule would end up looking very similar to
>>> what we now.
>>>
>>> The benefit of option 2 is that driver writers themselves can choose
>>> which drivers should issue "add_once" instead of add.  Drivers that are
>>> known to run on all devices at once would call "add_once" to only issue
>>> a single load.
>>
>> On the device event side, I more wonder if it would be possible to avoid tying
>> up cpufreq and edac modules to individual CPU devices. Maybe their loading
>> could be attached to some platform device, even if it means introducing an
>> auxiliary device for this purpose? I need to look a bit more into this idea.
> 
> That's an interesting idea and something I had not considered.  Creating 
> a virtual device and loading against that device would be much better 
> (easier?) of a solution.

Made some progress on this.. Both acpi-cpufreq and pcc-cpufreq drivers have
their platform firmware interface defined by ACPI. Allowed performance states
and parameters must be same for each CPU. Instead of matching these drivers on
acpi:ACPI0007: or acpi:LNXCPU: (per-CPU devices), it is possible to check the
ACPI namespace early and create a virtual platform device for each of these
interfaces if it is available. My test patch is pasted at the end of the
email.

This looks to work well and has a benefit that no attempt is made to load
pcc-cpufreq on machines where PCC is not available, which should be most
systems. I think this change is useful independently of whether there will be
eventually any improvement on the udev or module loader side. My plan is to
send it for review to the cpufreq maintainers.

There still remains a problem though that a CPU is typically aliased by other
drivers too:

# modprobe --show-depends 'cpu:type:x86,ven0000fam0006mod0055:feature:,0000,0001,0002,0003,0004,0005,0006,0007,0008,0009,000B,000C,000D,000E,000F,0010,0011,0013,0015,0016,0017,0018,0019,001A,001B,001C,001D,001F,002B,0034,003A,003B,003D,0068,006A,006B,006C,006D,006F,0070,0072,0074,0075,0076,0078,0079,007C,0080,0081,0082,0083,0084,0085,0086,0087,0088,0089,008B,008C,008D,008E,008F,0091,0092,0093,0094,0095,0096,0097,0098,0099,009A,009B,009C,009D,009E,00C0,00C5,00C8,00E1,00E3,00E4,00E6,00E7,00EA,00F0,00F1,00F2,00F3,00F5,00F9,00FA,00FB,00FE,00FF,0100,0101,0102,0103,0104,0111,0120,0121,0123,0125,0126,0127,0128,0129,012A,012C,012D,012E,012F,0130,0131,0132,0133,0134,0137,0138,0139,013C,013E,013F,0140,0141,0142,0143,0160,0161,0162,0163,0164,0165,0171,01C0,01C1,01C2,01C4,01C5,01C6,0203,0204,020B,024A,025A,025B,025C,025D,025F'
insmod /lib/modules/6.1.0-rc3-default+/kernel/crypto/cryptd.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/crypto/crypto_simd.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/aesni-intel.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/sha512-ssse3.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/sha512-ssse3.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/sha512-ssse3.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/crypto/cryptd.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/ghash-clmulni-intel.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/crypto/gf128mul.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/crypto/polyval-generic.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/polyval-clmulni.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/crc32c-intel.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/crc32-pclmul.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/crypto/crct10dif-pclmul.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/virt/lib/irqbypass.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/kvm/kvm.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/arch/x86/kvm/kvm-intel.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/hwmon/coretemp.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/thermal/intel/intel_powerclamp.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/thermal/intel/x86_pkg_temp_thermal.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/nvdimm/libnvdimm.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/acpi/nfit/nfit.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/edac/skx_edac.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/platform/x86/intel/uncore-frequency/intel-uncore-frequency-common.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/platform/x86/intel/uncore-frequency/intel-uncore-frequency.ko 
insmod /lib/modules/6.1.0-rc3-default+/kernel/drivers/powercap/intel_rapl_common.ko

If any of these modules repeatedly fails to load then this will again delay
processing of 'udevadm trigger' during boot when a given system has many CPUs.

Cheers,
Petr


diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0002eecbf870..b6fd14b829be 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -57,6 +57,7 @@ acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
+acpi-$(CONFIG_X86)		+= acpi_cpufreq.o
 acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_X86)		+= x86/s2idle.o
diff --git a/drivers/acpi/acpi_cpufreq.c b/drivers/acpi/acpi_cpufreq.c
new file mode 100644
index 000000000000..3eebe58fbe9b
--- /dev/null
+++ b/drivers/acpi/acpi_cpufreq.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ACPI support for Processor Performance Control and Processor Clocking
+ * Control.
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#include "internal.h"
+
+static void cpufreq_add_device(struct acpi_device *adev, const char *name)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_resndata(
+		&adev->dev, name, PLATFORM_DEVID_NONE, NULL, 0, NULL, 0);
+	if (IS_ERR(pdev))
+		dev_err(&adev->dev, "%s platform device creation failed: %ld\n",
+			name, PTR_ERR(pdev));
+}
+
+static acpi_status
+acpi_pct_match(acpi_handle handle, u32 level, void *context,
+	       void **return_value)
+{
+	bool *pct = context;
+
+	/* Check if the first CPU has _PCT. The data must be same for all. */
+	*pct = acpi_has_method(handle, "_PCT");
+	return AE_CTRL_TERMINATE;
+}
+
+void __init acpi_cpufreq_init(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+	struct acpi_device *device;
+	bool pct = false;
+
+	status = acpi_get_handle(NULL, "\\_SB", &handle);
+	if (ACPI_FAILURE(status))
+		return;
+
+	device = acpi_fetch_acpi_dev(handle);
+	if (device == NULL)
+		return;
+
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+			    ACPI_UINT32_MAX, acpi_pct_match, NULL, &pct, NULL);
+	if (pct)
+		cpufreq_add_device(device, "acpi-cpufreq");
+
+	if (acpi_has_method(handle, "PCCH"))
+		cpufreq_add_device(device, "pcc-cpufreq");
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 219c02df9a08..ab02efeaa192 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -55,8 +55,10 @@ static inline void acpi_dock_add(struct acpi_device *adev) {}
 #endif
 #ifdef CONFIG_X86
 void acpi_cmos_rtc_init(void);
+void acpi_cpufreq_init(void);
 #else
 static inline void acpi_cmos_rtc_init(void) {}
+static inline void acpi_cpufreq_init(void) {}
 #endif
 int acpi_rev_override_setup(char *str);
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b47e93a24a9a..e51cf28fc629 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2614,6 +2614,7 @@ void __init acpi_scan_init(void)
 	if (!acpi_gbl_reduced_hardware)
 		acpi_bus_scan_fixed();
 
+	acpi_cpufreq_init();
 	acpi_turn_off_unused_power_resources();
 
 	acpi_scan_initialized = true;
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 1bb2b90ebb21..1273d42e9ca1 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1056,18 +1056,5 @@ MODULE_PARM_DESC(acpi_pstate_strict,
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
-static const struct x86_cpu_id __maybe_unused acpi_cpufreq_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
-
-static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
-
 MODULE_ALIAS("acpi");
+MODULE_ALIAS("platform:acpi-cpufreq");
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 9f3fc7a073d0..cc898bc3e156 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -616,12 +616,7 @@ static void __exit pcc_cpufreq_exit(void)
 	free_percpu(pcc_cpu_info);
 }
 
-static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
+MODULE_ALIAS("platform:pcc-cpufreq");
 
 MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
 MODULE_VERSION(PCC_VERSION);
