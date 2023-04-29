Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B456F21CF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347183AbjD2BFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjD2BFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:05:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F440DC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:04:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f4b911570so73081566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682730293; x=1685322293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTn0uOMGTuWLuRngMF+Mi86XU8w2URv7NcBiyCeRgDc=;
        b=JSkbGKCUjHZI7+nBhJqBBrG9nvRCvbkJv5nmz5Ts+E4aZZXlHNDnYtGaRKGjYM0lHd
         z1dqaD7q+5NIDUZldy82M2qxQlxv9o53OEXpLltaHuD1lSu9+IcHrL8vP14DEhI85oLq
         VomV/Hs1SLn6fR2DO4p1rz4PFQtrQyD7tOvFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682730293; x=1685322293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTn0uOMGTuWLuRngMF+Mi86XU8w2URv7NcBiyCeRgDc=;
        b=bBo/fO4TnIInMe68ibJnIHmhiSmXRsyPHf7nPq/ywLQjJ3yFGuJctFr9VjTlMS9ptS
         7dFp1VbPYq26OBYwyAWaEaCWpwrweBWshJc5odxkNm+6LwV5KkTd0mDrHwcmxVmNP0/v
         hzhZY+LygCDJtTOqGSnIFpxdD4vJsU1cBahZxghtkcFekZVV+IOoaLmkk1QwBQbhy39A
         JeUTey3UpASL52Yl1Vbh7NdqtWEHEp7rUVbj+bqeFXz1iNWb6qBuFsPTgJ20lOpU3SuF
         ArgFNI0JgRjnbsZwVSHqb/UwufqGC/6j3hAVrESxurW8vDvfz2ELNDLMDWQwauB9IBpk
         pBvg==
X-Gm-Message-State: AC+VfDxivAMN8U1KlTwunUtqZY8L+wW4KsWpn/bcM3uiG5DDn4FL9OWn
        YRcC/BaJYX+7eMDrEuX4ok4E+lXtizBsJH8vnLFg2wEe
X-Google-Smtp-Source: ACHHUZ4wmbBCsytbUF2C7yaBstFEpmz71mrBdwp6cK9wToNxwEJ+9+O9p73Pxz6xtc6A+v91DAFjUA==
X-Received: by 2002:a17:907:3e1b:b0:95e:d3f5:3d47 with SMTP id hp27-20020a1709073e1b00b0095ed3f53d47mr7553552ejc.48.1682730292817;
        Fri, 28 Apr 2023 18:04:52 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906349900b0095336e8e012sm12073787ejb.176.2023.04.28.18.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 18:04:52 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5050491cb04so492544a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:04:51 -0700 (PDT)
X-Received: by 2002:aa7:c849:0:b0:506:83e7:8c6c with SMTP id
 g9-20020aa7c849000000b0050683e78c6cmr456351edt.10.1682730291434; Fri, 28 Apr
 2023 18:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com> <20230429003822.n3mglslg666j3npp@box.shutemov.name>
In-Reply-To: <20230429003822.n3mglslg666j3npp@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 18:04:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcBw8yV-LPz-64D-9c6xS_eWbw_75qpyrqvUtUXy4szA@mail.gmail.com>
Message-ID: <CAHk-=wgcBw8yV-LPz-64D-9c6xS_eWbw_75qpyrqvUtUXy4szA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 5:38=E2=80=AFPM Kirill A. Shutemov <kirill@shutemov=
.name> wrote:
>
> BTW, I think the static check can be relaxed. Checking size against
> PAGE_SIZE is rather conservative: there's 8 TB (or 4 PB for 5-level
> paging) guard hole at the begging of kernel address space.

So I don't worry about the size per se - we just don't have any
constant sized accesses that are bigger than a page.

The constant-sized case is for things like structures being copied to
user space.

And having a bug gap is nice for the suzkaller case, although I don't
think that GP fault has triggered lately (or ever, I don't remember).
Having random system call arguments that trigger "oh, this is in the
non-canonical region" is a good thing.

> > So being careful about the range is kind of annoying, when we don't
> > really need it.
>
> Hm. Is there anybody who access high to low after the check (glibc
> memcpy() bug flashbacks)? Or not in any particular order?

Yeah, I can't think of a single case, which is why it seems so silly
to even bother.

Almost all real life cases end up being limited by things like the
page/folio size.

We do have exceptions, like module loading etc that might copy a
bigger area from user space, but no, we don't have any backwards
copies.

So you'd almost have to have some "access_ok()" followed by random
access with a user-controlled offset, and that seems nonsensical and
fundamentally impossible anyway.

But just because I can't think of it, and go "that would be insane"
doesn't mean that some driver ioctl interface might not try it.

Which is why I think having others look at it would be a good idea.

               Linus
