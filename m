Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED6618688
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKCRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiKCRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:46:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3691AF2A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:46:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f5so7328771ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e2vl8ggBQ4DSKIkQaxbrvGPJDtNwTTQXpx+tZPGGN8o=;
        b=EvIvCAkWd7vySy5cybOo5dSXSJUaPIRJpDjtFYj0STk5LWyLct9eEPK12BRCKIM4My
         hlj1AFu66Ep6lPBqlahaJCW60VORMqxez5xD42rPr1ctZtSaMN8uSMAZ0vtW9eTRptvg
         xxxRIzJQA7M48Nakd+z8C85wbXZkjlB39cw4TQU3xealVdjmdXTbizLcmbOdbnMqTgEZ
         TaqfBSiA17CVScCYMsl12JAAdoHjoRnCR088mCY8d7oTQxEkuv2W60H7s838DkbV8K2Q
         S+E3um0kNwwvIYbAlAg88uVNQxqCCH+2neQniHsISDN0QsvmvBdgUxyvf0qFGQE0JenR
         wSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2vl8ggBQ4DSKIkQaxbrvGPJDtNwTTQXpx+tZPGGN8o=;
        b=vDYhuVG1M7nzcGsej1QD+E6A4TMNqt2xM6/ejxtV0qBwiYdsPMCdEMzCEc9/ed2r8b
         6X6H8sOta/zValv8J54k2DHBWwkQLUB/koQD2aOcFUCI38eAgJQJlu5A/cUUCmZc7cdB
         LSQ+SY2hxAPJFHt9GgOdkreRu/ilbl2SLuLC1G06B9EndLmJJIc3cr1t1Wlnw/zHy4zL
         671ylJRL8iEZ1Io/UxdvoplWJkJPEKyrD9GDVTdY2uwuEtMhIzbI5dYeyfymlBHh14QZ
         bbHEny+l6xuxstTwfmb8yCzj+A+WhoxIGi6Bjxf5txIsGjOA9OqhbfLTuyDT+cC/6Wtq
         kfqA==
X-Gm-Message-State: ACrzQf24krQX06utvQdBvv5QJ1twtbHSLmogxoiA7an15GJUUmv//NI2
        hbs/lpuLlfWX5xRFgsJtY9aaaMc5ZtbaN2LSRddCXQ==
X-Google-Smtp-Source: AMsMyM5OdMT8h0r9sTXgL/pREiL0rU9mrqoPbLfTmrZFu/cEpJpgbnldnZzM/kekiYV9zZ7TUEYWUeDGduEIA++yJnk=
X-Received: by 2002:a17:907:7d8f:b0:78e:2cba:560f with SMTP id
 oz15-20020a1709077d8f00b0078e2cba560fmr30429617ejc.173.1667497565298; Thu, 03
 Nov 2022 10:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221102164005.2516646-1-dlatypov@google.com> <20221102164005.2516646-2-dlatypov@google.com>
 <CABVgOSki2WnA_JyYTwdzQJB+fJDPkFRWjmwW60vih+aEJ2QmLg@mail.gmail.com>
In-Reply-To: <CABVgOSki2WnA_JyYTwdzQJB+fJDPkFRWjmwW60vih+aEJ2QmLg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 3 Nov 2022 10:45:53 -0700
Message-ID: <CAGS_qxpVvM825nxi2Vw3WcSAbbHJKPCk0Thx9LGgnz5FtPgxNQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: unit tests all check parser errors,
 standardize formatting a bit
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Wed, Nov 2, 2022 at 11:38 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Nov 3, 2022 at 12:40 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Let's verify that the parser isn't reporting any errors for valid
> > inputs.
> >
> > This change also
> > * does result.status checking on one line
> > * makes sure we consistently do it outside of the `with` block
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good, thanks.
>
> Note that this patch does conflict with "kunit: tool: print summary of
> failed tests if a few failed out of a lot":
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=f19dd011d8de6f0c1d20abea5158aa4f5d9cea44
> It's only a context line issue, though.
>
> Reviewed-by: David Gow <davidgow@google.com>

Oh huh, I rebased onto the kunit branch and it managed to merge cleanly.
I guess `git am` is more picky than `git rebase`.

I'll send a v2 that's rebased to avoid issues applying them.
