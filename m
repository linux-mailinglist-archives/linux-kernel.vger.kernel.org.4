Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323DE665D61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjAKOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjAKOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:12:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6C38B4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:12:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d17so15158919wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXt4s2lip+WA/lmUg4T5cJqMM6VlHjVoPy2O6/n25ds=;
        b=owT5Z7YsSyvfkk7SD7GhDMameVdIh1ypm2zj/GA3jXJb+LOitrJuC4Ov5VDYJGa2MD
         34NiU/BYRVlU9w/pA+AlPEU7FcK/z0WTvFYxvsIqozVzAp/uIoDzpwzvPkjIyMmLdTgC
         2wX1PdfP2vg7wLHUcgMyRDb9cdysZ84IST1ET7Dzd64zYIEgidCgF6hqJyItyaHUMU9O
         K3mfY2hx7xApx07Hp2WO945MYfaWodKR03UbBPkaF1Qwn5/YJqNU14zGm20G8hxEcoYC
         p1xeYsChi+DdE/pve3GDeIW310+PkM/qhL3CHDfBtGAInDI/uaHxEWePqbKAU9cVDLI7
         xuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXt4s2lip+WA/lmUg4T5cJqMM6VlHjVoPy2O6/n25ds=;
        b=bwaoGJGtVGZd3VEgG7k2s7zNOPsYO+igcJtoFLYHl65FB1YJnobk5KWQTMhCJaH6Oh
         +qePiNKGozeXC6bY5O3KGiQRUQ3BQUA6JXoVxKRrUYem9Q2YX4TJfGhFTISfQ1PAW/dD
         JqowfKLU6fPsK+8vWWluwGihauq5KNMeurIlI4nIpvwJFP63Tczbuh/gumZd97+LoYp7
         H0ffKnaiKuIO96QRsxIBYGAlXzAg5qpLiH3mNsPzf5OCau01V2i+B6L6sf4GhSML55FB
         MPSQP+DwNpAM+IoGjjgRGr/LLDB5RTkgUEYNr0oTpW/sJwcVZsBYVnOFCArp6jf6j7JN
         cPhQ==
X-Gm-Message-State: AFqh2kp2YJ370YaEfhLJMEK7HaSgADEbN6BI1tufPjOSTI+O877MkBwM
        bGMGIsFIHF4E8hILAeqSF3c/LA==
X-Google-Smtp-Source: AMrXdXsxKFj7ZVc3xTe+S4UTkutbibA2rD1cSKyHd0bYG1cVbu9ZIHYY5v8GsFOu+jJHXX5CTsVMrA==
X-Received: by 2002:adf:f20a:0:b0:2ba:bd95:e3af with SMTP id p10-20020adff20a000000b002babd95e3afmr12695642wro.47.1673446345000;
        Wed, 11 Jan 2023 06:12:25 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id k9-20020adfd229000000b002bdbef07f7csm2867288wrh.50.2023.01.11.06.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 06:12:24 -0800 (PST)
Date:   Wed, 11 Jan 2023 15:12:23 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 10/13] riscv: alternative: patch alternatives in the
 vDSO
Message-ID: <20230111141223.mib46x54au3n7xpq@orel>
References: <20221204174632.3677-1-jszhang@kernel.org>
 <20221204174632.3677-11-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204174632.3677-11-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:46:29AM +0800, Jisheng Zhang wrote:
> Make it possible to use alternatives in the vDSO, so that better
> implementations can be used if possible.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/vdso.h     |  4 ++++
>  arch/riscv/kernel/alternative.c   | 25 +++++++++++++++++++++++++
>  arch/riscv/kernel/vdso.c          |  5 -----
>  arch/riscv/kernel/vdso/vdso.lds.S |  7 +++++++
>  4 files changed, 36 insertions(+), 5 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
