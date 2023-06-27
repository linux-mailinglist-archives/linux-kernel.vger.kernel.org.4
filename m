Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9173FC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjF0Mkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0Mkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:40:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C064213F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:40:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so43209115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687869604; x=1690461604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsX4SXg32pBoD8x6wheSWux3YvW6+LLlu5lLGvU4A08=;
        b=NYX4MwTDi6LDbWSS2P+1hTN3MClyVGAhhslCEAPQIKnmlnbe25HJjHhRIRBb+f//w3
         nsQztM7eoHxIWyjwPGDxcj6LrpYH6y4eQomxbFNJf9Js/a58EDwYlrfg+o5z3iFSd59z
         dlHxlGieOEHIow0lzEbjmyEzYo562R+2dcbl60VsU06s8+uF75/daPwM4dSCJ/8TGI5d
         4Xj9xEPxkZFJ08TX/yQTOxg61XdHXSYPYr3HIGlX7E4m9i80/RaucMWtOvk/blq/dF7D
         iK8Gt0LCi6jYQiD60h50H6vu70SuJ+dwOA/RJkux6e0a+jfnzIRp+Rt02YyRzNh+0Qi+
         PWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687869604; x=1690461604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsX4SXg32pBoD8x6wheSWux3YvW6+LLlu5lLGvU4A08=;
        b=dblJo3GDW6T9RN/5ce0M8ZZTxRXs+HMqVQ/RgGdlOHYpcpE8OtG+/NgVxvuHfkdCUa
         yeBFwCzRKS9bGLKWJYi6hXYjiEvAX8Kzt8gi4vnA4X0nJSOz4RP10owrTTvqKilSJdPr
         S06M9PQ33pQXN0sqc7zVvBZ6iOZa61DuqvuQOeKJ8tWKjRD0NAR8H3XJnD5Imugtdm4b
         ePd8+kxNNA52nm42vko7prhnFeFCSGSQjZnk/sZoJvRy5fjUeZqcg6fBODMmI3qMQIEJ
         eFasvo8Y/guCezruH9MLPdN5AfnMZu/aX2vPP745c4WfJcKoSLHbBFBJTLw4KzaarwSh
         P+fg==
X-Gm-Message-State: AC+VfDxkRJavrwkgNWZGpj8+vd8J8voq9lFQcoGjNbE73F+7rxeUPH0W
        19QXNnB5fyb7pfQNNb3JkgWDtQ/7/QOcHKbee09ecw==
X-Google-Smtp-Source: ACHHUZ78ealNaCFybT1aaDdFLU+JvYWx1kK5RakJszJjSRojkVh7ReDH9O/FAivG5fdaAExlu+rmt39S8z/PbXhiVIw=
X-Received: by 2002:adf:ee51:0:b0:311:1dfb:2907 with SMTP id
 w17-20020adfee51000000b003111dfb2907mr21187428wro.68.1687869604088; Tue, 27
 Jun 2023 05:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
 <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
 <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
 <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
 <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com>
 <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com>
 <CAEEQ3wkT_2GbdsjfA_VA+LeyCzdeQ+Bh+admyVjz7rE3cSWSxA@mail.gmail.com> <CAMj1kXGT04HeMqmr7BWYaNQM6jYzYFLGEJY7TNtig-t48n7CLg@mail.gmail.com>
In-Reply-To: <CAMj1kXGT04HeMqmr7BWYaNQM6jYzYFLGEJY7TNtig-t48n7CLg@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Tue, 27 Jun 2023 20:39:52 +0800
Message-ID: <CAEEQ3wmd4XayKV8BCk+1CZVDXdtCa3vvbhfJyhfkkBccE3fo6w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

>
> I will defer to Mark or other DT experts to help decide on the naming
> and general shape of these.

Okay, thanks.


> However, as I have indicated twice now, it would be better to describe
> the SMBIOS structured data directly, instead of passing the physical
> address of one of the existing entry points. This avoids the need for
> mapping and reserving additional pages that don't carry any relevant
> information.
>
> So the node in question should have at least (base, size) and the
> major, minor and docrev version fields.

Other platforms also need related memory to store this table, don't they?
Coreboot also completes the construction of this table according to
its existing code, rather than creating a new description method.

Furthermore, As we discussed before, SMBIOS-related code should be
placed in the general code, and an entry address is required to
connect to dmi_scan_machine().
according to what you said (base, size, region) how can it be
connected to dmi_scan with an entry address?

So, For SMBIOS, only keep the smbios part in drivers/firmware/ffi.c in
this patch? If yes in terms of code structure, I will update it in v2.


> SMBIOS is a separate set of firmware tables that have little
> significance to the kernel itself, and describing it via DT makes
> sense.
>
> ACPI serves a similar purpose as DT, and so having both at the same
> time results in a maintenance burden, where the arch code is forced to
> reason about whether they are consistent with each other, and if not,
> which description has precedence.
>

Well... I don=E2=80=99t want to discuss too much, according to your
suggestion, To implement acpi_arch_get_root_pointer() under
arch/riscv.
I'll update it on v2.

> If the firmware uses DT as a conduit to deliver the ACPI system
> description to the OS, it is probably better to pass this via the
> /chosen node as a special boot argument.
>

This is not the focus of our discussion this time, and we will discuss
it when we discuss node naming with DTS experts.


Thanks,
Yunhui
