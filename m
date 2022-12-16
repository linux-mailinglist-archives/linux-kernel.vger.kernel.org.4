Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6654B64F0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLPSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLPSJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:09:04 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458933C26;
        Fri, 16 Dec 2022 10:09:03 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id q190so1618474iod.10;
        Fri, 16 Dec 2022 10:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eFLCni2OGFsB0YPow85ffGtmX+w7qQ59Jc5KJ46+aE=;
        b=0io4IvVsIbTgKpEMxDIdRt97bamCXj4PjZZlsNs4TB8vGiklQ9fjBWawQsPykqIp/d
         qcnK72/FtzIOCDIbAsIHlQxMUHm0nDr8P/hgO2hbsVNayPqnJP53oylt6YaJhwvb6/2q
         5aOI9OFOzKvLY96w7e5lKa7PneEv/AOCSOlzPqOLgIMzOUADXQA45334zoMAWFlg4aC8
         Eo09w10OerPwKIAXvzdRQ/G4EMg8lr3kvX++RdVsTThS7UQ8AUNEYiiZkmltZEra0uFK
         fDIfloP9/gnLT28ilywR0Mkw70jUFk7B68CtZF9LVQvVjm6FZh9t3WBqHDJYTv8Ud63s
         kHQA==
X-Gm-Message-State: ANoB5pmwmGOebPtZ6VPN0BOIyEYBQWuC7FS06iCMqAksIEb+VMGKGQbk
        Y3Ol8xLXWtBKPSw/ZdOI5UCvLIIoWZr+002p32E=
X-Google-Smtp-Source: AA0mqf7Mc1qsy89MJIB/mEQA6FG/Nz7IiVG09NMLeNxXxYuGoobuOTsg29OmNVQkAFXcY8wxtZHZQOdUgi+7+UTQcNQ=
X-Received: by 2002:a02:3f48:0:b0:376:2a35:3b21 with SMTP id
 c8-20020a023f48000000b003762a353b21mr37069879jaf.284.1671214142116; Fri, 16
 Dec 2022 10:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20221215192817.2734573-1-namhyung@kernel.org> <20221215192817.2734573-3-namhyung@kernel.org>
 <18594a2a-553a-c2b8-2c4f-6f7563ae3727@linux.intel.com>
In-Reply-To: <18594a2a-553a-c2b8-2c4f-6f7563ae3727@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Dec 2022 10:08:50 -0800
Message-ID: <CAM9d7ciS3H=2OVGGiNg5N6NeyZtfSE6D5kCHmQu_Otem4ByuuA@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf report: Ignore SIGPIPE for srcline
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Thu, Dec 15, 2022 at 11:25 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 12/15/2022 9:28 PM, Namhyung Kim wrote:
> > It can get SIGPIPE when it uses an external addr2line process and the
> > process was terminated unexpectedly.  Let's ignore the signal and move
> > on to the next sample.  The sample will get the default srcline value
> > anyway.
>
>
> That's a bit dangerous -- if perf report output is piped to something
> else you really want to stop on SIGPIPE.

Maybe we can handle the pipe write errors gracefully, but it'd require
more changes in many places.

>
> You would need to find a way to distinguish those cases.

Hmm.. ok.  I guess we can just drop this for now.  With checking
the .debug_line section, problematic cases should be gone mostly.

Thanks,
Namhyung
