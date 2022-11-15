Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68F62A164
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKOSep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKOSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:34:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A721CD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYhBDY4HegLxsp62qLvXhJD84qsyQw0M6qayAsmL2a4s2yUlAsVoE1A+KYH/ObQmqaShWn4aNu+bZg1PKGUDyJhdF5CTpOSbTuqnrNJkC50f1IUrfu4oaH8i42YQYrmKSgTYgqx1K3IOxwww/ekX2mKrRM/hJe7UlY+HHQ82M0lZZ9xMg6wHuyjlfEhlVZ43JkQRdLfzLKqTSzOveuqrQajYXb992wcF4hOUG5H7XGac/lge8YRKD0Kc0or2qXt3Gax6cq05jNp0YFnwQcNjJiNU87dLQVTdyOnmJkylvxfdChlCYJaohN1ME4V6KtjNR4OcoKHBH+hnx8MvXyf0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/jqCvSbZZvttovjfFVnFzhZ/l3olmDXcBZ902xfTmY=;
 b=WLuKB+g9wRKPnkbunpEZrsuJvfXPbw2aM3HqYKGSpHOYm6i1h9FcIA+nPCBrjZnQ5nYmPB1o5VqjUlVgiIWXCHROJMTqyu+dvRbOTww1HOWEecZ9JDSTFWJ1JiR4DXBasz4xh/xdSDc1jd1Pb2PU3C7sihdhd7+hO59LJPbD/GSHP/m+pOtN2pwWbBEXKML2jqY21FzJqdg5Z0xb+1dDbUVVPxgT4CmmJiXo2fl/KE7UPCVvf4oTz2TqndgZoUcbviLENYG7M3DNcUU5HC6gRjy24WowEvu0AtZfPzZcNBTRhYASXJNIY7Tza+BnV9yclud0+7WjZoyNT9YpeTBMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/jqCvSbZZvttovjfFVnFzhZ/l3olmDXcBZ902xfTmY=;
 b=ZTU1xKdYUR27TVn7Pu3nTeDdpvacKrwpsrDvpaYLmQHrH39ygbDn0cuGomehY/cergVsIxBXLyWyBx1CvtYZVic1CLngYd2KxXeXIdprBxWXmk7OyrSAc9axfkI+xR1x5hejHD73G7oqaQXCBbMukEoAjYmz4UMFsvVPcT2hixk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:34:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 18:34:38 +0000
Message-ID: <cbcb6f35-e5d7-c1c9-4db9-fe5cc4de579a@amd.com>
Date:   Tue, 15 Nov 2022 12:34:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20221114233441.3895891-1-seanjc@google.com>
 <5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com>
 <Y3PEv9MmQ+y91Ir+@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Y3PEv9MmQ+y91Ir+@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:610:51::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7ba6e1-38ee-4017-c068-08dac7380d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVyhmZyTCHWNS7IDoyvV8lhmxKG2aoGEvRDmnYjt9Ckh27r2FzyXjo+qsPnFT8XbSEQ3y3zABXM2/ukQPhpiM+IjFSDs4D4qPpjuWU/sdV++6DVZfTNgUcLkLCNcCpHo3M0oETj5fT2np1g5F3sbMcacTXMOUs0JmHO88QuILTEstYhtuyPrs+2uaUeUq4e0rTWWyksu/oO804BtXS/n1wMg17tkma475rKFIO5lZHyXYPaY3RFDm0Y6h74YwOQw9+M1MCuKiz0dbPmRXFjjggRNRgpSQI2xelqQ7wOHZ3nFGm/Du5Saoz2XyIykdSSPRvjbh6GTVIYar22b+4IV90tv4bg9dAm1YTpQnjr1ZdYyHw7PylIvDt9ibHozvO78o4pH/U5xZ4onvkRjNC7gdCFILQUzvrgtmGQpDkbq60Ji9bDa9UkjYvaIoBC9zgwnrSV7ZhdiUz50+sToC148Tuut4ejf3Drkr10Wff5oXo0u3KEp5huHcaaC4HO3FSsuwNMv/lDInKAtdFl7Zms07/1ySQg4dLOFOj/0Sc64uZS+E1Y0pAPrqLjoQbRtGtmW/4MncWW+R4wcFkT8q5huVfg28XPUSlaXmK4V2rdEDKY6YPKFZ3Nnrp508rYr+JxE2COkv5Xl81wttJxExJB8249zHW2cT3b23DeQajR3GgPa+c7AR/0X5WhGrhMYkaBN+ZI7PNUrXQ2lHwC8rPleR4/RTC1XS4j6Z26ZqxOVwNQtIO2lyo73SWeks45rGMQWKyM5OUh/rzr39CSqe7Y9/KQ1Xep4ovPSVLHjuZM3MVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(31686004)(2906002)(8936002)(41300700001)(2616005)(6512007)(186003)(7416002)(5660300002)(31696002)(36756003)(86362001)(66476007)(8676002)(4326008)(110136005)(54906003)(66946007)(316002)(66556008)(38100700002)(26005)(83380400001)(478600001)(6506007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlY1M0ZmbHBCdVczbHl6eWRKdGZxZHZMOFhXRytyNTFxa0RiTnl1Q2F3WXlX?=
 =?utf-8?B?aVhyUFdyL3hFalp2Mk1ZRDNFcXZyMDU2RjN3ZGJENzZQQjB0MDFFVjVTaGhM?=
 =?utf-8?B?enQyektMcEN0OWdVNWdKdnRMdlRMS1NDR2xrUWthTkpXNTVDZ1B0akphbXh1?=
 =?utf-8?B?eUFSRkVvMHdQR2RnWllrcnFwM2JKVlhPZGxPT2VQcE1pZ0dGZDhrMmxZWE9p?=
 =?utf-8?B?SUNkT3djemlOOVh4ZGdtRHYrN0VxR08yMUdSSE1sNEo4eWNYeFJXYlBQbm1x?=
 =?utf-8?B?RHhUVUxQbnhpanRJQlk4WFNuSzVJSGt1bGpjK1IxZ3VNUnp5bW9EMlBobUdU?=
 =?utf-8?B?dnU5RE12MWRIM2N2SEk3TFZNUXRKMUdEeEtoTGM4Q2hzZVlveER1OUZvYVdT?=
 =?utf-8?B?OUhTWUFremxPT2xCWS93dXJUSm1IM3djVmtPR0tRdWgxa2dZVjJINjU2b3ZH?=
 =?utf-8?B?aWpweG0yZUdITlhiRmJuamNDc21mbnN6ZXdEU3BGSHdlaDRCeCtVTVdSZlVS?=
 =?utf-8?B?ZTNqaVYwU21OVEpjOFlCNmlEVWJjbEVVZFRKMTl4bjdBY2NtbnJ1a0I0SFRO?=
 =?utf-8?B?YXIxRFpLWmYvbjcxTHM5SldxM0NZSitCZ0x2ZEpJL3JrQ0pmUWJQQ3o1TUcr?=
 =?utf-8?B?MHhRNFdHMTBqZGhNZmQ0cWorZUZCd2NMMTcrTkpUQUlleUd4NmhhcVJ2K2E2?=
 =?utf-8?B?T0daWkkvd05GV2x4TWxzSUdrOUlVZG91QVFKV056UlRqT2tReWpIcDRQT3pn?=
 =?utf-8?B?Y2hLcjg4L2x5RTlpT2FtUzRBZy9abU5FM0xIaTVmd29GWkZ4OUVPOWhLaE1V?=
 =?utf-8?B?b0ZvRUtZU0J5dTF1Y3BJYU5TRzQxQ29aU1hSSEYrVjVRdXIyNG92dEh1dmht?=
 =?utf-8?B?dmFXSmNFZTVFcmUxb3kxWnpwRzlKRGVDVHBPSFpPZmhiOGRzaWl5alNLYU1F?=
 =?utf-8?B?SFZpR1MrV1NIWEVBRis3WU9BS0VQMlNpV0hWNzJNSjJhTU9VcXZLYU52TUZH?=
 =?utf-8?B?d0w1ZXh6R2dQWmxhZlJnMzRtdVRYaFp4aGE4ZXZTQ1lkalNvdXZIVFdwU29x?=
 =?utf-8?B?Q1NabzRBWXViMzYvNVpKNHpmWm1MNzc1WWhjOUJaMXFvaGZnM2N3UEVMNzM4?=
 =?utf-8?B?M29OQjNxVy9NVFd5UXlrTGR3Z082b2FyNnVOaGtwS091TlJyeUtiZlFuTGs2?=
 =?utf-8?B?THlDMWMraC9RQzN6R29mWFJMQ2NWSnBLbU02cG5Sck9iczlxVmtwd3dnTVZy?=
 =?utf-8?B?c2NjNWtIWG5GbVlSOTR5Q1NnLy92b0tiS0R0NXAySmV3bDA2azFGbEF3RFlF?=
 =?utf-8?B?RFQ1YnJ1Q3J4eUw3VE1BWWxqb1ZWdXF3YTl5aElvZ2tEMGxGb3NhOEp4c3Aw?=
 =?utf-8?B?YkdJU0VrRnUrejNRN2tadHZpY09TYnBFVk53TmVKWnZCZlFsZW1EakdrSGt5?=
 =?utf-8?B?N2dNd2sySTZBeHp3bjMzTFJmdW1QOWl3THUzSGE5TW92TVZnRFZMWWxBY2ZH?=
 =?utf-8?B?d3ozb0MvZ0hTVXlscWVLNm9QeXZxZTdFWGpuZXZaUXRLUWZsRmY0K21LcEJ5?=
 =?utf-8?B?alNHUWJIMXg5K0pjcUpxRlFJUUlnVHRUcVV2QjBRbVh6OHBVK1lUU2VZUnZ6?=
 =?utf-8?B?ZVRQS2ozZWxCM3NpSHlLZVAxZEpEZnBkdDdmZmlTNnlKaCtpWHZvYnc3RDhl?=
 =?utf-8?B?YzQ3RklaZVdIZEtzRWpWalIzeFMxZDJKQUJSdGJxR2I1Q3B4Z0VCTkIzUjJy?=
 =?utf-8?B?OHl6YTlrM05jOVljRmtDSGIybVdmTzVRbkZSNE1Ra2JaUDZoM01hYldPMjE0?=
 =?utf-8?B?ZE42R2VQSm9lOHJFT1o2eTVEb3hHSWcwNzFTM0lUNWwzVW5yNmppOXZlNU5s?=
 =?utf-8?B?U1RpWmJnTG5yM2w2M1VRcmxHbHlIMi9aY3NyWURDeEd5aC9oTWd6QzJ6VXRY?=
 =?utf-8?B?OWFxMTZiMEN5dnJ6czd3MXFIdWNvNzNMd1ZMQXNKNWJuaGErYkpWeXFFdjdm?=
 =?utf-8?B?Q1ZPOEpTRjFPQkxqeEtIZVpPVnNmbzZ1UXQrTFpVaFI5ZTZiQ0xXd2FTZXAz?=
 =?utf-8?B?eFpMKy90RityRnRYNDJGcnRGVDY1alJPbkRVNCtPc0N4WEQ2Mmc2MCtZVy9s?=
 =?utf-8?Q?EVdk8K3w47fo50nOV+e2NWu4D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7ba6e1-38ee-4017-c068-08dac7380d43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:34:38.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ783GOrVQIdeJgKI+CYV1K+0pTV1uAfvQyMPCEhW7w1bp/aqEFM6YuE8pHESXBxJatg6S+YeGuVp4g9WcPLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 10:56, Sean Christopherson wrote:
> On Tue, Nov 15, 2022, Andrew Cooper wrote:
>> On 14/11/2022 23:34, Sean Christopherson wrote:
>>> Tom,
>>>
>>> I Cc'd you this time around because the APM doesn't explicitly state that
>>> GIF is set when EFER.SVME is disabled.  KVM's nSVM emulation does set GIF
>>> in this case, but it's not clear whether or not KVM is making up behavior.
>>> If clearing EFER.SVME doesn't set GIF, then patch 1 needs to be modified
>>> to try STGI before clearing EFER.SVME, e.g. if a crash is initiated from
>>> KVM between CLGI and STGI.  Responding CPUs are "safe" because GIF=0 also
>>> blocks NMIs, but the initiating CPU might leave GIF=0 when jumping into
>>> the new kernel.
>>
>> GIF exists independently of EFER.SVME.
>>
>> It is also gets set by the SKINIT instruction, which is why there is an
>> asymmetry on the #UD conditions of STGI and CLGI.
>>
>> STGI is also intended to be used by the DLME once critical
>> initialisation is done, hence why it's dependent on EFER.SVME || SKINIT.
> 
> Gah, stupid APM.  The pseudocode states "EFER.SVME || CPUID.SKINIT", but the
> description and the comment both say that SVM must be enabled to execute SKINIT,
> which made me hope that disabling SVM would reset everything.
> 
>    This instruction generates a #UD exception if SVM is not enabled. See “Enabling
>    SVM” in AMD64 Architecture Programmer’s Manual Volume 2: System Instructions,
>    order# 24593.
> 
> ...
> 
>    IF ((EFER.SVME == 0) && !(CPUID 8000_0001.ECX[SKINIT]) || (!PROTECTED_MODE))
>            EXCEPTION [#UD]  // This instruction can only be executed
>                             // in protected mode with SVM enabled
>                                                       ^^^^^^^^^^^

I'll see if I can't get someone to update the psuedo-code comment here.

But, to your original question, as far as I understand, GIF is not 
automatically set if SVME is cleared from EFER.

Thanks,
Tom
