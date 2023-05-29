Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28E07148F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjE2L6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2L6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:58:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692CC4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:58:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9836B21A60;
        Mon, 29 May 2023 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685361487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=99OVFMsEI+o0NXFSIbSb74d8EXInXAXOzm6QHE6Z63E=;
        b=T27v/pEsSnQqvLlJimCp61zxMgPMFPwqsebiCg1QRJeC1XfEyq40S/LK9+aOtRxtmHdrqn
        ADMvoIUSLRGZJOJzS591R/R/xaqCVLsKE72QOERIwwZ7sURPaaRA0eaTnpztbrAzA+rJKa
        f/Pq04lBsaf4xkUdUFQXnhQEFMP4BrU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 767D91332D;
        Mon, 29 May 2023 11:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tScgGk+TdGQJEQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 29 May 2023 11:58:07 +0000
Date:   Mon, 29 May 2023 13:58:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Haifeng Xu <haifeng.xu@shopee.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: remove free_area_init_memoryless_node()
Message-ID: <ZHSTTu7aNvZeIHIT@dhcp22.suse.cz>
References: <20230528045720.4835-1-haifeng.xu@shopee.com>
 <20230529090446.GK4967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529090446.GK4967@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-05-23 12:04:46, Mike Rapoport wrote:
> (added Michal)
> 
> On Sun, May 28, 2023 at 04:57:20AM +0000, Haifeng Xu wrote:
> > free_area_init_memoryless_node() is just a wrapper of
> > free_area_init_node(), remove it to clean up.
> > 
> > Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> > ---
> >  mm/mm_init.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 2d91bb52c619..93821824271a 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1752,11 +1752,6 @@ void __init setup_nr_node_ids(void)
> >  }
> >  #endif
> >  
> > -static void __init free_area_init_memoryless_node(int nid)
> > -{
> > -	free_area_init_node(nid);
> > -}
> > -
> >  /*
> >   * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
> >   * such cases we allow max_zone_pfn sorted in the descending order
> > @@ -1867,7 +1862,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> >  				panic("Cannot allocate %zuB for node %d.\n",
> >  				       sizeof(*pgdat), nid);
> >  			arch_refresh_nodedata(nid, pgdat);
> > -			free_area_init_memoryless_node(nid);
> > +			free_area_init_node(nid);
> 
> Using a dedicated free_area_init_memoryless_node() wrapper here emphasizes
> that the node has no memory, but I don't have a strong feeling about
> keeping it.

Honestly, I do not think it has any added value anymore. Some time ago
it was a list of special parameters and aliasing that made some sense at
least. Maybe that could be carved into the changelog in some form.

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> >  
> >  			/*
> >  			 * We do not want to confuse userspace by sysfs
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Michal Hocko
SUSE Labs
