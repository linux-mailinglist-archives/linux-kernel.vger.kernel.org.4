Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F72669808
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbjAMNHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjAMNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:06:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201F7826E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKAvTm+lRdZoLjha1eIp/iprReFTWmJP7RFt/IGPHDzYHWyg8pzRa53jtgTHeJZ2QUCQMYrJoi4GjJz0y6TuN+r4yxSPJYvpoIb/K62vNCngG0x5ZAezBT7T8zP5O/EFmWzsLdrMqM5UX3bu5Hp5V3AOjfMw4ZEYWDLOLhL9Tcwtg+ApsI8EyVzl8E1gPRHRxanhpghT7eNx02GIbEMdi+dmlCNjg7hsW+JvtW+F+bDg0W9f21lexeL6gOWMWZj5TA/wRkGS0X+rByL/bhyNtIz6kuu+2BXXH8OaSGTCw64bGKRgEEFNQQa1yyGDJj66SkBbrHASqAJMhRf+LY6Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf3t+LKgSoUgAAvmfGjWiPQafJd7SlIcz7FVxK8vkJo=;
 b=CPm5y30ejzkx5djNdsdKLj1Z2HXfgWFJM5zmN68oEyYyYWGHXA0OkRb+DOjefGx7uPLVhbbd6N5/sL7RK/SfKj4RKVlNmCkNlpYOUuRXNrurDcF+IaMp6n3rAI3NhBK/QSPjQFO/QVvxp7IcmC9aJn9yaIXf0c3M5TrSYIU50Iv3fGJUKoQFbwLxmdN+JlgJgDM6OZqZzFCZGd0GupXyVXWsufK4NMpIf1fmOOq03nVu62v6hsjDchVO2dk8hsiPix6inDqi4pebdnRXf3SSQXpvodUIIWfr2aFh+QvN+s4CgwJwuLNw1WxlaQ8pqWCsdBfswogK9fWhYyUs4ojMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf3t+LKgSoUgAAvmfGjWiPQafJd7SlIcz7FVxK8vkJo=;
 b=KOhhDTjqGqjZOmfDl8kjcqJ5plHM0B3vhGOCqwUsEtMXQ95ggXKJp/xot5adxj7p42YpXaBDYpYGCrq9C5zmw/yntSVcobVjftmMxBsaFoFo75KD8hDo/INWoHbmZwImqavejvrvs1wh2/BoJk7v5lFa/SvLGMoDXf3N66es0+A=
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 12:54:33 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::d1) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 12:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 12:54:33 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 06:54:31 -0600
Message-ID: <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
Date:   Fri, 13 Jan 2023 13:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Kris Chaplin <kris.chaplin@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com> <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com> <Y8FAFAwB9gBzQXQG@kroah.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: Reg the next LTS kernel (6.1?)
In-Reply-To: <Y8FAFAwB9gBzQXQG@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 262bee22-b86b-418d-d6d6-08daf5655185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5UysTY1yrLLQLPJ3gqF3Sdew2F0OpW3AJIsgQqROI/TclqAAsMjMim8LlqmZaq7lkr7uyMW9TzO7g3qFqJAdGAFYgLLuny2K1IsLlgaKGEtaTBxtcGCUo0jgIEZ4/HM9JOWGPSmh5mF7ZmUSHcJG7EAbjZUeooE+qIUUPeOJeNfkd3KZBarz+nnInaiyCv0CmzNPB7vd3BCzP7ZrdQaHkqW/5wdCOmDzkV6bIr9bc3wJiBafSKS3w3E9QGADmBVPUnH+dvnAEQGBTTiCjQ1Cj7ZQUdv94TbD/Kyq5JYYLZhqWlcJgPT3WgCpelzUIfDaG7ZTfFR84So8HIKFdZXqS2vI8rv3xxydbzppCDM1gEJs6biRnDSjIfvQUluFR1pCyZK45vdpdAArX88WYWOZbeqK9TJGMv6AzeLr4aSqL3L3UwQgXm32uw1FierDf+OZllKLHU96irn2Rx+/C1G0k9vxQLVxpEdV/vyvnBQuw5ZN3h0CL9HoO2FEOrYao0BJOkrrzbayfQm2weHWbO/8XrRU9CnnklxG36sGsrfgbKVGCL5kk19QZxO2A9dMLwVXteGzZSrxUR2dsOkUrkQUKsGU6mHzIphxMugvfGhgnqNEZPSgzdBPakmVjUv3lEy1uWprMSrFN09VU2UpMl0l02gMRWdsloTfDRYHTm51GWrQn/LQugUJIqbjhsBsodz8+yX/ASJXX/czFDRBJLuh+j5nffAgR8lhRYJWmPm/N0ltB7w2D4Vfa2/ZI1fD+svanWBPS6XAhNspqnU5SsNeBcdGQGZp4jixmuqGUZg7x4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(36756003)(426003)(47076005)(53546011)(41300700001)(336012)(4326008)(8676002)(70206006)(70586007)(83380400001)(44832011)(26005)(8936002)(478600001)(186003)(966005)(16526019)(54906003)(2616005)(316002)(16576012)(6916009)(356005)(82310400005)(5660300002)(86362001)(31696002)(2906002)(82740400003)(36860700001)(81166007)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 12:54:33.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262bee22-b86b-418d-d6d6-08daf5655185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 12:27, Greg KH wrote:
> On Thu, Jan 12, 2023 at 01:26:28PM +0100, Michal Simek wrote:
>> Hi Greg,
>>
>> On 1/12/23 13:23, Kris Chaplin wrote:
>>> Hello Greg,
>>>
>>>> You tell me please.  How has your testing gone for 6.1 so far?  Does it
>>>> work properly for you?  Are you and/or your company willing to test out
>>>> the -rc releases and provide feedback if it works or not for your
>>>> systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
>>>> anything missing in it that you feel needs to be addressed with a newer
>>>> kernel instead?
>>>
>>> We have been integrating and testing 6.1 on the Microblaze, ARM32 and
>>> ARM64-bit architectures over the past few weeks.  These builds have
>>> been successful and we are able to run our regression tests on hardware
>>> targeting our FPGA SoC devices.
>>>
>>> We're continuing our tests as new updates to the 6.1 kernel series
>>> appear.
>>
>> As Kris said AMD/Xilinx has already moved internal SOC tree to 6.1 based
>> kernel in expectation that 6.1 will become next LTS.
>> And I am not aware about any issue from testing team related to 6.1 kernel
>> version. And we are covering our AMD/Xilinx SOCs based on arm32/arm64 and
>> Microblaze CPUs.
>>
>> It would be good to continue with the same strategy which using the latest
>> kernel at that year which is what I am hearing all the time from others that
>> 6.1 was last kernel at that year and it should be LTS.
> 
> Generally yes, I pick the last release of the year but we need people to
> verify and validate that both it works for them, and that they are going
> to be using it in their systems and can provide testing results to us
> (as well as providing a way for their devices to actually be updated to
> the new releases, we've had previous stable kernel releases that were
> never actually shipped out to devices...)

We are preparing base (every year) for our customers which is what it is also 
shipped in our distribution.
Other distribution like Ubuntu with their derivative kernels prefer to stay on 
the LTS kernels too.
Also users will be getting fixes against our base for extended period with fixes 
going from vanilla kernel.
For code which is not upstream(which we unfortunately have it) we are providing 
fixes only till the next LTS version base is created.

That's why it is very beneficial to use for our base kernel which is going to be 
LTS that users will get that extended period support.

Base Kernel version is taken after your decision about LTS. But this year 
because of timing we couldn't wait for this decision. That's why 6.1 was taken 
with expectation that your generic concept about picking up the last release of 
the year is going to continue.

Tested wise. We have test result from 6.1 <.0> and I have also shared 6.1.5 
based version for our distribution. As of today we can't see any issue with 6.1 
kernel in general on features which we are using on AMD/Xilinx SOCs.

Also Jonathan wrote at https://lwn.net/Articles/915435/
"Unless something extremely surprising happens, 6.1 will be the final kernel 
release for 2022, and thus will become the next LTS kernel."
That's why I hope that 6.1 is going to be next LTS.

> 
>> I didn't run any stats but normally also more patches are going to this
>> version to be the part of LTS.
> 
> What do you mean by this?  The patches accepted so far since 6.1.0 was
> released, or up until 6.1.0 was released?  For the patches since 6.1.0
> was released, that's due to more developers/maintainers tagging patches
> during the -rc1 merge window for stable releases (honestly they should
> have gotten them into the -final release first), and due to us having
> better tools in digging up potential stable patches (i.e. Sasha's
> AUTOSEL bot work.)

I am just saying that developers/driver owners can simple do calculation to 
identify LTS version. When they know it they also know time when their deadline 
is for upstreaming work. It means if patch is accepted between 6.0-r1 and 
6.0-rc5/6 they know that it will get to 6.1 merge window.
And by this there will be less patches pending for the next release upgrade.
I am not working in this mood but I have met with it couple of times.

Thanks,
Michal
