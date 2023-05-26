Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43C712E58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbjEZUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEZUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:47:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD2FBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:47:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b0160c7512so6155465ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685134044; x=1687726044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfp02npkh0h/YWUAgBDsalIo85iCBRV6d/ctWRGEdlM=;
        b=HWXQYRLK7ntwWtvuKa8oeGsD27iRIjXFFB3NKRgYTo6AbUXgLPeW3qK0kjBQERZ3A+
         hpLbk5UD6xB7CAzhW10l0+DRI1R3CwdWx4tRagyUtmf6xVPsqRG9KuB8vBWnMxVh0omE
         +Y+ZQrk4EVBT1bEzkphBCFItOUN81ElbIBCLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134044; x=1687726044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfp02npkh0h/YWUAgBDsalIo85iCBRV6d/ctWRGEdlM=;
        b=ijluSoUJf98+n34bmZf+jl5HRK09EuuY3GzTpTaiQeH/OE5KUNu/3BdqEtaVAHK9SB
         4ODT94YmbHchwUqO9LSlo6H0pFhUQl0AT/opbh90Lj1f9BMI9D+khTPaQxT59yhL5vXj
         4d8lWhadIqIYum5yCMQTpJskpvsx9vnROxwL2XQFskP5iIx0J2lJafDb1ySJfGTJT3qE
         TQ/TBjMAtwzYVFfBgtpt+zjBMXM/QsTMgne2ozxuMEg5Uw7uo4q00DOnd/3Caw2oME07
         FqHIVTY9aazfjpajcTaLGN3/wZQLzKP8POsx84F3wEmaOlRhhNGVSMlwLl9ZCcvGJRlm
         RnBQ==
X-Gm-Message-State: AC+VfDztdpMYi5b88WGqfvE1F+qJP5miXGE9t/KmnmIxEp4ohgn1ibOf
        oW5/yvLRQvuR5YUsWIjLc+7x4A==
X-Google-Smtp-Source: ACHHUZ74jsM1296cY4bBvBCOf7HyRaDBLdiJgwSaoNdaJ9O57iSahTuW8wR3toOlGsGaHRgpudK/nQ==
X-Received: by 2002:a17:903:27c3:b0:1ac:a02f:c9a4 with SMTP id km3-20020a17090327c300b001aca02fc9a4mr3542847plb.4.1685134044683;
        Fri, 26 May 2023 13:47:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001ac7c725c1asm3650623plf.6.2023.05.26.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:47:24 -0700 (PDT)
Date:   Fri, 26 May 2023 13:47:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org,
        qing.zhao@oracle.com, morbo@google.com, llvm@lists.linux.dev,
        trix@redhat.com, linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Message-ID: <202305261344.A938E07789@keescook>
References: <20230517190841.gonna.796-kees@kernel.org>
 <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
 <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
 <202305261156.67CDEE933D@keescook>
 <CAFP8O3JO42CD2EXk+DJ5pci8ieHvRifAZpKg4iR_NiqTaYfLdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3JO42CD2EXk+DJ5pci8ieHvRifAZpKg4iR_NiqTaYfLdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:48:26PM -0700, Fangrui Song wrote:
> On Fri, May 26, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, May 26, 2023 at 07:47:03PM +0200, Miguel Ojeda wrote:
> > > On Fri, May 26, 2023 at 7:16 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > FYI, applied to for-next/hardening:
> > > >
> > > > [1/1] Compiler Attributes: Add __counted_by macro
> > > >       https://git.kernel.org/kees/c/86a76e91cbab
> > >
> > > Sorry, I was going to apply it soon -- in case you want it:
> > >
> > >     Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >
> > Thanks!
> >
> > > And thanks Nathan for resubmitting the `Reviewed-by` from v1!
> >
> > Yes, apologies for missing this in my v2 submission!
> >
> > --
> > Kees Cook
> >
> 
> https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/70854
> proposes a macro __counted_by as well.
> This patch uses the same name:
> 
> > # define __counted_by(member)          __attribute__((__element_count__(member)))
> 
> I wonder whether the two use cases are compatible so that using the
> same macro name will be fine.

Yeah, I have suggest the name change for the GCC proposal. However,
given that there is still no code to test for -fbounds-safety, I'm
sticking with __element_count for the moment, as there is code
implementing that name in both GCC and Clang today.

> #if defined(__has_feature) && __has_feature(bounds_safety)
> #define __counted_by(T) __attribute__((__counted_by__(T)))
> // ... other bounds annotations
> #else
> #define __counted_by(T) // defined as nothing // ... other bounds annotations
> #endif

Right. My main consideration for getting __counted_by defined by the
kernel at all is so that annotation can begin. We can adjust the
define's contents as needed. :)

-- 
Kees Cook
