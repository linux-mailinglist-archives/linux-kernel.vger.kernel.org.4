Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7F72633E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbjFGOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjFGOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:49:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBABD1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:49:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686149342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUaBfTcHId7JKM2e6tJONQCWuwAhrRrkjDCJTXnEVkk=;
        b=yEAC4l6yy47HXqtcoPCkiS+uu0K9giLzeY/Og33R3h1xiIFZCE3JfQNrk1HjyCbJT72mLE
        JwmSeKyzqeyhwG1xrDzlYrj8F5ErKgqUBHiX7MoMUIHwM4KB7pjueVVtUaN48yoO544WSE
        Zxws2ui0t6CTle3lO8asnM17jZ7zFdCAYN7danFx6iM2D372/7DTaUwU55tpIDrHmlNddY
        EI+hTa99vbij14R7snY/09Q04fQlfntlS1DqP7EOXiQrQkfOlfrNHjGp3/FHrTV26hy9C2
        9Ff+e2Nji56DRVvPvGv782FZCYUfR2vg/KE8cgoRgx8nlDVwO66IaLdiUq501w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686149342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUaBfTcHId7JKM2e6tJONQCWuwAhrRrkjDCJTXnEVkk=;
        b=L3DEJLNv6lIo0SMdrux97AA9yNtc9HI1bqULFSo8gCL5AGxFZJmc5f8Aarm04qNnoIDgND
        2lS0ra00zw0D5RCw==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if
 ia32_disabled is passed
In-Reply-To: <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com>
Date:   Wed, 07 Jun 2023 16:49:01 +0200
Message-ID: <87a5xbjpk2.ffs@tglx>
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

On Wed, Jun 07 2023 at 16:38, Nikolay Borisov wrote:
> On 7.06.23 =D0=B3. 15:53 =D1=87., Thomas Gleixner wrote:
>> So why would boottime disabling of IA32_EMULATION affect X32_ABI in any
>> way?
>
> In this case it shouldn't affect it and the check should be
>
> ((elf_check_arch_ia32(x) && !ia32_disabled) ||=20
> (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_64)).

Correct.

>>    1) What is the justification for setting the 'present' bit of
>>       GDT_ENTRY_DEFAULT_USER32_CS to 0?
>
> This was something which was suggested by Andrew Cooper on irc, to my=20
> understanding the idea is that by not having a 32bit capable descriptor=20
> it's impossible to run a 32bit code.

Right, but that's a completely separate change. If it is agreed on then
it needs to be consistent and not depend on this command line parameter.

> I guess the scenario where it might be relevant if someone starts a
> 64bit process and with inline assembly tries to run 32bit code
> somehow, though it might be a far fetched example and also the fact
> that the compat_elf_check_arch() forbids loading 32bit processes might
> be sufficient.

Guesswork is not helpful. Facts matter.

Fact is that today a 64bit application can do a far jump of far call
into a 32bit code segment based on the default descriptors or by setting
them up via LDT. That 32bit code obviously can't do compat syscalls if
IA32_EMULATION is disabled, but other than that it just works.

Whether that makes sense or not is a completely different question.

Ergo fact is that clearing the present bit is a user space visible
change, which can't be done nilly willy and burried into a patch
which is about making CONFIG_IA32_EMULATION a boot time switch.

Thanks,

        tglx
