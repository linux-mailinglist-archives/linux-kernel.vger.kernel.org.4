Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E865B625
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjABSD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjABSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:03:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C4625D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:03:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E40F6106C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691AFC433D2;
        Mon,  2 Jan 2023 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672682599;
        bh=xFB+pqkNVJr5d8mSMRmOujiTSNxhjU4TQhJt9Jg8R8Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nTlYO3nfkttQQtNzmo5st0FF1fLUh3JjCaVhN08ZsFu2/Ar3eRDOzfAvEQFgt7sdV
         1VwVgLYhgywzHybz+qx+w6R3pBQQ+1xBmPecCZEksyOSyU/mqs03PuEAyj36TqyuFQ
         ss6xPo+zvoVXRefp20KH+1Ufo3tZcQ8O9Vv2+7bUqV3SGoNlZny2fZSXbXOpKECPOs
         o/jGZd7b8s0MUGGRqmz/VYLlCulDIq4o+VFIXkQ2rfSod0QNe338OIjxHp+4FjFRGm
         qe+EkEmhta0pUJSsu1TMvsTcURy5os45fvHYRY7oDp/sJWrxmLQLrlV+ZO9+rH88IT
         CenFM5oUu0BTQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 1/9] riscv/kprobe: Prepare the skeleton to implement
 RISCV OPTPROBES feature
In-Reply-To: <20221224114315.850130-2-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-2-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 02 Jan 2023 19:03:17 +0100
Message-ID: <87wn64vmoq.fsf@all.your.base.are.belong.to.us>
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

> From: Liao Chang <liaochang1@huawei.com>
>
> Prepare skeleton to implement optimized kprobe on RISCV, it is consist
> of Makfile, Kconfig and some architecture specific files: kprobe.h and
> opt.c opt.c include some macro, type definition and functions required
> by kprobe framework, opt_trampoline.S provide a piece of assembly code
> template used to construct the detour buffer as the target of long jump
> instruction(s) for each optimzed kprobe.

This is pretty much just reiterating what diff-stat says. Please try to
explain why a certain change is done, instead of what. What is already
in the patch.

> Since the jump range of PC-relative instruction JAL is +/-2M, that is
> too small to reach the detour buffer, hence the foudamental idea to
> address OPTPROBES on RISCV is replace 'EBREAK' with 'AUIPC/JALR'. which
> means it needs to clobber one more instruction beside the kprobe
> instruction, furthermore, RISCV supports hybird RVI and RVC in single
> kernel binary, so in theory a pair of 'AUIPC/JALR' is about to clobber
> 10 bytes(3 RVC and 1 RVI, 2 bytes is padding for alignment) at worst
> case. The second hardsome problem is looking for one integer register as
> the destination of 'AUIPC/JALR' without any side-effect.

There are a number of spelling errors, please use a spellchecker and if
you reference a file (e.g. Makefile), make sure it is correctly spelled
out.

The comments above applies to all the commit messages of this series.


Bj=C3=B6rn
