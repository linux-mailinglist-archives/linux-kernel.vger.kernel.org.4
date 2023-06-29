Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606607420F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjF2H2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjF2H2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E404268A;
        Thu, 29 Jun 2023 00:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCFEE61475;
        Thu, 29 Jun 2023 07:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64316C433C8;
        Thu, 29 Jun 2023 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688023690;
        bh=YybS3GOlOBIDzkNzWpon+uuGWahmqnaYLL/cihgEKjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NajRoua/kcVZrw8GbqivoW0UN9nIcAyEavl5YzguvD5nUV6nw04Ksw2ViZ6vQ197E
         fPil9QKn6COdSFWJYxB2bsuBYJRu96GLv3LnEDd0TpI2/EuAISuhr50aixEj6w4oqa
         Op2suIG6PO0Rw9g7E/m8cprNmNdttF+ntAG5DgE15Z0NO3569Tjs6+cTsGuSNLDp6l
         eOuSBNNEL7jMvw0gzduPSdNyuNjqtpGDMS5xgH9mKPbC7h5Yv6dXPtSzUI6gT+InLf
         PJLxr9gqSc9rSEet/N6+11QTgNCWIp9BFkieMpaPmNtVhPgqppTnIaUlQJnhwJE/8C
         MuP1M789rX0Kw==
Date:   Thu, 29 Jun 2023 10:28:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Build error in crypto/marvell/cesa/cipher.c
Message-ID: <20230629072805.GE23952@unreal>
References: <CAHk-=whXn0YTojV=+J8B-r8KLvNtqc2JtCa4a_bdhf+=GN5OOw@mail.gmail.com>
 <202306282051.51D98294F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306282051.51D98294F@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:53:26PM -0700, Kees Cook wrote:
> On Wed, Jun 28, 2023 at 08:13:25PM -0700, Linus Torvalds wrote:
> > I get a similar error in 'irdma_clr_wqes()' at
> > drivers/infiniband/hw/irdma/uk.c:103 (and same thing on line 105). I
> > don't see what the right solution there is, but it looks like we have
> > 
> >         IRDMA_CQP_WQE_SIZE = 8
> >         __le64 elem[IRDMA_CQP_WQE_SIZE];
> > 
> > and it's doing a 4kB memset to that element. The mistake is not as
> > obvious as in the cesa driver.
> 
> I pressed "send" too fast. :)
> 
> This should also already be fixed:
> https://lore.kernel.org/all/20230523111859.2197825-1-arnd@kernel.org/

The fix is in latest RDMA PR:
https://lore.kernel.org/linux-rdma/ZJzUeFT7lLqEjMJn@nvidia.com/T/#u

Arnd Bergmann (1):
      RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes


Thanks

> 
> -- 
> Kees Cook
