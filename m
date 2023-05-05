Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE726F885C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjEESEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjEESEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:04:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C11E998
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:04:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so4054144a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683309845; x=1685901845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdJjs9CjNXLLFADO9bBX7juUeHygp4VbE2s0YcEvSDk=;
        b=bNqbfVfGD+0ZuohZwGAG5mSHHZ0SjE+Xt8+Weh02vLh+Nh6Mt3x6amCsWPomuFSAuI
         S/1bo9O/VZ3+TYyQY+bU+FuLpUz98R8FRtPYP6c+49j9Wemees1nklJQnvVcf17NaqdG
         x11zOICMpyqCibtnyYFZalyyJ8rtmGABKY3Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309845; x=1685901845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdJjs9CjNXLLFADO9bBX7juUeHygp4VbE2s0YcEvSDk=;
        b=Cx3im/L5DZUb4/iiRT2gaDeSaevFif5B49k5J04WrmOVff0bwT10mRHh5tp0QWb0Fp
         VD5gS09Of56LJh3OiX9rgHB3+bPjjw3QSj9frOOqfLccuG4a//bUkZRV/LxQnSJia80r
         Z8NLMvvFLw/4LzVXAdTDFApExvgCUrRF5xK/DPfXPeSGJ2nEVVoE5OarH5a9jAKlLYgv
         5/JnrZouM6vrtaYcWQKP7hAPqSSIYTT+neCqB7xv2R4U5Nbj/dfnRz6o33HvBNJd8vDB
         nLrEuKDI+FdFrC5BXBZXij8IkVqZHvTHpGi45mM2y+/A73QVJf7gMCHP8Opwt/OPKRXr
         WbhQ==
X-Gm-Message-State: AC+VfDzkCBXflLJ4/FgGs0OIeWfp2TtAqZeVCjYqca6I1Hc8zTI93l51
        JNsFVK2bhtKc7KtouKgihoTAccWp9HOxTIcs5N11ng==
X-Google-Smtp-Source: ACHHUZ4nKa3xkajKiMRqubW1fQXHbA2QsTLhlCB/zHhJQICUHwPzxktDgvX7cMCvcb97iHqR8ZrBSg==
X-Received: by 2002:a17:907:868b:b0:961:57fb:10c1 with SMTP id qa11-20020a170907868b00b0096157fb10c1mr2040161ejc.63.1683309844920;
        Fri, 05 May 2023 11:04:04 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id z5-20020aa7cf85000000b0050bc6d0e880sm3151534edx.61.2023.05.05.11.04.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:04:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so4045083a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:04:03 -0700 (PDT)
X-Received: by 2002:a17:907:3f9a:b0:961:be96:b093 with SMTP id
 hr26-20020a1709073f9a00b00961be96b093mr2186880ejc.36.1683309843677; Fri, 05
 May 2023 11:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org> <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
 <ZFUMja5MpRPWCRXw@8bytes.org>
In-Reply-To: <ZFUMja5MpRPWCRXw@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 11:03:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
Message-ID: <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
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

On Fri, May 5, 2023 at 7:02=E2=80=AFAM Joerg Roedel <joro@8bytes.org> wrote=
:
>
> On Sun, Apr 30, 2023 at 01:07:45PM -0700, Linus Torvalds wrote:
> > Anyway, I'm not super-happy with how this all turned out. The example
> > merge seems to be wrong, and the Kconfig situation is confusing.
>
> You are right, looks like I missed some context when doing my example
> merge, sorry for that. I will take more care next time.

So I find the suggested merges useful even if they are wrong - it just
makes me look at what I did in an area that is clearly non-obvious.

And the part that made me unhappy about the merge was actually how
non-obvious it was, not so much the mis-merge itself.

That config option rename in particular I find to just be bad. We now
have some code that is *very* central, to the point where we have a
field for it in the 'struct mm_struct', and special callback for
fork() and exit(), and then the config option is called something
completely incomprehensible like 'IOMMU_SVA'?

That just smells to high heaven to me.

Now, I'm not saying that 'struct mm_struct' is some holy thing, and it
has a lot of other strange fields that get enabled by strange config
options. But I *am* saying that it's one of our most central data
structures in the kernel (just behind 'struct task_struct'), and when
it has something like this in it:

    #ifdef CONFIG_IOMMU_SVA
                u32 pasid;
    #endif

that just doesn't look right. "IOMMU_SVA" just isn't an obvious or
descriptive enough name to be involved in that data structure.

The old name ("CONFIG_IOMMU_SUPPORT") honestly made a ton more sense
in that context.

So I was a bit frustrated with the merge.  When there are merge
conflicts, the way I resolve code is to make the resolution make
sense. Most of the time that's completely trivial, then occasionally I
have to look at the code history to see what people were doing.

And in this case, I didn't feel like the end result made sense, if you
see what I mean. The resolution is _right_, but I'm not happy about
it.

                 Linus
