Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F976E011B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDLVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:45:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4971FD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:45:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fbb713301so3499497b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681335929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XthPmCYaivHZIwtWQ/LnLricsPrqMX3nZnKrC+JcB1k=;
        b=oCcKhu9VMCRHVy6bIf2Km6fG1pha41/bl1YLBWZ7m4m5TOQ8LcLN/9EEKpgQAhUsK3
         I+PGzroWzwCwCmEWaNdZN5XOEOjdnCqbs+M/gpumBSTmekCoRpsYmJZTE/lB7HrvbJ4g
         qDL2iBlTKD8CD/vKltwGZSGBB7nHgryhP1mr+gzFs55uCMr5jTjAkMee0HUJzXr1kPLc
         rxlcMuUARbTL0vUS5/EeS+u4Kxm/YmV5PY4lL/jmDIU4V999XxUhvvsP1+92pAKQ8WTx
         AJOftcnbgYQvEAe0fbKtADvDI1ivhZIofl0j0PhvmoZ+t5LtLPZiLct2Vmjv+MSz0dZ8
         j2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XthPmCYaivHZIwtWQ/LnLricsPrqMX3nZnKrC+JcB1k=;
        b=j6MW7kaQ/UTkl/eifErywCWa8fgo6hSiimikHuvTaqRgqcLrd8zzrs6cveD9VljA/3
         XRO5WmEcymIGvAg7xa7sgMtYnyW/wwvbJMb4Jsdgw4NQZsOIl8Qw/K4jOOCNZF/PoW6C
         D72yPwQVynndWwp75ZqdY90U1PEHwwEKXBIAtilx2/EcQ5NzhKP/Zrk+Hj++s0WqZzWd
         vrO7lO4WShXTAGZleieDx9vpvMsfKecuhSRJeSK8+09/MbiSJIngIwXaSHz+92enOLWU
         3bzEUuW7ycMYDps6CKcIRoNYJqljjznR9BhxyDJmm9FNeFtxY/zh727nefK3P0ZgDMRi
         PGOA==
X-Gm-Message-State: AAQBX9fXQN2dUA94KrCR2//SHxv0TXWCqQCfvyC/yO6lryF+4OcnPxzV
        MfGccH3l+cr1/zExuA61c7xkZsrszGLS/3G5uiRbiA==
X-Google-Smtp-Source: AKy350ZiX3xDzWpCzxdn8YY44w716/xqsqYL8UP7mUWmHLD2jMUfjPFTrNVUMmlAms7bl/lkPcd2ya11zh4XAxh1djM=
X-Received: by 2002:a05:690c:730:b0:54f:899f:890f with SMTP id
 bt16-20020a05690c073000b0054f899f890fmr2917768ywb.9.1681335929036; Wed, 12
 Apr 2023 14:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net> <20230412212126.3966502-4-j.neuschaefer@gmx.net>
In-Reply-To: <20230412212126.3966502-4-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Apr 2023 23:45:18 +0200
Message-ID: <CACRpkdY1XQqz84cHVHhhbphKqXMtxVFs3TPLeEb7YHjzKu0K_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: compressed: Enable ZSTD compression
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:22=E2=80=AFPM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> With the previous two commits, it is possible to enable ZSTD
> in the decompressor stub for 32-bit ARM.
>
> Unfortunately, ZSTD decompression has been quite slow in my tests
> (on ARM926EJ-S, ARMv5T):
>
>  - LZO:  7.2 MiB,  6 seconds
>  - ZSTD: 5.6 MiB, 60 seconds
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Disappointingly slow, but not all systems are 926, and
not all memory hierarchies are as slow.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
