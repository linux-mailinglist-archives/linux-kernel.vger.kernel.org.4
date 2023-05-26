Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC1712EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbjEZVho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbjEZVhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:37:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7BDF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:37:40 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-56186035b61so18529087b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685137060; x=1687729060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9/rg2U7H/S/4wiMWQ0QTw8pwZELLTRWhsCcYwQO/2s=;
        b=V5eKKPH8zAUfDNkaDIQfkQtB6MVZzFDTyeHyAlIjRynQmCfVes0oBT6g/CjIPnX+Dt
         MvKx5IGKeOCRI7V63Ih5bJgFdDRByu8ENuPSN+KUfm8HCudMOrrVWL/dYg6d0gZpoct/
         DzNAmJo49MutC0fpjMPC/RBpKOr15ueYQyONi08vRVCC1larS3b9gVXq6Ca8/ojWlwiQ
         G7vozT/3JkWooiuaQZwto5FGaZK23XKh1rwtWSjI4GbqH7oSP2uGRco6VR8DUAY11bLh
         Bx5mQs9WXc6ioDtq2rU83TRnEKzS5g8NaeEu464z6TwKh20bTT7mI4JTtABhB0GqN90j
         e/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685137060; x=1687729060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9/rg2U7H/S/4wiMWQ0QTw8pwZELLTRWhsCcYwQO/2s=;
        b=X0RY7Tlk9IsHv+xW/SNt6AyoDbWASFH7k208pCqe7uDJEGmMdXJFczhHNE6eltFE+u
         13u7ASicI4F7QFoJHl0VBgJfyyTFY8DrD92Z6eJRy78rxSFNbT9U+WDV9Unyf4rJBn8b
         4xIXtx149m/i/2uPuCBIuR4orqUFwYbTmX8lQSXd/0fqcKl/aGUpMC4fhHsqA4g57cNc
         lmzCUmH8SCTcgRy0KbncPmIT7x6HYfxZSJGAObVXCuPRVZB/7sAxz4+NQJoDvyZafKJ/
         b8H0st2Sw/Xj1Dw38CeMh5eLof9Uo42qvdXca1V59lcyuobCfXHqB7F2MplKejTJLGju
         ZybQ==
X-Gm-Message-State: AC+VfDxX+DkxqVa1FNYakv+41ONPHKZNLh8aO9GGvCIbPDezsG8UdRR6
        Jry2ATWf98B3fQWoSZGA/h4iWvFCn6tzmFsdMl0T
X-Google-Smtp-Source: ACHHUZ6dPlAIu9Y6n6ppfo9zlwXpb28g+ZvNNe6IXP2jggt1ZpYLVgfh05LmwZQWvc2lEdREHIR5p59Qhqen1mWCTHM=
X-Received: by 2002:a81:6b09:0:b0:561:c147:1d46 with SMTP id
 g9-20020a816b09000000b00561c1471d46mr3898395ywc.9.1685137060066; Fri, 26 May
 2023 14:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230420215331.88326-1-junxiao.bi@oracle.com> <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com> <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com> <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
 <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com> <CAHC9VhSCjuJZ122EqdDxzJTU1tGq5nU_3+11WGKZ-WHjzU2FBw@mail.gmail.com>
 <afeb0ced-e4e9-6039-893e-b50268c1c148@oracle.com> <58172674-2e0e-1bbd-aff1-881c2096c5bb@oracle.com>
In-Reply-To: <58172674-2e0e-1bbd-aff1-881c2096c5bb@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 May 2023 17:37:29 -0400
Message-ID: <CAHC9VhQu5h6zfn8E5HKG3Krs-HfCXx5TJxTw_oRwr5HrNH1kiA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:56=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com>=
 wrote:
>
> Hi Paul,
>
> The patches have not been merged yet, i would like to resend them, just
> want to confirm i can add your Reviewed-by in the patches, right?

Hi Junxiao,

I haven't personally had the time to verify the blktrace claims that
it doesn't violate the Lockdown principles so I'm not comfortable
adding my reviewed-by tag at this point in time, I'm sorry.

> On 5/9/23 9:13 AM, Junxiao Bi wrote:
> > On 4/30/23 2:46 PM, Paul Moore wrote:
> >
> >> On Fri, Apr 28, 2023 at 6:41=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.=
com>
> >> wrote:
> >>> On 4/28/23 2:26 PM, Paul Moore wrote:
> >>>> On Wed, Apr 26, 2023 at 12:33=E2=80=AFPM Junxiao Bi <junxiao.bi@orac=
le.com>
> >>>> wrote:
> >>>>> Paul,  do you have any other concerns regarding blktrace? As Jens
> >>>>> mentioned, blktrace just exported IO metadata to Userspace, those
> >>>>> were
> >>>>> not security sensitive information.
> >>>> I think this version of the patchset is much better, thanks for your
> >>>> patience.  I don't have any further concerns, and since the lockdown
> >>>> LSM doesn't have a dedicated maintainer I think you should be all se=
t
> >>>> from my perspective.
> >>> Thanks a lot for the review.
> >>>
> >>>> Since there are no changes under security/, I'm assuming this will g=
o
> >>>> in via the tracing tree?
> >>> Should I notify some specific maintainer or mail list for merging?
> >> When in doubt, the scripts/get_maintainer.pl tool in the kernel
> >> sources can be helpful.
> >>
> >> The results for the debugfs and relay files are fairly generic, but if
> >> you look at the results for the blktrace.c file you get a more
> >> reasonable list of maintainers and mailing lists.  I believe Jens has
> >> already commented on your patches at least once, I don't recall if the
> >> others have or not.  I see you've already CC'd the block mailing list,
> >> so that might be enough.
> >>
> >> Keep in mind that we are in the middle of a merge window so it is very
> >> possible this patch might not be merged in a working/next/etc. branch
> >> until after the merge window closes (every maintainer is a little bit
> >> different in this regard).
> >
> > I didn't see the patches in the trace tree yet, maybe better to merge
> > it through block tree since it's a blktrace fix.
> >
> > Jens, can you help merge these two patches to your tree?
> >
> > Thanks,
> >
> > Junxiao.

--=20
paul-moore.com
