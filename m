Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B32741EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjF2Dxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjF2Dxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:53:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101CD2D50
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:53:29 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b5f362f4beso217413a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688010808; x=1690602808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F51EaCZBCjjsjVu5ApRgh9kG0gXJ3pj2CcPmr4xvEVA=;
        b=kzU5jMblv0xz5lzjgtrnn4xxh6hlexJ7oarp6AhiqhBHF0Moc73IE9in1CSO6kbAFW
         atB3woyHuTcXgQ2uvijtMt1KKQygW5Lwf2mIenqOO3tpZ7ldK90ybnGlmbaWo/caj6D3
         pihx+DaOPGKUC5T61KTFucDLEsnntHKx03ilM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010808; x=1690602808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F51EaCZBCjjsjVu5ApRgh9kG0gXJ3pj2CcPmr4xvEVA=;
        b=FS6VqUe3vNfa3QQkIK4VpXTJr9LaBGyUoHI3jtl4CnXQPQa0T+W7g155ksRqbPZQaM
         7GTqSmzt9PDyh08I+gaq9A49UYYKusQYy0r+YgtyWBx04wxKXcYzW50zwskdv+ZwnZE3
         DtTaT6ZlfOJnBSsegZMOrfmKigwssTsny859xZWv93h//JgK96hMCEJFX7pg1Pknm8hH
         04S+D4/mgHvju0QmkwpdsHcJDj27EXgOsTTAS7g/twblgkkdAl8RrXEIqdk8aiJ+cWrl
         p3n8ojuGNDcJ6ZiGlgGFNOTVFHvfvuPhWStJz/we3yEoHlOlwpwYio67qvbaSSA0sUi5
         ldOA==
X-Gm-Message-State: AC+VfDxtsT9b+pPkaRfc0V5qxGpqgf5lEUysG7H4W7yR7hFktyIbjOY+
        6aeX+sxfg8bkDaL3UqQz+nvhLA==
X-Google-Smtp-Source: APBJJlFY5tmOsLx96KPJPQPsk+DLr/hc6W6E39YwYceSOPePO+snjxpcIvS/udSk3tYh/N0Rv0gBZg==
X-Received: by 2002:a05:6359:608:b0:134:e8c6:a888 with SMTP id eh8-20020a056359060800b00134e8c6a888mr997521rwb.8.1688010808332;
        Wed, 28 Jun 2023 20:53:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l187-20020a6391c4000000b00543b4433aa9sm8221454pge.36.2023.06.28.20.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 20:53:27 -0700 (PDT)
Date:   Wed, 28 Jun 2023 20:53:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: Build error in crypto/marvell/cesa/cipher.c
Message-ID: <202306282051.51D98294F@keescook>
References: <CAHk-=whXn0YTojV=+J8B-r8KLvNtqc2JtCa4a_bdhf+=GN5OOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXn0YTojV=+J8B-r8KLvNtqc2JtCa4a_bdhf+=GN5OOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:13:25PM -0700, Linus Torvalds wrote:
> I get a similar error in 'irdma_clr_wqes()' at
> drivers/infiniband/hw/irdma/uk.c:103 (and same thing on line 105). I
> don't see what the right solution there is, but it looks like we have
> 
>         IRDMA_CQP_WQE_SIZE = 8
>         __le64 elem[IRDMA_CQP_WQE_SIZE];
> 
> and it's doing a 4kB memset to that element. The mistake is not as
> obvious as in the cesa driver.

I pressed "send" too fast. :)

This should also already be fixed:
https://lore.kernel.org/all/20230523111859.2197825-1-arnd@kernel.org/

-- 
Kees Cook
