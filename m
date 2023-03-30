Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0066CF975
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjC3DNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC3DNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:13:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF449DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:13:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id iw3so16848193plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680145995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCg6ynzMxsrJHzdReGq2w6T9esplKe2G2nwmJ+uwMSk=;
        b=R6FlPuP7QN/VqYKtQ7COJpyc8MTkHY2gm4Lts2H1x1/cJomKJQZViPH2mdB8Mwj4bC
         uElDQaM11CRQPKmy8Z42ZYbkfZZ6Hbinoyn/0S0pLiOYH6/VsbcfAxnE/IMtLXkuaE30
         043qMbzWWJCr27kY0zqW+4pwhLxtQnoqRUo9z9G61haXfh9MKOWPJPKUrpU8TCfWJ7rl
         4oJ5beMaM+XO10BfV6qM695M+ppvZ8pI+RiI3T9/q4TM9STQkjAfF9oEyTw3uB/nwlVk
         i0WiB1NgIljehHHkSKQVGVCYRLKwKx6ADhudgSE/bGFVc9+3aaeHI3ipWtPR7GmTM2Po
         NjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680145995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCg6ynzMxsrJHzdReGq2w6T9esplKe2G2nwmJ+uwMSk=;
        b=yHDKlauF+42F+0tjA8J/YFCLxV+YBJyjILknCH5KMvPWy/Z8x2qyTY+YxMZnFdxN4l
         TeneJ6OuKS0M0sEtJJDvX/vD3m4XaPXO55/Xf/UbGKRpXyyqONF9V7NhX9JVShnQ8E3u
         elX0w7EiPxu4uTbsEt9jFjXwg44bCoWVUuMGTmvQ+70qcGManROYrEfpYRBpdzi/zdB8
         eFyx7AnV4a+Rry81UWIgwK47R4reqGxuy1B6r7bNAEZiS+9V2eSVKbcngtwI2WiK0hsR
         UGFGtQ6HG77HwF4psUrsrWt6GcYZLB1sxK7ajS3S205gaVuQ30DrSDy9wrwxfzZNPCSH
         1npg==
X-Gm-Message-State: AAQBX9cybjKt8+iSx1B/x5EuOl/GsoeG30iAnIqkpeo1/5jlKn8l9eaQ
        4K6Sfy8IM+C89KQWoE2qsdO/RQ==
X-Google-Smtp-Source: AKy350bevnhgi7ch9vGSubFn23BHtfiEnN9OxinnIYOj9g9dbzrQC+pyV5yjwQfolRFnNWfqylARcg==
X-Received: by 2002:a17:902:f542:b0:19e:e172:2a40 with SMTP id h2-20020a170902f54200b0019ee1722a40mr26853081plf.65.1680145995145;
        Wed, 29 Mar 2023 20:13:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.100.185])
        by smtp.gmail.com with ESMTPSA id z23-20020a1709028f9700b001a043e84bf0sm23598172plo.209.2023.03.29.20.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:13:14 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:13:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        gankulkarni@os.amperecomputing.com, darren@os.amperecomputing.com,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Message-ID: <20230330031307.GD252145@leoy-yangtze.lan>
References: <20230329111422.3693-1-mike.leach@linaro.org>
 <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org>
 <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
 <ZCQ7nhrISA+jCfnI@kernel.org>
 <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
 <ZCSRU8zvjjBHhq+x@kernel.org>
 <ZCS4XJaWg7NvaWb7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCS4XJaWg7NvaWb7@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:14:52PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Not here, I'll check after a call:
> > 
> >   50     9.90 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
> >     arch/arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
> >     arch/arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
> >       data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> >                                  ^~~~~~~~~~~~~~~~~~~~~~
> 
> This function was removed in:
> 
> Author: Mike Leach <mike.leach@linaro.org>
> Date:   Wed Mar 29 12:14:21 2023 +0100
> 
>     perf cs-etm: Update record event to use new Trace ID protocol
> 
>     Trace IDs are now dynamically allocated.
> 
> I'm removing this series from perf-tools-next, please address this issue
> and send a v9.

I can reproduce this building failure.  I am curious for how to verify
building for patch wise, the link [1] gives me some hints and below
command works for me:

  $ git rebase -i --exec "make -C tools/perf clean && \
    make -C tools/perf VF=1 DEBUG=1 CORESIGHT=1 && \
    make -C tools/perf clean && \
    make -C tools/perf VF=1 DEBUG=1" HEAD~3

Thanks,
Leo

[1] https://stackoverflow.com/questions/26983700/git-run-shell-command-for-each-commit
