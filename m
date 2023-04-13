Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66056E1168
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjDMPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDMPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:49:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680921FFE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:49:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso104745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681400966; x=1683992966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4sn6GCzgTLSVuwjc0X0HwtkDGk6cO+gZHnJUhGaRu4=;
        b=EU0pNUYyvaYH0BwlANnHHkX7/88t5UnmQ8ob2MJi7m6RdWkkrVdBLB+5ti+wosU8Hp
         64MCCS5lanIUhUFOrAZTi0HN3M0P9m9uo2Tm8tWX3i9SCC359ROmFb2iV5p5EX5XaTh/
         S+zIrKyoe+NrjLNsnTVfeAOl8LF5271z8LKbKTxX2HvY5jwiiWisWqZs4qlnMr2oNqKE
         46WfAjGGPqnB+C5QIjIQIB0EoviWnc/Sj00HoGCrCmeGTsFZ43a0ftc8SGpSV0NodMkk
         hXfwu9yNnSpEBnhT+fhru2MEf60zUQ9snaxsFzXFpzo/vwH7J3MHgtaM7eRSkzHdv9Z6
         qwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400966; x=1683992966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4sn6GCzgTLSVuwjc0X0HwtkDGk6cO+gZHnJUhGaRu4=;
        b=hTFJ6Qt5kVHdcjBRQObe9iXixXfuuxCHo8hd0Ztc3udrLcv67GjVxZbFH/29JLowx0
         +43avLoxCV0Pl/urmDvomBvquNEkh8EmYxaRHvQzs8V6/sXnOmq80Z01wZGH7jCEe7QW
         vXswBM9LcBCTmKutC++0UgH7Z6tv8KSGEW3z8HYNVGsXF6p6HNmFb87aFsSaTd6mQNM0
         +8asJ4/boWoDcjmDmlrlbXvTeAWMlDSwNhdBpLtuIVBdU3ZkbxkJ25YJTKZJtPdDeJuV
         gdTyK+aVm9svYqw8bXvm1bE4hOQqW2v8RzahyGAaBBYtSnRFeahMZ9cRV+26/Pu/6rxI
         SP0Q==
X-Gm-Message-State: AAQBX9fQAPv1ufkMDXcrisAsG0lCfgZUJYF6FkMdrXKchbQtgzgtTLmd
        V5PlHnVum9AHwL6hfovmaEgp2GLPQcwYEcx5ZvpWwg==
X-Google-Smtp-Source: AKy350avMDVRz9X07td8492agQ2aQWjRLwbxKM4KikLqgoTQEcfN+TUokW8ShUvWj/J1ak4nRePR0dTjMxqcmtegeBg=
X-Received: by 2002:a05:600c:3b28:b0:3f0:3dd2:8c24 with SMTP id
 m40-20020a05600c3b2800b003f03dd28c24mr750691wms.6.1681400965759; Thu, 13 Apr
 2023 08:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <54a21fea-64e3-de67-82ef-d61b90ffad05@web.de>
In-Reply-To: <54a21fea-64e3-de67-82ef-d61b90ffad05@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Apr 2023 08:49:14 -0700
Message-ID: <CAP-5=fW08PRXst_LdcM442ASGYs48b4B+0PnkLWCUcODB9Ju2w@mail.gmail.com>
Subject: Re: [PATCH] perf map: Delete two variable initialisations before null
 pointer checks in sort__sym_from_cmp()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 6:03=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> Date: Thu, 13 Apr 2023 14:46:39 +0200
>
> Addresses of two data structure members were determined before
> corresponding null pointer checks in the implementation of
> the function =E2=80=9Csort__sym_from_cmp=E2=80=9D.
>
> Thus avoid the risk for undefined behaviour by removing extra
> initialisations for the local variables =E2=80=9Cfrom_l=E2=80=9D and =E2=
=80=9Cfrom_r=E2=80=9D
> (also because they were already reassigned with the same value
> behind this pointer check).
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: 1b9e97a2a95e4941dcfa968c4b2e04022e9a343e ("perf tools: Fix report =
-F symbol_from for data without branch info")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/sort.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 80c9960c37e5..f2ffaf90648e 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1020,8 +1020,7 @@ static int hist_entry__dso_to_filter(struct hist_en=
try *he, int type,
>  static int64_t
>  sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
>  {
> -       struct addr_map_symbol *from_l =3D &left->branch_info->from;
> -       struct addr_map_symbol *from_r =3D &right->branch_info->from;
> +       struct addr_map_symbol *from_l, *from_r;
>
>         if (!left->branch_info || !right->branch_info)
>                 return cmp_null(left->branch_info, right->branch_info);
> --
> 2.40.0
>
