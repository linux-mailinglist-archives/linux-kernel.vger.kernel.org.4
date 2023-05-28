Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED24713AA0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjE1Qkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1Qkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:40:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBAA7;
        Sun, 28 May 2023 09:40:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso26838725e9.0;
        Sun, 28 May 2023 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685292034; x=1687884034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLa47+Q3W2OzgpecH5Xnum+73EwRiKQp+CKkhWwm3IY=;
        b=GJkOU3y3qiwRwnS/9jGZN9BIVn7uG4LZCp/MOPkMjb/n+xYI+QrfSeAZyj663Skkxg
         t/mhhjruGA+p0ZC+gnGtmkGloQjjKhD2Wo3lpVEegbC5Yg133Ib8cxDBZPZgU46wyXXM
         c///XBgvBruxUxtXw85KLtr8QJBkj8lCH1Dlk1E8JlfkA7GVi0pwee1gB8qfxjC/x2lm
         IAQwlazZuYnGekmUKHRbw+vQNItgUZDrA6QUGTIoQx5fsLwVALjTCg39XnIXuLIymR4Y
         Gsd+hjVcbEHJyvhZTX/R86Og3uJwM3Nok3rpJPbybie9CY098JJvaK/4xlaRxinn+/JD
         ZjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685292034; x=1687884034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLa47+Q3W2OzgpecH5Xnum+73EwRiKQp+CKkhWwm3IY=;
        b=cEP8A7PWNF7sfNbms9hN/MMPMGzPesLJ5CahCdCQXj0Iym9M19Ei9fpVV5Bw9X8NV8
         cpkYvbA9mzMafVapZK8BTb3YTIZTsf0w/GA9Z/WHwwKxPZyiBJgzBWuUOHnrumd/nKYv
         x8lZ6QRbAHRwoTFAtyUQRQ5yINUIiY+QGYiHIhvlQaIjJRUMDmrEH87oCGzNDtcHF2VI
         1SSVyBtn5cAVzxOnnmFdnJLIgqq1oKzTO1okx1riA1le2+cVToUvgY5eWMMdV4TC9CxK
         0vFSz4IVec8WgBd3XdSKnfsxezxwa7bimTqYQUa4pNnEsFG+8wY0Kwm2U/rPoNtq13OL
         f7ug==
X-Gm-Message-State: AC+VfDz/El1q8Ba8M4NKkQbhYiPyk/MeJJsUwjJZejz2gzuxqTAmwPt0
        35RatbdWYjSXSJKz3JdRTkiPrRNY1YCz/g==
X-Google-Smtp-Source: ACHHUZ7mRyrdzgqfUt22WPn1ATcdeLzjoh+SvsixN8BgTtvUiWMITbemlvIavvz5pgcffUuoXTXd7g==
X-Received: by 2002:a1c:7515:0:b0:3f7:5d:49ff with SMTP id o21-20020a1c7515000000b003f7005d49ffmr1807888wmc.1.1685292033854;
        Sun, 28 May 2023 09:40:33 -0700 (PDT)
Received: from solport.. (203.red-83-43-24.dynamicip.rima-tde.net. [83.43.24.203])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c0b4f00b003f611b2aedesm11583969wmr.38.2023.05.28.09.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 09:40:33 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: build error while building arch/x86/purgatory/sha256.o: invalid 'asm': operand is not a condition code [...]
Date:   Sun, 28 May 2023 16:40:31 +0000
Message-Id: <20230528164031.266590-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info>
References: <175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can also reproduce the problem with Arch's linux-next-git, see config:
https://aur.archlinux.org/cgit/aur.git/tree/config?h=linux-next-git&id=f9a384e1c582321651fb613782ebc5a581146af0

I've bisected it to df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
which explains why it only happens on GCC13.

The problematic expansion that causes the error seems to be this fragment
from `_BUG_FLAGS` in `arch/x86/include/asm/bug.h`:
    asm(".long %c0 - .\n": : "i" (__FILE__));

Along with the fact that this file is built with `-mcmodel=large`
(see `PURGATORY_CFLAGS` in `arch/x86/purgatory/Makefile`).

Regards,
- Joan
