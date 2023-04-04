Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8B6D637C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjDDNlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjDDNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:41:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F044BF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:40:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3e0965f70ecso109391cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680615640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZcpONyrq35k/KMGNdDERzaapkisIpNvWic8pI9VCIY=;
        b=M2vzh9W51JaG8iKSKF8epT+/9MuS5c0JUkok1vh6Q/vtNkZR9TSdEjK+TqBG0JRMLn
         H4+IwrSKmC2N8KHS5aZzgh5b+4MXgQfKF9Ln1stvVacxYNm+Y5v8dNhuaVeCNzuKHmV5
         rDZ4w/cLX6nGpxgmPb2ugH8fqBb+0t0ULHz5dQWIjejTeQtZ7mRnbGs38qF5gaEVnj9f
         j0/1o9Y7fQ00da59pAZwWuaUOu0g8blXl2FhUAuw80VTm2cNi8xBrLJDj0CPGNw5b+v7
         muBV1O2EBXDZY4Jd5G9y4ZJuSrQKQTSUC8TqD8Nzt+lECl4W3W1ULzmYxqP9rDt/A3iO
         m1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZcpONyrq35k/KMGNdDERzaapkisIpNvWic8pI9VCIY=;
        b=zXHBqa5ijymBoEXqYu9JjBR5R6AOwoTGXIyTtH9XefNSNyQMi+LymfJXXNZc3uRgbj
         v+qbGR/FJiHrlV4ePy3qzSfEmAmGHcDgoyLDAmsXiU+wgPCg/tSEGZxF3rGbEdq1xfTG
         Vm5HxvwirTCuoYViVDzCp+CQSof0yvLwvlHH/l7uhwAXhUjKt6ME81zrjHHtp38MFH09
         mW5MKNmZvGoroBwFa24nF7Hi/kY6S/R3M58bEszrK2d2NNfTjcvSC4XcHJjMAqqxnmSf
         2/4AEAir0vUCyZCcJq+SwkZF+bU+RvzeFlW2XQ6fDu6HoCNMh9qvw6dGSsccrSfAEQJF
         ijKQ==
X-Gm-Message-State: AAQBX9fNvrLJQHphyoYgMuCos/WWB5kx04gjF1wM0kalmAmxOnBEzzP4
        dWY2vNS8V7noBDFzUhn5BH238J81Mz9gyJBagVLQtQ==
X-Google-Smtp-Source: AKy350YAuwojFrWhhma/x+GD/OWGo8vlOCnjWZlVtwOH4/NoK6blbsC9wr688+5E4xG/a37J+g7dpI6m6JPF5D2cOZM=
X-Received: by 2002:ac8:574c:0:b0:3bf:c406:3a5f with SMTP id
 12-20020ac8574c000000b003bfc4063a5fmr247495qtx.7.1680615640024; Tue, 04 Apr
 2023 06:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230403172031.1759781-1-irogers@google.com> <ZCvT+OvZKQqsw8mh@krava>
 <ZCwabKeceQUqgtAd@kernel.org>
In-Reply-To: <ZCwabKeceQUqgtAd@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Apr 2023 06:40:26 -0700
Message-ID: <CAP-5=fX1Cuoswr3dbDjt8A39OMj=hHnz0D5imHp1p6owNuUimQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Make parser reentrant
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 5:39=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Apr 04, 2023 at 09:38:32AM +0200, Jiri Olsa escreveu:
> > On Mon, Apr 03, 2023 at 10:20:31AM -0700, Ian Rogers wrote:
> > > By default bison uses global state for compatibility with yacc. Make
> > > the parser reentrant so that it may be used in asynchronous and
> > > multithreaded situations.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> So this clashed with Namhyung's recent series, please update it using
> what is in tmp.perf-tools-next.
>
> - Arnaldo

I dealt with the merge conflict in v2 [1]. I didn't add Jiri's
acked-by just because there was a small change in
perf_pmu__format_parse.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/20230404133630.1985739-1-irogers@google.co=
m/
