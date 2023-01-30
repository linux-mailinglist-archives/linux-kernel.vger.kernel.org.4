Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49A681709
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjA3Q4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3Q4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:56:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA493D0A4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE8B5B81269
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1C4C4339B;
        Mon, 30 Jan 2023 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675097806;
        bh=ewr/oDOz3QgnkOdhjAWLANR8/++xZfNx9fetWwn02wc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TnotIDIjxyAKloXOFrfY+5Fs6kkrG3ajpcmyy+hOzoHjngt/WZNthH56Ls87DKMbJ
         eJJAOT3ykQ+ykv0nnV3mmOnT7rs0daNwDkYhnBYKE8qALswYYIzaAXGJBegQjXN9SZ
         f28Is6DeoQ8goSMuJ//ZVIoZmCPJKDCA7hP91JyGfqnIpz1WV4OtDJWY0rdub5Rm5H
         r8yoeyykNsUmXFuu7SUmKVl2EI9LXRec8RDwLTUyxzzJJlSeZwvJn+IxadeJg3RzwX
         I1ugAYrwcGpu1vj2pXdUXUqHC6rYoxNXwXrl9CXtD5aYNB3v/IfUWeehutgI/svBmj
         WR2WAMqElDMYw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Guo Ren <guoren@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
Date:   Mon, 30 Jan 2023 17:56:43 +0100
Message-ID: <87edrc2c6s.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

>> ...and stop_machine() with !PREEMPTION is broken as well, when you're
>> replacing multiple instructions (see Mark's post at [1]). The
>> stop_machine() dance might work when you're replacing *one* instruction,
>> not multiple as in the RISC-V case. I'll expand on this in a comment in
>> the OPTPROBES v6 series.
>
> Just to clarify, my comments in [1] were assuming that stop_machine() was=
 not
> used, in which case there is a problem with or without PREEMPTION.
>
> I believe that when using stop_machine(), the !PREEMPTION case is fine, s=
ince
> stop_machine() schedules work rather than running work in IRQ context on =
the
> back of an IPI, so no CPUs should be mid-sequnce during the patching, and=
 it's
> not possible for there to be threads which are preempted mid-sequence.

TIL! stop_cpus() highlights that very nicely. Thanks for clearing that
out! That's good news; That means that this fix [4] should go in.

> That all said, IIUC optprobes is going to disappear once fprobe is ready
> everywhere, so that might be moot.

Yes (However, the stop_machine()/!PREEMPTION issue was with ftrace).


Bj=C3=B6rn

[4] https://lore.kernel.org/lkml/20230107133549.4192639-2-guoren@kernel.org/
