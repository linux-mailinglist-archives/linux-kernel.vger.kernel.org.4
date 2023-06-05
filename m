Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F915721FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFEHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjFEHli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:41:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F000E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:41:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRgDaYGSQi9Frjrd+B4nzhFfQVtX2tsSstoahg/AF3M=;
        b=GDMB5sBZtNGqz1DQqhuFkF676LxkJ5xZriX2P0iXRQOJlc6QnaB737vNosX54s2U98g1oe
        ySCLQpEjWcuobPj/SrXVvtLgjz3HTcxSHfuT2ztmJO5OUAOSOP2U5YjeymCMr8mrrVCBaX
        dHq3BxnxFE3Nm7fUUHJz0LlB1s1gX2vDo45OK/9vec3p73i0mWOoPDL+RmCMZb5nLaKfHf
        XZttK+2Ah6koyeYigE6UoTM/Exj+TE47vjQJR8Za8hKuL50a5OPmUcDw0Z3/wtKeBX6oXR
        TFXF4pI3bs7pJ1el72f/eU/i4krJ6ga/s2/2qakXOvstQE8NQVu4SMZZ8rb/LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRgDaYGSQi9Frjrd+B4nzhFfQVtX2tsSstoahg/AF3M=;
        b=aPFq5nHYr7sTH2ObiYSYZLaI1+r4rknFOXhFui5OtPPM/6jTFgxBF+QzgCHnsenf+fIaCd
        VJmG1Ol4y226NmCQ==
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 4/6] x86/smp: Cure kexec() vs. mwait_play_dead() breakage
In-Reply-To: <ZHwCurlgWM+Q8wCC@a4bf019067fa.jf.intel.com>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.832650526@linutronix.de>
 <ZHwCurlgWM+Q8wCC@a4bf019067fa.jf.intel.com>
Date:   Mon, 05 Jun 2023 09:41:30 +0200
Message-ID: <87ilc28ifp.ffs@tglx>
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

On Sat, Jun 03 2023 at 20:19, Ashok Raj wrote:
> On Sat, Jun 03, 2023 at 10:07:01PM +0200, Thomas Gleixner wrote:
>>  
>> +void smp_kick_mwait_play_dead(void);
>> +
>
> This seems like its missing prototype for #else for !CONFIG_SMP
>
>  #else /* !CONFIG_SMP */
> +#define smp_kick_mwait_play_dead(void) { }

Nope. The code which calls this is only compiled when SMP=y
