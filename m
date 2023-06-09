Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB308728F07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFIEk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIEkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:40:55 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D430E7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:40:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so188345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285654; x=1688877654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WctVijjK+PCqOwFmysl43LsrrAqXcmJG+wVLVPPGK9g=;
        b=LI82naPsaC/+dYDlxTaENt7V74zG+hG+8etdK/sKAQ0PSFINCTxC+FXyyMIzTt/K7M
         L+V2ijDwHzY/VcIOVAfaVwu1edhDmeRGimjWYbI2AuBLtdZWYQmewNknc4EdmeHa1e7m
         TxTfTSeXeXlqAB3X7YMI648BpWd7k/IjSZU8kIbZ0KSZKqGkcihsTLrgxa0yKQlKVEdC
         xB02NgxMEs/D9MAWd8bj7ggVN3PBrmwIaD5D8nb91VXBUlz5v6RSe+3uEpqcT/0BeUU+
         8I0L7ue01xc19O701ZjD0XWel5DLbjlnA/9OBVBBY7ZZk/t+x+T1tsL8QBfCxyK6I0VO
         c0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285654; x=1688877654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WctVijjK+PCqOwFmysl43LsrrAqXcmJG+wVLVPPGK9g=;
        b=ioBUry90SswmRv4bv0qn5vt2eTN6PRVt5yc50+ITz4F50x+dczkMFpUGJ6VWDe3fXA
         mJMLZeDaTO6b8bZN3eTXF4x+CPtJ0LG8nfSGY9alkhAUweUcOv3JZZSWLPqi/73yNLK0
         Qrz+pKpzfCYBD35a32Ojr9tq9EXDBXdvpvFO/h2ElMyOtB4nCg7gsKpZRo5I7HLEJk7M
         ih8CFTmi9rZpnJ4osKBHDNc84/1HhoMJ2ExI3pK8ELD3MyipTSyCoMUUc1R37ZikPAt9
         R09OyekP+YVgHwce+pFh/M8eHUgtlNymv0lbC6HdhXu3PPKoaExdjEzGpewQ5s6X1gUi
         IwDg==
X-Gm-Message-State: AC+VfDyyWnZKUIkhzxQdxhmFmjlCL199VcMNblD+eRrw+g55Cel3b9xv
        S0EmhA80l911apH+Iw5briodP7v86LC7HMZbuP3Tyw==
X-Google-Smtp-Source: ACHHUZ6g3S3eCkQr0Cq1l0j9GFF36Yvjnpmx6WE+39uupEOPHAtfRnGT74BrmWjAzChFIiEr4jsHV+MqZAk6GvRUcow=
X-Received: by 2002:a92:c244:0:b0:33a:e716:a76e with SMTP id
 k4-20020a92c244000000b0033ae716a76emr291878ilo.28.1686285653709; Thu, 08 Jun
 2023 21:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com> <20230527072210.2900565-29-irogers@google.com>
 <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com>
In-Reply-To: <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Jun 2023 21:40:42 -0700
Message-ID: <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

On Thu, Jun 8, 2023 at 9:01=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> Hi Ian,

Hi Ravi,

> On 27-May-23 12:52 PM, Ian Rogers wrote:
> > Split the pmus list into core and other. This will later allow for
> > the core and other pmus to be populated separately.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 38 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 58ff7937e9b7..4ef4fecd335f 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -12,13 +12,19 @@
> >  #include "pmu.h"
> >  #include "print-events.h"
> >
> > -static LIST_HEAD(pmus);
> > +static LIST_HEAD(core_pmus);
> > +static LIST_HEAD(other_pmus);
>
> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independent =
of
> core hw pmu. I wonder where does IBS fit. Currently it's part of other_pm=
us.
> So, is it safe to assume that other_pmus are not just uncore pmus? In tha=
t
> case shall we add a comment here?

I'm a fan of comments. The code has landed in perf-tools-next:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/pmus.c?h=3Dperf-tools-next
Do you have any suggestions on wording? I've had limited success
adding glossary terms, for example, offcore vs uncore:
https://perf.wiki.kernel.org/index.php/Glossary#Offcore
I think offcore is a more interconnect related term, but I'd prefer
not to be inventing the definitions. I'd like it if we could be less
ambiguous in the code and provide useful information on the wiki, so
help appreciated :-)

Thanks,
Ian

> Thanks,
> Ravi
