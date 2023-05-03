Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF06F6237
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjECXuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjECXtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:49:55 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE38A6C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:49:53 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D788BC40067;
        Wed,  3 May 2023 23:49:50 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 23B4513C2B0;
        Wed,  3 May 2023 16:49:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 23B4513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1683157791;
        bh=XALtbwbcOBSbPJpwrY4JfEAx3ICt0e7TO0hiS2sJnI4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=pg6Z+rLUdoNg5zcZ0c6fcIp8qOXW4CPGV/lj2xDATSIV/pesEN+z85tk9Xgc028Dg
         JDt7tASfefbqfvujpGm9l8F1zJepao+DeEaTcQAFBtoabnvWS0bJi35o4G4z7/aNpr
         siE2SUoIH8MlCJoalP+l9JwoLqyHJcPqsN3gGHq8=
Message-ID: <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
Date:   Wed, 3 May 2023 16:49:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1683157792-XA8JeW0ymIKj
X-MDID-O: us5;ut7;1683157792;XA8JeW0ymIKj;<greearb@candelatech.com>;3e693a8d56a8eeb61aa6e0137c1c1bf1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 03.05.23 04:31, Bagas Sanjaya wrote:
>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>
>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
> 
> Just to understand this properly: you mean after the boot loader said it
> loaded the initramfs, not when the kernel starts using it?

I am bisecting...it appears to be .config related.  If I skip enabling things
during bisect, then I do not see the problem.  But I copied my original buggy .config
into an otherwise good kernel commit, and now it fails.  I'm manually bisecting
the .config settings....

Thanks,
Ben

> 
>>>   Nothing useful is seen on
>>> serial console after that.  This was working late last week.  Other older kernels boot OK, so
>>> I think is is related to the kernel.
>>
>> What is your setup (especially kernel config)?
>>
>> Is v6.3 works for you? I haven't seen this regression on my computer
>> using v6.3.
> 
> Ben, you just to be sure might want to check if a kernel image that
> currently works still boots if you regenerate its initramfs: maybe the
> initramfs generator or something it uses changed recently and is causing
> your problem. I've seen a case or two where that was the case.
> 
>>> I have not yet started bisect, curious if this is already know problem.
>> Certainly you should try bisection.
> 
> Yeah.
> 
> BTW: What kind of platform is this?
> 
> Ciao, Thorsten
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


