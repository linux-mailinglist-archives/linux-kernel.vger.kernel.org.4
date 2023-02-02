Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC424688817
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjBBUMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjBBUM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:12:27 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA507C324
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:12:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gr7so9341983ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IHla39CiSn/iJKWSdMLdZQxGn8KNa71czZ//HIF7jnM=;
        b=b8S977PCJvYsm5/wWBBCuQu2MDqR3X3fUtF8X1r8mnXi8t+O+XjMQWNZFQCdwK3bQu
         bb2h40Lx6JiJTPlREK6y28ArbDlrecfcNjSuHQnO41A9KR2NvWMo8fBku8bWXW2ZsmOT
         3i1S7Ci7/Mz77ZbG9n+tgyGlxlIcHYfqwqElIshS4Q7ZnQdxZJwxp6hOfOB3IdRqQktA
         ly/hhMbpiYCBguunqDfA9g9Bu3cgo3d8McgbLXFFfupAu9Hqi1jppqaC0Qwjb+NRZC+h
         nOm8+qHMKnw3bcVXpH6k/6Y+ne2nkjuHiDVxYx23qm/zBpVknekHllYAtdJURLIsp0U2
         2E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHla39CiSn/iJKWSdMLdZQxGn8KNa71czZ//HIF7jnM=;
        b=pLVUDyi4Cserw/4wwWc6q0Z4KYxWo9Ht0GWnoHNVpDLPJyUkXF/SaxoWLhIcaRdxeN
         +IXIetyx5IhWBXfiSLraPPVzzPx5RWeSgt8z7KvTSai8v+uM4kg11RBRkAULMA7OoMLz
         +2Hg58CPdmz6IOeHWSz9dyqo+mFDIgNIyKy6a6vCl48pErTviilgHzer+umMrmZCc8ny
         5ZhSbieDz50Uwg2d+352/YvuAuDRW/x2XTGhWVesvy0pVZw6fBb9jGdPnhsQyEkXcFrd
         TX6dnKpVTOXck0gLNY3Sc33C3zv3pULNoxhn/zfUXEpF+se1HmhJnkS9CugQmoMvbr4r
         Qitw==
X-Gm-Message-State: AO0yUKVVw2roJsOyeMiWsg/0Ap2EgUxawoGZ+LBQVStGTFixJIZMthRY
        4bhJO8DpjdBLtc6Df/jeRsaVJPG+GTVzQ6izAfWOOg==
X-Google-Smtp-Source: AK7set9rIsutx+Ca2x+6Py7LpZCPwL53KUZH34ZDzhf5YBTLMNdyYbcMOhiSyZoKwKZW2sL2evQ4iBv7Bl6I/3PriEM=
X-Received: by 2002:a17:906:2c42:b0:88a:b6ca:7d3a with SMTP id
 f2-20020a1709062c4200b0088ab6ca7d3amr1942408ejh.1.1675368744381; Thu, 02 Feb
 2023 12:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
 <63dbf04a.630a0220.2608a.0149@mx.google.com> <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
 <63dc0a89.170a0220.49507.0091@mx.google.com> <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
 <CAKwvOd=cuDb2NNK4uoUTYTLryFig47hvDQ08ta5XhjHsEhAG4A@mail.gmail.com>
 <CABCJKuc+GvTHXu-CVedZs6CvPKJ8ySrVztkP2V3dsWn70xf7hA@mail.gmail.com> <63dc14a2.170a0220.beb2a.0275@mx.google.com>
In-Reply-To: <63dc14a2.170a0220.beb2a.0275@mx.google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 2 Feb 2023 12:11:47 -0800
Message-ID: <CABCJKueSasiWQvO2jZ-8KUF+c-dNgf87pR45sfHHCQMyyTvL0Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 11:53 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 02, 2023 at 11:49:42AM -0800, Sami Tolvanen wrote:
> > A quick look at Clang's source code suggests that Intrinsic::ubsantrap
> > already accepts the handler ID (from the SanitizerHandler enum) as an
> > argument and the arm64 LLVM back-end appears to encode the value as an
> > immediate for the brk instruction. I didn't confirm that this actually
> > works, but perhaps we just need to teach the kernel about the possible
> > values?
>
> Oh excellent. Yeah, if that's all that's needed here that would be
> great. What are the values?

The arm64 brk immediate encoding seems to be "ubsantrap arg | 'U' << 8":

https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/AArch64/AArch64InstrInfo.td#L7571

The argument values come from the SanitizerHandler enum, which is
populated from this list:

https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/CodeGenFunction.h#L113

Therefore, according to the tests, for ubsantrap(12) we'll get brk
#0x550c, for example:

https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/AArch64/ubsantrap.ll

Sami
