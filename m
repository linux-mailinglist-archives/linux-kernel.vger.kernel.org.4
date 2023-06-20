Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCDC736BED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjFTMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjFTMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:30:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED9E71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:30:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687264246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cliDFdvEII/ObelRErqGCCe5zuD8wpNnRDoNEdt0aQ=;
        b=MZg1OnWYBZbJpfirIqr6mqS0LT7CNQY7eCM/kdjjBMN+keiEHan06vd1gwbDg8AmYowoQu
        nRJd7JEWKVRT+rCZpVRQyuqAqNwC1H+ICqij9kPhUjlaKeXzINAT/h5POjuQ2O29S714VI
        NCxATvGWxiC5mlOJly4eu0YmFP8ih4JQEOcnuVVstdHBSBLCOsKsbWyV+t+Q8umnHXMajm
        zgOF+lLDd8xhLHzOySGuXdXPk501LxqfjcNBfHg2Ub0WPXokDKpGKtHPBTloReno+IvOT4
        +V/qC4XYhfjMDDiYM1W7o5dNKkxaqnc1qYNXwRBOGx6evIv5Rpas+H8rMi/Pcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687264246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cliDFdvEII/ObelRErqGCCe5zuD8wpNnRDoNEdt0aQ=;
        b=80US8P9djAsAKhadr+E4DSenfnfT+UAFcilH2q5B2H/7lZELUgHEpo4fzqn65qeenYzDYo
        Y58dc46ofZRYzHAA==
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
Subject: Re: [patch v3 6/7] x86/smp: Split sending INIT IPI out into a
 helper function
In-Reply-To: <20230620092906.GXZJFxYpyR2Sf9PM84@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.551157083@linutronix.de>
 <20230620092906.GXZJFxYpyR2Sf9PM84@fat_crate.local>
Date:   Tue, 20 Jun 2023 14:30:45 +0200
Message-ID: <878rce8gei.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20 2023 at 11:29, Borislav Petkov wrote:
> On Thu, Jun 15, 2023 at 10:33:58PM +0200, Thomas Gleixner wrote:
>>=20=20
>> -static int
>> -wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
>> +static void send_init_sequence(int phys_apicid)
>>  {
>> -	unsigned long send_status =3D 0, accept_status =3D 0;
>> -	int maxlvt, num_starts, j;
>> -
>> -	maxlvt =3D lapic_get_maxlvt();
>> +	int maxlvt =3D lapic_get_maxlvt();
>
> Whoops:
>
> arch/x86/kernel/smpboot.c: In function =E2=80=98send_init_sequence=E2=80=
=99:
> arch/x86/kernel/smpboot.c:860:9: warning: ISO C90 forbids mixed declarati=
ons and code [-Wdeclaration-after-statement]
>   860 |         int maxlvt =3D lapic_get_maxlvt();
>       |         ^~~

How so? It's the first thing in the function, no?

And in the other hunk it's _before_ code too.

Conflict resolution artifact?

Thanks,

        tglx
