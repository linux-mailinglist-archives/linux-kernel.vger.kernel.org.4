Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35B7401FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjF0RTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjF0RTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:19:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3151FE4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:19:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso17641cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687886370; x=1690478370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBjJTKwL7vgV3jsH8nCrQ0roxswa1psP2GFa+i0N8HY=;
        b=Rp0Kw1Qs355H8V84pEHlLy/4KG6qgT0o3WdQQKlac1LOxRtZMPi27kXfeSBsqegbh8
         +x1Dij5wvH8fwI+fu2F/ODa1yv82sxCydGklIb0PIU5Xc/Qff52stuvVBJU8Ye5N9YJG
         iTiJ2l8EA/odAs2OSbbbC3WPbuS9m+5YHzE56SM/aWstBhdWMkGgJ1tcWfljc314BNFP
         UFUN9yrCUa6pXS06pw6svv4SEKqqeCXkeKOiVrWuXRDAcLNlIS2ZMi01ClkqJmZx261w
         Wq5T/W2fuLq0AfOu0wr1/Z0JDdbVPwJqeJK10HrNa281IEOlje4PONG26Kn1BEkz39Lp
         /zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886370; x=1690478370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBjJTKwL7vgV3jsH8nCrQ0roxswa1psP2GFa+i0N8HY=;
        b=Y3nvTdALA/1hhpJsQXIy82qO5KeeMTGhEPCTNEO15u6PJWpgUJUug8uAOyl5ExZjo0
         bqhbAlGvRk/DrD/NkvMAQc7J34FOkFyKZvdys07MGSY3sQGo6HmYaDVElsqrcgg136Pu
         xRnItl4Ih1OYKo4cN1fwn9lN8uPT8eiV5e4+qVKLwqYmSrRSLgpTcCmo2FAjtC3GnXQI
         Rnj9A61gY3Ysq5XhNKZBLnilSUO/Ud9I6+pEb+C3ylm9S1qGt0VF3WyMqsyrTk1bu65G
         R/ZFAEHvfGq0P5pZTaMQIfkQniWUaDFgoNe4zTeh9Zy1Timk467Bi8LEhA4jBDXHwm7t
         0sHA==
X-Gm-Message-State: AC+VfDwSnKB41Hy/UiszjHJFAOWVN2WedIDE+/U8ejw+sFxEJD7oEwso
        lHHT5M+t3c1ETCvFIra7VliVh0V6m5Skqv+LCUxNrg==
X-Google-Smtp-Source: ACHHUZ4jwWSCrq7FmwwM8vfo7rB80rBGxbKjbEqwSR7EzE02DXl4ESDvoaoT0aF3jdU7Zy9PoXq5qJ/C9ohuDqc+z58=
X-Received: by 2002:ac8:5710:0:b0:3ef:343b:fe7e with SMTP id
 16-20020ac85710000000b003ef343bfe7emr2710qtw.2.1687886369968; Tue, 27 Jun
 2023 10:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230626161059.324046-1-james.clark@arm.com> <20230626161059.324046-3-james.clark@arm.com>
 <ZJonE3ZZ2cBUq0U8@google.com> <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
 <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
In-Reply-To: <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 27 Jun 2023 10:19:18 -0700
Message-ID: <CAP-5=fUTzn06DM7o-1qBx7Tauo2Q2ACHmYcvwTmrTOJpzS2=oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 9:58=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jun 27, 2023 at 9:43=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Jun 26, 2023 at 5:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> > > > thread__find_map() chooses to exit without assigning a thread to th=
e
> > > > addr_location in some scenarios, for example when there are samples=
 from
> > > > a guest and perf_guest =3D=3D false. This results in a segfault whe=
n adding
> > > > to the histogram because it uses unguarded accesses to the thread m=
ember
> > > > of the addr_location.
> > >
> > > Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
> > > init/exit/copy functions") that introduced the change, I'm not sure i=
f
> > > it's the intend behavior.
> > >
> > > It might change maps and map, but not thread.  Then I think no reason
> > > to not set the al->thread at the beginning.
> > >
> > > How about this?  Ian?
> > > (I guess we can get rid of the duplicate 'al->map =3D NULL' part)
> >
> > It seemed strange that we were failing to find a map (the function's
> > purpose) but then populating the address_location. The change below
> > brings back that somewhat odd behavior. I'm okay with reverting to the
> > old behavior, clearly there were users relying on it. We should
> > probably also copy maps and not just thread, as that was the previous
> > behavior.
>
> Probably.  But it used to support samples without maps and I think
> that's why it ignores the return value of thread__find_map().  So
> we can expect al.map is NULL and maybe fine to leave it for now.
>
> As machine__resolve() returns -1 if it gets no thread, we should set
> al.thread when it returns 0.
>
> Can I get your Acked-by?

Yep:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
