Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FD76F256E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjD2RWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjD2RWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:22:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A9199B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 10:22:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f0037de1d1so1330730e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682788935; x=1685380935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5lxPzrjhYS+x8oV+yPDIMaFlDt2g4rI2Bd9NsNsMYo=;
        b=D+EFxaAeeM/Mdzjqd66XMj4wliYrzQAG+DP4ocl4uRm12utnu0JmZr/0Gyj4Obx9MY
         UhVF9pToiXvNOCpbgKBQaVRS/wlvwBXn0cTancqDm/MlsL3VRWfro3CjuYU5fDe15/ge
         DPYRwGhV8AszcDxRGNf5pi8XgQlWMrO/z27sePr3CPKyeGWv5UjrR4Tjbnsul1lDWPix
         FroV5od2nVYzRP6ej4bWDaZNXx2Q9LWSwWdfVzcoB/sT6NI2pCy8d9KTX37Pjg7AnuGv
         sAipPqULobXzeHf3e9nRuEPT5GZ21yDk66uiQUqM9CJdoXmHN2mIPfqiFrJnGEONVnJj
         yXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682788935; x=1685380935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5lxPzrjhYS+x8oV+yPDIMaFlDt2g4rI2Bd9NsNsMYo=;
        b=hY3a6mOcwfL8YbNaUQZHqY1WrtTX6PyYmYlacf/SB0mt6Of1lVN/UPdNXERpPimZDS
         J5jKqwXFMp4ndGqCitENZmBC3BE2eUYcO3IdMocOhpfAlpeZm9YTgN2URZvtPMvzqP9N
         uegTql7zImQP1ZZyxOCyPJQonRhKRoucyCAMcsEnulTVfMfU5L7rNI2flO6QVZCYGOXT
         7OioS2d6s80flAHvP/ActHE8JtFARZOmzt4IGKLn1ee2dbkU8jhmiWDO9boXSdrrQy4R
         ahk6bs+l2Nh8Qxo9reMygxxdiZG1do2an4DLtHRS/XMhukPdkdZr+4AG8MFNRmrLy52U
         ZvhA==
X-Gm-Message-State: AC+VfDxiSU5vywu6QdNbfdoV38GiTw+wfCojOY1DeOlJtU2JydZAc4pu
        ofrP9ojmuSfXT92UtDBCPEiBG7ITn+gSKXIRq8pTng==
X-Google-Smtp-Source: ACHHUZ7ZGFqRXHelEmVWQ/SZrSKIX1h5xJuRe82tOvkh5riAOmsfNIENLCkrrCgnlJcWBNx0eE4Ii2UJu2hPscNca5Y=
X-Received: by 2002:ac2:4d18:0:b0:4db:4530:2b2d with SMTP id
 r24-20020ac24d18000000b004db45302b2dmr2511668lfi.49.1682788935606; Sat, 29
 Apr 2023 10:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230429155247.12131-1-rdunlap@infradead.org>
In-Reply-To: <20230429155247.12131-1-rdunlap@infradead.org>
From:   Evan Green <evan@rivosinc.com>
Date:   Sat, 29 Apr 2023 10:21:39 -0700
Message-ID: <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in errata
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
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

On Sat, Apr 29, 2023 at 8:52=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
> CONFIG_MODULES is not set, __init_or_module becomes __init.
> In the latter case, it causes section mismatch warnings:
>
> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cp=
u_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.tex=
t)
> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cp=
u_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.text=
)
>
> Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_feat=
ures()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Evan Green <evan@rivosinc.com>
> ---

Thanks, Randy. I'm confused at how I didn't see that when I made the
original fix. I feel like repro of these section mismatch errors
depend on some other factor I'm not understanding. In any case:

Reviewed-by: Evan Green  <evan@rivosinc.com>
