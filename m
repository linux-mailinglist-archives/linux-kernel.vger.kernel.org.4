Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E55E92C1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiIYLgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIYLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:36:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1CA24BE5;
        Sun, 25 Sep 2022 04:36:33 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y15so2287025ilq.4;
        Sun, 25 Sep 2022 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xWL9H7Cbc4v2FgRfmr8f53bQANuU95GmvHgWHVu51kI=;
        b=nuGAnz718hTIDG8x472iASsuCuAR1frKWhu53XAd1i9txp0dG29y/aoRGt5VKod55V
         vZz/RqrH9CCdn319zMhWhnv8/BNHvfsvHOhNNpcaNtlBneQMJLqSKcxNp/TdZDmWy9Qg
         qE8jBWmjyTpZbC/qRsMV5QdCKG8KCJzFAWSALEe33rhemjKgxmyyzGz44++IZ1ryiwD2
         RW0FnRvlr/KZP7bE4gnDFLhIxwIUdqxWs7kX8+3TKpG+3x7WDlJippRa8w0+reTpA/+3
         2msHr29RdRvRSq5S6j0mGLZSEZWCq1tcfRUfvObSsIJfv/F6MNpQWl4KOs8UbUtb8Zuh
         fL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xWL9H7Cbc4v2FgRfmr8f53bQANuU95GmvHgWHVu51kI=;
        b=rCL/pOOB68/kdb+LVz+4OnRD+TYFRxGVBPYazlgeZrlgpn/wg/ujT44nKLP/oqRsWL
         oSwqjti9EsVn8oIT9azo5gWDHLCGg7lfPBYib46h0ylEuRbIJFSMyvU/P9chSJh5DQN4
         oC0whRdMw2AHqc/s+D6gdHxycRylrI+ixCWZ9sCOeAMnBL0FXi6USJhrcsIya2iH/qvT
         CaPY/mTIZkOWkFsIFtcrjzmR6GQ0ZE4NVQonrG0PzAz+T6AQXOiihzW7cNBeLlODSRdE
         TDDln0kFgsCn5vsxl+k3mzCFpNSLzKeYonlAcF5JBJmYMeU5+T9rwalaOPxY3k97LdTk
         zn9Q==
X-Gm-Message-State: ACrzQf3tC81U6C59+ttrr3biazjcORt8Bvokigx4nTsFobesf0AcDRWX
        Z4XrBF79ukey2f90+ltNu3iHFIcHxlQvL9XsS/MTzb29Zyg=
X-Google-Smtp-Source: AMsMyM4vRE6qPYMJjiHtzUWaCajCHFCkHMbT9IoMTG3Rgnkno8rn4gbQDbOuIROT4NaBUTn27/6ZKLFBRK+0f4o5+OE=
X-Received: by 2002:a05:6e02:152a:b0:2f6:58ae:ff0c with SMTP id
 i10-20020a056e02152a00b002f658aeff0cmr8531069ilu.237.1664105793350; Sun, 25
 Sep 2022 04:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220924150715.247417-1-keescook@chromium.org> <Yy/dLihBWSFzZdyq@dev-arch.thelio-3990X>
In-Reply-To: <Yy/dLihBWSFzZdyq@dev-arch.thelio-3990X>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 25 Sep 2022 13:36:22 +0200
Message-ID: <CANiq72nb8s0odCEfCEeWDKjJ7=aj_JxO9iaR8Jmn6LB1aSGifQ@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: Introduce __access_*() function attribute
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 6:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> The GCC docs say it is 'access', instead of '__access__'. I assume it is
> probably okay so:

Yeah, attributes can be used either with or without double
underscores, see
https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Attribute-Syntax.

In this file, we always use the underscore ones to minimize the chance
of collisions, since the idea is that the rest of the kernel uses the
shorthands provided here.

Cheers,
Miguel
