Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D106F70CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEDRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:22:50 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8A4220
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:22:49 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 87354500062;
        Thu,  4 May 2023 17:22:47 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2351D13C2B0;
        Thu,  4 May 2023 10:22:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2351D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683220967;
        bh=+nLKqJaXzBlTzuClAWPKmZyH5g0YbhY/JlRTyBhd5/Q=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=p1dQQ3xxguhB0bwgDob5e1MDvcaddQ3S2aQQjvuJx73D6u5CFvMACL5c0ZizU7jZK
         CEaxXWXxuTsvslxh/ukqAQnRRtOEsdwebCUg6FBkH5ug+DZ/DvzUBkJoq/lkS7ldFX
         ZkSPbQLWGbWw8faBQqxhxMisvtzP1d9y9/M9EvXQ=
Message-ID: <a227583c-ef41-e954-fd4c-0cdb23c77222@candelatech.com>
Date:   Thu, 4 May 2023 10:22:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1683220968-qU9bEiPif6Zu
X-MDID-O: us5;ut7;1683220968;qU9bEiPif6Zu;<greearb@candelatech.com>;3e693a8d56a8eeb61aa6e0137c1c1bf1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 16:49, Ben Greear wrote:
> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 03.05.23 04:31, Bagas Sanjaya wrote:
>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>>
>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
>>
>> Just to understand this properly: you mean after the boot loader said it
>> loaded the initramfs, not when the kernel starts using it?
> 
> I am bisecting...it appears to be .config related.  If I skip enabling things
> during bisect, then I do not see the problem.  But I copied my original buggy .config
> into an otherwise good kernel commit, and now it fails.  I'm manually bisecting
> the .config settings....

I had enabled this option:  CONFIG_HYPERV_VTL_MODE

And that makes it not boot.  Not sure that is expected or not, but I will simply un-select it
and continue on, as I do not actually need that feature.

Thanks,
Ben

