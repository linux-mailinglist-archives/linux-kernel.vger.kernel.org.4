Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629895BB1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIPSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIPSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:12:21 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224CB6D5D;
        Fri, 16 Sep 2022 11:12:18 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id n83so7081756oif.11;
        Fri, 16 Sep 2022 11:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S9PIV64pGtjaPrT9t4m6JJ+cZj+i70+NGMZ0t+i2gas=;
        b=5wGNsOnQLmqqGdhjCCuxnlKr+EAU0PGU2rhl0vaIIutonXBvjD4yTHqRYleicb3k6w
         J1tcrX/Xi4BCVgei2M95CitmXQcVES4lkRDkn5+B87ol9cQQHJ/+/xZ/pRkAMOotFAdT
         1UQfgrvJ2bxSNKyvs4rY61IrsCV651Sex9NqAcKvyWn86M4I+J5J2VIDvuH7lCyoeLKj
         UPXKeuB7gcmrJ5ag3i7DuFPjBYssdTjev1kFQXGBFnPzqisqMGixHOT35R8QiaYVpbsM
         DD1LWZzswGZ5UKkt2rZVKE9MpQzSw1z4CKPADaqC1oQTU+axRXqY+SM7qTyN0SDMIBsJ
         hMRA==
X-Gm-Message-State: ACrzQf071H/VzI4IcL2InxD0sMfOTR2Nrl0RG+EjiDpItfHGuv3cqJon
        T3d26IaT+rZyxmMMPqGHZ4Nmzh8KdbQl2t+vcnJAotKQ
X-Google-Smtp-Source: AMsMyM56vTjLBa2hmmNMuTinTTNT+gXsBXyo9xSoWc5u4UxGYEFGFjjzEvMZSNg1b3wLAKsRWDf4QQG7n3WSMsaOh8s=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr2961208oib.218.1663351937491; Fri, 16
 Sep 2022 11:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org> <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 16 Sep 2022 11:12:06 -0700
Message-ID: <CAM9d7ciNwe1HaYXjau6hv8yUmnZvvQU0=bNdf=EA589frkjptg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN' attrs
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Sep 14, 2022 at 1:09 PM Rob Herring <robh@kernel.org> wrote:
>
> If the kernel exposes a new perf_event_attr field in a format attr, perf
> will return an error stating the specified PMU can't be found. For
> example, a format attr with 'config3:0-63' causes an error as config3 is
> unknown to perf. This causes a compatibility issue between a newer
> kernel with older perf tool.
>
> Before this change with a kernel adding 'config3' I get:
>
> $ perf record -e arm_spe// -- true
> event syntax error: 'arm_spe//'
>                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> Run 'perf list' for a list of valid events
>
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>     -e, --event <event>   event selector. use 'perf list' to list
> available events
>
> After this change, I get:
>
> $ perf record -e arm_spe// -- true
> WARNING: 'arm_spe_0' format 'inv_event_filter' requires 'perf_event_attr::config3' which is not supported by this version of perf!
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.091 MB perf.data ]
>
> To support unknown configN formats, rework the YACC implementation to
> pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> warning.

It only handles configN formats but it might add a completely different
name later, right?

Thanks,
Namhyung
