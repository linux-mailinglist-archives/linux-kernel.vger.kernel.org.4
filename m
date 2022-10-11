Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089305FAAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJKCyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJKCyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:54:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532A86817
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:54:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h10so11990486plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9h01mOlxpzNszygrbY3PSLVmKbNIHt3PdjiV1vSnx0=;
        b=ZjdW8+T+Y4e71mZf1sibeBNLw/z7mE7w4NcdaTKDB1CKtnqPQShw9RAW1fDmFFtN1W
         Ho5cbX8s1Uv6nKmfwUz3zeFuHr30aFJARnS/9GAqL0cSuwqXh8RC5IVM9MxT+Pc2pzko
         hw9XaY02k60i32ujEOOiUIvYuZAWvReQcHSupledK7sO/UcS8Zs3oqu/Put4yvDbYuEr
         mLcCNyhWIAZ8CLE7/binJqdcsv7qe8L2YAVl0u2mW0uRZ6Hk37JklnJjK0b9+BuLKJmY
         VJmQUTvMZ4O7l9ha4D6cbYSyIVtjlZJ3NCYabAINv31yO62jhz2upSSparefphVaxdoV
         vT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9h01mOlxpzNszygrbY3PSLVmKbNIHt3PdjiV1vSnx0=;
        b=jJpXKkAjEE3MCKzP5rhF9PFXTCsWZ6GI+b2Y79Q3iv0tJz+7jynYRlE2FanDkH79FX
         uA7KFzuzKLREiPA/aPX7Df8hAKESJ3jZOsutyKW5hHW+2afzHIj1arhIRUZJ8uLWBAFv
         XT9sJfX3yrjzPTML8rxeUWxDwCg3JauWs3hSbJlIl22i7UjOZnOCJM39sI2vdJBZDpQC
         OfLlZ4p93ZylalyJXsj+jdx1MxZIdim8CKgMksDRTGFB5tNLaEp/ckt3bD4yMJiI/aj4
         jjotxnrWRlKm9V3dFCh8HgNmapk74RSJhHnsFCMf+//Pjy3n+WKKrnCPQuz96TTX8Z2I
         WA1A==
X-Gm-Message-State: ACrzQf0MuWVl+2xhkTDmbkACn0jRDXZOuOpRmTGycGUmmMTRU4z0ol8U
        3Ccgq40RXP/CGqweWp8J2eB3iA==
X-Google-Smtp-Source: AMsMyM7YnZwwrBObgtHtb6a+5AOTs5/9arUWCvNE0jilaJdTKTjFFKZiDKU28V/+o97ZDdHSvbvEfg==
X-Received: by 2002:a17:902:8347:b0:178:6e81:35ce with SMTP id z7-20020a170902834700b001786e8135cemr21272589pln.23.1665456872597;
        Mon, 10 Oct 2022 19:54:32 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id o39-20020a17090a0a2a00b001f262f6f717sm9935137pjo.3.2022.10.10.19.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:54:31 -0700 (PDT)
Date:   Tue, 11 Oct 2022 08:24:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH V2 7/9] cpufreq: amd_pstate: add AMD Pstate EPP
 support for the MSR based processors
Message-ID: <20221011025426.xocfhvvkakdc4jzo@vireshk-i7>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-8-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010162248.348141-8-Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-22, 00:22, Perry Yuan wrote:
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);

Why isn't cpufreq_cpu_get() enough here ? cpufreq_cpu_acquire() is
special as it takes policy->rwsem as well and you shouldn't need it.

> +
> +	if (!policy)
> +		return;
> +
> +	refresh_frequency_limits(policy);
> +	cpufreq_cpu_release(policy);
> +}

-- 
viresh
