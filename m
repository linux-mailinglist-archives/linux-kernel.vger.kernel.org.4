Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEF73A74D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjFVRcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjFVRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:32:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362E19AF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:32:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9b627c1b8so41675695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687455155; x=1690047155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYzOr+m6ZxzxEvl2PF3jrjUYErtnMeTqwLS2G94marM=;
        b=ibqirJS/+biMpP8g0L5piVynHBTRRV0bAE5mOryNRHtbZi+mUnHRxl1c12p9uwMXoo
         VIA3AI2PNjkLGz2Lni0gPEPKYC1WiIWn39+K/xKx3l2kv003L3E5cnDW8khAhpgiXT1o
         zZhWog/JvqMDRqfmAEF1tlWoTjKMM18+q3PudZ8F1Id2V5ef5Vpi+xNIR1WDV2vDgad+
         hDiD0aKhjmRs29GFgxUG/6gtQL5Uv69OvhuVtj861qNiHJ7ZcnpLdQsMYtt3xOStWaiu
         Ew1FgY0Pbc3vEwbdd//PJgWVjUMI/q7UnDKCy3eGhRGfFQ8d5Zt6lnxi/L1gzBRm3nhm
         JfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455155; x=1690047155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYzOr+m6ZxzxEvl2PF3jrjUYErtnMeTqwLS2G94marM=;
        b=jjtAbnu7JqWOHLCOy1Qh5keoc9OztnRfeVvnGp5fhIPloO0aOFojKwUm8BvofRRSzm
         huLHqXuqaBdfTiy9I7tIdp2a95Zt4qUYdF7gCPfwzn2L2fu4eFa+eKYU4x5rcLurw9cp
         2QQgZD7wGNTj1radhYo0P0Cu8S7JjUIQ9dBBS0tIfhd94HFxNsCgrzE7bLWrBC0kOxnJ
         BQn7XDQFC6+/p9CGprtgeuOPxFyjFgyk3MsZL6jr7mpVLj+xCUk3X68Mqe+NEuXOHF04
         NRLxeBw8G9GHZRMdWN4F9Smu2yifJX0KwlHAxP2nywvD4C6iM1Z8D/dRuEy52ZZrg6rT
         EhXQ==
X-Gm-Message-State: AC+VfDzM7bp3a9yqzPuwwfx8YTghXvoneZ8pBvv5tZdtdnU/IP/O6AsK
        ZMbos3AMfPUrEilmSWr3CDHQ3DLZdDV87jcggAK5cQ==
X-Google-Smtp-Source: ACHHUZ4a2mEPLo7cxfgHRoQCrjnAyTY6kt8y7S9iJ/FgJPnbTeWHOErvMKTvucsyVTz5v4YV/fO/IM9DesMd11bIA1U=
X-Received: by 2002:adf:de87:0:b0:311:1029:e325 with SMTP id
 w7-20020adfde87000000b003111029e325mr16013813wrl.70.1687455155123; Thu, 22
 Jun 2023 10:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072234.9900-1-alexghiti@rivosinc.com> <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-d6da578719f8af903d6746ef@orel> <20230622-4af59422f118ea634836d351@orel>
In-Reply-To: <20230622-4af59422f118ea634836d351@orel>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 22 Jun 2023 19:32:23 +0200
Message-ID: <CAHVXubgJQhShbOfaQeOTxM61g_tUnLBxa-0JK+WE+YQRGkYRQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 7:24=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jun 21, 2023 at 02:19:50PM +0200, Andrew Jones wrote:
> > On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> ...
> > > +Hardware description
> > > +--------------------
> > > +
> > > +The firmware can pass either a devicetree or ACPI tables to the RISC=
-V kernel.
> > > +
> > > +The devicetree is either passed directly to the kernel from the prev=
ious stage
> > > +using the `$a1` register, or when booting with UEFI, it can be passe=
d using the
> > > +EFI configuration table.
> > > +
> > > +The ACPI tables are passed to the kernel using the EFI configuration=
 table. In
> > > +this case, a tiny devicetree is still created by the EFI stub. Pleas=
e refer to
> > > +"EFI stub and devicetree" tree section below for details about this =
devicetree.
> >                              ^ redundant 'tree' here
> >
>
> Can whoever applies this drop this 'tree' I pointed while applying?

Yes, sorry: @Conor Dooley give me the overly long lines you wanted me
to break and I'll send a v3, it won't take much time and I'll fix this
too!

>
> Thanks,
> drew
