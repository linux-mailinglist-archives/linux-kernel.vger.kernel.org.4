Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A7640642
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiLBL7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLBL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:59:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E4D9D2FC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:59:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669982376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuTxsHaX4pa8PYtAzRpn9Ilwnb3Tx9DNZ8XPxnFRgCQ=;
        b=zSlJAiWabZ/MW0paX2M/vZelt8JK7y5RcEMdMjWFUho3B/TFC64NfVpSJ8mSqlmD0+Bwsq
        L0x603Q1gXnujeN11DD+ZAcBe0xbL3Tkp9UwmolpHJ5W0NYd7bmWUpfBKTbldhyhFwZBzt
        QWzVsd14FYWaEp4iTe7WQwG8zf+zp4zWqNJk53O3dWBLLUShN4IHqU5m439d3J315xYjgR
        PJEMRsVNiOtWEeoIhVjTy4j5awo0vm2zvuX4RDAsyY94DNxSTW6QkfoxAfYbKibTVQr/oT
        KmdSt7HkOp4Nf5jWGClOItmR4krg8NcjQ+iUmwzLa9Xx3dTDPqzq497jVs24Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669982376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuTxsHaX4pa8PYtAzRpn9Ilwnb3Tx9DNZ8XPxnFRgCQ=;
        b=TAQFXhInn7wLSJP2Coi1IlaWl5AspRGCeIR5ymKiugQCZJMupdRJiXoim4T5WIctUoVM9p
        J7BWGYBZ9jOkqJBw==
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com
Subject: Re: [PATCH v2] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
In-Reply-To: <20221011113803.956808-1-linmiaohe@huawei.com>
References: <20221011113803.956808-1-linmiaohe@huawei.com>
Date:   Fri, 02 Dec 2022 12:59:36 +0100
Message-ID: <87y1rqow2f.ffs@tglx>
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

On Tue, Oct 11 2022 at 19:38, Miaohe Lin wrote:
> Due to the explicit 'noinline' GCC-7.3 is not able to optimize away the
> argument setup of:
>
> 	apply_ibt_endbr(__ibt_endbr_seal, __ibt_enbr_seal_end);
>
> even when X86_KERNEL_IBT=n and the function is an empty stub which leads
> to link errors due to missing __ibt_endbr_seal* symbols like below:
>
> ld: arch/x86/kernel/alternative.o: in function
> `alternative_instructions':
> alternative.c:(.init.text+0x15d): undefined reference to
> `__ibt_endbr_seal_end'
> ld: alternative.c:(.init.text+0x164): undefined reference to
> `__ibt_endbr_seal'

This is incomplete because the noinline is only visible within
alternative.c, but there is another caller in module.c

This needs an inline stub in the header to be correct.

Thanks,

        tglx
