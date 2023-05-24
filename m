Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3870FD70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjEXSFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjEXSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:05:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB8180
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:05:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30789a4c537so853929f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684951506; x=1687543506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGNgbJnX0tVJRsKgUg1OydGKxpSLVGxD0LmlnA5I/bM=;
        b=T3bmdGNXzv6F/ZNJVh0QwRzqZQCki3KwhMEXYoFLZNVZ5sc0qmYH8Fw8Tzu+29lruu
         yEXlDnvHD/EQop4XIpBtPbjIHYvfCVyHtfiVhOtp22z5Nuk0mjwClPsGrymFR4Dlcz5i
         kC+uv1iA7XZSuF5J3ShKIQMHCCh4rd5bTUStI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951506; x=1687543506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGNgbJnX0tVJRsKgUg1OydGKxpSLVGxD0LmlnA5I/bM=;
        b=b7//kkxz3HE1qg6vF2C+qtc+dpBMq+tp/mOXg2vM7JY4HdoYIv+xrM/GosNXK5l/bT
         InasHD6OliJAPdiIWVrWquRuXmwN3tuRh3nsDf7/yNMAX8HgLKBhi34qCmSQAz7Yr6Gb
         EWugJ0Py2fwVnMfLpftqqiSIWhHV4MMS96gOlD/VxBaiEVpRUnLJ53CCJlv4YJzBJHjm
         cIEFimLNz40k3n7sR0BFxGPmX52G4QDbGbi2Qf8uPsE+BUkIo+ldZZseXQUActkfQM+v
         m6S6kSiwMpxKNB6uju8jg7W/cLZzVl7t94cb7GjHVL3D09jLRvDxNfpXmSz9/RDAMMUA
         d8hw==
X-Gm-Message-State: AC+VfDyVByTwuEhIDiMkPTX/sVtVf3jUGjrBR1ao7zD4Kxn5nO7RR1Ty
        3Qfy1A77DHAeocu5XXIv2TIbQzLJBUsBfkFJHlLl6Q==
X-Google-Smtp-Source: ACHHUZ6ALmCPhK5rkszARkB26zQAaXHx/UD16iJSre39FqEv+jJsUXS7DYivRjjrf/EemoUmrobXzoF8NaU0TSLh2OI=
X-Received: by 2002:adf:f58a:0:b0:307:a7af:402c with SMTP id
 f10-20020adff58a000000b00307a7af402cmr422705wro.41.1684951506392; Wed, 24 May
 2023 11:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com> <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
In-Reply-To: <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 24 May 2023 11:04:55 -0700
Message-ID: <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> > Could you elaborate on what exactly you would like to see added? It's
> > not clear to me what is missing.
>
> I should have been more clear, let me try again ...
>
> From my perspective, this patch adds code and complexity to deal with
> the performance impact of auditing.  In some cases that is the right
> thing to do, but I would much rather see a more in-depth analysis of
> where the audit hot spots are in this benchmark, and some thoughts on
> how we might improve that.  In other words, don't just add additional
> processing to bypass (slower, more involved) processing; look at the
> processing that is currently being done and see if you can find a way
> to make it faster.  It will likely take longer, but the results will
> be much more useful.

The fastest way to do something is to not do it to begin with. The
next best thing I could think of is checking a trivial condition (int
equality + bit check) to bypass the work in the hot path, which is
what this patch does. I'm not even adding a new condition for this,
I'm using the existing context->dummy. It is also 100% transparent for
end users, which get the benefits as long as they don't have any rules
that target all syscalls.

It's not very useful to see futex() and stat() syscalls being audited
when we have no rules that target those. The processing of rules in
exit is already fast for a reasonable set of rules, but we don't have
to do it to begin with. List iteration is not going to be faster than
a bit check. For VFS related things we also have to collect paths
accessed during processing and it's just not useful when we know that
there is no way these are going to be used.

We started with a ruleset that was matching all syscalls and this was
very expensive. We reduced it to targeting specific syscalls, which
made it a lot cheaper, but it's still a very noticeable fraction of
overall CPU usage (the benchmark in the commit is the evidence of
that). Not enabling auditing on syscall entry is the next logical step
in making audit cheap enough to not feel guilty about using it in the
first place.
