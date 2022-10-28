Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B13611904
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiJ1RMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJ1RLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:11:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10196AA2B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:10:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o28so1183932qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGoG4+kkpjFKIiC1aB206pNaNNu8WHtjUzbD9QY9Ydk=;
        b=AHLpWHbvaJj6iAHcMzE5M/XFIEJbvJiM188nPc4sZcuDlddbnWJj2scjftscU4cF4x
         7ek2zIay9rBYB96uXxrfVQTv5OfVuThw3qxUxjLeEdzSlmmCOyQ3PY8Gh2POJX82KNSM
         0yIW2D4UUkVkaewo1+mavlSqKbWHmteTLXE9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGoG4+kkpjFKIiC1aB206pNaNNu8WHtjUzbD9QY9Ydk=;
        b=pI06dJL0onfYOeBrb6EbzbThtSXqkiVmOnQPapyv7KO9+9XFnlmfrWNTKffksVQ6qb
         XbA6bYENLo+xZKn4O0ZbEpxJ72JHSNb/PUbwWSCNx6uon3PSQYK5Pjy5gmbGK99pGdsS
         GojeSUC6TkmaT4WqapW5NM/ZyO+6cvzl7y8FpENdZ/w8QaUsxYON8lsXUsEOxETe3k7g
         b5XOQrV7bUw2qExzgXMMXbx06Z7PKqlMHJ3oIaSPPd7xbEgS6ADdXZO9fFHMwWrhmXbX
         nC2edpgsvwaytESPQgmSatprpN7xKaW2o2P1RkYyliWU/2Ewy1m2HHsP6Fn6HnOkz1nG
         pIiA==
X-Gm-Message-State: ACrzQf3I+HxQXwv5G0/K4wcHzwuLIRgwVXoqNQl0Vy/Gp+EjblfshZZk
        ZJP6Znskm9uyik31VI/WcWhXytYtq0tyMg==
X-Google-Smtp-Source: AMsMyM78DYgxUPTZx/d8YyLBn4l6B3lGZcEoNe9GJbrxprEa6QNa8q1zmCMYUdmD4RKXpp+3ZrkNZQ==
X-Received: by 2002:a05:620a:1204:b0:6ec:db32:18c1 with SMTP id u4-20020a05620a120400b006ecdb3218c1mr169497qkj.401.1666977009318;
        Fri, 28 Oct 2022 10:10:09 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a0e9600b006b8e63dfffbsm1390997qkm.58.2022.10.28.10.10.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:10:08 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 187so6850053ybe.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:10:08 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr192268ybk.501.1666977007965; Fri, 28 Oct
 2022 10:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <Y1btOP0tyPtcYajo@ZenIV> <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk> <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <65441.1666976522@warthog.procyon.org.uk>
In-Reply-To: <65441.1666976522@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 10:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMAxxw3n5gvURUV68zHr6vXbcvhXSzXdi2obKo2bK=Dw@mail.gmail.com>
Message-ID: <CAHk-=wgMAxxw3n5gvURUV68zHr6vXbcvhXSzXdi2obKo2bK=Dw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] use less confusing names for iov_iter direction initializers
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:02 AM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Honestly, I think the *real* fix would be a type-based one. Don't do
> >
> >         iov_iter_kvec(&iter, ITER_DEST, ...
> >
> > at all, but instead have two different kinds of 'struct iov_iter': one
> > as a destination (iov_iter_dst), and one as a source (iov_iter_src),
>
> Or maybe something along the lines of iov_iter_into_kvec() and
> iov_iter_from_kvec()?

For the type-based ones, you would need that to initialize the two cases.

But without the type-based approach, it ends up being yet another case
of "you just have to use the right name, and if you don't, you won't
know until the dynamic WARN_ON() tells you".

And the dynamic WARN_ON() (or, WARN_ON_ONCE(), as it should be) is
great, but only for the drivers that get active testing by developers
and robots.

Which leaves potentially a _lot_ of random code that ends up being
wrong for years.

I really like static checking that actually gets noticed by the
compiler when you get it wrong.

It may not be entirely realistic in this situation, but it would be
really nice to try...

                  Linus
