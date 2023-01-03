Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5561765BC34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjACI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjACI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:27:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC7FDF90
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:27:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37317CE104A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2705BC433D2;
        Tue,  3 Jan 2023 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672734432;
        bh=/7Ir17x6sUBFne3FTmiO4fvH6wQq9v5ncXOlJYzqp9E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sw0t0e+EuOz/wt6XBY5yMn2qzHsAeQsHZt8siJHdPdhAhemMd83atmAH402D7z2Qv
         /jdqA0tliYvhQK8eDsdpuf5iZQjYftZmwDEE0wVyomdaqOEgd9XZLAiLXcBYPc1Pup
         G1dZ3B08kC3STtdrPiA/qk5ATISJKIlTvxYLoC1SkAJK1UCytFzHyrpu0IePWmANVc
         ks/mz1C+caJednsN+c7wsGIMSQhOnTwkbwGCDa5Mpru+LC9Kxxw1eqEdnTZ2RUYC4E
         W8vhl2wKBRNZNCecXrpJ7L1kxHMOJ+aoIGQYv1EMXcb2r6RtNB7qbkEp17hCaZpMly
         YNP6rvjXsRlIA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v5 3/9] riscv/kprobe: Prepare the skeleton to prepare
 optimized kprobe
In-Reply-To: <20221224114315.850130-4-chenguokai17@mails.ucas.ac.cn>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-4-chenguokai17@mails.ucas.ac.cn>
Date:   Tue, 03 Jan 2023 09:27:09 +0100
Message-ID: <87358sxbtu.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
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

> diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
> index 56c8a227c857..a4271e6033ba 100644
> --- a/arch/riscv/kernel/probes/opt.c
> +++ b/arch/riscv/kernel/probes/opt.c
> @@ -10,6 +10,54 @@
>  
>  #include <linux/kprobes.h>
>  #include <asm/kprobes.h>
> +#include <asm/patch.h>
> +
> +static inline int in_auipc_jalr_range(long val)

Leave "inline" out; Let the compiler decide.
