Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60B863BEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiK2L0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiK2L0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:26:43 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 03:26:41 PST
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9364B775
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:26:40 -0800 (PST)
Received: (qmail 26958 invoked by uid 1001); 29 Nov 2022 11:20:00 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@icdsoft.com@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 29 Nov 2022 11:20:00 -0000
Message-ID: <ff5ad474-6d32-8bf8-e297-ed71a967d27c@icdsoft.com>
Date:   Tue, 29 Nov 2022 13:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   Ivan Zahariev <famzah@icdsoft.com>
In-Reply-To: <87y2c28zir.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello gentlemen,
Hello Yu-cheng Yu,

Can you please take a look into this bug which syzbot tracked to a 
commit of yours (b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94). Even since 
we switched from kernel 4.14 to 5.15 we are experiencing often random 
segmentation faults with the following error in "dmesg":

    post.sh[2237] bad frame in rt_sigreturn frame:00007ad24b2f8df8 
ip:733cfa4351d1 sp:7ad24b2f9398 orax:ffffffffffffffff in 
libc-2.28.so[733cfa36d000+147000]

Most commonly Bash is getting hit by this problem but other binaries 
also experience the it less often.

Thomas Gleixner has already provided some insight and a simple 
reproducer: 
https://groups.google.com/g/syzkaller-bugs/c/rbdQkahfwE4/m/RyWIrlA0BQAJ

If there is no simple fix, can we simply revert the faulty commit?

Best regards.
--Ivan

