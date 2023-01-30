Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB5680CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjA3L5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjA3L5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:57:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366E2FCC4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED08860A25
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3242C4339C;
        Mon, 30 Jan 2023 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675079838;
        bh=Bf8wXn0zRLu9HdaSqycqpB534BIJARXYm1sFG+MUpXA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GSLp284SjuIuW4XWjBOUObAOGJI2q7alFTxsGR7F9z+cZxgWOVcVsZWAGZiSWUvS+
         J00I3RbWhRoEivjtITdrCSpYlnLyAEYWhGBHUPvy9oPAGiDe0eULAVVtFCVSqYLgTK
         olij8y6dfEU8WLnVQImTPg3m8qjysNZdP25H5BUFuItQcNjGlxMD9WQhzpo/7pvUqS
         aBOHUacSkQoEq0MCY4o+aYx1GE/QBgwGz4MScnZI4YN/N5nJSZm3n9K6tGzXMzpJBS
         g5GvOxyDnqwQzJrGdMw/wyKgsgF1eM0HfD9CO/6rRCSCZvyJZoIB0ECCguPDfFAxnB
         IwvyOitQLhmPg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, guoren@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, jrtc27@jrtc27.com, andy.chiu@sifive.com,
        zong.li@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [PATCH -next V3 1/2] riscv: jump_label: Fixup unaligned
 arch_static_branch function
In-Reply-To: <20230126170607.1489141-2-guoren@kernel.org>
References: <20230126170607.1489141-1-guoren@kernel.org>
 <20230126170607.1489141-2-guoren@kernel.org>
Date:   Mon, 30 Jan 2023 12:57:15 +0100
Message-ID: <87357sjkv8.fsf@all.your.base.are.belong.to.us>
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

guoren@kernel.org writes:

> From: Andy Chiu <andy.chiu@sifive.com>
>
> Runtime code patching must be done at a naturally aligned address, or we
> may execute on a partial instruction.
>
> We have encountered problems traced back to static jump functions during
> the test. We switched the tracer randomly for every 1~5 seconds on a
> dual-core QEMU setup and found the kernel sucking at a static branch
> where it jumps to itself.
>
> The reason is that the static branch was 2-byte but not 4-byte aligned.
> Then, the kernel would patch the instruction, either J or NOP, with two
> half-word stores if the machine does not have efficient unaligned
> accesses. Thus, moments exist where half of the NOP mixes with the other
> half of the J when transitioning the branch. In our particular case, on
> a little-endian machine, the upper half of the NOP was mixed with the
> lower part of the J when enabling the branch, resulting in a jump that
> jumped to itself. Conversely, it would result in a HINT instruction when
> disabling the branch, but it might not be observable.
>
> ARM64 does not have this problem since all instructions must be 4-byte
> aligned.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Nice catch! And I guess this is an issue for kprobes as well, no?
I.e. in general replacing 32b insns with an ebreak. This is only valid
for natural aligned 32b insns?

@Guo I don't see the point of doing a series for this, and asking the
maintainers to "pick this patch to stable, and the other for
next". Isn't that just more work for the maintainers/reviewers?


Bj=C3=B6rn
