Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC08750C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjGLPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjGLPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:18:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31E1BDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:18:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e292cf214so9194316a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689175085; x=1691767085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSRYzXQJjSzscDofbSmSLHS50IQUvlXSSpTRB4ma0qw=;
        b=WKN/SIA/XO1lPrDOTg9H5Y9QVBzMys/4dO7qOvkxg1kVrOMCUj8pB5Pbg0DIjZmGwn
         CcKtivJweKIAjfuiRB7mY43/5IAjGbHWjAcqZoMs8+byLSpnbrQ3kv1Yuwn9wZoEE9m/
         0Z80z2qmtMyoFi/x0ZyYXQLbsZf9Bq0kTrXxgw8TAKwcquQxZ6+Ke8koEbAq2EfRkI0A
         GBOZT3f6nCGYjJn2lJbR2+2zPKGR64oif3/jQo1o6KbuTWpbXBGK/eAr/OQwVkC1tgU8
         Q/WyF3BgPozt9JQJtCL87WEWgue09s/r52S83yRkEz6dQd3Xju3J/LKflptrGuq8oxg1
         JNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175085; x=1691767085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSRYzXQJjSzscDofbSmSLHS50IQUvlXSSpTRB4ma0qw=;
        b=e19U4QBJPnrMI7Ev4U9xUvNyN5n/3mebOBNLp3gHPPQrUkjqjnJL5hHpOPPrw9Uyij
         cPCuXAAXrA7qVh2m1pJN7VC2E9QsetIVnL//0tU3mGxSavnsITWQY5KQ788ZP50uYXp3
         UxE5XluIZ5XIC0z7Pt74bcz8BQCeBM5McL/jfoor0fw4QtnFkdiqs55S4796GAeGqjsC
         nHfJ/3Pq/nW7Whsb6veYwWcJ006fCP0th0e014oVUSelhKwcredeKWM20jGKsxk3+iJu
         jzXBvIuCLvL9mt1Oat6ZpiHb9wKtu/arFOOqQWVm/nqAIDuFF0uIpf4uJ+5Lk8N4jrfA
         07VA==
X-Gm-Message-State: ABy/qLZniccz9fBDxSaaBGW2+0DKWtXJAp6FXP9EuSS7i8FOt8IaHjAG
        SXubb8JTnzR9lMwBchW6bCjeLb7sH2tY7g==
X-Google-Smtp-Source: APBJJlEk9gtg7L60OsOJ5R6HcLlpMod3vSrX0zpJyJcfqUvOGZpC33tgecmEO/qzBuuVg/63uT30ow==
X-Received: by 2002:a17:906:6485:b0:98e:419b:4cbc with SMTP id e5-20020a170906648500b0098e419b4cbcmr19173591ejm.12.1689175085246;
        Wed, 12 Jul 2023 08:18:05 -0700 (PDT)
Received: from andrea (host-95-238-70-145.retail.telecomitalia.it. [95.238.70.145])
        by smtp.gmail.com with ESMTPSA id qw5-20020a170906fca500b00992ed412c74sm2668251ejb.88.2023.07.12.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:18:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:18:01 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv,mmio: Use the generic implementation for the
 I/O accesses
Message-ID: <ZK7EKQjCQV7fNPSx@andrea>
References: <20230711133348.151383-1-parri.andrea@gmail.com>
 <20230711133348.151383-3-parri.andrea@gmail.com>
 <20230712-lesser-deflector-d18f7991477b@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-lesser-deflector-d18f7991477b@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:05:16AM +0100, Conor Dooley wrote:
> On Tue, Jul 11, 2023 at 03:33:48PM +0200, Andrea Parri wrote:
> > The current implementation of readX(), writeX() and their "relaxed"
> > variants, readX_relaxed() and writeX_relaxed(), matches the generic
> > implementation; remove the redundant code.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> 
> This fails to build for (64-bit, I didn't check 32-bit) nommu:
> arch/riscv/include/asm/timex.h:20:16: error: implicit declaration of function 'readq_relaxed' [-Werror=implicit-function-declaration]
> include/asm-generic/io.h:342:23: error: conflicting types for 'readq_relaxed'; have 'u64(const volatile void *)' {aka 'long long unsigned int(const volatile void *)'}

Thank you for the report, Conor.  Looking at it.

  Andrea
