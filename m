Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8276F4B19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEBUO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjEBUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:14:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2BF1997
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:14:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94eee951c70so701281566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683058491; x=1685650491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUwpf5dCSAsRqOsNYrifOv842ZnhqrfcdkR7socPbWA=;
        b=Hhe0NwqMlh+m2MPo5JrIJLXpRSdllSZiwYe+dvWmjqghMVmfGrhIA2WS0dqfKslG7L
         VaMwydsZZFeqtc/RDU/rB+t8bI1UFiMXPVgjlZtFbXbjeb9FZRwPhUEFtmx3ba4Qayhw
         yt+hvMLrZ+b4NC6Yrd6JQ5GFHdvcQFkmjQ1JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058491; x=1685650491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUwpf5dCSAsRqOsNYrifOv842ZnhqrfcdkR7socPbWA=;
        b=R0s1MTvyGEJJamPSNf/ooNSoxb9xNJG4uuv/kBJa8LIlatrjH0Zf6tTiIRpWHHWPGe
         ams1GSaDqtKTP2eyxXnbMEVUAPly2djRCuCyr3Dqb9iQe7GQRYuWikCCN0rBPTWJR84/
         wn7+j5Nsv4atjQg7QLwCmOfaeOdUnPCsvg/so5vSfcDiQQ0AxgFmDyqnoo6gAZmS3JtN
         y0JsNPm57YHthPiIK0Nk1uvaG6qSxwqD8eOvbDiuTQKcV07UlZBsinyFw6tzccHc77pf
         fpJwcrkpb1nNVg39ujzJy3DtBAqCQ1us8U3L/rhbUtRpK96Rk4Y3i/V8PkzcRBwcvu0A
         jtRg==
X-Gm-Message-State: AC+VfDxuT/OWk5OU0V4vhXC5J1X5J68DXa8te0NiVx0Ubv5bhSX46Gec
        rxFGK3/k5nUuQx0TWloGR0MX++S1DZ5q0f+aLwO9oQ==
X-Google-Smtp-Source: ACHHUZ4koWnculTPb2gj00yHLby4J4cWNQ78ePXktwJOWwpWbdHSm5/pQFJfAq1KI+Th4GGYypXUQA==
X-Received: by 2002:a17:907:268c:b0:953:82d7:1c5a with SMTP id bn12-20020a170907268c00b0095382d71c5amr1033300ejc.11.1683058490945;
        Tue, 02 May 2023 13:14:50 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906c40d00b0094aa087578csm16711074ejz.171.2023.05.02.13.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:14:50 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-95369921f8eso703161966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:14:50 -0700 (PDT)
X-Received: by 2002:a17:907:1c09:b0:94a:9ae2:1642 with SMTP id
 nc9-20020a1709071c0900b0094a9ae21642mr1083857ejc.46.1683058489892; Tue, 02
 May 2023 13:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
In-Reply-To: <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 May 2023 13:14:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
Message-ID: <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 9:00=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > I guess it also wouldn't matter as much either if we hid it in a helper
> > like the attached patch and I didn't have to read it twice. ;)
>
> Yeah, I think that's a good solution.

Hmm. And as I was rebasing the patch to fix up my patch, I realized
that the current -git top-of-tree state is actually broken.

That

  #define access_ok(addr, size)                                           \
  ({                                                                      \
          WARN_ON_IN_IRQ();                                               \
          likely(__access_ok(untagged_addr(addr), size));                 \
  })

is actually *wrong* in two ways.

Now, in my original patch, I added a comment about how that
"WARN_ON_IN_IRQ()" is bogus and this shouldn't be x86-specific at all.

I ended up going back in time to see why it was added, and I think it
was added because we used to access 'current' in access_ok(), due to
it using that user_addr_max() thing:

        likely(!__range_not_ok(addr, size, user_addr_max()));

but that was all removed by the set_fs() removal by Christoph Hellwig.

So there is actually nothing task-related in "access_ok()" any more,
and any warning about using it in the wrong context is just bogus.
That warning simply shouldn't exist any more (or maybe it should be in
a different place, like the actual user copy functions)

But that's actually not the problem with the above.

No, the problem is that probably *because* "access_ok()" has that
warning, not all users use "access_ok()" at all. We have places that
use "__access_ok()" instead. Like copy_from_nmi().

So now copy_from_nmi() doesn't do the untagging, so if you were to use
tagged pointers for the stack, you'd not get stack traces.

End result: I think that

 (a) that WARN_ON_IN_IRQ() is actively detrimental and causes problems

 (b) the current "use untagged_addr() in access_ok()" model is also broken

and my patch - which was meant to just improve code generation -
actually fixes this.

            Linus
