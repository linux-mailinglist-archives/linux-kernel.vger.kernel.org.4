Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1395EACA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIZQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIZQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:34:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDAD1231D2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:22:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 4so656070ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qvRaYPYKDxzCfmvXG/5tfegDFwEt8aN7PLvlIvfXAQ8=;
        b=pStoVQWt8z1fKG46RrHzQ+sN31TSBbQ26LClitIomuBqoK2WB2xkeSUXpBiR/tZFPS
         ZDpUvIXb30o3RRyb586qMCs2Q+aQOJw7lbbI6PS44mBomAbcgUfLoksOaDJugCE7d+Kh
         DJYfs/0c/Ga9st0WzAfZIJFu4DF8IqUh15usUbL1dCXM2QiqHXk8ojNAhIy5vYeVGAcF
         yiAG1h4zC7pp6bxc3yAE+/mbXNSEvVQWLVZHPvCy8R6DPk46I2RwzMxgozOy7irYGciQ
         vBmUqB6XipPTnYgWdmuHwBVqqKSrEp2B6W5q06iRFMxMW6q+JcdP8i1p4vXqTZFiSo0p
         sU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qvRaYPYKDxzCfmvXG/5tfegDFwEt8aN7PLvlIvfXAQ8=;
        b=Qqg2BDmEBryey9mU7rGxRO3KRWkSUP5hcKvQSmms85oexjR/pMSqDUv7XXxYR3yHGJ
         eyuqBsXdYmry4YYOCM1ZdB0TFV7tb55GarG5nUx2VmelqV1qpD3vjwFCqQQM77Pix/0q
         ynZ3JRu1O6uduyDFY+B5psfVTB2GBDSRYiskb7t/RpC+giphs/oApmpdaE/xv7TOb77A
         sjfuX9yVJL2BrroWZUUITRumbxTjdlR4TuJDTUJ92Pej6dUHdllfAK48jKFX+SuzLCMC
         u8vZPlxYmrPlIEwN6Yy+faPl3MDj5airnsrP2cUaNx1rql2x1G2Gqdd3j6GI8cMbh7kd
         Gm9A==
X-Gm-Message-State: ACrzQf1dqRGaQ3PJhnU8LwV07TrG1/wFT/D5sEDscOBHVGbNdb3bWqmT
        svzTQNMGytzzN7uU8R+befYir6gtqJURAC0bjYWhdA==
X-Google-Smtp-Source: AMsMyM5Lp73sHyFKfLjMTs/m+By3tCw/fxlEkA5yb+z+FfL3c5aa+8/pB0jwke64blltc+ac6ZWSOAVc+uIJ2LribaE=
X-Received: by 2002:a25:9d83:0:b0:68f:a551:ec71 with SMTP id
 v3-20020a259d83000000b0068fa551ec71mr21591820ybp.212.1664205747529; Mon, 26
 Sep 2022 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220926135704.400818-1-hannes@cmpxchg.org> <20220926135704.400818-5-hannes@cmpxchg.org>
In-Reply-To: <20220926135704.400818-5-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Sep 2022 08:22:16 -0700
Message-ID: <CALvZod573J7wJgvvWMHnyL39b7S0TD7fbs2fohvRmSCHUanCqA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: memcontrol: drop dead CONFIG_MEMCG_SWAP config symbol
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 6:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Since 2d1c498072de ("mm: memcontrol: make swap tracking an integral
> part of memory control"), CONFIG_MEMCG_SWAP hasn't been a user-visible
> config option anymore, it just means CONFIG_MEMCG && CONFIG_SWAP.
>
> Update the sites accordingly and drop the symbol.
>
> [ While touching the docs, remove two references to CONFIG_MEMCG_KMEM,
>   which hasn't been a user-visible symbol for over half a decade. ]
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
