Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEC66BD73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjAPMDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAPMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:02:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA51E2A0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRyCyU9t7Td+Y7uzahbSZS9NbglZe2nj++sgOYNAmqKHJlZzP3DbTzjp4+f6nC4+rbzU18JMyskOjIJuMsafCC1d/w2Lx9pqmGCvC+sty30+FflJn/ovrpwnutWaXBs09SDDgE7RihCDiAm8M73LgLVhGnjbkJKj+lfvssDLAWlvKoeXV7Yce7NXNGQX2ql5b2SjI+u9RMX0FD5LAS4cfTgaMo/N81lEHCWtoQWcUPAqfZO1urCt3GTLKYAuWsZbbNdVxY4XGTBs94o6z55UjJQmYd1aWD9YeoYW858+3JXudQUn8WQ2v2y+bwXbs4obZUngB4iXdBGV4QAYLiO78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa69sBU6amB8bnBApow4rzKzQcvkQ2PUgFSgR88+xgM=;
 b=L8GNMRGP/NsVXMc/H9W12FtX2oj28r54ayCvBBKxeeifpAKvgCDN5TK5IQ3wDQf39MB4Lmv7ss9UVjFsKUwef4TKskuNAyWiaGk3N4rfO94Any/iB64qUuMQDGnsj7nAgA6/6/Hn1hi4JcNQcUBjwt46hTKlqm1Dz3VcJa9duZf5kWkAP1QhspsUIeF0qyrTx+64wDTteI+ZTN3+EYj1lXly1NNLFNrflD+HGZr6BCSg7CWRkFOYjBJzouob5reprzcckOSUSkzyDwatQqiMukP7lbgGOL6IDOZRzaJ39mcHWPjMdjuF4EtyXGD1VKxTzSfCqt33p/BjOzt7OU/xdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa69sBU6amB8bnBApow4rzKzQcvkQ2PUgFSgR88+xgM=;
 b=mZxr5FWd1k1C9QuIyni/6Bk1exn3QsYR7GNFaB3ZMoax9tgcqn1RVa1+UipA41FkgGtJhAHQkMlc2pW3phdgzqPlpVP0g4ACoantMRmjp4gVGUgVxaSxgAdbioEOZHMWA253q0keNVj81RY3DhTDbwZY/Z2bwlsIPWJQyeBR9E4=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 12:02:13 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::87) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Mon, 16 Jan 2023 12:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 12:02:13 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 06:02:11 -0600
Message-ID: <b5176020-5edb-79e2-d699-8370ed4f0d90@amd.com>
Date:   Mon, 16 Jan 2023 13:02:09 +0100
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
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com> <Y8GFYEnIy0Wbh/n6@kroah.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: Reg the next LTS kernel (6.1?)
In-Reply-To: <Y8GFYEnIy0Wbh/n6@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: ce68b7af-90ed-4679-ae42-08daf7b98173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh2XxGF9ojG4KVSJeBSRgwWrF/oZJCM1VPpTNBcOK0vAjA5BaHQg6o8J2qfUxqJpb0pkdKSKgkAkNXKb0lHfx3ZNFmvJq4jioZenz3UrRVPjzZZTr8X1EszVEkDY4HJorabuaWp5fRhqYMkHoTvPz6BzRAaNN+UnM6BthxkF9WTQW26ocqAiY6cbw2uhKQqlT5fEFloQv1Ru6o1CglrzIxkaNuIyMVDu3YXsZRBhp6kP20MmcpGCAKnnSyvVmE1ucPBC5Qd4Y2fampgFTjgbw//872/gV0s2RPUI56WRfZDJK3ffq+gZL2TWVZce+beRyzoYZuew+Oqk12a9I2IiSqOch5n9+kZ2KrmLr873uAiQ61aeBBNVwdqfxcTvTm3v3JPvhYddiTzT3N1zdWldEQHXCJOygHGD9GiKBDO6iWkQM6aqhm+qkMTgQlKmACzmDrqhVBu/sFsqlR6BKO3mb5zs8ZgcuLfddZSJtfL6qQzT47xeqV/VYgoBlz0/D//CK+1you6NwjY0Rj081hmamviCazcAEjCnGXDMHVg4JAvVM/aVgEkSxLpZNoPTcl3UbPc7imSd7D4NbCXizR3vzt0NxCs647GMq4ijqqJnaBjWNzW+foAYKxpF1ajm2/EEPcXe/Az7JXglwFLT2COVWWOc/m6wYWGaWxfzLQNrCSBw0QcM2z1vRLCIbj3WGgb3igY2eyh7pqZlZHFGzjsZVgTzhbRZWyb2My7wEn8pvoqv/yjccHx7C+eLgqQCmsQigMDfkWScOxSQjXABIKat6BSTW1lsOWgyYFnh0XutzOqIpozmgb+Mx5Wsu5IxXcmMH4z9aX3e3zh2Ag6KOk5hFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(31686004)(53546011)(426003)(70206006)(70586007)(47076005)(2616005)(41300700001)(186003)(16526019)(26005)(4326008)(8676002)(6916009)(82310400005)(36756003)(31696002)(86362001)(5660300002)(336012)(36860700001)(82740400003)(8936002)(54906003)(478600001)(40480700001)(16576012)(316002)(83380400001)(2906002)(356005)(81166007)(966005)(44832011)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 12:02:13.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce68b7af-90ed-4679-ae42-08daf7b98173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 17:22, Greg KH wrote:
> On Fri, Jan 13, 2023 at 01:54:29PM +0100, Michal Simek wrote:
>>
>>
>> On 1/13/23 12:27, Greg KH wrote:
>>> On Thu, Jan 12, 2023 at 01:26:28PM +0100, Michal Simek wrote:
>>>> Hi Greg,
>>>>
>>>> On 1/12/23 13:23, Kris Chaplin wrote:
>>>>> Hello Greg,
>>>>>
>>>>>> You tell me please.  How has your testing gone for 6.1 so far?  Does it
>>>>>> work properly for you?  Are you and/or your company willing to test out
>>>>>> the -rc releases and provide feedback if it works or not for your
>>>>>> systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
>>>>>> anything missing in it that you feel needs to be addressed with a newer
>>>>>> kernel instead?
>>>>>
>>>>> We have been integrating and testing 6.1 on the Microblaze, ARM32 and
>>>>> ARM64-bit architectures over the past few weeks.  These builds have
>>>>> been successful and we are able to run our regression tests on hardware
>>>>> targeting our FPGA SoC devices.
>>>>>
>>>>> We're continuing our tests as new updates to the 6.1 kernel series
>>>>> appear.
>>>>
>>>> As Kris said AMD/Xilinx has already moved internal SOC tree to 6.1 based
>>>> kernel in expectation that 6.1 will become next LTS.
>>>> And I am not aware about any issue from testing team related to 6.1 kernel
>>>> version. And we are covering our AMD/Xilinx SOCs based on arm32/arm64 and
>>>> Microblaze CPUs.
>>>>
>>>> It would be good to continue with the same strategy which using the latest
>>>> kernel at that year which is what I am hearing all the time from others that
>>>> 6.1 was last kernel at that year and it should be LTS.
>>>
>>> Generally yes, I pick the last release of the year but we need people to
>>> verify and validate that both it works for them, and that they are going
>>> to be using it in their systems and can provide testing results to us
>>> (as well as providing a way for their devices to actually be updated to
>>> the new releases, we've had previous stable kernel releases that were
>>> never actually shipped out to devices...)
>>
>> We are preparing base (every year) for our customers which is what it is
>> also shipped in our distribution.
> 
> What distribution does AMD create?  Who uses it?  Where is it published
> and how is it updated?

AMD acquired Xilinx last year. That's why Xilinx PetaLinux distribution is under 
AMD wings. It means it is distribution for Xilinx SOCs (Microblaze, Zynq 
(arm32), ZynqMP/Versal/VersalNET(arm64).
https://www.xilinx.com/products/design-tools/embedded-software/petalinux-sdk.html


It is used initially by all Xilinx customers. Kernel itself is wired inside this 
distribution and also used by Xilinx meta Layers in Yocto.
Cannonical is also using it as a base for AMD/Xilinx derivative kernel in Ubuntu 
for supporting arm64 based SOCs.


>> Other distribution like Ubuntu with their derivative kernels prefer to stay
>> on the LTS kernels too.
> 
> I already discuss this with the various "normal" distributions all the
> time so they know what is going on here already.

ok

>> Also users will be getting fixes against our base for extended period with
>> fixes going from vanilla kernel.
> 
> What is "your base"?  Who uses this?  How long is it supported?

For 2022 it was 5.15 + Xilinx SOC patches.
For 2023 it is going to be 6.1 + Xilinx SOC patches.

As I said above. It is wired in petalinux, yocto and also partners are using it.

Xilinx is supporting this kernel for one year till the next upgrade.
After it 3rd party partners are continue to support these kernels if required.

> 
>> For code which is not upstream(which we unfortunately have it) we are
>> providing fixes only till the next LTS version base is created.
> 
> So you only support the image for one year?

 From AMD/Xilinx point of view unfortunately yes but in Ubuntu via derivative 
kernel newer LTS version are merged and supported base on their support strategy.


>> That's why it is very beneficial to use for our base kernel which is going
>> to be LTS that users will get that extended period support.
> 
> But you should be keeping this up to date for each normal release,
> right?

We have never had enough resources to support multiple kernels. In perfect world 
we should do it but there are all the time constraints.
I am keep pushing over years to do upstreaming as early as possible and then our 
changes will be spread to all kernels. But we are not there yet.

>  Never do only yearly jumps, that way causes way too much work
> and is proven to be a bad idea.

I know that for many years but not the person who is deciding the upgrade strategy.

> 
> And why not just update your "customers" to every normal release?  Why
> stick them with one a year?  What is preventing more frequent updates?

Questions are correct but I am not defining strategy.

My goal is very simple to push everything to upstream and then we don't need to 
have discussions about it.

>> Base Kernel version is taken after your decision about LTS. But this year
>> because of timing we couldn't wait for this decision. That's why 6.1 was
>> taken with expectation that your generic concept about picking up the last
>> release of the year is going to continue.
> 
> That's a great guess, but again, you should always be updating your
> out-of-tree changes against every release so it will not matter what
> kernel is picked as a stable one or not.

There are a lot of things what we should be doing but we don't have unlimited 
number of resources especially on testing side. For me it is not a problem to 
preparing that kernels but someone has to run regressions over it and fixing 
issues if any issue happens.


>> Tested wise. We have test result from 6.1 <.0> and I have also shared 6.1.5
>> based version for our distribution. As of today we can't see any issue with
>> 6.1 kernel in general on features which we are using on AMD/Xilinx SOCs.
> 
> Great, can you also test the -rc releases to make sure we don't break
> anything for your systems?

Request to test the HEAD of TF-A, U-Boot and Linux was sent long time ago.
And I hope that regressions are running based on available features internally.

And our ZynqMP board is the part of LTSI and KernelCI and I see that regression 
is running there properly

https://linux.kernelci.org/soc/zynqmp/job/next/
https://lava.ciplatform.org/scheduler/device_type/zynqmp-zcu102

Another regression is running on Canonical side.


>> Also Jonathan wrote at https://lwn.net/Articles/915435/
>> "Unless something extremely surprising happens, 6.1 will be the final kernel
>> release for 2022, and thus will become the next LTS kernel."
>> That's why I hope that 6.1 is going to be next LTS.
> 
> Testing and feedback is going to be what allows this to happen.  I can't
> happen in a vacuum, and nor should you want it to.

And that was the purpose of jumping to this thread to send you a message that we 
are going to use 6.1 kernel and we can't see any issue with it on our side.
If 6.1 is going to be LTS then good for us.
If different kernel is going to be pick up based on feedback you get then we 
will just stay on kernel which is not going to be LTS.
For me this discussion is worth as input for internal discussion for kernel 
selection for 2024.

As I said I prefer to push everything upstream, properly mark fixes and then 
kernel version decision is up to every distribution/project. I got there with 
TF-A project and we are pretty much there with U-Boot and the kernel is the last 
one to focus.


>>>> I didn't run any stats but normally also more patches are going to this
>>>> version to be the part of LTS.
>>>
>>> What do you mean by this?  The patches accepted so far since 6.1.0 was
>>> released, or up until 6.1.0 was released?  For the patches since 6.1.0
>>> was released, that's due to more developers/maintainers tagging patches
>>> during the -rc1 merge window for stable releases (honestly they should
>>> have gotten them into the -final release first), and due to us having
>>> better tools in digging up potential stable patches (i.e. Sasha's
>>> AUTOSEL bot work.)
>>
>> I am just saying that developers/driver owners can simple do calculation to
>> identify LTS version. When they know it they also know time when their
>> deadline is for upstreaming work. It means if patch is accepted between
>> 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.
> 
> That is what I am afraid of and if it causes problems I will purposfully
> pick the previous release.  This has happened in the past and is never
> an excuse to get anything merged.  Code gets merged when it is ready,
> not based on a LTS release.

No doubt about it.

Thanks,
Michal

