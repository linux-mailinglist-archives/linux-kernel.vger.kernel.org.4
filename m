Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745C062FE86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKRUEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKRUEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:04:43 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2C2A3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:04:41 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id p8so3418305qvn.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnH+UGx6+sixESVz7YWSOh6Sim/QTDifgTL6tzstjgA=;
        b=DRWPND7gokcVicYVOXrukH04arSMoUahVZMMvUuh/RZt1CvnZFSwMWfFrl1QuagkEO
         4IjO4oIV1BjTQCV0spRV/0O4t4cHZRBC4h6d0t77WIEXWlzt/p6E7fmbLczkx83ORg+3
         9dx+ArTvBbihStU79hog4sLh8bQ5/lblrBt+E8qj9ExOS8QaFauZF7UeflI4msz+RuTE
         Z7DGKxt3qghkgGm+EznYjml/czTKqLXhCS0pnS/7dNxVWEYAoXqjglKdSOoY4RME3egL
         NbO6T82tPvXEWS+KmDaKV7mpwcfeer+q6zPQNk6ss8XwL9UaRnIdC/nkeyJA7zB8/NbP
         85fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnH+UGx6+sixESVz7YWSOh6Sim/QTDifgTL6tzstjgA=;
        b=nleQ43SD9vVGKglcgDMleusxmEq7gkZs0MZMUuTeYtF9iYbygCWnNOHN8Qu8nofY24
         Ez9iNoVDWCOS4KPV5OsWL8Xcz+S6KgjczLNqaEJIEx3BBARJ7c7Unhet5G16I/uqnDzo
         QzdqaQ6lOqbO+8tid0sx8251oSJLWMkj2Um1sA4pEh6aWmHkqWLhR45eGQAi6d/CwJQM
         +40l80U2e59iCwIsM25TxnPA80yQcaITRyfgxKvwXi4CoS4diI94ix7JdAYh2KeM7614
         yq/t87yaZyAsUIgV3bb7rkU1opV1JrypryoBK1afI084Len5BReiejAuj0lPq61WggIG
         ZEgA==
X-Gm-Message-State: ANoB5pn3oaKHVHn1WFlZqX6czJ39ZrgPkgD82+S06GnwmXUoU9qd012z
        jGsiWDtez0fotyqgGcRL1ePwkg==
X-Google-Smtp-Source: AA0mqf53XtBWr5U1zPbvI6iymbL1muAxR7LyTGqpMGH2buD3DhgLQS922JiRBZu4ZwalPNGfmukrLQ==
X-Received: by 2002:a05:6214:162e:b0:4c6:57f1:3514 with SMTP id e14-20020a056214162e00b004c657f13514mr8140454qvw.87.1668801880681;
        Fri, 18 Nov 2022 12:04:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id d7-20020ac86147000000b003a5c60686b0sm2564105qtm.22.2022.11.18.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:04:40 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:05:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v5 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3flcAXNxxrvy3ZH@cmpxchg.org>
References: <20221118182407.82548-1-nphamcs@gmail.com>
 <20221118182407.82548-5-nphamcs@gmail.com>
 <Y3fdsTDFgCzhcDwo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3fdsTDFgCzhcDwo@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:32:01AM -0800, Minchan Kim wrote:
> On Fri, Nov 18, 2022 at 10:24:05AM -0800, Nhat Pham wrote:
> > @@ -1444,6 +1473,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > 
> >  	/* We completely set up zspage so mark them as movable */
> >  	SetZsPageMovable(pool, zspage);
> > +out:
> > +#ifdef CONFIG_ZPOOL
> > +	/* Move the zspage to front of pool's LRU */
> > +	move_to_front(pool, zspage);
> > +#endif
> >  	spin_unlock(&pool->lock);
> 
> Please move the move_to_front into zs_map_object with ZS_MM_WO with
> comment with "why we are doing only for WO case".

I replied to the other thread, but I disagree with this request.

The WO exception would be as zswap-specific as is the
rotate-on-alloc. It doesn't make the resulting zsmalloc code any
cleaner or more generic, just weird in a slightly different way.

On the other hand, it makes zsmalloc deviate from the other backends
and introduces new callchains that invalidate thousands of machine
hours of production testing of this code.
