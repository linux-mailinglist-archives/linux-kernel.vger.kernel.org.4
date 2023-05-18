Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E16707C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjERImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjERIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:41:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769901BF4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:41:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307a8386946so1162026f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684399291; x=1686991291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqGJ07vQsFxHx1wjb6sLaSSKe4ljbWhXmhYOtRDR+sc=;
        b=3g1KGo1E0lC0/vdmtoMo5WxFumQ4IcY0av3zs7UdSpcsmpmcX79H76VGmty6I19xe6
         aKS4xxY6MZWuvtfXNc2T5H1uPdaSGI4O+bSgWUF4RA7TuG2CbVYtQb6y3X4ANRQFaG1R
         SxnYMtnV+YNorfLrVjt3HBXDlCPAKlYRIOUh0R+8EvbPgGlYLnFaVwKXkQA+w4Bfz+va
         vHdTGEsGt4zgcuX+B1+Z6Skk2yVc191vmreJjg3xROGYXJCzdeSos5hUsrHMACbAvuvf
         gpJCWBSxJCILQtOSZ6ft5hFV778/pTZ5ckw5VUQJHE0744WT7ea9LOVh+YtQ/ehbWLic
         pRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399291; x=1686991291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqGJ07vQsFxHx1wjb6sLaSSKe4ljbWhXmhYOtRDR+sc=;
        b=bU3ZaZQPaoeOnRKA8mSgC8XEmq4zAvv3cewGzv2/794ViULsgQeVtTcY98P3cyPJZQ
         xIdF4urUBMPCesjlcHFXMuVPagGFc5AdLe7dOVqQ6f1mVhSxc2I72BnDOR/3U+oHYbtg
         WEm5re/f7d8cg7VYkcZ3l5wbeGj1XbmdFt7BNYHQuaTMpJP/hTFyCe74HtpaXmu7dzHO
         QB7S7yFYon+rdp7AssLfDcgeb62rEgQNwjg637rOUprT6rJUHJZmwWzEZm1VtxyiC89n
         n4C3RMJEl/CpT3KmgTDHlDp0H7S1732DkbUIgDwJ+l6P/OhiTryJ9JQWAcZIGZA6d3Rk
         +T8g==
X-Gm-Message-State: AC+VfDyfLWN/aPJWIhIITxu2JRNemdJWNOyBL7ApgGhzz4QNGlbyuz4U
        Jg9PmRjXUzpGJyJZJqDx4zUcYZlm0qsMmCa9HpSonQ==
X-Google-Smtp-Source: ACHHUZ5M6SngD64QNPPYRKLdwGRlWkTiXOXVdssbphc8Iy1ZDMkk7KyDaOmzkgfiFWEMMRTRpEewjzToqvNXxnkHgDo=
X-Received: by 2002:a5d:6604:0:b0:306:4613:65e with SMTP id
 n4-20020a5d6604000000b003064613065emr919947wru.45.1684399290823; Thu, 18 May
 2023 01:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com> <20230518-mobilize-dipper-051dfbc41971@wendy>
In-Reply-To: <20230518-mobilize-dipper-051dfbc41971@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 18 May 2023 10:41:19 +0200
Message-ID: <CAHVXubhpkkC_1sYkHJvjuHB24YhmHJJ_ZvjRhzaqvygCvfbRnw@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi Conor, Anup!

On Thu, May 18, 2023 at 10:00=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> Hey Alex, Anup,
>
> On Thu, May 18, 2023 at 12:23:59PM +0530, Anup Patel wrote:
> > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > > On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > > On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> > > > > On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > >
> > > > > > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfille=
t@gmail.com> wrote:
> > > > > > I actually removed this flag a few years ago, and I have to adm=
it that
> > > > > > I need to check if that's necessary: the goal of commit 3335068=
f8721
> > > > > > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to e=
xpose
> > > > > > the "right" start of DRAM so that we can align virtual and phys=
ical
> > > > > > addresses on a 1GB boundary.
> > > > > >
> > > > > > So I have to check if a nomap region is actually added as a
> > > > > > memblock.memory.regions[] or not: if yes, that's perfect, let's=
 add
> > > > > > the nomap attributes to the PMP regions, otherwise, I don't thi=
nk that
> > > > > > is a good solution.
> > > > >
> > > > > So here is the current linear mapping without nomap in openSBI:
> > > > >
> > > > > ---[ Linear mapping ]---
> > > > > 0xff60000000000000-0xff60000000200000    0x0000000080000000      =
   2M
> > > > > PMD     D A G . . W R V
> > > > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000      =
  12M
> > > > > PMD     D A G . . . R V
> > > > >
> > > > > And below the linear mapping with nomap in openSBI:
> > > > >
> > > > > ---[ Linear mapping ]---
> > > > > 0xff60000000080000-0xff60000000200000    0x0000000080080000      =
1536K
> > > > > PTE     D A G . . W R V
> > > > > 0xff60000000200000-0xff60000000e00000    0x0000000080200000      =
  12M
> > > > > PMD     D A G . . . R V
> > > > >
> > > > > So adding nomap does not misalign virtual and physical addresses,=
 it
> > > > > prevents the usage of 1GB page for this area though, so that's a
> > > > > solution, we just lose this 1GB page here.
> > > > >
> > > > > But even though that may be the fix, I think we also need to fix =
that
> > > > > in the kernel as it would break compatibility with certain versio=
ns of
> > > > > openSBI *if* we fix openSBI...So here are a few solutions:
> > > > >
> > > > > 1. we can mark all "mmode_resv" nodes in the device tree as nomap=
,
> > > > > before the linear mapping is established (IIUC, those nodes are a=
dded
> > > > > by openSBI to advertise PMP regions)
> > > > >     -> This amounts to the same fix as opensbi and we lose the 1G=
B hugepage.
> > > >
> > > > AFAIU, losing the 1 GB hugepage is a regression, which would make t=
his
> > > > not an option, right?
> > >
> > > Not sure this is a real regression, I'd rather avoid it, but as
> > > mentioned in my first answer, Mike Rapoport showed that it was making
> > > no difference performance-wise...
>
> My point was that if someone has hugepages enabled & we handle this in a
> way that causes the first hugepage to be unusable, is that not a
> regression? Whether hugepages provide a performance benefit is not
> really related to that question AFAICT.

Not being able to map certain regions of the linear mapping with a 1GB
hugepage will happen, for example the kernel mapping is protected in
the linear mapping so that it can't be written: so we can only map
this region with 2MB hugepages. A firmware could mark a region as
"no-map" and there again we would not be able to use a 1GB hugepage. I
don't see that as a regression as the intention is not to *always* use
1GB hugepages, but rather to use them when possible. Does that make
sense?

>
> Were you suggesting reverting hugepage support entirely in your original
> message? If we entirely remove hugepage support, then I guess the first
> hugepage cannot be lost..

Given Mike Rapoport's recent talk, I think that's an option, yes.

>
> > > > > 2. we can tweak pfn_is_nosave function to *not* save pfn correspo=
nding
> > > > > to PMP regions
> > > > >     -> We don't lose the 1GB hugepage \o/
> > > > > 3. we can use register_nosave_region() to not save the "mmode_res=
v"
> > > > > regions (x86 does that
> > > > > https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/=
e820.c#L753)
> > > > >     -> We don't lose the 1GB hugepage \o/
> > > > > 4. Given JeeHeng pointer to
> > > > > https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/sna=
pshot.c#L1340,
> > > > > we can mark those pages as non-readable and make the hibernation
> > > > > process not save those pages
> > > > >     -> Very late-in-the-day idea, not sure what it's worth, we al=
so
> > > > > lose the 1GB hugepage...
> > > >
> > > > Ditto here re: introducing another regression.
> > > >
> > > > > To me, the best solution is 3 as it would prepare for other simil=
ar
> > > > > issues later, it is similar to x86 and it allows us to keep 1GB
> > > > > hugepages.
> > > > >
> > > > > I have been thinking, and to me nomap does not provide anything s=
ince
> > > > > the kernel should not address this memory range, so if it does, w=
e
> > > > > must fix the kernel.
> > > > >
> > > > > Let me know what you all think, I'll be preparing a PoC of 3 in t=
he meantime!
> > > >
> > > > #3 would probably get my vote too. It seems like you could use it
> > > > dynamically if there was to be a future other provider of "mmode_re=
sv"
> > > > regions, rather than doing something location-specific.
> > > >
> > > > We should probably document these opensbi reserved memory nodes tho=
ugh
> > > > in a dt-binding or w/e if we are going to be relying on them to not
> > > > crash!
> >
> > Depending on a particular node name is fragile. If we really need
> > information from DT then I suggest adding "no-save-restore" DT
> > property in reserved memory nodes.
>
> We can add whatever properties we like, but where does that leave us for
> the systems in the wild where their reserved memory nodes do not contain
> a "no-save-restore" property or "no-map"?
>
> Ideally, yes, we do not depend on the node name and instead use explicit
> properties - but I think we may be "forced" to fall back to checking the
> node-name to cover the opensbi versions that do not contain one.
> LMK if I have missed something there!

Yes I agree with you, we can implement Anup's solution #1, but we need
to fix the kernel anyway since if we don't, that would make the kernel
hibernation support depend on a certain version of openSBI.

>
> > > Yes, you're right, let's see what Atish and Anup think!
> >
> > I think we have two possible approaches:
> >
> > 1) Update OpenSBI to set "no-map" DT property for firmware
> >     reserved regions. We were doing this previously but removed
> >     it later for performance reasons mentioned by Alex. It is also
> >     worth mentioning that ARM Trusted Firmware also sets "no-map"
> >     DT property for firmware reserved regions.
> >
> > 2) Add a new "no-save-restore" DT property in the reserved
> >     memory DT bindings. The hibernate support of Linux arch/riscv
> >     will use this DT property to exclude memory regions from
> >     save-restore. The EFI implementation of EDK2 and U-Boot
> >     should do the following:
> >     1) Treat all memory having "no-map" DT property as EFI
> >         reserved memory
> >     2) Treat all memory not having "no-map" DT property and
> >         not having "no-save-restore" DT property as EfiBootServicesData
> >     3) Treat all memory not having "no-map" DT property and
> >          having "no-save-restore" DT property as EfiRuntimeServiceData
> >          (Refer,
> > https://devicetree-specification.readthedocs.io/en/latest/chapter3-devi=
cenodes.html#reserved-memory-and-uefi)
> >
> > Personally, I am leaning towards approach#1 since approach#2
> > will require changing DeviceTree specification as well.
>
> #1 is by far the simpler option of the two, if the consensus is that the
> loss of the first hugepage is not a problem (or if it is a problem that
> realistically is unavoidable).

The "no-map" property does not provide much security anyway: the
kernel should not touch a page that is reserved (this is where I may
be wrong), so the real fix to this issue is to make the hibernation
process not save those pages.

>
> There's something else I think I might be missing here, given the
> scattered nature of the reporting. This is not a problem for a system
> that does not implement hibernation, which was only added in v6.4-rc1?
>
> That would make it not a regression after all. I think I misunderstood
> the report on sw-dev to mean that this was a problem generally after
> v6.4-rc1, which would have been one. Could someone please confirm that?

The problem is only present since v6.4-rc1, that's not a regression,
it's just that both patches landed at the same time and gave rise to
this issue.

>
> If it only affects hibernation, and is not a regression, should we make
> ARCH_HIBERNATION_POSSIBLE def_bool n in Kconfig until we have agreed on
> a solution for the problem?
>
> Thanks,
> Conor.
