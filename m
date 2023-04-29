Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641C6F2697
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjD2Va7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjD2Va5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:30:57 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFD3E60
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:30:56 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-329577952c5so755475ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682803856; x=1685395856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzdpTpVqVAbcBmm57skQ5w54yJzO0yjUjXTiorZSwZU=;
        b=qGHa5T1rAGzVj/YuUB9S4wn/CfiB+WAlGRiaE1+2b2REq3qzpun+H/3Mmx4ymsqOf0
         9y0MKDosArJLELDw0W/vyr5Ij1Za1BbV3xrg//xa/1sHVc8G56WK3tkeFSGzuxO2Md1H
         DsCfeQmhLx5HrACcioHu/1+pVOhFDLmaVpX/0AxEZbxIFXXu0agg+xARXYsc0y/EYiOV
         T+sNeopW+tkBzbypXiuQB1OqaWH+WuSrPKySjuUE9gw58tYFb5zi+6DfNfVMJR08xrUg
         ic7IktmxfwesjVHGaFzcCvVeWRbB607GY52EqwJBhSXjwivH539DJBe2L1/5vRJ0GwyQ
         abBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682803856; x=1685395856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzdpTpVqVAbcBmm57skQ5w54yJzO0yjUjXTiorZSwZU=;
        b=WtohO1yRFAqjlktaNzYliMD2qNeD5Bo1TQDg2NzrRAx1L9OL7cdULcZDXt6N3gyudD
         uEpNFHSc1BLsoYtS+4P70snxY5Gx1+CVLsdCiCrlWDzpagN5XpXE6Jkmnp/rN0cH5KcO
         Tvyaf5Yu2Qsns1sp5qWJFtctWS5AyUR6HzxI1P7f8ES9e0ZmO2MGeTP+1sNjuL3dSX7I
         XzXcKb0qkY9PSoQuMc2dL5ZSAAx22zNaUHxG8MvDJmzje9v9nC+jGnR/eESsaFTuuoY7
         4YbQWRGRffNdhaC33tI0o8pt7S9o0th0qe7LuJ0v5GyR+w9E06mQ1xeLLNEh0z8LIMF7
         klOA==
X-Gm-Message-State: AC+VfDy0b/J9oS/KAruVoerQTsqFycCLIhgund2MrLQAPdLz04xqK+WX
        Brlg9Ve39tUf/VUMokclssoX+SKJ+Di3m0PKwfhKPw==
X-Google-Smtp-Source: ACHHUZ4Aiq0TvEoJUc7kDutZjKkhhjfLXc4HK8Wz3M32TsGV+A57Cht7IvWeDX4jqvkwxTGzhyET1vhqhXx7funo4VI=
X-Received: by 2002:a05:6e02:1c25:b0:31f:ba43:2ed5 with SMTP id
 m5-20020a056e021c2500b0031fba432ed5mr169139ilh.11.1682803855773; Sat, 29 Apr
 2023 14:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230428125345.8924-1-adrian.hunter@intel.com>
In-Reply-To: <20230428125345.8924-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 29 Apr 2023 14:30:44 -0700
Message-ID: <CAP-5=fUGJBntxprz6NQO84TivQBG4Pjd6Tw95RyE0Zp--+Nm3w@mail.gmail.com>
Subject: Re: [PATCH V2 0/1] perf tools: Allow config terms with breakpoints
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 5:54=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Hi
>
> Here is a patch (V2) to the event parser for breakpoint events.
> I am not that familiar with flex / bison, but it seemed to
> need trailing context to stop the mem event colon and slash
> delimiters from getting mixed up with delimiters for config
> terms or event modifiers.  Please look closely at that.
>
>
> Change in V2:
>
>       Add comments to tools/perf/util/parse-events.l
>       Add a test for 2 mem events back to back with config terms

Thanks for the tests/comments!
Reviewed-by: Ian Rogers <irogers@google.com>

Ian

>
> Adrian Hunter (1):
>       perf tools: Allow config terms with breakpoints
>
>  tools/perf/tests/parse-events.c | 157 ++++++++++++++++++++++++++++++++++=
++++++
>  tools/perf/util/parse-events.c  |  23 +++++-
>  tools/perf/util/parse-events.h  |   6 +-
>  tools/perf/util/parse-events.l  |  23 +++++-
>  tools/perf/util/parse-events.y  |  42 ++++++-----
>  5 files changed, 224 insertions(+), 27 deletions(-)
>
>
> Regards
> Adrian
