Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593274A473
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGFTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:35:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240791BD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:35:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1674457e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688672106; x=1691264106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJb0tT5v6PFselQcra2E8iBWNOHEwGRQkGYRNRggtk0=;
        b=PvGnYWJHhj4WvRyhsNgheDIkauEwn6/iNIBYs/wbygmrSNi0xmT0h5/NLSevgYfprC
         DW0mNTVRMvvj+aPw7mC+AV4zhcsASi+hkaiDsXAZkzkf+Z+2UJJjwohlTScOhbMNSdME
         mr47Uqy8H6MINnTvdyCl1w3XhpdBSHENZSpKMwEadhFbfDM+zeGejDwi9iEJQCgaqLSN
         L4xbbHzz33ROw05NkWmTP+cdZ/QRsg/VQboOC805ZI+4tufbmUTbjrjvNKxX/X98Oj13
         RvB5CkJPLsaedPxMqpdE24uZX94gEV+Sg0kRz7kcHMdWHj3kbh10IiC9Eb8gvImuJ1rV
         hKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688672106; x=1691264106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJb0tT5v6PFselQcra2E8iBWNOHEwGRQkGYRNRggtk0=;
        b=Fopzyn2xjeNgAmo/pC7H4sX8XRFrtBsGwE0fR8mNJfEcEKaQ/nVzOsex0Vxvackhkw
         rSLlK5gP5KOS5KiCwBH44hviqxI3lQnnOhfe5irQYWV23lUYvjanKq8OzQMpn/tACI3u
         3WybqCFgvZfQXUgkPTROAhSQAVlZASUM2vMGxpagxDsrpRf9D0v0PeIrqhKfoqOxrF5t
         H9pyjP3GN+S6ZLp7+fkf4ip60FzK1D5/Pa5KoeqEHQ1hsWudRLH+N7zjBj0+VETi9eId
         +DmSOpvc/oEQR3VaEdYqKNKJjZs5VdnTUJW0o76jre+sSAdcXQlu7l2ZPECsp6QpEp4d
         CYbQ==
X-Gm-Message-State: ABy/qLagdZqV03T3WF3jJ79o49nJFrYk3NulPcSOQT2Wr5AYB2itJqca
        v6UeLvoHjsPMtvp4IxR9VbOpGiFSlDNHckV//r8LDA==
X-Google-Smtp-Source: APBJJlEiwB3zrVWoRSJyoWVS8+2c9Dd5aS5me6kgVvr1RCyWHsgrOefe0B9ojFn0k/KgRnYGHW7i7mTIbl76IWI8W+U=
X-Received: by 2002:a05:6512:1ca:b0:4f5:1418:e230 with SMTP id
 f10-20020a05651201ca00b004f51418e230mr2117287lfp.52.1688672106378; Thu, 06
 Jul 2023 12:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230705172931.1099183-1-evan@rivosinc.com> <20230706-dbdee6eba0c4a16084587b10@orel>
 <20230706-murkiness-oven-444f25924546@wendy>
In-Reply-To: <20230706-murkiness-oven-444f25924546@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 6 Jul 2023 12:34:30 -0700
Message-ID: <CALs-Hssc6Uxf-6FKbye2n-CD0FWWE4xDmUWvN1NoKNFpn88SKg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 3:53=E2=80=AFAM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Thu, Jul 06, 2023 at 10:01:31AM +0200, Andrew Jones wrote:
> > On Wed, Jul 05, 2023 at 10:29:31AM -0700, Evan Green wrote:
> > > In /proc/cpuinfo, most of the information we show for each processor =
is
> > > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> > > compatible, and the mmu size. But the ISA string gets filtered throug=
h a
> > > lowest common denominator mask, so that if one CPU is missing an ISA
> > > extension, no CPUs will show it.
> > >
> > > Now that we track the ISA extensions for each hart, let's report ISA
> > > extension info accurately per-hart in /proc/cpuinfo. We cannot change
> > > the "isa:" line, as usermode may be relying on that line to show only
> > > the common set of extensions supported across all harts. Add a new "h=
art
> > > isa" line instead, which reports the true set of extensions for that
> > > hart. This matches what is returned in riscv_hwprobe() when querying =
a
> > > given hart.
> > >
> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > >  - Added new "hart isa" line rather than altering behavior of existin=
g
> > >    "isa" line (Conor, Palmer)
> > >
> > >
> > > I based this series on top of Conor's riscv-extensions-strings branch
> > > from July 3rd, since otherwise this change gets hopelessly entangled
> > > with that series.
> > >
> > > I was unsure if I could snuggle the new "hart isa" line in just below
> > > "isa". Aesthetically it would be quite pleasing, but it runs the risk=
 of
> > > breaking brittle usermode parsers that are assuming a specific line
> > > order. So I put it at the end.
> >
> > Actually, they're probably only aesthetically pleasing when they match.=
 If
> > there are differences, then I'd guess having them side by side, almost =
the
> > same, but different, would make them even harder to look at then they
> > already are. So I think I'll be happier with them separated by a few li=
nes
> > anyway.
>
> This list is eventually going to be so big that I don't think doing
> by-eye anything is going to be useful, so aesthetics be damned.
> That said, a parser that relies on the order of individual lines like
> that might deserve to be broken ;)
>
> Anyway, change looks good to me:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> I was thinking the uabi doc might need an update - should we add to it
> that "isa" means the common set & "hart isa"?

I did do a little search for documentation to update, but failed to
come up with any. Which doc are you thinking of?
-Evan
