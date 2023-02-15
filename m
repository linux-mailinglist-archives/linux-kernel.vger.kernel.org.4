Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2105698731
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBOVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:14:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C71ABD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:14:55 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id br9so307589lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1gQtmlRBhpSJ40ajJoTyktY/WnEFbQ+Gi+issmQ3qU=;
        b=ZKZR82o1JYYe14j7LfX/wQTXfDrD3ih0AoR7f+3SDLTKATYgPzCMEAUnUkZzUA/+DX
         QWYoRJG/TGiaTqb34QpT1WfKCZ+eYENcPkPiWeQE7I4AmUrCHVzeMVU25cDCmexT5f4C
         1MOqUXvdkIhjDry1uM4ZR3ro2TI1L+F3IIiDJR8PIKsSF9ppE9FVhBsJmB7r0yuzvcc3
         7wyHq/J4YfGovrsD+GApWNFljd6GXYMtkfdw+saKP7bI7kOWawLukydV6eXrxa9xQfTZ
         9DxhRkVheK33LhW5CHDzJxkOzthCn81C82GL+SUnsDy0yK3zfDp+g0sBT9AJUI3y2cPN
         kVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1gQtmlRBhpSJ40ajJoTyktY/WnEFbQ+Gi+issmQ3qU=;
        b=b9/SrK4ukuuf/mp3+KAYfQEAu3zEVqY9E2/ot7igz9zclgXE5apTBfnF2g4344fKg8
         63gDmBek1pmJ6DTwU10ce/TvC2exXKHbHfg/tV2ne0asncc4g1GzzqyoKk2nA34WbEdG
         lFCelkpgMs5+BWws9YDU8Hs1cr6HT1ebvDYpgoCd9JJ79aFL0e/dflgdjPWTY3O+RQgD
         lJbYuFaNn1783ZijDGeWaRaBZmViEr6uxrMg2M9m8PBcli2pvTLnhP/xEvEtc1xDUik/
         J2lSwAgEcIEEhzFP+BSDVl2cXO7mdJBPP64uOIQu3oi9lhmuKlSmLX8kteNdJyErgKhl
         E60A==
X-Gm-Message-State: AO0yUKWLHTQlTr7+YsxDxUxgXq09jci+zLIGE05ICLgsmc+MVBBQSGjz
        c4TF5ii8gY8pOvabAupwtc3ghqn0XtJRbAKQQLXt4A==
X-Google-Smtp-Source: AK7set9HNLqLqmvl/qQOOm2AvS5tnhyFklJKHOM0CSXZu5uWUVPpDBcsV7m40liFRQynQZO4GW6u4p+S+8fNfafnfzs=
X-Received: by 2002:ac2:43b9:0:b0:4db:182b:2d74 with SMTP id
 t25-20020ac243b9000000b004db182b2d74mr1004018lfl.9.1676495693301; Wed, 15 Feb
 2023 13:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-3-evan@rivosinc.com>
 <ded4018d-c90f-41c7-9e54-da954bdef49e@app.fastmail.com>
In-Reply-To: <ded4018d-c90f-41c7-9e54-da954bdef49e@app.fastmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 15 Feb 2023 13:14:17 -0800
Message-ID: <CALs-HsuwOqR+y-GriKOiRx068bgOv3qTOpsJTaA02htiiynWmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Vineet Gupta <vineetg@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        slewis@rivosinc.com, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, guoren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 1:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 6, 2023, at 21:14, Evan Green wrote:
> > We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> > system call that quite does this, so let's just provide an arch-specific
> > one to probe for hardware capabilities.  This currently just provides
> > m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > the future.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
>
> I'm not sure I understand the problem with
> AT_HWCAP. While the bits in AT_HWCAP and AT_HWCAP2
> are limited, I don't see us running out of new
> AT_* words to use for additional bits. Presumably
> the kernel would already have to know about the
> name of each supported HW feature and could assign
> a unique bit number to them.

Palmer can probably speak to this with more authority, but my
understanding about the motivation for an approach like this goes
something like:
 * With the nature of RISC-V, we expect a lot of these types of bits
and bobs, many more than we've seen with the likes of x86 and ARM.
 * We also expect in some cases these values to be inconsistent across CPUs.
 * While we could copy all that data into the aux vector every time,
it starts to look like a lot of data, not all programs care about all
of it, and a lot of it is static, making all the copying wasteful.
 * Another option that would solve most of this would be to point to a
vDSO data area from the aux vector. This solves the copy complaints,
but makes that vDSO data ABI, and requires it all to be known up
front.
 * So, a syscall with a vDSO function in front of it seemed like a
good combination of speed and flexibility.

You're certainly right that HWCAPn would work for what we're exposing
today, so the question probably comes down to our relative predictions
of how this data will grow.

-Evan
