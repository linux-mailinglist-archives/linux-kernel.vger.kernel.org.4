Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD495EAC14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiIZQH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiIZQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:06:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252CA27CC7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:54:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso12727561pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kKFISMF8y3UineE1SH2S8n91CZBFI7ucs7QvcNIP1eo=;
        b=ub/tjcofVKs8dZhq8NKKsRXUHATcafd3A6sc+Xf4tb5skXyA7ZN4Id9uToPQpx546/
         k7snccIY4Ghvz1ZfHfUHoRFZOfK+yGVyalHcrJc65DY3M/feAN6SJcp0NUieezE0Z/QQ
         f99fZwZPcyxsySurBO1kutJvaSTVzf7mkhQXKvQAHfF92o0C0ur9rGd7eWHNHrCrNVcV
         eDlooqsVPv990JymmDDW7ZGVcnQTMjwEzLSdFdYHugHLDjxsKuD+5ZpC+q4ZiZ0mlYBy
         TWIorBs27Gy7ECdqa7Nto7RTuY+nlhouyTwoCjjhrGSXNTDUv3+xyrETr6OiBP6rJ8KS
         4+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kKFISMF8y3UineE1SH2S8n91CZBFI7ucs7QvcNIP1eo=;
        b=RZwCRi0Z6H7XsX97paA44wqkxL/rkbBjWFaWz6a885RuJtpVRzOKf/qJpzDnntB9sW
         Xx9za+FHUhnhuiYOts8tiEPgpqPoZC6HMJuE1b+ZVWi/S4Rov66yPGEGW7t+35rTqNcm
         g6SQ+Q8rW28k+cOuiez4lUGGhOQ1mtycpy99KTT4l9rdLIc+hIyDcEst53aoV5xQ0U3C
         z6u7xnbAKks4DTsyYzfbaPMz3AuLieHP49kKRljSyP29p5UUhB5gjmG1XMR7Kfdgg5lP
         w8wDR3RVxsMcPcZEeTgeoMRJ2vDGsQ8gzRzLchVbFFjZRU5F33/1TbHvBsu+cYSxCu4z
         CLPQ==
X-Gm-Message-State: ACrzQf3SrJ31Y4JF41EISfEIW4M6Ejq4r2H2A6xQ3A7ElwJW4EYhB8jc
        Mau0FAQfIG74kKRuLczP+qXwmg==
X-Google-Smtp-Source: AMsMyM6ipv9MuqOqf/u98HYXMaP1pTXWs7eWPOXMmYQPczfjPw+3vk7F6iQPuzMNWBgDKUi/WpGhVA==
X-Received: by 2002:a17:90b:388c:b0:202:a29d:6e6f with SMTP id mu12-20020a17090b388c00b00202a29d6e6fmr25587905pjb.231.1664204091215;
        Mon, 26 Sep 2022 07:54:51 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00172e19c2fa9sm11413162plg.9.2022.09.26.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:54:50 -0700 (PDT)
Date:   Mon, 26 Sep 2022 22:54:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix segmentation fault in
 record__read_lost_samples()
Message-ID: <YzG9Mz8t6aNn1ZwX@leoy-huanghe.lan>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
 <YzGiMdIRRE8ibCiD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzGiMdIRRE8ibCiD@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 01:59:29PM +0100, Arnaldo Carvalho de Melo wrote:

[...]

> > > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Thanks for the fix and sorry for the inconvenience.
> > Actually I sent the same fix a few weeks ago.
> > 
> > https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org
> 
> collecting it now, and adding that Fixes from Leo's patch, ok?

Yeah, I think it's good to add Fixes tag.  Just remind, actually
Namhyung has mentioned Fixed tag in above link:

"I didn't add a Fixes tag as it's not sent to Linus yet. But in case you want it.

  Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
"

Thanks,
Leo
