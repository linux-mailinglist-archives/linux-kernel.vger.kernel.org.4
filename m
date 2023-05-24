Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85570F81F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjEXN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjEXN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:57:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9179E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:57:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30957dd7640so627655f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684936651; x=1687528651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEYTuRJhRkLKtHKUvCdhWe7fUcQHcs0X5Wg0nUuBVyI=;
        b=O7CZTXIhIq2dic1DrB38b60QIS7+YZ9/3RYM8/onVvnoX48tg5PhgjmZgJBMnp1D3P
         M+/Ms1TJG7QvXYzs4y0NBerxVc+K01Tro7vt2VRnF7BcebZJDCMUEY0I4SWH6gZro4f+
         1alFS+hqmtkvRp9Vy9JGY1/Aa1qCDay/dMqQcqZ6PpQWhVALZU6IDGVWPLJKexEIivpw
         O9gqWs+wlTcvgIjsDgkF/5ddgcK2kdAcy5QUUaCqgrUNTTpXzge3cCNHYVD5j+lDhnz6
         3qzjMrpaJ71y2p5Eafo0gpxoIyjq10mwD22sRMFYOE5281iCF3JV5bZ90v+pHq5gbw7a
         pXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684936651; x=1687528651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEYTuRJhRkLKtHKUvCdhWe7fUcQHcs0X5Wg0nUuBVyI=;
        b=DboL9xV4nXTr71+3ORXhd82B9SGXUh8ETzp8xiNsqIkcDkTfAQAFmsZ2mV5ErGKsDB
         dUsY/jiks1THPhUCl+fl0XXXTNvC6le+lxAChnDpx9LoxmOoxUvVrhdC3qiIKCHccaWk
         G9K781DxLMFi0EMHDluXW4KjSznLu/ZJjh1ysyNOB3LswdIyP8up/0kR4V6KmqAZ1OE1
         L91K2eAEDSbbuXbqneclDLfOB4gzWJXCPuhBYoR09J3YgtVRoB6ResOLEnue9hdErg+g
         DUv3gv2zwFXjLHEJI6hpYpU6O65YQ9bQEelHpHijsVwKkP76JFCaBTBtDwgGAV7jQPZD
         LKbA==
X-Gm-Message-State: AC+VfDzuzuoGgVUB+BN9L2G9u6oPeE9JMdDm18e9nixXT1FZt/dAshe8
        //6/OTfvXSG+ajkEbq53lBOXMLy/bL6fABAapbKV4Q==
X-Google-Smtp-Source: ACHHUZ4ibYoa8M7c79FfdKNZjLT6wT/DnWmlTjhaBAhFYX+3rtP+YQniMuLxkPNIZ/AUVrArC7rsOmcs/O5cG3kd/Q4=
X-Received: by 2002:a5d:4a02:0:b0:30a:8c0b:320d with SMTP id
 m2-20020a5d4a02000000b0030a8c0b320dmr8578757wrq.11.1684936651122; Wed, 24 May
 2023 06:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy> <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr> <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <20230524-wasp-charm-fe5c5478957a@spud>
In-Reply-To: <20230524-wasp-charm-fe5c5478957a@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 24 May 2023 15:57:20 +0200
Message-ID: <CAHVXubjhti9reD8oCh3Jm97tvFdUGi9ShYnm0NhQU4ZYVgU6HA@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sunil V L <sunilvl@ventanamicro.com>
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

Hi Conor,

On Wed, May 24, 2023 at 3:49=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Alex, Anup,
>
> On Thu, May 18, 2023 at 07:34:16PM +0530, Anup Patel wrote:
> > On Thu, May 18, 2023 at 5:39=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> > > On 5/18/23 08:53, Anup Patel wrote:
> > > > On Wed, May 17, 2023 at 8:26=E2=80=AFPM Alexandre Ghiti <alexghiti@=
rivosinc.com> wrote:
> > > >> On Wed, May 17, 2023 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley=
@microchip.com> wrote:
> > > >>> On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
> > > >>>> On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghi=
ti@rivosinc.com> wrote:
> > > >>>>> On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfille=
t@gmail.com> wrote:
> > > >>>>> I actually removed this flag a few years ago, and I have to adm=
it that
> > > >>>>> I need to check if that's necessary: the goal of commit 3335068=
f8721
> > > >>>>> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to e=
xpose
> > > >>>>> the "right" start of DRAM so that we can align virtual and phys=
ical
> > > >>>>> addresses on a 1GB boundary.
> > > >>>>>
> > > >>>>> So I have to check if a nomap region is actually added as a
> > > >>>>> memblock.memory.regions[] or not: if yes, that's perfect, let's=
 add
> > > >>>>> the nomap attributes to the PMP regions, otherwise, I don't thi=
nk that
> > > >>>>> is a good solution.
> > > >>>> So here is the current linear mapping without nomap in openSBI:
> > > >>>>
> > > >>>> ---[ Linear mapping ]---
> > > >>>> 0xff60000000000000-0xff60000000200000    0x0000000080000000     =
    2M
> > > >>>> PMD     D A G . . W R V
> > > >>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000     =
   12M
> > > >>>> PMD     D A G . . . R V
> > > >>>>
> > > >>>> And below the linear mapping with nomap in openSBI:
> > > >>>>
> > > >>>> ---[ Linear mapping ]---
> > > >>>> 0xff60000000080000-0xff60000000200000    0x0000000080080000     =
 1536K
> > > >>>> PTE     D A G . . W R V
> > > >>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000     =
   12M
> > > >>>> PMD     D A G . . . R V
> > > >>>>
> > > >>>> So adding nomap does not misalign virtual and physical addresses=
, it
> > > >>>> prevents the usage of 1GB page for this area though, so that's a
> > > >>>> solution, we just lose this 1GB page here.
> > > >>>>
> > > >>>> But even though that may be the fix, I think we also need to fix=
 that
> > > >>>> in the kernel as it would break compatibility with certain versi=
ons of
> > > >>>> openSBI *if* we fix openSBI...So here are a few solutions:
> > > >>>>
> > > >>>> 1. we can mark all "mmode_resv" nodes in the device tree as noma=
p,
> > > >>>> before the linear mapping is established (IIUC, those nodes are =
added
> > > >>>> by openSBI to advertise PMP regions)
> > > >>>>      -> This amounts to the same fix as opensbi and we lose the =
1GB hugepage.
> > > >>> AFAIU, losing the 1 GB hugepage is a regression, which would make=
 this
> > > >>> not an option, right?
> > > >> Not sure this is a real regression, I'd rather avoid it, but as
> > > >> mentioned in my first answer, Mike Rapoport showed that it was mak=
ing
> > > >> no difference performance-wise...
> > > >>
> > > >>>> 2. we can tweak pfn_is_nosave function to *not* save pfn corresp=
onding
> > > >>>> to PMP regions
> > > >>>>      -> We don't lose the 1GB hugepage \o/
> > > >>>> 3. we can use register_nosave_region() to not save the "mmode_re=
sv"
> > > >>>> regions (x86 does that
> > > >>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel=
/e820.c#L753)
> > > >>>>      -> We don't lose the 1GB hugepage \o/
> > > >>>> 4. Given JeeHeng pointer to
> > > >>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/sn=
apshot.c#L1340,
> > > >>>> we can mark those pages as non-readable and make the hibernation
> > > >>>> process not save those pages
> > > >>>>      -> Very late-in-the-day idea, not sure what it's worth, we =
also
> > > >>>> lose the 1GB hugepage...
> > > >>> Ditto here re: introducing another regression.
> > > >>>
> > > >>>> To me, the best solution is 3 as it would prepare for other simi=
lar
> > > >>>> issues later, it is similar to x86 and it allows us to keep 1GB
> > > >>>> hugepages.
> > > >>>>
> > > >>>> I have been thinking, and to me nomap does not provide anything =
since
> > > >>>> the kernel should not address this memory range, so if it does, =
we
> > > >>>> must fix the kernel.
> > > >>>>
> > > >>>> Let me know what you all think, I'll be preparing a PoC of 3 in =
the meantime!
> > > >>> #3 would probably get my vote too. It seems like you could use it
> > > >>> dynamically if there was to be a future other provider of "mmode_=
resv"
> > > >>> regions, rather than doing something location-specific.
> > > >>>
> > > >>> We should probably document these opensbi reserved memory nodes t=
hough
> > > >>> in a dt-binding or w/e if we are going to be relying on them to n=
ot
> > > >>> crash!
> > > > Depending on a particular node name is fragile. If we really need
> > > > information from DT then I suggest adding "no-save-restore" DT
> > > > property in reserved memory nodes.
> > >
> > >
> > > I understand your point, the node name is the only thing I found that
> > > would work with current opensbi: any other idea what we could use ins=
tead?
> > >
> > >
> > > >> Yes, you're right, let's see what Atish and Anup think!
> > > > I think we have two possible approaches:
> > > >
> > > > 1) Update OpenSBI to set "no-map" DT property for firmware
> > > >      reserved regions. We were doing this previously but removed
> > > >      it later for performance reasons mentioned by Alex. It is also
> > > >      worth mentioning that ARM Trusted Firmware also sets "no-map"
> > > >      DT property for firmware reserved regions.
> > > >
> > > > 2) Add a new "no-save-restore" DT property in the reserved
> > > >      memory DT bindings. The hibernate support of Linux arch/riscv
> > > >      will use this DT property to exclude memory regions from
> > > >      save-restore. The EFI implementation of EDK2 and U-Boot
> > > >      should do the following:
> > > >      1) Treat all memory having "no-map" DT property as EFI
> > > >          reserved memory
> > > >      2) Treat all memory not having "no-map" DT property and
> > > >          not having "no-save-restore" DT property as EfiBootService=
sData
> > > >      3) Treat all memory not having "no-map" DT property and
> > > >           having "no-save-restore" DT property as EfiRuntimeService=
Data
> > > >           (Refer,
> > > > https://devicetree-specification.readthedocs.io/en/latest/chapter3-=
devicenodes.html#reserved-memory-and-uefi)
> > > >
> > > > Personally, I am leaning towards approach#1 since approach#2
> > > > will require changing DeviceTree specification as well.
> > >
> > >
> > > If needed, indeed #1 is the simplest, but I insist, to me it is not
> > > needed (and we don't have it in the current opensbi), if you have
> > > another opinion, I'm open to discuss it!
> >
> > I agree with you, backward compatibility with older firmwares
> > is important.
> >
> > Let's go with your proposed change to treat reserved DT nodes
> > with "mmode_resv*" name as M-mode firmware memory (it could
> > be any M-mode firmware). We will certainly need to document it
> > somewhere as an expectation of Linux RISC-V kernel.
>
> Actually, you two both probably know the answer to this, but was there a
> release done of OpenSBI where the reserved memory region was not
> specified to be no-map?

The reserved memory regions are *currently* not specified to be no-map
and that since v0.8: the culprit is commit 6966ad0abe70
("platform/lib: Allow the OS to map the regions that are protected by
PMP").

So to make sure we are on the same page:

- from 0.1 to 0.7 =3D> reserved memory regions were marked as no-map
- starting from 0.8 =3D> reserved memory regions are *not* marked as
no-map anymore

Hope that's clear!

Alex

>
> >
> > @Sunil How about treating "mmode_resv*" as
> > EfiRuntimeServiceData in EDK2 ? Other reserved memory
> > nodes can follow the device tree specification.
>
