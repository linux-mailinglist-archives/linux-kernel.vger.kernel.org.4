Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFD62E3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiKQSAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiKQR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:59:58 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2D7ECAC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:59:58 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id m18so1209328vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dCKWOnvjQEJq4tUo9dFNFyCXfgqwWTejP/nifqG4MVw=;
        b=nlzF0FNAIehjAt0d1wDzFKJniOtpT80HzGxTOrWuENTwUSwuTiNQYYp4m/GIvX53No
         LaFZKGirDMSVpPBW/04S0TI0sjkPJveKwj+h0grCPpw0juOLe+BACCONhAMeonw/XVMf
         +zDzSHLkZekfRoEEJWERtMW5xKDz5w7cN+AUpSNeKKJK6L4zeiQnMwdR2nIHWFHaRsE5
         +OFqrymqk1qv4kmny0WrqRprK2zH7fUUOLlumVfgMs2bveD6QKryBUjGg8bGquGDx8zH
         2aji3Mm48AI71Y6OTZyAkhL/nOIu5F8k487ZFNPkGaY7cNJEDeAPSB4xeUfCu2bzmnO3
         BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCKWOnvjQEJq4tUo9dFNFyCXfgqwWTejP/nifqG4MVw=;
        b=IBvtDg0KfqMB6AUkWOIm1ufzt0pVwHKs/V9AxT/Dsg2AYC08OwjRR/uRzagG1NdoG+
         6/aNb0I/j6hJ5dECWmjw5oCA8mmMR/ana44BnSSmaqn6Jtpf0BQlYQxQD15n4Lno1HSH
         WAKgFfCN5iAHxssve2DMbdJQ9JpGzrJ/elVwuuQhbH8DYjNIVCQzh0GVJezkuYeG36R2
         GsVpoMydxU/TsSRCKcw7jnEdB34Svt942zsWW7HFHKzZ0xDSW606sSEbQFTLFFZlkNMc
         XgoU5Q+wSfhgh3dEW3mlYslB8RgTFQCMlK+pwRfSVCz1ZjXGbPqem9Z37DmdYGZvmfx0
         iSIQ==
X-Gm-Message-State: ANoB5ploXIG9KERAwRwZYP2SiNcSE4/3WvISzD7cxbuNjGRzcTtsOzGF
        nh+ut73XaDavaetPIh8mtWfjK9Q9/fzJ1sXKjfvXqg==
X-Google-Smtp-Source: AA0mqf51xB7AnO0xFFSDWF/njP75eYwYOkGHnUr/g/pZGGxytCxiRLsm3hLySdFwAlYONeFEXlsQmTIH/EiZgXILVwI=
X-Received: by 2002:a1f:c645:0:b0:3b8:685e:22eb with SMTP id
 w66-20020a1fc645000000b003b8685e22ebmr2034444vkf.33.1668707997105; Thu, 17
 Nov 2022 09:59:57 -0800 (PST)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 09:59:46 -0800
Message-ID: <CAP-5=fWxAjEia-Qbm0RVzKOxyiod8rUOBieqaGK=DtQboDe3Qw@mail.gmail.com>
Subject: Remove traceevent from tools/lib
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arnaldo raised defaulting BUiLD_BPF_SKEL in the perf tool build:
https://lore.kernel.org/lkml/Y3Yy5DFEoCEBv%2FQi@kernel.org/

The recent build clean up:
https://lore.kernel.org/lkml/20221109184914.1357295-1-irogers@google.com/
https://lore.kernel.org/lkml/20221116224631.207631-1-irogers@google.com/

Means that perf is cleanly(ish) separated from libraries in tools/lib.
traceevent in tools/lib is out of date (~2years - version 1.1.0 whilst
the latest is 1.6.3 [1]) . Should we delete traceevent from tools/lib
and just make LIBTRACEEVENT_DYNAMIC the only supported perf build
option? I guess this may break old distributions that may not have
libtraceevent, but even so I'm not sure that should motivate not
cleaning this up (if they are building perf they can build
libtraceevent).

Thanks,
Ian

[1] https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/Makefile
