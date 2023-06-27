Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DBC7401CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjF0Q6K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjF0Q6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:58:07 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5D171A;
        Tue, 27 Jun 2023 09:58:01 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-57023c9be80so48222027b3.3;
        Tue, 27 Jun 2023 09:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885080; x=1690477080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6c/E6AXYzbisGWFmvmo6pUwZPWyqFohyT+yy2+nmio=;
        b=GkQZgEpZRcV93bTL8u8jjRrkbWUAOjbdW0uYb7vvEcA0RV9X42sDgtT4qo1zmJBVNo
         y5kMTtV4FBm+GrpOvR0JiPPyXlX2FPOQuVBMXaPJLnOcbyiogVvTGpaT999Vt994E4iQ
         BcKC8WrY9or+vKCe0QKKnBg4p/SR0ZgqruFKYGuxsgqB9XgKMEdzzaTv56Qj9UW2yleq
         Qns7fpWneCVGXH8K6CEF8GDBnsnkON7hzADrX2FjFCRKXjaD/ie1lSGFUeMXLKNQtoRZ
         U5txGKmhpz/4L1uRVCVigzpsCCUawyHCl/jJYzPLb/JCv+3eteHMLmKNmcOoTCbfwLU4
         NgIw==
X-Gm-Message-State: AC+VfDy0ksUY4NkqH/8QwChMNzyiYq/MCGfYbY+oxYiTkmLd84BWghQq
        jhVJUc6C0W59k80ewjZk2V7eMsbZBTo1shhDGxk=
X-Google-Smtp-Source: ACHHUZ5za4SKXgCUycxICS4iLcZ0E0uXMbtX5kX1cppuI2T83ewm6+E4jBEdXR26Hqgi9kkyvRq2HjMdVCQm+QGqejs=
X-Received: by 2002:a25:8407:0:b0:c19:9ca6:d18 with SMTP id
 u7-20020a258407000000b00c199ca60d18mr7689380ybk.38.1687885080211; Tue, 27 Jun
 2023 09:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230626161059.324046-1-james.clark@arm.com> <20230626161059.324046-3-james.clark@arm.com>
 <ZJonE3ZZ2cBUq0U8@google.com> <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
In-Reply-To: <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Jun 2023 09:57:48 -0700
Message-ID: <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
To:     Ian Rogers <irogers@google.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 9:43 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jun 26, 2023 at 5:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> > > thread__find_map() chooses to exit without assigning a thread to the
> > > addr_location in some scenarios, for example when there are samples from
> > > a guest and perf_guest == false. This results in a segfault when adding
> > > to the histogram because it uses unguarded accesses to the thread member
> > > of the addr_location.
> >
> > Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
> > init/exit/copy functions") that introduced the change, I'm not sure if
> > it's the intend behavior.
> >
> > It might change maps and map, but not thread.  Then I think no reason
> > to not set the al->thread at the beginning.
> >
> > How about this?  Ian?
> > (I guess we can get rid of the duplicate 'al->map = NULL' part)
>
> It seemed strange that we were failing to find a map (the function's
> purpose) but then populating the address_location. The change below
> brings back that somewhat odd behavior. I'm okay with reverting to the
> old behavior, clearly there were users relying on it. We should
> probably also copy maps and not just thread, as that was the previous
> behavior.

Probably.  But it used to support samples without maps and I think
that's why it ignores the return value of thread__find_map().  So
we can expect al.map is NULL and maybe fine to leave it for now.

As machine__resolve() returns -1 if it gets no thread, we should set
al.thread when it returns 0.

Can I get your Acked-by?

Thanks,
Namhyung
