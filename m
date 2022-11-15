Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA2628EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiKOArQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiKOArN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:47:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3E1D324
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:47:12 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id j12so11689353plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4E776DpX0wTKCI3TLDV4yOHj0J735rhp+IkszbZ/MY=;
        b=mrdRFzEsY9YBXYTxUDDgLoZgCJJvgN4FGzcb9hSocsa6IAryE5Y2FPNsit0tVRbvF5
         FSzZp5BRgBeh8yXm/FBdFsv1HAzukEZFPhR49dV0zw8w+BK0YYfpC4jE4nd7z+SEfvhy
         YSZ8aKDJoaltzO3r1+Z+go6uM5CdADWKjdYMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4E776DpX0wTKCI3TLDV4yOHj0J735rhp+IkszbZ/MY=;
        b=dVlB3ARzmk+YSbvC2oRNq34j4lM4+19DU/uRmfq2qRW6IVvUg6sPmARBEkQiokeGju
         hGeTu3p9ZlTKJk79gOG20qAYCXDvHYYQtBdb5WCe3yODZsbbmY/dCUFOtwxPwZleNfMD
         aBo2XeBMfvGQHj279Hgp1MMX7TI/iqFB9EWSeNSyCdpHWmDFKjo3wS0cj1sNXq+k+hdP
         nJ+jHLhsvy0SicjwHD9far3o0GC5bzKeMR2l09pZjuBMBqjSvgUTYyN4nY08SYBMMQsq
         BtSaBHWt8hYTUKFOAgoeNtlDOvgjz3Jabbc39QRiWzkt94AGzHM/OAIHHTz9XUfj8r8j
         vy3Q==
X-Gm-Message-State: ANoB5plwTV5CiNkSPwm73pFCbknQAzJhlAquI1f71JXGRctdYDQJCasG
        uOlleQYYrNN8ebTKhHav1sylSw==
X-Google-Smtp-Source: AA0mqf6vHTVyItSWJ1wYm5TuZk7m1iytf1d5Mce00t/Mfag+LscwaIlRwnFRTD5F8ozzDjRbr08mXg==
X-Received: by 2002:a17:902:aa47:b0:186:61c8:c512 with SMTP id c7-20020a170902aa4700b0018661c8c512mr1598724plr.155.1668473232412;
        Mon, 14 Nov 2022 16:47:12 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:3d10:c2ca:ba5b:55e6])
        by smtp.gmail.com with ESMTPSA id e12-20020a63544c000000b0047048c201e3sm1009186pgm.33.2022.11.14.16.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:47:11 -0800 (PST)
Date:   Tue, 15 Nov 2022 09:47:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] zram: explicitly limit prio_max for static analyzers
Message-ID: <Y3Lhi74Z1t2W+Jfw@google.com>
References: <20221109115047.2921851-5-senozhatsky@chromium.org>
 <20221114021420.4060601-1-senozhatsky@chromium.org>
 <20221114164130.e45a95db4e8be2c3909bdba1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114164130.e45a95db4e8be2c3909bdba1@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/14 16:41), Andrew Morton wrote:
> >  drivers/block/zram/zram_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 9d33801e8ba8..e67a124f2e88 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1706,6 +1706,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
> >  	 * Iterate the secondary comp algorithms list (in order of priority)
> >  	 * and try to recompress the page.
> >  	 */
> > +	prio_max = min(prio_max, ZRAM_MAX_COMPS);
> >  	for (; prio < prio_max; prio++) {
> >  		if (!zram->comps[prio])
> >  			continue;
> 
> I'll queue this as a fix to "zram: introduce recompress sysfs knob".
> 
> What's it do?  A little changelog would be nice, or at least a link to
> the coverity report?

It doesn't do much, coverity (static analyzer?) got confused by
the code, so this simply is supposed to help coverity figure out
that we never do an out of bounds access in comps[] array:
https://lore.kernel.org/lkml/202211100847.388C61B3@keescook/
