Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779C7647718
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLHUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLHUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:15:33 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557378B9B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:15:25 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id y2so1669492ily.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBJ3EpD4mCazHRDaQ0hpxsWyDSGssOPcsHYErf96w0M=;
        b=LZDZZYsoerHqDDBIYE5Ys/KwPq0bnmxoDl4HSMnfXKyLDJ3uVBTAG5FGEZ9R5X2tNB
         EyPz/uF8P4cY1zyuabxlbkuSnW18Ke3df8siylVL2PT61ICewNESGeuo5icbuMc5KZ+o
         r45BzsZyXh65+VRD6bZSu8WBh0ZSLbFq6Txzl1XZ07+sukqr7ti/p87mnQypGdnOHohs
         VSSAk7xdcOLCtoUy8T7EHFOWJvvdkisq055Fz8Tojxox/0zF6QiBDfWuPGDzIJXQ0QDP
         fhkhrIkWh55tfzuak7pXjLiZyEfW37m5a4gCSHJYvHCyka72O38hQ1B6z1covEHfsfu4
         DgDg==
X-Gm-Message-State: ANoB5pn3mQ9gofmV2LqQJ7Ii7Jfd7amESz88oqZdy3MhkRnKHcevUkUF
        Uj6vdM1UeW9pYXAi224hrEgmJTd4vHl4HJFf+ms=
X-Google-Smtp-Source: AA0mqf5JUUqce8JQ28yrQ0HY/cc5JQ738DMG73VEo15NaeOIBoMI8m7Dm/UEvAAFK4DfJ/IQUqWvwQprDjYXv/V9nK4=
X-Received: by 2002:a92:6b08:0:b0:303:148c:6a28 with SMTP id
 g8-20020a926b08000000b00303148c6a28mr23429305ilc.294.1670530525105; Thu, 08
 Dec 2022 12:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20221206154406.41941-1-petar.gligor@gmail.com>
 <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
 <Y4/AfA2OYtlTkKwo@debian> <CAM9d7chLZVDg_-tnUh_qFYzchnpis-e7HYNDVM_OPjj_QXMeKQ@mail.gmail.com>
 <Y5HVdS3mlDruNyrl@debian> <CAM9d7ciX9ULwSy5G3cFZi7mMXrt_A52hwwk7L1m-oV_0P07_vw@mail.gmail.com>
 <Y5JE/ci+1nN9RrJQ@debian>
In-Reply-To: <Y5JE/ci+1nN9RrJQ@debian>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Dec 2022 12:15:13 -0800
Message-ID: <CAM9d7chSj_p8KzqRdOUZaFMyVVXHLoW+Ra5ZR4FY60bpvzUSMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
To:     Petar Gligoric <petar.gligor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
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

On Thu, Dec 8, 2022 at 12:11 PM Petar Gligoric <petar.gligor@gmail.com> wrote:
>
> >On Thu, Dec 08, 2022 at 11:10:58AM -0800, Namhyung Kim wrote:
> >
> > Then I have no problem with python.  Please take a look at the
> > scripts/python/bin directory to provide shortcuts for record/report.
>
> Great that we could resolve it! Regarding wrapper: I thought I added
> them or did you mean something else?
>
> .../scripts/python/bin/tasks-analyzer-record |  2 +
> .../scripts/python/bin/tasks-analyzer-report |  3 +

Right, that's what I meant.  You got it already! :)

Thanks,
Namhyung
