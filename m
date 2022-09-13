Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179885B6C49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiIMLTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiIMLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:19:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EEF248EA;
        Tue, 13 Sep 2022 04:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36BD46142A;
        Tue, 13 Sep 2022 11:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC9C433D6;
        Tue, 13 Sep 2022 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663067954;
        bh=8WL+2ChhNqJlCeEkSghkmVAikI1JBjjo/JWZKZfMn+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UhfEBLtkgUc3lrz38hjnenMo+Rg51QOM1iTk1lKYeEgONVhVxyeH3CGOrJw68hTV6
         7jHgezmYrca3LZj1v+4hhN791suCz3UG9K9vWr4AsXS8+NGkB++3IVcLjEfr/OhNj6
         1DsTUc6SUW31x79tpKfQbuU5YMehEz8dafiHWM01nVwvKRPlzazhtlJbJxkotBnNYV
         rBpHAmzgoUsvAcjspfavQ4X6fhp31cH6AVI6kKTsw14N2zZKnCIYrbm3WsuzNlzGN3
         R9uNKDAjHumn5p9xb/T6kR2qfrskiGYaFTT+iCy2vrXySykOI/RxJ/3RC04WV2Qx5Q
         tBP94Ih85TpVg==
Date:   Tue, 13 Sep 2022 20:19:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH V2 0/3] kprobe: Optimize the performance of patching ss
Message-Id: <20220913201909.2c7e38a40e719461e3c19b12@kernel.org>
In-Reply-To: <20220913033454.104519-1-liaochang1@huawei.com>
References: <20220913033454.104519-1-liaochang1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 11:34:51 +0800
Liao Chang <liaochang1@huawei.com> wrote:

> Single-step slot would not be used until kprobe is enabled, that means
> no race condition occurs on it under SMP, hence it is safe to pacth ss
> slot without stopping machine.

All these patches look good to me, since single-step slot must not
be executed until it is prepared.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
for this series.

But I need Ack by each architecture maintainer.

Thank you,

> 
> v2:
> Backport riscv patch to cksy and arm64.
> 
> Liao Chang (3):
>   riscv/kprobe: Optimize the performance of patching single-step slot
>   csky/kprobe: Optimize the performance of patching single-step slot
>   arm64/kprobe: Optimize the performance of patching single-step slot
> 
>  arch/arm64/kernel/probes/kprobes.c | 5 ++---
>  arch/csky/kernel/probes/kprobes.c  | 6 +++++-
>  arch/riscv/kernel/probes/kprobes.c | 8 +++++---
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
