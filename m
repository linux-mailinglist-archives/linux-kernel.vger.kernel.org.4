Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C674193F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjF1UGt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jun 2023 16:06:49 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:42493 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjF1UGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:06:47 -0400
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so467378276.1;
        Wed, 28 Jun 2023 13:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982806; x=1690574806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cyNi1a1Nb17nGMmnPDS7fjF0SkMOGKhIkklLddywOk=;
        b=X1x3rNuF6XKQM6/TLqTi3ipiO1ZLqjPjNRj2C8BwtBQ9XNJmI22JIqN+1Wh3h6zUGO
         5uje30xDoxF6H1SPjJFM6KNfzUi500bXZ/WRGCxNetICCr4MZgZiLeooIcvROorTuaNU
         o4uD5qsT+G2RLeOKLJIl1SfqFb7QRLY2xHMUkJo09d8ibgHc+hRu1Uc8lk4AHVcZXZJz
         N7yT/JfveCUBvfqkc7Vs8H+gijmD4mMeFi6iSF2e3igJGZdKgeKh0IkGMIb608bsIAkt
         2DvM09yxN9h60srKylUXxPjASeE6JjDj02yts5xGZWK3GJpVIoE/UusMWXmspa2JmGxL
         xweA==
X-Gm-Message-State: ABy/qLYUipwWaIQOpzorcv4/nzVOqpICmA4JvLewwSNCrdpYSDsGFuRY
        KK397THGK79NpO7s+FCxtKRywJP1dhj80sdkjps=
X-Google-Smtp-Source: APBJJlEeEcKbHmvEmttD34oTcc1DwYznh2OGqFMOOY0qFSeTJuJrhlHQEu0Sh2t/6j/N0RHsNJK0LpUaU98M0WxMYps=
X-Received: by 2002:a25:553:0:b0:bc8:42db:2c07 with SMTP id
 80-20020a250553000000b00bc842db2c07mr2388631ybf.25.1687982806236; Wed, 28 Jun
 2023 13:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230626161059.324046-1-james.clark@arm.com> <20230626161059.324046-3-james.clark@arm.com>
 <ZJonE3ZZ2cBUq0U8@google.com> <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
 <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
 <CAP-5=fUTzn06DM7o-1qBx7Tauo2Q2ACHmYcvwTmrTOJpzS2=oQ@mail.gmail.com> <d5618d0b-1441-0c04-4b09-768bfe7b7ee7@arm.com>
In-Reply-To: <d5618d0b-1441-0c04-4b09-768bfe7b7ee7@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Jun 2023 13:06:35 -0700
Message-ID: <CAM9d7cjx2zinztBYiYaU6iqKzuV3vcJA6wtY71aicFbr5sy9zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:34 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 27/06/2023 18:19, Ian Rogers wrote:
> > On Tue, Jun 27, 2023 at 9:58 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> On Tue, Jun 27, 2023 at 9:43 AM Ian Rogers <irogers@google.com> wrote:
> >>>
> >>> On Mon, Jun 26, 2023 at 5:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>>>
> >>>> On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> >>>>> thread__find_map() chooses to exit without assigning a thread to the
> >>>>> addr_location in some scenarios, for example when there are samples from
> >>>>> a guest and perf_guest == false. This results in a segfault when adding
> >>>>> to the histogram because it uses unguarded accesses to the thread member
> >>>>> of the addr_location.
> >>>>
> >>>> Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
> >>>> init/exit/copy functions") that introduced the change, I'm not sure if
> >>>> it's the intend behavior.
> >>>>
> >>>> It might change maps and map, but not thread.  Then I think no reason
> >>>> to not set the al->thread at the beginning.
> >>>>
> >>>> How about this?  Ian?
> >>>> (I guess we can get rid of the duplicate 'al->map = NULL' part)
> >>>
> >>> It seemed strange that we were failing to find a map (the function's
> >>> purpose) but then populating the address_location. The change below
> >>> brings back that somewhat odd behavior. I'm okay with reverting to the
> >>> old behavior, clearly there were users relying on it. We should
> >>> probably also copy maps and not just thread, as that was the previous
> >>> behavior.
> >>
> >> Probably.  But it used to support samples without maps and I think
> >> that's why it ignores the return value of thread__find_map().  So
> >> we can expect al.map is NULL and maybe fine to leave it for now.
> >>
> >> As machine__resolve() returns -1 if it gets no thread, we should set
> >> al.thread when it returns 0.
> >>
> >> Can I get your Acked-by?
> >
> > Yep:
> > Acked-by: Ian Rogers <irogers@google.com>
>
> Looks good to me too. Should I resend the set with this change instead
> of my one?

No, I can take care of that.  I'll take this as your Acked-by. :)

Thanks,
Namhyung
