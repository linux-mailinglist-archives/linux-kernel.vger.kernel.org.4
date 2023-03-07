Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C26AE0AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCGNg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCGNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:36:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ECD7E89E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA3B61440
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B82DC433EF;
        Tue,  7 Mar 2023 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678196211;
        bh=kVKeC2EhtKsgrAU3QzvKrOOsQ+sn27416WSfb4QStJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDcIIeHLgDvJ2Qam8i1aV+8JWgsuVVXgZb0F6Yz2Sa33GgpyNSVtdDB8HwmYpLY1N
         +ZWXqlXfanaFDjA7xEZNmhBVdjHDRfvkoC8x3n8iadUvbtAhnTgHbXlfX9LojgUfKW
         WO9jmRrEAwpvy0sbYMIoocFnfV2ww7ymrL5uZG9ygHTRM4Qi86+lCZXwahaXA7ktyb
         h9bTo8PSwdJgYPMDF/D5L+f0BFtMQ0G4VbkoFjezjR9uJoAdms8LRQRanUJ0qBJjom
         psaWqHzoSJQ+BNEJkSX2VE7+zwHJykc0Ujy2AslAJkOaiEEvDuCttByrnJeKNmvP98
         tRM4C+ldLj68w==
Date:   Tue, 7 Mar 2023 15:36:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <ZAc96GZXnGugA5ML@kernel.org>
References: <20230306235730.GA31451@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306235730.GA31451@monkey>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> One of our product teams recently experienced 'memory bloat' in their
> environment.  The application in this environment is the JVM which
> creates hundreds of threads.  Threads are ultimately created via
> pthread_create which also creates the thread stacks.  pthread attributes
> are modified so that stacks are 2MB in size.  It just so happens that
> due to allocation patterns, all their stacks are at 2MB boundaries.  The
> system has THP always set, so a huge page is allocated at the first
> (write) fault when libpthread initializes the stack.
> 
> It would seem that this is expected behavior.  If you set THP always,
> you may get huge pages anywhere.
> 
> However, I can't help but think that backing stacks with huge pages by
> default may not be the right thing to do.  Stacks by their very nature
> grow in somewhat unpredictable ways over time.  Using a large virtual
> space so that memory is allocated as needed is the desired behavior.
> 
> The only way to address their 'memory bloat' via thread stacks today is
> by switching THP to madvise.
> 
> Just wondering if there is anything better or more selective that can be
> done?  Does it make sense to have THP backed stacks by default?  If not,
> who would be best at disabling?  A couple thoughts:
> - The kernel could disable huge pages on stacks.  libpthread/glibc pass
>   the unused flag MAP_STACK.  We could key off this and disable huge pages.
>   However, I'm sure there is somebody somewhere today that is getting better
>   performance because they have huge pages backing their stacks.
> - We could push this to glibc/libpthreads and have them use
>   MADV_NOHUGEPAGE on thread stacks.  However, this also has the potential
>   of regressing performance if somebody somewhere is getting better
>   performance due to huge pages.
> - Other thoughts?

Push this to the application? :)

Something like pthread_attr_getstack() + madvice(MADV_NOHUGEPAGE) will do
the job, no?
 
> Perhaps this is just expected behavior of THP always which is unfortunate
> in this situation.
> -- 
> Mike Kravetz
> 

-- 
Sincerely yours,
Mike.
