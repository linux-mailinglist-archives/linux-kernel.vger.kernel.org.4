Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E56A83FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCBOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:14:45 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB4234EC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:14:44 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id g6so6760708iov.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=732b5wP+BowSmRkkbJVoygYQGzzLcyCOL0CaRiRQkbI=;
        b=BD98PveroswgOLELzmE6VIl8n5CeYoqZMduPI7QJjqPZcji78t1C+pPl48AT3pxbwQ
         9YFmNgz7El1VQScoFHzJ/svLim3JH8+fNMBeIIF55REHFVhILd9TYSE1mbWUrmzDjdQX
         JhCPLu0x1Y4hZ08/PIDJLAdpOulYuSVSbM2l6mrBF+jh3dNYXdwXuyOraXslQv8GB3/U
         m8YSl6J32I7O/gC5LP8m67dzVO53BpkcVNJtsJ9OEJC80r/DJBvPKmn/0te+GaxLspBC
         XwAThV+qvJH4tBxFu9ez6RFGYc6hVFwMX9eE5KSnNkwkOqVU1vzNjKS4gJxnZxAhFFCJ
         zFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=732b5wP+BowSmRkkbJVoygYQGzzLcyCOL0CaRiRQkbI=;
        b=NiTnd1A0U4p1VXoSJ5gIQe4BbP5OGwXwmjGqmsvP+xzJv0GebclAp5EG/aujcLi/eC
         1qg9Q/ktVHxP17Bk6K+EKJLYzcWWFNwfek0mEgSdmRHJcBMFi0a4slQW3rEG1j7Cg3A/
         jCPjwYX2Ebf8Xfl3Zw66L1e2DO0hSheakuS93p4MUaaplWvtJ/jUQyC24bjg7tsfqGCx
         0eyEB7mFnkKUqzUa12+CyKFBlFGE0PgyC/HSW0VkZPAJg+AQl1aC0Z/C5TGHIqiT1ILB
         scVyG/Nge2v5WCHcMwZBdDpC0UA4xY3u4Y6x1kipNMo2onskt9ij5qFzCjgb12y8FhLg
         HqjA==
X-Gm-Message-State: AO0yUKX3d2azq7gM70FtFRq/z5kNOkA3BeHXK7EpXpLZFYUbHIXlXFGQ
        olJvruKs2Btz3vsiLCbDnPn4mMQUSu6g5ujeVDlzGNbhX4PAfJwz
X-Google-Smtp-Source: AK7set8+wlmmGu++ONW5xj7HgngOtl9j0r1Dk7jOzX6yp6wc8kOvY/ReR7vw83x0DvUspbDl2cFQU9++XrxQ5wokKbY=
X-Received: by 2002:a5e:c243:0:b0:745:70d7:4962 with SMTP id
 w3-20020a5ec243000000b0074570d74962mr4904464iop.0.1677766484171; Thu, 02 Mar
 2023 06:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <20230301143933.2374658-4-glider@google.com>
 <CANpmjNO0GBpfRbT1YnNnoupVG7TOcuBbTHzxNyZwdJaH3W7w5g@mail.gmail.com>
In-Reply-To: <CANpmjNO0GBpfRbT1YnNnoupVG7TOcuBbTHzxNyZwdJaH3W7w5g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Mar 2023 15:14:07 +0100
Message-ID: <CAG_fn=VjYhMrXuAR=tyXeC6-wTYA+EmkHQZf5nGwCCKwpApjUQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kmsan: add memsetXX tests
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 2, 2023 at 12:23=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Wed, 1 Mar 2023 at 15:39, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > Add tests ensuring that memset16()/memset32()/memset64() are
> > instrumented by KMSAN and correctly initialize the memory.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  mm/kmsan/kmsan_test.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> > index cc98a3f4e0899..e450a000441fb 100644
> > --- a/mm/kmsan/kmsan_test.c
> > +++ b/mm/kmsan/kmsan_test.c
> > @@ -503,6 +503,25 @@ static void test_memcpy_aligned_to_unaligned2(stru=
ct kunit *test)
> >         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> >  }
> >
> > +/* Generate test cases for memset16(), memset32(), memset64(). */
> > +#define DEFINE_TEST_MEMSETXX(size, var_ty)                            =
      \
> > +       static void test_memset##size(struct kunit *test)              =
     \
> > +       {                                                              =
     \
> > +               EXPECTATION_NO_REPORT(expect);                         =
     \
> > +               volatile var_ty uninit;                                =
     \
>
> This could just be 'uint##size##_t' and you can drop 'var_ty'.

Indeed, thanks!
