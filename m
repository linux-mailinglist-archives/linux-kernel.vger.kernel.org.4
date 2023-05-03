Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272956F5A10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjECObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjECObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:31:39 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E1E9B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:31:37 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-74e462a540aso243310985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683124296; x=1685716296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7llKhBaHnkQjLetPGzkZN0ajWGNkpSrzpK5vsJeUYo=;
        b=OEysCc3Q3AKZhYWUpecGGN+q2wOXE5wiyVvtko0WaJ2fEF5TgOdqBC+UgjJaKatM4j
         Hk8gD6ZHWvzvWGN6ZFM4ZdXXiLRZOENkqMpoEcR7TPHTjgYqm+JUUNaYF1NjPwNMH+XC
         t3AiZLBPIR/LbJUbtOA2ucWvWq1mgUvx6eYpoV8xcGmUnFf21ziYRfmryIfoB7XMQNKi
         Gep/JblJp11omSrcXBKcxDuoCpyJs5GbLr6596ivDXkas4ThRVy4RSYqyknHtPUU6oSb
         NRc/LfnhjI3vv4EB+X3g5MeSp0Hg72kS2vPM993Umv9YxSm+C9Nq9lQYrxlESiIsgBuu
         SP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124296; x=1685716296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7llKhBaHnkQjLetPGzkZN0ajWGNkpSrzpK5vsJeUYo=;
        b=RUp25pOdlvthD7lgdkw6TI+wNYeIB+Oxcve8ihbiggf3LL59GJR8PsAYZ5FgKBcZ31
         PAxiKRMYSOzsgGGvzyWVTFOXPsbxApd9dldc5w7RW601VwgwI3ZF6I4ZUffZMGIfUEP3
         8B56sGEQWWHyRhNkwhpiYB2qHshdhHPym7y5c2ACSCozeuP4ykZ9c25mnvxqFtXyHkHk
         L9zFsupO9UksD/gWycccgGghqShD+65uIalO9P0Rn0IQWiK2KT0p5CvvlpC4cDD2XAME
         Tpg87iHXP0bGVuIXd1vW6ImH0HQW1+/vRQ7dwYCZpJO1E0Zb1XBpGVV0dUnME7rTGxRY
         ZN7A==
X-Gm-Message-State: AC+VfDzBeYokQFbCeVdwW1zgl6W6WBq0nBGQ2t8wprkbc8S3fyEGgpr+
        BHSoRTDivZdiO5lJ/ggDbzixFw==
X-Google-Smtp-Source: ACHHUZ52pEaTCuzSpiKuoJ9hRntF1lpl/uhp/LT3ZTmSOW5jqLwz9JWE4c/5m2w391ttcRDRN6fT2w==
X-Received: by 2002:ac8:5e50:0:b0:3ea:8224:b5b4 with SMTP id i16-20020ac85e50000000b003ea8224b5b4mr504607qtx.9.1683124295905;
        Wed, 03 May 2023 07:31:35 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d6-20020ac80606000000b003bf9f9f1844sm11116879qth.71.2023.05.03.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:31:35 -0700 (PDT)
Date:   Wed, 3 May 2023 10:31:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v13 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <20230503143134.GB193380@cmpxchg.org>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
 <20230503013608.2431726-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503013608.2431726-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 06:36:06PM -0700, Nhat Pham wrote:
> In preparation for computing recently evicted pages in cachestat,
> refactor workingset_refault and lru_gen_refault to expose a helper
> function that would test if an evicted page is recently evicted.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
