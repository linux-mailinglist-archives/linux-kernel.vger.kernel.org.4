Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519BC61505E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKARQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKARQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:16:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA336358
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:15:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gw22so896211pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RX4xzZ+ZS1XzIPjQGu76TBFL1oLPQqm0GGT/7lwwNk=;
        b=CfQYbO2XcQYTIBqqHWVcDSlWzGkOF+pA/awkac95JhmVeZnAwuLGDYm4hRMEFgO4Mu
         P1lcp0nnzddNd/16ztZQ6XGfGXv8SMPdJ2y54UZH4v6Mt4DnRH+wx0jkrpyHs3+N50K1
         RwAB4tAmlQN8wAlzoCWEeCMcSy+Q8CMTxsI3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RX4xzZ+ZS1XzIPjQGu76TBFL1oLPQqm0GGT/7lwwNk=;
        b=VepMtfYlPAfD6WvP/VTtpg79TJSLXRcEAQaoxUHUXlJ8QToh4N63Tr2GLV30aP2Xaq
         B9qyj4fE9vJW+zBKfB5xosS5W0q+uhuKWcpEw5krx5kpEJcMbrNEk5Y6qNLrR1hpeQl4
         ATDxsJXK++CaAIQf6N2yIkslxC++1aumwZOFPKC5bIRzypZzJE4jNQMr74rOC9+dssKW
         S/nQBzzd/tweY1PQZOEIkOYZiArRMq2fik6QgrCTcMvUBrmWgEpXNG7J+Ns5PalSgr0W
         uLqQuDsB5yV/hTUeew4HVG3vNWXxbAQ4gwtlo0VJ0AVvT8X05sX9EWMFyo8xBe7b7z4C
         ECpw==
X-Gm-Message-State: ACrzQf2EZ2cTMhJDXOt9LN1d9+zo4CnqqNOuh2MQp0nNGkStb1iZcFFf
        mKDzbVL1NHabay9QtkmnBUoDIg==
X-Google-Smtp-Source: AMsMyM58fyxdnpL447tR6e947sOuZc70DvaZmHDir1HHTRUYdrq81zgSXsRo4ceaLysD6zxQYaXXLQ==
X-Received: by 2002:a17:902:f809:b0:186:e8c3:bb45 with SMTP id ix9-20020a170902f80900b00186e8c3bb45mr3676558plb.150.1667322946401;
        Tue, 01 Nov 2022 10:15:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12-20020aa794ac000000b0056bee23a80bsm6764429pfl.137.2022.11.01.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:15:45 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:15:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Message-ID: <202211011014.02F2559@keescook>
References: <20221028154823.you.615-kees@kernel.org>
 <20221031105514.GB69385@mutt>
 <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c4bd6e-09d3-efce-43a5-5a99be8bc96b@suse.cz>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:00:25PM +0100, Vlastimil Babka wrote:
> From a4a5a40852723dfadb2429bee1d5e1f9d3b75f39 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 31 Oct 2022 15:55:47 +0100
> Subject: [PATCH] mempool: Do not use ksize() for poisoning-fix
> 
> For slab mempools (not kmalloc), pool_data is not object size, but a
> kmem_cache pointer; we need to extract the size via kmem_cache_size().
> 
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Link: https://lore.kernel.org/all/20221031105514.GB69385@mutt/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202210312110.1fe5d224-oliver.sang@intel.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks again for fixing this. I don't see it in -next yet? Should I
resend this directly, or how would be best to land it?

-Kees

-- 
Kees Cook
