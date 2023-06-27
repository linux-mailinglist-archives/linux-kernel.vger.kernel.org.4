Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDED73F3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjF0Fcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjF0Fcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:32:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104D1734
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:32:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso8757245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687843962; x=1690435962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooF2+9s/dYxk4t4QZ6dr9+cLdLfWELP5XjTCQq5ybIM=;
        b=iPNim+rvo2A1bn4dMUpbF1e0wz6EHmQxUGg3fxS/+RmnfHG3J5BVlUWPudJHtH2vP8
         YjqFyw/UGGt17s8u9TU6IQq+4HFYI8r7SpVepLLM6d6YG52UjNvRTbzcVS2qqSO/bvoO
         kIzZ7bdb6MFPTOU2pgG3yd7iuvPxsPb6+zzjYIpoRDyrASAGY+jKEVnnnOzw76GM0/ch
         Dtjy7JhZd8qqO/3fS5uJ3uDAxkmyI/nNc7aOg12onfRM6yluoX3USBNrkmwxUsGEaLxU
         b9/6zfoWKBsZMdvTrB3nXg8UNo7575e2HYb4IY2h9B47hfUhESpgAA6/DmUh/Ti7xu6Y
         rahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687843962; x=1690435962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooF2+9s/dYxk4t4QZ6dr9+cLdLfWELP5XjTCQq5ybIM=;
        b=I9+JpjEeQIznwZMRf6M8R/LleiIItGYCxJJeiwIrAHquxbJu2Yc4nGBfWz0dr+H+xc
         i5J7A24Lbfs0TxxPCoWqvVFpzma2SK2aScoqhkKyqQPv3oRKlY/BtEQe0/fLO5sxkFmZ
         VNTtUFryl5NYvSyDaMxTzwD8QrKFrzmuuX850OfkeRgjxV4Rn8QYZGKOsGuMtx+y1XZq
         wXnmUl2N8aUKes4M7L2XinGLs/z5TPHj00pNKmNnyk0qYtdBZ+8dmbA4rm0DI7ECLKJU
         MXn38pyb+VzyVbJFcV3I0AjgYiWxSvG1CwtM8iw2cqR1K6YZXJSQ1s9TLKszDhs+03cM
         eHBQ==
X-Gm-Message-State: AC+VfDx0S1bPtGbfZ/zuS9ZHStfFdUW6BcnSPxg0UfpaBoPdoDh9Qqec
        wY4WZLtE0+qbsRl3I8fksXYqeg==
X-Google-Smtp-Source: ACHHUZ7/KMGanhWpS4V6XigbARqv+ptaFhhnRebXUfv/XgANDJmcyk+nRrK/8gABHNSsbrCfv0MRJg==
X-Received: by 2002:a05:600c:3657:b0:3f6:8ba:6ea2 with SMTP id y23-20020a05600c365700b003f608ba6ea2mr28557361wmq.15.1687843962270;
        Mon, 26 Jun 2023 22:32:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x26-20020a1c7c1a000000b003fa740ef99esm9405573wmc.45.2023.06.26.22.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:32:39 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:32:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH v2] perf unwind: Fix map reference counts
Message-ID: <a9732501-3eff-4b94-a9b2-53e5e5e5be1d@kadam.mountain>
References: <20230623043107.4077510-1-irogers@google.com>
 <64741e8e-e81a-afb9-9ce3-9c2d6baab44a@web.de>
 <CAP-5=fVwhiGJEqTST2bfX8cUALpnTxELSHrvKtyJEPjqQjOacQ@mail.gmail.com>
 <35569055-0873-4d5d-8c9c-78c818e9aa26@moroto.mountain>
 <CAP-5=fWDnLDox3apMmvXmzVurFA=+sj7SEOOD7_2fam2VrGokA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWDnLDox3apMmvXmzVurFA=+sj7SEOOD7_2fam2VrGokA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, great.  Thanks, Ian.

The Reference Count Checking page is good information.  There is a bunch
of interest in doing better QC so this stuff is good to know.

So in this case, it's probably difficult to assign a Fixes tag and that's
fine.  Whatever.  But I'm not a huge fan of the "Leave off the Fixes tag"
approach to preventing backports.  There should be a better system for
that.  Maybe there should be a tag for that?  Or possibly that's too
complicated...  I'm not sure.

Anyway, let's leave it for now.  If it's really a problem then we'll run
into it again later and we can think about it at that point.

regards,
dan carpenter
