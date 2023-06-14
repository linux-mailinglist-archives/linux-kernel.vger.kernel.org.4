Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C89730AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjFNWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFNWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:40:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBB1BC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:40:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686782411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IJ3rNp43FU2Lp9lvkrrGEgS04PW2LxBh6CBSMfqEhU=;
        b=dGWWzBaRJje6L7gdtJqb9apszHjZvRaCNpJMHDYnCObt45YEP6Olk5Js+R+FR26VnT0/SN
        vIGZOIa5ZU/BaYwepAd912zBET6bsbktHNSeDEjIDBOhQYOPd+rUp8U1yCXjbH/pJwUqHa
        ZHC4ocTa7GWzbXiUeC2jEwGgvbiDsxa8aazRgjbJoFcjttaqXoLIFg8GY5FjsWb9avcKDF
        au34/0mil0KYL9Qgcv+fu04O8dDjZehIpXq1McG260X6IlWQs4VnD+XAYo2pCpRb9PrkY9
        ljZYlzgeZkC0pHuZ3p6et/hLIrqp+vemBXLyEfuot4PRMDsn1t+WupxcNHiqeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686782411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IJ3rNp43FU2Lp9lvkrrGEgS04PW2LxBh6CBSMfqEhU=;
        b=6qZ1NmdJ6ThkdjLYK4SNt5Qm/U9VCnLYjPzLQunoBB6O1kVZr3B9Di8Zm+7hGIIKZXYtBS
        /FolykaDkujCURCA==
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 1/8] x86/smp: Make stop_other_cpus() more robust
In-Reply-To: <ZIonT7+sxAx8IWEE@a4bf019067fa.jf.intel.com>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.639116359@linutronix.de>
 <ZIoYMakfbAU9EOjc@a4bf019067fa.jf.intel.com> <87ilbp95xq.ffs@tglx>
 <ZIonT7+sxAx8IWEE@a4bf019067fa.jf.intel.com>
Date:   Thu, 15 Jun 2023 00:40:10 +0200
Message-ID: <87fs6t8y7p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14 2023 at 13:47, Ashok Raj wrote:
> On Wed, Jun 14, 2023 at 09:53:21PM +0200, Thomas Gleixner wrote:
>> 
>> Now let me look into this NMI cruft.
>> 
>
> Maybe if each CPU going down can set their mask, we can simply hit NMI to
> only the problematic ones?
>
> The simple count doesn't capture the CPUs in trouble.

Even a mask is not cutting it. If CPUs did not react on the reboot
vector then there is no guarantee that they are not going to do so
concurrently to the NMI IPI:

CPU0                          CPU1
                
IPI(BROADCAST, REBOOT);
wait() // timeout
                              stop_this_cpu()
if (!all_stopped()) {
  for_each_cpu(cpu, mask) {
                                mark_stopped(); <- all_stopped() == true now
       IPI(cpu, NMI);
  }                            --> NMI()

  // no wait() because all_stopped() == true

proceed_and_hope() ....

On bare metal this is likely to "work" by chance, but in a guest all
bets are off.

I'm not surprised at all.

The approach of piling hardware and firmware legacy on top of hardware
and firmware legacy in the hope that we can "fix" that in software was
wrong from the very beginning.

What's surprising is that this worked for a really long time. Though
with increasing complexity the thereby produced debris is starting to
rear its ugly head.

I'm sure the marketing departements of _all_ x86 vendors will come up
with a brilliant slogan for that. Something like:

  "We are committed to ensure that you are able to experience the
   failures of the past forever with increasingly improved performance
   and new exciting features which are fully backwards failure
   compatible."

TBH, the (OS) software industry has proliferated that by joining the
'features first' choir without much thought and push back. See
arch/x86/kernel/cpu/* for prime examples.

Ranted enough. I'm going to sleep now and look at this mess tomorrow
morning with brain awake again. Though that will not change the
underlying problem, which is unfixable.

Thanks,

        tglx


