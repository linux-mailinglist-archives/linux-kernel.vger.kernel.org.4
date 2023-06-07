Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AD72720B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjFGWu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFGWuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:50:23 -0400
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 15:50:21 PDT
Received: from schatzi.steelbluetech.co.uk (james.steelbluetech.co.uk [92.63.139.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C421BE8;
        Wed,  7 Jun 2023 15:50:20 -0700 (PDT)
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
        by schatzi.steelbluetech.co.uk (Postfix) with ESMTP id 9B303BFC0A;
        Wed,  7 Jun 2023 23:24:44 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 schatzi.steelbluetech.co.uk 9B303BFC0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
        t=1686176684; bh=58edecI1dvqmoO6hSffmg4G7qFjkGAjLJvpFPrr3KWA=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p5kOdPKNq6SSnTVRbir3eTOIdp6kjSwBueX1UtDR8uGHqbEwwya+JoA4CtTfB/Giu
         YNQtvvmTMPSrYNSV3EjNLqKZhuowjwiVGZarknPeZxS5vXIHr1m4j2qLzFBxCKWWOF
         Vu4AMhZp0TITKv7n8hGpycDu+g1mngRnBT6FxXr6C90E+DOyyCvg2y+LdQ4ZUbz1dl
         6FRGTtSSFc+YTxHAdRiKCs/LfMQm8ZjkNQYeoMVcMdd49dj3v+7/KUqWpKo5B1qeJ8
         lrPoJfMkLzb1nh2A83Ja/bhMTLY06yW3TR/y7AFARoBwZ3KXgABGD4T25osawKx+mS
         WKjkCbpsOlFdw==
Message-ID: <fac961cf-7fa8-3ad9-f4b7-4701d864d015@ehuk.net>
Date:   Wed, 7 Jun 2023 23:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: eddie@ehuk.net
Subject: Re: [PATCH 5.15 00/93] 5.15.107-rc1 review (possible amdgpu
 regression)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230412082823.045155996@linuxfoundation.org>
 <97c9d345-b57c-8024-be35-357c8842115a@ehuk.net>
 <2023041326-esophagus-spoils-4c3f@gregkh>
Content-Language: en-GB
From:   Eddie Chapman <eddie@ehuk.net>
In-Reply-To: <2023041326-esophagus-spoils-4c3f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 15:46, Greg Kroah-Hartman wrote:
> On Wed, Apr 12, 2023 at 10:47:13PM +0100, Eddie Chapman wrote:
>> Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.107 release.
>>> There are 93 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please let
>>> me know.
>>>
>>> Responses should be made by Fri, 14 Apr 2023 08:28:02 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> I think I'm seeing a regression here in the amdgpu driver, though not being
>> a kernel dev I could be wrong.
>>
>> I built and booted this today on an x86_64 machine (AMD Ryzen 7 3700X,
>> Gigabyte X570 UD motherboard) with 3 x AMD graphics cards (using names from
>> lspci output):
>> - Cape Verde GL [FirePro W4100]
>> - Oland XT [Radeon HD 8670 / R5 340X OEM / R7 250/350/350X OEM] (rev 83)
>> - Bonaire [Radeon R7 200 Series]
>>
>> All three using the amdgpu driver (radeon module blacklisted).
>>
>> This machine has been running vanilla 5.15 stable releases for a good while,
>> with the kernel updated with whatever the latest 5.15 release is every 6
>> weeks or so. Never had any amdgpu problems.
>>
>> To build 5.15.107-rc1 I applied the contents of the queue-5.15 directory on
>> top of 5.15.106, having synced the stable queue git repo up until commit
>> 344d8ad1b5dde387d1ce4d1be2641753b89dd10d (still the latest commit as a
>> type). This is what I have done for years running vanilla stable kernels.
>>
>> There was nothing out of the ordinary in the build output, but on rebooting
>> into 5.15.107-rc1 I had the following error in dmesg from 1 card only:
>>
>> amdgpu 0000:0d:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test
>> failed on vce0 (-110).
>> [drm:process_one_work] *ERROR* ib ring test failed (-110).
>>
>> This was during bootup immediately after driver loading. X is not running.
>> 0000:0d:00.0 is the Bonaire card.
>>
>> I then shutdown and fully powered off for a few minutes, booted 5.15.107-rc1
>> again, but the error on that card persisted exactly the same.
>>
>> This was a regression for me as I've never had that error before on any
>> kernel release (I grepped through old kernel logs to check).
>>
>> I then rebuilt 5.15.107-rc1 but without applying the following 4 patches:
>>
>> drm-panfrost-fix-the-panfrost_mmu_map_fault_addr-error-path.patch
>> drm-amdgpu-fix-amdgpu_job_free_resources-v2.patch
>> drm-amdgpu-prevent-race-between-late-signaled-fences.patch
>> drm-bridge-lt9611-fix-pll-being-unable-to-lock.patch
>>
>> On booting into the newly built kernel there was no error anymore, amdgpu
>> dmesg output was as normal, and the machine is running fine now on that.
>>
>> So I'm quite confident one of those patches introduced the error for me.
>> Having now looked at the contents of them I see the lt9611 is entirely
>> different hardware and I'm guessing the panfrost one probably is as well, so
>> most likely I didn't need to remove those 2.
>>
>> This is not a great report and maybe not helpful (sorry) as unfortunately I
>> cannot try and narrow it down further to a single patch as this machine has
>> to stay running now for a while. I just crudely tried yanking those 4 to
>> hopefully get rid of the error and get the machine running again. Also I
>> didn't go on to test whether the card actually worked as expected, maybe the
>> error is harmless after all, though it doesn't look insignificant.
>>
>> As the error was only output for the Bonaire card (the other two were fine),
>> below is lspci -vvv output for that card only in case it helps. If anyone
>> would like further info just let me know.
> 
> Ok, I've dropped the two drm-amdgpu-* patches from the tree for now.
> Let me know if the release works properly for you or not.
> 
> thanks for testing and letting us know!
> 
> greg k-h

Hello Greg,

My apologies just realised I never got back to you, as requested, to 
confirm that, yes, that final release of 5.15.107 as well as other 
5.15.x releases I've tried since then (including 5.15.115) have booted 
up fine, without any unexpected errors, with these 3 AMD cards all using 
the amdgpu driver, each with monitors connected.

Eddie
