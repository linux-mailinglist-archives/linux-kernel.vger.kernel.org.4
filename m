Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4563F359
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiLAPLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:11:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F174AF36
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:11:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669907471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNLne/VWext7Yu16r6JUWRUmTMDNOZZ7Wk/3g909dJ8=;
        b=DbIw0rnjB54m2y8dvxt+vusGlBK4YOz5s9A30sLVwmhejkEOZtQRy917zRVC5g6VT4EaMo
        t+FHIoRrqaAkpZzM9DDIxfElWOVmuoSTnGnSquoqbTyOQRS1kIezdwZLs+hJjgm9SA+Hnf
        4Tfo76ArSsCivnNCZCcRAVx3cV9mJB0Xf4w64L82yUBBdDuboet16RiWTsMKdVMwVyHWrY
        0Jzr+tvwh2VRJwlql+/8mteBlfUHdpdR0EGrLlcMXcZs+16er8LdhF5pPvqvQbH0G0PaVu
        11qZiM2LHx3LrzuKucVo/pEOOKy0l+XBirJCZRFVbncU71gGPU5FA+ki9LTQDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669907471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNLne/VWext7Yu16r6JUWRUmTMDNOZZ7Wk/3g909dJ8=;
        b=9GKnKvCIE1xKPGfOtKQnQLQKtoFrDKncspiNfzCa+cWgmKRY1Kg2C62y5xAP2bEIv+q2VF
        zdk7JasHrIU+t4Dw==
To:     Borislav Petkov <bp@alien8.de>,
        Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
In-Reply-To: <Y1l+v3uG7tSUZfd0@zn.tnic>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
 <20220911084711.13694-2-mat.jonczyk@o2.pl> <Y1l+v3uG7tSUZfd0@zn.tnic>
Date:   Thu, 01 Dec 2022 16:11:10 +0100
Message-ID: <871qpjrwfl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26 2022 at 20:38, Borislav Petkov wrote:
> On Sun, Sep 11, 2022 at 10:47:02AM +0200, Mateusz Jo=C5=84czyk wrote:
>> As many current platforms (most modern Intel CPUs and QEMU) have x2APIC
>> present, enable CONFIG_X86_X2APIC by default as it gives performance
>> and functionality benefits.
>
> Can we do that without any detriment to older systems which don't have
> x2APIC?

Can we please adjust to reality and do:

    X86_X2APIC
    bool
    default y if X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)

There is zero reason for having a knob.

Thanks,

        tglx
