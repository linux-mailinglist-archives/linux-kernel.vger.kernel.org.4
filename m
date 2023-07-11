Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B88A74F6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGKRRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGKRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:17:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D13A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:17:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so6030690f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689095826; x=1691687826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKFZ1fsOWMTwkYmCF5xZHlaiZPqOrQjG51XkXG8xsuk=;
        b=D5y3LWruBfCLfjEqzVCNKUET3kISp5tN0QhzQ0iP6goxPbl+uI/RYpL2N0LVcglj2X
         0lEe3icLlxNx4dmUGdWBogGMZxmkMerhMKo2z8Taa3yXYB3F57C+Q2sZZ9VXeCqZ1vq3
         IfL9lqdd5K5jEEB9K4m63l4Kg4qdSuit0mNh1SO1qcpywK/UyGuuA0teNwWRy6oTR7Gs
         wLcYjMziDvFC8xmLXoA0agYIot8X/qnhT+7xau9EO5vMz5j9yHLUmsY6lbF5hdrTb5mJ
         DUY5ssopkfJz2b5PCInx3UMPHhbXj3vW8qRufrU2DYx+0RSqiK1S21dNcjePJd3seafz
         PqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689095826; x=1691687826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKFZ1fsOWMTwkYmCF5xZHlaiZPqOrQjG51XkXG8xsuk=;
        b=ggI/oj7NMg4A6RF1ZFtM41zMLubyaVaq0QufAU5lMd7QWAPFcg222mvU4wxsYUbbeg
         r55JLEC297IOUUKySszR4fmRRpA3aEFaYJkGXT1wAfCES4j1ZdSUMQOAVVscl9v3P/Zw
         aduC/ZafToysdjRioZLjL5vO5rWOtMjD1p9lW4cu2mpYNeCHNPGXoehBOj3smzuXNw3N
         k4yOHhgJDlZ/hxMLokFLyHBDUYbb7XO7tIl0joxhX6G4cSidSZRA2sBOg37V10YPM/FC
         8feWEWHgpYvZBO/anMarrexwMI1MFPWqH2jtV5JsM+GBKzpUOiX03Umnhor/nJCYN1Qk
         ww/Q==
X-Gm-Message-State: ABy/qLaX1txmZt2N3Qv2QNrmpfsicsgMuCS8pHBqzkBpCdUxt4Txo4N2
        KpZf62/ee7bbI2sa+367wjf0BA==
X-Google-Smtp-Source: APBJJlHP0y7SeY1nrbv57HJV7f8WoCTfGdEzwRBf4kmtBVsQ6FUsVRpK3RM24Y5TlmLXsB9e6E8P0w==
X-Received: by 2002:a05:6000:150:b0:306:46c4:d313 with SMTP id r16-20020a056000015000b0030646c4d313mr13962528wrx.28.1689095825620;
        Tue, 11 Jul 2023 10:17:05 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id d3-20020a5d6443000000b0031433443265sm2783203wrw.53.2023.07.11.10.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:17:05 -0700 (PDT)
Date:   Tue, 11 Jul 2023 19:17:02 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Heiko Stuebner <heiko.stuebner@vrull.eu>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] RISC-V: Implement archrandom when Zkr is available
Message-ID: <ZK2OjvchhqzEKZWR@vermeer>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-5-sameo@rivosinc.com>
 <3566075.R56niFO833@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3566075.R56niFO833@phil>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Sun, Jul 09, 2023 at 04:06:16PM +0200, Heiko Stuebner wrote:
> Am Sonntag, 9. Juli 2023, 13:55:46 CEST schrieb Samuel Ortiz:
> > The Zkr extension is ratified and provides 16 bits of entropy seed when
> > reading the SEED CSR.
> > 
> > We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> > that CSR and filling an unsigned long with valid entropy bits.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> > ---
> 
> > +static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
> > +{
> > +	if (!max_longs)
> > +		return 0;
> > +
> > +	/*
> > +	 * If Zkr is supported and csr_seed_long succeeds, we return one long
> > +	 * worth of entropy.
> > +	 */
> > +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_long(v))
> 
> While this whole thing looks really nice, I don't think you can only
> check the ZKR existence though.
> 
> To access the seed csr from supervisor-mode, it looks like the SSEED
> bit in the mseccfg register also needs to be set by firmware.
> And in the kernel we will likely need to check this setting somehow
> before enabling access.

We can't check it as msseccfg is an M-mode only CSR. While reviewing v2
of this patchset, Stephen suggested to either document the SSEED
requirement with the dt-bindings documentation, use the SBI FWFEATURE
extension to ask firmware to set mseecfg properly, or trap seed access
and feed the caller with a virtual entropy source.
I'd like to go with the second proposed approach (FWFEATURE) but that
requires the corresponding pending patch to be merged first. So for now,
I will only document the SSEED requirement when passing the Zkr
extension, so that we at least have a contract definition for firmwares
that enable Zkr through DT. When they do, they're required to at least
set SSEED in MSSECFG.

I have a couple of pending patches ([1],[2]) related to that, so that an
OpenSBI+qemu+linux combination works as expected when enabling Zkr. I am
going to submit them upstream as well.

Cheers,
Samuel.

[1] https://github.com/qemu/qemu/commit/2a146057099ada946bf4a9c2e355a5a290c23c80
[2] https://github.com/riscv-software-src/opensbi/pull/315
