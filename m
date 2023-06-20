Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02809736BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjFTMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFTMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:25:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60855E71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:25:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687263949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI/H55BDJsoGpeJInU2i92oFiehPg5S80icORgiJn5A=;
        b=uwHLfdAruaoAt9x0r9NyU1U1dDeV5Iw/Q16G921rh4dyW89i3wkaGf6rmuuyXMb55DWyZh
        dx7Nm+3FOu7rbPMXwz1dMmNriAsaGaAExYYHs0XEbSdAGx2rzsJhFIbMymgJqZQltUaCOb
        o9jxSujIRbZfIVsRlAaIEgHDW/i/msR0DqNwbTrTlcWroCrzn98+6nKaJkE/jVaQoRWDLL
        c88B/i3TZYWNDpZGbZKZkbeo1I1/n8lULWq147gZwzz1/ejAQmI7TYJ3jsotB3QYJHB81A
        yCVeYVEtIemgfmFcfPc2YpYXvvXDakWLhxMhpdTo9BNJWzNKLgqthuFjTYol0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687263949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI/H55BDJsoGpeJInU2i92oFiehPg5S80icORgiJn5A=;
        b=LUo2lP5lXi1Ya7ZYhXPxwax2NUKoCPomaA+pUaDTRvD0SQ55gUL5LTVw1iEUXgs49Amy7J
        T2sevr5cr5+jOBDw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 5/7] x86/smp: Cure kexec() vs. mwait_play_dead()
 breakage
In-Reply-To: <20230620092324.GWZJFwDDVo3TRUI0Ck@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.492257119@linutronix.de>
 <20230620092324.GWZJFwDDVo3TRUI0Ck@fat_crate.local>
Date:   Tue, 20 Jun 2023 14:25:48 +0200
Message-ID: <87bkha8gmr.ffs@tglx>
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

On Tue, Jun 20 2023 at 11:23, Borislav Petkov wrote:
> On Thu, Jun 15, 2023 at 10:33:57PM +0200, Thomas Gleixner wrote:
>> TLDR: It's a mess.
>>  	while (1) {
>> @@ -1824,10 +1836,57 @@ static inline void mwait_play_dead(void)
>
> JFYI: that last hunk has some conflicts applying to latest tip/master.
> Might need merge resolving...

Yes, I know.

>> +/*
>> + * Kick all "offline" CPUs out of mwait on kexec(). See comment in
>> + * mwait_play_dead().
>> + */
>> +void smp_kick_mwait_play_dead(void)
>> +{
>> +	u32 newstate = CPUDEAD_MWAIT_KEXEC_HLT;
>
> Do you even need this newstate thing?

Yes, for two reasons:

  1) To explicitely tell the other CPU to go into HLT. MWAIT can resume
     execution due to SMIs or NMIs, so we don't want to go them into HLT
     unconditionally. TLD; .... :)

  2) Two have the state feedback from the other CPU.

>> +
>> +		if (READ_ONCE(md->status) != newstate)
>> +			pr_err("CPU%u is stuck in mwait_play_dead()\n", cpu);
>
> Shouldn't this be a pr_err_once thing so that it doesn't flood the
> console unnecessarily?

Yes, no, do not know :)
