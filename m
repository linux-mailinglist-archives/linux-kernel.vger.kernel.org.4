Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E06866DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjBAN37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjBAN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:29:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217463874
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:29:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A21046179F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B988EC433EF;
        Wed,  1 Feb 2023 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258160;
        bh=JAkFMc2dp9aZIGy+X9W+0UNRWy7+puxfrgWYGUKvqE4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WKU6JBJGVX831/YeO/vIYsFoeoansxJf7b8w4H9k88wixsW4a+ZvxfWZfEUPVbNhr
         OKHeNYRnuU3FdrkiRLgpSFU0y2bw89SGaykTQdwiEl1bako/8BQEmSrEuM8zwSua9G
         1RzCzjSQgugchSWQZ9xFwvXYCwpd+7HQK6UhCGYxrdNmcBh/YYsYxaR/vqwxsSmxBT
         5d+6am272vW6rpWOr6bBMi++KUCfwOrN7sMrQ9/xHYPhjtjcDeDEnV2f2+SDuaqc9p
         0MccYrRNUFLXxlltVf/1bzp/LHIRfPwU8fteA3wPgDnhfi6fgLRxsQFhvvDTKTSFNu
         qJpHQlaYwirZQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v6 00/13] Add OPTPROBES feature on RISCV
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:29:17 +0100
Message-ID: <87zg9xtsya.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> Add jump optimization support for RISC-V.
>
> Replaces ebreak instructions used by normal kprobes with an AUIPC/JALR
> instruction pair with the aim of suppressing the probe-hit overhead.
>
> All known optprobe-capable RISC architectures have been using a single
> jump or branch instructions while this patch chooses not. RISC-V has a
> quite limited jump range (4KB or 2MB) for both its branch and jump
> instructions, which prevent optimizations from supporting probes that
> spread all over the kernel.
>
> AUIPC/JALR instruction pair is introduced with a much wider jump range
> (4GB), where AUIPC loads the upper 12 bits to a free register and JALR
> Deaconappends the lower 20 bits to form a 32 bits immediate. Note that
> returns from probe handler require another free register. As kprobes
> can appear almost anywhere inside the kernel, the free register should
> be found generically, not depending on calling convention or any other
> regulations.
>
> The algorithm for finding the free register is inspired by the register
> renaming in modern processors. From the perspective of register
> renaming, a register could be represented as two different registers if
> two neighbor instructions both write to it but no one ever reads it.
> Extending this fact, a register is considered to be free if there is no
> read before its next write in the execution flow. We are free to change
> its value without interfering normal execution.
>
> Static analysis shows that 51% of instructions of the kernel (default
> config) is capable of being replaced i.e. one free register can be found
> at both the start and end of replaced instruction pairs while the
> replaced instructions can be directly executed. We also made an
> efficiency test on Gem 5 RISCV which shows a more than 5x speedup on=20
> breakpoint-based implementation.
>
> Contribution:
> Chen Guokai invents the algorithm for searching free register, evaluate
> the ratio of optimization, the basic function support RVI kernel binary.
> Liao Chang adds the support for hybrid RVI and RVC kernel binary, fix
> some bugs with different kernel configure, refactor out the entire
> feature into some individual patches.

Thank you for continuing to work on this series! I took it for a spin,
and it worked nicely on my QEMU setup.

It would be nice to have it run on some *actual* hardware as well. :-)

I have some additional comments on the series, but I'll add those to the
relevant patch. It's mostly minor things!


Bj=C3=B6rn
