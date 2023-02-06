Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7B68BD74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjBFNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBFNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:03:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897E26AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:03:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675688609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oYHI1jbFdGXhe6qIvHJHxe9o/y0Q9Zxojj50+J8Zwk4=;
        b=NWYFuyYE7b0tuBHTJOxcYCgAnoSp3h1UbUe9ccgOe4tFZZQB06KAjQgK3DZ7/gAwURYn41
        LHy6oLaOwyMlKSK5sownXg8CY6Oos2cU2yQ1ODCrjg8QGXK+Y/uh2nt96TAZe2eZNzbrRn
        rOXJ7aj1CazZ6Eeauycoe1lxdsaF4WO8cdY0YoPoNg17LgD5FUtZHdaliUBznpOV6N8dR5
        lZNrW/ZyXRlBqWdhhYllwWaGMTAbmy9Q3BBOtqpBz0ZJ+yoPClSa+V0zHpfV0/cCY4lwvj
        C1KUd9QzDVq+smXS1d6xUmkJsa2dJqS2hGvvTZ/EVlBrepHIDS7K3Cnc4q6r6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675688609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oYHI1jbFdGXhe6qIvHJHxe9o/y0Q9Zxojj50+J8Zwk4=;
        b=qLrSgtbmRVYWO5RluyJBrdjMcgRG8fhCYnHwWU9fTeoIbhgHPzZH5LJAmIl/uc3iJwHsm6
        9ccGBaH+Cp4FoTAA==
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <8308e930-6b55-5756-d653-5c623a8ea758@linux.ibm.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <8308e930-6b55-5756-d653-5c623a8ea758@linux.ibm.com>
Date:   Mon, 06 Feb 2023 14:03:28 +0100
Message-ID: <87357jymhr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2023 at 13:42, Sourabh Jain wrote:
> On 01/02/23 17:03, Thomas Gleixner wrote:
>> Also in case of loading the crash kernel in the situation where not all
>> present CPUs are online (think boot time SMT disable) then your
>> resulting crash image will contain all present CPUs and none of the
>> offline CPUs are excluded.
>>
>> How does that make any sense at all?
>>
>> This image->hp_action and image->offlinecpu dance is engineering
>> voodoo. You just can do:
>>
>>          for_each_present_cpu(cpu) {
>>              if (!cpu_online(cpu))
>>              	continue;
>>              do_stuff(cpu);
>>
>> which does the right thing in all situations and can be further
>> simplified to:
>>
>>          for_each_online_cpu(cpu) {
>>              do_stuff(cpu);
>
> What will be the implication on x86 if we pack PT_NOTE for possible
> CPUs?

I don't know.

> IIUC, on boot the crash notes are create for possible CPUs using pcpu_alloc
> and when the system is on crash path the crash notes for online CPUs is
> populated with the required data and rest crash notes are untouched.

Which should be fine. That's a problem of postprocessing and it's
unclear to me from the changelogs what the actual problem is which is
trying to be solved here.

Thanks,

        tglx


