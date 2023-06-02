Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0F71FE12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjFBJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFBJlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77416C0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9B964C7D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA543C433EF;
        Fri,  2 Jun 2023 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685698876;
        bh=/KSfwY3Ual0+wljvgcQlMt2JAgEfVGw+2YZ7Lc+KauY=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=UDLKmlUAbmsOJHDUcz5fnpZTTJXa+Dkfr8EZpIQJkiP0PFwaHjIHlsfPjtVSahPyO
         ybmlER5Np6+I53qyaUKKbu7ZpRfSepvfS2mu6y54NWnJzRhe+5DZNie8mk2D02xrPE
         25gt8d46UomGELcEcrEEYQVHHrkhNY0IyblBiLp57higroyXJ5FWyXjgyRfA0rzLfN
         7XMTuEWZV5Helndap57dn4EjfxkvKIrwhK36B+Z2BMRtz5igg0RlfIdiBVfF9W0u4d
         XnMPDODBOYzTsGxznoFfQ9BgWNZgH5+0HI2jSONP6szg5K5GaW7rL3F3KqE6ku/uEx
         vMntFNYBCgNFg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com
Subject: Re: [PATCH v3] riscv: fix kprobe __user string arg print fault issue
In-Reply-To: <c9b6939c-f072-c4aa-b721-3cd0b2fd5635@huawei.com>
References: <20230504072910.3742842-1-ruanjinjie@huawei.com>
 <c9b6939c-f072-c4aa-b721-3cd0b2fd5635@huawei.com>
Date:   Fri, 02 Jun 2023 11:41:13 +0200
Message-ID: <87cz2ei4li.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ruan Jinjie <ruanjinjie@huawei.com> writes:

> Ping.

Maybe it's not clear *why* we need
ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE on RISC-V?

ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE is used in the kernel to
determine what "memory access" function to use, e.g.

  | #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
  |         if ((unsigned long)str_val < TASK_SIZE)
  |             ret =3D strncpy_from_user_nofault(str_field, str_val, STR_V=
AR_LEN_MAX);
  |         else
  | #endif
  |             ret =3D strncpy_from_kernel_nofault(str_field, str_val, STR=
_VAR_LEN_MAX);

RISC-V makes use of the SUM bit [1], which requires the kernel flips a
bit explicitly to touch user memory, so it's important to use the
correct access function.

What this means, is that if
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE is *not* defined for RV
kernels, the copy_from_kernel will fault (as Jinjie points out in the
commit message).

The fixes tag should be when Daniel Borkmann introduced the config -- or
that makes sense from a backport perspective.

Maybe Palmer can add a lore link to this post, and the following
fixes-tag

  Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs=
 where they work")

when applying?


Bj=C3=B6rn

[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/supervisor.adoc=
?plain=3D1#L118
