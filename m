Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC5735CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjFSRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjFSRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:15:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F54B2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:15:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687194902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPJqe5fTBR0aJ5jpaj3EjZ/URBImS5R5IdkZX0nWfXw=;
        b=Emwa1WmLtvccC3yx3fD8Q4Vi8Kvm2HMIpjvgxo+RJJeNvNDyeezFwwJClOkuvZ/Uj7meIZ
        RDXPMF5GFtSfg6Tjp+wDbhO8lhlooJy1UkhkRCkzUlYRgzHyAYRfOs/kB1pgOT8hg7+Wmn
        yxb4NPWl6wqNa6CcMBLnxgkbl7+fLgYIxKJkK3zhy6RvlbnonTJHC2Kq9z0Sy6fuCo6bQi
        UJbXG09icXb7O/OEyFY1jMUKWzNf10wPXfPCYG2q+WU5tXZtxjG0vRgu4nFd8WkrMc8dDG
        bLAZZ2rz80bI8Z81eGWFjkQf/ptVWFKISYwsh3c9brDoAu6Dm6DZSTTlFa+2fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687194902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPJqe5fTBR0aJ5jpaj3EjZ/URBImS5R5IdkZX0nWfXw=;
        b=d8agZ1JQiewhHZ1fyJhP0m43q6bqVtmSBrhRrc2kClrXKw+781t8JovA9TrsDTwug6zEyJ
        gDa3Ci8JC25Fv5Aw==
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch v3 2/7] x86/smp: Dont access non-existing CPUID leaf
In-Reply-To: <220eb0c4-ace2-d67c-8680-fc9cd361f873@amd.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.322186388@linutronix.de>
 <220eb0c4-ace2-d67c-8680-fc9cd361f873@amd.com>
Date:   Mon, 19 Jun 2023 19:15:01 +0200
Message-ID: <87v8fjpe5m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19 2023 at 12:02, Limonciello, Mario wrote:
> On 6/15/2023 3:33 PM, Thomas Gleixner wrote:
>> From: Tony Battersby <tonyb@cybernetics.com>
>>
>> stop_this_cpu() tests CPUID leaf 0x8000001f::EAX unconditionally. CPUs
>> return the content of the highest supported leaf when a non-existing leaf
>> is read. So the result of the test is lottery except on AMD CPUs which
>> support that leaf.
>>
>> While harmless it's incorrect and causes the conditional wbinvd() to be
>> issued where not required.
>>
>> Check whether the leaf is supported before reading it.
>>
>> [ tglx: Adjusted changelog ]
>>
>> Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
>
> Thanks for this fix.
> This particular patch should probably also CC to stable.

It's pretty much all stable material.
