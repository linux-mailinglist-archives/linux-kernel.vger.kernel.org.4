Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C773ABAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFVVfz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFVVfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:35:54 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA31BFA;
        Thu, 22 Jun 2023 14:35:53 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so6131154276.3;
        Thu, 22 Jun 2023 14:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687469753; x=1690061753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly5bOU0Q1ozj3v75g6rZQFU8W9SZnQQ902G0DTBvlTE=;
        b=cVGxt3CK4KSWt3jPjNPmtnf/h2hDs54PCU1u4oAdXWIZl2eOrbSGSHmbll0K5OY73U
         Nzu+GjNvSSXMNyBAO0iexCgQNcsNX9e2qGpiikY9ULtY3pWMH1rHLepToY2M9FncmSl9
         2WcGJZrYoJC2n5kxq9IKqUU372ynDNknEpf7HKZKNeJ/aKrSpvg+8jV+JKTE29PoWEHL
         aPA9gsxw0vNER1TAYhtRJGEJDaxxW1JdYJDlH4sxwLQ9PERiCs9pw1tTQL94sb+3uhMh
         +2EjP5TQT0GHlEg7yQlhPeRVndLiGbksgemjGSvmJNyP0vZ+dDxDcnnzdQ+B1FKft5EW
         BI+A==
X-Gm-Message-State: AC+VfDzJVdSNcitiLV6063McQRF625oxJdGbSXZ28qF5XZGR2cz3be9I
        aiJ5SY6c+9dnDnryQgoFsCcjo0d/hBmw/cZ6yFycyOoN
X-Google-Smtp-Source: ACHHUZ66wrVnAFkgxodls7dYze0SB9vVxDK8/wLAIHDdhuiyC7mq7XMxV5nA4fjFVlfYa2TDl7W7dUgF1wEGHxre4Lw=
X-Received: by 2002:a25:748b:0:b0:bce:782:d617 with SMTP id
 p133-20020a25748b000000b00bce0782d617mr11964929ybc.56.1687469752765; Thu, 22
 Jun 2023 14:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230620170027.1861012-1-weilin.wang@intel.com> <CAM9d7cichi8QpVFjCDUf8e5aJEuZg1JPHtMBEs_FSNtsm8VoeA@mail.gmail.com>
In-Reply-To: <CAM9d7cichi8QpVFjCDUf8e5aJEuZg1JPHtMBEs_FSNtsm8VoeA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 14:35:41 -0700
Message-ID: <CAM9d7chBM_z=vNKsLFTLVevXgd8=ZfS_XSX=999+jitrTJodTA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add metric value validation test
To:     Weilin Wang <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>, ravi.bangoria@amd.com
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

On Wed, Jun 21, 2023 at 5:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jun 20, 2023 at 10:00 AM Weilin Wang <weilin.wang@intel.com> wrote:
> >
> > This is the fifth version of metric value validation tests.
> >
> > We made the following changes from v4 to v5:
> >  - Update "()" to "{}" to avoid creating sub shell and successfully skip test on non-Intel
> >  platform. [Ravi]
> >
> > v4: https://lore.kernel.org/lkml/20230618172820.751560-1-weilin.wang@intel.com/
> >
> > Weilin Wang (3):
> >   perf test: Add metric value validation test
> >   perf test: Add skip list for metrics known would fail
> >   perf test: Rerun failed metrics with longer workload
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
