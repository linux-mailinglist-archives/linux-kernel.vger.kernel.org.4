Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C329B748F27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjGEUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjGEUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:43:39 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC5A19AC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:43:38 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7659db6fb4bso57135685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688589818; x=1691181818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLtlZez9GAkHzasHFvmV0dDR+vDOeVbGvtxiizQEwv4=;
        b=qoJ/WcInnMvxpe/7GYFg2GXpLKxlltJ2gqvaiqY44B6DdIWAU+YP7JMLutJNgP2G0p
         PS8eidSRJn3Fl9ZhTpgMUdMGP9jXV/2myeCTFXsR1jOrQlsxSti0P/bFqLgGGAnLNjnm
         Y851GXtefxphylLWbgQlxgBzgZhgWRyCqfiSDetpCtO/Xi0C543Cw6dwegH6QRbcXoUK
         RcSYsRYqN8niT0QAh6V7Uc6lLPp1u39bDKH1+LKlV2xKlfXmkeXr8NFZY+UGFtYvuWAR
         xHsfrwwatncC14sspoLrcoiGsd+1VNKlXU7OakZirS5BPjzbW4TH/OzYlR1bQONPJgx1
         IimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589818; x=1691181818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLtlZez9GAkHzasHFvmV0dDR+vDOeVbGvtxiizQEwv4=;
        b=V653cB9o0j3SwxZYCI3HKOTCGc+ZYsYkp0xizcF67eSFamv6oR3qiQwwIaSOy9EGet
         1VFExxVoxuiYPUYOt2x7kWg1tur8pwGtXP0FvMRMeUjyAVM0v2CgnM41VXDI1nfcesIW
         VuaQb5xIfZ0rhwVUw+ltbDotBUI4RE4lFJJuWsCskMl/0rocSnkcVX4B7b/uxs36ZXdV
         ktvJP2wPs18zEgCQi7R1Dn65I5lOxdXWoQjfAu0uma7GZTf8pHZqwkoOULQALW0DBAHO
         VfpiukEUfmsJNjMOrABfcjijBHnUHwx0OmZcEWxZ8VqJcjurt7KHiqKtQN8mV57jRjgS
         vWog==
X-Gm-Message-State: ABy/qLbDBkJgYHbq/HkXvSuNoJG/jTLmWkwd3Vr2H0I24XTtzLPIb6L/
        Ybsth6InP7Wv3nThVoWSIHLhNLzmcaA9B1KOLdgdpw==
X-Google-Smtp-Source: APBJJlHbB9as3fe+0u2+Ip6pMscKC0JFWdREHMoggTYXzbM688weDbz0++Qq4UE/yyF05PLEILCR1aFPSluIC8MNkps=
X-Received: by 2002:a05:620a:29d2:b0:763:bac8:39c4 with SMTP id
 s18-20020a05620a29d200b00763bac839c4mr4044453qkp.18.1688589817815; Wed, 05
 Jul 2023 13:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-14-samitolvanen@google.com> <20230630-rake-clubbed-bba8a9c27219@spud>
In-Reply-To: <20230630-rake-clubbed-bba8a9c27219@spud>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 5 Jul 2023 13:43:01 -0700
Message-ID: <CABCJKufa=TpydWsCY5QotC9a+hUHUwkpfMsC07BMwv6-VuzdCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] riscv: Allow CONFIG_CFI_CLANG to be selected
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:08=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Jun 29, 2023 at 11:42:51PM +0000, Sami Tolvanen wrote:
> > Select ARCH_SUPPORTS_CFI_CLANG to allow CFI_CLANG to be selected
> > on riscv.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 20a40927175e..2699e1f8fe33 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -44,6 +44,7 @@ config RISCV
> >       select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
> >       select ARCH_SUPPORTS_HUGETLBFS if MMU
> >       select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> > +     select ARCH_SUPPORTS_CFI_CLANG
>
> Please add new entries in alphanumerical order, thanks.

Sure, I'll fix the order in v2. Thanks for taking a look!

Sami
