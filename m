Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2BB73BBC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFWPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjFWPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:36:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304112116
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:36:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3909756b8b1so482805b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687534566; x=1690126566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9CymSRMDbqHIro+JW8XfRWWOAA5tcI4JPlypVJojtE=;
        b=Pf+IdItQ+K7ft3zprVXyNENnCmGH3dYMxT1fLOl9w4HG38AetOQbLU2CWhjQE7/wrb
         z6EFB6v1DVPj4Gj/KUd/i/q/D9WcsxPpSD0JEGFhLK251PPkuWryOYQV7mj2XzqT6i40
         783h5cO75omYeCslDqu1KZ2qxl32r/B3aTjm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534566; x=1690126566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9CymSRMDbqHIro+JW8XfRWWOAA5tcI4JPlypVJojtE=;
        b=jbXjIqefI185dsbHwpRuCF1XNv/Pa1WObljLxBh07yoQuV8XJmUzq98zF+J5V911RX
         6x8Cw9b99IYYs32qTJuXJS9UV+EHwJK53h4zP5kncBthaxuyDnzWLdcGLX40tdbnORK5
         KElU2OxKT+CjXCgRQqxnrFcy7LsV1EO7jycPvXRwFD3K+2eovySCNdj1RzwIDAWJvLhX
         O/oAwuAsu5XygOgDlGynzNWWIUOO9tFKAjxLvLK53pAr/yotvJ1PXWi/LxOPqrhuhr6d
         aPdVHSTC5q8++uWp91Fynncy2se0yGAzS+2pNVHDgtdnS57lupfuNRaNijFAtPqXP4fa
         n2hg==
X-Gm-Message-State: AC+VfDxngaQR2uuy5LbihM/Ecdr5G9tKaKsoxE0HBzRJE/3fRWYkqGcE
        zjNOaQDzhjrzFm7VGa44Oi/TEsZCF2I8c933E0nBFw==
X-Google-Smtp-Source: ACHHUZ6DrDzdNIVXxAvx+TDFfseQBiZYeDasVgGvYaxuMsethdsP9RLn0x0lPg7v26V7PlRq40/fpnKgOZISMPftpDQ=
X-Received: by 2002:a05:6808:10c3:b0:3a0:4feb:41bc with SMTP id
 s3-20020a05680810c300b003a04feb41bcmr8168171ois.29.1687534566267; Fri, 23 Jun
 2023 08:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230623152204.2216297-1-arnd@kernel.org>
In-Reply-To: <20230623152204.2216297-1-arnd@kernel.org>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 23 Jun 2023 17:35:55 +0200
Message-ID: <CABRcYmJcCWTNHZjh2m75wKUzpvH-vkhkOaG87CU=ZXpDCzrZFw@mail.gmail.com>
Subject: Re: [PATCH] arm64: ftrace: fix build error with CONFIG_FUNCTION_GRAPH_TRACER=n
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 5:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> It appears that a merge conflict ended up hiding a newly added constant
> in some configurations:
>
> arch/arm64/kernel/entry-ftrace.S: Assembler messages:
> arch/arm64/kernel/entry-ftrace.S:59: Error: undefined symbol FTRACE_OPS_D=
IRECT_CALL used as an immediate value
>
> FTRACE_OPS_DIRECT_CALL is still used when CONFIG_DYNAMIC_FTRACE_WITH_DIRE=
CT_CALLS
> is enabled, even if CONFIG_FUNCTION_GRAPH_TRACER is disabled, so change t=
he
> ifdef accordingly.
>
> Fixes: 3646970322464 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/asm-offsets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offs=
ets.c
> index 757d01a68ffd0..5ff1942b04fcf 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -213,9 +213,9 @@ int main(void)
>    DEFINE(FGRET_REGS_X7,                        offsetof(struct fgraph_re=
t_regs, regs[7]));
>    DEFINE(FGRET_REGS_FP,                        offsetof(struct fgraph_re=
t_regs, fp));
>    DEFINE(FGRET_REGS_SIZE,              sizeof(struct fgraph_ret_regs));
> +#endif
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>    DEFINE(FTRACE_OPS_DIRECT_CALL,       offsetof(struct ftrace_ops, direc=
t_call));
> -#endif
>  #endif
>    return 0;
>  }
> --
> 2.39.2
>

Acked-by: Florent Revest <revest@chromium.org>

Good catch, thank you Arnd!
