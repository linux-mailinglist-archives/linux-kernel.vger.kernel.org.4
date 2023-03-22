Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063826C5057
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCVQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:18:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D02146B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:18:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j11so24088637lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679501891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91NUsnI2JWzfZ4bANRRwcZ4orsUryFhVkgWXPdVK98g=;
        b=G2s79NLcITgAksd3/kq8VJtWspJVsPtOCodre7wqiFjOGu3tfqxEGcHiiTKs9xXS8g
         nwTXUK9QA5CbXOAbXfd+kxBIrw8HMUUewNAP0B71MjIkc5fHVCIv6eXxUxjmLljY1lMy
         nkE30ypFZwFDgsjEIjrBSqFee//emPM2Ig3TP9YTWrXf9yzM6JbK4GM1eeXEQybU/PUb
         GETetZGN2DggKxOYhw1jwg4XprUTKPaWloeltxSiG5FYNJUzkEDTjEIvspbM1dRSvjGN
         H9OPDl7W4ebTwMXIsaEPtjILjg0BbMztfI898jPtHg9QT/tZViD2dRCgwc9pBKe78T3J
         uMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91NUsnI2JWzfZ4bANRRwcZ4orsUryFhVkgWXPdVK98g=;
        b=sOWbm9RIXHc5Uc3MqLWeHZI+IZGs6V+VqxRq8dnnKnNYbbWxHQZX/vjg9Y6i8E2jHw
         yIKddP8vqMjWq9bQFRQ0osSNN81cUSN/JT95zgzIMjThcM/9E/4wW2YjM8JVKsdGfloc
         1pa3kxRoNS/p3asO2fpX2Tv31QNE35tNOZnBcTwL9JXA0ITUajeRSyEEERY3xwl/o8P7
         KkiPKJhL+wNhvQkRQE5Id/tk4PmV/7vDBM+tzqzpDO3dMq9oh/v6mHyx6qvLMXMnDIRL
         InELqGui/WniVcJbNzW0VdwO9hFjAKT7MnKPyVhXqt90z7bdyx0KfN5E5d+1jgQtQNSq
         MWaQ==
X-Gm-Message-State: AO0yUKWBe+COqwjdL/ePix3j74kGFkZnjvFvI4Vn3SklWCvIidfnqHOe
        v3nRDU6H3GkqbccrkPHwUyT1k6xFlisZ8QmggbMmYg==
X-Google-Smtp-Source: AK7set9Y6w1sy23dklqHJdPn+k27VHykRl6SZ39SZtwN0MftCWxQu9UvUwQzQP7Nv3+x+O3Su2kEKylKZtHjHnLlD3Q=
X-Received: by 2002:ac2:41c6:0:b0:4d5:ca43:704a with SMTP id
 d6-20020ac241c6000000b004d5ca43704amr2061085lfi.13.1679501890831; Wed, 22 Mar
 2023 09:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230314183220.513101-1-evan@rivosinc.com> <20230314183220.513101-4-evan@rivosinc.com>
 <3351107.e9J7NaK4W3@diego>
In-Reply-To: <3351107.e9J7NaK4W3@diego>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 22 Mar 2023 09:17:34 -0700
Message-ID: <CALs-HsuCejsEtS65pH=SBp74V2gw2d2WmkL44muWr6+VSocO5w@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:41=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Evan,
>
> Am Dienstag, 14. M=C3=A4rz 2023, 19:32:17 CET schrieb Evan Green:
> > We have an implicit set of base behaviors that userspace depends on,
> > which are mostly defined in various ISA specifications.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >
> > Changes in v4:
> >  - More newlines in BASE_BEHAVIOR_IMA documentation (Conor)
> >
> > Changes in v3:
> >  - Refactored base ISA behavior probe to allow kernel probing as well,
> >    in prep for vDSO data initialization.
> >  - Fixed doc warnings in IMA text list, use :c:macro:.
> >
> >  Documentation/riscv/hwprobe.rst       | 24 ++++++++++++++++++++++++
> >  arch/riscv/include/asm/hwprobe.h      |  2 +-
> >  arch/riscv/include/uapi/asm/hwprobe.h |  5 +++++
> >  arch/riscv/kernel/sys_riscv.c         | 20 ++++++++++++++++++++
> >  4 files changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwpr=
obe.rst
> > index 211828f706e3..945d44683c40 100644
> > --- a/Documentation/riscv/hwprobe.rst
> > +++ b/Documentation/riscv/hwprobe.rst
> > @@ -39,3 +39,27 @@ The following keys are defined:
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimpli=
d``, as
> >    defined by the RISC-V privileged architecture specification.
> > +
> > +* :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the=
 base
> > +  user-visible behavior that this kernel supports.  The following base=
 user ABIs
> > +  are defined:
> > +
> > +  * :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: Support for rv32ima or
> > +    rv64ima, as defined by version 2.2 of the user ISA and version 1.1=
0 of the
> > +    privileged ISA, with the following known exceptions (more exceptio=
ns may be
> > +    added, but only if it can be demonstrated that the user ABI is not=
 broken):
> > +
> > +    * The :fence.i: instruction cannot be directly executed by userspa=
ce
> > +      programs (it may still be executed in userspace via a
> > +      kernel-controlled mechanism such as the vDSO).
> > +
> > +* :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`: A bitmask containing the ext=
ensions
> > +  that are compatible with the :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_I=
MA`:
> > +  base system behavior.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_IMA_FD`: The F and D extensions are suppor=
ted, as
> > +    defined by commit cd20cee ("FMIN/FMAX now implement
> > +    minimumNumber/maximumNumber, not minNum/maxNum") of the RISC-V ISA=
 manual.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as d=
efined
> > +    by version 2.2 of the RISC-V ISA manual.
>
> just wondering, is there a plan on how further extensions should be added=
 this this?
> [as we have this big plethora of them :-) ]
>
> Aka things like Zbb and friends will probably also be relevant to userspa=
ce, so just
> fill up RISCV_HWPROBE_KEY_IMA_EXT_0 with more elements and once full swit=
ch to
> RISCV_HWPROBE_KEY_IMA_EXT_1 , RISCV_HWPROBE_KEY_IMA_EXT_2, etc?
>
> Or do we have some more elaborate sorting mechanism?

That sounds reasonable to me. I tried to think about a couple of
possible sorting patterns, but when I played them out mentally they
were only ever aesthetically pleasing with no technical benefit, and
possibly added technical debt.
-Evan
