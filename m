Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D3636E42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKWXUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKWXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:20:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5327511E70F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:20:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i12so46712wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70Ny9DI7+FCGlZC99ZMX0gprkrrRN/2B6ssSCnxJ3SQ=;
        b=Yh/Rfw7+88BOigs5W1OnTsmT29XFTLvJ0nNVz4V4Rljd1J72CQqBxv1wXFiWvgDXaJ
         OWJ4GnY7FkhvCf0hlIVBXqf446VkMLwkf5lyPUJIFPDG6yW+aTRa4eNXR0cirVIXEVeX
         9ZTWDrC0kbY8kQgt2wBrFHIgg/Qw7Wx4udDRjAdQV/WaDVkR2MsRNbwEJDlTVvsFTRLF
         VPHq3P0XuhbpDMUc4Q5dqJArq40SRqj8wE+ZAUTATmsrm1Wrfl7j1+9cWjGQvhhQRuC4
         XvObc2Z5ZJsJqAFvlMT8qNkXq3vyxvWOe/WRWu0SVc/89m3JQ/sWJCueI8DppXekMxzQ
         577Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70Ny9DI7+FCGlZC99ZMX0gprkrrRN/2B6ssSCnxJ3SQ=;
        b=h2APqv1tdDLp3yzErNX6bYzjQ46zCisKSTLCjtQbe2mcw3JtTBzBrfEasSQFSI2ZAB
         09cugv0EIJgvf8sjDiaIrMKjEsveBCGBpgxchOAIHQc0CVOQFa1EAz9mkdIEe9AUvPEY
         S4wZ8KWTVz3pdWE2isrrA9zGz03USvPHYvpBo0BWrFdWhEdjq/1BKimWSgiM42UAZ1Jm
         lYxCfhe9OdcgxkkOSbgIWIFzBwILiaNGnOJiW7hNG1tZ9Z3+teVM+9S0iEZJY4HUujBr
         Lc3dTXyBr1NsTiuxbOif3fkNyLMNIOtLnHXi4vWrrg2P2Z/5P3+5wMOowwp+EgWD+j13
         Nbmg==
X-Gm-Message-State: ANoB5plI5IMrBIPXVmr6MBGqGAwE17WuvppRlwSdoDzmIJezm2so175t
        0+xWNKVzglirHYfjxDT6zrrz/3Pqt1LjW3GkZKOtz4GYdb8=
X-Google-Smtp-Source: AA0mqf5Ozvo6mHLLmCXVjwSOPOCTWL1gb0O9Dnyubp/kJPcRpHen07EJ5Xpor96lT5jr119Jqtu60J9IHASakpUBIOQ=
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id
 q4-20020adff944000000b002368f54f1f4mr18763863wrr.654.1669245625634; Wed, 23
 Nov 2022 15:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-2-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:20:12 -0800
Message-ID: <CAP-5=fV-szgDP_QQuCHn49ZvNL6i1ZU9Wkb4bfKLavPzetqeFA@mail.gmail.com>
Subject: Re: [PATCH 01/15] perf stat: Fix cgroup display in JSON output
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It missed the 'else' keyword after checking json output mode.
>
> Fixes: 41cb875242e7 ("perf stat: Split print_cgroup() function")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index f5501760ff2e..46e90f0bb423 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -175,7 +175,7 @@ static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
>
>                 if (config->json_output)
>                         print_cgroup_json(config, cgrp_name);
> -               if (config->csv_output)
> +               else if (config->csv_output)
>                         print_cgroup_csv(config, cgrp_name);
>                 else
>                         print_cgroup_std(config, cgrp_name);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
