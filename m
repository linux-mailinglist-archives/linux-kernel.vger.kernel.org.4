Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A050744BF0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 03:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGBBCb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 21:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBBCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:02:30 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7EF1717;
        Sat,  1 Jul 2023 18:02:29 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-c4d04d50c4cso375247276.1;
        Sat, 01 Jul 2023 18:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688259748; x=1690851748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpxQT1popqga6hqikm0/WuMRufOfA5vSFKW1HFmcbgI=;
        b=Kah+v9SUsXJGdn+Y0dlI3qJWU7dpL8frR5P6rEkDDwxEQg7zWCZcuZIfJUvNpuMdpi
         CHBQtzaUue/K3VXxf/pb/wN1DVwykl6871HuLQXguP83Wv+QBBG9TcXvlNhkoBHPdfQJ
         NvVQxKBPECgr7Hb6XFgB8TBwUUFbdpzbvG0G8gw4VogfnUGhFR86EwVktTRNyZ9xOc8/
         pKJn1CZs+ErxZH0+bUyDiqPxysSagPrLlzEbPX3zBGYN2FKTcnTE15M0t7D7UTumJ2iD
         FGp+0L5faLzD11ksAKd/dmckcIUTOu9ysGFoSz13xTp0FIC2SAbEmxWQLTPBNXJlDDZl
         lHWA==
X-Gm-Message-State: ABy/qLYT9zCp9vszQ3MZJmF5xeeWAA4W1iTV7PT+9bxHSZfU1ZBVG2zn
        ZTRsEHNdpZsPWCONraPSocjQv0EHZWblGUbfn6RmsbOX
X-Google-Smtp-Source: APBJJlHeyvRW5bUM6+AC6w6B4kK2l08jECx294WYxVpM/OdbrFS/TIkJhceGRUcY3k93AUq3Y/Lk+OhsicWKTKKKUWQ=
X-Received: by 2002:a25:fb0c:0:b0:c1a:b0e2:e930 with SMTP id
 j12-20020a25fb0c000000b00c1ab0e2e930mr6029928ybe.3.1688259748079; Sat, 01 Jul
 2023 18:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230630153840.858668-1-james.clark@arm.com> <CAP-5=fWMu7g9DWbBatbACV0VmThKNLLg0=Uff-oH48XEsrpJ3g@mail.gmail.com>
In-Reply-To: <CAP-5=fWMu7g9DWbBatbACV0VmThKNLLg0=Uff-oH48XEsrpJ3g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 18:02:16 -0700
Message-ID: <CAM9d7cjxm4bSiNgnTTgomcNTpOqasd-iOdxab-qoqb4SNg9qmg@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Fix uninitialized return value in symbols__find_by_name()
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
        linux-kernel@vger.kernel.org
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

On Fri, Jun 30, 2023 at 8:49 AM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Jun 30, 2023 at 8:39 AM James Clark <james.clark@arm.com> wrote:
> >
> > found_idx and s aren't initialized, so if no symbol is found then the
> > assert at the end will index off the end of the array causing a
> > segfault. The function also doesn't return NULL when the symbol isn't
> > found even if the assert passes. Fix it by initializing the values and
> > only setting them when something is found.
> >
> > Fixes the following test failure:
> >
> >   $ perf test 1
> >   1: vmlinux symtab matches kallsyms     : FAILED!
> >
> > Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Thanks, and thanks for the Fixes.
>
> Acked-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
