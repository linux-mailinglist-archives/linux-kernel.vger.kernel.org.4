Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207D66443D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjAJPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjAJPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:11:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB5F49154;
        Tue, 10 Jan 2023 07:11:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2AC461779;
        Tue, 10 Jan 2023 15:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B7C433EF;
        Tue, 10 Jan 2023 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673363488;
        bh=uKrtRn6CDrdTBnWrc0AschRz5jiayfkSvYCIjkppPHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdF0lCsEFYZpu4mxGFlTO0ahbX8LHqTV7NEYRJEBBh+C2qhCkIwgCoR/x4C9avokB
         3ss3e/Q1hq3fAN7hq4OS2m91Sm+jMc78d2yAv4KL73z8Ml/7zVqwg8H8K9WW0afZsE
         3HvXIxNn9QVb2rAhneAxn8MTA9hnAf6KGlmvCAis/JuQ5/1OBfs7ioJecEKspWjF+n
         87x8wx8RgGnqA+nJA+k5JFPxlcuuRaTm5AX+4XO3IKqkvcxC37NRn/lIOxnxn5/dsj
         oO/Z7sGXLoaO7w2rss9wtYhrUyVikTEslbYoeamv8Hwkb2+ZUwMXRY67UtYNU8TWOd
         zrMWLsyc2vMWQ==
Date:   Tue, 10 Jan 2023 15:11:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using
 function pointers for cache management
Message-ID: <20230110151119.GA9436@willie-the-truck>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
 <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
 <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com>
 <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com>
 <20230110070144.GG10289@lst.de>
 <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:03:06PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 10, 2023, at 08:01, Christoph Hellwig wrote:
> > On Mon, Jan 09, 2023 at 01:59:12PM +0100, Arnd Bergmann wrote:
> >> I had another look at the arm64 side, which (like the zicbom
> >> variant) uses 'clean' on dma_sync_single_for_device(DMA_FROM_DEVICE),
> >> as that has changed not that long ago, see
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c50f11c6196f45c92ca48b16a5071615d4ae0572
> >
> > which IIRC has been reverted recently.
> 
> To clarify: I was looking at arch_sync_dma_for_device(), which
> changed from 'invalidate' to 'clean' last June in commit
> c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers
> at start of DMA transfer"). I don't see  a revert for that.
> 
> The one that was reverted recently is arch_dma_prep_coherent, which
> was changed and reverted in
> 
> c44094eee32 Aug 23 2022 flush->clean
> b7d9aae4048 Dec 6  2022 clean->flush
> 
> I'm primarily interested in the streaming mappings (arch_sync_*)
> at the moment.

Just as an FYI, but we plan to revert the revert (i.e. go back to 'clean')
here once Qualcomm's modem firmware loader has been updated:

https://lore.kernel.org/r/20230109034843.23759-1-quic_sibis@quicinc.com

Will
