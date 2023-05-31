Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33162718760
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjEaQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEaQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:31:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928512B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:31:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b041ccea75so24303645ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685550680; x=1688142680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ByzmIR8bdGAXP2o41OwIixgXQi8QYuh3izNby61Iy4=;
        b=hbrIeOvaeAKyyvxHsoe7u4SWuGGCrkUeYy9BIzH3pyZFfF87fzRN4hsBFOI/2I8AAX
         c/uIbxHraDc7ffkJ/UgVcHCW2LDjOCDYPpUcVZ5sVfalNIU3me49YUi6YEKMRIT6CAB8
         ZHYplMOe/l48NyiEudrdmRuN8OuSuhtSJp/1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550680; x=1688142680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ByzmIR8bdGAXP2o41OwIixgXQi8QYuh3izNby61Iy4=;
        b=NCIBguldRKLm0tIsPjEy2GNBuDfeAv/cDNsKeBvnGnWVhIpNVxRdqIhs2fA8llc+m9
         qTe0iCmBZ4JIQhuANTS8cdUcvrS+6Oxi67Ai0/jx1tQLu6hzTW5uRhkWpE/kYLuH6F9F
         h8wchipVJtEzRoRJ3+b9WqabzYDGNyP4HYXWaO8/zNIlN2vrJFW70Cijj0fKhpHf5QXr
         KwX0H8ZVCKR6pWTr9vv02xEe+Ii4BOGZyUS8GrDsRWLkblBN1td15OXnlV40QnNkUAS6
         PMxjnxHA7Rd6MrWoFFU731PbieYx/5fYtGLgAxYwCDMsMyJzJwD4yBkRBEZbchBwK3IZ
         SCqQ==
X-Gm-Message-State: AC+VfDxpxtOXy30Lk3pemcSLl4AlLQu1ALRlRBM1RXHtDl1+tkX+Rn5H
        EC/0WAzmUDKMWPfJc+2S5mxwyA==
X-Google-Smtp-Source: ACHHUZ7+YRicU2hUq7DYy5WQBOqTFZW3O0RNpTvYGxbuQd/k91gpcaBhaOTyIxRwClClVq5v5gXBbw==
X-Received: by 2002:a17:902:c94e:b0:1b1:8aa1:3a2f with SMTP id i14-20020a170902c94e00b001b18aa13a2fmr930782pla.27.1685550680219;
        Wed, 31 May 2023 09:31:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001aface7bdd8sm1608614plg.31.2023.05.31.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:31:19 -0700 (PDT)
Date:   Wed, 31 May 2023 09:31:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     arno@natisbad.org, arnd@kernel.org, schalla@marvell.com,
        bbrezillon@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/cesa - Fix type mismatch warning
Message-ID: <202305310930.844EBEA21C@keescook>
References: <20230523083313.899332-1-arnd@kernel.org>
 <168548692863.1302890.6789778742527600870.b4-ty@chromium.org>
 <ZHcoQvWnzO0c1Cp9@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHcoQvWnzO0c1Cp9@gondor.apana.org.au>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 06:58:10PM +0800, Herbert Xu wrote:
> On Tue, May 30, 2023 at 03:48:49PM -0700, Kees Cook wrote:
> > On Tue, 23 May 2023 10:33:04 +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") uncovered
> > > a type mismatch in cesa 3des support that leads to a memcpy beyond the
> > > end of a structure:
> > > 
> > > In function 'fortify_memcpy_chk',
> > >     inlined from 'mv_cesa_des3_ede_setkey' at drivers/crypto/marvell/cesa/cipher.c:307:2:
> > > include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> > >   583 |                         __write_overflow_field(p_size_field, size);
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] crypto: marvell/cesa - Fix type mismatch warning
> >       https://git.kernel.org/kees/c/37f3abddda8d
> 
> Why did you apply it to your tree? This patch makes sense on its
> own regardless of the fortify changes.

I snagged it since a week had gone by with no additional discussion and
it fixed an issue exposed by work in the hardening tree. Let me know if
you'd prefer I drop it for you to carry instead.

-Kees

-- 
Kees Cook
