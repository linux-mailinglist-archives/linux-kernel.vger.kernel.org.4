Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88905B7FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINEC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiINECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:02:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9E48EA1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:02:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bq9so23703337wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sb7rAbJZuS+StHRfXIZQwRnlRn6aCsFhpXPXtu19SaQ=;
        b=WcFpC1SKt4w7D427YmJ5Tdrd9kMBFrENC/xVio9ndDXv7ugPFzvlaqss6cwGm3PSy4
         0RReYbd2KtIqubWe2dAuGIaSWON4ImCNrAGWxG043j2zg0iUfaVoui3LYf+MpEKE1my4
         vOq4BFvk4hnEPlGfyvU65nLJUR5VengC673opgX8gRY0Gu6rxeyeTE59kSLbGTcH8FvL
         S3cjxj10MxzMNN3FBboqWWhbgbRVCcJ0vWfHqlCbrZMrzNMPvpO1yteL0XNWajeRWjE2
         FHGlnfpHl5RQe6tF+jfJOPa2uip6r39wnJetNlVRGvd5o4VbOO7hP+IV9LLczjgj1Akg
         h0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sb7rAbJZuS+StHRfXIZQwRnlRn6aCsFhpXPXtu19SaQ=;
        b=5zP4OYFLMkx2hzJVzO0Sn2ZZI8tLsUwWYyvOTSh0iIUMP4226ckA44E5N9wA4lq/gL
         unodAUMIZ015uZgg0tpXSKstQRozUxSz8u8I6vH5EOJjCmjGNKL6nHBdHINBH8sfGl40
         DS6cC1vFS8Suyt80RVRjtHcMrEeSgXSbNXK/5BOxECU5+h7vwUme9cwVjxrSkkdhNErf
         SjwXFC+kyPNwfpCluO9pH2NKWYmW5W4XFekxnmiFAwFiWT1Ps6y7ehSie5n4R/Gu4o0c
         /fXbxZiN8it4Kf2EkqhmpRvYHz7IKZm79KmPd6aLpRLWfyta5WDOeuP4o6zZzUPGVL1X
         2e+g==
X-Gm-Message-State: ACgBeo1ycASGOFGv9NhXg2+UnGLPJQ1wJsVMLgvcz3t/nE7mWrN/jm5J
        1iAnJPVZtn3RF1GSUlYdgbPTSwFJFZx4PXDpGA==
X-Google-Smtp-Source: AA6agR78iSAq9l5/YpX1vG1o7mn5nkeDb44f9QKmbUjxBORze5ZAHwUvoZc3FqrpklNof5cdYldFtGBx9yoIHcIX4S0=
X-Received: by 2002:adf:8b07:0:b0:228:da7c:80ee with SMTP id
 n7-20020adf8b07000000b00228da7c80eemr19716209wra.25.1663128137340; Tue, 13
 Sep 2022 21:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <1663060287-30201-5-git-send-email-kaixuxia@tencent.com> <20220913151114.103184-1-sj@kernel.org>
In-Reply-To: <20220913151114.103184-1-sj@kernel.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Wed, 14 Sep 2022 12:02:05 +0800
Message-ID: <CAGjdHu=8pGmyBpVMpf-V=6w7hZHLmG4WH5EsNchn_+GqikTDxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/damon/vaddr: indicate the target is invalid when
 'nr_regions' is zero
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:11 PM SeongJae Park <sj@kernel.org> wrote:
>
> On Tue, 13 Sep 2022 17:11:27 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > When 'init()' and 'update()' DAMON operations failed and the number
> > of the damon_target regions is zero,
>
> Well, I think that could be a temporal failure.  In the case, later call of
> 'update()' could success?
>
Yeah, the kdamond while() loop calls 'update()' periodically to fix this
temporary failure. But for extreme scenarios that 'update()' continues to fail,
we should have some ways to detect this case.

Thanks,
Kaixu
>
> Thanks,
> SJ
>
> > the kdamond would do nothing
> > to this monitoring target in this case. It makes no sense to run
> > kdamond when all of monitoring targets have no regions. So add the
> > judgement in 'target_valid()' operation to indicate the target is
> > invalid when 'nr_regions' is zero.
>
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  mm/damon/vaddr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 39ea48d9cc15..65ff98d49ec0 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -598,6 +598,9 @@ static bool damon_va_target_valid(void *target)
> >       struct damon_target *t = target;
> >       struct task_struct *task;
> >
> > +     if (!damon_nr_regions(t))
> > +             return false;
> > +
> >       task = damon_get_task_struct(t);
> >       if (task) {
> >               put_task_struct(task);
> > --
> > 2.27.0
