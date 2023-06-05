Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEBA72203E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjFEHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjFEHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:55:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BFD110
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:54:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685951694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xF8Q31iGiIVSiWCG8vtRm8j2MKMRIGvASB6jbNLRZ8Y=;
        b=BDJa+tzVu80gDfR9LXVPEcn6g8cSsqlRE/egzJpZSuyuq5+HsGjOhEAHjH5Px0dB5poLBH
        dmxfFKyGB0Fqn1D+rhImYpEuc1OAxj8sD8fZg4WCATKX0GCCzYzSr7eu0920q3mnaoi0Jv
        a8GJoXtGVeRhjH5CJm8L1jKBsZdAQ5+93Hrx6EnoBtiFwPGlEwySZ42HsYE0JGMtpvHXT9
        V7df/8GNs3mhm2Ksajy4WflVvyU9GjrLI5mMyyOIln2trZYde4cr+64+T+ONM1OVhTn9F5
        gczeBz2HTkzvpVbeJ9w3LxDirYn+yjcvUGA8ppwgO2BVCePp2On9cJnu5f04IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685951694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xF8Q31iGiIVSiWCG8vtRm8j2MKMRIGvASB6jbNLRZ8Y=;
        b=NnxJNr5bsJgmVs8ttgVgomsWQwK6qm5uIZ5SEpnnG1tlz4BYXPzIG64gS+Ylh6wI3tUzDg
        EkfmlqOv6NNEhqDw==
To:     Mika =?utf-8?Q?Penttil=C3=A4?= <mika.penttila@mbosol.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch 5/6] x86/smp: Split sending INIT IPI out into a helper
 function
In-Reply-To: <b9cef72f-0bcf-5bd6-e828-f11bd822fe33@mbosol.com>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.889612295@linutronix.de>
 <b9cef72f-0bcf-5bd6-e828-f11bd822fe33@mbosol.com>
Date:   Mon, 05 Jun 2023 09:54:54 +0200
Message-ID: <87fs768htd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04 2023 at 07:02, Mika Penttil=C3=A4 wrote:
> On 3.6.2023 23.07, Thomas Gleixner wrote:
>> +/*
>> + * Wake up AP by INIT, INIT, STARTUP sequence.
>> + */
>> +static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long=
 start_eip)
>> +{
>> +	unsigned long send_status =3D 0, accept_status =3D 0;
>> +	int maxlvt, num_starts, j;
>> +
>> +	preempt_disable();
>
> This seems like an unbalanced preempt disable..

Right. I screwed up a rebase completely....
