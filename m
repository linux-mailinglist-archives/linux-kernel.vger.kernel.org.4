Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F356FBD69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjEIC7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjEIC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:59:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8677ED2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:58:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaed87d8bdso37412715ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683601134; x=1686193134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyLj8HoVtfi4u1IfIfS6SKhJKc2AXFWhk5oxVikC/mQ=;
        b=T6QDiZzxsNNqW9dRgau/daPxt4FhkYs/ITGlQI+zGtIZhiA1yEAzgoUxaPr17QQTxB
         T2wOKECfJ8djM9wqroh20f+GmXIREVlfas6dSHHnnm5MGpu95hx4HmiCqyx2/8sPT/bg
         R/tMyLihWPoQg4iXsuBjyTx0SbjSGyCewtiXr3yORNoYtYtnbNR/98B5pogjIP16q0bp
         2VHuET4Q1daNAIp5nSumoTrXsyVBllUcUJOrA6t1Eo6QFLxMpHnphjLBTrzaGNsqcqAj
         b2umWICM7EmxusxFCNVIWIPL4LcV1y+VPsbZtrbrKQkuZ90lJqNf0Jj3+44nWWXE2wsr
         Yztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683601134; x=1686193134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyLj8HoVtfi4u1IfIfS6SKhJKc2AXFWhk5oxVikC/mQ=;
        b=hU+DvYSf8zXzcQFtv3hD9FbxtGYGzP4YN7Gpk8RFGuJJcpMZ95C9vBOuI4iD/zOpuj
         U6fboTmwhfJXmB2UZvmvy7SNOPV+By4xP2XNP5caRYZ8Gqpm3Yxws/sVbSbte0rJodSG
         /ZXp9MoI1OyBwgJRd3Ql8lcoyeK/59YEPWXETKehErnrd+HLfoDlFFhOqOuWD417x1c+
         iu9v/jZ7oSVO9jGH8akss9SOOQaa8nVkJ9UHo9tsVfk2OO4gfPBXRixfrkVESwAiY/LZ
         iR8IFl7KAiVPQjXOvZ9gQrNrOJMQBVC9dtu5JQLgn3ADSCR6Qz/0aygOlFbP4oMh56CD
         yzEw==
X-Gm-Message-State: AC+VfDzwZqW/AC307SG7yKnFGSnlnVF+3DwB+nDKzl1JGEwnyVivCXjD
        FCZ4Nj1lNqA7cM6t4aDU1kDKlA==
X-Google-Smtp-Source: ACHHUZ5SGln/XR0RFcFjgz3GCNY/xB4lMkhVYaT5SM3anUrKBg8HdtL+v97rbfQYe8vYr8U7wtW4yA==
X-Received: by 2002:a17:902:a508:b0:1a9:baa4:8677 with SMTP id s8-20020a170902a50800b001a9baa48677mr12244693plq.11.1683601134308;
        Mon, 08 May 2023 19:58:54 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-209.hinet-ip.hinet.net. [211.75.219.209])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090a448100b00246cc751c6bsm2228984pjg.46.2023.05.08.19.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:58:53 -0700 (PDT)
Date:   Tue, 9 May 2023 10:58:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf arm: Fix include path
Message-ID: <20230509025846.GD3374705@leoy-yangtze.lan>
References: <20230508213128.3622268-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508213128.3622268-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Mon, May 08, 2023 at 02:31:28PM -0700, Ian Rogers wrote:
> Change "../cs-etm.h" to just "cs-etm.h" as ../cs-etm.h doesn't exist.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 860a8b42b4b5..46154c226fbb 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -12,7 +12,7 @@
>  #include "arm-spe.h"
>  #include "hisi-ptt.h"
>  #include "../../../util/pmu.h"
> -#include "../cs-etm.h"

This code is a bit tricky.  Here it deliberately uses "../cs-etm.h" to
avoid including the header file in the same folder, alternatively, the
compiler option "-I/home/leoy/Work/linux/tools/perf/util/include" will
lead the C file to include "tools/perf/util/include/../cs-etm.h".

> +#include "cs-etm.h"

So with this change, perf will fail to build actually :)

We need to change to:

  #include "../../../util/cs-etm.h"

With above change:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks for code improvement!

>  struct perf_event_attr
>  *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 
