Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3E641362
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiLCCaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiLCCaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:30:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364CBFAD3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:30:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y17so6254679plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 18:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CWt07COLqhM0wZS8+aSuBFX0K5MaXOD5vm4AlkQK9u8=;
        b=ibJN+4wupMeFZ8AsO0XiaFGivYyW2MY8j9syFwSujyzsv8WIvvQldHP0Mw+8z+BtGq
         +UM8iq8dyM8sYwdY14XNad29HiFmWd6Qav74FWK5Ij3GLXj+9mUdrsoQ9Op6Brm9boVS
         qA69QuShWk84L3KGUcVi8zcoNcRtMcDwru8WtwsOUxBX4PCzQq2yi4ArmDlhntkN4FuY
         SrkCGavYXx5dNpTWKxnmz4RLfgfohN8Uebag3wtDA4QffX+MVkAr/CjWUbotqfxo0Sd5
         5eGUlsoWU0/Vd2EXp3Oorpz8Dx0a0o6CyY8W3M5Bfyo98mfI74cnheSly1UbCCx0hDzj
         46qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWt07COLqhM0wZS8+aSuBFX0K5MaXOD5vm4AlkQK9u8=;
        b=inCMFDiG3mdYjRNY2El6ldc+Kn3BLTPS10xRtY+57z3Mv7dUnVSjeNkOSypK3p+ArA
         7kpmlaTOp3Li0DsGNPBu922aAygW7oz2rqNCIQm5QrtSHye5hID86YnPHV4e1bcADP/2
         QN4wlkN91T4J5YNf/+B3RI9sk2QQfOnX0ASJNk6rngx5D51cdE/+Z7v5yo9dw5JxVHgl
         hBFpNds+ZG5fHNvfB+Tx26GW9MwAqV0nqtk5Q2xcpDDizy7BUyvxDbZWxhYGPX0iA/bi
         fx155Mxoc/1YhrLlGYTD+Ic7N//Gs49F/F/QOA7cy/TfCJ8JCYzvEBA2x5GSfxNbAWtX
         4oUw==
X-Gm-Message-State: ANoB5pnJpBnJiX1BCSVhHRpocu88rdc7W9y/YzsjvyBPPhehuGR5nLWC
        m/tNoiVSNf4zNPI0SO/+Sbp7A6IWQwGV/5Kk1oFsvQ==
X-Google-Smtp-Source: AA0mqf4+7wHUUYy7iS3SBS3k5hhK+zqhcW2r6ExsGfYHliv7BR/cjYNM/HINU3xucnxLrSzdQD0p4/Gr+j/OQbHxh0I=
X-Received: by 2002:a17:90a:5317:b0:213:34f7:fb14 with SMTP id
 x23-20020a17090a531700b0021334f7fb14mr82075775pjh.25.1670034609492; Fri, 02
 Dec 2022 18:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20221202013404.163143-1-jeffxu@google.com> <20221202013404.163143-7-jeffxu@google.com>
 <CABVzXAkoGoypAs86EG5RsJZ=CXPu3NtTHb7_2=byQt7A7p7krQ@mail.gmail.com>
In-Reply-To: <CABVzXAkoGoypAs86EG5RsJZ=CXPu3NtTHb7_2=byQt7A7p7krQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 2 Dec 2022 18:29:32 -0800
Message-ID: <CALmYWFuR93cgj1_P4=S81Wntg-m_6g-0Vd2JQmrLWmA7=B7QVA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memfd: Add write seals when apply SEAL_EXEC to
 executable memfd
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
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

Hi Daniel

Thanks for your review.

On Fri, Dec 2, 2022 at 3:24 PM Daniel Verkamp <dverkamp@chromium.org> wrote:
>
> On Thu, Dec 1, 2022 at 5:36 PM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > When apply F_SEAL_EXEC to an executable memfd, add write seals also to
> > prevent modification of memfd.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/memfd.c                                 |  3 +++
> >  tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 96dcfbfed09e..3a04c0698957 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -222,6 +222,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> >                 }
> >         }
> >
> > +       if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> > +               seals |= F_ALL_SEALS;
> > +
> >         *file_seals |= seals;
> >         error = 0;
> >
>
> Hi Jeff,
>
> (Following up on some discussion on the original review, sorry for any
> duplicate comments.)
>
> Making F_SEAL_EXEC imply all seals (including F_SEAL_SEAL) seems a bit
> confusing. This at least needs documentation to make it clear.
>
> Rather than silently adding other seals, perhaps we could return an
> error if the caller requests F_SEAL_EXEC but not the write seals, so
> the other seals would have to be explicitly listed in the application
> code. This would have the same net effect without making the
> F_SEAL_EXEC operation too magical.
>
If we take error out approach, application need to add
F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE
when F_SEAL_EXEC is used.
Personally I think it is a bit long. From an API point of view, we can
think of this as
sealing the whole executable instead of just "X" bit.

If there is a new type of write SEAL in future, all applications need
to be updated, that is much harder,
and updating the kernel is easier.

Maybe I should remove F_SEAL_SEAL, so this code is still correct if a
new type of "Non-Write" seal  is added in future.

> Additionally, if the goal is to enforce W^X, I don't think this
> completely closes the gap. There will always be a period where it is
> both writable and executable with this API:
>
> 1. memfd_create(MFD_EXEC). Can't use MFD_NOEXEC since that would seal
> chmod(+x), so the memfd is W + X here.
> 2. write() code to the memfd.
> 3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to !W + X.
>
> I think one of the attack vectors involved the attacker waiting for
> another process to create a memfd, pausing/delaying the victim
> process, overwriting the memfd with their own code, and calling exec()
> on it, which is still possible in the window between steps 1 and 3
> with this design.
>
There are also step 4.
4. call exec on the memfd,
In confused deputy attack, attacker wants to inject content into memfd
before step 4,
because step 4 is by a privilege process, attackers can gain root
escalation this way.

Ideally step 2 rewrites the whole memfd,  (injecting  content between
1 and 2 won't work), and
step 3 is the next line after 2, making the process to stop  exactly
between 2 and 3 is not easy.

So enforcing W^X can reduce the attack surface. It also defines the
most secure way for dev,
or else, dev might:
- forget to apply the W seal.
- choose to apply X and W seal in multiple calls, thus adding a gap.

> Thanks,
> -- Daniel

Thanks
Jeff
