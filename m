Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D63727071
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFGVUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFGVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:19:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C3D19BA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:19:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b0236ee816so8415915ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686172793; x=1688764793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OwwAPTsX0YV3vUdxtjfpz4TiWLtJRU1D8tBxvGSgvM=;
        b=Dn0wciA0nzHX/RcBPG9bXLiBsfDH0C8i9UN4h19QGoCN+lXz6j0TtaghmiYxiYlatz
         dUC48YyfCOPEd3NaExvAy2oGXwf0DLKnjOsfdvOMBv9O3c7mgsdTf0l/eZf2dhkvtXNs
         Tkx8GQi4UFiuncFvzm6eLIaGIDZtFMT/meXs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686172793; x=1688764793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OwwAPTsX0YV3vUdxtjfpz4TiWLtJRU1D8tBxvGSgvM=;
        b=LHoCUCAjHM4Uu1f5I1GIJ0tC5Slc+Db779uw3hwXlz+pzSIKO1L3ArJNf64hIU74Rg
         yk/6RJWi563sgs1q5hGn+77o4QBLyws5sv26JwSvbmz0IsbdXypwhVesZa5SW2UBiKFQ
         Zzgwa7BK3Oj9v4qH7ilMJeRgbbQMU2YdNz320aig2TKh1NHwmks8yKTy7PHbKvi0mwNA
         kNj8UMetcXU9VS72ggna5CPLTsH04F4KJ+Lttek3FINK2n2py5Cbn1mIVkUt8P3Pduhm
         +D5HYu8O2sgqR60OE19gztLjkIznfYglnTAfEp6sOZnrD3E49t0bgJJz3Hj+LQd0i2d8
         +4ZQ==
X-Gm-Message-State: AC+VfDz/5qyf1YASYkIrTP72+GK+LGY5aS6mLgyf+OrIXO2Da4QnsRGJ
        J2Z2yPUAx3wHoSE29P7DFScOJA==
X-Google-Smtp-Source: ACHHUZ5V9nGQDkdGfxISQMBDH8TRICjsCW5LhXfjuFShBXzhX7gSXaKHOiWW4nMsxpBocxsJSkfahg==
X-Received: by 2002:a17:903:2350:b0:1af:ac49:e048 with SMTP id c16-20020a170903235000b001afac49e048mr186444plh.25.1686172792827;
        Wed, 07 Jun 2023 14:19:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001a922d43779sm10846050plr.27.2023.06.07.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:19:52 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:19:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: dynamically allocate note.data in
 parse_elf_properties
Message-ID: <202306071417.79F70AC@keescook>
References: <20230607144227.8956-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607144227.8956-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 04:42:27PM +0200, Christian Marangi wrote:
> Dynamically allocate note.data in parse_elf_properties to fix
> compilation warning on some arch.

I'd rather avoid dynamic allocation as much as possible in the exec
path, but we can balance it against how much it may happen.

> On some arch note.data exceed the stack limit for a single function and
> this cause the following compilation warning:
> fs/binfmt_elf.c: In function 'parse_elf_properties.isra':
> fs/binfmt_elf.c:821:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>   821 | }
>       | ^
> cc1: all warnings being treated as errors

Which architectures see this warning?

> Fix this by dynamically allocating the array.
> Update the sizeof of the union to the biggest element allocated.

How common are these notes? I assume they're very common; I see them
even in /bin/true:

$ readelf -lW /bin/true | grep PROP
  GNU_PROPERTY   0x000338 0x0000000000000338 0x0000000000000338 0x000030 0x000030 R   0x8

-- 
Kees Cook
