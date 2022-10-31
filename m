Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA2613F57
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJaU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJaUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:55:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3F1401D;
        Mon, 31 Oct 2022 13:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrZ8AgFhcrMc+YuwEGkfOv7QNulT+doC65pWl7z9uMEp8ZGPyqv50QxyCPxbdUhjt903EGRLdfSRB0RKBXRB1tfgpRWuxpAMFrfM5kV/MphGPuYSG45ucGSxXRy6H0gu6cTu8JGJoCncbQPoNi2kaodeB08IUvb+PF6u0+ypjSZXlEujr+kQjtu1QTl0dt1Hc7XPSv6zLx4fUJf4YYei253efe1tnf3f7DyY5jilODky4r1EkdLx/Rm2OqJHaRYHcK0uCbAxfdSm90oZBXQGmbclQdZ6ynlqUMFcaZVEmPMq4y0m1HEzLqRrJiG5b/1QSRB2gauQMOnjqOM70h5WvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQijhpd5usk8q1nNPbt/uk//OwujZi+aJ+bMvaazFZM=;
 b=MQusvMXoVqufT0y01lHWq2HcmnaHfD1ENGb8SeCpya8SqAfbSlzKDFV7eNTNirSe5zayQbSG7gyyqkAY09MCEbPi0PkSb5p/3x6soPX2JphojMbER7swWPNvR0jgF9hp5YvuHXHeMNMfJDLUjPmEzr85BvNzmBz7gX4+adLBGnhbSzQueixXXNhgg2CX9NfWlU0UNUlpRG8r5Fs44WV/Szhv4Y/pGnSljeD/BdXOLceEOuEgMeglTXg7Lmi1XDo3Khd2yRjNWZYLbb5lKV8q+7VlEvpnfCAcOYB8XElVD1OgEecBEd9tOp9+t72jwhQ5LOt/cMJJz1BlwaPrt0Lv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQijhpd5usk8q1nNPbt/uk//OwujZi+aJ+bMvaazFZM=;
 b=RgWdpUAI2s4vd5SD/3SlpZr+tYq6HPF//uwtklv1Ca44nFFzv0awRFN9USM4e5VIVGLaYMeeCyUjF3U6Dg3OxOaiNQiPtWNwvcmazIE8qAkA4CzepumN9amLUvkJxFgoWT2hvi4TeJMdO0tMYCgTScrC9wuJANNTPLua0oX9hno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 20:55:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Mon, 31 Oct 2022
 20:55:40 +0000
Message-ID: <29e7c8f5-0784-6501-e3fb-f2ab33d3f438@amd.com>
Date:   Mon, 31 Oct 2022 15:55:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     Rajat Jain <rajatja@google.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
 <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
 <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACK8Z6E7=xt118d47FTpmgKHgUBgH48FQzTi5iL90C3MjHb-3Q@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CACK8Z6E7=xt118d47FTpmgKHgUBgH48FQzTi5iL90C3MjHb-3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:610:50::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: c4548e1b-707f-478a-b22b-08dabb8244bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaXlpckSfiw4Da6o1ixelZyKTe5R8uUvBLwd/+mzQe0BQKpppvg+K3Gm/c2Xuuc20zgI0zx6BmJq0rxpQG8CJqpUO2gb6W7Qkxzi5Z7ufTfophqhDgekzURUzIjNnvBRtcWyt+DUCAxABZcNALKKL0XgmAuitUmQh9Q/BQtKMJxk0u0pNFs13Obu9ZwvY2YdU+F5Da0/wCLzW8inOSEAECpRplrQoFDZfuRyZPHSpHpwkI93yQZJYOOcjD7xC5CB6pv3LLknC3sB79k7ZH5hJfE9jqRxgmnJgDHanJpWTjTsBc5as/JyM10OjNM4WBscl6STGJhhsbogfJObmKhCrp1MeBdSGnEnOV5/g9QiwJ2nUNjk4oeJmpcWCrEKEUOmwcW/oZWyhUNPykw8Ftl4izB4strCVeDD1iaWNBUehqt5r4wmF4rjN7OhNjYfu/g5ySjo8JcuXBoeLMbSFaVvuHnCRd6Ko7EAwXbOQuEjAsjTFoDf1fZz3MrK6mNklPznjDbtEQAdFVNK7OxIeUKMsXiKNX6DGMISZa5/CXO20C5uObMCZTK0/TsvwbHpuqiD8s3aO+Z5UpXZ/IRBalKzkcLLK2lG6OU+AcPQGoX3JUgB8wcpef/fJlz/Tv3G0dx2kZYRcO1xNGL1z3C8zP8Fecv/0vMHI9bdE2sSj9d2G3LoSST3yD119uatf6QR3pvBY+dZezTPAUtoYYgykyPqEmnYsxirXLBwNUq45jAGgRj2ylzx7gN2F4RwpeKG5Exn89iasT/ot0qigpQeNiFTsL9tWd/zguJLJBIuXou1gA9WyetguuQFUP5G2CSZ+qJJkTjUcch3r8/VgJojHtwZUKH6JV+FSZQxRx49krOZgEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(8936002)(5660300002)(83380400001)(54906003)(966005)(6512007)(26005)(6486002)(2906002)(53546011)(6666004)(478600001)(7416002)(6506007)(186003)(31696002)(36756003)(86362001)(31686004)(2616005)(38100700002)(66946007)(66476007)(66556008)(6916009)(41300700001)(316002)(8676002)(4326008)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dJcXpwUW1OSzNDRzdSWTVwSlV3MFNZMTh0ME5CMUs1bXlpL0NyeHVmZDNn?=
 =?utf-8?B?cWZzMFVrdjBMeWF3OXl0M3dzdnFOd200bWlGS3dnakdqWVBNMW9kMTFYTkl2?=
 =?utf-8?B?RVViak9OM0VZeUk5ZllCVlZUS0xYVmttNmNSR0dBTGtIZlQrK2RLRlUvWnNF?=
 =?utf-8?B?R2NQeVlqWnEzMDJWUVZkUlN0MytHV1crQktUQ3licWpBZmtrOXFmVXdGYUFj?=
 =?utf-8?B?NjcrZk9HK0xoR2VFSlZqbzRJYStkaU1BWnVxeHJFUlFnR0Nqc3gwTGxEUzE4?=
 =?utf-8?B?MzFMRTlrQjA5YWs3SzBYR3AyOVFRRmplZC9OQUl5WldGVExIWXE2Qkx5MXls?=
 =?utf-8?B?TWtlcEhiZXdPQjl6dUxyV0NKdFRRME9OcWQ0MEMxK0xXT1lMR25XRWFiRjNO?=
 =?utf-8?B?TnRYYVZ1Z0RZbGlXeHAvRVMxQWpib3lwRzJVeVRXbFhXTEQwNnd3a1FCY3k0?=
 =?utf-8?B?MkpYV2lEVUpQdTNFQnQvelBZOXZ2TzZtNXNmZGVnMlhrSXJBQkl1Rjc1aFNz?=
 =?utf-8?B?aTZscTRSZ2RwME5tWllnSWFQTSt1RE9KcjFVWWZXczdySEJpd3FxUGF0Z2o4?=
 =?utf-8?B?Zlk5Qy8yV25ETnd4NWhYY21nMUpBMFRpNnIzdFBUWmMzQTA5MndTVjU0cnBT?=
 =?utf-8?B?RXNyRmlhVm52WnpMTUgwa2xFQ3pxTFBtZnY2UWhoK055NzRTOWd3YzYvQnVq?=
 =?utf-8?B?dXVSMW1panoyV0xFbEVhNEwxOEsyTGdSZ0hKWEJHOThRU2V3R0V0WVV2QmxZ?=
 =?utf-8?B?VDJtdU02RUx6TCtOcko3ajdQeGlsbE1rbkJvL0F5NnRLZmY1akFYWjRSOFhP?=
 =?utf-8?B?M05INnJyUVFQMmhRNmFzbVJwY1EwS01OUmJpckVTWXlNNk9sVDVBVG4vaVVk?=
 =?utf-8?B?Z1dKcFd5VUc5MDByNUdYbkN5WEYxYm5nVE9qd1RiQUNNZGwxR05DcjNRcHF5?=
 =?utf-8?B?eEI2UTlSbkNnSGs4MXJ6eENZRVVHNHRoQjFzQjFYTlhYb090YWlTa0l2YldO?=
 =?utf-8?B?VTZFMmpCLzB1enNXSWFEY1VLd0xzc3ByaEpwK0ZFcTJIWFhhSzZFdUoxUUx6?=
 =?utf-8?B?bmZUY25mU0tMNUJDaFovdEpRZGcvNlhBV0xKZUdaUXhqTmFUUkZBT2Y1UGFS?=
 =?utf-8?B?cnpDTzBuOS9HVldxc09GUjVmazEzcSt4aUNLV25XcDRHOXAzcEZ5aWdyTlNJ?=
 =?utf-8?B?S2hJSytvQ01FbDdPTmVDUlFucTlmc0crUW5NRXNZWUhqeDBPbWtwZjh1TnpG?=
 =?utf-8?B?R1A4bGJXOFVVMFFrQWs4dFBwTWJjUzB6WWtIRExPTDIvRVU3TDJDc1ZJZnZt?=
 =?utf-8?B?SmduM2xnTlA0TW5YM0QzK1JheG1ucHlCRDBoZk4zSFpXOTZOc0daTURrUnNu?=
 =?utf-8?B?UDRYVlJCOGJCcTNMYnpodVBLWmpoQTZwTk0rSFNWRGg3RE9UTTY5dUhsVGZt?=
 =?utf-8?B?eG9ENkNPVGZuMzNONUY5akxmMk02UVRMc3Vkd1dpazRUM2VoTHVkVDRiSStv?=
 =?utf-8?B?UEFHbkVIRU45Q2RDaEJzTmhUQ0lvSUhtbnU4ZjBFc3pNMGtKQ1A4OFhIakIz?=
 =?utf-8?B?QzZQQzZ6VnJPYlJXTy9nc0NhWlNiU21KWDBFMTRCdW5NbG54ajdxSU1DVEdl?=
 =?utf-8?B?ZDc3YnV3OXc4eXV5Q2FLS29DSmFJdjZTdXMvSVRlQldRbExJK2JBeEc0azhX?=
 =?utf-8?B?aTBHL0M3Z3Q3ektOTFh1c2IwZnpodlcxRXQxV1ZrS285V2Y1VlZPL21oZk41?=
 =?utf-8?B?eUtKTmg2SGNiS1h3VWltQUpRNFlmTG5YaVZBaXpPdFBJSDR6WjhlVkM4dU82?=
 =?utf-8?B?eStkcFFMZTczZytibFcvbmxmRnRNcTRhcXdsTWtONGVMbjJQWjFCMmNWTnBB?=
 =?utf-8?B?dW5PeHE5aWt5dGc2OTBHcGZBOUdyK0tZSW8yY2ZRK0RQdHhCNTFWOTNCNG9n?=
 =?utf-8?B?TjZXR2xQU1dqRDhSTHVYaGxGMDRTOEtxbjRqdTlUSUFuYUNIZEoyc3p3a1ph?=
 =?utf-8?B?MHZXd2d4Y0ZZRlVrTitHWHZBRWJlNksyb09lTUN1U3dSM2FPb2ZhWU8xb0xt?=
 =?utf-8?B?aGFzcUZ0R0FtdFlRYWxxNHYvUUcrZC9SZS94SDNqblUveHc5dzdGYzNlSlNi?=
 =?utf-8?Q?otN/M/RCkgN3dJCiGnInS76zP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4548e1b-707f-478a-b22b-08dabb8244bc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:55:40.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC+DQQSLKwl2yjwRKgjXjfE4obczHuMkq9fUL4KBzyglg8ZQJ9wS2Cu5G7KiiLCR+/5Q9Ab0iloWK3sq/gd73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2022 15:47, Rajat Jain wrote:
> Hello,
> 
> On Mon, Oct 31, 2022 at 12:39 PM Limonciello, Mario
> <Mario.Limonciello@amd.com <mailto:Mario.Limonciello@amd.com>> wrote:
>  >
>  > [Public]
>  >
>  > > -----Original Message-----
>  > > From: Sven van Ashbrook <svenva@chromium.org 
> <mailto:svenva@chromium.org>>
>  > > Sent: Friday, October 28, 2022 23:12
>  > > To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com 
> <mailto:irenic.rajneesh@gmail.com>>; Hans de Goede
>  > > <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
>  > > Cc: Limonciello, Mario <Mario.Limonciello@amd.com 
> <mailto:Mario.Limonciello@amd.com>>; LKML <linux-
>  > > kernel@vger.kernel.org <mailto:kernel@vger.kernel.org>>; S-k, 
> Shyam-sundar <Shyam-sundar.S-
>  > > k@amd.com <mailto:k@amd.com>>; rrangel@chromium.org 
> <mailto:rrangel@chromium.org>; platform-driver-
>  > > x86@vger.kernel.org <mailto:x86@vger.kernel.org>; Rajneesh Bhardwaj 
> <rajneesh.bhardwaj@intel.com <mailto:rajneesh.bhardwaj@intel.com>>;
>  > > Rafael J Wysocki <rjw@rjwysocki.net <mailto:rjw@rjwysocki.net>>; 
> Rajat Jain <rajatja@google.com <mailto:rajatja@google.com>>;
>  > > David E Box <david.e.box@intel.com <mailto:david.e.box@intel.com>>; 
> Mark Gross <markgross@kernel.org <mailto:markgross@kernel.org>>
>  > > Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix 
> failure
>  > > warn() to WARN()
>  > >
>  > > On Thu, Oct 27, 2022 at 12:02 PM Rajneesh Bhardwaj
>  > > <irenic.rajneesh@gmail.com <mailto:irenic.rajneesh@gmail.com>> wrote:
>  > > > I'd advise against this promotion based on my experience with 
> S0ix entry
>  > > failures.
>  > >
>  > > On Thu, Oct 27, 2022 at 11:40 AM Hans de Goede <hdegoede@redhat.com 
> <mailto:hdegoede@redhat.com>>
>  > > wrote:
>  > > > I'm not a fan of the change you are suggesting here.
>  > >
>  > > Thanks everyone for the feedback. Looks like there is consensus 
> that it's
>  > > not advisable to promote the warning. We will move forward with 
> changes to
>  > > our monitoring infrastructure instead.
>  >
>  > Did you see the idea proposed by David Box to introduce some 
> infrastructure in
>  > the kernel for this?
>  >
>  > Just thinking about it a little bit more, it could be a lot nicer to 
> have something like:
>  >
>  > /sys/power/suspend_stats/last_hw_deepest_state
>  >
>  > During the resume process drivers such as amd_pmc and intel_pmc_core 
> could
>  > read the appropriate values for the hardware and call a function that 
> would
>  > populate it with either a "0" or "1" or maybe even the amount of time 
> spent in
>  > that state.
>  >
>  > We could then retire the debugging messages from both drivers
> 
> I do not think we should retire the debug messages. The sysfs
> attribute could help us *trigger* a failure detection, but we would
> still need these debug logs to actually determine why exactly we did
> not go into the S0ix / deepest power state (And the debug messages
> print out the debug register bit fields that let us know that).
> 
> Thanks,
> 

I just spun together an RFC series for this idea and while doing it I 
had the same realization.  So I left the warning messages in place for 
both drivers.

You can take a look at the series here:

https://lore.kernel.org/platform-driver-x86/20221031204320.22464-1-mario.limonciello@amd.com/T/#m6c7db55c98b8a3ce8c48d451fc01c1d9b0df37fb

Thanks,



