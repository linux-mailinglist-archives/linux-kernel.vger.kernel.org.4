Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65A06866EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBANar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjBANaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:30:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C165ECE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6AC6B82184
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB4AC433D2;
        Wed,  1 Feb 2023 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258204;
        bh=PDRhcGJ17Tvv0fPAUYuSJW7rVUzUKearobtYgs9at/A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pAatRhSGMokeGNVuQJGZ/boTlD0T2LGuzdJOv8rZSmG4QFGAETe9dW4CL/5uqX1tf
         hiRntJ9OyEP63OdrKLI6KDbSVtG92Raz+N9mboJgHl8s2TExUOpVQSrqFYIUbCS4kD
         kl0NChOBUxSId6xbchT7g5mhstI1LuaRZ1wRDBKmefzp/JQkkofF4vioCEVDmN8uis
         ApkXnWjUJYiRRzCiaY/KSNcrxTFC1BC7Tf7IiirCK0B3ShUTDYOFwpA87MYn0ANbEQ
         E5Ceioh9LdJgQKlgQcv45liEpDv2xEfVOrTZ4rrUPaRa9bL6C5rfZJ92oeE0Hece1M
         WsO8Zd8qtAI0Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v6 06/13] riscv/kprobe: Add code to check if kprobe can
 be optimized
In-Reply-To: <20230127130541.1250865-7-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-7-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:30:01 +0100
Message-ID: <87wn51tsx2.fsf@all.your.base.are.belong.to.us>
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

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaochang1@huawei.com>
>
> For the RVI and RVC hybrid encoding kernel, although AUIPC/JALR just
> occupy 8 bytes space, the patched code is 10 bytes at the worst case
> to ensure no RVI is truncated, so to check if kprobe satisfies the
> requirement of jump optimization, it has to find out an instruction
> window large enough to patch AUIPC/JALR(and padding C.NOP), and ensure
> no instruction nearby jumps into the patching window.
>
> Besides that, this series does not support the simulation of pc-relative
> instruction in optprobe handler yet, so the patching window should not
> includes pc-relative instruction.
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
