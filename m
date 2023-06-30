Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4329C7441C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjF3SFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjF3SFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:05:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6335AB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:05:19 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40345bf4875so34531cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688148318; x=1690740318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ4gsD4rdwDr1A7gGhTaZLJd5JcR8+ufDcHkEAaH+aI=;
        b=vrcDAgj6sRGcvIlvprCMA7feEwtCyao6hA5NDXyisD1BqXXzouKok5V7REUCAOFJQ3
         zylC8OdZ+i6LfWwa1RxUkTT0L+Xd4R5znxstA5gDq0af3FYCZHQpgGfo2HJbFIcRMLrM
         XA/MJLWU3cl0bvwJraoLOccS6UmqznYKQH32p+WwWGLWhOchI9R6cDRv/PlfcB/cZbZW
         cfsPZGa5PgUsXPVQMDrz8UTrVmT5qwzlbhuX8W7aUgh4oxpuzOAO+4Yea4a8DCUeI5aY
         OVvJS7KBVrM7xBlkP9YSHY8VDCpZr3RjNhryXWqEA8GwslPLfY7j8RON2Qkyn8gJs/zX
         Cf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688148318; x=1690740318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ4gsD4rdwDr1A7gGhTaZLJd5JcR8+ufDcHkEAaH+aI=;
        b=cguPTFjH2ZQyvJ/NKTAon9xy4YCQDc2rGGfNovFBnc/WnBJAyn8Pr7khjT30Nit1jg
         qJayfz+wcxe5MbigORlJ+u4bzD31vdwpSRvgKU0k6u0u49UQFf2D4zpi2YBh7Ma6pHX7
         GJEMngINcAqdoAYPA1pg6Da+HcxqJtmWYt7KSOVSZXfxXhiXwl5LExBjVPztEVZsFaP/
         nZAy/eMlXMzrWfExOje7H6ZrFX9bun0H5jAs0U9IJW5Wh2hd0VUgKqEkStWAdcSoCHJX
         WA4sD8Sr40hbwwvWaZI3OzRAdyhQg+qLBBpasMcMTg5R82uTD+LfQ4WmzymLP1E6xczc
         4DGw==
X-Gm-Message-State: ABy/qLbIsJ2bi3LktBJUyIliARR2z9B/+tadv/6llQZdwx9rNyGNp4u4
        bfGqTBEZrRrkrsBlTahMZTNG2xYvdYjDqQVxBj6ZuA==
X-Google-Smtp-Source: APBJJlFBVz1kI+p5pJzmHdNMLO9ZN9vVI/wrZ03xA0F44tFU7ilVI9KouRjr3eyIVvMMvg7cuPExG7fJ2bUHGksBdQo=
X-Received: by 2002:ac8:580c:0:b0:3f4:f841:df89 with SMTP id
 g12-20020ac8580c000000b003f4f841df89mr988qtg.1.1688148318671; Fri, 30 Jun
 2023 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230627181030.95608-14-irogers@google.com> <ea39aaf0-0314-1780-c1cd-7c3661fa3e7c@web.de>
 <CAP-5=fX+kdRujgNAq8SVkkNwgnB383r38+AEmvon1k01R4X=kg@mail.gmail.com> <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
In-Reply-To: <a3517306-7804-f5cf-6182-ef63b6054647@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 11:05:07 -0700
Message-ID: <CAP-5=fUEa150DYWte2u6M8sejxXXqec_L8GEhVbppJHHq8N5PA@mail.gmail.com>
Subject: Re: [v2 13/13] perf parse-events: Remove ABORT_ON
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Jun 30, 2023 at 10:40=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >>> Prefer informative messages rather than none with ABORT_ON. Document
> >>> one failure mode and add an error message for another.
> >>
> >> Does such a wording really fit to the known requirement =E2=80=9CSolve=
 only one problem per patch.=E2=80=9D?
> >>
> >> See also:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.4#n81
> >
> > Sorry your explanation isn't clear.
>
> Do you really find the application of the linked development documentatio=
n unclear
> in this case?
>
>
> > Sorry your explanation isn't clear. Please can you elaborate.
>
> Will it become helpful to split the proposed patch into smaller update st=
eps?

This is kind of why the series is 13 patches long, I'm not seeing why
you think the following stats qualify as "long":
14 insertions(+), 8 deletions(-)

Thanks,
Ian

> Regards,
> Markus
