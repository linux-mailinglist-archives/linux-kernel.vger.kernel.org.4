Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94F6BF8D3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCRIEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCRIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:04:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573BC8898
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:03:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41FFD1FE51;
        Sat, 18 Mar 2023 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679126623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXvcZJ9gcO/Gy66DNQ9ErC3M6Vf4j6rmw8rucTPwz/k=;
        b=MmHb31MIdModKA5DHpShfuWrNKRWubjzSBPL4LnqH7XqLYdp9x4OScRGSl8yyr82uvLaUg
        i+qrF3WTifnW00av4PpDPAJCbygGp4sU1PhKv3YzSy7GYfAzxX8SbDxgYeNxlydn7hgvfH
        /sQpPcx/cnOp0WeBT7g3/OFckqcyy9Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A94F13A00;
        Sat, 18 Mar 2023 08:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g3xTBV9wFWRqOQAAMHmgww
        (envelope-from <mhocko@suse.com>); Sat, 18 Mar 2023 08:03:43 +0000
Date:   Sat, 18 Mar 2023 09:03:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Leonardo Bras <leobras@redhat.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] memcg: do not drain charge pcp caches on remote
 isolated cpus
Message-ID: <ZBVwXgaaF2r/v8At@dhcp22.suse.cz>
References: <20230317134448.11082-3-mhocko@kernel.org>
 <202303180617.7E3aIlHf-lkp@intel.com>
 <20230317163229.51431ba28ba82c70eaa55d81@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317163229.51431ba28ba82c70eaa55d81@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-03-23 16:32:29, Andrew Morton wrote:
> On Sat, 18 Mar 2023 06:22:40 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> >    mm/memcontrol.c: In function 'drain_all_stock':
> > >> mm/memcontrol.c:2369:35: error: implicit declaration of function 'cpu_is_isolated' [-Werror=implicit-function-declaration]
> >     2369 |                         else if (!cpu_is_isolated(cpu))
> >          |                                   ^~~~~~~~~~~~~~~
> 
> Thanks.
> 
> --- a/mm/memcontrol.c~memcg-do-not-drain-charge-pcp-caches-on-remote-isolated-cpus-fix
> +++ a/mm/memcontrol.c
> @@ -63,6 +63,7 @@
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
>  #include <linux/seq_buf.h>
> +#include <linux/sched/isolation.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>

Thanks a lot Andrew!
> _

-- 
Michal Hocko
SUSE Labs
