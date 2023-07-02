Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48F744BF3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 03:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGBBDp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 21:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBBDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:03:43 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED64172B;
        Sat,  1 Jul 2023 18:03:42 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bd6446528dcso3458682276.2;
        Sat, 01 Jul 2023 18:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688259822; x=1690851822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eH/EyizLb9FjbDE2YkuFGN61mm1+iiCI7p0+/Tx7qko=;
        b=eTkDHVEHnqb1cFndxc83Izo7UTblTdrMziB0sCIaRfNNp0m6sidfrCQL2TSua9Z5Kh
         7iI715oaYE+8AIdKNgBP2euBpJLksxIJUjEF+hLftHoKENBQt8N0y02O+2W/pAGw8a6F
         A/qCmiIzBPfgo56PCZ0UH6OgX0093rS0HJYTRnbzX9Ady6gS+yC2ytJWpMH/8Tng/3Lf
         X1zR99N5K2eCPw8ilBGrIYM681hIG1Ecq7cRfVB6fIQzeNiGs0cyG1i7IX6PoXR6BYHd
         yYJOFQ6KOMWsoSSOZCMjVqpBmKBlj9or6x2UFUiK/TDKALLpk0ZImQabRrcJh/wgpXmS
         Mo+A==
X-Gm-Message-State: ABy/qLZmsn4ffIc1yFi5nN22uH+3H7LzfaE5ca/06cDOeJk/o/QXcsKO
        WRQFLjiXd80BzzZohByopOyNGa/qDDuHP+DHV2Y=
X-Google-Smtp-Source: APBJJlHHOWkKr0/zYtKwSsGlZrlHf2gh3VIuCvw6n4ajuNSjpGTn7JNs3X/0SJDBYrayzKCUV9OilaY/HevRe3yRQi4=
X-Received: by 2002:a25:ae84:0:b0:bb1:6e29:a84d with SMTP id
 b4-20020a25ae84000000b00bb16e29a84dmr6865225ybj.53.1688259821849; Sat, 01 Jul
 2023 18:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230630085230.437-1-ravi.bangoria@amd.com> <CAM9d7chYnT2s1V1juP+EyewJfRD+2qHGs2pwghh=k3kFf1P9BA@mail.gmail.com>
In-Reply-To: <CAM9d7chYnT2s1V1juP+EyewJfRD+2qHGs2pwghh=k3kFf1P9BA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 18:03:30 -0700
Message-ID: <CAM9d7ciV--mPi_MFQdsa8eoGp82NB0B5BmVccP_kMB65wGJafg@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel amd: Fix IBS error message
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, irogers@google.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 11:17 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ravi,
>
> On Fri, Jun 30, 2023 at 1:53 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >
> > AMD IBS can do per-process profiling[1] and is no longer restricted to
> > per-cpu or systemwide only. Remove stale error message. Also, checking
> > just exclude_kernel is not sufficient since IBS does not support any
> > privilege filters. So include all exclude_* checks. And finally, move
> > these checks under tools/perf/arch/x86/ from generic code.
> >
> > Before:
> >   $ sudo ./perf record -e ibs_op//k -C 0
> >   Error:
> >   AMD IBS may only be available in system-wide/per-cpu mode.  Try
> >   using -a, or -C and workload affinity
> >
> > After:
> >   $ sudo ./perf record -e ibs_op//k -C 0
> >   Error:
> >   AMD IBS doesn't support privilege filtering. Try again without
> >   the privilege modifiers (like 'k') at the end.
> >
> > [1] https://git.kernel.org/torvalds/c/30093056f7b2
> >
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
