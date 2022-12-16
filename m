Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6064E7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLPHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLPHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:47:36 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC871AF14
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:47:35 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3f15a6f72d0so23154567b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gRmRwuqglh1o58OVtcxh+xj9twqhPtxCrkd2F77f+mg=;
        b=jU+i+crZ4fP9lDjfdd40L1X4W+J89begb3e9Pd0KnwpzghD4XLuVsl5HzGu8kyR5qx
         W5BNgTmFW2+Vg6O9xy/6ffIDsxmkil7CPfRpk8ev3bxCvQ/tYbcqX02yi3ILPm3njcJW
         Hvs3Crlv5XMaxvE2yuJqv56FMDvhAemM1iaIyW2YtFkl3EJn305tpKaU/7vDhNT43nMC
         q9J1w6YFIkZCgrEVmYvLc2GtX5+GV/3OTstYb7hQhGs8URtZycVAm16T5BokZGlcxcOz
         X3MqyJvlYR1huq7pEnAQdqV6XZCQhIAcHWRSECuozNN28XJvlKZ1K2i/3wpojQJlOe9D
         2CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRmRwuqglh1o58OVtcxh+xj9twqhPtxCrkd2F77f+mg=;
        b=6q3oAYkzJxLGhUtEPOKWTI2Ly79J1cV3SnMIJfFhilUfKpV08+sE2cF7GE5vIOO5N8
         0nANt+04K54QfaDing1L7g7QrGAecdNMRJmKY1Dp6BIs8raADsJUpynasrxfg1XsMz/4
         jX1MZO/Fx31rWzlE9IX4qaaxzr3+fx84harrVtsWrEEjkidHobBjAEgi022fMREawxKi
         biS0aSsVa+0pScB3SV/Pc3F6xBHqgFNJHmMInG91a8ncbMzZaeRut0utNh94kQTotVhQ
         wXjIrujMwRr4SWvSRv1Mc6AFxmsEhbffAjo147iffYrsnQ5oG/eif8+NBniNo31t9GIH
         wqMw==
X-Gm-Message-State: ANoB5pnvuDDl2BO0U0Ytd1QiqfxcjNMdwxkwwXvxSELwWSfq6ufgbd1a
        5DU1jW7SQXyOFeTYe6Xemh9ZEfbpUcCrIIl2079/Hw==
X-Google-Smtp-Source: AA0mqf7htW4zPU07spjkn6CCMZS0zIzrrn0oFgsUw4oI3Pr+auhIvz2z+cyAFiQSHxmLA6IeMMKI4guY5P3yqH2zJpw=
X-Received: by 2002:a81:1e04:0:b0:391:fccf:db48 with SMTP id
 e4-20020a811e04000000b00391fccfdb48mr27345280ywe.257.1671176854341; Thu, 15
 Dec 2022 23:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20221215170347.2612403-1-arnd@kernel.org> <1bba42a31e0a487bbbf67955b674583e@AcuMS.aculab.com>
In-Reply-To: <1bba42a31e0a487bbbf67955b674583e@AcuMS.aculab.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Dec 2022 08:47:23 +0100
Message-ID: <CACRpkdY_050MZ3Gun_bOZiTk=q+7xUkiP0CO7daLEiX2wRi_yg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: fix pointer cast warning
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:20 PM David Laight <David.Laight@aculab.com> wrote:

> From: Arnd Bergmann
> > Sent: 15 December 2022 17:04
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The previous build fix left a remaining issue in configurations
> > with 64-bit dma_addr_t on 32-bit architectures:
> >
> > drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_get_pblpage':
> > drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: error: cast to pointer from integer of different size [-
> > Werror=int-to-pointer-cast]
> >    32 |                 return virt_to_page((void *)paddr);
> >       |                                     ^
> >
> > Use the same double cast here that the driver uses elsewhere
> > to convert between dma_addr_t and void*.
> >
> > It took me a while to figure out why this driver does it
> > like this, as there is no hardware access and it just stores
> > kernel pointers in place of device addresses when communicating
> > with the rdma core and with user space.
>
> I hope that doesn't mean it is relying on user space only
> giving it back valid values?

It looks to me like this driver totally trusts userspace.

Yours,
Linus Walleij
