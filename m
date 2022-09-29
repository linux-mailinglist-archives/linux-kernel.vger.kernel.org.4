Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784005EEB74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiI2CLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiI2CL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:11:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6FF105D64
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:11:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so14335wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TwooFJxjhRgJG+cOSV3PRCJCp4RIeUqc3CtUNz+Wumk=;
        b=spuLDBc8RRYI6yfGXXyY1PEyX8lSRB2teAxRuop2uJtO1oW8LBT+i/2UhFM8pOd6H2
         LIWIrsuUXHkHWavX8aY3GUFAO/CAQT5qAWQ/9yLxnTaX61qMxpkFNQu7AArCg76J09KQ
         Y1A9/Mse3fMgmWxV41i0BUbYUCLuhhWyX/1HISvZ2LQ20c0s9uix34ijzH9TG+ro6iJV
         AD2ZGZC45uJ3KCu1/PQXwNkujCwfEeq7MEFuu7Pcm17EKV6cmr5gRYP3BemR0eT6WFQ4
         SxEfpsbZgkYSrE0/ZMeazezp05fC8KPWJvKgE2sLNm2xSm2Ljm0eg4Kr8OQG/AkiCdiX
         2Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TwooFJxjhRgJG+cOSV3PRCJCp4RIeUqc3CtUNz+Wumk=;
        b=wOZ0Imy7RtuFOG+KQUBzT0S0KMRUSd7DhzuY9jGxnfGB6oMMhFn4j5uNqziIedGfDp
         vmHAPiOgwEeY60l+G7MZEizvDVysEX24csgl/VWiUM9EBMiJQ3HEzD6Zqd/Pug63CFTk
         ru5GqvfV/aQ6lVVSjoexmsL5fhjOwUlPbfaUdFsgrXVL534wqaCzR/df1YRpr5sFbqxQ
         ce5EIuRV1jY8gb5U3jfJ1O2+oF9Pm2idxcblwB/KJRWLgDkVHATmu6A7uSjCklXi2pXF
         thp7eGcivb4VDp7UsXNZVOYWoVqYKJFcb8cfN8Assebtohf2MegBWJD+zPd7obOmlDWq
         x9Kg==
X-Gm-Message-State: ACrzQf3ORnFvl6oV7V/SxGVJdcBk3RVMwb6vrmlinSSyvbaoyxX5xOtC
        DGVYysgtY1zVnFC8Zp388DZnRGlM52a9I7z+IhOv7g==
X-Google-Smtp-Source: AMsMyM5USHjqcex3UgGFABXMyH/XTRe2NtqMCvmsWB/a7GJGkUUxhuIUhfMj0gFiEEGEgcZVSwmhXa7flf9f0GYpsX0=
X-Received: by 2002:a05:600c:4e94:b0:3b4:b416:46c3 with SMTP id
 f20-20020a05600c4e9400b003b4b41646c3mr527727wmq.149.1664417487060; Wed, 28
 Sep 2022 19:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220927051513.3768717-1-zhengjun.xing@linux.intel.com> <YzRaAxFrg56uph+W@kernel.org>
In-Reply-To: <YzRaAxFrg56uph+W@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 19:11:15 -0700
Message-ID: <CAP-5=fVgsMzx6F=rgy9kyfWS=Gj3hvtLTJmTzf6+O954x4oY_g@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case 87 ("perf record tests") for
 hybrid systems
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Wed, Sep 28, 2022 at 7:28 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 27, 2022 at 01:15:13PM +0800, zhengjun.xing@linux.intel.com escreveu:
> > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> >
> > The test case 87 ("perf record tests") failed on hybrid systems,the event
> > "cpu/br_inst_retired.near_call/p" is only for non-hybrid system. Correct
> > the test event to support both non-hybrid and hybrid systems.
> >
> > Before:
> >  # ./perf test 87
> >  87: perf record tests                                   : FAILED!
> >
> > After:
> >  # ./perf test 87
> >  87: perf record tests                                   : Ok
>
> Looks sane, applied.
>
> Ian, consider providing your Acked-by,
>
> - Arnaldo

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> > Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index 00c7285ce1ac..301f95427159 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -61,7 +61,7 @@ test_register_capture() {
> >      echo "Register capture test [Skipped missing registers]"
> >      return
> >    fi
> > -  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
> > +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> >      -c 1000 --per-thread true 2> /dev/null \
> >      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> >      | egrep -q "DI:"
> > --
> > 2.25.1
>
> --
>
> - Arnaldo
