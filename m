Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0B6DC537
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDJJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDJJmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:42:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A01FDD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:42:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id be27so4743485ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1681119728; x=1683711728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6HIMp5HPIYwzx39Zs3ERp+4XjFzUpn9IkIJmmm8N5g=;
        b=kTa1s8ObzL4x/scAUIpJ5lnCr3TBiHpj8kYi+LxKtdJi5MlPMYRV6fk5+XFsisYuWQ
         e3lDPNPGSxDtqEUomY77DWJNbyyehG8TRP4t3CvYblUwhNDnir8+TYvPQMS5FqEYxHdX
         h6cv75u9H4BEiGWMghObNIFHErPcWHQUfScn8nvb8BddTfqxAM8A8ZE0ghYNsC+dcc/3
         TH2hXdVb6vN5/jKkI6FbZgdole8hP+pslpBmxYs9DzrnkiijnPrc1AC22/x9uuXZwNAj
         wHzZTzxxg4rGn3KKH8UGweCQ1lnVu5TTp5WsjPwrqJdQvYqk+lrWFVdZSHJDRUGWhOTy
         noUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681119728; x=1683711728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6HIMp5HPIYwzx39Zs3ERp+4XjFzUpn9IkIJmmm8N5g=;
        b=JjxlXy2KjZQDkw7wyk43/mEHD70t3bzJ/Y7F97XNa05GBY0Km4oWqnl3QSPN6JNZPo
         Um4A1OB5kd/lBOuGmWQMScbjfFdjjerfFyU5HNsFhcp5PO7v5xGGFjCYDHMDm20afVhi
         lwnKilPbOFfaECsH0Egru7ozPTczmVJTutFLcop/iEmzJXSIVLzCg5aW5p+qZrh2ZKcf
         XFTOoJe98yUY4LqAgElunBR+IMAI+7M8eDw9Z/uarX16Sxhf89rcDvqnqz+Ut3yDVs5J
         Rcu2WOfsjfovJc1OBwJKM9F3CnpHlVRiWPTswvcYjNGT9cRkYfJjPfc2I+s3Hq0lusWs
         BPyw==
X-Gm-Message-State: AAQBX9e1xVM54YSbGuQ9L8+j6k05NbT7+/6sFVfsUi+rq+VW/6iu0CwJ
        QXIP63vYWkOlvhCjTHswpUQZxfj7vK0B0YGhA5pGhQ==
X-Google-Smtp-Source: AKy350bk6w46vlv6oRG+v+DFoajxTbsMMyTGBokCnqcMKDJJwxvpqJXqumF0482SPhELKGlTRrK5F53lVgP8PaGeCn8=
X-Received: by 2002:a2e:9f44:0:b0:2a6:18c0:2b3e with SMTP id
 v4-20020a2e9f44000000b002a618c02b3emr2659377ljk.0.1681119728564; Mon, 10 Apr
 2023 02:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230403065207.1070974-1-bjorn@kernel.org>
In-Reply-To: <20230403065207.1070974-1-bjorn@kernel.org>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Mon, 10 Apr 2023 17:41:57 +0800
Message-ID: <CABgGipVHV9C3QwsCkaU+ecTPqhdztn7EwWOr1Hc1ETqEWhhdxQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 2:54=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
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
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

This fix works for me, thanks!

Tested-by: Andy Chiu <andy.chiu@sifive.com>
