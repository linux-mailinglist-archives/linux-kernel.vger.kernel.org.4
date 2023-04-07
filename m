Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6F6DB709
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDGXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDGXOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:14:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF68D53C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:14:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c9so45652866lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680909239; x=1683501239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLCKLoInrHAdRrt/0I6H7kvsHh1I3smFNdrczzyqv/Q=;
        b=1BVMFc6cnJvNZ3RCGog/TgUAVTShIApspugpWbu7eb5NWMCf7pwShOSSgxqtalstr7
         /5oEqJlSLieSR/6Fbv9vqMSMmsb7NEJiC1iv1Sl8e8N5TRv6Kgmgs2RNyOtD/3+lS/HB
         VC0jNqy85O2whn7VfMZxF1x5AuNlf45ENRtquDzLd3lJ72FprgdTNqXMSC66Bkz5kraO
         5sH4rcSJ8RwJREALKSNnUUEjeiYuMBnaHqHe+Yzew0lJll7GhNquiEhAg7iHbYkgiLOR
         8tZTJrI9uxuOzfAplYHdH5oerDH1tIxhUTEqK9hp5AvToRNly5zYVQ9c2uoXtwMPlZMQ
         Npog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680909239; x=1683501239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLCKLoInrHAdRrt/0I6H7kvsHh1I3smFNdrczzyqv/Q=;
        b=4UkjAhdEwZVF1PDzU7v2vZZIlyn9ZPUyIqhqr4EnHwILvu+n9ZWNnTb4WRxQTTloqz
         2bIIarvL8R2r86sUjLjlG2vc8Zd9WNCMQu4UpT3HrJ3QpVXnOSF2mtjPBbFH5kuyYdhO
         l0UYkZnpRRSUdBi3BLwL0BxSnGqcIyDg6xp/MGLUGIyncdyx8d+jM8WjeqDQHJLOEK5c
         jzWzKklLqCTOebI9E3vojqsbSknbjbvphnYMLVcW9GkxKwfmDpGxvx/pAFc1y1DmhnCY
         HbOl2/VE6irZQK4xSlpMxtooDN3HT5ExrRPFiNEOlfExj663GW0FR4EJ6e6NXyMq0aK+
         jWfg==
X-Gm-Message-State: AAQBX9fGXBe9cEIsvwJe3RTGx+GmrIlQuHO6v7S02/DWOnot59G1GMnx
        U3IBEeMQaD2lNb+sQQMRE9Qumg2vZIqsgL2irM9ogA==
X-Google-Smtp-Source: AKy350bzm19IuX0j9iDEEWmFoH1N6yWiSVZDoy915nZ//DbP2dy6HrkAEPcTK3qRSxUvCqRvZzChy9AaY00tladbUn4=
X-Received: by 2002:ac2:54a5:0:b0:4db:5133:59a6 with SMTP id
 w5-20020ac254a5000000b004db513359a6mr1120101lfk.13.1680909239626; Fri, 07 Apr
 2023 16:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230327163203.2918455-1-evan@rivosinc.com> <20230327163203.2918455-3-evan@rivosinc.com>
 <alpine.DEB.2.21.999.2304051354280.19052@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.21.999.2304051354280.19052@utopia.booyaka.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 7 Apr 2023 16:13:23 -0700
Message-ID: <CALs-HstVAGX476SGi_+ct7xxWrBeSE=nGVqckGjm9xo06K-Mww@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] RISC-V: Add a syscall for HW probing
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
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

On Wed, Apr 5, 2023 at 6:57=E2=80=AFAM Paul Walmsley <paul@pwsan.com> wrote=
:
>
> On Mon, 27 Mar 2023, Evan Green wrote:
>
> > We don't have enough space for these all in ELF_HWCAP{,2} and there's n=
o
> > system call that quite does this, so let's just provide an arch-specifi=
c
> > one to probe for hardware capabilities.  This currently just provides
> > m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > the future.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> Folks are already building RISC-V systems with cores that have different
> feature sets inside the same Linux system image - just like some ARM
> vendors are - so it makes sense to pass this information onto userspace.
>
> By the way, Evan, did you intend to update the copyright dates to include
> 2023?

Updated in v6.

>
> Beyond that,
>
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

Thanks, Paul!
-Evan
