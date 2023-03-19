Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A86C06A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 00:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCSXex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 19:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCSXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFCC10C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 16:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1939CB80CA3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652A6C433D2;
        Sun, 19 Mar 2023 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679268886;
        bh=OHFIkS02PBwwN4tDVa9bwFIXVHAnsp7dEnx4o7xqt/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWS+q1/L6zMGmM54AkIQYlVjdUqomwxLOUxhh5bAA1qlRYSVcSb6zn8PU6mU8PhVP
         ZAIvUAJMkimSaOiK/gxicLqQhubfng5yZfvFzXxfg18Q/x7lDJCwdZR/cQcpHb1uvO
         SSk3FHfWhGTeFU2vXTZRw19TeowFt2kxewwPKlOO9jJHpB5Vcy46IjUBe00d2CFS+3
         0ZpR1G6R5SAeqoizt5d+wBItTLpPlnbccdeNT+NPaIzTS9Zs2z3TPO6WQS1QzX080m
         fPB/FqFyXk8vxidUm7Zx7iYQlnKg69M1PDcTMrDLp2OuMfVi1f1al7/JtPqqe4V8d2
         1ZDg7Zc2ZTxIA==
Date:   Sun, 19 Mar 2023 16:34:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Tom Rix <trix@redhat.com>, perex@perex.cz, tiwai@suse.com,
        ndesaulniers@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ALSA: ymfpci: remove unused snd_ymfpci_readb function
Message-ID: <20230319233444.GA12415@dev-arch.thelio-3990X>
References: <20230318132708.1684504-1-trix@redhat.com>
 <87mt49mabx.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt49mabx.wl-tiwai@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 09:09:22AM +0100, Takashi Iwai wrote:
> On Sat, 18 Mar 2023 14:27:08 +0100,
> Tom Rix wrote:
> > 
> > clang with W=1 reports
> > sound/pci/ymfpci/ymfpci_main.c:34:18: error:
> >   unused function 'snd_ymfpci_readb' [-Werror,-Wunused-function]
> > static inline u8 snd_ymfpci_readb(struct snd_ymfpci *chip, u32 offset)
> >                  ^
> > This static function is not used, so remove it.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> I applied now, but still wondering why it warns at all even if it's a
> static inline function...

See commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build") for some more information. The key part
of the commit message is 'with W=1', this will not happen with a normal
clang build.

Cheers,
Nathan

> > ---
> >  sound/pci/ymfpci/ymfpci_main.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
> > index c80114c0ad7b..2858736ed20a 100644
> > --- a/sound/pci/ymfpci/ymfpci_main.c
> > +++ b/sound/pci/ymfpci/ymfpci_main.c
> > @@ -31,11 +31,6 @@
> >  
> >  static void snd_ymfpci_irq_wait(struct snd_ymfpci *chip);
> >  
> > -static inline u8 snd_ymfpci_readb(struct snd_ymfpci *chip, u32 offset)
> > -{
> > -	return readb(chip->reg_area_virt + offset);
> > -}
> > -
> >  static inline void snd_ymfpci_writeb(struct snd_ymfpci *chip, u32 offset, u8 val)
> >  {
> >  	writeb(val, chip->reg_area_virt + offset);
> > -- 
> > 2.27.0
> > 
