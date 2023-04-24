Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE296ECF99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjDXNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjDXNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:49:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387C93D7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:49:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efea87c578so3474e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682344157; x=1684936157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pP+RxkIYzemZdCZ53UUeyLEz4L6xQOJqoI1Dw7qkHQ=;
        b=OvPfRmaz3tdzsvigbEso2jGXAWxziIiwH3npny3IJUoaynFsoO9+KIlD4flJ4FbkP8
         rrRjgevhV/G3mj0QKp9UsIc/d5KhDHg79PBplls+V8MDGZ9JZ9HapY9UOPYxsq75zt8t
         of4qR9dQMh9ltWU/hFdsgGXE/5lc5yuXcf2QA6h2Kp59/eaunCSedY2PXjWHWIy/SXkZ
         lU22lbFZDPd0qgXXkqWURh0hrYw14c8+fVZHjjnB5xjewJu2ptZnghvjqnKtNSs5H09w
         Cb7e/+lB7MTRsiBTfMU/7SYtZjAVWO//su1m3FufzbkGF++CCEkA1lX6w0NRhEDcq2Og
         6GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344157; x=1684936157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pP+RxkIYzemZdCZ53UUeyLEz4L6xQOJqoI1Dw7qkHQ=;
        b=e30Sd4LexHLJi+HwMdy9XxuQKKh5QH1iDJExxvraC66saFwQMGpMsfJ4M8jEZlU4qr
         4na6pDXFYCMp836SmNqbZkPCrNBrk0KsNtxjR1+H+/CF6v82qScN8vhcJ+xnk5pNMf42
         EyNWwgp4ORzyBZbYWzH4tvLaPgaCyN9/Z64rpc7y7QBtjqC4QWl1r5rQrGIsZNK3OlMI
         CohcwRYXyQmx37J29D0PJgP9CZSn49jc7+W1EcECx7oxzVxJ2tZ3xvCeaFB9Bk/aPBZ9
         D8Agkkq5WseP6EOwh3DbPpLM9Z6Lke+PfGlHoNWVWYb73BRX108gHXYDTaFfUArYtVTA
         yU6w==
X-Gm-Message-State: AAQBX9fRl1aobuy5kl5dRKU8YA9M+FeujEhJHubvtwZ0IIRXRydaX4qC
        pYAiC04HzCW/AHutBtAlXhjyTnAZWlCFx1mdl6wLOA==
X-Google-Smtp-Source: AKy350YKHv6i0YsOKB/k2YG8Y9bmIUVxcsE88sYOazC2VGHdo0q/sQzUcf19ECK3kOBZ9drPl1Jv7Io4F6X/zKxnXAM=
X-Received: by 2002:a05:6512:3d2a:b0:4ed:d7d:d141 with SMTP id
 d42-20020a0565123d2a00b004ed0d7dd141mr254260lfv.6.1682344156926; Mon, 24 Apr
 2023 06:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0737c05fa0fd499@google.com> <CACT4Y+YKt-YvQ5fKimXAP8nsV=X81OymPd3pxVXvmPG-51YjOw@mail.gmail.com>
 <ZEaCSXG4UTGlHDam@casper.infradead.org>
In-Reply-To: <ZEaCSXG4UTGlHDam@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 15:49:04 +0200
Message-ID: <CACT4Y+YeV8zU2x+3dpJJFez5_33ic3q7B2_+KYrcNOQxooRWpw@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio /
 folio_mapping (2)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>,
        djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 at 15:21, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 24, 2023 at 09:38:43AM +0200, Dmitry Vyukov wrote:
> > On Mon, 24 Apr 2023 at 09:19, syzbot
> > <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com> wrote:
> > If I am reading this correctly, it can lead to NULL derefs in
> > folio_mapping() if folio->mapping is read twice. I think
> > folio->mapping reads/writes need to use READ/WRITE_ONCE if racy.
>
> You aren't reading it correctly.
>
>         mapping = folio->mapping;
>         if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
>                 return NULL;
>
>         return mapping;
>
> The racing write is storing NULL.  So it might return NULL or it might
> return the old mapping, or it might return NULL.  Either way, the caller
> has to be prepared for NULL to be returned.
>
> It's a false posiive, but probably worth silencing with a READ_ONCE().

Yes, but the end of the function does not limit effects of races. I
think this can still crash on NULL deref.

The simplest example would be to compile this:

struct address_space *folio_mapping(struct folio *folio)
{
        ...
        mapping = folio->mapping;
        if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
                return NULL;

        return mapping;
}

ret = !mapping_unevictable(folio_mapping(folio)) &&
        !folio_test_mlocked(folio);

static inline bool mapping_unevictable(struct address_space *mapping)
{
        return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
}

to this:

if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) && folio->mapping)
   if (test_bit(AS_UNEVICTABLE, &folio->mapping->flags))

which does crash.
