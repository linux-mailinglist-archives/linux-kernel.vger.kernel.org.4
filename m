Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27E66D66C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjDDPGv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjDDPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:06:49 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E43C2F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:06:48 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-544787916d9so618566787b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwzDPt+9Axnp6bNzN+6EpAA+HQRFVNX7yH6ulz2lZ88=;
        b=qgaR7eW0kJgtUewGlR8rFg1TY2t2Rd+EoSDVC8kqrCSA3GweazF3yzWAQLFV1+DwtU
         I4Owu0mjth/1ezL3Q2w99GzBAmYUUczyKD1mkO+h+p4bTY6eSXluzAyqIas0l0mjiXMV
         ho+VyHeiFYrubFqEmFne2h5BFeSFfWqbGuZS2YsRt/PEzYomL+9qJvtSib9WbdyQyjW4
         B7VIXoaE844CbhgZokq9ENgKRtYyAkr6nyGLt76PT3Gnm9sW4d3HlAFZoOuoc5bjTY+8
         pBHJnSxqWuu6Y8nTBg7ArYJKIsV+fcWPHAt3aYEl4vFrpk2x9yxwEX9EBX83skgSSNnr
         ieIQ==
X-Gm-Message-State: AAQBX9ciygBV5zMr9+L3tWjwPOtDCkfwJTrhQM+34kvUZyT8WPA2J0n6
        QjJMhGlCINFDb2zuQLhp96zfE2ksW2CPsZ5A
X-Google-Smtp-Source: AKy350aZaaLZqKOEoI+FVaecc0iCkW3FVYpMfMGtlSPFxi7VwNBRvpWnksZKFtJAfEskKjBLAXpsGw==
X-Received: by 2002:a81:6c10:0:b0:536:cb48:9059 with SMTP id h16-20020a816c10000000b00536cb489059mr3209248ywc.50.1680620807274;
        Tue, 04 Apr 2023 08:06:47 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id dg3-20020a05690c0fc300b00545a08184fcsm3200872ywb.140.2023.04.04.08.06.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 08:06:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5463fa0c2bfso288705277b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:06:46 -0700 (PDT)
X-Received: by 2002:a81:440f:0:b0:545:5e70:323f with SMTP id
 r15-20020a81440f000000b005455e70323fmr1593040ywa.4.1680620806640; Tue, 04 Apr
 2023 08:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230403065207.1070974-1-bjorn@kernel.org>
In-Reply-To: <20230403065207.1070974-1-bjorn@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Apr 2023 17:06:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+sqGB5V4LZAcHw_4n6=ZVPs_v0uB9V-sPTUL1EpL6eg@mail.gmail.com>
Message-ID: <CAMuHMdV+sqGB5V4LZAcHw_4n6=ZVPs_v0uB9V-sPTUL1EpL6eg@mail.gmail.com>
Subject: Re: [PATCH] riscv: entry: Save a0 prior syscall_enter_from_user_mode()
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Yipeng Zou <zouyipeng@huawei.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 8:54 AM Björn Töpel <bjorn@kernel.org> wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> The RISC-V calling convention passes the first argument, and the
> return value in the a0 register. For this reason, the a0 register
> needs some extra care; When handling syscalls, the a0 register is
> saved into regs->orig_a0, so a0 can be properly restored for,
> e.g. interrupted syscalls.
>
> This functionality was broken with the introduction of the generic
> entry patches. Here, a0 was saved into orig_a0 after calling
> syscall_enter_from_user_mode(), which can change regs->a0 for some
> paths, incorrectly restoring a0.
>
> This is resolved, by saving a0 prior doing the
> syscall_enter_from_user_mode() call.
>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
