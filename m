Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEED652C28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiLUEsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLUEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:48:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF4617E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:48:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so997945pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNVq9wYnva/HPW3ThTI1Fu0L0uIDsvRYyulYsvw3yMw=;
        b=N46ClaEkZ5LdphwXlH2yEBShRVSJpXNciwMMS6UVV2V+NVN6hIY+SufeELGHmaDGyN
         C20fTIWM+vH6ZiG0kBqaqj93CmgognrVh3s0J4NdVoHHAx6kfH0XjugTgzoPwcwfuOru
         rviZoIIDtRlKxXfALdi7m/bAH8wDP+8txlEST8mXx7YRsDjBArmlzczB4oh1HwQOQRwb
         nfOT5fVrj/Jzl+5xumQjfv1+gLm561elFy7YDwFozQoLiIlUSayMkekUsbEd6nfIjk1p
         pQ7nW7Zktmy6rQH11WnZdpTSXuWWm+t3IRAdcP6VdnZagHNmXlMzgRnArKUorxw7d4MN
         i+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNVq9wYnva/HPW3ThTI1Fu0L0uIDsvRYyulYsvw3yMw=;
        b=unPQhvrRzKZiSFiisKHDhXsLg/UpsWevwdAyke350Z7Vhc6rGVqj+N0y9K3xk/+vwT
         hn8hpXF5z7TOYNh7/AjsDOeBh1gXeFxhyW0c8tnhCH1kUCF7Oi7MegO4a5a7/1UNsSpk
         wjiU7211lEA43hSOBubECC0ii00PpBeUy6HgbHD6vw6B0USzOeRcUXhkaBP41XYFi98D
         0bXUFZ7oYf2fFqtVTKf4f5QjCiV/i9Q+8LjA8d4MgHdGWf8lzu0sjLM5pckLqrAEepOV
         pfgS8lADbP+k2+aFlI6hpIJEUXFaNyvQYOJPeU2gbZDBk+E0yM5zGlTHlhr5KMzhOkXz
         mVZQ==
X-Gm-Message-State: AFqh2kqHFvpkYUuws90VrgOP8AaDYdgPvpT5fcTdrcxsmIiUWUZklJ4N
        QmD95NBq9dbg93m+PaLxvRj4oA==
X-Google-Smtp-Source: AMrXdXupM0KGFiZrNN7WUHbgR7SQIZup0DNgaE244EV3PgALNtrv+r8+DYIoQZi948KC4j2rzYH3fw==
X-Received: by 2002:a17:902:ee13:b0:187:c49:5a1a with SMTP id z19-20020a170902ee1300b001870c495a1amr697497plb.17.1671598129213;
        Tue, 20 Dec 2022 20:48:49 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b00189348ab156sm10215121plg.283.2022.12.20.20.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:48:48 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:18:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, james.clark@arm.com,
        Ionela.Voinescu@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: Add u64 casts to avoid overflowing
Message-ID: <20221221044833.ebh2timtn7uluqpm@vireshk-i7>
References: <20221220101225.3190672-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220101225.3190672-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-22, 11:12, Pierre Gondois wrote:
> The fields of the _CPC object are unsigned 32-bits values.
> To avoid overflows while using _CPC's values, add 'u64' casts.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh
