Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E68E673E41
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjASQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjASQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:08:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698917CC1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:08:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b5so2391358wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fv4FveSXLtbMs8fIyKU7U7B1TC2c3Ol7CJ/N2mCREsE=;
        b=Z6hdEw1xC+r9OZvwDwA+B122spz7EsoHP17f0Cp0vq9QAN4CfQCci6tDWJkxfZ9fNo
         fzLNoMg3XjnZOQI0eUNHprxoWuzAK9gnijj0wJ8SfUeGbvhQ2b+9wuuf4KylcWf0dLQb
         BV6YyUFFWnr4hylTSaSxk+vggHHkY2yrUXDhwbKtI8GscswMZcVgWjNYfu/gIejjmr4F
         5Zl1MjBlBade7gjOmcbOKg4GIpxkJSXMHS7LZC/aoCoejUSyCUVMH6XTFveOZojxIvTK
         DrXT+Z97kKkkykC2hxSjWJos0PWZ77JFKJ39E+jLcUrpe/YXXu9OTBWhoZ/N6vYGUPrq
         9tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv4FveSXLtbMs8fIyKU7U7B1TC2c3Ol7CJ/N2mCREsE=;
        b=T0gGUDB2UWUD7MDITrfWShRRcstyDqcXyr4qzO/ItewT2llvxxprAh56RqS4DsPF+f
         FY8hWJuT8vtPtHn0fUkqZtykd0CUNxaHTvR228LtZuC46Jp6GJ2W79Rt/GqeOF8KJmWJ
         O4zCSMAERYTO3Rj+1HONYLGdQs9exJeyvIQYAlwtZ1uBYKnshP5pD6HkwvOgD/+VxBE5
         nK/xv0U5DC89E9nH5IS3wo6nTIXt4GZzhEr+vahNIcgm5mZPwS4aTncAUKY8W+wagGKc
         H2TXZSRLwtSlygx+YiypxlVyr2n9SptRSmSzNrWL+xy38ieBiaW3322FLZX8+mWdHcPS
         RtAA==
X-Gm-Message-State: AFqh2kowmfptV6U4apwrovL5REQxtWQSGckXhdfgcHOX2SDYy0o1+0w7
        9WVaOHOKKNeHL1XLyR1W4G/4jqXAfuiVYDO4GEtEPg==
X-Google-Smtp-Source: AMrXdXuGSDCU/sElIGWgZvb6vilVuirMVBG1izak7wLK9Loxpwn63U0ajRG3KIbUTiISw4IRZxfZrt/XGomjC/ouxDk=
X-Received: by 2002:a05:6000:124f:b0:2bd:df97:13f4 with SMTP id
 j15-20020a056000124f00b002bddf9713f4mr496689wrx.654.1674144504966; Thu, 19
 Jan 2023 08:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20230113185732.134861-1-irogers@google.com>
In-Reply-To: <20230113185732.134861-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 08:08:13 -0800
Message-ID: <CAP-5=fXg28wcW93tfiN6mdFHj0+eSRE3dL3LTv53bRYuezjZDg@mail.gmail.com>
Subject: Re: [PATCH] perf buildid: Avoid copy of uninitialized memory
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:57 AM Ian Rogers <irogers@google.com> wrote:
>
> build_id__init only copies the buildid data up to size leaving the
> rest of the data array uninitialized. Copying the full array during
> synthesis means the written event contains uninitialized memory.  This
> was detected by the Clang/LLVM memory sanitizer.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/synthetic-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 3ab6a92b1a6d..348d05e4ec03 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2219,7 +2219,7 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
>
>         len = pos->long_name_len + 1;
>         len = PERF_ALIGN(len, NAME_ALIGN);
> -       memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
> +       memcpy(&ev.build_id.build_id, pos->bid.data, pos->bid.size);

Ping. Should be an uncontroversial change to fix a copy of
uninitialized memory into the perf.data file during synthesis.

Thanks,
Ian

>         ev.build_id.size = pos->bid.size;
>         ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
>         ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
> --
> 2.39.0.314.g84b9a713c41-goog
>
