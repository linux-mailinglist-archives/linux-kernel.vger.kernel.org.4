Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A376F09D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbjD0Q0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjD0Q0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D6AC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682612731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q+mSfHIYwgygtxN4zqh6EGSnWzRFToL7aoBJGdpNRnc=;
        b=bdic6POI1xqLpIeipFZSoD3edhltlV9/PDgnOh5cpyl5yizszxeEI1gxVMmuWZAfDwLdhP
        y0smU0X6TCLcVquIiLSS4yGmwKN2N1uoq7GPyimzzNYgHSgdu+0hnVLuOtgoXXSCvTP1ut
        FpU/yX25scn62IWSkFR3gVRamO/LSj4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-GkWBjQSnPwanr_NMARvn3g-1; Thu, 27 Apr 2023 12:25:28 -0400
X-MC-Unique: GkWBjQSnPwanr_NMARvn3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D7AD2808E74;
        Thu, 27 Apr 2023 16:25:26 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5438F492B01;
        Thu, 27 Apr 2023 16:25:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 5E59E4038F56E; Thu, 27 Apr 2023 13:25:10 -0300 (-03)
Date:   Thu, 27 Apr 2023 13:25:10 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZEqh5qzFZFrSUja/@tpad>
References: <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
 <ZEFB8FSKWms2VmaL@tpad>
 <44f2df1a-ace4-0c44-166f-4f2fef49e0c1@suse.cz>
 <ZElNDltcv4PA0HsM@tpad>
 <ZEo0wctuNFBzaxoJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEo0wctuNFBzaxoJ@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:39:29AM +0200, Michal Hocko wrote:
> On Wed 26-04-23 13:10:54, Marcelo Tosatti wrote:
> [...]
> > "To test the performance difference, a page allocator microbenchmark:
> > https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c
> > with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.
> > 
> > For the single_page_alloc_free test, which does
> > 
> >        	/** Loop to measure **/
> >        	for (i = 0; i < rec->loops; i++) {
> >                	my_page = alloc_page(gfp_mask);
> >                 if (unlikely(my_page == NULL))
> >                        	return 0;
> >                 __free_page(my_page);
> >         }                                                                                                           
> > 
> > Unit is cycles.
> > 
> > Vanilla                 Patched         Diff
> > 115.25                  117             1.4%"
> > 
> > To be honest, that 1.4% difference was not stable but fluctuated between
> > positive and negative percentages (so the performance difference was in
> > the noise).
> > 
> > So performance is not a decisive factor in this case.
> 
> It is not neglible considering that majority worklods will not benefit
> from this change. You are clearly ignoring that vmstat code has been
> highly optimized for local per-cpu access exactly to avoid locked
> operations and cache line bouncing.
> -- 
> Michal Hocko
> SUSE Labs

Again, the values fluctuate between positive and negative
performance difference (i happen to have copied a positive value).

So the performance difference is in the noise (its not stable at 1.4%),
but rather close to 0%.

So the data is showing that there is no negative performance impact.

