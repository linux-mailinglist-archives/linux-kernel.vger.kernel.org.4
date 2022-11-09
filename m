Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019C6231FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKISDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiKISC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:02:56 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C125C6E;
        Wed,  9 Nov 2022 10:02:54 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id l127so19634141oia.8;
        Wed, 09 Nov 2022 10:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v65PkuQjKTHQdc19gFzSt8e8ZJKq+oCVZt1MzCmow2k=;
        b=KWU7wydo1mRWKs8a/41YUugJJ5iNiZ8kqeBJVcNcZ1P/BE5qloc+5D65pBaGNajBPR
         cRmMqX1MRvqUEv3olP3KemeOYQYjo/wTDfnLrR6/q2VKgmRYkYIkr5zlnOz/Rlbtjw1q
         HT4TSsn9GozUEDNYmV+oj+sq2vld1sBpN5b8d7nSUmEILQIl5E/3cmTq2EjESsbZzDdz
         tAWRyYtcNXWRU30nRApHydjTudrcOH4CScOv4caJuPERhmXaVA5zwls1Y521SdUWMANA
         CM2uYVrcJG2lVQTAeBgiMVBb9Ky3zcuZDqUe2PsGWfdv7QK6wW5aENCRG2s8UrVZlvts
         sGHg==
X-Gm-Message-State: ACrzQf3w6plCAnmBo/ioXGzQ9nxVX9rKMahAHf9Y2HPK+oT0AGDala9g
        YxTAswkSPy/P6aoxhRkNc1ACRVYqRv4UFnG5py5N7t1Q
X-Google-Smtp-Source: AMsMyM6P64mXF96xlWlJJBgPkppkmrmr469ozds/QsLjGImzDjBeJskYqBvMaDPQhbA7YSkRaOB0OTEwvMvHrKTdVoo=
X-Received: by 2002:aca:2805:0:b0:359:e340:d53 with SMTP id
 5-20020aca2805000000b00359e3400d53mr31683937oix.209.1668016973150; Wed, 09
 Nov 2022 10:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-4-namhyung@kernel.org>
 <CAP-5=fWXAjWd-dbVXCVfRzP9iw5RzXo+cPWWPpOmTw-1xBECqg@mail.gmail.com>
In-Reply-To: <CAP-5=fWXAjWd-dbVXCVfRzP9iw5RzXo+cPWWPpOmTw-1xBECqg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Nov 2022 10:02:41 -0800
Message-ID: <CAM9d7cgAiAUqv0PZXMLjHqxfZO9u5NJgip=7Zd5QAJsBbzaOOw@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf stat: Clear screen only if output file is a tty
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Nov 8, 2022 at 3:16 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The --interval-clear option makes perf stat to clear the terminal at
> > each interval.  But it doesn't need to clear the screen when it saves
> > to a file.
>
> Would it be more intuitive to warn if interval-clear is specified with a file?

Makes sense, will change.

Thanks,
Namhyung
