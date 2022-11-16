Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF05D62BD03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKPMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiKPMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:05:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061AA191;
        Wed, 16 Nov 2022 03:58:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668599922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dQYqPhhovrBxLiBx5JQlSjwam1Zc+8q5jOQGEC5PI4=;
        b=W/buQpAagstSpFIH+iUt9kP7nJncLHprXbFWPq6EU4lF2qz3iqYoz8t3D9MQC/7nu7ntcv
        9m1+zsGQL/92SozbsBE8BulZPI9bJJTdlXcnP57cFpf5n7y9lyY4Jz2/e2agqkCSh9w4nO
        8s7ktsYn1Y6lCbh3QDb35kbvwi2S4rvd6DL1XuGRCM+K7Awj1iCp8lVDOeH1bgEYm8SLbw
        /vxKB7a42Mql7pqzAbMumOlY+32n+2yusSuaAHB4V/abATIa3YVGgza4YXOLug9dDOmLkc
        ZlpC2COInhp6SF7Nb08qLlXm6ZEV6plgJm0B4g20OQBQ1OYpYASrn76pgRKIrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668599922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dQYqPhhovrBxLiBx5JQlSjwam1Zc+8q5jOQGEC5PI4=;
        b=tXaZ1uoECQLine1j4fGI/PvpqWQkOMUmOFVSHCf4PX6hj9/+majTQ8eO76WnVcWMdm2lyJ
        p1qszXH6JwOjFzBg==
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        jarkko@kernel.org, ira.weiny@intel.com,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
In-Reply-To: <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com>
References: <20221115161627.4169428-1-kristen@linux.intel.com>
 <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com>
Date:   Wed, 16 Nov 2022 12:58:41 +0100
Message-ID: <87cz9nqff2.ffs@tglx>
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

On Wed, Nov 16 2022 at 11:16, Fabio M. De Francesco wrote:
> On marted=C3=AC 15 novembre 2022 17:16:26 CET Kristen Carlson Accardi wro=
te:
>> The use of kmap_atomic() in the SGX code was not an explicit design
>> choice to disable page faults or preemption, and there is no compelling
>> design reason to using kmap_atomic() vs. kmap_local_page().
>
> This is at the core of the reasons why you are converting, that is to avo=
id
> the potential overhead (in 32 bit architectures) of switching in atomic
> context where it is not required.

No. The point is that kmap_atomic() is an historical artifact of 32bit
HIGHMEM support.

The back then chosen implementation was to disable preemption and
pagefaults and use a temporary per CPU mapping. Disabling preemption was
required to protect the temporary mapping against a context switch.

Disabling pagefaults was an implicit side effect of disabling
preemption. The separation of preempt_disable() and pagefault_disable()
happened way later.

On 64bit and on 32bit systems with CONFIG_HIGHMEM=3Dn this is not required
at all because the pages are already in the direct map.

That means support for 32bit highmem forces code to accomodate with the
preemption disabled section, where in the most cases this is absolutely
not required. That results often in suboptimal and horrible code:

again:
    kmap_atomic();
    remaining =3D copy_to_user_inatomic();
    kunmap_atomic();
    if (remaining) {
    	if (try_to_handle_fault())
            goto again;
        ret =3D -EFAULT;
    }

instead of:

    kmap_local();
    ret =3D copy_to_user();
    kunmap_local();
=20=20=20=20
It obsiously does not allow to sleep or take sleeping locks in the
kmap_atomic() section which puts further restrictions on code just to
accomodate 32bit highmem.

So a few years ago we implemented kmap_local() and related interfaces to
replace kmap_atomic() completely, but we could not do a scripted
wholesale conversion because there are a few code pathes which rely on
the implicit preemption disable and of course something like the above
monstrosity needs manual conversion.

kmap_local() puts a penalty exclusively on 32bit highmem systems. The
temporary mapping is still strict per CPU, which is guaranteed by an
implicit migrate_disable(), and it is context switched in case of
[un]voluntary scheduling.

On plain 32bit and 64bit systems kmap_local() is pretty much a NOP. All
it does is to return the page address. It does not disable migration in
that case either. kunmap_local() is a complete NOP.

The goal is to eliminate _all_ use cases of kmap_atomic*() and replace
them with kmap_local*(). This is a prerequisite for system protection
keys and other things.

Thanks,

        tglx








