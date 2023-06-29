Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781E742BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF2SUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjF2ST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:19:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890D2D60
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:19:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso1160373a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688062795; x=1690654795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=119MmpmBlik/DZD2cugIRiS/KUlXYi8QMOdrxDs/3Jk=;
        b=fUHWntqopNqgGR09zF8r/4qyuydTLc1DL0oftk32N+n5+LPRuwJTd0kF47/Lz0FNlL
         btWGQuGN4B9C/qdKWV9OwSlxnWgLKV7fMWm6r+FyfKzHhNWZ1zonVW5BzXjRxWm427+Z
         jOgNmjWX6QNOT+qrUbKOQZA2jnsqeKuMR1l9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688062795; x=1690654795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=119MmpmBlik/DZD2cugIRiS/KUlXYi8QMOdrxDs/3Jk=;
        b=FVWjnnQ9B6XANb8jGa32QoyeQaV7oNIRemXTMkUCwgsJSQ9mZitKeDd3TYgkt64q9y
         Fn2bJ8Y4Z24rJGvtiNp1HcHX4Khz4AcEK80kqim4wsIhnUqxoVHzKz8mH/wZ2GQXkdXd
         DzvgrZxS6r5Qwh9TUkv6ggV5+QZmOLZpmOGGyKTHNjKZwkqK/H3iUiuQ9o4CT7NOrALL
         uqxE4z83khrPNcbaFZvB0fZLsN5I8/ryaco/GWNNvG8fKVmEuYMNxqtVYZkNnoobN2SH
         4jiN6sDgUwpPFWVISWNcoaVRG09DWIBrtdKhr61pQKPqqs8ltEcaXVO8ERYP9EEynStY
         6GXw==
X-Gm-Message-State: ABy/qLam00eFrAi+kR0Dah6HvIcSBRXdNZO2InKa6yM/uKe43zNozsz7
        u1JGv2ycqLE9QLhaJWGqMdmm3qQYi0LkCA/OpAZBqoD2
X-Google-Smtp-Source: APBJJlFhiZwn5A9+zi+a+6/13AgRqaNqn6ITD6vaJpGRp6En0Oo8vzbkM4tDJGg+cj/kskjvvWvuPQ==
X-Received: by 2002:aa7:d94a:0:b0:51d:d01c:a936 with SMTP id l10-20020aa7d94a000000b0051dd01ca936mr7828eds.17.1688062794933;
        Thu, 29 Jun 2023 11:19:54 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640204cf00b0050bc4600d38sm6007745edw.79.2023.06.29.11.19.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:19:54 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so1159352a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:19:53 -0700 (PDT)
X-Received: by 2002:a05:6402:5147:b0:51d:e30e:5b10 with SMTP id
 n7-20020a056402514700b0051de30e5b10mr1164043edd.40.1688062793473; Thu, 29 Jun
 2023 11:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
 <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name>
In-Reply-To: <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 11:19:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
Message-ID: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, 29 Jun 2023 at 11:05, Matt Whitlock <kernel@mattwhitlock.name> wrote:
>
> I don't know why SPLICE_F_MOVE is being ignored in this thread. Sure, maybe
> the way it has historically been implemented was only relevant when the
> input FD is a pipe, but that's not what the man page implies. You have the
> opportunity to make it actually do what it says on the tin.

First off, when documentation and reality disagree, it's the
documentation that is garbage.

Secondly, your point is literally moot, from what I can tell:

       SPLICE_F_MOVE
              Unused for vmsplice(); see splice(2).

that's the doc I see right now for "man vmsplice".

There's no "implies" there. There's an actual big honking clear
statement at the top of the man-page saying that what you claim is
simply not even remotely true.

Also, the reason SPLICE_F_MOVE is unused for vmsplice() is that
actually trying to move pages would involve having to *remove* them
from the VM source. And the TLB invalidation involved with that is
literally more expensive than the memory copy would be.

So no. SPLICE_F_MOVE isn't the answer.

Now, we also have SPLICE_F_GIFT. That's actually a more extreme case
of "not only should you taekm this page, you can actually try to
re-use the end result for your own nefarious purposes".

Now, I would actually not disagree with removing that part. It's
scary. But I think we don't really have any users (ok, fuse and some
random console driver?)

            Linus
