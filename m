Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCC6F02AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbjD0Ijh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbjD0Ijc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:39:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02A4C39
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:39:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 057BE1FDE6;
        Thu, 27 Apr 2023 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682584770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMrvZyqM9F6NwS2j3x4LD6uk7Z1GCte7sBQp3tSyrI0=;
        b=X353LtqfV+6pqSyB966vqMy9+ztle3Z/pqW67hkJRs/EoH5ZR0mfDLsDhPOngvMQURlcG6
        vCrV3rrt7OVsXzGXuO+nEKNZxlYWJRbJ5bstwD5oXZDa9hsSE7KNAUcyGxlvI8faB7XUcA
        amefGyok16OH+ZV2mZvvAX9AtVY4Pos=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6665138F9;
        Thu, 27 Apr 2023 08:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gKb/NcE0SmTpWAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 27 Apr 2023 08:39:29 +0000
Date:   Thu, 27 Apr 2023 10:39:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
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
Message-ID: <ZEo0wctuNFBzaxoJ@dhcp22.suse.cz>
References: <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
 <ZEFB8FSKWms2VmaL@tpad>
 <44f2df1a-ace4-0c44-166f-4f2fef49e0c1@suse.cz>
 <ZElNDltcv4PA0HsM@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZElNDltcv4PA0HsM@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-04-23 13:10:54, Marcelo Tosatti wrote:
[...]
> "To test the performance difference, a page allocator microbenchmark:
> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c
> with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.
> 
> For the single_page_alloc_free test, which does
> 
>        	/** Loop to measure **/
>        	for (i = 0; i < rec->loops; i++) {
>                	my_page = alloc_page(gfp_mask);
>                 if (unlikely(my_page == NULL))
>                        	return 0;
>                 __free_page(my_page);
>         }                                                                                                           
> 
> Unit is cycles.
> 
> Vanilla                 Patched         Diff
> 115.25                  117             1.4%"
> 
> To be honest, that 1.4% difference was not stable but fluctuated between
> positive and negative percentages (so the performance difference was in
> the noise).
> 
> So performance is not a decisive factor in this case.

It is not neglible considering that majority worklods will not benefit
from this change. You are clearly ignoring that vmstat code has been
highly optimized for local per-cpu access exactly to avoid locked
operations and cache line bouncing.
-- 
Michal Hocko
SUSE Labs
