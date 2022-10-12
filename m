Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94E85FC92F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJLQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJLQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:25:27 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA3B03EA;
        Wed, 12 Oct 2022 09:25:26 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1322d768ba7so20030914fac.5;
        Wed, 12 Oct 2022 09:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBMigr3FS6M7Tme4HNYJL0mrMQ1H4UvqlHB2i2CRcmk=;
        b=z45oWLWhA9B47uJULnBDigCcU59O3qf5X64ZkDlFHlL54b786e/esLNtWX8rnGCra6
         dP/bTfhDhQYfnKb/LjPWRZ0QJ4ndG3pzUuX+9zUFldnmh+0tFu/Vl6orB0Ce9Prh2cez
         pcpTbDFzoxHiUROoPMULOi/3HuCNsKlFdRxgrYILI5NagavMx/oUMwG0pTsKNO2hN0SI
         +1rgiCkCCOrIHv7TJtTUg9Nymps+7XECzSBUA53s+WwPYtfK6ZtgBx00k3/Eua2Ll4B1
         MEzCHBIc3/H+Orcw4mVwzjbs+hzNjknK/Leds6t2G6/oCuGWMqY+rp+48++BYFTaIFin
         uY4w==
X-Gm-Message-State: ACrzQf2KLS+L9B4/FC95atN2k25puo2+itCH3efnEzL3lWb1dlcFA2rr
        M8aW5Gva1MeFXnO40FTrrmjuvV1Rz5qKAR7alj92fHQH
X-Google-Smtp-Source: AMsMyM49Pk81tm16EjpfYhNOdd8zt9Qbo+S52VtLhkzMhG1o9eq36gFeYbByUD2HSK5GibVBzv3FwYyqz5jw3HcvLkU=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr2991744oae.218.1665591925447; Wed, 12
 Oct 2022 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221012082259.22394-1-adrian.hunter@intel.com> <20221012082259.22394-3-adrian.hunter@intel.com>
In-Reply-To: <20221012082259.22394-3-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:25:14 -0700
Message-ID: <CAM9d7chCGw-iXUiD+Bj3azTdVdYz21KtBOhR5ZbLoVuFXE6nbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf intel-pt: Fix system_wide dummy event for hybrid
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 1:23 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> User space tasks can migrate between CPUs, so when tracing selected CPUs,
> system-wide sideband is still needed, however evlist->core.has_user_cpus
> is not set in the hybrid case, so check the target cpu_list instead.
>
> Fixes: 7d189cadbeeb ("perf intel-pt: Track sideband system-wide when needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/arch/x86/util/intel-pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 793b35f2221a..af102f471e9f 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -866,7 +866,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>                  * User space tasks can migrate between CPUs, so when tracing
>                  * selected CPUs, sideband for all CPUs is still needed.
>                  */
> -               need_system_wide_tracking = evlist->core.has_user_cpus &&
> +               need_system_wide_tracking = opts->target.cpu_list &&
>                                             !intel_pt_evsel->core.attr.exclude_user;
>
>                 tracking_evsel = evlist__add_aux_dummy(evlist, need_system_wide_tracking);
> --
> 2.25.1
>
