Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572DE6F2585
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjD2RtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2RtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:49:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A3183
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 10:49:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ba23a2abso8935501fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682790553; x=1685382553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PojX7n9y1aOGyHyL1VmBDz4x0J1ICc3U37mnhGQzRqw=;
        b=AwozKjrJpvKPO20JkTdZKpX7tX9aSjJb+RjAdf9DpdhiejGiMjOtxO4g2VVLucmke/
         imbfKbMa3zOgsL8SMg5k8bhbuiNJlCzh8i/Y/1V3Gosasoz81oK5F3LGlMfZouoMcVx3
         kEeHH9dYfsW+kes2zyZImeZ/HU6ECCeRricaa3qoJExbX31DuuXOwZTCQQVnkIvRbWrw
         RMIOy/kaztJxJ50Ky3zYcXCN0BCZxhsyULr8DVBTpoJh1Jt3xYEDEfbHgaz9U2+lIzPx
         MSJv+jG1Ej2uQUhNsyXtE99ZgKiDwU/nvWvwhWXtFqBhHz6W22B9ayL+5fD8Ptk6xqHA
         6F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682790553; x=1685382553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PojX7n9y1aOGyHyL1VmBDz4x0J1ICc3U37mnhGQzRqw=;
        b=lUBh8tReK3ylyNgJyqClY//DNJXK8AFZTrSPzC3kYkq9Lah06pGgwgZMcDVCVF2/8n
         iuZjRAAzKzUer+nUZ72R8ANH64N8gPkONxCM/EaQyuTi5RZyseyAGl0prsj9xP47Na7f
         CfGpc8mKzTu+WlShaxKpfJOVGpF6DEG919i0YPyp/zQlqy1yiKYMCtW/n7og30nYZpzd
         EKxhfBXzynXteSHp0Z3j0XzxL+ityWOFikU9bCX1bBuvwAnk93411enxpEaSBqJR0yBd
         d6zkJ4VjsmsCeMU7D1no3DzEnjdz4BEiLakleevJviU5uz4kqdzToWOozXNT4KZf0K8c
         WCFA==
X-Gm-Message-State: AC+VfDxWeLC6k4NGeqkmAgki19RfkJHmmZm5t5MEbi9J7/iBZWABeuuZ
        7bBLtHQ8EnxbZqyGUUqahJgjCEeDmRBc48gjdQTeGA==
X-Google-Smtp-Source: ACHHUZ6lrMlBks2CRDNnvyjN4qwXhBuTJUOiifSCIb9PA3+jMjw2vMD7tZeVz7LwgYa3vAcLAAUMpsmDCcs6DFU2rmg=
X-Received: by 2002:a2e:9d13:0:b0:2a8:c45f:9fd8 with SMTP id
 t19-20020a2e9d13000000b002a8c45f9fd8mr2078374lji.44.1682790553046; Sat, 29
 Apr 2023 10:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230429155247.12131-1-rdunlap@infradead.org> <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
 <20230429-outboard-hypocrite-983e977103d2@spud>
In-Reply-To: <20230429-outboard-hypocrite-983e977103d2@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Sat, 29 Apr 2023 10:48:37 -0700
Message-ID: <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in errata
To:     Conor Dooley <conor@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
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

On Sat, Apr 29, 2023 at 10:24=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Apr 29, 2023 at 10:21:39AM -0700, Evan Green wrote:
> > On Sat, Apr 29, 2023 at 8:52=E2=80=AFAM Randy Dunlap <rdunlap@infradead=
.org> wrote:
> > >
> > > When CONFIG_MODULES is set, __init_or_module becomes <empty>, but whe=
n
> > > CONFIG_MODULES is not set, __init_or_module becomes __init.
> > > In the latter case, it causes section mismatch warnings:
> > >
> > > WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fil=
l_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init=
.text)
> > > WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fil=
l_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.=
text)
> > >
> > > Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_=
features()")
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > > Cc: linux-riscv@lists.infradead.org
> > > Cc: Conor Dooley <conor@kernel.org>
> > > Cc: Evan Green <evan@rivosinc.com>
> > > ---
> >
> > Thanks, Randy. I'm confused at how I didn't see that when I made the
> > original fix. I feel like repro of these section mismatch errors
> > depend on some other factor I'm not understanding. In any case:
>
> Perhaps you had a cut-down config that did not enable either of the
> relevant ARCH_ options to get those errata compiled?

It was weird, my original "fix" (the one listed in this Fixes tag) was
needed because while the hwprobe series was clean on Palmer's branch,
it generated a "section mismatch" on linux-next. As noted here, it was
only with !CONFIG_MODULES, so I explicitly remember generating that
config and checking it on linux-next to generate this "fix", and it
came out clean. It's like the robots are getting smarter.
-Evan
