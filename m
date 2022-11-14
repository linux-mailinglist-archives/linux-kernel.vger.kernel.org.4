Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECD627639
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKNHDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiKNHD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:03:27 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF61E13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:03:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k7so9257142pll.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvfBNxVIGOH3Bp/nCBzNm/9qGi/7IhzqapsmYDeuoxU=;
        b=eHjR5DqRQ2d6kboIXotQnkplHR6lj6qZNY7QdJZg1wM7ff6AUOTy30q3iMF9JswVor
         YAMTi+LnQnzNunMS9xkgpJCct4Azvn8JYaSEX424xOASjGZY5QwV0wDDMRR5rfpIOC5r
         KMPLHHUvrYTrEfWL4ewTbJXRyKHrXOHBL3V66OB528VzmwDPmYnbMOdb5QMKeSHxSdjp
         PE+PMV2HhJssdSTiSW+1YV95hHisEdkrOitJvr6Vhpew2MDLY29pMAt/3WSXBGeePInx
         jC+IzrgeyqJtbd5mPdFoOLDbRglqtHtNZ1emhuhgpCrx5ZWS/Kkzv8xWMAlbipHm/6+F
         AQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvfBNxVIGOH3Bp/nCBzNm/9qGi/7IhzqapsmYDeuoxU=;
        b=x29ITbjHCJxjYfn0zZXOhPo+/NrbF/4Adl+YCjAvPb+X1C99Iswp2vrJ38C5Bhynjv
         qDvRpKy87mlkCol0Xs1iqkZauSRUt12yaiH/edJnWAs5r1QEF3vqLGjKdpbGVDkLbeT4
         e7q6yf2jlhss6M8TWcx07SGuya5t+BHT3I7dOJB0/PjtGV6gjwwpQ4DwuYeYoPFR9dRA
         zAlxx9jwKK4oZTdvVERwKu+9qBZrcf7puqU03+DfgKH92b6ftNGhN5W4uS+nHhugehZj
         WvH+IJyirReX+KK+u4JY4ryw35K1rslSOwQtwgEESis/Ir7aecWAMn7MMSLEQ9GtOlZt
         PccQ==
X-Gm-Message-State: ANoB5pk0axOHPjptPpwK2dAoyPQ6HSecEH4eN3uSLTcio7Mgh2hdQAPn
        mGvKyWRK7n62Hu/g6a/tSTqw8g==
X-Google-Smtp-Source: AA0mqf4kzm9a0ZulwDzo7O7QvNDBVZbnouYhbqOgpYg1p8Ab8qawbcF0CbVo0l6hdJrTRXDZt8L+PA==
X-Received: by 2002:a17:902:efc4:b0:176:a6c5:20c9 with SMTP id ja4-20020a170902efc400b00176a6c520c9mr12736074plb.57.1668409405987;
        Sun, 13 Nov 2022 23:03:25 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id x11-20020a17090a9dcb00b001faafa42a9esm5667825pjv.26.2022.11.13.23.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:03:25 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:33:23 +0530
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
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Message-ID: <20221114070323.gjwgllfd44hthwon@vireshk-i7>
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st>
 <20221102061819.dyl5ah6qffntqieh@vireshk-i7>
 <c3b88bae-f6da-4242-0b19-5e2a32b9c266@marcan.st>
 <20221114065116.zs67pkbhhgfoze52@vireshk-i7>
 <367270ad-114a-96ca-a92a-a7f54a5f3318@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367270ad-114a-96ca-a92a-a7f54a5f3318@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-22, 15:57, Hector Martin wrote:
> I don't think you understood me. We have multiple identical clusters.
> All those clusters share an OPP table but are *not* the same cpufreq
> domain. So we can have 8 CPUs which are two 4-CPU cluster using one OPP
> table.

I looked at the patch 5/5. It shows two clusters, e and p, with four CPUs in
each cluster. And as per the OPP table all the CPUs in cluster e are part of
same frequency domain, i.e. switch rate together. Same with all CPUs of cluster
p.

And I also see both the clusters have separate OPP tables.

> There is no way to express this relationship with OPP tables without
> duplicating the tables themselves.

Can you show how the DT looks in this case ? I am still not clear on what the
scenario is here :(

-- 
viresh
