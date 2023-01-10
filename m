Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6658663FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAJMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjAJMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:10:48 -0500
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 04:07:08 PST
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045C77AC4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1673352397; bh=1lAq3hxMorwKertNBHt6kodNs2aKb8MmxSA/uvyQtjI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Q2xOroI33ZBTvLTbLZwgBXoIRIs84is0yynUPd9GoLmqA6ebjP/UR0zYS08ftSNrW
         XOnKoF5DzEnL23E+hVNwl9Vs53uU52aTtB0uMYdSP9hEGSon47b0JoRAsTz5/aaB0r
         tTIcK880hwzSR5/kxQeocCubyGDh4EtOsaav3CniPZBwWmr3c+uUqk75Xavl/8go0R
         fzN9eM+3w28PUVXRErsJHdTSiCegBrzoDYVcei18VIVh6rvT5QW+VyxGxDsXmg9tDL
         SO1uE+yGzu5YoPSmHq7NVvhUC4oh9+bO6DYBrtY0kCsmD8h37xK3QQpGlbipmV/jmy
         F1gXNMICSffMw==
Received: by gentwo.de (Postfix, from userid 1001)
        id 438A9B0021D; Tue, 10 Jan 2023 13:06:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 41B09B00136;
        Tue, 10 Jan 2023 13:06:37 +0100 (CET)
Date:   Tue, 10 Jan 2023 13:06:37 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     atomlin@atomlin.com, frederic@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific
 vmstat discrepancies
In-Reply-To: <20230105125248.813825852@redhat.com>
Message-ID: <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de>
References: <20230105125218.031928326@redhat.com> <20230105125248.813825852@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023, Marcelo Tosatti wrote:

> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -381,6 +381,7 @@ void __mod_zone_page_state(struct zone *
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	vmstat_mark_dirty();

__vmstat_mark_dirty()? See earlier patch

>
>  	preempt_enable_nested();
>  }
> @@ -417,6 +418,7 @@ void __mod_node_page_state(struct pglist
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	vmstat_mark_dirty();

Ditto.

>
>  	preempt_enable_nested();
>  }
> @@ -577,6 +579,9 @@ static inline void mod_zone_state(struct
>  	s8 __percpu *p = pcp->vm_stat_diff + item;
>  	long o, n, t, z;
>
> +	/* cmpxchg and vmstat_mark_dirty should happen on the same CPU */
> +	preempt_disable();

If you are disabling preemption then why do we still need cmpxchg?
Same again below.

