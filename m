Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E31615BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKBFh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKBFhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:37:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539ED63E2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:37:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j12so15571336plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqop9bFq4X+7EEZsaLdz6NMp5hBj6ltud7ohZ8tsg/c=;
        b=g3oAGRBhy4zV/+aMWPwq9VXoNC7cP9h9qVE4qBLjD+3NS7GRkGz5FrTmIqNcAzY7zc
         4IMxosno3yAK9C73eKUhBaphssSlKUJhPzgJys2nw/xsY9+9ejhTTOcncA9J+v0/ukw/
         MGgNDTinvmL5qzXi7pAgaykmC1iOtnZ/SSSoKECSXRAJbFq95kjrowWflh2G7RH+3HOR
         mVcBxPXm8E01LUwJ09OXZq9DfNONLPW3phLJ7NwYLaW2r221cXIB8pdx+hlNVgcbPSXa
         1fu3CpzvpSar8joeUuYl7cVs29Vg+lENpkxaRNJwMMz+lCjVABZakp0CMM+qs4hVLVVk
         REkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqop9bFq4X+7EEZsaLdz6NMp5hBj6ltud7ohZ8tsg/c=;
        b=z+EBwluaLVV/IL8MLSKv/aN8eglrl0de9rQNMPx75UHEjWzVC1c6EKUzW8weQdjek2
         0kFPYwrVfIHtOMEFPCdM6Go7ZkkRMGnsbSPbm2O5W02bJ1I+4+4C0sagT52l6bktbrn9
         UV2lZxk9+6sISyasgSGv/T1W0vlFW5XC2t0aiLGvZQ3Hvzrv0JQ74Q3jc9vFnBP25nwi
         oTV8QridV4FN5lyeQZYxbWuQKdtGesepPINrV0RHkZScaoqlFcPDfV6kqLw5oa+9nea2
         KTrUTEVI94kcZONT6PtNJx1oj1K1LKXWEjZfJNmSzmOjYux/SyPGaNcIDL3/i1xu98O6
         TSzw==
X-Gm-Message-State: ACrzQf06Ojr5WOVzsifkCawUaereen1uAbeVKutwYASutMujMywFZSfH
        GplIljqa+6GLg9ajUAldSSJFwg==
X-Google-Smtp-Source: AMsMyM4R/OuXIAegcMHeQp65UbHlOBt/uVdkUBh4+GKJeepib2DNmvB0Hj4flrqj25QOs55d4qS+8A==
X-Received: by 2002:a17:90a:c38a:b0:213:119e:ebce with SMTP id h10-20020a17090ac38a00b00213119eebcemr24165138pjt.159.1667367467841;
        Tue, 01 Nov 2022 22:37:47 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a748700b00212d4c50647sm500218pjk.36.2022.11.01.22.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:37:47 -0700 (PDT)
Date:   Wed, 2 Nov 2022 11:07:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] cpufreq: Generalize
 of_perf_domain_get_sharing_cpumask phandle format
Message-ID: <20221102053744.jq7dug6oyalu6uhj@vireshk-i7>
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024043925.25379-4-marcan@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-10-22, 13:39, Hector Martin wrote:
> of_perf_domain_get_sharing_cpumask currently assumes a 1-argument
> phandle format, and directly returns the argument. Generalize this to
> return the full of_phandle_args, so it can be used by drivers which use
> other phandle styles (e.g. separate nodes). This also requires changing
> the CPU sharing match to compare the full args structure.
> 
> Also, make sure to of_node_put(args.np) (the original code was leaking a
> reference).
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 14 +++++++++-----
>  include/linux/cpufreq.h               | 28 +++++++++++++++------------
>  2 files changed, 25 insertions(+), 17 deletions(-)

Applied. Thanks.

-- 
viresh
