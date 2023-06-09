Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0BC729E33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbjFIPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjFIPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1330F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:22:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686324143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1naFavr92GwX5FkOX7e/quHSVxFZtV+4DxcoRTFPC6Q=;
        b=UIfNsraeML09qxs86FX0zo6kBEbq1ALHAB85lj3ub1Z7X9LgnQy93k9XHTm/vilJEXs5Ir
        llkKGj8FcmXONuq8zMP/hVC7hFa5CU+vP4szIJ++CqYUg0oG55tj3d8S+22215iQtMenKP
        poQQCPOTBC2aU4N8SMoqmm81WBs542fnlCwbxiCLusR4bmhTo8oC87hUE+ThnFcD6cVPS3
        n15LHd2SAbV+7UcxCJANo2DuWyNab0EXt6fvcDmOuHWK18eeATLenM8Ec8qFzuz//j2u/9
        E75T7FSAqevWkJt0ON7ECFZADEA5vloKe26pANHLIPTCYQE+ZxjzSB6XGAFZPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686324143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1naFavr92GwX5FkOX7e/quHSVxFZtV+4DxcoRTFPC6Q=;
        b=ZzrSBncpCwezVe7wuseibyrYIlve0G2tEZyR0dnz2li0uUYOkSVjSxUhDMo+YnwSiUwc5V
        jV4R5S8a5JJ7roAA==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v2 3/4] x86/entry: Disable IA32 syscall if ia32_disabled
 is true
In-Reply-To: <20230609111311.4110901-4-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-4-nik.borisov@suse.com>
Date:   Fri, 09 Jun 2023 17:22:22 +0200
Message-ID: <87edmkirtd.ffs@tglx>
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

On Fri, Jun 09 2023 at 14:13, Nikolay Borisov wrote:
> First stage of disabling ia32 compat layer is to disable 32bit syscall
> entry points. Legacy int 0x80 vector is disabled by zeroing out its gate
> descriptor in the idt and the sysenter vector is disabled by re-using
> the existing code in case IA32_EMULATION is disabled.

This describes WHAT the patch does without providing any context.

> +	if ((IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) ||
> +	    !IS_ENABLED(CONFIG_IA32_EMULATION)) {

I told you before that my brain based compiler complains about your
patches not building with CONFIG_IA32_EMULATION=n. The above still fails
to build.

Aside of that this condition is convoluted and can be simplified to
exactly a simple and understandable

        if (foo)

which is actually the obvious solution to make it compile in all
configurations.

It's not too much asked to flip the config switch which affects the code
you are changing for a test.

> @@ -226,6 +226,13 @@ void __init idt_setup_early_traps(void)
>  void __init idt_setup_traps(void)
>  {
>  	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
> +
> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) {

Ditto.

> +		gate_desc null_desc = {};

Lacks a newline between declaration and code. It's documented to be
required, no?

> +		write_idt_entry(idt_table, IA32_SYSCALL_VECTOR, &null_desc);
> +		clear_bit(IA32_SYSCALL_VECTOR, system_vectors);
> +	}

That aside, I asked you to split IA32_SYSCALL_VECTOR out of def_idts[]
and handle it separately, no? If you disagree with me then reply to my
review first instead of ignoring me silently.

I don't care about you wasting your time, but I very much care about you
wasting my time.

Stop this right now before it becomes a habit.

Thanks,

        tglx
