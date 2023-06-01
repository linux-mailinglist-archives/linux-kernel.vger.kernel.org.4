Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE54B71F3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFAUbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFAUbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:31:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520019B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:31:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b04949e5baso11654025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685651495; x=1688243495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wqcyp4CmxpgYeEHc8GcJ0HoG2EXsHPzXMFxXDEfLsg=;
        b=Q94S1yLY0nWcPU4aftdIP7iFZ+0tnpeB5SKyv2cGl8gHz9JYvwaxOfVnDgn9M0tLwG
         OK17SGHZ99X1XonVvgWbZPqVibIBYqYvGjn/tEKmQBiXW1GG6v7poNVXrOMC3K/Sxi93
         G6DXrPSnRO8r/dgFxY+kV5vZa6c1fWXnC4Mrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651495; x=1688243495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wqcyp4CmxpgYeEHc8GcJ0HoG2EXsHPzXMFxXDEfLsg=;
        b=PwodKBBh/RpnmGGjkNiKV9u7fjZ0aFlG2iet2tRcbyQcXYViRHOAQSogfIx+VTkWU7
         m+tcybQcNDsDHx6dw4BxOwChgMM4UY+hDowTZC4EBAQS/uDQM/svhbw/gjC34+kcWbCY
         J3GOz/pqnxIf44ggmrgh0x4sYxkHkse2b+jfplgUMR3rJlRbADwAq0R49xM6jWGED0qZ
         uB9WCY9M1QE1zGyZFBEH04KL2aypihFTNwY5b499Q8xpzciN8yvYU5NJdhnAVQlTPooM
         6WgZSBbX97TgBFUJrlWxp/jXX0vSzkIjmIrMXcidSri3aFOQN0x5rn410BEc5+q06ED7
         IFKQ==
X-Gm-Message-State: AC+VfDxnZMUFMOPDGTtDlJItriZ5xiebIejxXdrQNPstSXRnn4TpBoLP
        HrDdYVT/U28RMLx43yMk1WVr0w==
X-Google-Smtp-Source: ACHHUZ50FytdpQsyv66+VN0G5nKzPNryGrQhcvOnlh+7piyIN35if31vm6o+E+x5MGd1aTr+6gJlWA==
X-Received: by 2002:a17:903:2352:b0:1ab:253e:6906 with SMTP id c18-20020a170903235200b001ab253e6906mr357438plh.67.1685651494889;
        Thu, 01 Jun 2023 13:31:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902bcc700b001aaed55aff3sm3888464pls.137.2023.06.01.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:31:34 -0700 (PDT)
Date:   Thu, 1 Jun 2023 13:31:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        linux@leemhuis.info, heiko.stuebner@vrull.eu,
        linux-hardening@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, joanbrugueram@gmail.com,
        masahiroy@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, hi@alyssa.is
Subject: Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
Message-ID: <202306011331.880AF01743@keescook>
References: <168564402237.2891605.1600418987887898293.b4-ty@chromium.org>
 <mhng-8c6309b5-4ba9-4276-a8e6-2864426e77f0@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8c6309b5-4ba9-4276-a8e6-2864426e77f0@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:17:03PM -0700, Palmer Dabbelt wrote:
> On Thu, 01 Jun 2023 11:27:03 PDT (-0700), keescook@chromium.org wrote:
> > On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
> > > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> > > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> > > 
> > > struct sha256_state {
> > >         u32 state[SHA256_DIGEST_SIZE / 4];
> > >         u64 count;
> > >         u8 buf[SHA256_BLOCK_SIZE];
> > > };
> > > 
> > > [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] riscv/purgatory: Do not use fortified string functions
> >       https://git.kernel.org/kees/c/ca2ca08f479d
> 
> Sorry, I'd just applied this to riscv/fixes as well.  I can drop it if you
> want?  I was going to send a PR tomorrow, just LMK.

I'm fine either way. I was carrying each arch's fix just since it was
related to the -fstrict-flex-arrays=3 patch in the hardening tree.

-- 
Kees Cook
