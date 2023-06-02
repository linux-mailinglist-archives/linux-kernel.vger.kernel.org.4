Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96297203AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjFBNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFBNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:47:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83031B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:47:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75affe977abso232565685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685713638; x=1688305638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Av3DwbRJheuZ35bZLaiap4GdmXYULoQEeloJpKMXRA=;
        b=lB+7zjIwoY6KGIT9tm5bVnYKdzdAo1C4ssiOCIChRgrr8odSW5Z/tAen81PEw01/Y5
         mQs7YMkamON+NEmPa2EgLf6a5zRLdxNPhkXtaOK7u9M0FOE/lCv7lKUO71TtBg0AT9kh
         B3XpS3ZJrn/T4k5UNUOCpyNIQwcS+PM+dLWoyJHzxImyxpUKpF4Dt7NC+RiTbBuHkGA7
         xK9J6HeRBomg5Fj1/NGy9ybxbmVWzDdY++3B3Sle2tIuDOAhiYiRgBgRtpUqdlZm9xw8
         rdZqCsx4iw+WQdSQw1D4OK7xvLLAoEBC3fkOZacYKSe64ZK8PH8Spu6okTgo/agLhAZN
         Hj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685713638; x=1688305638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Av3DwbRJheuZ35bZLaiap4GdmXYULoQEeloJpKMXRA=;
        b=HUzYz/eet+/lwThcI7Mbv+8mcoeyobpHvpbfGhnozSwZrJF0CknKmSO9obvV4UZmoa
         IKW+gYJW/5LA1OOokmn0cQycaJlhvKAREFOKVFJAaiSeMMQNitWLHcH63kl42bXAROpK
         12G3X9Z3iSfnuFbMgoBQqoZ6YacYDZm0/MIpB85bqdtnZy/egqHNyPeBezYIffMecqkG
         lSisL0DO4fi2enahTVKxrpd7ZtiXR/0vmM5Buq/5Ig6h479tpQ3DNRpnUzVs3rs7fQwu
         VYT3fcuE5m3XSKuSX5il6E5oYhrOPNMLAY3f9Ub8VZ+pu5UxVMULPWm8kckJB13ovVes
         hvSA==
X-Gm-Message-State: AC+VfDzDPK3eGaG6p4iCjVZC3tEuqN0MTL3LtFeMxp/8gqKnjVKsLV8+
        uPutOrHPLwPKUNwUCZGYiYlc6A==
X-Google-Smtp-Source: ACHHUZ7hwbxFTW/+twpdNVEARK5Q3unfonBSzlskRIIJIXq0QI/7YK5mzqBKnRaUWogaeq8sCgnK3w==
X-Received: by 2002:a05:620a:2014:b0:75b:23a1:3634 with SMTP id c20-20020a05620a201400b0075b23a13634mr12916394qka.69.1685713637971;
        Fri, 02 Jun 2023 06:47:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e012000000b00755951e48desm615961qkk.135.2023.06.02.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:47:17 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:47:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: zswap: do not shrink if cgroup may not zswap
Message-ID: <20230602134716.GA161817@cmpxchg.org>
References: <1cbc8768-7a94-530d-f3ba-923038e6ef12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbc8768-7a94-530d-f3ba-923038e6ef12@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 01:38:44PM +0100, Colin King (gmail) wrote:
> Hi,
> 
> static analysis with clang scan build has detected an issue in the following
> commit:
> 
> commit 6804144bf1cfa3978ad98e625d8a1d2a4b80cbee
> Author: Nhat Pham <nphamcs@gmail.com>
> Date:   Tue May 30 15:24:40 2023 -0700
> 
>     zswap: do not shrink if cgroup may not zswap
> 
> 
> The issue is as follows in function zswap_frontswap_store in mm/zswap.c:
> 
>         /*
>          * XXX: zswap reclaim does not work with cgroups yet. Without a
>          * cgroup-aware entry LRU, we will push out entries system-wide
> based on
>          * local cgroup limits.
>          */
>         objcg = get_obj_cgroup_from_page(page);
>         if (objcg && !obj_cgroup_may_zswap(objcg))
>                 goto reject;
> 
> mm/zswap.c:1210:6: warning: variable 'ret' is used uninitialized whenever
> 'if' condition is true [-Wsometimes-uninitialized]
> 
> The goto reject path ends up returning ret, however, ret at this point has
> not been initialized, so a garbage return value is being returned
> by function zswap_frontswap_store

Thanks Colin. Andrew has picked up a fixlet for this, and it should be
rectified in the next iteration:

https://lore.kernel.org/mm-commits/CAJD7tkZGYj2yiwk5qd=_bqqnxT-Zd+BtFdqRV_xHk2iX+2Rh_g@mail.gmail.com/T/#
