Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618C6015DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJQSBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJQSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:01:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC36386F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:01:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so11511769plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dPSILD0fz6+hHDKRa0DrcnmU24d1fwAr5y/3mLAghY=;
        b=mtxvCNrQHeFU2z7E52M6ReIfWOUx4f1Vt/0bBEhqoaLmsuIn38ne/1mVK2kth7WrqG
         VzhnEYQ/wCAvweINwfQk5bTcyUoZA4At01PZZUpRLs8PvOZ6Gf4AzrffzwoIrVYlhmyr
         7wXP+tBBLd1EMI+jW/o3qkR5qrK2YPVQN4e4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dPSILD0fz6+hHDKRa0DrcnmU24d1fwAr5y/3mLAghY=;
        b=V6TAE1PYW3lj2WsT09g+QQ+xdn0xnuJSaOrLnVnr+qnwQ+OorG4qywK9pubS6MwySv
         4lcoeNOxjHVA9Y7GXjigUWcNhbIsFhoM7wi91YpyBo3aq6Q45t4mpyFAV0DRGPoavIzC
         Qq15nRqj1qBXRU+dDK784VgIk+8TBItWznmzsxE8gQ7UN072FeHaObGWxyhyp6gtMGAX
         qFye37jaOFHhEVqN2BG5tD4UBknShhhHc2AgqTlA0oMSLtb3l4+4zYsVOiZ5l/ujnLWP
         RYDROZq7x4OBPyBctW8b2CYZOjbvKpTdXuwStXp9432AgnKh9WH/BiyRk7aQKi0jPTnr
         5EJw==
X-Gm-Message-State: ACrzQf2bXKn9mHJjeK7+mAcBaeY+kH4X1n10MZ72urZ4wKCuowaT7bcP
        qiPs3AUB/o1W86GWTxHJEQ+MLQ==
X-Google-Smtp-Source: AMsMyM4kblho2j2or0iiU5gOYmPCRjaRxTYSNnheSLa4H+zvGlp3SbU0MsPiwxniAAbFp9Hjbf0SDQ==
X-Received: by 2002:a17:90a:f192:b0:20d:2ea6:4b18 with SMTP id bv18-20020a17090af19200b0020d2ea64b18mr15216803pjb.27.1666029701638;
        Mon, 17 Oct 2022 11:01:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090300d400b0017f95efe62esm6851112plc.13.2022.10.17.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:01:40 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:01:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171100.5BAC4A5CC8@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:26:12PM -0300, Guilherme G. Piccoli wrote:
> On 06/10/2022 20:41, Kees Cook wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > The crypto 'compress' interface is deprecated, so before adding new
> > features, migrate to the acomp interface. Note that we are only using
> > synchronous implementations of acomp, so we don't have to deal with
> > asynchronous completion.

Ard, given your observation about all the per-cpu memory allocation,
should pstore still go ahead with this conversion?

-Kees

> > 
> > [ Tweaked error paths to avoid memory leak, as pointed out byGuilherme
> >   G. Piccoli <gpiccoli@igalia.com>, and fixed pstore_compress()
> >   return value -kees ]
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Link: https://lore.kernel.org/lkml/CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com/
> > Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/pstore/platform.c | 74 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 57 insertions(+), 17 deletions(-)
> > 
> 
> Hi Kees, thanks for re-sending this one.
> 
> Just tested it on top of v6.0, with efi-pstore/ramoops, using zstd, lz4
> and deflate - everything working as expected.
> So, with the typo fixed, have my:
> 
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks!

-- 
Kees Cook
