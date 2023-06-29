Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C558741E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF2DOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjF2DNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:13:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A709272D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:13:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991fe70f21bso23888866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688008424; x=1690600424;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsP6l6F2Ynxmy6UfbGE0U5XGQemQAiefdBx9y2MwRzY=;
        b=I6G+9+XnwLcg3XT8KdV+xRXd4FxyrBoVymRZnyU5rEYGnkYtzQWVojNJAIzuBC48XT
         Rlfk8KDOOREEuq4y2OMP2AuVNE8bOAmLi5rYb7u8uiWFbzV2VS6g1OCFofRm8+p6JZwu
         /6e8IoAkkVFTJAooKqAR+R1sJkx+yU6yeSoWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688008424; x=1690600424;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsP6l6F2Ynxmy6UfbGE0U5XGQemQAiefdBx9y2MwRzY=;
        b=WJo3E/evl/n36fEfd69kHsp/8ve8r1kT741gJi+YHZPVtOjuYQkP56bN2hbndl2DZ5
         Iv/xjNQoa2XOdAGJkmstNrnpNdOOSi8YfdqV9J/hhJQrJWVbPY9ZDVbMmDYGjRFK0uW/
         sKdeRBkVKwJwg0z5iNI/9ue0Wn+V7roMulkCxLFL/qgDJW83G4PjQRdYNbBfx27e29F1
         GRycSCrAjef6lD/aX0MBrhbMkdFk5iaF5wautJWQAzqdW0Hf/+mH7HB92ReLqnwYcuwz
         Od3ISTqLU14QbiUl0vauEyKTMilfynZbSpZI0cpOfUwHq6bO2cqe6E9fNaYRxTr5WZvS
         4C5w==
X-Gm-Message-State: AC+VfDzPlhHhOY5qL+ditxMwsD9oms7aghF4auPKAlj64QhyFUCnv1bu
        bdWV+0/4BfDR87VmQRYpy0h68BMYxZGla63wYmI5BKr6
X-Google-Smtp-Source: ACHHUZ6ZyVx4TCyiVaNDofEPVOF1b2NK5BRkT2PLbopFgo8e+INVte24QlhxqKWADHsXoSEa6o8SKA==
X-Received: by 2002:a17:907:d9e:b0:98e:419b:4cc2 with SMTP id go30-20020a1709070d9e00b0098e419b4cc2mr11003094ejc.3.1688008423911;
        Wed, 28 Jun 2023 20:13:43 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00982a352f078sm6281264ejm.124.2023.06.28.20.13.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 20:13:43 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so233657a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:13:42 -0700 (PDT)
X-Received: by 2002:aa7:da44:0:b0:51d:9605:28fc with SMTP id
 w4-20020aa7da44000000b0051d960528fcmr7619337eds.41.1688008422437; Wed, 28 Jun
 2023 20:13:42 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 20:13:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXn0YTojV=+J8B-r8KLvNtqc2JtCa4a_bdhf+=GN5OOw@mail.gmail.com>
Message-ID: <CAHk-=whXn0YTojV=+J8B-r8KLvNtqc2JtCa4a_bdhf+=GN5OOw@mail.gmail.com>
Subject: Build error in crypto/marvell/cesa/cipher.c
To:     Kees Cook <keescook@chromium.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I don't see anything that has changed, and I suspect the only
change is that my compiler version changed, but my arm64 build fails
right now with FORTIFY_STRING enabled.

On arm64 I now get this warning:

  In function 'fortify_memcpy_chk',
    inlined from 'mv_cesa_des3_ede_setkey' and
drivers/crypto/marvell/cesa/cipher.c:307:2:
  ./include/linux/fortify-string.h:583:25: error: call to
'__write_overflow_field' declared with attribute warning: detected
write beyond size of field (1st parameter); maybe use struct_group()?
[-Werror=attribute-warning[

but I haven't been compiling regularly enough to know when this
warning suddenly started showing up.

I enabled the cesa driver on x86-64 (by also letting it build with
COMPILE_TEST), and I do *not* see this warning on x86-64, which makes
me think it's the compiler version that matters here.

On my arm64 setup, I have gcc-13.1.1, while my x86-64 build is still 12.3.1.

But I think the warning is correct.  The problem is that the 'ctx'
pointer is wrongly typed, and it's using "struct mv_cesa_des_ctx"
(which has a "key[]" size of DES_KEY_SIZE).

And it *should* use "struct mv_cesa_des3_ctx" which has otherwise the
same layout, but the right key size (DES3_EDE_KEY_SIZE).

Fixing that type fixes the warning.

I'm actually surprised that gcc-12 doesn't seem to warn about this.
Kees? This looks like a rather obvious overflow, which makes me think
I'm missing something.

I get a similar error in 'irdma_clr_wqes()' at
drivers/infiniband/hw/irdma/uk.c:103 (and same thing on line 105). I
don't see what the right solution there is, but it looks like we have

        IRDMA_CQP_WQE_SIZE = 8
        __le64 elem[IRDMA_CQP_WQE_SIZE];

and it's doing a 4kB memset to that element. The mistake is not as
obvious as in the cesa driver.

Kees, any idea why I'm seeing it now? Is it the new
-fstrict-flex-arrays=3? And if so, why? None of this is about flex
arrays...

Anyway, please forward me fixes so that I can have a working arm64
test build again....

               Linus
