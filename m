Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCA611A32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJ1Sfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJ1Sf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:35:26 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CD63362
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b25so4010328qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=554KCjWn8qBcAcBVpoouhKeUYG/Iw1xaVWw3M5KddOs=;
        b=DCzroOtVcESn8/j0p2284O1c8+f71f2wa1HhtWbyeBVb5KrtXtesUm1DKY6tLO/CqX
         oBob/TSHMKmFbqkcAbw8pVZOUno4hI+NzeRw7haRuA1X/fp9UYA0EEKK34zd9GG+8Fmn
         h0agPHPClfZ8rFS2LoP6wiZ0asEbvErvPOO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=554KCjWn8qBcAcBVpoouhKeUYG/Iw1xaVWw3M5KddOs=;
        b=IpYM0UBZLNICOboR+KaZIpTGvjju0oL3jDkJQKoN9AS2lquKOeqPlbRSVtZ3Q9yvyX
         1U/zj1sFeQ3gdnaJCrMdv9D2B1UOi8S5I9YDzV5ZBWossNik9dVZeQF7gLoM9WVbnoQF
         JXlckS9Pev1ntjkuwJrBIEd7CPhAEbBbAlRYRArxaUAp9KGsrgLI9I3MNNxi5fkUfS1t
         gT0Mpye/KCqLlfy/1Y5Dl5NbY86/0QvAMDE5lyxLdBDjjbgV1d2gE/Q81R+npuLtzBSp
         v0uzrB82ULED3YJ7BopoSmEXsRMYicT8NJT9VrxEhbZHdI6e/yZxm0m3HgfYiX6sC029
         UkXQ==
X-Gm-Message-State: ACrzQf07ikZ6GaKHF3zLF/1SZvOxThhQJRPfXisl7enU0DFWuE5ZxHuv
        X73rxWyns4b0fGidY1uKiQd0ZuAcm6qUzw==
X-Google-Smtp-Source: AMsMyM5mE/IFBzZ1aaGiZMvl+rC56PhMEBcXqYMqDf0N3FvoZC6xUvNrgd5OzWqTi/jVvhbSjNVPRw==
X-Received: by 2002:a05:620a:1d0d:b0:6ee:3a2e:d225 with SMTP id dl13-20020a05620a1d0d00b006ee3a2ed225mr550740qkb.10.1666982124422;
        Fri, 28 Oct 2022 11:35:24 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a24c800b006ce515196a7sm3460267qkn.8.2022.10.28.11.35.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:35:23 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y72so7054276yby.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:22 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr619498ybb.184.1666982122579; Fri, 28
 Oct 2022 11:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <Y1btOP0tyPtcYajo@ZenIV> <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk> <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <Y1wOR7YmqK8iBYa8@ZenIV>
In-Reply-To: <Y1wOR7YmqK8iBYa8@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 11:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
Message-ID: <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] use less confusing names for iov_iter direction initializers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
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

On Fri, Oct 28, 2022 at 10:15 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I can see the logic: "the destination is the iter, so the source is
> > the bvec".
>
> ???
>
> Wait a sec; bvec is destination - we are going to store data into the page
> hanging off that bvec.

Yeah, no, I'm confused and used confusing language. The bvec is the
only "source" in the sense that it's the original destination.  They
are both the destination for the data itself.

> Umm...  How are you going to e.g. copy from ITER_DISCARD?  I've no problem
> with WARN_ON_ONCE(), but when the operation really can't be done, what
> can we do except returning an error?

Fair enough. But it's the "people got the direction wrong, but the
code worked" case that I would want tyo make sure still works - just
with a warning.

Clearly the ITER_DISCARD didn't work before either, but all the cases
in patches 1-10 were things that _worked_, just with entirely the
wrong ->data_source (aka iov_iter_rw()) value.

So things like copy_to_iter() should warn if it's not a READ (or
ITER_DEST), but it should still copy into the destination described by
the iter, in order to keep broken code working.

That's simply because I worry that your patches 1-10 didn't actually
catch every single case. I'm not actually sure how you found them all
- did you have some automation, or was it with "boot and find warnings
from the first version of patch 11/12"?


> No.  If nothing else, you'll get to split struct msghdr (msg->msg_iter
> different for sendmsg and recvmsg that way) *and* you get to split
> every helper in net/* that doesn't give a damn about the distinction
> (as in "doesn't even look at ->msg_iter", for example).

Gah. Ok. So it's more than just direct_io. Annoying.

              Linus
