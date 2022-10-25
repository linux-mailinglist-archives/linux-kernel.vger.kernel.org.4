Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447FC60D5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiJYUnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJYUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:43:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4BF10AC2E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:43:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a18so9101042qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub0BSMQoXwxgMbCEulstR2TYu+9kYjLpcZILAjgqG30=;
        b=VeEO2vjrQ0ESCZCTGDSoSw4KEGYai2RbrNxNuSJSbH7Wg6g1MrSYPkBaDNeAr3eCfb
         F2VAyCJ2YtPJI00XidiYHZM9FvhW5nYm8DaSOnhf+yXpp/pa8t4qPREUf+5HhNE4ThLz
         K91Op+1qbhqIJn+nKRLMQtyNg2vi5BCpT3o1y5/Z6RoLT39vhcPMeOUMWXWDObMMJBfJ
         DPRNrzHsRnR6GW+DRHUbyEgwvosgc31S3Oy7ss3bkOw4Y9ZvJe72aZBpUYmCUeCEq6Uc
         RnCWPGgSEbUTwpsVeRnancGf3un+CfvGgB8Dt+e7L9z4MhLkeaVSXze/WbCEExoZWeO5
         BP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub0BSMQoXwxgMbCEulstR2TYu+9kYjLpcZILAjgqG30=;
        b=Sz7QMerkieiZQaXXrmsSdTJcpEJDPI3gl0fQNzYFwQx8XwsyUyVlUNp4gke3fmptSo
         LKAtHC++qrMNHK8uo9VlfA9IrTBqqi9oGxr64t27SqU4PGxC+aZCX2Nz+UVykGjsVw5j
         ue1d1CzdemQRrm+6venAKHrpGpqPd2X2fmiOe9cVHH8tV/q1pHg7T3l7YjvrPMwRCkRs
         jvaqIArBBixffucQ05iuXe2b2aA64KLgztnQ5GyFB8TI45U4apXiSnWBpJd51xjby57n
         0VGX9/qNNcRalAmyN3MYTxvdlZjgzRge3Fo/Goguon2LmlsULW69npfZ9c1DLFlTi9Gx
         R2NA==
X-Gm-Message-State: ACrzQf0xaruKOLb0GoeaQnAwxJxrznDR4Cf8qN6iv2q9ODGKlbd1NODN
        T59QcjFtq8OcyiDkel52w6bIoZGsMKL8Ng==
X-Google-Smtp-Source: AMsMyM7a+tSlftH8MJH8oaBF7rMoToaHIRy3kKzxKarkYUrXhwcfTv5RoobFHvNn42sFhROGPOCGJA==
X-Received: by 2002:a05:620a:2995:b0:6ee:e3a0:9fb8 with SMTP id r21-20020a05620a299500b006eee3a09fb8mr28133725qkp.165.1666730600690;
        Tue, 25 Oct 2022 13:43:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id f2-20020a05620a12e200b006eeb185c209sm2580743qkl.50.2022.10.25.13.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:43:20 -0700 (PDT)
Date:   Tue, 25 Oct 2022 16:43:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1hKaHmzVJ1cJPyn@cmpxchg.org>
References: <20221025170519.314511-1-hannes@cmpxchg.org>
 <Y1gaBXp+IENVIU7z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1gaBXp+IENVIU7z@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 06:16:53PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 25, 2022 at 01:05:19PM -0400, Johannes Weiner wrote:
> > +static int reclaimer_offset(void)
> > +{
> > +	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD != 1);
> > +	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD != 2);
> > +	BUILD_BUG_ON(PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD != 1);
> > +	BUILD_BUG_ON(PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD != 2);
> > +	BUILD_BUG_ON(PGSCAN_DIRECT - PGSCAN_KSWAPD != 1);
> > +	BUILD_BUG_ON(PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD != 2);
> > +
> > +	if (current_is_kswapd())
> > +		return 0;
> > +	if (current_is_khugepaged())
> > +		return 2;
> > +	return 1;
> > +}
> 
> Would this be simpler as ...
> 
> 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
> 			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
> 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
> 			PGSCAN_DIRECT - PGSCAN_KSWAPD);
> 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
> 			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
> 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
> 			PGSCAN_KHUGEPAGED - PGDEMOTE_KSWAPD);
> 
> 	if (current_is_kswapd())
> 		return 0;
> 	if (current_is_khugepaged())
> 		return PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD;
> 	return PGSTEAL_DIRECT - PGSTEAL_KSWAPD;
> 
> Not that I think we'd ever want to separate them, but it is perhaps a
> bit less magic?

Yeah that looks better. I'll do that in v2, thanks!
