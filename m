Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2366A62A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjAMWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAMWpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:45:41 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6478A45
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:45:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g23so9268954plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5j3zGLGYIDHIc+SfHENsP+6wHl7aF41ocUmiDBCYQ0=;
        b=sv+fwEZs5pMW7YVskHNkYk7qS5BEjpjzfeCxS3ESjQdiQl5XM9iJzovzCHHEWE6Y7s
         MTFvGIt5Hii5NRUJICpBuh/r6ih6T67irFuzXknIY4slT8OJ4uK+8L8L1LsG+aitRASo
         HJOldOsuOFnWws+gR2XL3l/j0snkMAQYsBny89H18kYGhDttFWDgrALPFwxmxFsFJYNA
         hamRZvpYgilUsG2lQOkLcp2SE6PT8Bcj01M0/aA5Em60vzlbjungF11aRRhrx8AB9rVL
         57FTsmyXpn6W8/V8DGywlrC0cmq/aTg8gyglFU4YI4ES7DZ6alHDlm59jsKGTmnRJ/Fm
         92fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5j3zGLGYIDHIc+SfHENsP+6wHl7aF41ocUmiDBCYQ0=;
        b=DiaFgo5kdhNH/KAUm98xDcEhSfuYZCY/v9WwZ36L0jfhe/quUydTBiUf/UJzqa3waZ
         koUJ79c8jqDs65+VU6BwvJB0K5SJrhzWUxySHZd9l1ivS8EhiHBFLnlk2q/3IO7GjjtX
         5q9W/rt4yZ9cMhgIoRadFzBhyzkgk06r9eKpQ4iU3BU/nHknYCS5NmgfCNdzH9bs/2ZF
         mSw/wJ4/S0RdKT+juIu3IF+ArUFDiCw43lLwD2QL0Aqopzq11gvpi7xCqaEmwQ/ektzA
         co8Fm1RV+9IBEXsCtqUCMEXr64zSUjdY5Cz7BdFny/IChdLd39x5d8qVjD/jVYQfu77T
         sY3A==
X-Gm-Message-State: AFqh2kohx/CTeTSKQAXXSW6R8tYqdkfCovq8Ly9n2eFOrrEq9DyxhDfv
        1HidAPFykXII9ZcdFNWfI7hrQcwvlvTetU0SLYmXtA==
X-Google-Smtp-Source: AMrXdXvNn1l4cxy+9xn/nsyxTYoAvQss413ZOx3wj1jctbxKLz3mF1xHLFglrxI34f3o75+G+8kx2bjw1IwtlX6i7OI=
X-Received: by 2002:a17:90b:3c81:b0:219:2e8c:d1d0 with SMTP id
 pv1-20020a17090b3c8100b002192e8cd1d0mr5949807pjb.57.1673649940289; Fri, 13
 Jan 2023 14:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20221220031023.197178-1-rmoar@google.com> <CAGS_qxrp_oT7b_NNP4PfES06QAp-V4B4BAETFd3Wv9x-F8Zhrg@mail.gmail.com>
 <CA+GJov4cyXhLnVtSMB8vBzscN0_y4fmSegEJjCr1aY51aCs5Bg@mail.gmail.com>
In-Reply-To: <CA+GJov4cyXhLnVtSMB8vBzscN0_y4fmSegEJjCr1aY51aCs5Bg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 Jan 2023 14:45:29 -0800
Message-ID: <CAGS_qxqz31x_ya1BhoL=3xXLWnuwcJErdUweGK_tKx2KP_tLYQ@mail.gmail.com>
Subject: Re: [PATCH v1] lib/hashtable_test.c: add test for the hashtable structure
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 2:23 PM Rae Moar <rmoar@google.com> wrote:

<snip>

> > Note: given x is supposed to point to a or b, I don't know if checking
> > against a.data does us much good.
> > If we're trying to check that hash_add() doesn't mutate the keys and
> > data, this code won't catch it.
> > We'd have to instead do something like
> >   if(x->key != 1 && x->key != 2) KUNIT_FAIL(test, ...);
> >
>
> This seems like a good change to me in combination with changing it to
> x->visited++;.
> Although David's suggestion might be slightly more exhaustive.
> Why wouldn't it be important to check that the key matches the data?

Checks like
  KUNIT_EXPECT_EQ(test, x->data, a.data);
won't do anything, given that x == &a.
We're just comparing x->data to itself.

So we would have to write something instead like
  hash_for_each(hash, bkt, x, node) {
          x->visited++;
          if (x->key == a.key) {
                  KUNIT_EXPECT_EQ(test, x->data, 13);
          } else if (x->key == b.key) {
                  KUNIT_EXPECT_EQ(test, x->data, 10);
          } else { /* some call to KUNIT_FAIL about a bad key */ }
  }

Maybe that's worth it in one of the test cases, but I don't know if
it's necessary to replicate this in the other places where we're
incrementing `visited` by checking keys.

Daniel
