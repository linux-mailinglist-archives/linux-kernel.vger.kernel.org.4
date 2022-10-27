Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4A60FD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiJ0QhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiJ0QhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:37:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FF18E724
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:37:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i3so2086451pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/U6QNXQ/xCPGTTB1SAGiuHHJBka8um7FPSVO88evHYI=;
        b=VSrXHgK1wthxTiSvcuhaQbjJeIf88juMO1vdkrfo8WfFh1W8lrjC/FEAR/tfSGGiaI
         MwL2e/KdbjhhU5Mvx64WTzDvM28en1ruz6tMYyq71mEdM2mUXPl7YsB9GXfSG3zXUdL3
         U0JN8NqLuwTvA7DsT/+Z2LG8SnF4BakmBHO6rvnjvJ2wyzmZ82j7VbOXOvCM4FTenpjf
         LUXfcAQJLSbblvmH06iJVgcMmmP76BqS6KGm/FBWFP1CkRZ14QuwLiNAFLMCuAx/VC3X
         y1k+lyPjJvUOCVaMMDcxwoNJbPK7skwJ05kKMxPx1sab1r+g80HAIayEjDwr2Z3Vaz1U
         tTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U6QNXQ/xCPGTTB1SAGiuHHJBka8um7FPSVO88evHYI=;
        b=3a9cGV4H1YW1iP2+se3GqrLpg9rexhLbMtlMcEl8RRUh3U6pkJVJkwtvEpXJjJinId
         djiLn7caLYgq9GtmySS9VZqGPBk4A4YlhxQuWSRrT0QJ6bGfEriGtNmrn9DF3lwAf/9t
         AUK3nNCeWN31V2LWvzcrviZGUmMa/2pEQxEkWEj99+B3C0p3VuG04vCw/BYd2hMGe2Oa
         /AqRNX2hE9PgVCh1FbrSWEZhpB/kxOJndrCcbHecl6QCQSAfK2r7rcaNoCgJrcXuUjdk
         LYZgaGuRBb08FvFjNr/TlZxHR065szhkyRVNJ4LAqrzVs6dbPl7/uh1WZBzBzw8QZtb+
         4lug==
X-Gm-Message-State: ACrzQf1DUJZyZtv0LHgkZAAg+umzk2kFLUwqJeHRxze/orw9f3KsFNWl
        MFVW/2eA/irRq81Zc+F5140cr/hlV6p00Cxam7b7FA==
X-Google-Smtp-Source: AMsMyM74RkehYChf05WveFojOxGE9ShcFGDHudhN3+Bi2xfxS50UVNk6k4zl48d16veCpcNgt4M8U3ECMEQxzyXkjHU=
X-Received: by 2002:aa7:83cd:0:b0:563:5f54:d78c with SMTP id
 j13-20020aa783cd000000b005635f54d78cmr51545714pfn.66.1666888628868; Thu, 27
 Oct 2022 09:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221027162839.410720-1-masahiroy@kernel.org>
In-Reply-To: <20221027162839.410720-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Oct 2022 09:36:57 -0700
Message-ID: <CAKwvOdmDFxr_PgY4WK392zCgs2QGxrsPfWoX=5h+y3R5r1xrJA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: fix SIGPIPE error message for AR=gcc-ar and AR=llvm-ar
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 9:28 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Jiri Slaby reported that building the kernel with AR=gcc-ar shows:
>   /usr/bin/ar terminated with signal 13 [Broken pipe]
>
> Nathan Chancellor reported the latest AR=llvm-ar shows
>   error: write on a pipe with no reader
>
> The latter occurs since LLVM commit 51b557adc131 ("Add an error message
> to the default SIGPIPE handler").
>
> The resulting vmlinux is correct, but it is better to silence it.
>
> 'head -n1' exits after reading the first line, so the pipe is closed.
>
> Use 'sed -n 1p' to eat the stream till the end.
>
> Fixes: 321648455061 ("kbuild: use obj-y instead extra-y for objects placed at the head")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1651
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Looks great! Thanks all.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - Update commit description to mention llvm-ar
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index e90bb2b38607..e9e7eff906a5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
>        cmd_ar_vmlinux.a = \
>         rm -f $@; \
>         $(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> -       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
> +       $(AR) mPiT $$($(AR) t $@ | sed -n 1p) $@ $$($(AR) t $@ | grep -F -f $(srctree)/scripts/head-object-list.txt)
>
>  targets += vmlinux.a
>  vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
