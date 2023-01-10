Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912F664FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjAJXWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAJXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:22:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BB4ECBC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:22:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id co23so13368993wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmGS/5cqJeFoACOJHc4BZzYIiIrGMVykwhdR9XF4jmk=;
        b=c9g60mip6DpvqJLy5dqRJjsW9pGnhDft8wTL2uY8ndZFa5w6WYCaP0WJwePVMeaSJ0
         t9h2CoV7gylh95IMSaormiIQc3G2EZCrEX+EQUHRe2KDvDhc76MEv0KE+vgy4xE1Jmpp
         PDV1NAP9Xxw5nErDe0nKNAK29nrD9pU7mZfdrVUAl+FEm5S/w1ML7vfEgTAZkUJvSlsK
         jc0C/VDjQqn2ZfnvCbv2Uf/PIl6dXAJtnKrn1SCsPy5wH1l1kojpHDE/BgVWarRWUPJt
         ik1P+2NgbNAnx1J2YAPvMZ9BeFT3wBkUeUxrzk+cS6ZIeKO4OHj3P4tJPh3sqK9Mzb0j
         rTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmGS/5cqJeFoACOJHc4BZzYIiIrGMVykwhdR9XF4jmk=;
        b=leo22Y7IgTg+K3kl1Wr3Jr6Uc89wtlH65c2w45fbafLAHmaCgWk0Hbi7Cac7nIQwKl
         OxMqn1Un8tGjGZnp4yZBFfuHBDvQN7xyIU5/fvlWW11I3zs8r0qJiaOrhmdRWm+/cIlZ
         nhz66LfLmuBF9sLZ/z2ar7PaBU8WOUtnKibAUMxFURifTYF/5pRlz2dAHYlHEsJqEOig
         5+UKoXtWVBZwze6xnUm5fat41kk+3MA11TW9DoJ899Ryd0YvMwGKT2qJyt4LHU8J1c2h
         z/AGK4RmROTQXT3g52hp/WalCKjqLw0ZYXxJPhJrNaoxSdOlKGn7yAnT0aG3q5uwNNjK
         JjFA==
X-Gm-Message-State: AFqh2krDzqCsfXDdX4v3geWOvZkd7EIaPwh7GRrNw1oaXd3QodQogdA2
        ywq21kqaW3SD3I958Ns1KQ46Rg==
X-Google-Smtp-Source: AMrXdXuPV2x7LUIyKJ2bgEVRoXBdmp8FuAYdkb702LTqrQdwWYBCkc8H47LxWuVyUOVifyalSD3xIQ==
X-Received: by 2002:adf:de88:0:b0:2bb:e864:7a30 with SMTP id w8-20020adfde88000000b002bbe8647a30mr7331280wrl.32.1673392920931;
        Tue, 10 Jan 2023 15:22:00 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4091000000b0028965dc7c6bsm12192345wrp.73.2023.01.10.15.22.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:22:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <6dcdd143-ff1c-41f7-9f46-0c4505575669@rivosinc.com>
Date:   Tue, 10 Jan 2023 23:21:59 +0000
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9061941F-3221-467D-B0FC-DCA8E8FF3996@jrtc27.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <01AF458D-1EDC-47D1-A902-A686E2DF26AF@jrtc27.com>
 <6dcdd143-ff1c-41f7-9f46-0c4505575669@rivosinc.com>
To:     Vineet Gupta <vineetg@rivosinc.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2023, at 21:50, Vineet Gupta <vineetg@rivosinc.com> wrote:
> On 1/10/23 12:48, Jessica Clarke wrote:
>> On 10 Jan 2023, at 20:18, Vineet Gupta <vineetg@rivosinc.com> wrote:
>>> This implements the elf loader hook to parse RV specific
>>> .riscv.attributes section. This section is inserted by compilers
>>> (gcc/llvm) with build related information such as -march organized =
as
>>> tag/value attribute pairs.
>>>=20
>>> It identifies the various attribute tags (and corresponding values) =
as
>>> currently specified in the psABI specification.
>>>=20
>>> This patch only implements the elf parsing mechanics, leaving out =
the
>>> recording/usage of the attributes to subsequent patches.
>>>=20
>>> Reported-by: kernel test robot <lkp@intel.com>  # code under =
CONFIG_COMPAT
>>> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
>> This code is full of buffer overruns and uninitialised reads in the
>> presence of malicious files,
>=20
> While the outer loop is bound, indeed the internal pointer increments =
could get oob.
> I don't recall seeing existing explicit "safe" pointer, so thinking of =
cooking something up.
> The conceptual idea is to replace
>=20
>     p +=3D 4
>=20
> with
>=20
>    PTR_INC(p, 4, p_max)
>=20
> And similarly replace
>=20
>     while (*p++ !=3D '\0')
>=20
> with
>=20
>     while (*p !=3D '\0')
>           PTR_INC(p, 1, p_max)
>=20
> Is that sufficient or you had something else in mind.

I=E2=80=99d be very careful about obfuscating control flow but how you
implement it is between you and other kernel developers, which I don=E2=80=
=99t
count myself as.

>> and fails to check the version, vendor and sub-subsection tag.
>=20
> That is now added.
>=20
>> You also should handle more than one sub-subsection even if tools =
don=E2=80=99t
>> emit it today.
>=20
> Just to be on same page, a sub-section implies the following
>=20
>       uint32:len, NTBS:vendor-name, uint8: Tag_file, uint32:data-len, =
<tag><value>....
>=20
> If so, the code does support multiple of these

That=E2=80=99s a sub-section, but I said sub-subsection.

Jess

>> You also have an unaligned access for reading the sub-subsection=E2=80=99=
s data
>> length (maybe that=E2=80=99s ok in kernel land, but worth making =
sure).
>=20
> True, I've added get_unaligned_le32 for those now
>=20
> Thx,
> -Vineet

