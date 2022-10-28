Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FC6115B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1PTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJ1PTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:19:47 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55532DF11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:19:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i12so4274236qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGpWpYk9FObgq3Y62dYBOf425/zqj5oaH/xiIhX/NB0=;
        b=55nZPiMlGB9uq9VZeUxYDbFpBpFyDYpUXHMjc5jWIv5lCKjUYAdXN9WWieQF4qj3y5
         nSqEvglG6RNbTt/ZiBGeC/HfP49lE/bojqAXJlAHcuVRBmsEBZYm0HyIYG1RaFwYvicX
         brzk0yOd3wsqFHiOi8jdNteliOSONgcj4WjUGVfDjs2OETp9mvxeVJrdZ+52WEKbVq0m
         Eo1uXP5JxaOS9Ctl4XTt7xmbIGWI8bA3ywwnd4z86SFSUQGrE2jiw+Q91TX0YNd1Vrj1
         XnKqsmUjeqXWSqa1bTFPwVGW2bLbEiBy1Ug5TJG855XdHhxRp1geEprHclmPu8dH9Xpt
         S09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGpWpYk9FObgq3Y62dYBOf425/zqj5oaH/xiIhX/NB0=;
        b=g5GSuDQ5DrI7pD5VD/D6h5KbyFXarTAlsgm004OlSRKcHJyFdEkCItdc+7h06eLvsl
         DtCnPEooEs2ZWXIieQ+Y04MTwcdNaZxnmdbvPLKX6O3uKaJPu9hO9sCWAuI7gWwuurrO
         84yH7pvSmsoEBFg5GAbcs6MWKiobgAVKnzu2UkzYdotXz8LV1jOF9onCA7NGgSP8zFOI
         /pdDoLILXTX0XYmgBmyiJtaV4nT948O9mHIRthQ7qWKvi5OOxcplW45TZqK3kBVK7HYN
         AIt+mMLDOj7HQrpxeDFWWfyf2w/gNTM1YhlKYYfjwqqwgDoPa4mlS3Pce87VtuOjqzVC
         vs0Q==
X-Gm-Message-State: ACrzQf1nwvH17jc88Pr5g5EaQ64P3Ef8XTxOsMo9BvWhs1ZrEa4Bs716
        whh/bfNyFTxSX9jFd6xvjtNBuMjsyPNn4A==
X-Google-Smtp-Source: AMsMyM7AAPZXnYuKPvbUVgPMfVRPcx/D3RUeqDaz3SVEnbHUlt0Y4yOK2qFEhdVYq+BsUpiknYF89g==
X-Received: by 2002:a0c:e2d4:0:b0:4bb:5902:922c with SMTP id t20-20020a0ce2d4000000b004bb5902922cmr33636qvl.57.1666970382477;
        Fri, 28 Oct 2022 08:19:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id bn1-20020a05620a2ac100b006b5c061844fsm3068979qkb.49.2022.10.28.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:19:42 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:19:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y1vzD41j8zFef3Tp@cmpxchg.org>
References: <202210272158.7swYwd23-lkp@intel.com>
 <20221027182736.513530-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027182736.513530-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:27:36AM -0700, Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
