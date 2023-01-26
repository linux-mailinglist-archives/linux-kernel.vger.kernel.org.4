Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7867D58E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAZTlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjAZTlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:41:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E157F71656
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:41:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DBA5B81E0B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54AEC4339C;
        Thu, 26 Jan 2023 19:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674762066;
        bh=3YjWfRUjo1ft3vovfj8Qj3jVfoFZUWVVSPF5um0H8zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoyKzLiNEea4r35ZvjOAjIE9GUFTldWwpSUnLI7E55mloCSr7TsbGm6/pJQ0+n37j
         Ey3424GqS0m6y6wvsA6a01ivb6oq/gKzpvviM0ASv/lK4h9ClorDIMEtm81rSQ90B8
         d49B4DHagpUBxkO0N84eFsxptnABs+HFtUKDIKeW65vgXmcMMLIxbih7TzgBji6j/z
         DomLaK/PhQavIqoKjaeL9JpDz8oBnF7vdRjLWkhR2ejUFY7MRSF7wS3ks/FcapV5KH
         yn+Dtbj/M2HckZSj5kuumdgcprFLcGYxS1dXf5R2gASVuKyjuHPu7+HIKUYMthXIja
         CVEbdGOSsbMhw==
Date:   Thu, 26 Jan 2023 21:40:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 1/7] kernel/fork: convert vma assignment to a memcpy
Message-ID: <Y9LXOUMTY4hW3+SQ@kernel.org>
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126193752.297968-2-surenb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:37:46AM -0800, Suren Baghdasaryan wrote:
> Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> errors when we add a const modifier to vma->vm_flags.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 441dcec60aae..9260f975b8f4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -472,7 +472,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  		 * orig->shared.rb may be modified concurrently, but the clone
>  		 * will be reinitialized.
>  		 */
> -		*new = data_race(*orig);
> +		data_race(memcpy(new, orig, sizeof(*new)));
>  		INIT_LIST_HEAD(&new->anon_vma_chain);
>  		dup_anon_vma_name(orig, new);
>  	}
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
