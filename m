Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDC73BC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjFWQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFWQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:08:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E38910A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:08:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4007b5bafceso236591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687536509; x=1690128509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awlw4SDBq/EVN1A7kQsXZpq8IW9b3XSNJsurYU+C4nc=;
        b=QbI99M+WQDhAtfL824R0Jx/dP1jEjMPF3m9kXs7dG2SGG2qquuyvVibkyVIPbkWgJl
         aZdcR4oz6y7c0OAL9MVkaPmWkxF+djpldr4SpqeM+Efi5Og2Dd/PFEWQiAHdH5g/DBvw
         XrASliVWeVemTFCymVXZ0P780/xSE0aoR7W1RfQYO0b12TR1OuCTe17j6ACzgwUqVdgz
         kIT7CEpmC4fh0+uAUNwxxECfqKOE5vb+mv2uzxwOnXVvbOt+Jz2OH5emF41J++gVFv0V
         u7p1AVOasy+LJBcT2w4ja/A7j5GzJ4kWx1URD+fPZ4ZD5ydJXfXawcHh+qg0dG1ahNhK
         Pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536509; x=1690128509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awlw4SDBq/EVN1A7kQsXZpq8IW9b3XSNJsurYU+C4nc=;
        b=F/Llu5vJFHr9sqBg3xUVZsW1PcqUlIoTLCkfQHe9WHrNL+HRDPs7w8smMy8rmwsrkt
         XQQFaqnU6L/5kfstgLGE1j9h6dgoLPmvK4+xnIeqKAjrLTYVBcdrZ4JkLVeBeAxmKgzu
         fjT6iz62YYEYRbfy9PkK06HQh7ZuHsWfH1orjsK29nwa5xYbMxyOePdroYDUVZKpfFSA
         gZovPkqBCePsuDNlKxC13e1pkUz+kOZEpXUXq2qwWPknPa1F+skbP3zIWKpQ/zd1ArYZ
         ixqLlCz1Mu4DaUrmttdRK0VP/qk0LYo1b24qIosT2WxRqoiwdlaxEFJhj4xxXX+YcqLG
         PXCw==
X-Gm-Message-State: AC+VfDyyHqc9iGIdzYWM1t7Z6ygeq5Y5SXTxVsHusTrqkwuKt90uJ9yA
        zuH2flo9KJ3exhrFv8fupwFxYMibTdD5wnT98QT9OQ==
X-Google-Smtp-Source: ACHHUZ7I1svGn6Um+b289e5KGZT4OaB29KSO7bke6i8ZyCWlgx+jWIie8P0N/S2FF74Lsf4bwN2Fc2+EY00oDqN3si0=
X-Received: by 2002:a05:622a:19a3:b0:3ef:343b:fe7e with SMTP id
 u35-20020a05622a19a300b003ef343bfe7emr157356qtc.2.1687536509389; Fri, 23 Jun
 2023 09:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com> <20230623151016.4193660-8-irogers@google.com>
 <ac3b4a0c-7984-8b15-a7ed-9c0428bdb027@maine.edu>
In-Reply-To: <ac3b4a0c-7984-8b15-a7ed-9c0428bdb027@maine.edu>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 09:08:17 -0700
Message-ID: <CAP-5=fXatNFoNBc8PfC6Yd1uvd6ivzyn=k9NLO+sT_QRUrr1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] perf vendor events intel: Update icelake to 1.19
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 9:04=E2=80=AFAM Vince Weaver <vincent.weaver@maine.=
edu> wrote:
>
> On Fri, 23 Jun 2023, Ian Rogers wrote:
>
> > Updates were released in:
> > https://github.com/intel/perfmon/commit/f3d841189f8964bc240c86301f4c849=
845630b5b
> > A number of events are deprecated and event descriptions updated. Adds
> > events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and DECODE.LCP.
>
> why are the events marked as deprecated rather than just being removed?

My guess would be so that people who used the deprecated event name
don't suddenly get failures. The deprecated flag means that the events
no longer show in "perf list" unless --deprecated is specified.

Thanks,
Ian

> Vince Weaver
> vincent.weaver@maine.edu
