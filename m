Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEC66B86DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCNA1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNA1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:27:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E267735
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:27:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so5977545pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678753622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxHE9Z1fYF3JO3MBVvTg1TSETT4czgValrRGg9ZVOLI=;
        b=SlwI0Wej6j4KkPHhzHJxfO6a/i85VVkDxMqcTGowiU+jYgeEfSyMD/fDdd1cwh3M29
         4jI7gFN3G/e72M8AbM15eaQnjvcHIzTHrICAGFQAtZ50lq6MgOiCdTBEEuA7fwaPukXD
         gC4aAnpHDlaV7PqHmL8nePBd17M3fTRwlj9r778UCBlspI3Tc9ybayhtGkDerIjvEDD1
         o0DJXF9UymGlgCFCb515Dsb9R5aZIsV59mzMrrwKK+wKyOPSWZBtHx9jV05PnJWEbYBw
         FB5SZ2NdkEQ0YJ/shn1BsBHiIndIPKpz3h2QNs0AizREyJNxT8w1xAS2o7qZZmN0WRFC
         8DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678753622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxHE9Z1fYF3JO3MBVvTg1TSETT4czgValrRGg9ZVOLI=;
        b=BNv4xA9uXlqvzlkq37cbVR6ebov2E/LqSsgM3vjSnHAAltg1iookuofmCS8UngGVBl
         RDMvm46sg3T+9Im2Kxfzlsk+jBz0x5mLxJnPIXXMd0780CQDg/qo+pcULMFc+QQxdd27
         JnT1MuGb67PxiQk4Mh5pGmkcEzD8ANauHId95YTPqUBiJ4Urc91SLG2/wW9WdQzmmfCs
         uVU4Z+TgMuqiw2TSJwZvvFaw+RtlOrXUsFPrrhYoYgI8vhv8mAv2KMzdetO0X/hf23Ag
         MCUAzRd2MMro28L+wItqcM+Qu/r0Q0eA482YlAyWO9bzIaHwYF5NaTtd4fW7/CbG4DxW
         sc7g==
X-Gm-Message-State: AO0yUKX8lFIbN8pM9S2Y7++tFyN05kxEUM4pzbArm1l+c1T5s9+jYYa9
        T5KcIhNfDLfkkdGdrYHdbpcNGg==
X-Google-Smtp-Source: AK7set8f/2vb+YfoFzMLadtwfiX5pSJAQjA6HcKC4VngJswMYfXkYsghM7ajzyPnZ8Yfjbh/MVWmYA==
X-Received: by 2002:a17:902:ecd2:b0:194:5c63:364c with SMTP id a18-20020a170902ecd200b001945c63364cmr46084642plh.62.1678753621870;
        Mon, 13 Mar 2023 17:27:01 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b0019a70a85e8fsm389562plz.220.2023.03.13.17.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:27:01 -0700 (PDT)
Date:   Tue, 14 Mar 2023 08:26:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 04/16] perf kvm: Use subtraction for comparison metrics
Message-ID: <20230314002656.GC2426758@leoy-yangtze.lan>
References: <20230313114018.543254-1-leo.yan@linaro.org>
 <20230313114018.543254-5-leo.yan@linaro.org>
 <ZA9kPg7JDzkxAStz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA9kPg7JDzkxAStz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:58:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 13, 2023 at 07:40:06PM +0800, Leo Yan escreveu:
> > Currently the metrics comparison uses greater operator (>), it returns
> > the boolean value (0 or 1).
> > 
> > This patch changes to use subtraction as comparison result, which can
> > be used by histograms sorting.  Since the subtraction result is u64
> > type, we change the function return type from int to int64_t to avoid
> > overflow.
> 
> Not building at his point in the series:

Sorry for this!

I can reproduce the building failure, will check patches compilation one
by one and send out new patch set in today's later time.

Thanks,
Leo
