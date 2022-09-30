Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA55F03E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiI3EuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiI3EuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:50:16 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B6E00B;
        Thu, 29 Sep 2022 21:49:43 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1280590722dso4218590fac.1;
        Thu, 29 Sep 2022 21:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jTrTTnaa+GsdIoW1GjjS2R5NSouTfSyTGh02W/ezd1U=;
        b=NKFIb/qrKL0wjldHsRoreCjnJOobJSODRxsLc9KhTLyFNrnQv+fCX3KkPklMieQpHY
         gTGiGkLLSO/bmTaYSiviLlPA2IZ8jUuOEBf5odYsXSrjhcPd85He3z9q2cm4gWDhpH6r
         2seUvjBTo682qRomW3tZmi/T0PKj9dGKyBOvXLhxPwRKLjtmOowhLs+tFSAbfzsGFzLq
         jnjn1h0s6uPvamIMXX8Ziscuj8IoFCoP8d051CK85ajNxkTbS9CeeiGVXH0djxU+Cfzi
         jAS6LlTedP/7TFU/3e0hfSHozk8hnmGNr2B1ZhMZ5jN+NsxGVbfEa/HjfWURJPodAX5h
         YZMw==
X-Gm-Message-State: ACrzQf1WKMn5MCo6rV/sZE9SESQoMAOua2yyWRgKfHlOwaCw/srJNY48
        4OfwnlI5ZHLzknLtpOHJ2DYig0KMZuQefTWajwL/A/fB
X-Google-Smtp-Source: AMsMyM5du413VAnocLApIY0LX3A7KaMR9bCOO99QFehMhA6HRAdrIhZCxgptiV+rELmtUWQbXlqV9/QmG/WVIhGPqrQ=
X-Received: by 2002:a05:6870:a70f:b0:127:666a:658 with SMTP id
 g15-20020a056870a70f00b00127666a0658mr3895783oam.218.1664512907523; Thu, 29
 Sep 2022 21:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220928095805.596-1-ravi.bangoria@amd.com> <20220928095805.596-3-ravi.bangoria@amd.com>
In-Reply-To: <20220928095805.596-3-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Sep 2022 21:41:36 -0700
Message-ID: <CAM9d7cjVcGLn+dmajox6ASxx=YQYv9Viv+wzSXdaqCEJrow56w@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, alisaidi@amazon.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Wed, Sep 28, 2022 at 2:59 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS_OP_DATA2 DataSrc provides detail about location of the data
> being accessed from by load ops. Define macros for legacy and
> extended DataSrc values.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> index f3eb098d63d4..cb2a5e113daa 100644
> --- a/arch/x86/include/asm/amd-ibs.h
> +++ b/arch/x86/include/asm/amd-ibs.h
> @@ -6,6 +6,22 @@
>
>  #include <asm/msr-index.h>
>
> +/* IBS_OP_DATA2 DataSrc */
> +#define IBS_DATA_SRC_LOC_CACHE                  2
> +#define IBS_DATA_SRC_DRAM                       3
> +#define IBS_DATA_SRC_REM_CACHE                  4
> +#define IBS_DATA_SRC_IO                                 7
> +
> +/* IBS_OP_DATA2 DataSrc Extension */
> +#define IBS_DATA_SRC_EXT_LOC_CACHE              1
> +#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE                 2
> +#define IBS_DATA_SRC_EXT_DRAM                   3
> +#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE          5

Is 4 undefined intentionally?

Thanks,
Namhyung


> +#define IBS_DATA_SRC_EXT_PMEM                   6
> +#define IBS_DATA_SRC_EXT_IO                     7
> +#define IBS_DATA_SRC_EXT_EXT_MEM                8
> +#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM                12
> +
>  /*
>   * IBS Hardware MSRs
>   */
> --
> 2.31.1
>
