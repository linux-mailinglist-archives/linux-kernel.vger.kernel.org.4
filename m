Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29994697AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjBOLnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjBOLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:43:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C555B8B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676461371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kbdKU98/vo3fMtB/dos++x3HLoxdm3oQAZqZchHYs0=;
        b=er0FUyHHTA31jO4i/7/5YK/mzqUEyiCTYp2ZiqZp+o6HKOp27jQH7FmKEvzn+LiyX6cbB5
        w1M8xXRa1HDnn1LIK5V2wCr/ciRebAhKuXCja+G/RrTU7/yar/3QE4zFb+q+KKQYemg3sy
        aWoLus2zuVia9RrCiDeSvSaVg6WMPs4=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-264-9mr21VxnPgKrYanGoE4Iug-1; Wed, 15 Feb 2023 06:42:50 -0500
X-MC-Unique: 9mr21VxnPgKrYanGoE4Iug-1
Received: by mail-vs1-f70.google.com with SMTP id o19-20020a67e153000000b0041221fdc3cfso2384933vsl.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kbdKU98/vo3fMtB/dos++x3HLoxdm3oQAZqZchHYs0=;
        b=UHoEdZ1QCNz4kSlIkbtXb49uNvl1+aVk9/e1ejg3hl+TDA9I3Lg8OQTPLbP2mvAft2
         ySQ0k4u8rZT7bZCBfYOJtAGlf8t0TC8WIhd0d75E90a1mOc5SgwUiEY/x+OC60yUZGD8
         XSkpHHyZl94y2bilvUeKNVfh44Utvd4ifku+z2V0S3oudOsKnrj7AmNNIsqlWSWrf1jc
         xIKkqIFOpMO4BchnbOLsbCDAUHsDQMb+P1ppPhAa+NUVwNXwcGWL1d5de4/f2rIF0kLM
         umbwhDCapN6WW0SGTCCWiAql90mvbsPi2ARZ2kip8hfQQ405GyVvt8S1oqNEfZwSHJ+v
         RcKA==
X-Gm-Message-State: AO0yUKXQK2AiaPCUxbLeplRuuD2Wz2KfigfCwIMfV/joLrFgMA9cE1ne
        h/bDy7hNzq2yEhfYaVHDotxx4AQMlDSVCE1JZLsnjUJpszg+3dN2lQjaR7gtNDiY5PvexLsdtn4
        T7EteUL8ned0T7QW9jDFe5yZHRZwmGChQ9aKk6zgu
X-Received: by 2002:a05:6102:34c7:b0:411:bd2e:11ac with SMTP id a7-20020a05610234c700b00411bd2e11acmr287369vst.75.1676461369788;
        Wed, 15 Feb 2023 03:42:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+kUPt7gGzhiQgVyz2CNApAZCVfBk6sZ3Tsubo9kL7OIwxXKmGLrqpTGKjxBr7zf81hSPv+GO0q1wH37PJfvTc=
X-Received: by 2002:a05:6102:34c7:b0:411:bd2e:11ac with SMTP id
 a7-20020a05610234c700b00411bd2e11acmr287362vst.75.1676461369540; Wed, 15 Feb
 2023 03:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net> <CAOgh=FwCk1qMUAqkv+aih_=6vJ0SjqyzS9-gW+v+YjEse6V0Yw@mail.gmail.com>
In-Reply-To: <CAOgh=FwCk1qMUAqkv+aih_=6vJ0SjqyzS9-gW+v+YjEse6V0Yw@mail.gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Wed, 15 Feb 2023 11:42:33 +0000
Message-ID: <CAOgh=Fx_i87_9gGpfPGJ2uNfEK8W=bH=40Dy8J5yYz53qPeRSQ@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: Invert fallback armpmu_filter() return value
To:     Janne Grunau <j@jannau.net>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 11:40, Eric Curtin <ecurtin@redhat.com> wrote:
>
> On Wed, 15 Feb 2023 at 11:36, Janne Grunau <j@jannau.net> wrote:
> >
> > Fixes a regression in "perf: Rewrite core context handling" for arm_pmu
> > based drivers without a filter function pointer as the Apple M1 PMU.
> > The event is ignored if filter() returns 'true' opposite to
> > filter_match(). The refactoring failed to invert the return value if
> > arm_pmu has no filter() function pointer of its own.
> >
> > Fixes: bd2756811766 ("perf: Rewrite core context handling")
> > Signed-off-by: Janne Grunau <j@jannau.net>
>
> Makes sense we return the inverse of armpmu_filter everywhere else in the code.

or we return the inverse of cpumask_test_cpu rather... copy/paste
error on my part.

>
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
>
> Is mise le meas/Regards,
>
> Eric Curtin
>
> > ---
> >  drivers/perf/arm_pmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index 9b593f985805..9cb22f36cf66 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -556,7 +556,7 @@ static bool armpmu_filter(struct pmu *pmu, int cpu)
> >         if (ret && armpmu->filter)
> >                 return armpmu->filter(pmu, cpu);
> >
> > -       return ret;
> > +       return !ret;
> >  }
> >
> >  static ssize_t cpus_show(struct device *dev,
> >
> > ---
> > base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
> > change-id: 20230215-arm_pmu_m1_regression-b6dd48d0c792
> >
> > Best regards,
> > --
> > Janne Grunau <j@jannau.net>
> >
> >

