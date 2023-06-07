Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B435172601F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbjFGM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbjFGM4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:56:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82A10DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:55:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686142552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO4Cr3xOuSS4p6uSUWgjKuKXxBCfM0OB3C5OihkHED4=;
        b=vmArIk+AJKtb3HxDDiMaYwdaC++iJozeqxwax4UpIG4VX/LDEMcuG+J8jj3XpbXgLQhUH0
        W8irNFkM0qmmQxOUuqdjNEK4f6kLZYLCPbsIo4RMftLAkP1VSOQh9la/iCdo0eFXrAfc4t
        sizdM/RYlU4nU4lnCaIF29fTyfVZnQkJkhjFr+FsolgwIKa1dYOW3uiNdl+RTp1XSsQ+Ov
        Pe6wbOcVO3DMy/J/ncZ9/3vN4JkoD6ru3Jqr8HWfTq0Ns9H6XXku4J5C63VR6b8ypK17IC
        nJbLYXm7KQ+LQpTcKRVaX9LoIik5LSdnl5LCSXCGGWs4lnXTxT2kJLKlzhHWgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686142552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO4Cr3xOuSS4p6uSUWgjKuKXxBCfM0OB3C5OihkHED4=;
        b=yzOZGXRXTxAhDJ8fWqHc/m5At4P9gYrMf11BNvPDv0s5maeBU6NspdPI3/jJxjrBaKoCQk
        eLrUG8dKK2uxy3AQ==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <87legvjxat.ffs@tglx>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
Date:   Wed, 07 Jun 2023 14:55:51 +0200
Message-ID: <87cz27juso.ffs@tglx>
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

On Wed, Jun 07 2023 at 14:01, Thomas Gleixner wrote:
> On Wed, Jun 07 2023 at 10:29, Nikolay Borisov wrote:
>> @@ -2368,4 +2373,7 @@ void arch_smt_update(void)
>>  	cpu_bugs_smt_update();
>>  	/* Check whether IPI broadcasting can be enabled */
>>  	apic_smt_update();
>> +	if (ia32_disabled)
>> +		on_each_cpu(remove_user32cs_from_gdt, NULL, 1);

My brain based compiler tells me, that this breaks the 32bit build and
the 64bit build with CONFIG_IA32_EMULATION=n. I'm pretty confident that
a real compiler will agree.


