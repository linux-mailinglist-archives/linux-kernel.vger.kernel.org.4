Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC34694002
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBMIzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:54:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994313DC1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:54:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso3753486pjf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2/mSUWKlQedrqtTIBOMxdk2IBVcf3JH3oYstMkfrAk=;
        b=CIG9hHXtpyrGgUqYj2fchGva1a4G6Bps/aP7JA5AqxJYIzBD7kM0DMYdQMHITkUbew
         cq6j1fq5P951jNJC2bKW9Ngt4b9xQpN4H5YUI66zeHzWojLU9r5pmn/qXy0jAq4ezTC/
         xeEen2pN598DADe6fMynbAQsSYINgRuOzYLM8hKym8fMIlTRu99BwEoru8hHwzjrzjRb
         5JjO5xIlDUzUgaTcx743OvI42sDiLLuRfg0/H0cT7nB2IKcjPooJni4TBhs+/E1NeO5J
         yTSy8bz0Y+gnsQyMcvp/KAFmo5/LJp115OIzxGo8WKo7am9puXGu1vmuRqduYg+jFEd7
         mSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2/mSUWKlQedrqtTIBOMxdk2IBVcf3JH3oYstMkfrAk=;
        b=EE6eEK26VNYyXpFxL6Elollrjdo1Qke59WGF1neKN4+mRPRmBYwqc0PUVyN27seLic
         z07OYBMXADUu8J0n56ATEubmW8t+wvccxNuI2/9xCUaWx5mc9pYg2iSBdCud7lx3GFmh
         W0EqfTQ6QLTeWMhnt5OxUBcQYQ2CJiFyT0odyjilAwO8DrwX+SJqqWYTakpVhs7L1Mwp
         hFkiEmw1AcE/IOuicVgzIKNo0rMVlLIXgJxcorPcSdJEXgTeFcxDLgJdXVItTL/dYPiK
         AHF183hbunHpcAj7W9bCEMjJR90FJ5VdDnDOs59dajI7g5EJT2yxoDtU17ER8iW5Djic
         zqtQ==
X-Gm-Message-State: AO0yUKUVYHy4GrnbvjLucSI2X4L+ey7XbTtWuqDRvhLG4mOG7Nf3XcEF
        yhEYIIX6Ck7gn8WZ2iiF5Fy6wQK5fb1LpO35NtKPfw==
X-Google-Smtp-Source: AK7set/TSDUJkzPnFx+7/gB56sSpKMXzphKQ1Rl4A/cwmpt51uV7IRswYltPBpVPD8UiWxP/wbHe+Q==
X-Received: by 2002:a17:902:e545:b0:199:f5d:478 with SMTP id n5-20020a170902e54500b001990f5d0478mr7310453plf.63.1676278495460;
        Mon, 13 Feb 2023 00:54:55 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902ac9600b0019aa6bf4450sm868142plr.188.2023.02.13.00.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 00:54:55 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:54:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH] perf c2c: Add report option to show false sharing in
 adjacent cachelines
Message-ID: <Y+n62XwT3nUGX4/M@leoy-yangtze.lan>
References: <20230213031733.236485-1-feng.tang@intel.com>
 <Y+nyakPnVDpVjn24@leoy-yangtze.lan>
 <Y+nzoaJcnMFokDMX@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+nzoaJcnMFokDMX@feng-clx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:24:01PM +0800, Feng Tang wrote:

[...]

> > With these typo fixes, you could add my reviewed and tested tags.
> 
> Thanks a lot for the review and helping to test on Arm64 platform
> which I don't have access to!

Welcome, Feng!  And thanks for your patch!

Leo
