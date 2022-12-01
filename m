Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC263F103
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiLAM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiLAM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:59:15 -0500
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E6BB7E5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:59:00 -0800 (PST)
Received: (qmail 13748 invoked by uid 1001); 1 Dec 2022 12:58:59 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@icdsoft.com@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 1 Dec 2022 12:58:59 -0000
Message-ID: <212daa8e-8f48-30d9-cfc8-ee5c2025f02c@icdsoft.com>
Date:   Thu, 1 Dec 2022 14:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20200512145444.15483-6-yu-cheng.yu@intel.com>
 <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
 <CALCETrXfLbsrBX42Y094YLWTG=pqkrf+aSCLruCGzqnZ0Y=P-Q@mail.gmail.com>
 <10a553a5-699f-6921-705e-9afa1a8e42de@intel.com>
 <87y2c28zir.ffs@nanos.tec.linutronix.de>
 <ff5ad474-6d32-8bf8-e297-ed71a967d27c@icdsoft.com>
 <31b30c00-9de9-2881-53c3-b08804571d6c@intel.com>
From:   Ivan Zahariev <famzah@icdsoft.com>
In-Reply-To: <31b30c00-9de9-2881-53c3-b08804571d6c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 29.11.2022 г. 20:16, Dave Hansen wrote:

> On 11/29/22 03:19, Ivan Zahariev wrote:
>> Can you please take a look into this bug which syzbot tracked to a
>> commit of yours (b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94). Even since
>> we switched from kernel 4.14 to 5.15 we are experiencing often random
>> segmentation faults with the following error in "dmesg":
> Which kernel are you running, exactly?  There is a fix for the commit
> that you identified:
>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=484cea4f362e
> but it should have been in 5.15.

We are running 5.15.75 (LTS) but the problem started when we upgraded 
from 5.15.31 to 5.15.59 and is present ever since. I erroneously said 
that it's present into every 5.15.

I didn't do my homework well and blamed the commit by Yu-cheng Yu. But 
this commit never landed into 5.15, nor the fix commit that you 
referred. There are no functions fpu__clear_all(), 
copy_init_fpstate_to_fpregs(), copy_user_to_xstate() anywhere in the 
sources of 5.15.75 or 5.15.31, so the 5.15 kernel is running with a 
different FPU implementation.

Additionally, I tested the reproducer on older 5.15 kernels and on the 
super-stable 4.14.256. They all emit the same "dmesg" error, so the 
reproducer is not reliable to detect our problem.

I am sorry for wasting your time.

> Is there a chance you could test current mainline and see if the issue
> is still there?

That's our only option, it seems. Thank you.

Best regards.
--Ivan
