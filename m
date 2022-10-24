Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC20560B658
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJXSzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJXSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:54:36 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AAF17D292
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:36:02 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id a67so32786404edf.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7EupM1XkZie3F6/X4CsQbgv/pGCs3msiJ5PDGul5cM=;
        b=iF8fvDF0N6jtK1Q2xk30+27mDLB3PfMd8Ab+VgTEWk2wv7zkElOQtyHa7uou42oaCH
         4dIIrO1eas4+tDLwGM7gXAwZD1l8WlXHzrPHgIEhyqmZ3W7dZmIAeIZxXMxBpjmPBoTu
         aKp2Y93ZxLV1AoVo6ZU3n4d/wwLHzasITt4x/t2Dfqb9cjcxSL6VdMKCSMwvfAw2TnAP
         BpoVjTgRHYwkEIrMCWRK+9a95w5okEq5lchLx7jIko0dp4WXquFQa/hHx48OFuwf2M/8
         RU7mjUYQnJnjxVQA5uA3nT3yHVUbl3lVSv9vmaym4yuuzeDMrASPoaC6SAFxw63KxO30
         E8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7EupM1XkZie3F6/X4CsQbgv/pGCs3msiJ5PDGul5cM=;
        b=nmWXMzV4NAQUVJVLTsAE3aD4OS2At4my+LgTkb62030ht/nes0i/cQG7AEflisLC9d
         qGfwgrHbsjRID57DoPqlHf29S/JpinQaC5BkaZjphT5CPLY4faZBZyL6Gko5jqtnuWYE
         MlfwpFtzV2QdZcAdZjSahhUQdSD1fo+L+sV9XsOZUoe3cnSEoCKvZQakWF+ygZIntH3t
         BN0Glf1KqIr8kv4xjE/A36JS0AtiVcahmFlYdLAGQtCeLj30fPMccWo1oLNh5YFhtn0C
         YG/yhAjNRjMzjf83LyER5l9+B407S4kPq9XAViwRImDzn4Zh8eyVUqYRb6dGHsUz4Wy9
         Z8ug==
X-Gm-Message-State: ACrzQf0XTbPGQY+EDli2lvvaZTCV574EsIjNQjK8vb5qW2WaiwjlUcmi
        G7CgQ8/FunxE96oCp/18k03MszHXzAywxsdyjU5U0JDYpnY=
X-Google-Smtp-Source: AMsMyM7K4mznfgGYqc99l9m+iX6PL7iskLHkm+nGGgIVSOvLSsID4ZT5BVmtLHFVGV6yWen4xk19digk92HtUiOb2lI=
X-Received: by 2002:a17:906:8a47:b0:7a5:8160:19a6 with SMTP id
 gx7-20020a1709068a4700b007a5816019a6mr7582635ejc.477.1666631796112; Mon, 24
 Oct 2022 10:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <20221021230859.gysp5v3yzfqz4xgb@treble> <Y1QGUXSc43rInacJ@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1QGUXSc43rInacJ@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 24 Oct 2022 10:15:59 -0700
Message-ID: <CABCJKuc8eu0t08E0e1si-Sm2m0QqB1mrzofZy9cJ3G-tHBUZRg@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 8:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Oct 21, 2022 at 04:08:59PM -0700, Josh Poimboeuf wrote:
> > On Tue, Oct 18, 2022 at 03:35:50PM +0200, Peter Zijlstra wrote:
> > > +#ifdef CONFIG_FINEIBT
> > > +/*
> > > + * kCFI                                            FineIBT
> > > + *
> > > + * __cfi_\func:                                    __cfi_\func:
> > > + * movl   $0x12345678,%eax                      endbr64                    // 4
> > > + * nop                                          subl   $0x12345678,%r10d   // 7
> > > + * nop                                          jz     1f                  // 2
> > > + * nop                                          ud2                        // 2
> > > + * nop                                     1:   nop                        // 1
> > > + * nop
> > > + * nop
> > > + * nop
> > > + * nop
> > > + * nop
> > > + * nop
> > > + * nop
> >
> > All the "CFI" naming everywhere is very unfortunate.  We already have
> > "call frame information" in both the toolchain and objtool.
> >
> > The feature is called "kCFI" anyway, can Clang call the symbols
> > '__kcfi_*'?
>
> I think the compiler patch is already merged in clang, not sure that's
> still an option, Sami?

Yes, the compiler patch is already in, but if the cfi/kcfi confusion
is a big concern, it's still possible to rename the symbol before
Clang 16 is released. However, I thought we picked the __cfi prefix
earlier to make things less confusing with FineIBT? Joao, are you
still planning on adding FineIBT to Clang as well?

Sami
